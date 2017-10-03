#objdump: -dr --show-raw-insn
#name: Expressions with volatile labels on nanoMIPS

.*\.o: +file format .*mips.*

Disassembly of section \.text:

[0-9a-f]+ <test>:
   0:	9008      	nop

[0-9a-f]+ <\$LVL2>:
   2:	90e9      	addiu	a3,a3,1

[0-9a-f]+ <\$LVL3>:
   4:	0200 00e8 	li	s0,232
   8:	dbe0      	jrc	ra
   a:	9008      	nop
