tmpdir/ifunc-iplt-0x400000000:     file format elf64-tradbigmips


Disassembly of section .iplt:

0000000400000188 <.iplt.func1>:
   400000188:	3c0f0004 	lui	t3,0x4
   40000018c:	25ef0001 	addiu	t3,t3,1
   400000190:	000f7c38 	dsll	t3,t3,0x10
   400000194:	ddf90320 	ld	t9,800\(t3\)
   400000198:	03200008 	jr	t9
   40000019c:	00000000 	nop
	...
