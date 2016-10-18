#objdump: -dr --prefix-addresses
#name: MIPS32R7 and
#source: and.s
#as: -32

# Test the add macro for R7

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <foo> andi	a0,a0,0
0+0004 <foo\+0x4> andi	a0,a0,1
0+0008 <foo\+0x8> lui	at,0x8
0+000c <foo\+0xc> and	a0,a0,at
0+0010 <foo\+0x10> lui	at,0xffff8
0+0014 <foo\+0x14> and	a0,a0,at
0+0018 <foo\+0x18> lui	at,0x10
0+001c <foo\+0x1c> and	a0,a0,at
0+0020 <foo\+0x20> lui	at,0x1a
0+0024 <foo\+0x24> ori	at,at,1445
0+0028 <foo\+0x28> and	a0,a0,at
0+002c <foo\+0x2c> li	at,0
0+0030 <foo\+0x30> nor	a0,a1,at
0+0034 <foo\+0x34> li	at,1
0+0038 <foo\+0x38> nor	a0,a1,at
0+003c <foo\+0x3c> lui	at,0x8
0+0040 <foo\+0x40> nor	a0,a1,at
0+0044 <foo\+0x44> lui	at,0xffff8
0+0048 <foo\+0x48> nor	a0,a1,at
0+004c <foo\+0x4c> lui	at,0x10
0+0050 <foo\+0x50> nor	a0,a1,at
0+0054 <foo\+0x54> lui	at,0x1a
0+0058 <foo\+0x58> ori	at,at,1445
0+005c <foo\+0x5c> nor	a0,a1,at
0+0060 <foo\+0x60> ori	a0,a1,0
0+0064 <foo\+0x64> xori	a0,a1,0
	\.\.\.
