#objdump: -Mginv -Mvirt -d --show-raw-insn
#name: nanoMIPS GINV+VIRT disassembly
#as: --defsym VX= -mginv -mvirt
#source: ginv.s

# Check nanoMIPS Global INValidate Virtualization disassembly

.*: +file format .*nanomips.*

Disassembly of section \.text:
00000000 <test>:
   0:	2002 1f7f 	ginvi	t4
   4:	2003 0f7f 	ginvt	t5,0
   8:	2024 0f7f 	ginvt	a0,1
   c:	2045 0d7f 	ginvgt	a1,2
  10:	2066 0d7f 	ginvgt	a2,3
	\.\.\.
