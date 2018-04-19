#objdump: -dr --no-show-raw-insn
#name: nanoMIPS LI float big endian
#as: -EB
#source: lifloat.s

# Test loading immediate floating point values (nanoMIPS)

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <foo>:
   0:	li	a0,0x3ff1f9a6
   6:	li	a1,0xb50b0f28
   c:	li	a0,0x3f8fcd36
#pass
