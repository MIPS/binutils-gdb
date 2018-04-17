#objdump: -dr
#name: nanoMIPS64 instructions

# Check nanoMIPS64 instruction assembly

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <text_label>:
   [0-9a-f]+:	c022 4b3c 	dclo	at,t4
   [0-9a-f]+:	c064 5b3c 	dclz	t5,a0
   [0-9a-f]+:	8043 f820 	dext	t4,t5,0,1
   [0-9a-f]+:	8043 ffe0 	dext	t4,t5,0,32
  [0-9a-f]+:	8043 f800 	dext	t4,t5,0,33
  [0-9a-f]+:	8043 ffc0 	dext	t4,t5,0,64
  [0-9a-f]+:	8043 f83f 	dext	t4,t5,31,1
  [0-9a-f]+:	8043 ffff 	dext	t4,t5,31,32
  [0-9a-f]+:	8043 f81f 	dext	t4,t5,31,33
  [0-9a-f]+:	8043 f020 	dext	t4,t5,32,1
  [0-9a-f]+:	8043 f7e0 	dext	t4,t5,32,32
  [0-9a-f]+:	8043 f03f 	dext	t4,t5,63,1
  [0-9a-f]+:	8043 faca 	dext	t4,t5,10,44
  [0-9a-f]+:	8043 f2ea 	dext	t4,t5,42,12
  [0-9a-f]+:	8043 e820 	dins	t4,t5,0,1
  [0-9a-f]+:	8043 efe0 	dins	t4,t5,0,32
  [0-9a-f]+:	8043 e800 	dins	t4,t5,0,33
  [0-9a-f]+:	8043 efc0 	dins	t4,t5,0,64
  [0-9a-f]+:	8043 efff 	dins	t4,t5,31,1
  [0-9a-f]+:	8043 e81f 	dins	t4,t5,31,2
  [0-9a-f]+:	8043 efdf 	dins	t4,t5,31,33
  [0-9a-f]+:	8043 e020 	dins	t4,t5,32,1
  [0-9a-f]+:	8043 e7e0 	dins	t4,t5,32,32
  [0-9a-f]+:	8043 e7ff 	dins	t4,t5,63,1
  [0-9a-f]+:	8043 ed4a 	dins	t4,t5,10,44
  [0-9a-f]+:	8043 e56a 	dins	t4,t5,42,12
  [0-9a-f]+:	832a c1fc 	drotr32	t9,a6,28
  [0-9a-f]+:	832a c1c4 	drotr	t9,a6,4
  [0-9a-f]+:	832a c1dc 	drotr	t9,a6,28
  [0-9a-f]+:	c080 c9d0 	dnegu	t9,a0
  [0-9a-f]+:	c32a c8d0 	drotrv	t9,a6,t9
  [0-9a-f]+:	832a c1e4 	drotr32	t9,a6,4
  [0-9a-f]+:	c08a c8d0 	drotrv	t9,a6,a0
  [0-9a-f]+:	c0a0 09d0 	dnegu	at,a1
  [0-9a-f]+:	c024 20d0 	drotrv	a0,a0,at
  [0-9a-f]+:	c0c0 21d0 	dnegu	a0,a2
  [0-9a-f]+:	c085 20d0 	drotrv	a0,a1,a0
  [0-9a-f]+:	8084 c1ff 	drotr32	a0,a0,31
  [0-9a-f]+:	8085 c1c0 	drotr	a0,a1,0
  [0-9a-f]+:	8085 c1ff 	drotr32	a0,a1,31
  [0-9a-f]+:	8085 c1e1 	drotr32	a0,a1,1
  [0-9a-f]+:	8085 c1e0 	drotr32	a0,a1,0
  [0-9a-f]+:	8085 c1df 	drotr	a0,a1,31
  [0-9a-f]+:	8085 c1c1 	drotr	a0,a1,1
  [0-9a-f]+:	8085 c1c0 	drotr	a0,a1,0
  [0-9a-f]+:	8084 c1c1 	drotr	a0,a0,1
  [0-9a-f]+:	8085 c1c0 	drotr	a0,a1,0
  [0-9a-f]+:	8085 c1c1 	drotr	a0,a1,1
  [0-9a-f]+:	8085 c1df 	drotr	a0,a1,31
  [0-9a-f]+:	8085 c1ff 	drotr32	a0,a1,31
  [0-9a-f]+:	8085 c1e1 	drotr32	a0,a1,1
  [0-9a-f]+:	8085 c1e0 	drotr32	a0,a1,0
  [0-9a-f]+:	8085 c1df 	drotr	a0,a1,31
  [0-9a-f]+:	8085 c1c1 	drotr	a0,a1,1
  [0-9a-f]+:	2064 6d3f 	dmfc2	t5,\$4
  [0-9a-f]+:	20c7 7d3f 	dmtc2	a2,\$7
