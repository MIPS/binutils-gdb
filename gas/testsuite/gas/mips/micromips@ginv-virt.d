#objdump: -pdr --prefix-addresses --show-raw-insn
#name: microMIPSr6 Global INValidate Virtualization instructions
#as: --defsym VX= -mginv -mvirt -32
#source: ginv.s

# Check microMIPSR6 Global INValidate Virtualization instructions

.*: +file format .*mips.*

#...
ASEs:
#...
	VZ ASE
	MICROMIPS ASE
	GINV ASE
#...

Disassembly of section .text:
[0-9a-f]+ <[^>]*> 0002 617c 	ginvi	v0
[0-9a-f]+ <[^>]*> 0003 717c 	ginvt	v1,0x0
[0-9a-f]+ <[^>]*> 0004 737c 	ginvt	a0,0x1
[0-9a-f]+ <[^>]*> 0004 7d7c 	ginvgt	a0,0x2
[0-9a-f]+ <[^>]*> 0005 7f7c 	ginvgt	a1,0x3
	\.\.\.
