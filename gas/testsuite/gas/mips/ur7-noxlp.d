#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPSR7 XLP instructions expanded to macros
#as: -mmicromips -mips32r7 -mno-xlp
#source: ur7-noxlp.s

# Check MIPSR7 instructions

.*: +file format .*mips.*

Disassembly of section .text:
0+0000 <test> 8043 c011 	sll	v0,v1,0x11
0+0004 <test\+0x4> 8042 c05a 	srl	v0,v0,0x1a
0+0008 <test\+0x8> 8043 c001 	sll	v0,v1,0x1
0+000c <test\+0xc> 8042 c05f 	srl	v0,v0,0x1f
0+0010 <test\+0x10> 8042 c05f 	srl	v0,v0,0x1f
0+0014 <test\+0x14> 83ff c05f 	srl	ra,ra,0x1f
0+0018 <test\+0x18> 2042 115f 	align	v0,v0,v0,0x5
0+001c <test\+0x1c> 2062 13df 	align	v0,v0,v1,0xf
0+0020 <test\+0x20> 2042 131f 	align	v0,v0,v0,0xc
0+0024 <test\+0x24> 2042 101f 	align	v0,v0,v0,0x0
0+0028 <test\+0x28> 2042 17df 	align	v0,v0,v0,0x1f
0+002c <test\+0x2c> 2062 105f 	align	v0,v0,v1,0x1
0+0030 <test\+0x30> 23ff ffdf 	align	ra,ra,ra,0x1f
0+0034 <test\+0x34> 23df f85f 	align	ra,ra,s8,0x1
