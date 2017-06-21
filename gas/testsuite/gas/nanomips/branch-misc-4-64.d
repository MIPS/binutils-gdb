#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS branch-misc-4-64
#as: -m64
#source: branch-misc-4.s

# Verify PC-relative relocations do not overflow.

.*: +file format .*nanomips.*

Disassembly of section \.text:
	\.\.\.
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC25_S1	bar
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC25_S1	\.Lbar
	\.\.\.

Disassembly of section \.init:
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC25_S1	foo
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC25_S1	\.Lfoo
	\.\.\.
