
--- INSTRUMENT MAPPINGS ---

local piano = {'note.harp', 66}
local bass = {'note.bass', 54}
local steeldrums = {'note.pling', 66}
local drum = 'note.bd'
local stick = 'note.hat'
local snare = 'note.snare'

local melodic = {
    [piano] = {0,7, 16,23, 72,103},
    [steeldrums] = {8,15, 104,127},
    [bass] = {24,71},
}
local percussive = {
    0,27,
    snare,1,
    29,30,
    stick,1,
    stick,1.4,
    stick,1,
    34,34,
    drum,0.5,
    drum,0.7,
    stick,1,
    snare,1,
    snare,1.3,
    snare,0.9,
    drum,0.5,
    stick,1.2,
    drum,0.75,
    stick,1.2,
    drum,0.9,
    snare,0.8,
    drum,1.1,
    
    drum,1.5,
    snare,1.4,
    drum,2,
    snare,1,
    snare,2,
    stick,2,
    stick,1,
    snare,2,
    snare,0.5,
    snare,1.7,
    drum,1.5,
    snare,1.4,
    
    drum,0.75,
    drum,0.5,
    drum,1.5,
    drum,2,
    drum,1,
    
    drum,2,
    drum,1.8,
    stick,2,
    stick,1.8,
    
    stick,1,
    stick,1,
    drum,2,
    drum,2,
    stick,1,
    stick,1,
    stick,1.4,
    snare,2,
    snare,1.5,
    stick,1.2,
    stick,1,
    drum,2,
    drum,1.8,
    82,127,
}

--Where to save song info
local savedir = "songdata"

