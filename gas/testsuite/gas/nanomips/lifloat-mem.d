#objdump: -dr --no-show-raw-insn
#name: LI float without float construction
#source: lifloat.s
#as: --no-construct-floats

# Test loading immediate floating point values without float construction

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <foo>:
   0:	li	at,0x0
			2: R_NANOMIPS_I32	.rodata
   6:	lwm	a0,0\(at\),2
   a:	ldc1	\$f4,0\(gp\)
			a: R_NANOMIPS_GPREL16_S2	.sdata
   e:	lui	a0,0x0
			e: R_NANOMIPS_HI20	.rodata\+0x8
  12:	lw	a0,0\(a0\)
			12: R_NANOMIPS_LO12	.rodata\+0x8
  16:	lwc1	\$f4,0\(gp\)
			16: R_NANOMIPS_GPREL16_S2	.sdata\+0x8
#pass
