#objdump: -dr --no-show-raw-insn
#name: nanoMIPS add
#source: add.s

# Test the add macro for nanoMIPS

.*: +file format .*mips.*

Disassembly of section \.text:

00000000 <foo>:
   0:	addiu	a0,a0,0
   4:	li	at,1
   8:	add	a0,a0,at
   c:	li	at,32768
  10:	add	a0,a0,at
  14:	lui	at,%hi\(0xffff8000\)
  18:	add	a0,a0,at
  1c:	lui	at,%hi\(0x10000\)
  20:	add	a0,a0,at
  24:	li	at,0x1a5a5
  2a:	add	a0,a0,at
  2e:	addiu	a0,a0,1
  32:	nop
	\.\.\.
