#objdump: -dr

.*: +file format .*

Disassembly of section \.text:

0+ <.text>:
   0:	877b 87ff 	lw	k1,2047\(k1\)
   4:	a77b c080 	lw	k1,-128\(k1\)
   8:	877b 97ff 	sw	k1,2047\(k1\)
   c:	a77b c880 	sw	k1,-128\(k1\)
	\.\.\.
