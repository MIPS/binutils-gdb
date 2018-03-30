#objdump: -dr
#name: nanoMIPS constant hi/lo

.*: +file format .*nanomips.*

Disassembly of section \.text:

0+0000 <foo>:
   0:	e08d bbd5 	lui	a0,%hi\(0xdeadb000\)
   4:	dbe0      	jrc	ra
   6:	8444 0eef 	lb	t4,3823\(a0\)
   a:	9008      	nop
#pass