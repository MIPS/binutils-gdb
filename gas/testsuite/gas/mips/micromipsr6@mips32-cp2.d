#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS MIPS32 cop2 instructions
#source: micromips@mips32-cp2.s
#as: -32

# Check MIPS32 cop2 instruction assembly (microMIPS).

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> 0022 cd3c 	cfc2	at,\$2
[0-9a-f]+ <[^>]*> 0009 1a2a 	cop2	0x12345
[0-9a-f]+ <[^>]*> 0043 dd3c 	ctc2	v0,\$3
[0-9a-f]+ <[^>]*> 0064 4d3c 	mfc2	v1,\$4
[0-9a-f]+ <[^>]*> 00c7 5d3c 	mtc2	a2,\$7
	\.\.\.
