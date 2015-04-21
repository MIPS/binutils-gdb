#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS branch-misc-2pic
#source: branch-misc-2.s
#as: -32 -call_shared

# Test the backward branches to global symbols in current file (microMIPS).

.*: +file format .*mips.*

Disassembly of section \.text:
	\.\.\.
	\.\.\.
	\.\.\.
[0-9a-f]+ <[^>]*> b7ff fffe 	balc	0+003c <x>
			3c: R_MICROMIPS_PC26_S1	g1
[0-9a-f]+ <[^>]*> b7ff fffe 	balc	0+0040 <x\+0x4>
			40: R_MICROMIPS_PC26_S1	g2
[0-9a-f]+ <[^>]*> b7ff fffe 	balc	0+0044 <x\+0x8>
			44: R_MICROMIPS_PC26_S1	g3
[0-9a-f]+ <[^>]*> b7ff fffe 	balc	0+0048 <x\+0xc>
			48: R_MICROMIPS_PC26_S1	g4
[0-9a-f]+ <[^>]*> b7ff fffe 	balc	0+004c <x\+0x10>
			4c: R_MICROMIPS_PC26_S1	g5
[0-9a-f]+ <[^>]*> b7ff fffe 	balc	0+0050 <x\+0x14>
			50: R_MICROMIPS_PC26_S1	g6
	\.\.\.
	\.\.\.
	\.\.\.
	\.\.\.
