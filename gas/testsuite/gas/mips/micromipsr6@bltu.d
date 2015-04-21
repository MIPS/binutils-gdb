#objdump: -dr --prefix-addresses
#name: MIPS bltu (micromips-r6)
#source: bltu.s
#as: -32

# Test the bltu macro.

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> sltu	at,a0,a1
[0-9a-f]+ <[^>]*> bnezc	at,00000004 <.*>
[	]*4: R_MICROMIPS_PC21_S1	text_label
[0-9a-f]+ <[^>]*> beqzc	a0,00000008 <.*>
[	]*8: R_MICROMIPS_PC21_S1	text_label
[0-9a-f]+ <[^>]*> sltiu	at,a0,2
[0-9a-f]+ <[^>]*> bnezc	at,00000010 <.*>
[	]*10: R_MICROMIPS_PC21_S1	text_label
[0-9a-f]+ <[^>]*> li	at,0x8000
[0-9a-f]+ <[^>]*> sltu	at,a0,at
[0-9a-f]+ <[^>]*> bnezc	at,0000001c <.*>
[	]*1c: R_MICROMIPS_PC21_S1	text_label
[0-9a-f]+ <[^>]*> sltiu	at,a0,-32768
[0-9a-f]+ <[^>]*> bnezc	at,00000024 <.*>
[	]*24: R_MICROMIPS_PC21_S1	text_label
[0-9a-f]+ <[^>]*> lui	at,0x1
[0-9a-f]+ <[^>]*> sltu	at,a0,at
[0-9a-f]+ <[^>]*> bnezc	at,00000030 <.*>
[	]*30: R_MICROMIPS_PC21_S1	text_label
[0-9a-f]+ <[^>]*> lui	at,0x1
[0-9a-f]+ <[^>]*> ori	at,at,0xa5a5
[0-9a-f]+ <[^>]*> sltu	at,a0,at
[0-9a-f]+ <[^>]*> bnezc	at,00000040 <.*>
[	]*40: R_MICROMIPS_PC21_S1	text_label
[0-9a-f]+ <[^>]*> sltu	at,a1,a0
[0-9a-f]+ <[^>]*> beqzc	at,00000048 <.*>
[	]*48: R_MICROMIPS_PC21_S1	text_label
[0-9a-f]+ <[^>]*> beqzc	a0,0000004c <.*>
[	]*4c: R_MICROMIPS_PC21_S1	text_label
[0-9a-f]+ <[^>]*> beqzc	a0,00000050 <.*>
[	]*50: R_MICROMIPS_PC21_S1	text_label
[0-9a-f]+ <[^>]*> sltu	at,a0,a1
[0-9a-f]+ <[^>]*> bnezc	at,00000058 <.*>
[	]*58: R_MICROMIPS_PC21_S1	external_label
[0-9a-f]+ <[^>]*> sltu	at,a1,a0
[0-9a-f]+ <[^>]*> beqzc	at,00000060 <.*>
[	]*60: R_MICROMIPS_PC21_S1	external_label
	\.\.\.
