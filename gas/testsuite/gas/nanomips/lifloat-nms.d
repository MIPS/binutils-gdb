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
			c: R_NANOMIPS_LITERAL	\.lit8
  10:	lui	a0,%hi\(0x3f8fc000\)
  14:	ori	a0,a0,0xd36
  18:	lwc1	\$f4,0\(gp\)
			18: R_NANOMIPS_LITERAL	\.lit4
