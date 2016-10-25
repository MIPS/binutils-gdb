#as: -32
#objdump: -dr --prefix-addresses --show-raw-insn
#name: LA with relocation operators for MIPS R7 with li[48]
#source: la-reloc.s

.*file format.*

Disassembly of section \.text:
0+0000 <func> 6080 0000 0000 	li	a0,0x0
			2: R_MICROMIPS_32	foo
0+0006 <func\+0x6> 6080 0000 0000 	li	a0,0x0
			8: R_MICROMIPS_32	foo
0+000c <func\+0xc> 6080 1234 8765 	li	a0,0x12348765
0+0012 <func\+0x12> 6080 1234 8765 	li	a0,0x12348765
0+0018 <func\+0x18> 6080 0000 0000 	li	a0,0x0
			1a: R_MICROMIPS_32	foo
0+001e <func\+0x1e> 20a4 2150 	addu	a0,a0,a1
0+0022 <func\+0x22> 6080 0000 0000 	li	a0,0x0
			24: R_MICROMIPS_32	foo
0+0028 <func\+0x28> 20a4 2150 	addu	a0,a0,a1
0+002c <func\+0x2c> 6080 1234 8765 	li	a0,0x12348765
0+0032 <func\+0x32> 20a4 2150 	addu	a0,a0,a1
0+0036 <func\+0x36> 6080 1234 8765 	li	a0,0x12348765
0+003c <func\+0x3c> 20a4 2150 	addu	a0,a0,a1
0+0040 <func\+0x40> 6080 0000 0000 	li	a0,0x0
			42: R_MICROMIPS_32	foo\+0x12348765
0+0046 <func\+0x46> 20a4 2150 	addu	a0,a0,a1
0+004a <func\+0x4a> 6080 0000 0000 	li	a0,0x0
			4c: R_MICROMIPS_32	foo\+0x12348765
0+0050 <func\+0x50> 20a4 2150 	addu	a0,a0,a1
