#objdump: -dr
#as: -mfix-24k -32
#name: 24K: Triple Store (Double-word Check)
#source: 24k-triple-stores-3.s

.*: +file format .*mips.*

Disassembly of section \.text:

[0-9a-f]+ <.*>:
 *[0-9a-f]+:	185d 000b 	sb	v0,11\(sp\)
 *[0-9a-f]+:	187d 000b 	sb	v1,11\(sp\)
 *[0-9a-f]+:	189d 0004 	sb	a0,4\(sp\)
 *[0-9a-f]+:	441b      	break
 *[0-9a-f]+:	185d 0000 	sb	v0,0\(sp\)
 *[0-9a-f]+:	187d 000b 	sb	v1,11\(sp\)
 *[0-9a-f]+:	189d 0005 	sb	a0,5\(sp\)
 *[0-9a-f]+:	441b      	break
 *[0-9a-f]+:	185d 0007 	sb	v0,7\(sp\)
 *[0-9a-f]+:	187d 000b 	sb	v1,11\(sp\)
 *[0-9a-f]+:	189d 0010 	sb	a0,16\(sp\)
 *[0-9a-f]+:	441b      	break
 *[0-9a-f]+:	1848 0000 	sb	v0,0\(t0\)
 *[0-9a-f]+:	1868 0008 	sb	v1,8\(t0\)
 *[0-9a-f]+:	1888 0009 	sb	a0,9\(t0\)
 *[0-9a-f]+:	441b      	break
 *[0-9a-f]+:	385d 0000 	sh	v0,0\(sp\)
 *[0-9a-f]+:	387d ffe1 	sh	v1,-31\(sp\)
 *[0-9a-f]+:	389d ffe2 	sh	a0,-30\(sp\)
 *[0-9a-f]+:	441b      	break
 *[0-9a-f]+:	385d 0006 	sh	v0,6\(sp\)
 *[0-9a-f]+:	387d 0008 	sh	v1,8\(sp\)
 *[0-9a-f]+:	389d 0010 	sh	a0,16\(sp\)
 *[0-9a-f]+:	441b      	break
 *[0-9a-f]+:	3848 0001 	sh	v0,1\(t0\)
 *[0-9a-f]+:	3868 0003 	sh	v1,3\(t0\)
 *[0-9a-f]+:	3888 000b 	sh	a0,11\(t0\)
 *[0-9a-f]+:	441b      	break
 *[0-9a-f]+:	c842      	sw	v0,8\(sp\)
 *[0-9a-f]+:	f87d fff8 	sw	v1,-8\(sp\)
 *[0-9a-f]+:	c882      	sw	a0,8\(sp\)
 *[0-9a-f]+:	441b      	break
 *[0-9a-f]+:	c841      	sw	v0,4\(sp\)
 *[0-9a-f]+:	c862      	sw	v1,8\(sp\)
 *[0-9a-f]+:	c884      	sw	a0,16\(sp\)
 *[0-9a-f]+:	441b      	break
 *[0-9a-f]+:	f848 0003 	sw	v0,3\(t0\)
 *[0-9a-f]+:	f868 0007 	sw	v1,7\(t0\)
 *[0-9a-f]+:	f888 000f 	sw	a0,15\(t0\)
 *[0-9a-f]+:	441b      	break
 *[0-9a-f]+:	0c00      	nop
	\.\.\.
