//! "noteblock.exe"

use clipboard::{ClipboardContext, ClipboardProvider};
use inputbot::KeybdKey as Key;
use midly::{EventKind, MetaMessage, MidiMessage, Smf, Timing, Event};
use std::{
    env,
    error::Error,
    io::{self, Write},fs,
    path::Path,
    thread,
    time::{Duration, Instant},
    borrow::Cow,
};
use flate2::{write::DeflateEncoder,Compression};
use md5::{Md5, Digest};

const MIDISONG_VERSION: f64 = 1.3;
const MAX_LEN: usize = 512;
const INTERVAL: Duration = Duration::from_millis(80);

struct Context {
    clip: ClipboardContext,
}
impl Context {
    fn paste(&mut self, mut str: &str) {
        while str.len() > 0 {
            let mut up_to = str.len();
            if up_to > MAX_LEN {
                up_to = MAX_LEN;
                while !str.is_char_boundary(up_to) {
                    up_to -= 1;
                }
            }
            let (chunk, rem) = str.split_at(up_to);
            str = rem;
            thread::sleep(INTERVAL * 1 / 4);
            self.clip.set_contents(chunk.to_string()).unwrap();
            Key::LControlKey.press();
            Key::VKey.press();
            thread::sleep(INTERVAL * 3 / 4);
            Key::LControlKey.release();
            Key::VKey.release();
        }
        println!("pasted");
    }
}

struct Out {
    data: Vec<u8>,
}
impl Out {
    fn new() -> Out {
        Out {
            data: Vec::new(),
        }
    }
    
    fn marker(&self) -> usize {
        self.data.len()
    }
    
    fn write_at(&mut self, at: usize, bytes: &[u8]) -> Result<(), Box<Error>> {
        self.data[at..at+bytes.len()].copy_from_slice(bytes);
        Ok(())
    }
    
    fn write(&mut self, bytes: &[u8]) -> Result<(), Box<Error>> {
        self.data.extend_from_slice(bytes);
        Ok(())
    }
    
    fn write_int(&mut self, int: u32) -> Result<(), Box<Error>> {
        self.write(&int.to_le_bytes())
    }
    
    fn write_varlen(&mut self, mut int: u32) -> Result<(), Box<Error>> {
        const BITS: u32 = 7;
        const MASK: u32 = (1<<BITS)-1;
        for _ in 0..4 {
            let piece = (int&0x7F) as u8;
            if int&!MASK == 0 {
                //Last piece
                self.write(&[piece])?;
                break;
            }else{
                //Continue
                self.write(&[piece|0x80])?;
                int>>=BITS;
            }
        }
        Ok(())
    }
    
    fn finish(self) -> Result<String, Box<Error>> {
        //Compress
        let mut flate = DeflateEncoder::new(Vec::new(), Compression::new(5));
        flate.write_all(&self.data)?;
        let raw = flate.finish()?;
        
        //Do base-95 encoding
        let mut string = String::new();
        let rem = (raw.len()%4) as u8;
        string.push((32+rem) as char);
        for chunk in raw.chunks(4) {
            let mut bytes = [0; 4];
            bytes[..chunk.len()].copy_from_slice(chunk);
            let mut chunk = u32::from_le_bytes(bytes);
            //Push 5 ASCII printable characters for the 4 input bytes
            for _ in 0..5 {
                //A byte in the range [32, 126] (both inclusive)
                let piece=(chunk%95) as u8+32;
                chunk/=95;
                string.push(piece as char);
            }
        }
        Ok(string)
    }
}

struct Hand {
    instrument: u8,
    key_sum: f64,
    note_count: f64,
}

struct TrackData {
    hands: [Option<u8>; 128],
    last_time: u32,
}
impl TrackData {
    fn new() -> Self {
        TrackData {
            hands: [None; 128],
            last_time: 0,
        }
    }
}

