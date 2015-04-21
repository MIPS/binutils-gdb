#objdump: -dr
#as: -mips64r6 -mmicromips
#name: Paired LL/SC for micromips mips64r6
#source: llpscp-64.s

.*: +file format .*

Disassembly of section \.text:

00000000 <test>:
   0:	6044 5030 	lldp	v0,v1,a0
   4:	6044 5030 	lldp	v0,v1,a0
   8:	3044 1234 	addiu	v0,a0,4660
   c:	6042 5000 	lldp	v0,zero,v0
  10:	3064 0000 	addiu	v1,a0,0
			10: R_MICROMIPS_HI16	sync_mem
  14:	6003 5030 	lldp	zero,v1,v1
  18:	3062 0000 	addiu	v1,v0,0
			18: R_MICROMIPS_LO16	sync_mem
  1c:	6043 5030 	lldp	v0,v1,v1
  20:	1040 0123 	lui	v0,0x123
  24:	0062 1150 	addu	v0,v0,v1
  28:	3042 4567 	addiu	v0,v0,17767
  2c:	6042 5030 	lldp	v0,v1,v0
  30:	1020 0000 	lui	at,0x0
			30: R_MICROMIPS_HI16	sync_mem
  34:	3021 0000 	addiu	at,at,0
			34: R_MICROMIPS_LO16	sync_mem
  38:	0081 0950 	addu	at,at,a0
  3c:	6001 5000 	lldp	zero,zero,at
  40:	3040 1234 	li	v0,4660
  44:	6042 1030 	llwp	v0,v1,v0
  48:	1040 0001 	lui	v0,0x1
  4c:	3042 abcd 	addiu	v0,v0,-21555
  50:	6042 1000 	llwp	v0,zero,v0
  54:	3060 0000 	li	v1,0
			54: R_MICROMIPS_LO16	sync_mem
  58:	6003 1030 	llwp	zero,v1,v1
  5c:	1040 0123 	lui	v0,0x123
  60:	3042 4567 	addiu	v0,v0,17767
  64:	6042 1020 	llwp	v0,v0,v0
  68:	1020 0000 	lui	at,0x0
			68: R_MICROMIPS_HI16	sync_mem
  6c:	3021 0000 	addiu	at,at,0
			6c: R_MICROMIPS_LO16	sync_mem
  70:	6001 1000 	llwp	zero,zero,at
  74:	6044 d030 	scdp	v0,v1,a0
  78:	6044 d030 	scdp	v0,v1,a0
  7c:	3024 1234 	addiu	at,a0,4660
  80:	6041 d000 	scdp	v0,zero,at
  84:	3024 0000 	addiu	at,a0,0
			84: R_MICROMIPS_HI16	sync_mem
  88:	6001 d030 	scdp	zero,v1,at
  8c:	3022 0000 	addiu	at,v0,0
			8c: R_MICROMIPS_LO16	sync_mem
  90:	6041 d030 	scdp	v0,v1,at
  94:	1020 0123 	lui	at,0x123
  98:	0061 0950 	addu	at,at,v1
  9c:	3021 4567 	addiu	at,at,17767
  a0:	6041 d030 	scdp	v0,v1,at
  a4:	1020 0000 	lui	at,0x0
			a4: R_MICROMIPS_HI16	sync_mem
  a8:	3021 0000 	addiu	at,at,0
			a8: R_MICROMIPS_LO16	sync_mem
  ac:	0081 0950 	addu	at,at,a0
  b0:	6001 d000 	scdp	zero,zero,at
  b4:	3020 1234 	li	at,4660
  b8:	6041 9030 	scwp	v0,v1,at
  bc:	1020 0001 	lui	at,0x1
  c0:	3021 abcd 	addiu	at,at,-21555
  c4:	6041 9000 	scwp	v0,zero,at
  c8:	3020 0000 	li	at,0
			c8: R_MICROMIPS_LO16	sync_mem
  cc:	6001 9030 	scwp	zero,v1,at
  d0:	1020 0123 	lui	at,0x123
  d4:	3021 4567 	addiu	at,at,17767
  d8:	6041 9020 	scwp	v0,v0,at
  dc:	1020 0000 	lui	at,0x0
			dc: R_MICROMIPS_HI16	sync_mem
  e0:	3021 0000 	addiu	at,at,0
			e0: R_MICROMIPS_LO16	sync_mem
  e4:	6001 9000 	scwp	zero,zero,at
	...
