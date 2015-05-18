tmpdir/ifunc-4-n64:     file format elf64-tradbigmips


Disassembly of section .iplt:

0000000000080000 <.iplt.func1>:
   80000:	3c0f0000 	lui	t3,0x0
   80004:	65ef0000 	daddiu	t3,t3,0
   80008:	000f7c38 	dsll	t3,t3,0x10
   8000c:	65ef0008 	daddiu	t3,t3,8
   80010:	000f7c38 	dsll	t3,t3,0x10
   80014:	ddf90800 	ld	t9,2048\(t3\)
   80018:	03200008 	jr	t9
   8001c:	00000000 	nop
