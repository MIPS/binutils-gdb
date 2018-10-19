#objdump: -pdr --prefix-addresses --show-raw-insn
#name: MIPS GINV Virtualization
#as: --defsym VX= -mginv -mvirt -32
#source: ginv.s

# Test GINV+VZ instructions.

.*: +file format .*mips.*
#...
ASEs:
#...
	VZ ASE
	GINV ASE
#...

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> 7c40003d 	ginvi	v0
[0-9a-f]+ <[^>]*> 7c6000bd 	ginvt	v1,0x0
[0-9a-f]+ <[^>]*> 7c8001bd 	ginvt	a0,0x1
[0-9a-f]+ <[^>]*> 7c8002fd 	ginvgt	a0,0x2
[0-9a-f]+ <[^>]*> 7ca003fd 	ginvgt	a1,0x3
	\.\.\.
