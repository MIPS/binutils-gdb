#objdump: -dr --no-show-raw-insn
#name: nanoMIPS LI float sysVr4 PIC big endian mode
#as: -mpic -EB
#source: lifloat.s

# Test loading immediate floating point values in PIC (nanoMIPS)

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <foo>:
   0:	li	a0,0x3ff1f9a6
   6:	li	a1,0xb50b0f28
   c:	aluipc	at,0 <L0>
			c: R_NANOMIPS_PCHI20	L0
  10:	ldc1	\$f4,0\(at\)
			10: R_NANOMIPS_LO12	.rodata
  14:	li	a0,0x3f8fcd36
  1a:	li	at,0x3f8fcd36
  20:	mtc1	at,\$f4
#pass
