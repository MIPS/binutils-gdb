#objdump: -dr --no-show-raw-insn -M gpr-names=32
#name: MIPS GPR disassembly (32)
#source: gpr-names.s

# Check objdump's handling of -M gpr-names=foo options.

.*: +file format .*mips.*

Disassembly of section .text:

00000000 <text_label>:
   0:	lui	zero,0x0
   4:	lui	at,0x0
   8:	lui	v0,0x0
   c:	lui	v1,0x0
  10:	lui	a0,0x0
  14:	lui	a1,0x0
  18:	lui	a2,0x0
  1c:	lui	a3,0x0
  20:	lui	t0,0x0
  24:	lui	t1,0x0
  28:	lui	t2,0x0
  2c:	lui	t3,0x0
  30:	lui	t4,0x0
  34:	lui	t5,0x0
  38:	lui	t6,0x0
  3c:	lui	t7,0x0
  40:	lui	s0,0x0
  44:	lui	s1,0x0
  48:	lui	s2,0x0
  4c:	lui	s3,0x0
  50:	lui	s4,0x0
  54:	lui	s5,0x0
  58:	lui	s6,0x0
  5c:	lui	s7,0x0
  60:	lui	t8,0x0
  64:	lui	t9,0x0
  68:	lui	k0,0x0
  6c:	lui	k1,0x0
  70:	lui	gp,0x0
  74:	lui	sp,0x0
  78:	lui	s8,0x0
  7c:	lui	ra,0x0
	...
