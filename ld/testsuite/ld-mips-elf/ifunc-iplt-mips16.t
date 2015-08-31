tmpdir/ifunc-iplt-mips16:     file format elf32-tradbigmips


Disassembly of section .iplt:

00400170 <.iplt.func1>:
  400170:	b202      	lw	v0,400178 <.iplt.func1\+0x8>
  400172:	9a60      	lw	v1,0\(v0\)
  400174:	eb00      	jr	v1
  400176:	653b      	move	t9,v1
  400178:	0041      	addiu	s0,sp,260
  40017a:	0190      	addiu	s1,sp,576
