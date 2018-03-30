#objdump: -dr --no-show-raw-insn
#name: LI float nanoMIPS subset
#source: lifloat.s

# Test loading immediate floating point values (nanoMIPS subset)

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <foo>:
   0:	lui	at,0x0
			0: R_NANOMIPS_HI20	\.rodata
   4:	lw	a0,0\(at\)
			4: R_NANOMIPS_LO12	\.rodata
   8:	lw	a1,0\(at\)
			8: R_NANOMIPS_LO12	\.rodata\+0x4
   c:	ldc1	\$f4,0\(gp\)
			c: R_NANOMIPS_GPREL16_S2	\.sdata
  10:	lui	a0,%hi\(0x3f8fc000\)
  14:	ori	a0,a0,0xd36
  18:	lui	at,%hi\(0x3f8fc000\)
  1c:	ori	at,at,0xd36
  20:	mtc1	at,\$f4
#pass
