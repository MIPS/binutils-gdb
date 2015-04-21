#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS ELF jal
#source: jal.s
#as: -32

# Test the jal macro (microMIPS).

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> 472b      	jalrc	t9
[0-9a-f]+ <[^>]*> 0099 0f3c 	jalrc	a0,t9
[0-9a-f]+ <[^>]*> b7ff fffe 	balc	0+0006 <text_label\+0x6>
			6: R_MICROMIPS_PC26_S1	text_label
[0-9a-f]+ <[^>]*> b7ff fffe 	balc	0+000a <text_label\+0xa>
			a: R_MICROMIPS_PC26_S1	external_text_label
[0-9a-f]+ <[^>]*> 97ff fffe 	bc	0+000e <text_label\+0xe>
			e: R_MICROMIPS_PC26_S1	text_label
[0-9a-f]+ <[^>]*> 97ff fffe 	bc	0+0012 <text_label\+0x12>
			12: R_MICROMIPS_PC26_S1	external_text_label
[0-9a-f]+ <[^>]*> 0c00      	nop
	\.\.\.
