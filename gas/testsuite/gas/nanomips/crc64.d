#objdump: -pdr
#name: nanoMIPS CRC64
#as: -mcrc

# Test the CRC64 instructions

.*: +file format .*nanomips.*
#...
ASEs:
#...
	CRC ASE
#...

Disassembly of section \.text:

00000000 <test_crc>:
   0:	2087 0fe8 	crc32d	a0,a3
   4:	2087 1fe8 	crc32cd	a0,a3
	\.\.\.