fn run() -> Result<(), Box<Error>> {
    //Read in input
    let path = env::args_os()
        .nth(1)
        .ok_or("a file must be dragged into the executable")?;
    let path = Path::new(&path);
    if path.extension() != Some("mid".as_ref()) && path.extension() != Some("midi".as_ref()) {
        return Err("this program must be run by drag-and-dropping a midi file onto it".into());
    }
    let file =
        fs::read(&path).map_err(|err| format!("failed to read dragged file: {}", err))?;
    let smf = Smf::<Vec<Event>>::read(&file)
        .map_err(|err| format!("failed to parse midi file: {}", err))?;
    println!("midi parsed: {} tracks", smf.tracks.len());
    
    //Serialize midi into here
    let mut out = Out::new();
    
    //Write MD5 hash
    {
        let md5: [u8; 16] = Md5::digest(&file).into();
        out.write(&md5)?;
    }
    
    //Write song name
    let name = path
        .file_stem()
        .map(|name| name.to_string_lossy())
        .unwrap_or(Cow::Borrowed(""))
        .chars()
        .map(|ch| if ch<32 as char || ch>126 as char {
            ' '
        }else{
            ch
        }).collect::<String>();
    out.write_int(name.len() as u32)?;
    out.write(name.as_bytes())?;
    
    //Write global timing info
    let ticksperbeat = match smf.header.timing {
        Timing::Metrical(tpb) => tpb.as_int(),
        _ => return Err("unsupported midi format".into()),
    };
    out.write_int(ticksperbeat as u32)?;
    
    //Make space for hand data
    let hand_data_marker = out.marker();
    out.write(&[0xFF; 513])?;
    
    //Write NoteOn events
    let mut abs_last_time = 0;
    let mut mark_time = |new_time| {
        let delta = new_time - abs_last_time;
        abs_last_time = new_time;
        delta
    };
    let mut hands = Vec::new();
    let mut total_avg = (0.0, 0.0);
    let mut tracks = smf
        .tracks
        .into_iter()
        .map(|track| (TrackData::new(), track.into_iter().peekable()))
        .collect::<Vec<_>>();
    let mut channel_instruments = [0_u8; 16];
    loop {
        //Find the next event
        let mut min = None;
        for (i, (track_data, track)) in tracks.iter_mut().enumerate() {
            if let Some(ev) = track.peek() {
                let time = track_data.last_time + ev.delta.as_int();
                if match min {
                    None => true,
                    Some((_, min_time)) => time < min_time,
                } {
                    min = Some((i, time));
                }
            }
        }
        //Consume this event
        if let Some((i, time)) = min {
            let (track_data, track) = &mut tracks[i];
            let ev = track.next().unwrap();
            track_data.last_time = time;
            //Serialize this event
            match ev.kind {
                EventKind::Midi { channel, message } => {
                    let chan = channel.as_int();
                    let instrument = &mut channel_instruments[chan as usize];
                    match message {
                        MidiMessage::NoteOn{key, vel} => {
                            //Only care if velocity is nonzero
                            let (key,vel) = (key.as_int(), vel.as_int());
                            if vel>0 {
                                //Write down a noteon event
                                let mut write = |hand, key, vel| -> Result<(), Box<Error>> {
                                    out.write(&[vel&0x7F, key, hand])?;
                                    out.write_varlen(mark_time(time))?;
                                    Ok(())
                                };
                                if chan==9 {
                                    //Percussion
                                    write(0, 0x80 | key, vel)?;
                                }else{
                                    //Melody
                                    //Reuse or create a hand for this track/instrument combination
                                    let hand_idx = match &mut track_data.hands[*instrument as usize] {
                                        Some(hand) => *hand,
                                        hand_slot@ None => {
                                            if hands.len()>u8::max_value() as usize {
                                                return Err("song is too complex".into());
                                            }
                                            let hand_idx = hands.len() as u8;
                                            hands.push(Hand {
                                                instrument: *instrument,
                                                key_sum: 0.0,
                                                note_count: 0.0,
                                            });
                                            *hand_slot = Some(hand_idx);
                                            hand_idx
                                        },
                                    };
                                    write(hand_idx, key, vel)?;
                                    let hand = &mut hands[hand_idx as usize];
                                    hand.key_sum+=key as f64;
                                    hand.note_count+=1.0;
                                    total_avg.0+=key as f64;
                                    total_avg.1+=1.0;
                                }
                            }
                        }
                        MidiMessage::ProgramChange{program} => {
                            //Change instrument
                            *instrument = program.as_int();
                        }
                        _ => (),
                    }
                }
                EventKind::Meta(meta) => match meta {
                    MetaMessage::Tempo(microsperbeat) => {
                        //Tempo change
                        out.write(&[0x80])?;
                        out.write_int(microsperbeat.as_int())?;
                    }
                    _ => (),
                },
                _ => (),
            }
        } else {
            //No more events
            break;
        }
    }
    
    //Overwrite the zeros that were written at the start with hand data
    let get_avg = |sum: f64, count: f64| if count==0.0 {0xFF} else {(sum/count).round() as u8};
    for (i, hand) in hands.iter().enumerate() {
        out.write_at(hand_data_marker+i*2, &[hand.instrument, get_avg(hand.key_sum, hand.note_count)])?;
    }
    out.write_at(hand_data_marker+512, &[get_avg(total_avg.0, total_avg.1)])?;
    
    //Compress and encode into a clipboard-safe string
    let mut out = out.finish()?;
    
    //Insert header
    let prev_len = out.len();
    out.insert_str(0, &format!("midisong:{}:{}:", MIDISONG_VERSION, prev_len));
    println!("{}-hand midi serialized into {}KB", hands.len(), ((out.len() as f64)/1024.0*10.0).ceil()/10.0);
    println!(
        "expected upload time: {}s",
        ((((out.len() / MAX_LEN) as u32 * INTERVAL).as_millis() as f64)/100.0).ceil()/10.0
    );
    
    //Paste when requested
    println!("press F4 to paste song data");
    let mut ctx = Context {
        clip: ClipboardContext::new().unwrap(),
    };
    let mut pressed = false;
    let mut press_time = Instant::now();
    loop {
        let old_pressed = pressed;
        pressed = Key::F4Key.is_pressed();
        if pressed && !old_pressed {
            press_time = Instant::now();
        } else if !pressed && old_pressed {
            let now = Instant::now();
            ctx.paste(&out);
            if now - press_time <= Duration::from_millis(400) {
                break;
            }
        }
        thread::sleep(Duration::from_millis(50));
    }
    println!("goodbye");
    thread::sleep(Duration::from_secs(1));
    Ok(())
}

fn main() {
    if let Err(err) = run() {
        eprintln!("error: {}", err);
        let _ = io::stdin().read_line(&mut String::new());
    }
}
