#objdump: -dr --no-show-raw-insn
#name: nanoMIPS LI float 64-bit sysVr4 PIC mode
#as: -KPIC
#source: lifloat.s

# Test loading immediate floating point values in PIC (nanoMIPS64)

.*: +file format .*nanomips.*

Disassembly of section \.text:

0000000000000000 <foo>:
   0:	dlui	a0,0x3ff1f9a7
   6:	daddiu	a0,a0,-1257566424
   c:	ld	at,0\(gp\)
			c: R_NANOMIPS_GOT_PAGE	\.rodata
  10:	ldc1	\$f4,0\(at\)
			10: R_NANOMIPS_GOT_OFST	\.rodata
  14:	li	a0,0x3f8fcd36
  1a:	li	at,0x3f8fcd36
  20:	mtc1	at,\$f4
