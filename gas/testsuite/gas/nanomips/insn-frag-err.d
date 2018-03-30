#objdump: -dr
#name: nanoMIPS instruction fragment in disassembly

# Test disassembler handling parts of a truncated instruction

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <test1>:
   0:	0x8000 \(expected 32 bits, got only 16\): Address 0x0+2 is out of bounds.


00000002 <test2>:
   2:	0x6000 \(expected 48 bits, got only 16\): Address 0x0+4 is out of bounds.


00000004 <test3>:
   4:	0x6000 \(expected 48 bits, got only 32\): Address 0x0+8 is out of bounds.
#pass
