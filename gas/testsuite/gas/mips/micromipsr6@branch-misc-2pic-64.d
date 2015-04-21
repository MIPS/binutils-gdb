#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS branch-misc-2pic-64
#source: branch-misc-2.s
#as: -64 -call_shared

# Test the backward branches to globalc symbols in current file (microMIPS).

.*: +file format .*mips.*

Disassembly of section \.text:
	\.\.\.
	\.\.\.
	\.\.\.
[0-9a-f]+ <[^>]*> b400 0000 	balc	0+0040 <x\+0x4>
			3c: R_MICROMIPS_PC26_S1	g1\-0x4
			3c: R_MIPS_NONE	\*ABS\*\-0x4
			3c: R_MIPS_NONE	\*ABS\*\-0x4
[0-9a-f]+ <[^>]*> b400 0000 	balc	0+0044 <x\+0x8>
			40: R_MICROMIPS_PC26_S1	g2\-0x4
			40: R_MIPS_NONE	\*ABS\*\-0x4
			40: R_MIPS_NONE	\*ABS\*\-0x4
[0-9a-f]+ <[^>]*> b400 0000 	balc	0+0048 <x\+0xc>
			44: R_MICROMIPS_PC26_S1	g3\-0x4
			44: R_MIPS_NONE	\*ABS\*\-0x4
			44: R_MIPS_NONE	\*ABS\*\-0x4
[0-9a-f]+ <[^>]*> b400 0000 	balc	0+004c <x\+0x10>
			48: R_MICROMIPS_PC26_S1	g4\-0x4
			48: R_MIPS_NONE	\*ABS\*\-0x4
			48: R_MIPS_NONE	\*ABS\*\-0x4
[0-9a-f]+ <[^>]*> b400 0000 	balc	0+0050 <x\+0x14>
			4c: R_MICROMIPS_PC26_S1	g5\-0x4
			4c: R_MIPS_NONE	\*ABS\*\-0x4
			4c: R_MIPS_NONE	\*ABS\*\-0x4
[0-9a-f]+ <[^>]*> b400 0000 	balc	0+0054 <x\+0x18>
			50: R_MICROMIPS_PC26_S1	g6\-0x4
			50: R_MIPS_NONE	\*ABS\*\-0x4
			50: R_MIPS_NONE	\*ABS\*\-0x4
	\.\.\.
	\.\.\.
	\.\.\.
	\.\.\.
