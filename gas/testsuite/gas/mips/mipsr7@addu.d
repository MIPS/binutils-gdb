#objdump: -dr --no-show-raw-insn
#name: MIPSR7 add
#source: addu.s
#as: -mno-xlp

# Test the add macro for R7

.*: +file format .*mips.*

Disassembly of section \.text:

00000000 <foo>:
   0:	addiu	a0,a0,0
   4:	addiu	a0,a0,1
   8:	addiu	a0,a0,32768
   c:	lui	at,0xffff8
  10:	addu	a0,a0,at
  14:	lui	at,0x10
  18:	addu	a0,a0,at
  1c:	lui	at,0x1a
  20:	ori	at,at,1445
  24:	addu	a0,a0,at
	\.\.\.
