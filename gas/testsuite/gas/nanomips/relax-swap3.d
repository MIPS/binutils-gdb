#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS relaxed macro with branch swapping
#as: -mlegacyregs

.*: +file format .*nanomips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> e040 0002 	aluipc	t4,00000000 <bar>
[	]*[0-9a-f]+: R_NANOMIPS_PCHI20	bar
[0-9a-f]+ <[^>]*> 0042 0000 	addiu	t4,t4,0
[	]*[0-9a-f]+: R_NANOMIPS_LO12	bar
[0-9a-f]+ <[^>]*> d860      	jrc	t5
[0-9a-f]+ <[^>]*> e040 0002 	aluipc	t4,00000000 <bar>
[	]*[0-9a-f]+: R_NANOMIPS_PCHI20	bar
[0-9a-f]+ <[^>]*> 0042 0000 	addiu	t4,t4,0
[	]*[0-9a-f]+: R_NANOMIPS_LO12	bar
[0-9a-f]+ <[^>]*> 8860 0000 	beqzc	t5,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_NANOMIPS_PC14_S1	.*
[0-9a-f]+ <[^>]*> 9008      	nop
	\.\.\.
