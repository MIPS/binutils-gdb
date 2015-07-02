tmpdir/ifunc-4-n64:     file format elf64-tradbigmips


Disassembly of section .iplt:

0000000000080000 <.iplt.func1>:
   80000:	3c0f0000 	lui	t3,0x0
   80004:	3c0e0008 	lui	t2,0x8
   80008:	25ef0000 	addiu	t3,t3,0
   8000c:	000f783c 	dsll32	t3,t3,0x0
   80010:	01ee782d 	daddu	t3,t3,t2
   80014:	ddf90800 	ld	t9,2048\(t3\)
   80018:	03200008 	jr	t9
   8001c:	00000000 	nop
