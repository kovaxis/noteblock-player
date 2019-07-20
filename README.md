# Minecraft noteblock player

An executable/script pair that allows playing arbitrary midi files in
Minecraft 1.7.10.

The native executable "noteblock.exe" parses midi files and sends them over to
a ComputerCraft script by pasting text quickly into the in-game terminal.

The companion "noteblock.lua" receives this text and plays the notes on a
noteblock (made for and tested in ComputerCraft 1.79 with OpenPeripherals, for
Minecraft 1.7.10).

(Note that even though the name "noteblock.exe" suggests a Windows-only
executable, the `.exe` suffix is used only to indicate that it is a native
binary. The Rust program can be compiled to whatever platforms its dependencies
support. Currently the bottleneck is `inputbot`, which only claims to support
Windows and Linux. Prebuilt binaries are only provided for Windows, though.)
