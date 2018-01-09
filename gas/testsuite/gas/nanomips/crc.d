#objdump: -pdr
#name: nanoMIPS CRC
#as: -mcrc

# Test the CRC instructions

.*: +file format .*nanomips.*
#...
ASEs:
#...
	CRC ASE
#...

Disassembly of section \.text:

00000000 <test_crc>:
   0:	2087 03e8 	crc32b	a0,a3
   4:	2087 07e8 	crc32h	a0,a3
   8:	2087 0be8 	crc32w	a0,a3
   c:	2087 13e8 	crc32cb	a0,a3
  10:	2087 17e8 	crc32ch	a0,a3
  14:	2087 1be8 	crc32cw	a0,a3
	\.\.\.
