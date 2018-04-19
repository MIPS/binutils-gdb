#objdump: -dr --no-show-raw-insn
#name: LI float nanoMIPS subset sysVr4 PIC mode w/o float construction
#as: -mpic --no-construct-floats
#source: lifloat.s

# Test loading immediate floating point values from memory in PIC (nanoMIPS subset)

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <foo>:
   0:	lw	at,0\(gp\)
			0: R_NANOMIPS_GOT_PAGE	.rodata
   4:	lw	a0,0\(at\)
			4: R_NANOMIPS_GOT_OFST	.rodata
   8:	lw	a1,0\(at\)
			8: R_NANOMIPS_GOT_OFST	.rodata\+0x4
   c:	aluipc	a0,8 <L0>
			c: R_NANOMIPS_PCHI20	L0
  10:	lw	a0,0\(a0\)
			10: R_NANOMIPS_LO12	.rodata\+0x8
#pass
