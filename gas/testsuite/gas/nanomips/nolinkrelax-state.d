#objdump: -dr
#source: linkrelax-state.s
#name: State tracking with linker-relaxation disabled

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <foo>:
   0:	d201      	li	a0,1
   2:	9008      	nop
   4:	d201      	li	a0,1
   6:	1084      	move	a0,a0
   8:	9008      	nop
   a:	9008      	nop
