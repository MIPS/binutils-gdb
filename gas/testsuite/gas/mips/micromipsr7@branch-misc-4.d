#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS R7 branch-misc-4
#as: -32

# Verify PC-relative relocations do not overflow.

.*: +file format .*mips.*

Disassembly of section \.text:
	\.\.\.
00040000 <foo> 2800 0000 	bc	00040004 <\.Lfoo>
			40000: R_MICROMIPS_PC25_S1	bar-0x4
00040004 <\.Lfoo> 2800 0000 	bc	0004000c <\.Lfoo\+0x8>
			40004: R_MICROMIPS_PC25_S1	\.Lbar-0x4
	\.\.\.

Disassembly of section \.init:
0+0000 <bar> 2800 0000 	bc	00040004 <\.Lfoo>
			0: R_MICROMIPS_PC25_S1	foo-0x4
0+0004 <\.Lbar> 2800 0000 	bc	0004000c <\.Lfoo\+0x8>
			4: R_MICROMIPS_PC25_S1	\.Lfoo-0x4
	\.\.\.
