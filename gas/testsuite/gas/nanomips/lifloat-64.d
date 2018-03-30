#objdump: -dr --no-show-raw-insn
#name: nanoMIPS LI float 64-bit
#source: lifloat.s

# Test loading immediate floating point values (nanoMIPS64)

.*: +file format .*nanomips.*

Disassembly of section \.text:

0000000000000000 <foo>:
   0:	dlui	a0,0x3ff1f9a7
   6:	daddiu	a0,a0,-1257566424
   c:	ldc1	\$f4,0\(gp\)
			c: R_NANOMIPS_LITERAL	\.lit8
  10:	li	a0,0x3f8fcd36
  16:	lwc1	\$f4,0\(gp\)
			16: R_NANOMIPS_LITERAL	\.lit4
#pass
