#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS blt

# Test the blt macro.

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> a8a4 8000 	bltc	a0,a1,00000000 <text_label>
			0: R_NANOMIPS_PC14_S1	text_label
0+0004 <text_label\+0x4> a804 8000 	bltzc	a0,00000000 <text_label>
			4: R_NANOMIPS_PC14_S1	text_label
0+0008 <text_label\+0x8> a8a0 8000 	bgtzc	a1,00000000 <text_label>
			8: R_NANOMIPS_PC14_S1	text_label
0+000c <text_label\+0xc> a804 8000 	bltzc	a0,00000000 <text_label>
			c: R_NANOMIPS_PC14_S1	text_label
0+0010 <text_label\+0x10> 8880 8000 	blezc	a0,00000000 <text_label>
			10: R_NANOMIPS_PC14_S1	text_label
0+0014 <text_label\+0x14> c898 1000 	bltic	a0,2,00000000 <text_label>
			14: R_NANOMIPS_PC11_S1	text_label
0+0018 <text_label\+0x18> 0020 8000 	li	at,32768
0+001c <text_label\+0x1c> 2024 0b50 	slt	at,a0,at
0+0020 <text_label\+0x20> a820 0000 	bnezc	at,00000000 <text_label>
			20: R_NANOMIPS_PC14_S1	text_label
0+0024 <text_label\+0x24> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
0+0028 <text_label\+0x28> 2024 0b50 	slt	at,a0,at
0+002c <text_label\+0x2c> a820 0000 	bnezc	at,00000000 <text_label>
			2c: R_NANOMIPS_PC14_S1	text_label
0+0030 <text_label\+0x30> e021 0000 	lui	at,%hi\(0x10000\)
0+0034 <text_label\+0x34> 2024 0b50 	slt	at,a0,at
0+0038 <text_label\+0x38> a820 0000 	bnezc	at,00000000 <text_label>
			38: R_NANOMIPS_PC14_S1	text_label
0+003c <text_label\+0x3c> e021 a000 	lui	at,%hi\(0x1a000\)
0+0040 <text_label\+0x40> 8021 05a5 	ori	at,at,0x5a5
0+0044 <text_label\+0x44> 2024 0b50 	slt	at,a0,at
0+0048 <text_label\+0x48> a820 0000 	bnezc	at,00000000 <text_label>
			48: R_NANOMIPS_PC14_S1	text_label
0+004c <text_label\+0x4c> 2085 0b50 	slt	at,a1,a0
0+0050 <text_label\+0x50> 8820 0000 	beqzc	at,00000000 <text_label>
			50: R_NANOMIPS_PC14_S1	text_label
0+0054 <text_label\+0x54> 8880 8000 	blezc	a0,00000000 <text_label>
			54: R_NANOMIPS_PC14_S1	text_label
0+0058 <text_label\+0x58> 8805 8000 	bgezc	a1,00000000 <text_label>
			58: R_NANOMIPS_PC14_S1	text_label
0+005c <text_label\+0x5c> 8880 8000 	blezc	a0,00000000 <text_label>
			5c: R_NANOMIPS_PC14_S1	text_label
0+0060 <text_label\+0x60> a8a4 8000 	bltc	a0,a1,00000000 <external_label>
			60: R_NANOMIPS_PC14_S1	external_label
0+0064 <text_label\+0x64> 2085 0b50 	slt	at,a1,a0
0+0068 <text_label\+0x68> 8820 0000 	beqzc	at,00000000 <external_label>
			68: R_NANOMIPS_PC14_S1	external_label
	...
