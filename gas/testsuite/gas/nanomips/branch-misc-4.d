#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS branch-misc-4

# Verify PC-relative relocations do not overflow.

.*: +file format .*nanomips.*

Disassembly of section \.text:
	\.\.\.
[0-9a-f]+ <foo> 2800 0000 	bc	00000000 <bar>
			40000: R_NANOMIPS_PC25_S1	bar
[0-9a-f]+ <\.Lfoo> 2800 0000 	bc	00000004 <\.Lbar>
			40004: R_NANOMIPS_PC25_S1	\.Lbar
#...
Disassembly of section \.init:
0+0000 <bar> 2800 0000 	bc	00040000 <foo>
			0: R_NANOMIPS_PC25_S1	foo
0+0004 <\.Lbar> 2800 0000 	bc	00040004 <\.Lfoo>
			4: R_NANOMIPS_PC25_S1	\.Lfoo
#pass
