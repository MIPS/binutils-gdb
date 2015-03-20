tmpdir/ifunc-iplt-0x400000000:     file format elf64-tradbigmips


Disassembly of section .iplt:

0000000400000148 <.iplt.func1>:
   400000148:	3c0f0004 	lui	t3,0x4
   40000014c:	65ef0001 	daddiu	t3,t3,1
   400000150:	000f7c38 	dsll	t3,t3,0x10
   400000154:	ddf902e0 	ld	t9,736\(t3\)
   400000158:	03200008 	jr	t9
   40000015c:	00000000 	nop
	...
