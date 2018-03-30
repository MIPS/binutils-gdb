#objdump: -dr --no-show-raw-insn
#name: LI float sysVr4 PIC mode w/o float construction
#as: -mpic --no-construct-floats
#source: lifloat.s

# Test loading immediate floating point values in PIC

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <foo>:
   0:	lw	at,0\(gp\)
			0: R_NANOMIPS_GOT_PAGE	.rodata
   4:	lw	a0,0\(at\)
			4: R_NANOMIPS_GOT_OFST	.rodata
   8:	lw	a1,0\(at\)
			8: R_NANOMIPS_GOT_OFST	.rodata\+0x4
   c:	aluipc	at,8 <L0>
			c: R_NANOMIPS_PCHI20	L0
  10:	ldc1	\$f4,0\(at\)
			10: R_NANOMIPS_LO12	.rodata\+0x8
  14:	lwpc	a0,10 <L0>
			16: R_NANOMIPS_PC_I32	L0
  1a:	aluipc	at,14 <L0>
			1a: R_NANOMIPS_PCHI20	L0
  1e:	lwc1	\$f4,0\(at\)
			1e: R_NANOMIPS_LO12	.rodata\+0x14
#pass
