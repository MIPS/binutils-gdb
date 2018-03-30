#as: -mpic
#objdump: -dr

.*

Disassembly of section \.text:

0+0000 <test>:
   0:	4020 0002 	lw	at,0\(gp\)
			0: R_NANOMIPS_GOT_CALL	local
   4:	d830      	jalrc	at
   6:	4020 0002 	lw	at,0\(gp\)
			6: R_NANOMIPS_GOT_CALL	local\+0xc
   a:	d830      	jalrc	at
   c:	4020 0002 	lw	at,0\(gp\)
			c: R_NANOMIPS_GOT_CALL	global
  10:	d830      	jalrc	at
  12:	4020 0002 	lw	at,0\(gp\)
			12: R_NANOMIPS_GOT_CALL	global\+0xc
  16:	d830      	jalrc	at

0+0018 <local>:
  18:	9008      	nop
  1a:	9008      	nop
  1c:	9008      	nop
  1e:	9008      	nop
#pass