--Embedded LibDeflate library (https://github.com/SafeteeWoW/LibDeflate)
local deflate = (function()
    -- LibDeflate 1.0.0-release <br>
    -- Pure Lua compressor and decompressor with high compression ratio using
    -- DEFLATE/zlib format.
    -- @file LibDeflate.lua
    -- @author Haoqian He (Github: SafeteeWoW; World of Warcraft: Safetyy-Illidan(US))
    -- @copyright LibDeflate <2018> Haoqian He
    -- @license GNU General Public License Version 3 or later
    --
    -- This program is free software: you can redistribute it and/or modify
    -- it under the terms of the GNU General Public License as published by
    -- the Free Software Foundation, either version 3 of the License, or
    -- any later version.
    -- This program is distributed in the hope that it will be useful,
    -- but WITHOUT ANY WARRANTY; without even the implied warranty of
    -- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    -- GNU General Public License for more details.
    -- You should have received a copy of the GNU General Public License
    -- along with this program.  If not, see https://www.gnu.org/licenses/.
    local a;do local b="1.0.0-release"local c="LibDeflate "..b.." Copyright (C) 2018 Haoqian He.".." License GPLv3+: GNU GPL version 3 or later"if LibStub then local d,e="LibDeflate",-1;
    local f,g=LibStub:GetLibrary(d,true)if f and g and g>=e then return f else a=LibStub:NewLibrary(d,b)end else a={}end;a._VERSION=b;a._COPYRIGHT=c end;local assert=assert;local error=error;local pairs=pairs;local h=string.byte;local i=string.char;local j=string.find;local k=string.gsub;local l=string.sub;local m=table.concat;local n=table.sort;local tostring=tostring;local type=type;local o={}local p={}local q={}local r={}local s={}local t={}local u={}local v={}local w={}local x={3,4,5,6,7,8,9,10,11,13,15,17,19,23,27,31,35,43,51,59,67,83,99,115,131,163,195,227,258}local y={0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,0}local z={[0]=1,2,3,4,5,7,9,13,17,25,33,49,65,97,129,193,257,385,513,769,1025,1537,2049,3073,4097,6145,8193,12289,16385,24577}local A={[0]=0,0,0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13}local B={16,17,18,0,8,7,9,6,10,5,11,4,12,3,13,2,14,1,15}local C;local D;local E;local F;local G;local H;local I;local J;for K=0,255 do p[K]=i(K)end;do local L=1;for K=0,32 do o[K]=L;L=L*2 end end;for K=1,9 do q[K]={}for M=0,o[K+1]-1 do local N=0;local O=M;for P=1,K do N=N-N%2+((N%2==1 or O%2==1)and 1 or 0)O=(O-O%2)/2;N=N*2 end;q[K][M]=(N-N%2)/2 end end;do local Q=18;local R=16;local S=265;local T=1;for U=3,258 do if U<=10 then r[U]=U+254;t[U]=0 elseif U==258 then r[U]=285;t[U]=0 else if U>Q then Q=Q+R;R=R*2;S=S+4;T=T+1 end;local V=U-Q-1+R/2;r[U]=(V-V%(R/8))/(R/8)+S;t[U]=T;s[U]=V%(R/8)end end end;do u[1]=0;u[2]=1;w[1]=0;w[2]=0;local Q=3;local R=4;local W=2;local T=0;for X=3,256 do if X>R then Q=Q*2;R=R*2;W=W+2;T=T+1 end;u[X]=X<=Q and W or W+1;w[X]=T<0 and 0 or T;if R>=8 then v[X]=(X-R/2-1)%(R/4)end end end;function a:Adler32(Y)if type(Y)~="string"then error(("Usage: LibDeflate:Adler32(str):".." 'str' - string expected got '%s'."):format(type(Y)),2)end;local Z=#Y;local K=1;local Q=1;local R=0;while K<=Z-15 do local _,a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,aa,ab,ac,ad,ae=h(Y,K,K+15)R=(R+16*Q+16*_+15*a0+14*a1+13*a2+12*a3+11*a4+10*a5+9*a6+8*a7+7*a8+6*a9+5*aa+4*ab+3*ac+2*ad+ae)%65521;Q=(Q+_+a0+a1+a2+a3+a4+a5+a6+a7+a8+a9+aa+ab+ac+ad+ae)%65521;K=K+16 end;while K<=Z do local af=h(Y,K,K)Q=(Q+af)%65521;R=(R+Q)%65521;K=K+1 end;return(R*65536+Q)%4294967296 end;local function ag(ah,ai)return ah%4294967296==ai%4294967296 end;function a:CreateDictionary(Y,Z,aj)if type(Y)~="string"then error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32):".." 'str' - string expected got '%s'."):format(type(Y)),2)end;if type(Z)~="number"then error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32):".." 'strlen' - number expected got '%s'."):format(type(Z)),2)end;if type(aj)~="number"then error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32):".." 'adler32' - number expected got '%s'."):format(type(aj)),2)end;if Z~=#Y then error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32):".." 'strlen' does not match the actual length of 'str'.".." 'strlen': %u, '#str': %u .".." Please check if 'str' is modified unintentionally."):format(Z,#Y))end;if Z==0 then error("Usage: LibDeflate:CreateDictionary(str, strlen, adler32):".." 'str' - Empty string is not allowed.",2)end;if Z>32768 then error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32):".." 'str' - string longer than 32768 bytes is not allowed.".." Got %d bytes."):format(Z),2)end;local ak=self:Adler32(Y)if not ag(aj,ak)then error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32):".." 'adler32' does not match the actual adler32 of 'str'.".." 'adler32': %u, 'Adler32(str)': %u .".." Please check if 'str' is modified unintentionally."):format(aj,ak))end;local al={}al.adler32=aj;al.hash_tables={}al.string_table={}al.strlen=Z;local am=al.string_table;local an=al.hash_tables;am[1]=h(Y,1,1)am[2]=h(Y,2,2)if Z>=3 then local K=1;local ao=am[1]*256+am[2]while K<=Z-2-3 do local _,a0,a1,a2=h(Y,K+2,K+5)am[K+2]=_;am[K+3]=a0;am[K+4]=a1;am[K+5]=a2;ao=(ao*256+_)%16777216;local V=an[ao]if not V then V={}an[ao]=V end;V[#V+1]=K-Z;K=K+1;ao=(ao*256+a0)%16777216;V=an[ao]if not V then V={}an[ao]=V end;V[#V+1]=K-Z;K=K+1;ao=(ao*256+a1)%16777216;V=an[ao]if not V then V={}an[ao]=V end;V[#V+1]=K-Z;K=K+1;ao=(ao*256+a2)%16777216;V=an[ao]if not V then V={}an[ao]=V end;V[#V+1]=K-Z;K=K+1 end;while K<=Z-2 do local af=h(Y,K+2)am[K+2]=af;ao=(ao*256+af)%16777216;local V=an[ao]if not V then V={}an[ao]=V end;V[#V+1]=K-Z;K=K+1 end end;return al end;local function ap(al)if type(al)~="table"then return false,("'dictionary' - table expected got '%s'."):format(type(al))end;if type(al.adler32)~="number"or type(al.string_table)~="table"or type(al.strlen)~="number"or al.strlen<=0 or al.strlen>32768 or al.strlen~=#al.string_table or type(al.hash_tables)~="table"then return false,("'dictionary' - corrupted dictionary."):format(type(al))end;return true,""end;local aq={[0]={false,nil,0,0,0},[1]={false,nil,4,8,4},[2]={false,nil,5,18,8},[3]={false,nil,6,32,32},[4]={true,4,4,16,16},[5]={true,8,16,32,32},[6]={true,8,16,128,128},[7]={true,8,32,128,256},[8]={true,32,128,258,1024},[9]={true,32,258,258,4096}}local function ar(Y,as,al,at,au)if type(Y)~="string"then return false,("'str' - string expected got '%s'."):format(type(Y))end;if as then local av,aw=ap(al)if not av then return false,aw end end;if at then local ax=type(au)if ax~="nil"and ax~="table"then return false,("'configs' - nil or table expected got '%s'."):format(type(au))end;if ax=="table"then for ay,az in pairs(au)do if ay~="level"and ay~="strategy"then return false,("'configs' - unsupported table key in the configs: '%s'."):format(ay)elseif ay=="level"and not aq[az]then return false,("'configs' - unsupported 'level': %s."):format(tostring(az))elseif ay=="strategy"and az~="fixed"and az~="huffman_only"and az~="dynamic"then return false,("'configs' - unsupported 'strategy': '%s'."):format(tostring(az))end end end end;return true,""end;local aA=0;local aB=1;local aC=2;local aD=3;local function aE()local aF=0;local aG=0;local aH=0;local aI=0;local aJ={}local aK={}local function aL(O,T)aG=aG+O*o[aH]aH=aH+T;aI=aI+T;if aH>=32 then aF=aF+1;aJ[aF]=p[aG%256]..p[(aG-aG%256)/256%256]..p[(aG-aG%65536)/65536%256]..p[(aG-aG%16777216)/16777216%256]local aM=o[32-aH+T]aG=(O-O%aM)/aM;aH=aH-32 end end;local function aN(Y)for P=1,aH,8 do aF=aF+1;aJ[aF]=i(aG%256)aG=(aG-aG%256)/256 end;aH=0;aF=aF+1;aJ[aF]=Y;aI=aI+#Y*8 end;local function aO(aP)if aP==aD then return aI end;if aP==aB or aP==aC then local aQ=(8-aH%8)%8;if aH>0 then aG=aG-o[aH]+o[aH+aQ]for P=1,aH,8 do aF=aF+1;aJ[aF]=p[aG%256]aG=(aG-aG%256)/256 end;aG=0;aH=0 end;if aP==aC then aI=aI+aQ;return aI end end;local aR=m(aJ)aJ={}aF=0;aK[#aK+1]=aR;if aP==aA then return aI else return aI,m(aK)end end;return aL,aN,aO end;local function aS(aT,aU,aV)aV=aV+1;aT[aV]=aU;local O=aU[1]local aW=aV;local aX=(aW-aW%2)/2;while aX>=1 and aT[aX][1]>O do local V=aT[aX]aT[aX]=aU;aT[aW]=V;aW=aX;aX=(aX-aX%2)/2 end end;local function aY(aT,aV)local aZ=aT[1]local aU=aT[aV]local O=aU[1]aT[1]=aU;aT[aV]=aZ;aV=aV-1;local aW=1;local a_=aW*2;local b0=a_+1;while a_<=aV do local b1=aT[a_]if b0<=aV and aT[b0][1]<b1[1]then local b2=aT[b0]if b2[1]<O then aT[b0]=aU;aT[aW]=b2;aW=b0;a_=aW*2;b0=a_+1 else break end else if b1[1]<O then aT[a_]=aU;aT[aW]=b1;aW=a_;a_=aW*2;b0=a_+1 else break end end end;return aZ end;local function b3(b4,b5,b6,b7)local b8=0;local b9={}local ba={}for T=1,b7 do b8=(b8+(b4[T-1]or 0))*2;b9[T]=b8 end;for bb=0,b6 do local T=b5[bb]if T then b8=b9[T]b9[T]=b8+1;if T<=9 then ba[bb]=q[T][b8]else local N=0;for P=1,T do N=N-N%2+((N%2==1 or b8%2==1)and 1 or 0)b8=(b8-b8%2)/2;N=N*2 end;ba[bb]=(N-N%2)/2 end end end;return ba end;local function bc(Q,R)return Q[1]<R[1]or Q[1]==R[1]and Q[2]<R[2]end;local function bd(be,b7,b6)local aV;local bf=-1;local bg={}local aT={}local b5={}local bh={}local b4={}local bi=0;for bb,bj in pairs(be)do bi=bi+1;bg[bi]={bj,bb}end;if bi==0 then return{},{},-1 elseif bi==1 then local bb=bg[1][2]b5[bb]=1;bh[bb]=0;return b5,bh,bb else n(bg,bc)aV=bi;for K=1,aV do aT[K]=bg[K]end;while aV>1 do local bk=aY(aT,aV)aV=aV-1;local bl=aY(aT,aV)aV=aV-1;local bm={bk[1]+bl[1],-1,bk,bl}aS(aT,bm,aV)aV=aV+1 end;local bn=0;local bo={aT[1],0,0,0}local bp=1;local bq=1;aT[1][1]=0;while bq<=bp do local aU=bo[bq]local T=aU[1]local bb=aU[2]local b1=aU[3]local b2=aU[4]if b1 then bp=bp+1;bo[bp]=b1;b1[1]=T+1 end;if b2 then bp=bp+1;bo[bp]=b2;b2[1]=T+1 end;bq=bq+1;if T>b7 then bn=bn+1;T=b7 end;if bb>=0 then b5[bb]=T;bf=bb>bf and bb or bf;b4[T]=(b4[T]or 0)+1 end end;if bn>0 then repeat local T=b7-1;while(b4[T]or 0)==0 do T=T-1 end;b4[T]=b4[T]-1;b4[T+1]=(b4[T+1]or 0)+2;b4[b7]=b4[b7]-1;bn=bn-2 until bn<=0;bq=1;for T=b7,1,-1 do local br=b4[T]or 0;while br>0 do local bb=bg[bq][2]b5[bb]=T;br=br-1;bq=bq+1 end end end;bh=b3(b4,b5,b6,b7)return b5,bh,bf end end;local function bs(bt,bu,bv,bw)local bx=0;local by={}local bz={}local bA=0;local bB={}local bC=nil;local bj=0;bw=bw<0 and 0 or bw;local bD=bu+bw+1;for W=0,bD+1 do local U=W<=bu and(bt[W]or 0)or(W<=bD and(bv[W-bu-1]or 0)or nil)if U==bC then bj=bj+1;if U~=0 and bj==6 then bx=bx+1;by[bx]=16;bA=bA+1;bB[bA]=3;bz[16]=(bz[16]or 0)+1;bj=0 elseif U==0 and bj==138 then bx=bx+1;by[bx]=18;bA=bA+1;bB[bA]=127;bz[18]=(bz[18]or 0)+1;bj=0 end else if bj==1 then bx=bx+1;by[bx]=bC;bz[bC]=(bz[bC]or 0)+1 elseif bj==2 then bx=bx+1;by[bx]=bC;bx=bx+1;by[bx]=bC;bz[bC]=(bz[bC]or 0)+2 elseif bj>=3 then bx=bx+1;local bE=bC~=0 and 16 or(bj<=10 and 17 or 18)by[bx]=bE;bz[bE]=(bz[bE]or 0)+1;bA=bA+1;bB[bA]=bj<=10 and bj-3 or bj-11 end;bC=U;if U and U~=0 then bx=bx+1;by[bx]=U;bz[U]=(bz[U]or 0)+1;bj=0 else bj=1 end end end;return by,bB,bz end;local function bF(Y,V,bG,bH,bI)local K=bG-bI;while K<=bH-15-bI do V[K],V[K+1],V[K+2],V[K+3],V[K+4],V[K+5],V[K+6],V[K+7],V[K+8],V[K+9],V[K+10],V[K+11],V[K+12],V[K+13],V[K+14],V[K+15]=h(Y,K+bI,K+15+bI)K=K+16 end;while K<=bH-bI do V[K]=h(Y,K+bI,K+bI)K=K+1 end;return V end;local function bJ(bK,am,an,bL,bM,bI,al)local bN=aq[bK]local bO,bP,bQ,bR,bS=bN[1],bN[2],bN[3],bN[4],bN[5]local bT=not bO and bQ or 2147483646;local bU=bS-bS%4/4;local ao;local bV;local bW;local bX=0;if al then bV=al.hash_tables;bW=al.string_table;bX=al.strlen;assert(bL==1)if bM>=bL and bX>=2 then ao=bW[bX-1]*65536+bW[bX]*256+am[1]local V=an[ao]if not V then V={}an[ao]=V end;V[#V+1]=-1 end;if bM>=bL+1 and bX>=1 then ao=bW[bX]*65536+am[1]*256+am[2]local V=an[ao]if not V then V={}an[ao]=V end;V[#V+1]=0 end end;ao=(am[bL-bI]or 0)*256+(am[bL+1-bI]or 0)local bY={}local bZ=0;local b_={}local c0={}local c1=0;local c2={}local c3={}local c4=0;local c5={}local c6=0;local c7=false;local c8;local c9;local ca=0;local cb=0;local bq=bL;local cc=bM+(bO and 1 or 0)while bq<=cc do local cd=bq-bI;c8=ca;c9=cb;ca=0;ao=(ao*256+(am[cd+2]or 0))%16777216;local ce;local cf;local cg=an[ao]local ch;if not cg then ch=0;cg={}an[ao]=cg;if bV then cf=bV[ao]ce=cf and#cf or 0 else ce=0 end else ch=#cg;cf=cg;ce=ch end;if bq<=bM then cg[ch+1]=bq end;if ce>0 and bq+2<=bM and(not bO or c8<bQ)then local ci=bO and c8>=bP and bU or bS;while ce>=1 and ci>0 do local bC=cf[ce]if bq-bC>32768 then break end;if bC<bq then local M=3;if bC>=-257 then local cj=bC-bI;while M<258 and bq+M<=bM do if am[cj+M]==am[cd+M]then M=M+1 else break end end else local cj=bX+bC;while M<258 and bq+M<=bM do if bW[cj+M]==am[cd+M]then M=M+1 else break end end end;if M>ca then ca=M;cb=bq-bC end;if ca>=bR then break end end;ce=ce-1;ci=ci-1;if ce==0 and bC>0 and bV then cf=bV[ao]ce=cf and#cf or 0 end end end;if not bO then c8,c9=ca,cb end;if(not bO or c7)and(c8>3 or c8==3 and c9<4096)and ca<=c8 then local W=r[c8]local ck=t[c8]local cl,cm,cn;if c9<=256 then cl=u[c9]cn=v[c9]cm=w[c9]else cl=16;cm=7;local Q=384;local R=512;while true do if c9<=Q then cn=(c9-R/2-1)%(R/4)break elseif c9<=R then cn=(c9-R/2-1)%(R/4)cl=cl+1;break else cl=cl+2;cm=cm+1;Q=Q*2;R=R*2 end end end;bZ=bZ+1;bY[bZ]=W;b_[W]=(b_[W]or 0)+1;c1=c1+1;c0[c1]=cl;c2[cl]=(c2[cl]or 0)+1;if ck>0 then local co=s[c8]c4=c4+1;c3[c4]=co end;if cm>0 then c6=c6+1;c5[c6]=cn end;for K=bq+1,bq+c8-(bO and 2 or 1)do ao=(ao*256+(am[K-bI+2]or 0))%16777216;if c8<=bT then cg=an[ao]if not cg then cg={}an[ao]=cg end;cg[#cg+1]=K end end;bq=bq+c8-(bO and 1 or 0)c7=false elseif not bO or c7 then local W=am[bO and cd-1 or cd]bZ=bZ+1;bY[bZ]=W;b_[W]=(b_[W]or 0)+1;bq=bq+1 else c7=true;bq=bq+1 end end;bZ=bZ+1;bY[bZ]=256;b_[256]=(b_[256]or 0)+1;return bY,c3,b_,c0,c5,c2 end;local function cp(b_,c2)local cq,cr,bu=bd(b_,15,285)local cs,ct,bw=bd(c2,15,29)local cu,bB,cv=bs(cq,bu,cs,bw)local cw,cx=bd(cv,7,18)local cy=0;for K=1,19 do local bb=B[K]local cz=cw[bb]or 0;if cz~=0 then cy=K end end;cy=cy-4;local cA=bu+1-257;local cB=bw+1-1;if cB<0 then cB=0 end;return cA,cB,cy,cw,cx,cu,bB,cq,cr,cs,ct end;local function cC(bY,c0,cy,cw,cu,cq,cs)local cD=17;cD=cD+(cy+4)*3;for K=1,#cu do local W=cu[K]cD=cD+cw[W]if W>=16 then cD=cD+(W==16 and 2 or(W==17 and 3 or 7))end end;local cE=0;for K=1,#bY do local W=bY[K]local cF=cq[W]cD=cD+cF;if W>256 then cE=cE+1;if W>264 and W<285 then local cG=y[W-256]cD=cD+cG end;local cl=c0[cE]local cH=cs[cl]cD=cD+cH;if cl>3 then local cm=(cl-cl%2)/2-1;cD=cD+cm end end end;return cD end;local function cI(aL,cJ,bY,c3,c0,c5,cA,cB,cy,cw,cx,cu,bB,cq,cr,cs,ct)aL(cJ and 1 or 0,1)aL(2,2)aL(cA,5)aL(cB,5)aL(cy,4)for K=1,cy+4 do local bb=B[K]local cz=cw[bb]or 0;aL(cz,3)end;local cK=1;for K=1,#cu do local W=cu[K]aL(cx[W],cw[W])if W>=16 then local cL=bB[cK]aL(cL,W==16 and 2 or(W==17 and 3 or 7))cK=cK+1 end end;local cE=0;local cM=0;local cN=0;for K=1,#bY do local cO=bY[K]local b8=cr[cO]local cF=cq[cO]aL(b8,cF)if cO>256 then cE=cE+1;if cO>264 and cO<285 then cM=cM+1;local cP=c3[cM]local cG=y[cO-256]aL(cP,cG)end;local cQ=c0[cE]local cR=ct[cQ]local cH=cs[cQ]aL(cR,cH)if cQ>3 then cN=cN+1;local cn=c5[cN]local cm=(cQ-cQ%2)/2-1;aL(cn,cm)end end end end;local function cS(bY,c0)local cD=3;local cE=0;for K=1,#bY do local W=bY[K]local cF=E[W]cD=cD+cF;if W>256 then cE=cE+1;if W>264 and W<285 then local cG=y[W-256]cD=cD+cG end;local cl=c0[cE]cD=cD+5;if cl>3 then local cm=(cl-cl%2)/2-1;cD=cD+cm end end end;return cD end;local function cT(aL,cJ,bY,c3,c0,c5)aL(cJ and 1 or 0,1)aL(1,2)local cE=0;local cM=0;local cN=0;for K=1,#bY do local cU=bY[K]local b8=C[cU]local cF=E[cU]aL(b8,cF)if cU>256 then cE=cE+1;if cU>264 and cU<285 then cM=cM+1;local cP=c3[cM]local cG=y[cU-256]aL(cP,cG)end;local cl=c0[cE]local cR=G[cl]aL(cR,5)if cl>3 then cN=cN+1;local cn=c5[cN]local cm=(cl-cl%2)/2-1;aL(cn,cm)end end end end;local function cV(bL,bM,aI)assert(bM-bL+1<=65535)local cD=3;aI=aI+3;local aQ=(8-aI%8)%8;cD=cD+aQ;cD=cD+32;cD=cD+(bM-bL+1)*8;return cD end;local function cW(aL,aN,cJ,Y,bL,bM,aI)assert(bM-bL+1<=65535)aL(cJ and 1 or 0,1)aL(0,2)aI=aI+3;local aQ=(8-aI%8)%8;if aQ>0 then aL(o[aQ]-1,aQ)end;local cX=bM-bL+1;aL(cX,16)local cY=255-cX%256+(255-(cX-cX%256)/256)*256;aL(cY,16)aN(Y:sub(bL,bM))end;local function cZ(au,aL,aN,aO,Y,al)local am={}local an={}local cJ=nil;local bL;local bM;local c_;local aI=aO(aD)local Z=#Y;local bI;local bK;local d0;if au then if au.level then bK=au.level end;if au.strategy then d0=au.strategy end end;if not bK then if Z<2048 then bK=7 elseif Z>65536 then bK=3 else bK=5 end end;while not cJ do if not bL then bL=1;bM=64*1024-1;bI=0 else bL=bM+1;bM=bM+32*1024;bI=bL-32*1024-1 end;if bM>=Z then bM=Z;cJ=true else cJ=false end;local bY,c3,b_,c0,c5,c2;local cA,cB,cy,cw,cx,cu,bB,cq,cr,cs,ct;local d1;local d2;local d3;if bK~=0 then bF(Y,am,bL,bM+3,bI)if bL==1 and al then local bW=al.string_table;local d4=al.strlen;for K=0,-d4+1<-257 and-257 or-d4+1,-1 do am[K]=bW[d4+K]end end;if d0=="huffman_only"then bY={}bF(Y,bY,bL,bM,bL-1)c3={}b_={}bY[bM-bL+2]=256;for K=1,bM-bL+2 do local W=bY[K]b_[W]=(b_[W]or 0)+1 end;c0={}c5={}c2={}else bY,c3,b_,c0,c5,c2=bJ(bK,am,an,bL,bM,bI,al)end;cA,cB,cy,cw,cx,cu,bB,cq,cr,cs,ct=cp(b_,c2)d1=cC(bY,c0,cy,cw,cu,cq,cs)d2=cS(bY,c0)end;d3=cV(bL,bM,aI)local d5=d3;d5=d2 and d2<d5 and d2 or d5;d5=d1 and d1<d5 and d1 or d5;if bK==0 or d0~="fixed"and d0~="dynamic"and d3==d5 then cW(aL,aN,cJ,Y,bL,bM,aI)aI=aI+d3 elseif d0~="dynamic"and(d0=="fixed"or d2==d5)then cT(aL,cJ,bY,c3,c0,c5)aI=aI+d2 elseif d0=="dynamic"or d1==d5 then cI(aL,cJ,bY,c3,c0,c5,cA,cB,cy,cw,cx,cu,bB,cq,cr,cs,ct)aI=aI+d1 end;if cJ then c_=aO(aD)else c_=aO(aA)end;assert(c_==aI)if not cJ then local M;if al and bL==1 then M=0;while am[M]do am[M]=nil;M=M-1 end end;al=nil;M=1;for K=bM-32767,bM do am[M]=am[K-bI]M=M+1 end;for ay,V in pairs(an)do local d6=#V;if d6>0 and bM+1-V[1]>32768 then if d6==1 then an[ay]=nil else local d7={}local d8=0;for K=2,d6 do M=V[K]if bM+1-M<=32768 then d8=d8+1;d7[d8]=M end end;an[ay]=d7 end end end end end end;local function d9(Y,al,au)local aL,aN,aO=aE()cZ(au,aL,aN,aO,Y,al)local aI,da=aO(aB)local aQ=(8-aI%8)%8;return da,aQ end;local function db(Y,al,au)local aL,aN,aO=aE()local dc=8;local dd=7;local de=dd*16+dc;aL(de,8)local df=al and 1 or 0;local dg=2;local dh=dg*64+df*32;local di=31-(de*256+dh)%31;dh=dh+di;aL(dh,8)if df==1 then local aj=al.adler32;local dj=aj%256;aj=(aj-dj)/256;local dk=aj%256;aj=(aj-dk)/256;local dl=aj%256;aj=(aj-dl)/256;local dm=aj%256;aL(dm,8)aL(dl,8)aL(dk,8)aL(dj,8)end;cZ(au,aL,aN,aO,Y,al)aO(aC)local aj=a:Adler32(Y)local dm=aj%256;aj=(aj-dm)/256;local dl=aj%256;aj=(aj-dl)/256;local dk=aj%256;aj=(aj-dk)/256;local dj=aj%256;aL(dj,8)aL(dk,8)aL(dl,8)aL(dm,8)local aI,da=aO(aB)local aQ=(8-aI%8)%8;return da,aQ end;function a:CompressDeflate(Y,au)local dn,dp=ar(Y,false,nil,true,au)if not dn then error("Usage: LibDeflate:CompressDeflate(str, configs): "..dp,2)end;return d9(Y,nil,au)end;function a:CompressDeflateWithDict(Y,al,au)local dn,dp=ar(Y,true,al,true,au)if not dn then error("Usage: LibDeflate:CompressDeflateWithDict".."(str, dictionary, configs): "..dp,2)end;return d9(Y,al,au)end;function a:CompressZlib(Y,au)local dn,dp=ar(Y,false,nil,true,au)if not dn then error("Usage: LibDeflate:CompressZlib(str, configs): "..dp,2)end;return db(Y,nil,au)end;function a:CompressZlibWithDict(Y,al,au)local dn,dp=ar(Y,true,al,true,au)if not dn then error("Usage: LibDeflate:CompressZlibWithDict".."(str, dictionary, configs): "..dp,2)end;return db(Y,al,au)end;local function dq(dr)local ds=dr;local dt=#dr;local du=1;local aH=0;local aG=0;local function dv(T)local aM=o[T]local W;if T<=aH then W=aG%aM;aG=(aG-W)/aM;aH=aH-T else local dw=o[aH]local dk,dl,dm,dx=h(ds,du,du+3)aG=aG+((dk or 0)+(dl or 0)*256+(dm or 0)*65536+(dx or 0)*16777216)*dw;du=du+4;aH=aH+32-T;W=aG%aM;aG=(aG-W)/aM end;return W end;local function dy(dz,aJ,aF)assert(aH%8==0)local dA=aH/8<dz and aH/8 or dz;for P=1,dA do local dB=aG%256;aF=aF+1;aJ[aF]=i(dB)aG=(aG-dB)/256 end;aH=aH-dA*8;dz=dz-dA;if(dt-du-dz+1)*8+aH<0 then return-1 end;for K=du,du+dz-1 do aF=aF+1;aJ[aF]=l(ds,K,K)end;du=du+dz;return aF end;local function dC(dD,dE,d5)local W=0;local dF=0;local bq=0;local bj;if d5>0 then if aH<15 and ds then local dw=o[aH]local dk,dl,dm,dx=h(ds,du,du+3)aG=aG+((dk or 0)+(dl or 0)*256+(dm or 0)*65536+(dx or 0)*16777216)*dw;du=du+4;aH=aH+32 end;local aM=o[d5]aH=aH-d5;W=aG%aM;aG=(aG-W)/aM;W=q[d5][W]bj=dD[d5]if W<bj then return dE[W]end;bq=bj;dF=bj*2;W=W*2 end;for T=d5+1,15 do local dG;dG=aG%2;aG=(aG-dG)/2;aH=aH-1;W=dG==1 and W+1-W%2 or W;bj=dD[T]or 0;local dH=W-dF;if dH<bj then return dE[bq+dH]end;bq=bq+bj;dF=dF+bj;dF=dF*2;W=W*2 end;return-10 end;local function dI()return(dt-du+1)*8+aH end;local function dJ()local dK=aH%8;local aM=o[dK]aH=aH-dK;aG=(aG-aG%aM)/aM end;return dv,dy,dC,dI,dJ end;local function dL(Y,al)local dv,dy,dC,dI,dJ=dq(Y)local dM={ReadBits=dv,ReadBytes=dy,Decode=dC,ReaderBitlenLeft=dI,SkipToByteBoundary=dJ,buffer_size=0,buffer={},result_buffer={},dictionary=al}return dM end;local function dN(dO,b6,b7)local dD={}local d5=b7;for bb=0,b6 do local T=dO[bb]or 0;d5=T>0 and T<d5 and T or d5;dD[T]=(dD[T]or 0)+1 end;if dD[0]==b6+1 then return 0,dD,{},0 end;local dP=1;for U=1,b7 do dP=dP*2;dP=dP-(dD[U]or 0)if dP<0 then return dP end end;local dQ={}dQ[1]=0;for U=1,b7-1 do dQ[U+1]=dQ[U]+(dD[U]or 0)end;local dE={}for bb=0,b6 do local T=dO[bb]or 0;if T~=0 then local bI=dQ[T]dE[bI]=bb;dQ[T]=dQ[T]+1 end end;return dP,dD,dE,d5 end;local function dR(dM,cq,dS,dT,cs,dU,dV)local aJ,aF,dv,dC,dI,aK=dM.buffer,dM.buffer_size,dM.ReadBits,dM.Decode,dM.ReaderBitlenLeft,dM.result_buffer;local al=dM.dictionary;local bW;local d4;local dW=1;if al and not aJ[0]then bW=al.string_table;d4=al.strlen;dW=-d4+1;for K=0,-d4+1<-257 and-257 or-d4+1,-1 do aJ[K]=p[bW[d4+K]]end end;repeat local bb=dC(cq,dS,dT)if bb<0 or bb>285 then return-10 elseif bb<256 then aF=aF+1;aJ[aF]=p[bb]elseif bb>256 then bb=bb-256;local T=x[bb]T=bb>=8 and T+dv(y[bb])or T;bb=dC(cs,dU,dV)if bb<0 or bb>29 then return-10 end;local X=z[bb]X=X>4 and X+dv(A[bb])or X;local dX=aF-X+1;if dX<dW then return-11 end;if dX>=-257 then for P=1,T do aF=aF+1;aJ[aF]=aJ[dX]dX=dX+1 end else dX=d4+dX;for P=1,T do aF=aF+1;aJ[aF]=p[bW[dX]]dX=dX+1 end end end;if dI()<0 then return 2 end;if aF>=65536 then aK[#aK+1]=m(aJ,"",1,32768)for K=32769,aF do aJ[K-32768]=aJ[K]end;aF=aF-32768;aJ[aF+1]=nil end until bb==256;dM.buffer_size=aF;return 0 end;local function dY(dM)local aJ,aF,dv,dy,dI,dJ,aK=dM.buffer,dM.buffer_size,dM.ReadBits,dM.ReadBytes,dM.ReaderBitlenLeft,dM.SkipToByteBoundary,dM.result_buffer;dJ()local dz=dv(16)if dI()<0 then return 2 end;local dZ=dv(16)if dI()<0 then return 2 end;if dz%256+dZ%256~=255 then return-2 end;if(dz-dz%256)/256+(dZ-dZ%256)/256~=255 then return-2 end;aF=dy(dz,aJ,aF)if aF<0 then return 2 end;if aF>=65536 then aK[#aK+1]=m(aJ,"",1,32768)for K=32769,aF do aJ[K-32768]=aJ[K]end;aF=aF-32768;aJ[aF+1]=nil end;dM.buffer_size=aF;return 0 end;local function d_(dM)return dR(dM,F,D,7,J,H,5)end;local function e0(dM)local dv,dC=dM.ReadBits,dM.Decode;local e1=dv(5)+257;local e2=dv(5)+1;local e3=dv(4)+4;if e1>286 or e2>30 then return-3 end;local cw={}for K=1,e3 do cw[B[K]]=dv(3)end;local e4,e5,e6,e7=dN(cw,18,7)if e4~=0 then return-4 end;local cq={}local cs={}local bq=0;while bq<e1+e2 do local bb;local T;bb=dC(e5,e6,e7)if bb<0 then return bb elseif bb<16 then if bq<e1 then cq[bq]=bb else cs[bq-e1]=bb end;bq=bq+1 else T=0;if bb==16 then if bq==0 then return-5 end;if bq-1<e1 then T=cq[bq-1]else T=cs[bq-e1-1]end;bb=3+dv(2)elseif bb==17 then bb=3+dv(3)else bb=11+dv(7)end;if bq+bb>e1+e2 then return-6 end;while bb>0 do bb=bb-1;if bq<e1 then cq[bq]=T else cs[bq-e1]=T end;bq=bq+1 end end end;if(cq[256]or 0)==0 then return-9 end;local e8,e9,dS,dT=dN(cq,e1-1,15)if e8~=0 and(e8<0 or e1~=(e9[0]or 0)+(e9[1]or 0))then return-7 end;local ea,eb,dU,dV=dN(cs,e2-1,15)if ea~=0 and(ea<0 or e2~=(eb[0]or 0)+(eb[1]or 0))then return-8 end;return dR(dM,e9,dS,dT,eb,dU,dV)end;local function ec(dM)local dv=dM.ReadBits;local cJ;while not cJ do cJ=dv(1)==1;local ed=dv(2)local ee;if ed==0 then ee=dY(dM)elseif ed==1 then ee=d_(dM)elseif ed==2 then ee=e0(dM)else return nil,-1 end;if ee~=0 then return nil,ee end end;dM.result_buffer[#dM.result_buffer+1]=m(dM.buffer,"",1,dM.buffer_size)local da=m(dM.result_buffer)return da end;local function ef(Y,al)local dM=dL(Y,al)local da,ee=ec(dM)if not da then return nil,ee end;local eg=dM.ReaderBitlenLeft()local eh=(eg-eg%8)/8;return da,eh end;local function ei(Y,al)local dM=dL(Y,al)local dv=dM.ReadBits;local de=dv(8)if dM.ReaderBitlenLeft()<0 then return nil,2 end;local dc=de%16;local dd=(de-dc)/16;if dc~=8 then return nil,-12 end;if dd>7 then return nil,-13 end;local dh=dv(8)if dM.ReaderBitlenLeft()<0 then return nil,2 end;if(de*256+dh)%31~=0 then return nil,-14 end;local df=(dh-dh%32)/32%2;local dg=(dh-dh%64)/64%4;if df==1 then if not al then return nil,-16 end;local dm=dv(8)local dl=dv(8)local dk=dv(8)local dj=dv(8)local ak=dm*16777216+dl*65536+dk*256+dj;if dM.ReaderBitlenLeft()<0 then return nil,2 end;if not ag(ak,al.adler32)then return nil,-17 end end;local da,ee=ec(dM)if not da then return nil,ee end;dM.SkipToByteBoundary()local ej=dv(8)local ek=dv(8)local el=dv(8)local em=dv(8)if dM.ReaderBitlenLeft()<0 then return nil,2 end;local en=ej*16777216+ek*65536+el*256+em;local eo=a:Adler32(da)if not ag(en,eo)then return nil,-15 end;local eg=dM.ReaderBitlenLeft()local eh=(eg-eg%8)/8;return da,eh end;function a:DecompressDeflate(Y)local dn,dp=ar(Y)if not dn then error("Usage: LibDeflate:DecompressDeflate(str): "..dp,2)end;return ef(Y)end;function a:DecompressDeflateWithDict(Y,al)local dn,dp=ar(Y,true,al)if not dn then error("Usage: LibDeflate:DecompressDeflateWithDict(str, dictionary): "..dp,2)end;return ef(Y,al)end;function a:DecompressZlib(Y)local dn,dp=ar(Y)if not dn then error("Usage: LibDeflate:DecompressZlib(str): "..dp,2)end;return ei(Y)end;function a:DecompressZlibWithDict(Y,al)local dn,dp=ar(Y,true,al)if not dn then error("Usage: LibDeflate:DecompressZlibWithDict(str, dictionary): "..dp,2)end;return ei(Y,al)end;do E={}for ep=0,143 do E[ep]=8 end;for ep=144,255 do E[ep]=9 end;for ep=256,279 do E[ep]=7 end;for ep=280,287 do E[ep]=8 end;I={}for X=0,31 do I[X]=5 end;local ee;ee,F,D=dN(E,287,9)assert(ee==0)ee,J,H=dN(I,31,5)assert(ee==0)C=b3(F,E,287,9)G=b3(J,I,31,5)end;local eq={["\000"]="%z",["("]="%(",[")"]="%)",["."]="%.",["%"]="%%",["+"]="%+",["-"]="%-",["*"]="%*",["?"]="%?",["["]="%[",["]"]="%]",["^"]="%^",["$"]="%$"}local function er(Y)return Y:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])",eq)end;function a:CreateCodec(es,et,eu)if type(es)~="string"or type(et)~="string"or type(eu)~="string"then error("Usage: LibDeflate:CreateCodec(reserved_chars,".." escape_chars, map_chars):".." All arguments must be string.",2)end;if et==""then return nil,"No escape characters supplied."end;if#es<#eu then return nil,"The number of reserved characters must be".." at least as many as the number of mapped chars."end;if es==""then return nil,"No characters to encode."end;local ev=es..et..eu;local ew={}for K=1,#ev do local dB=h(ev,K,K)if ew[dB]then return nil,"There must be no duplicate characters in the".." concatenation of reserved_chars, escape_chars and".." map_chars."end;ew[dB]=true end;local ex={}local ey={}local ez={}local eA={}if#eu>0 then local eB={}local eC={}for K=1,#eu do local eD=l(es,K,K)local eE=l(eu,K,K)eA[eD]=eE;ez[#ez+1]=eD;eC[eE]=eD;eB[#eB+1]=eE end;ex[#ex+1]="(["..er(m(eB)).."])"ey[#ey+1]=eC end;local eF=1;local eG=l(et,eF,eF)local eH=0;local eB={}local eC={}for K=1,#ev do local S=l(ev,K,K)if not eA[S]then while eH>=256 or ew[eH]do eH=eH+1;if eH>255 then ex[#ex+1]=er(eG).."(["..er(m(eB)).."])"ey[#ey+1]=eC;eF=eF+1;eG=l(et,eF,eF)eH=0;eB={}eC={}if not eG or eG==""then return nil,"Out of escape characters."end end end;local eI=p[eH]eA[S]=eG..eI;ez[#ez+1]=S;eC[eI]=S;eB[#eB+1]=eI;eH=eH+1 end;if K==#ev then ex[#ex+1]=er(eG).."(["..er(m(eB)).."])"ey[#ey+1]=eC end end;local eJ={}local eK="(["..er(m(ez)).."])"local eL=eA;function eJ:Encode(Y)if type(Y)~="string"then error(("Usage: codec:Encode(str):".." 'str' - string expected got '%s'."):format(type(Y)),2)end;return k(Y,eK,eL)end;local eM=#ex;local eN="(["..er(es).."])"function eJ:Decode(Y)if type(Y)~="string"then error(("Usage: codec:Decode(str):".." 'str' - string expected got '%s'."):format(type(Y)),2)end;if j(Y,eN)then return nil end;for K=1,eM do Y=k(Y,ex[K],ey[K])end;return Y end;return eJ end;local eO;local function eP()return a:CreateCodec("\000","\001","")end;function a:EncodeForWoWAddonChannel(Y)if type(Y)~="string"then error(("Usage: LibDeflate:EncodeForWoWAddonChannel(str):".." 'str' - string expected got '%s'."):format(type(Y)),2)end;if not eO then eO=eP()end;return eO:Encode(Y)end;function a:DecodeForWoWAddonChannel(Y)if type(Y)~="string"then error(("Usage: LibDeflate:DecodeForWoWAddonChannel(str):".." 'str' - string expected got '%s'."):format(type(Y)),2)end;if not eO then eO=eP()end;return eO:Decode(Y)end;local function eQ()local eH={}for K=128,255 do eH[#eH+1]=p[K]end;local es="sS\000\010\013\124%"..m(eH)return a:CreateCodec(es,"\029\031","\015\020")end;local eR;function a:EncodeForWoWChatChannel(Y)if type(Y)~="string"then error(("Usage: LibDeflate:EncodeForWoWChatChannel(str):".." 'str' - string expected got '%s'."):format(type(Y)),2)end;if not eR then eR=eQ()end;return eR:Encode(Y)end;function a:DecodeForWoWChatChannel(Y)if type(Y)~="string"then error(("Usage: LibDeflate:DecodeForWoWChatChannel(str):".." 'str' - string expected got '%s'."):format(type(Y)),2)end;if not eR then eR=eQ()end;return eR:Decode(Y)end;local eS={[0]="a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","0","1","2","3","4","5","6","7","8","9","(",")"}local eT={[97]=0,[98]=1,[99]=2,[100]=3,[101]=4,[102]=5,[103]=6,[104]=7,[105]=8,[106]=9,[107]=10,[108]=11,[109]=12,[110]=13,[111]=14,[112]=15,[113]=16,[114]=17,[115]=18,[116]=19,[117]=20,[118]=21,[119]=22,[120]=23,[121]=24,[122]=25,[65]=26,[66]=27,[67]=28,[68]=29,[69]=30,[70]=31,[71]=32,[72]=33,[73]=34,[74]=35,[75]=36,[76]=37,[77]=38,[78]=39,[79]=40,[80]=41,[81]=42,[82]=43,[83]=44,[84]=45,[85]=46,[86]=47,[87]=48,[88]=49,[89]=50,[90]=51,[48]=52,[49]=53,[50]=54,[51]=55,[52]=56,[53]=57,[54]=58,[55]=59,[56]=60,[57]=61,[40]=62,[41]=63}function a:EncodeForPrint(Y)if type(Y)~="string"then error(("Usage: LibDeflate:EncodeForPrint(str):".." 'str' - string expected got '%s'."):format(type(Y)),2)end;local Z=#Y;local eU=Z-2;local K=1;local aJ={}local aF=0;while K<=eU do local _,a0,a1=h(Y,K,K+2)K=K+3;local aG=_+a0*256+a1*65536;local eV=aG%64;aG=(aG-eV)/64;local eW=aG%64;aG=(aG-eW)/64;local eX=aG%64;local eY=(aG-eX)/64;aF=aF+1;aJ[aF]=eS[eV]..eS[eW]..eS[eX]..eS[eY]end;local aG=0;local aH=0;while K<=Z do local af=h(Y,K,K)aG=aG+af*o[aH]aH=aH+8;K=K+1 end;while aH>0 do local eZ=aG%64;aF=aF+1;aJ[aF]=eS[eZ]aG=(aG-eZ)/64;aH=aH-6 end;return m(aJ)end;function a:DecodeForPrint(Y)if type(Y)~="string"then error(("Usage: LibDeflate:DecodeForPrint(str):".." 'str' - string expected got '%s'."):format(type(Y)),2)end;Y=Y:gsub("^[%c ]+","")Y=Y:gsub("[%c ]+$","")local Z=#Y;if Z==1 then return nil end;local e_=Z-3;local K=1;local aJ={}local aF=0;while K<=e_ do local _,a0,a1,a2=h(Y,K,K+3)_=eT[_]a0=eT[a0]a1=eT[a1]a2=eT[a2]if not(_ and a0 and a1 and a2)then return nil end;K=K+4;local aG=_+a0*64+a1*4096+a2*262144;local eV=aG%256;aG=(aG-eV)/256;local eW=aG%256;local eX=(aG-eW)/256;aF=aF+1;aJ[aF]=p[eV]..p[eW]..p[eX]end;local aG=0;local aH=0;while K<=Z do local af=h(Y,K,K)af=eT[af]if not af then return nil end;aG=aG+af*o[aH]aH=aH+6;K=K+1 end;while aH>=8 do local dB=aG%256;aF=aF+1;aJ[aF]=p[dB]aG=(aG-dB)/256;aH=aH-8 end;return m(aJ)end;local function f0()eR=nil;eO=nil end;a.internals={LoadStringToTable=bF,IsValidDictionary=ap,IsEqualAdler32=ag,_byte_to_6bit_char=eS,_6bit_to_byte=eT,InternalClearCache=f0}if io and os and debug and _G.arg then local io=io;local os=os;local debug=debug;local f1=_G.arg;local f2=debug.getinfo(1)if f2.source==f1[0]or f2.short_src==f1[0]then local ds;local f3;local K=1;local ee;local f4=false;local f5=false;local bK;local d0;local al;while f1[K]do local Q=f1[K]if Q=="-h"then print(a._COPYRIGHT.."\nUsage: lua LibDeflate.lua [OPTION] [INPUT] [OUTPUT]\n".."  -0    store only. no compression.\n".."  -1    fastest compression.\n".."  -9    slowest and best compression.\n".."  -d    do decompression instead of compression.\n".."  --dict <filename> specify the file that contains".." the entire preset dictionary.\n".."  -h    give this help.\n".."  --strategy <fixed/huffman_only/dynamic>".." specify a special compression strategy.\n".."  -v    print the version and copyright info.\n".."  --zlib  use zlib format instead of raw deflate.\n")os.exit(0)elseif Q=="-v"then print(a._COPYRIGHT)os.exit(0)elseif Q:find("^%-[0-9]$")then bK=tonumber(Q:sub(2,2))elseif Q=="-d"then f5=true elseif Q=="--dict"then K=K+1;local f6=f1[K]if not f6 then io.stderr:write("You must speicify the dict filename")os.exit(1)end;local f7,f8=io.open(f6,"rb")if not f7 then io.stderr:write(("LibDeflate: Cannot read the dictionary file '%s': %s"):format(f6,f8))os.exit(1)end;local f9=f7:read("*all")f7:close()al=a:CreateDictionary(f9,#f9,a:Adler32(f9))elseif Q=="--strategy"then K=K+1;d0=f1[K]elseif Q=="--zlib"then f4=true elseif Q:find("^%-")then io.stderr:write(("LibDeflate: Invalid argument: %s"):format(Q))os.exit(1)else if not ds then ds,ee=io.open(Q,"rb")if not ds then io.stderr:write(("LibDeflate: Cannot read the file '%s': %s"):format(Q,tostring(ee)))os.exit(1)end elseif not f3 then f3,ee=io.open(Q,"wb")if not f3 then io.stderr:write(("LibDeflate: Cannot write the file '%s': %s"):format(Q,tostring(ee)))os.exit(1)end end end;K=K+1 end;if not ds or not f3 then io.stderr:write("LibDeflate:".." You must specify both input and output files.")os.exit(1)end;local fa=ds:read("*all")local au={level=bK,strategy=d0}local fb;if not f5 then if not f4 then if not al then fb=a:CompressDeflate(fa,au)else fb=a:CompressDeflateWithDict(fa,al,au)end else if not al then fb=a:CompressZlib(fa,au)else fb=a:CompressZlibWithDict(fa,al,au)end end else if not f4 then if not al then fb=a:DecompressDeflate(fa)else fb=a:DecompressDeflateWithDict(fa,al)end else if not al then fb=a:DecompressZlib(fa)else fb=a:DecompressZlibWithDict(fa,al)end end end;if not fb then io.stderr:write("LibDeflate: Decompress fails.")os.exit(1)end;f3:write(fb)if ds and ds~=io.stdin then ds:close()end;if f3 and f3~=io.stdout then f3:close()end;io.stderr:write(("Successfully writes %d bytes"):format(fb:len()))os.exit(0)end end;return a
end)()

--Program starts here

--Midisong format version
local midisongVersion = 1.3

local hexchars = "0123456789abcdef"

--Parse instruments into a map
local instruments = {}
for ins, ranges in pairs(melodic) do
    for i=1, #ranges, 2 do
        for j=ranges[i], ranges[i+1] do
            instruments[j]=ins
        end
    end
end
do
    local i=0
    for j=1,#percussive,2 do
        local a,b=percussive[j], percussive[j+1]
        if type(a)=='string' then
            instruments[128+i]={a, b}
            i=i+1
        else
            assert(a==i, "percussive misalign")
            i=b+1
        end
    end
    assert(i==128, "missing percussion")
end

local nb = peripheral.find('note_block')
if not nb then
    print("noteblock not found")
    return
end

local messages = {}
local function message(msg)
    assert(type(msg)=='string', "non-string message")
    
    local w,h = term.getSize()
    local maxw = w-2
    local maxh = h-7
    
    local idx=1
    while idx<=#msg do
        local submsg = msg:sub(idx, idx+maxw-1)
        idx = idx+maxw
        while #messages>=maxh do
            table.remove(messages,1)
        end
        table.insert(messages, submsg)
    end
end
local function clearMessages()
    messages = {}
end
local function drawMessages(x,y)
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    for i,msg in ipairs(messages) do
        term.setCursorPos(x,y-1+i)
        term.write(msg)
    end
end

local function renderPlayMenu(name, transpose)
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    term.clear()
    local w,h = term.getSize()
    
    local trans = tostring(transpose)
    if transpose>0 then
        trans = "+"..trans
    end
    
    term.setCursorPos(2,2)
    term.write("Playing song:")
    term.setCursorPos(2,3)
    term.write("\""..(name or "?").."\"")
    term.setCursorPos(2,5)
    term.write("Transpose: "..trans)
    term.setCursorPos(2,6)
    term.write("[X] Stop")
    
    drawMessages(2,8)
end

local function decodeInt(str, idx)
    local b0, b1, b2, b3 = str:byte(idx, idx+3)
    local int = b3*2^24+b2*2^16+b1*2^8+b0
    return int, idx+4
end

local function decodeVarlen(str, idx)
    local int = 0
    local mul = 1
    for i=1,4 do
        local byte=str:byte(idx)
        idx=idx+1
        if byte<128 then
            --Last piece
            int=int+mul*byte
            break
        else
            --Continues
            byte=byte-128
            int=int+mul*byte
            mul=mul*2^7
        end
    end
    return int, idx
end

local function decideTranspose(hash, hands)
    local globalTuning = 66
    
    --Total transpose is based on total average
    local globalTranspose = globalTuning-hands.totalAvg
    
    --Hand transpose is by-octave
    for _,hand in ipairs(hands) do
        if hand.avg then
            --Start with an ideal transpose, which brings the average up to the tuning
            local localTranspose = (hand.instrument[2]-hand.avg) - globalTranspose
            --Round localTranspose to the closest multiple of 12 and divide by 12
            hand.octave = math.floor( localTranspose/12+0.5 )
        end
    end
    
    --Use the saved globalTranspose if available
    local file = io.open(savedir.."/"..hash, "r")
    if file then
        local trans = tonumber(file:read('*l'))
        file:close()
        if trans then
            trans = math.floor(trans+0.5)
            if trans==trans and trans>-math.huge and trans<math.huge then
                globalTranspose = trans
            end
        end
    end
    
    return globalTranspose
end

local function play(songdata)
    local hash
    local name
    local globalTranspose
    
    local function updateTranspose(offset)
        --Update transpose
        globalTranspose = globalTranspose+offset
        --Save transpose
        if not fs.exists(savedir) then
            fs.makeDir(savedir)
        end
        local file = io.open(savedir.."/"..hash, "w")
        if file then
            file:write(tostring(globalTranspose))
            file:close()
        end
        --Redraw
        renderPlayMenu(name, globalTranspose)
    end
    
    --Reverse base-95 encoding
    do
        local binary = {}
        local rem = songdata:byte(1)-32
        for i=2,#songdata,5 do
            local a,b,c,d,e = songdata:byte(i,i+4)
            a,b,c,d,e = a and (a-32) or 0, b and (b-32) or 0, c and (c-32) or 0, d and (d-32) or 0, e and (e-32) or 0
            local int = a*95^0+b*95^1+c*95^2+d*95^3+e*95^4
            local b0 = int%2^8
            int=math.floor(int/2^8)
            local b1 = int%2^8
            int=math.floor(int/2^8)
            local b2 = int%2^8
            int=math.floor(int/2^8)
            local b3 = int
            binary[#binary+1]=string.char(b0, b1, b2, b3)
        end
        if rem>0 and #binary>0 then
            binary[#binary] = binary[#binary]:sub(1,rem)
        end
        songdata=table.concat(binary)
    end
    
    --Deflate songdata
    songdata = assert(deflate:DecompressDeflate(songdata), "failed to decompress songdata")
    local idx = 1
    
    local function readByte()
        local byte = songdata:byte(idx)
        idx=idx+1
        return byte
    end
    
    --Read song id (md5 hash)
    do
        local binhash = songdata:sub(idx, idx+15)
        idx=idx+16
        hash = ""
        for byte in binhash:gmatch('.') do
            byte = byte:byte()
            local lo,hi = byte%16, math.floor(byte/16)
            hash=hash..hexchars:sub(lo,lo)..hexchars:sub(hi,hi)
        end
    end
    
    --Read name
    do
        local namelen
        namelen, idx = decodeInt(songdata, idx)
        name = songdata:sub(idx, idx+namelen-1)
        idx=idx+namelen
    end
    
    --Read ticks per beat
    local ticksPerBeat
    ticksPerBeat,idx = decodeInt(songdata, idx)
    
    --Read hand data
    local hands = {}
    for i=0,255 do
        local ins, avgKey = songdata:byte(idx, idx+1)
        idx=idx+2
        if ins<128 then
            if avgKey>=128 then
                avgKey = nil
            end
            hands[i] = {instrument = instruments[ins], avg = avgKey}
        end
    end
    hands.totalAvg = songdata:byte(idx)
    idx=idx+1
    
    --Pick a suitable global transpose and per-hand octaves
    globalTranspose = decideTranspose(hash, hands)
    
    renderPlayMenu(name, globalTranspose)
    
    local elapsed = 0
    local slept = 0
    local beatlen = 20
    local function sync(delta)
        elapsed = elapsed+delta*beatlen/ticksPerBeat
        local toSleep = math.floor(elapsed-slept)
        if toSleep>0 then
            local timer = os.startTimer(toSleep/20)
            while true do
                local ev, a = os.pullEvent()
                if ev=='timer' and a==timer then
                    break
                elseif ev=='key' then
                    if a==keys.x then
                        return true
                    elseif a==keys.down then
                        updateTranspose(-1)
                    elseif a==keys.up then
                        updateTranspose(1)
                    end
                end
            end
            slept = slept+toSleep
        end
    end
    
    while idx<=#songdata do
        local first = readByte()
        if first<0x80 then
            --NoteOn event
            local vel = first
            local key = readByte()
            local hand = readByte()
            
            local delta
            delta, idx = decodeVarlen(songdata, idx)
            
            if sync(delta) then
                return
            end
            if key<128 then
                --Melodic
                local hand = assert(hands[hand], "invalid hand index")
                local transpose = key-hand.instrument[2]+globalTranspose
                if hand.octave then
                    transpose = transpose+hand.octave*12
                end
                if transpose<-12 then
                    transpose=-((-transpose)%12)
                elseif transpose>12 then
                    transpose=transpose%12
                end
                local pitch = 2^(transpose/12)
                nb.playSound(hand.instrument[1], pitch, vel/127)
            else
                --Percussive
                local instrument = instruments[key]
                nb.playSound(instrument[1], instrument[2], 0.7*vel/127)
            end
        elseif first==0x80 then
            --Tempo change event
            local microsPerBeat
            microsPerBeat, idx = decodeInt(songdata, idx)
            beatlen = microsPerBeat*(20/1000000)
            beatlen = math.floor(beatlen/4)*4
        else
            error("invalid songdata event "..first)
        end
    end
end

local function renderUploadMenu(progress, elapsed)
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    term.clear()
    local w,h = term.getSize()
    
    if progress==0 then
        term.setCursorPos(2,2)
        term.write("Open up a file and press F4 to upload")
        term.setCursorPos(2,5)
        term.write("[X] Quit")
    else
        local secsLeft = elapsed/progress-elapsed
        local eta = ""
        if secsLeft>60*60 then
            eta=eta.." "..math.floor(secsLeft/(60*60)).."h"
            secsLeft=secsLeft%(60*60)
        end
        if secsLeft>60 then
            eta=eta.." "..math.floor(secsLeft/60).."m"
            secsLeft=secsLeft%60
        end
        eta=eta.." "..math.ceil(secsLeft).."s"
        
        term.setCursorPos(2,2)
        term.write("Uploading...  "..math.ceil(progress*100).."% (ETA:"..eta..")")
        term.setCursorPos(2,3)
        term.write("Do NOT exit the computer screen")
        local len = w-2
        local done = math.ceil(len*progress)
        term.setCursorPos(2,5)
        term.setBackgroundColor(colors.white)
        term.write((" "):rep(done))
        term.setBackgroundColor(colors.black)
        term.write((" "):rep(len-done))
    end
    
    drawMessages(2,7)
end

while true do
    renderUploadMenu(0)
    local ev, data = os.pullEvent()
    if ev=='key' and data==keys.x then
        term.clear()
        term.setBackgroundColor(colors.black)
        term.setTextColor(colors.white)
        term.setCursorPos(1,1)
        sleep(0)
        break
    elseif ev=='paste' then
        local version, len, msg = data:match('^midisong:([^:]+):([^:]+):(.*)$')
        version, len = tonumber(version), tonumber(len)
        
        --Validate header
        local err
        if version~=midisongVersion then
            if version then
                if version<midisongVersion then
                    err="update your noteblock.exe (got v"..version..", expected v"..midisongVersion..")"
                elseif version>midisongVersion then
                    err="use an older noteblock.exe (got v"..version..", expected v"..midisongVersion..")"
                else
                    err="unknown error"
                end
            else
                err="make sure a valid and up-to-date noteblock.exe is in use"
            end
            message("invalid songdata")
        end
        
        --Receive full songdata no matter what
        local start = os.clock()
        local timer = os.startTimer(1)
        local lastReceived = os.clock()
        while true do
            if not err then
                if #msg==len then
                    break
                elseif #msg>len then
                    err="only one person can upload at a time"
                    break
                end
            end
            local progress,elapsed
            if err then
                progress,elapsed=1,0
            else
                progress,elapsed=#msg/len,os.clock()-start
            end
            renderUploadMenu(progress, elapsed)
            local ev, data = os.pullEvent()
            local now = os.clock()
            if ev=='timer' and data==timer then
                if now-lastReceived>1.5 then
                    --Timed out
                    if not err then
                        err="upload interrupted or corrupted"
                    end
                    break
                end
                timer = os.startTimer(1)
            elseif ev=='paste' then
                lastReceived=now
                if not err then
                    msg=msg..data
                end
            end
        end
        
        if err then
            message(tostring(err))
        else
            clearMessages()
            print("playing song")
            ok,err = pcall(play, msg)
            if ok then
                clearMessages()
            else
                message("error playing song: "..tostring(err))
            end
        end
    end
end
print("Goodbye")
