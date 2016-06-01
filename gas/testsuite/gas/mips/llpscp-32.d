#objdump: -dr
#as: -mips32r6 -meva
#name: Paired LL/SC for mips32r6
#source: llpscp-32.s

.*: +file format .*

Disassembly of section \.text:

00000000 <test>:
   0:	7c821876 	llwp	v0,v1,a0
   4:	7c821876 	llwp	v0,v1,a0
   8:	24821234 	addiu	v0,a0,4660
   c:	7c420076 	llwp	v0,zero,v0
  10:	24830000 	addiu	v1,a0,0
			10: R_MIPS_HI16	sync_mem
  14:	7c601876 	llwp	zero,v1,v1
  18:	24430000 	addiu	v1,v0,0
			18: R_MIPS_LO16	sync_mem
  1c:	7c621876 	llwp	v0,v1,v1
  20:	3c020123 	lui	v0,0x123
  24:	00431021 	addu	v0,v0,v1
  28:	24424567 	addiu	v0,v0,17767
  2c:	7c421876 	llwp	v0,v1,v0
  30:	3c010000 	lui	at,0x0
			30: R_MIPS_HI16	sync_mem
  34:	24210000 	addiu	at,at,0
			34: R_MIPS_LO16	sync_mem
  38:	00240821 	addu	at,at,a0
  3c:	7c200076 	llwp	zero,zero,at
  40:	24021234 	li	v0,4660
  44:	7c42186e 	llwpe	v0,v1,v0
  48:	3c020001 	lui	v0,0x1
  4c:	2442abcd 	addiu	v0,v0,-21555
  50:	7c42006e 	llwpe	v0,zero,v0
  54:	24030000 	li	v1,0
			54: R_MIPS_LO16	sync_mem
  58:	7c60186e 	llwpe	zero,v1,v1
  5c:	3c020123 	lui	v0,0x123
  60:	24424567 	addiu	v0,v0,17767
  64:	7c42106e 	llwpe	v0,v0,v0
  68:	3c010000 	lui	at,0x0
			68: R_MIPS_HI16	sync_mem
  6c:	24210000 	addiu	at,at,0
			6c: R_MIPS_LO16	sync_mem
  70:	7c20006e 	llwpe	zero,zero,at
  74:	7c821866 	scwp	v0,v1,a0
  78:	7c821866 	scwp	v0,v1,a0
  7c:	24811234 	addiu	at,a0,4660
  80:	7c220066 	scwp	v0,zero,at
  84:	24810000 	addiu	at,a0,0
			84: R_MIPS_HI16	sync_mem
  88:	7c201866 	scwp	zero,v1,at
  8c:	24410000 	addiu	at,v0,0
			8c: R_MIPS_LO16	sync_mem
  90:	7c221866 	scwp	v0,v1,at
  94:	3c010123 	lui	at,0x123
  98:	00230821 	addu	at,at,v1
  9c:	24214567 	addiu	at,at,17767
  a0:	7c221866 	scwp	v0,v1,at
  a4:	3c010000 	lui	at,0x0
			a4: R_MIPS_HI16	sync_mem
  a8:	24210000 	addiu	at,at,0
			a8: R_MIPS_LO16	sync_mem
  ac:	00240821 	addu	at,at,a0
  b0:	7c200066 	scwp	zero,zero,at
  b4:	24011234 	li	at,4660
  b8:	7c22185e 	scwpe	v0,v1,at
  bc:	3c010001 	lui	at,0x1
  c0:	2421abcd 	addiu	at,at,-21555
  c4:	7c22005e 	scwpe	v0,zero,at
  c8:	24010000 	li	at,0
			c8: R_MIPS_LO16	sync_mem
  cc:	7c20185e 	scwpe	zero,v1,at
  d0:	3c010123 	lui	at,0x123
  d4:	24214567 	addiu	at,at,17767
  d8:	7c22105e 	scwpe	v0,v0,at
  dc:	3c010000 	lui	at,0x0
			dc: R_MIPS_HI16	sync_mem
  e0:	24210000 	addiu	at,at,0
			e0: R_MIPS_LO16	sync_mem
  e4:	7c20005e 	scwpe	zero,zero,at
	...
