#objdump: -pdr --prefix-addresses --show-raw-insn
#name: MIPS CRC
#as: -mcrc

# Test the CRC instructions

.*: +file format .*mips.*
#...
ASEs:
#...
	CRC ASE
#...

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> 7ce400cf 	crc32d	a0,a3,a0
[0-9a-f]+ <[^>]*> 7ce401cf 	crc32cd	a0,a3,a0

	\.\.\.
