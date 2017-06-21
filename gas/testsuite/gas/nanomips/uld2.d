#objdump: -dr --no-show-raw-insn
#name: nanoMIPS uld

# Test the uld macro.

.*: +file format .*nanomips.*

Disassembly of section .text:


0+0000 <text_label>:

0+0000 <text_label>:
   0:	lw	a0,0\(a1\)
   4:	lw	a1,4\(a1\)
   8:	lw	a0,1\(a1\)
   c:	lw	a1,5\(a1\)
  10:	lw	a2,4\(a1\)
  14:	lw	a1,0\(a1\)
  18:	lw	a2,5\(a1\)
  1c:	lw	a1,1\(a1\)
	...
