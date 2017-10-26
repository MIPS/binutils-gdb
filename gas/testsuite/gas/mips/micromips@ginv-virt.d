#objdump: -d --show-raw-insn
#name: MIPS microMIPS Global INValidate Virtualization instructions
#as: --defsym VX= -mginv -mvirt
#source: ginv.s

# Check microMIPS Global INValidate Virtualization instructions

.*: +file format .*mips.*

Disassembly of section .text:
00000000 <test>:
   0:	0002 617c 	ginvi	v0
   4:	0003 717c 	ginvt	v1,0x0
   8:	0004 737c 	ginvt	a0,0x1
   c:	0005 7d7c 	ginvgt	a1,0x2
  10:	0006 7f7c 	ginvgt	a2,0x3
	\.\.\.
