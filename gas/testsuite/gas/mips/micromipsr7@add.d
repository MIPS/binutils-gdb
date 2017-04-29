#objdump: -dr --no-show-raw-insn
#name: MIPS32R7 add
#source: add.s
#as: -32

# Test the add macro for R7

.*: +file format .*mips.*

Disassembly of section \.text:

00000000 <foo>:
   0:	addiu	a0,a0,0
   4:	li	at,1
   8:	add	a0,a0,at
   c:	li	at,32768
  10:	add	a0,a0,at
  14:	lui	at,0xffff8
  18:	add	a0,a0,at
  1c:	lui	at,0x10
  20:	add	a0,a0,at
  24:	li	at,0x1a5a5
  2a:	add	a0,a0,at
  2e:	addiu	a0,a0,1
  32:	nop
	\.\.\.
