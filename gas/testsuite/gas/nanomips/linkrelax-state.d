#objdump: -dr
#as: --defsym relaxmode=1
#name: State tracking with .linkrelax directive

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <foo>:
   0:	d201      	li	a0,1
			0: R_NANOMIPS_NORELAX	\*ABS\*
   2:	9008      	nop
			2: R_NANOMIPS_RELAX	\*ABS\*
   4:	d201      	li	a0,1
   6:	1084      	move	a0,a0
			6: R_NANOMIPS_NORELAX	\*ABS\*
   8:	9008      	nop
			8: R_NANOMIPS_RELAX	\*ABS\*
#pass
