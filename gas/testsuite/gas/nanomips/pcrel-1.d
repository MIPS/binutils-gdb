#objdump: -dr
#name: Locally-resolvable PC-relative code references

.*:     file format .*

Disassembly of section .text:

00000000 <func>:
       0:	e080 8000 	lui	a0,%hi\(0x8000\)
       4:	0084 000c 	addiu	a0,a0,12
	\.\.\.

00008010 <foo>:
    8010:	9008      	nop
    8012:	9008      	nop
#pass
