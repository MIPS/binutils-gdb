#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS ELF jal
#source: jal.s
#as: -mlegacyregs

# Test the jal macro (nanoMIPS).

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> db30      	jalrc	t9
0+0002 <text_label\+0x2> 4899 0000 	jalrc	a0,t9
0+0006 <text_label\+0x6> 2a00 0000 	balc	00000000 <text_label>
			6: R_NANOMIPS_PC25_S1	text_label
0+000a <text_label\+0xa> 2a00 0000 	balc	00000000 <external_text_label>
			a: R_NANOMIPS_PC25_S1	external_text_label
0+000e <text_label\+0xe> 2800 0000 	bc	00000000 <text_label>
			e: R_NANOMIPS_PC25_S1	text_label
0+0012 <text_label\+0x12> 2800 0000 	bc	00000000 <external_text_label>
			12: R_NANOMIPS_PC25_S1	external_text_label
0+0016 <text_label\+0x16> 9008      	nop
	\.\.\.
