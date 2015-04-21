#objdump: -dr
#as: -mfix-24k -32 -EB
#name: 24K: Triple Store (Store Macro Check)
#source: 24k-triple-stores-6.s

.*: +file format .*mips.*

Disassembly of section \.text:

[0-9a-f]+ <.*>:
 *[0-9a-f]+:	981d 0050 	swc1	\$f0,80\(sp\)
 *[0-9a-f]+:	985d 0058 	swc1	\$f2,88\(sp\)
 *[0-9a-f]+:	989d 0060 	swc1	\$f4,96\(sp\)
 *[0-9a-f]+:	441b      	break
 *[0-9a-f]+:	b81d 0050 	sdc1	\$f0,80\(sp\)
 *[0-9a-f]+:	b85d 0058 	sdc1	\$f2,88\(sp\)
 *[0-9a-f]+:	b89d 0060 	sdc1	\$f4,96\(sp\)
 *[0-9a-f]+:	441b      	break
	\.\.\.
