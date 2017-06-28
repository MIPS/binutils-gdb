#objdump: -dr --no-show-raw-insn
#name: LI float nanoMIPS subset sysVr4 PIC mode
#as: -KPIC
#source: lifloat.s

# Test loading immediate floating point values in PIC (nanoMIPS subset)

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <foo>:
   0:	lw	at,0\(gp\)
			0: R_NANOMIPS_GOT_DISP	\.rodata
   4:	lw	a0,0\(at\)
   8:	lw	a1,4\(at\)
   c:	lw	at,0\(gp\)
			c: R_NANOMIPS_GOT_PAGE	\.rodata\+0x8
  10:	ldc1	\$f4,0\(at\)
			10: R_NANOMIPS_GOT_OFST	\.rodata\+0x8
  14:	lui	a0,%hi\(0x3f8fc000\)
  18:	ori	a0,a0,3382
  1c:	lui	at,%hi\(0x3f8fc000\)
  20:	ori	at,at,3382
  24:	mtc1	at,\$f4
