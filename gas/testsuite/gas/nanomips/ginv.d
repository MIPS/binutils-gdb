#objdump: -d --show-raw-insn
#name: nanoMIPS Global INValidate instructions
#as: -mginv

# Check nanoMIPS Global INValidate instructions

.*: +file format .*nanomips.*

Disassembly of section \.text:
00000000 <test>:
   0:	2002 1f7f 	ginvi	t4
   4:	2003 0f7f 	ginvt	t5,0
   8:	2024 0f7f 	ginvt	a0,1
	\.\.\.
