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
   c:	lwpc	a0,8 <L0>
			e: R_NANOMIPS_PC_I32	L0
#pass
