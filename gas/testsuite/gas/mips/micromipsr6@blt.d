#objdump: -dr --prefix-addresses
#name: MIPS blt (micromips-r6)
#source: blt.s
#as: -32

# Test the blt macro.

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> slt	at,a0,a1
[0-9a-f]+ <[^>]*> bnezc	at,00000004 <.*>
[	]*4: R_MICROMIPS_PC21_S1	text_label
[0-9a-f]+ <[^>]*> bltzc	a0,00000008 <.*>
[	]*8: R_MICROMIPS_PC16_S1	text_label
[0-9a-f]+ <[^>]*> bgtzc	a1,0000000c <.*>
[	]*c: R_MICROMIPS_PC16_S1	text_label
[0-9a-f]+ <[^>]*> bltzc	a0,00000010 <.*>
[	]*10: R_MICROMIPS_PC16_S1	text_label
[0-9a-f]+ <[^>]*> blezc	a0,00000014 <.*>
[	]*14: R_MICROMIPS_PC16_S1	text_label
[0-9a-f]+ <[^>]*> slti	at,a0,2
[0-9a-f]+ <[^>]*> bnezc	at,0000001c <.*>
[	]*1c: R_MICROMIPS_PC21_S1	text_label
[0-9a-f]+ <[^>]*> li	at,0x8000
[0-9a-f]+ <[^>]*> slt	at,a0,at
[0-9a-f]+ <[^>]*> bnezc	at,00000028 <.*>
[	]*28: R_MICROMIPS_PC21_S1	text_label
[0-9a-f]+ <[^>]*> slti	at,a0,-32768
[0-9a-f]+ <[^>]*> bnezc	at,00000030 <.*>
[	]*30: R_MICROMIPS_PC21_S1	text_label
[0-9a-f]+ <[^>]*> lui	at,0x1
[0-9a-f]+ <[^>]*> slt	at,a0,at
[0-9a-f]+ <[^>]*> bnezc	at,0000003c <.*>
[	]*3c: R_MICROMIPS_PC21_S1	text_label
[0-9a-f]+ <[^>]*> lui	at,0x1
[0-9a-f]+ <[^>]*> ori	at,at,0xa5a5
[0-9a-f]+ <[^>]*> slt	at,a0,at
[0-9a-f]+ <[^>]*> bnezc	at,0000004c <.*>
[	]*4c: R_MICROMIPS_PC21_S1	text_label
[0-9a-f]+ <[^>]*> slt	at,a1,a0
[0-9a-f]+ <[^>]*> beqzc	at,00000054 <.*>
[	]*54: R_MICROMIPS_PC21_S1	text_label
[0-9a-f]+ <[^>]*> blezc	a0,00000058 <.*>
[	]*58: R_MICROMIPS_PC16_S1	text_label
[0-9a-f]+ <[^>]*> bgezc	a1,0000005c <.*>
[	]*5c: R_MICROMIPS_PC16_S1	text_label
[0-9a-f]+ <[^>]*> blezc	a0,00000060 <.*>
[	]*60: R_MICROMIPS_PC16_S1	text_label
[0-9a-f]+ <[^>]*> slt	at,a0,a1
[0-9a-f]+ <[^>]*> bnezc	at,00000068 <.*>
[	]*68: R_MICROMIPS_PC21_S1	external_label
[0-9a-f]+ <[^>]*> slt	at,a1,a0
[0-9a-f]+ <[^>]*> beqzc	at,00000070 <.*>
[	]*70: R_MICROMIPS_PC21_S1	external_label
	\.\.\.
