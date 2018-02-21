#objdump: -dr --no-show-raw-insn
#name: nanoMIPS LI float 64-bit sysVr4 PIC mode
#as: -mpic
#source: lifloat.s

# Test loading immediate floating point values in PIC (nanoMIPS64)

.*: +file format .*nanomips.*

Disassembly of section \.text:

[0-9a-f]+ <foo>:
   0:	dlui	a0,0x3ff1f9a7
   6:	daddiu	a0,a0,-1257566424
   c:	aluipc	at,0 <L0>
			c: R_NANOMIPS_PCHI20	L0
  10:	ldc1	\$f4,0\(at\)
			10: R_NANOMIPS_LO12	.rodata
  14:	li	a0,0x3f8fcd36
  1a:	li	at,0x3f8fcd36
  20:	mtc1	at,\$f4
#pass
