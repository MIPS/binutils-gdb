tmpdir/ifunc-3-n64:     file format elf64-tradbigmips


Disassembly of section .iplt:

0000000000000400 <.iplt.func1>:
 400:	3c0f0000 	lui	t3,0x0
 404:	65ef0000 	daddiu	t3,t3,0
 408:	000f7c38 	dsll	t3,t3,0x10
 40c:	65ef0000 	daddiu	t3,t3,0
 410:	000f7c38 	dsll	t3,t3,0x10
 414:	ddf90800 	ld	t9,2048\(t3\)
 418:	03200008 	jr	t9
 41c:	00000000 	nop
