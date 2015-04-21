#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS relaxed macro with branch swapping
#as: -32
#source: relax-swap3.s

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> 1040 0000 	lui	v0,0x0
[ 	]*[0-9a-f]+: R_MICROMIPS_HI16	bar
[0-9a-f]+ <[^>]*> 3042 0000 	addiu	v0,v0,0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	bar
[0-9a-f]+ <[^>]*> 4463      	jrc	v1
[0-9a-f]+ <[^>]*> 1040 0000 	lui	v0,0x0
[ 	]*[0-9a-f]+: R_MICROMIPS_HI16	bar
[0-9a-f]+ <[^>]*> 3042 0000 	addiu	v0,v0,0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	bar
[0-9a-f]+ <[^>]*> 8dff      	beqzc	v1,[0-9a-f]+ <[^>]*>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	.*
	\.\.\.
