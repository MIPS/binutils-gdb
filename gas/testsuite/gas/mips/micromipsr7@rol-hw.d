#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPSR7 hardware rol/ror
#source: rol.s
#as: -32

# Test the rol and ror macros (microMIPS R7).

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <foo> 20a0 09d0 	negu	at,a1
0+0004 <foo\+0x4> 2024 20d0 	rotr	a0,a0,at
0+0008 <foo\+0x8> 20c0 21d0 	negu	a0,a2
0+000c <foo\+0xc> 2085 20d0 	rotr	a0,a1,a0
0+0010 <foo\+0x10> 8084 c0df 	rotr	a0,a0,0x1f
0+0014 <foo\+0x14> 8085 c0df 	rotr	a0,a1,0x1f
0+0018 <foo\+0x18> 8085 c0c0 	rotr	a0,a1,0x0
0+001c <foo\+0x1c> 20a4 20d0 	rotr	a0,a0,a1
0+0020 <foo\+0x20> 20c5 20d0 	rotr	a0,a1,a2
0+0024 <foo\+0x24> 8084 c0c1 	rotr	a0,a0,0x1
0+0028 <foo\+0x28> 8085 c0c1 	rotr	a0,a1,0x1
0+002c <foo\+0x2c> 8085 c0c0 	rotr	a0,a1,0x0
0+0030 <foo\+0x30> 8085 c0c0 	rotr	a0,a1,0x0
0+0034 <foo\+0x34> 8085 c0df 	rotr	a0,a1,0x1f
0+0038 <foo\+0x38> 8085 c0c1 	rotr	a0,a1,0x1
0+003c <foo\+0x3c> 8085 c0c0 	rotr	a0,a1,0x0
0+0040 <foo\+0x40> 8085 c0c1 	rotr	a0,a1,0x1
0+0044 <foo\+0x44> 8085 c0df 	rotr	a0,a1,0x1f
	\.\.\.
