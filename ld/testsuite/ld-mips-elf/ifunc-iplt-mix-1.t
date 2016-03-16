#...
Disassembly of section .iplt:

00400140 <.iplt.func1>:
  400140:	3c0f0041 	lui	t7,0x41
  400144:	8df90160 	lw	t9,352\(t7\)
  400148:	03200008 	jr	t9
  40014c:	00000000 	nop

00400150 <.iplt.func2>:
  400150:	b202      	lw	v0,400158 <\.iplt\.func2\+0x8>
  400152:	9a40      	lw	v0,0\(v0\)
  400154:	ea00      	jr	v0
  400156:	653a      	move	t9,v0
  400158:	0041      	addiu	s0,sp,260
  40015a:	0164      	addiu	s1,sp,400
