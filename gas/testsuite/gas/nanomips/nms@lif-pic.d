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
   c:	lui	a0,%hi\(0x3f8fc000\)
  10:	ori	a0,a0,0xd36
#pass
