#name: nanoMIPS relax ADDIU
#objdump: -dr

# Test ADDIU relaxation on nanoMIPS

.*: +file format .*mips.*

Disassembly of section \.text:

00000000 <foo>:
   0:	9008      	nop
   2:	9008      	nop
   4:	8000 c000 	nop
	\.\.\.
  1c:	9008      	nop
  1e:	93ef      	addiu	ra,ra,7
  20:	9058      	addiu	v0,v0,-8
  22:	9252      	addiu	a0,a1,8
  24:	9257      	addiu	a0,a1,28
  26:	03e2 0007 	addiu	ra,v0,7
  2a:	8043 8008 	addiu	v0,v1,-8
  2e:	0088 0008 	addiu	a0,t0,8
  32:	0082 001c 	addiu	a0,v0,28
  36:	03ff 0008 	addiu	ra,ra,8
  3a:	8042 800c 	addiu	v0,v0,-12
  3e:	8085 8008 	addiu	a0,a1,-8
  42:	0085 001e 	addiu	a0,a1,30
  46:	0085 0006 	addiu	a0,a1,6
  4a:	93ef      	addiu	ra,ra,7
  4c:	9058      	addiu	v0,v0,-8
  4e:	9252      	addiu	a0,a1,8
  50:	9257      	addiu	a0,a1,28
  52:	03e2 0007 	addiu	ra,v0,7
  56:	8043 8008 	addiu	v0,v1,-8
  5a:	0088 0008 	addiu	a0,t0,8
  5e:	0082 001c 	addiu	a0,v0,28
  62:	03ff 0008 	addiu	ra,ra,8
  66:	8042 800c 	addiu	v0,v0,-12
  6a:	8085 8008 	addiu	a0,a1,-8
  6e:	0085 001e 	addiu	a0,a1,30
  72:	0085 0006 	addiu	a0,a1,6
  76:	9008      	nop
  78:	9008      	nop
  7a:	8000 c000 	nop
	\.\.\.
  92:	9008      	nop
  94:	9008      	nop
	\.\.\.
  9e:	9008      	nop
