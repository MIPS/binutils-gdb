#as: -EB
#objdump: -dr
#source: align2.s

.* file format .*

Disassembly of section \.text:

00000000 <f1>:
   0:	9049      	addiu	t4,t4,1
   2:	9008      	nop
   4:	8000 c000 	nop
   8:	9069      	addiu	t5,t5,1
   a:	9008      	nop

0000000c <f2>:
   c:	9049      	addiu	t4,t4,1
   e:	9069      	addiu	t5,t5,1
  10:	9089      	addiu	a0,a0,1
  12:	9008      	nop
  14:	8000 c000 	nop

00000018 <f3>:
  18:	9209      	addiu	s0,s0,1
  1a:	9008      	nop
  1c:	8000 c000 	nop

Disassembly of section .text.a:

00000000 <f4>:
   0:	90a9      	addiu	a1,a1,1
   2:	9008      	nop
   4:	8000 c000 	nop
   8:	8000 c000 	nop
   c:	8000 c000 	nop
