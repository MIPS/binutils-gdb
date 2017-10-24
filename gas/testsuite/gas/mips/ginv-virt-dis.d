#objdump: -mmips -Mginv -Mvirt -d --show-raw-insn
#name: MIPS GINV+VIRT disassembly
#as: --defsym VX=1 -mginv -mvirt
#source: ginv.s

# Check MIPS Global INValidate Virtualization disassembly

.*: +file format .*mips.*

Disassembly of section \.text:
00000000 <test>:
   0:	7c40003d 	ginvi	v0
   4:	7c6000bd 	ginvt	v1,0x0
   8:	7c8001bd 	ginvt	a0,0x1
   c:	7ca002fd 	ginvgt	a1,0x2
  10:	7cc003fd 	ginvgt	a2,0x3
	\.\.\.
