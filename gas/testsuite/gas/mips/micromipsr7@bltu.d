#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS R7 bltu
#as: -32
#source: bltu.s

# Test the bltu macro.

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> a8a4 c000 	bltuc	a0,a1,00000004 <text_label\+0x4>
			0: R_MICROMIPS_PC14_S1	text_label-0x4
0+0004 <text_label\+0x4> e880 0000 	beqzc	a0,00000008 <text_label\+0x8>
			4: R_MICROMIPS_PC20_S1	text_label-0x4
0+0008 <text_label\+0x8> c89c 1000 	bltuic	a0,2,0000000c <text_label\+0xc>
			8: R_MICROMIPS_PC11_S1	text_label-0x4
0+000c <text_label\+0xc> e020 8000 	lui	at,0x8
0+0010 <text_label\+0x10> 2024 0b90 	sltu	at,a0,at
0+0014 <text_label\+0x14> e830 0000 	bnezc	at,00000018 <text_label\+0x18>
			14: R_MICROMIPS_PC20_S1	text_label-0x4
0+0018 <text_label\+0x18> e03f 8ffd 	lui	at,0xffff8
0+001c <text_label\+0x1c> 2024 0b90 	sltu	at,a0,at
0+0020 <text_label\+0x20> e830 0000 	bnezc	at,00000024 <text_label\+0x24>
			20: R_MICROMIPS_PC20_S1	text_label-0x4
0+0024 <text_label\+0x24> e021 0000 	lui	at,0x10
0+0028 <text_label\+0x28> 2024 0b90 	sltu	at,a0,at
0+002c <text_label\+0x2c> e830 0000 	bnezc	at,00000030 <text_label\+0x30>
			2c: R_MICROMIPS_PC20_S1	text_label-0x4
0+0030 <text_label\+0x30> e021 a000 	lui	at,0x1a
0+0034 <text_label\+0x34> 8021 05a5 	ori	at,at,1445
0+0038 <text_label\+0x38> 2024 0b90 	sltu	at,a0,at
0+003c <text_label\+0x3c> e830 0000 	bnezc	at,00000040 <text_label\+0x40>
			3c: R_MICROMIPS_PC20_S1	text_label-0x4
0+0040 <text_label\+0x40> 2085 0b90 	sltu	at,a1,a0
0+0044 <text_label\+0x44> e820 0000 	beqzc	at,00000048 <text_label\+0x48>
			44: R_MICROMIPS_PC20_S1	text_label-0x4
0+0048 <text_label\+0x48> e880 0000 	beqzc	a0,0000004c <text_label\+0x4c>
			48: R_MICROMIPS_PC20_S1	text_label-0x4
0+004c <text_label\+0x4c> e880 0000 	beqzc	a0,00000050 <text_label\+0x50>
			4c: R_MICROMIPS_PC20_S1	text_label-0x4
0+0050 <text_label\+0x50> a8a4 c000 	bltuc	a0,a1,00000054 <external_label\+0x54>
			50: R_MICROMIPS_PC14_S1	external_label-0x4
0+0054 <text_label\+0x54> 2085 0b90 	sltu	at,a1,a0
0+0058 <text_label\+0x58> e820 0000 	beqzc	at,0000005c <external_label\+0x5c>
			58: R_MICROMIPS_PC20_S1	external_label-0x4
	\.\.\.
