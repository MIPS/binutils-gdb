tmpdir/ifunc-3-n64:     file format elf64-tradbigmips


Disassembly of section .iplt:

0000000000000400 <.iplt.func1>:
 400:	3c0f0000 	lui	t3,0x0
 404:	3c0e0000 	lui	t2,0x0
 408:	25ef0000 	addiu	t3,t3,0
 40c:	000f783c 	dsll32	t3,t3,0x0
 410:	01ee782d 	daddu	t3,t3,t2
 414:	ddf90800 	ld	t9,2048\(t3\)
 418:	03200008 	jr	t9
 41c:	00000000 	nop
