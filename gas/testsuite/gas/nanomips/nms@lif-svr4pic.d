#objdump: -dr --no-show-raw-insn
#name: LI float nanoMIPS subset sysVr4 PIC mode
#as: -mpic
#source: lifloat.s

# Test loading immediate floating point values in PIC (nanoMIPS subset)

.*: +file format .*nanomips.*

Disassembly of section \.text:

[0-9a-f]+ <foo>:
   0:	lw	at,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_PAGE	\.rodata
   4:	lw	a0,0\(at\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	\.rodata
   8:	lw	a1,0\(at\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	\.rodata\+0x4
   c:	aluipc	at,8 <L0>
			[0-9a-f]+: R_NANOMIPS_PCHI20	L0
  10:	ldc1	\$f4,0\(at\)
			[0-9a-f]+: R_NANOMIPS_LO12	\.rodata\+0x8
  14:	lui	a0,%hi\(0x3f8fc000\)
  18:	ori	a0,a0,0xd36
  1c:	lui	at,%hi\(0x3f8fc000\)
  20:	ori	at,at,0xd36
  24:	mtc1	at,\$f4
