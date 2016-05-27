tmpdir/ifunc-mix-2:     file format elf32-tradbigmips


Disassembly of section .iplt:

00400140 <.iplt.comp.func1>:
  400140:	lui	t7,0x41
  400144:	lw	t9,384\(t7\)
  400148:	jrc	t9
  40014a:	nop

0040014c <.iplt.comp.func2>:
  40014c:	lui	t7,0x41
  400150:	lw	t9,388\(t7\)
  400154:	jrc	t9
  400156:	nop

00400158 <.iplt.func1>:
  400158:	lui	t7,0x41
  40015c:	lw	t9,384\(t7\)
  400160:	jr	t9

00400164 <.iplt.func2>:
  400164:	lui	t7,0x41
  400168:	lw	t9,388\(t7\)
  40016c:	jr	t9
  400170:	nop
