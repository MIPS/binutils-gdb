#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS R7 beq
#as: -32
#source: beq.s

# Test the beq macro on R7.

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> 88a4 0000 	beqc	a0,a1,00000004 <text_label\+0x4>
			0: R_MICROMIPS_PC14_S1	text_label-0x4
0+0004 <text_label\+0x4> e880 0000 	beqzc	a0,00000008 <text_label\+0x8>
			4: R_MICROMIPS_PC20_S1	text_label-0x4
0+0008 <text_label\+0x8> c880 0800 	beqic	a0,1,0000000c <text_label\+0xc>
			8: R_MICROMIPS_PC11_S1	text_label-0x4
0+000c <text_label\+0xc> e020 8000 	lui	at,0x8
0+0010 <text_label\+0x10> 8824 0000 	beqc	a0,at,00000014 <text_label\+0x14>
			10: R_MICROMIPS_PC14_S1	text_label-0x4
0+0014 <text_label\+0x14> e03f 8ffd 	lui	at,0xffff8
0+0018 <text_label\+0x18> 8824 0000 	beqc	a0,at,0000001c <text_label\+0x1c>
			18: R_MICROMIPS_PC14_S1	text_label-0x4
0+001c <text_label\+0x1c> e021 0000 	lui	at,0x10
0+0020 <text_label\+0x20> 8824 0000 	beqc	a0,at,00000024 <text_label\+0x24>
			20: R_MICROMIPS_PC14_S1	text_label-0x4
0+0024 <text_label\+0x24> e021 a000 	lui	at,0x1a
0+0028 <text_label\+0x28> 8021 05a5 	ori	at,at,1445
0+002c <text_label\+0x2c> 8824 0000 	beqc	a0,at,00000030 <text_label\+0x30>
			2c: R_MICROMIPS_PC14_S1	text_label-0x4
0+0030 <text_label\+0x30> e890 0000 	bnezc	a0,00000034 <text_label\+0x34>
			30: R_MICROMIPS_PC20_S1	text_label-0x4
	\.\.\.
[0-9a-f]+ <text_label\+0x20034> 2800 0000 	bc	00020038 <text_label\+0x20038>
			20034: R_MICROMIPS_PC25_S1	text_label-0x4
[0-9a-f]+ <text_label\+0x20038> 2a00 0000 	balc	0002003c <text_label\+0x2003c>
			20038: R_MICROMIPS_PC25_S1	text_label-0x4
	\.\.\.
