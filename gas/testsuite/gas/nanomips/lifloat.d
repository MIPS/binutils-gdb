#objdump: -dr --no-show-raw-insn
#name: nanoMIPS LI float

# Test loading immediate floating point values (nanoMIPS)

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <foo>:
   0:	li	a1,0x3ff1f9a6
   6:	li	a0,0xb50b0f28
   c:	ldc1	\$f4,0\(gp\)
			c: R_NANOMIPS_LITERAL	\.lit8
  10:	li	a0,0x3f8fcd36
  16:	lwc1	\$f4,0\(gp\)
			16: R_NANOMIPS_LITERAL	\.lit4
  1a:	nop
