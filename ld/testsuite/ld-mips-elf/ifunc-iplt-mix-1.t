#...
Disassembly of section .iplt:

00400140 <.iplt.comp.func1>:
  400140:	b202      	lw	v0,400148 <.iplt.comp.func1\+0x8>
  400142:	9a40      	lw	v0,0\(v0\)
  400144:	ea00      	jr	v0
  400146:	653a      	move	t9,v0
  400148:	0041      	addiu	s0,sp,260
  40014a:	0180      	addiu	s1,sp,512

0040014c <.iplt.comp.func2>:
  40014c:	b202      	lw	v0,400154 <.iplt.comp.func2\+0x8>
  40014e:	9a40      	lw	v0,0\(v0\)
  400150:	ea00      	jr	v0
  400152:	653a      	move	t9,v0
  400154:	0041      	addiu	s0,sp,260
  400156:	0184      	addiu	s1,sp,528

00400158 <.iplt.func1>:
  400158:	3c0f0041 	lui	t7,0x41
  40015c:	8df90180 	lw	t9,384\(t7\)
  400160:	03200008 	jr	t9

00400164 <.iplt.func2>:
  400164:	3c0f0041 	lui	t7,0x41
  400168:	8df90184 	lw	t9,388\(t7\)
  40016c:	03200008 	jr	t9
  400170:	00000000 	nop
