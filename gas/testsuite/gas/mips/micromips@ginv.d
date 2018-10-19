#objdump: -pdr --prefix-addresses --show-raw-insn
#name: microMIPSR6 Global INValidate instructions
#as: -mginv -32
#source: ginv.s

# Check microMIPS Global INValidate instructions

.*: +file format .*mips.*
#...
ASEs:
#...
	MICROMIPS ASE
	GINV ASE
#...

Disassembly of section .text:
[0-9a-f]+ <[^>]*> 0002 617c 	ginvi	v0
[0-9a-f]+ <[^>]*> 0003 717c 	ginvt	v1,0x0
[0-9a-f]+ <[^>]*> 0004 737c 	ginvt	a0,0x1
	\.\.\.
