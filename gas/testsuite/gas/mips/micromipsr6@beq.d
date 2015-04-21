#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS beq
#source: beq.s
#as: -32

# Test the beq macro (microMIPS).

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> 74a4 fffe 	beqc	a0,a1,0+0000 <text_label>
			0: R_MICROMIPS_PC16_S1	text_label
[0-9a-f]+ <[^>]*> 809f fffe 	beqzc	a0,0+0004 <text_label\+0x4>
			4: R_MICROMIPS_PC21_S1	text_label
[0-9a-f]+ <[^>]*> 3020 0001 	li	at,1
[0-9a-f]+ <[^>]*> 7481 fffe 	beqc	at,a0,0+00c <text_label\+0xc>
			c: R_MICROMIPS_PC16_S1	text_label
[0-9a-f]+ <[^>]*> 5020 8000 	li	at,0x8000
[0-9a-f]+ <[^>]*> 7481 fffe 	beqc	at,a0,0+0014 <text_label\+0x14>
			14: R_MICROMIPS_PC16_S1	text_label
[0-9a-f]+ <[^>]*> 3020 8000 	li	at,-32768
[0-9a-f]+ <[^>]*> 7481 fffe 	beqc	at,a0,0+001c <text_label\+0x1c>
			1c: R_MICROMIPS_PC16_S1	text_label
[0-9a-f]+ <[^>]*> 1020 0001 	lui	at,0x1
[0-9a-f]+ <[^>]*> 7481 fffe 	beqc	at,a0,0+0024 <text_label\+0x24>
			24: R_MICROMIPS_PC16_S1	text_label
[0-9a-f]+ <[^>]*> 1020 0001 	lui	at,0x1
[0-9a-f]+ <[^>]*> 5021 a5a5 	ori	at,at,0xa5a5
[0-9a-f]+ <[^>]*> 7481 fffe 	beqc	at,a0,0+0030 <text_label\+0x30>
			30: R_MICROMIPS_PC16_S1	text_label
[0-9a-f]+ <[^>]*> a09f fffe 	bnezc	a0,0+0034 <text_label\+0x34>
			34: R_MICROMIPS_PC21_S1	text_label
[0-9a-f]+ <[^>]*> 97ff fffe 	bc	00000038 <text_label\+0x38>
			38: R_MICROMIPS_PC26_S1	external_label
[0-9a-f]+ <[^>]*> b7ff fffe 	balc	0000003c <text_label\+0x3c>
			3c: R_MICROMIPS_PC26_S1	external_label
	\.\.\.
