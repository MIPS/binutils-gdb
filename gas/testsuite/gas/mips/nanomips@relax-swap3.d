#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS relaxed macro with branch swapping
#as: -p32 -mno-xlp
#source: relax-swap3.s

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> e040 0000 	lui	v0,0x0
[	]*[0-9a-f]+: R_NANOMIPS_HI20	bar
[0-9a-f]+ <[^>]*> 0042 0000 	addiu	v0,v0,0
[	]*[0-9a-f]+: R_NANOMIPS_LO12	bar
[0-9a-f]+ <[^>]*> d860      	jrc	v1
[0-9a-f]+ <[^>]*> e040 0000 	lui	v0,0x0
[	]*[0-9a-f]+: R_NANOMIPS_HI20	bar
[0-9a-f]+ <[^>]*> 0042 0000 	addiu	v0,v0,0
[	]*[0-9a-f]+: R_NANOMIPS_LO12	bar
[0-9a-f]+ <[^>]*> 8860 0000 	beqzc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_NANOMIPS_PC14_S1	.*
[0-9a-f]+ <[^>]*> 9008      	nop
	\.\.\.
