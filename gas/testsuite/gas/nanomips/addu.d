#objdump: -dr --no-show-raw-insn
#name: nanoMIPS addu
#source: addu.s
#as:

# Test the add macro for nanoMIPS

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <foo>:
   0:	addiu	a0,a0,0
   4:	addiu	a0,a0,1
   8:	addiu	a0,a0,32768
   c:	lui	at,%hi\(0xffff8000\)
  10:	addu	a0,a0,at
  14:	lui	at,%hi\(0x10000\)
  18:	addu	a0,a0,at
  1c:	lui	at,%hi\(0x1a000\)
  20:	ori	at,at,0x5a5
  24:	addu	a0,a0,at
#pass
