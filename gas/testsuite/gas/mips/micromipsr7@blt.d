#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS R7 blt
#as: -32
#source: blt.s

# Test the blt macro.

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> a8a4 8000 	bltc	a0,a1,00000004 <text_label\+0x4>
			0: R_MICROMIPS_PC14_S1	text_label-0x4
0+0004 <text_label\+0x4> a804 8000 	bltzc	a0,00000008 <text_label\+0x8>
			4: R_MICROMIPS_PC14_S1	text_label-0x4
0+0008 <text_label\+0x8> a8a0 8000 	bgtzc	a1,0000000c <text_label\+0xc>
			8: R_MICROMIPS_PC14_S1	text_label-0x4
0+000c <text_label\+0xc> a804 8000 	bltzc	a0,00000010 <text_label\+0x10>
			c: R_MICROMIPS_PC14_S1	text_label-0x4
0+0010 <text_label\+0x10> 8880 8000 	blezc	a0,00000014 <text_label\+0x14>
			10: R_MICROMIPS_PC14_S1	text_label-0x4
0+0014 <text_label\+0x14> c898 1000 	bltic	a0,2,00000018 <text_label\+0x18>
			14: R_MICROMIPS_PC11_S1	text_label-0x4
0+0018 <text_label\+0x18> e020 8000 	lui	at,0x8
0+001c <text_label\+0x1c> 2024 0b50 	slt	at,a0,at
0+0020 <text_label\+0x20> e830 0000 	bnezc	at,00000024 <text_label\+0x24>
			20: R_MICROMIPS_PC20_S1	text_label-0x4
0+0024 <text_label\+0x24> e03f 8ffd 	lui	at,0xffff8
0+0028 <text_label\+0x28> 2024 0b50 	slt	at,a0,at
0+002c <text_label\+0x2c> e830 0000 	bnezc	at,00000030 <text_label\+0x30>
			2c: R_MICROMIPS_PC20_S1	text_label-0x4
0+0030 <text_label\+0x30> e021 0000 	lui	at,0x10
0+0034 <text_label\+0x34> 2024 0b50 	slt	at,a0,at
0+0038 <text_label\+0x38> e830 0000 	bnezc	at,0000003c <text_label\+0x3c>
			38: R_MICROMIPS_PC20_S1	text_label-0x4
0+003c <text_label\+0x3c> e021 a000 	lui	at,0x1a
0+0040 <text_label\+0x40> 8021 05a5 	ori	at,at,1445
0+0044 <text_label\+0x44> 2024 0b50 	slt	at,a0,at
0+0048 <text_label\+0x48> e830 0000 	bnezc	at,0000004c <text_label\+0x4c>
			48: R_MICROMIPS_PC20_S1	text_label-0x4
0+004c <text_label\+0x4c> 2085 0b50 	slt	at,a1,a0
0+0050 <text_label\+0x50> e820 0000 	beqzc	at,00000054 <text_label\+0x54>
			50: R_MICROMIPS_PC20_S1	text_label-0x4
0+0054 <text_label\+0x54> 8880 8000 	blezc	a0,00000058 <text_label\+0x58>
			54: R_MICROMIPS_PC14_S1	text_label-0x4
0+0058 <text_label\+0x58> 8805 8000 	bgezc	a1,0000005c <text_label\+0x5c>
			58: R_MICROMIPS_PC14_S1	text_label-0x4
0+005c <text_label\+0x5c> 8880 8000 	blezc	a0,00000060 <text_label\+0x60>
			5c: R_MICROMIPS_PC14_S1	text_label-0x4
0+0060 <text_label\+0x60> a8a4 8000 	bltc	a0,a1,00000064 <external_label\+0x64>
			60: R_MICROMIPS_PC14_S1	external_label-0x4
0+0064 <text_label\+0x64> 2085 0b50 	slt	at,a1,a0
0+0068 <text_label\+0x68> e820 0000 	beqzc	at,0000006c <external_label\+0x6c>
			68: R_MICROMIPS_PC20_S1	external_label-0x4
	...
