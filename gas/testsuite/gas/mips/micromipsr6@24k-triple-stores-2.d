#objdump: -dr
#as: -mfix-24k -32
#name: 24K: Triple Store (Range Check)
#source: 24k-triple-stores-2.s

.*: +file format .*mips.*

Disassembly of section \.text:

[0-9a-f]+ <.*>:
 *[0-9a-f]+:	185d 0000 	sb	v0,0\(sp\)
 *[0-9a-f]+:	187d 000a 	sb	v1,10\(sp\)
 *[0-9a-f]+:	189d 001f 	sb	a0,31\(sp\)
 *[0-9a-f]+:	441b      	break
 *[0-9a-f]+:	385d 0000 	sh	v0,0\(sp\)
 *[0-9a-f]+:	387d fff0 	sh	v1,-16\(sp\)
 *[0-9a-f]+:	389d ffe0 	sh	a0,-32\(sp\)
 *[0-9a-f]+:	441b      	break
 *[0-9a-f]+:	c840      	sw	v0,0\(sp\)
 *[0-9a-f]+:	f87d fff8 	sw	v1,-8\(sp\)
 *[0-9a-f]+:	c882      	sw	a0,8\(sp\)
 *[0-9a-f]+:	441b      	break
 *[0-9a-f]+:	0c00      	nop
	\.\.\.
