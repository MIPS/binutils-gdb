#objdump: -dr
#name: nanoMIPS64 instructions

# Check nanoMIPS64 instruction assembly

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <text_label>:
   0:	c022 4b3c 	dclo	at,t4
   4:	c064 5b3c 	dclz	t5,a0
   8:	8043 f820 	dext	t4,t5,0,1
   c:	8043 ffe0 	dext	t4,t5,0,32
  10:	8043 f800 	dext	t4,t5,0,33
  14:	8043 ffc0 	dext	t4,t5,0,64
  18:	8043 f83f 	dext	t4,t5,31,1
  1c:	8043 ffff 	dext	t4,t5,31,32
  20:	8043 f81f 	dext	t4,t5,31,33
  24:	8043 f020 	dext	t4,t5,32,1
  28:	8043 f7e0 	dext	t4,t5,32,32
  2c:	8043 f03f 	dext	t4,t5,63,1
  30:	8043 faca 	dext	t4,t5,10,44
  34:	8043 f2ea 	dext	t4,t5,42,12
  38:	8043 e820 	dins	t4,t5,0,1
  3c:	8043 efe0 	dins	t4,t5,0,32
  40:	8043 e800 	dins	t4,t5,0,33
  44:	8043 efc0 	dins	t4,t5,0,64
  48:	8043 efff 	dins	t4,t5,31,1
  4c:	8043 e81f 	dins	t4,t5,31,2
  50:	8043 efdf 	dins	t4,t5,31,33
  54:	8043 e020 	dins	t4,t5,32,1
  58:	8043 e7e0 	dins	t4,t5,32,32
  5c:	8043 e7ff 	dins	t4,t5,63,1
  60:	8043 ed4a 	dins	t4,t5,10,44
  64:	8043 e56a 	dins	t4,t5,42,12
  68:	c0e7 7b3c 	dsbh	a3,a3
  6c:	c10a 7b3c 	dsbh	a4,a6
  70:	c0e7 fb3c 	dshd	a3,a3
  74:	c10a fb3c 	dshd	a4,a6
  78:	832a c1fc 	drotr32	t9,a6,28
  7c:	832a c1c4 	drotr	t9,a6,4
  80:	832a c1dc 	drotr	t9,a6,28
  84:	c080 c9d0 	dnegu	t9,a0
  88:	c32a c8d0 	drotrv	t9,a6,t9
  8c:	832a c1e4 	drotr32	t9,a6,4
  90:	c08a c8d0 	drotrv	t9,a6,a0
  94:	c0a0 09d0 	dnegu	at,a1
  98:	c024 20d0 	drotrv	a0,a0,at
  9c:	c0c0 21d0 	dnegu	a0,a2
  a0:	c085 20d0 	drotrv	a0,a1,a0
  a4:	8084 c1ff 	drotr32	a0,a0,31
  a8:	8085 c1c0 	drotr	a0,a1,0
  ac:	8085 c1ff 	drotr32	a0,a1,31
  b0:	8085 c1e1 	drotr32	a0,a1,1
  b4:	8085 c1e0 	drotr32	a0,a1,0
  b8:	8085 c1df 	drotr	a0,a1,31
  bc:	8085 c1c1 	drotr	a0,a1,1
  c0:	8085 c1c0 	drotr	a0,a1,0
  c4:	8084 c1c1 	drotr	a0,a0,1
  c8:	8085 c1c0 	drotr	a0,a1,0
  cc:	8085 c1c1 	drotr	a0,a1,1
  d0:	8085 c1df 	drotr	a0,a1,31
  d4:	8085 c1ff 	drotr32	a0,a1,31
  d8:	8085 c1e1 	drotr32	a0,a1,1
  dc:	8085 c1e0 	drotr32	a0,a1,0
  e0:	8085 c1df 	drotr	a0,a1,31
  e4:	8085 c1c1 	drotr	a0,a1,1
  e8:	2064 6d3f 	dmfc2	t5,\$4
  ec:	20c7 7d3f 	dmtc2	a2,\$7
