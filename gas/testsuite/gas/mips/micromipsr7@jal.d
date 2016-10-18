#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS R7 ELF jal
#source: jal.s
#as: -32

# Test the jal macro (microMIPS).

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> db30      	jalrc	t9
0+0002 <text_label\+0x2> 4899 0000 	jalrc	a0,t9
0+0006 <text_label\+0x6> 2a00 0000 	balc	0000000a <text_label\+0xa>
			6: R_MICROMIPS_PC25_S1	text_label-0x4
0+000a <text_label\+0xa> 2a00 0000 	balc	0000000e <external_text_label\+0xe>
			a: R_MICROMIPS_PC25_S1	external_text_label-0x4
0+000e <text_label\+0xe> 2800 0000 	bc	00000012 <text_label\+0x12>
			e: R_MICROMIPS_PC25_S1	text_label-0x4
0+0012 <text_label\+0x12> 2800 0000 	bc	00000016 <external_text_label\+0x16>
			12: R_MICROMIPS_PC25_S1	external_text_label-0x4
0+0016 <text_label\+0x16> 9008      	nop
	\.\.\.
