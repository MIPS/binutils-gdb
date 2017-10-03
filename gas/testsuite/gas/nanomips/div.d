#objdump: -dr --no-show-raw-insn -mnanomips:isa64r6
#name: nanoMIPS div

# Test the div macro.

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <foo>:
   0:	div	zero,a0,a1
   4:	div	a0,a0,a1
   8:	div	a0,a1,a2
   c:	move	a0,a0
   e:	move	a0,a1
  10:	neg	a0,a0
  14:	neg	a0,a1
  18:	li	at,2
  1c:	div	a0,a0,at
  20:	li	at,2
  24:	div	a0,a1,at
  28:	li	at,32768
  2c:	div	a0,a0,at
  30:	li	at,32768
  34:	div	a0,a1,at
  38:	lui	at,%hi\(0xffff8000\)
  3c:	div	a0,a0,at
  40:	lui	at,%hi\(0xffff8000\)
  44:	div	a0,a1,at
  48:	lui	at,%hi\(0x10000\)
  4c:	div	a0,a0,at
  50:	lui	at,%hi\(0x10000\)
  54:	div	a0,a1,at
  58:	li	at,0x1a5a5
  5e:	div	a0,a0,at
  62:	li	at,0x1a5a5
  68:	div	a0,a1,at
  6c:	divu	zero,a0,a1
  70:	divu	a0,a0,a1
  74:	divu	a0,a1,a2
  78:	move	a0,a0
  7a:	mod	a0,a1,a2
  7e:	li	at,2
  82:	modu	a0,a1,at
  86:	ddiv	a0,a1,a2
  8a:	li	at,2
  8e:	ddivu	a0,a1,at
  92:	li	at,32768
  96:	dmod	a0,a1,at
  9a:	lui	at,%hi\(0xffff8000\)
  9e:	dmodu	a0,a1,at
  a2:	nop
	\.\.\.
