#objdump: -dr --no-show-raw-insn
#name: mixed mode relocation to microMIPS .insn
#as: -32 -mmicromips

.*: +file format .*mips.*

Disassembly of section \.text:

00000000 <test1>:
   0:	nop
   2:	nop

00000004 <test3>:
   4:	lui	v1,0x0
			4: R_MIPS_HI16	\.text
   8:	addiu	v1,v1,2
			8: R_MIPS_LO16	test1
	\.\.\.
#pass