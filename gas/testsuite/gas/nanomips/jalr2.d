#as: -mpic
#objdump: -dr

.*

Disassembly of section \.text:

0+0000 <test>:
   0:	4320 0002 	lw	t9,0\(gp\)
			0: R_NANOMIPS_GOT_DISP	local
   4:	db30      	jalrc	t9
   6:	4320 0002 	lw	t9,0\(gp\)
			6: R_NANOMIPS_GOT_DISP	local\+0xc
   a:	db30      	jalrc	t9
   c:	4320 0002 	lw	t9,0\(gp\)
			c: R_NANOMIPS_GOT_CALL	global
  10:	db30      	jalrc	t9
  12:	4320 0002 	lw	t9,0\(gp\)
			12: R_NANOMIPS_GOT_CALL	global\+0xc
  16:	db30      	jalrc	t9

0+0018 <local>:
  18:	9008      	nop
  1a:	9008      	nop
  1c:	9008      	nop
  1e:	9008      	nop
