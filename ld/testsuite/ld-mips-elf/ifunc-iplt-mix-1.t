#...
Disassembly of section .iplt:

00400140 <.iplt.comp.func1>:
  400140:	lw	v0,400148 <.iplt.comp.func1\+0x8>
  400142:	lw	v0,0\(v0\)
  400144:	jr	v0
  400146:	move	t9,v0
  400148:	addiu	s0,sp,260
  40014a:	addiu	s1,sp,512

0040014c <.iplt.comp.func2>:
  40014c:	lw	v0,400154 <.iplt.comp.func2\+0x8>
  40014e:	lw	v0,0\(v0\)
  400150:	jr	v0
  400152:	move	t9,v0
  400154:	addiu	s0,sp,260
  400156:	addiu	s1,sp,528

00400158 <.iplt.func1>:
  400158:	lui	t7,0x41
  40015c:	lw	t9,384\(t7\)
  400160:	jr	t9

00400164 <.iplt.func2>:
  400164:	lui	t7,0x41
  400168:	lw	t9,388\(t7\)
  40016c:	jr	t9
  400170:	nop
