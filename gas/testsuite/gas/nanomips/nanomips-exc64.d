#objdump: -dr --prefix-addresses --show-raw-insn
#name: New nanoMIPS64 instructions

# Check exclusive nanoMIPS64 instructions

.*: +file format .*nanomips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> a445 4704 	ualdm	t4,4\(a1\),4
[0-9a-f]+ <[^>]+> a445 6f04 	uasdm	t4,4\(a1\),6
[0-9a-f]+ <[^>]+> a445 1704 	ualdm	t4,4\(a1\),1
[0-9a-f]+ <[^>]+> a445 1f04 	uasdm	t4,4\(a1\),1
[0-9a-f]+ <[^>]+> a445 0704 	ualdm	t4,4\(a1\),8
[0-9a-f]+ <[^>]+> a445 7f04 	uasdm	t4,4\(a1\),7
[0-9a-f]+ <[^>]+> a445 0604 	ldm	t4,4\(a1\),8
[0-9a-f]+ <[^>]+> a445 7e04 	sdm	t4,4\(a1\),7
[0-9a-f]+ <[^>]+> 60bb 0000 0000 	ldpc	a1,00002710 <\*ABS\*\+0x2710>
			22: R_NANOMIPS_PC_I32	\*ABS\*\+0x2710
[0-9a-f]+ <[^>]+> 611f 0000 0000 	sdpc	a4,00002710 <\*ABS\*\+0x2710>
			28: R_NANOMIPS_PC_I32	\*ABS\*\+0x2710
[0-9a-f]+ <[^>]+> 60bb 0000 0000 	ldpc	a1,00000000 <test>
			2e: R_NANOMIPS_PC_I32	test
[0-9a-f]+ <[^>]+> 611f 0000 0000 	sdpc	a4,00000000 <test>
			34: R_NANOMIPS_PC_I32	test
#pass
