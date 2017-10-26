#objdump: -d --show-raw-insn
#name: MIPS microMIPS Global INValidate instructions
#as: -mginv
#source: ginv.s

# Check microMIPS Global INValidate instructions

.*: +file format .*mips.*


Disassembly of section .text:
00000000 <test>:
   0:	0002 617c 	ginvi	v0
   4:	0003 717c 	ginvt	v1,0x0
   8:	0004 737c 	ginvt	a0,0x1
	\.\.\.
