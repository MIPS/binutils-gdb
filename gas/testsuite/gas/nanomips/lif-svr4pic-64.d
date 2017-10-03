#objdump: -dr --no-show-raw-insn
#name: nanoMIPS LI float 64-bit sysVr4 PIC mode
#as: -mpic
#source: lifloat.s

# Test loading immediate floating point values in PIC (nanoMIPS64)

.*: +file format .*nanomips.*

Disassembly of section \.text:

[0-9a-f]+ <foo>:
   0:	dlui	a0,0x3ff1f9a7
   6:	daddiu	a0,a0,-1257566424
   c:	lwpc	a0,0 <L0>
			[0-9a-f]+: R_NANOMIPS_PC_I32	L0
  12:	li	a0,0x3f8fcd36
  18:	li	at,0x3f8fcd36
  1e:	mtc1	at,\$f4
  22:	nop
