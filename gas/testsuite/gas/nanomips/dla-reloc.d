#objdump: -dr
#name: DLA with relocation operators

.*file format.*

Disassembly of section \.text:

0+000000000000 <func>:
   0:	8080 a000 	daddiu	a0,zero,0
			0: R_NANOMIPS_LO12	foo
   4:	6094 0000 	dlui	a0,0x0
   8:	0000 
			6: R_NANOMIPS_HI32	foo
   a:	6091 0000 	daddiu	a0,a0,0
   e:	0000 
			c: R_NANOMIPS_I32	foo
  10:	8080 a765 	daddiu	a0,zero,1893
  14:	e094 8244 	lui	a0,%hi\(0x12348000\)
  18:	8085 a000 	daddiu	a0,a1,0
			18: R_NANOMIPS_LO12	foo
  1c:	6094 0000 	dlui	a0,0x0
  20:	0000 
			1e: R_NANOMIPS_HI32	foo
  22:	6091 0000 	daddiu	a0,a0,0
  26:	0000 
			24: R_NANOMIPS_I32	foo
  28:	c0a4 2150 	daddu	a0,a0,a1
  2c:	8085 a765 	daddiu	a0,a1,1893
  30:	e094 8244 	lui	a0,%hi\(0x12348000\)
  34:	c0a4 2150 	daddu	a0,a0,a1
  38:	8085 a000 	daddiu	a0,a1,0
			38: R_NANOMIPS_LO12	foo\+0x12348765
  3c:	6094 0000 	dlui	a0,0x0
  40:	0000 
			3e: R_NANOMIPS_HI32	foo\+0x12348765
  42:	6091 0000 	daddiu	a0,a0,0
  46:	0000 
			44: R_NANOMIPS_I32	foo\+0x12348765
  48:	c0a4 2150 	daddu	a0,a0,a1
  4c:	6094 0000 	dlui	a0,0x0
  50:	0000 
			4e: R_NANOMIPS_HI32	bar
  52:	6091 0000 	daddiu	a0,a0,0
  56:	0000 
			54: R_NANOMIPS_I32	bar
  58:	c0a4 2150 	daddu	a0,a0,a1
  5c:	6094 0000 	dlui	a0,0x0
  60:	0000 
			5e: R_NANOMIPS_HI32	bar
  62:	6091 0000 	daddiu	a0,a0,0
  66:	0000 
			64: R_NANOMIPS_I32	bar
  68:	c0a4 2150 	daddu	a0,a0,a1
