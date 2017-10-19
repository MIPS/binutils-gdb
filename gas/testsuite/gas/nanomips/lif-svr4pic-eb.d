#objdump: -dr --no-show-raw-insn
#name: nanoMIPS LI float sysVr4 PIC big endian mode
#as: -mpic -EB
#source: lifloat.s

# Test loading immediate floating point values in PIC (nanoMIPS)

.*: +file format .*nanomips.*

Disassembly of section \.text:

[0-9a-f]+ <foo>:
   0:	li	a0,0x3ff1f9a6
   6:	li	a1,0xb50b0f28
   c:	lwpc	a0,0 <L0>
			[0-9a-f]+: R_NANOMIPS_PC_I32	L0
  12:	li	a0,0x3f8fcd36
  18:	li	at,0x3f8fcd36
  1e:	mtc1	at,\$f4
  22:	nop
