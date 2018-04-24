#objdump: -dr --no-show-raw-insn
#name: nanoMIPS jal-pic
#as: -mlegacyregs --linkrelax

# Test the jal macro with -mpic for nanoMIPS.

.*: +file format .*nanomips.*

Disassembly of section \.text:
00000000 <text_label>:
   0:	lapc	gp,0 <_gp>
			2: R_NANOMIPS_PC_I32	_gp
   6:	jalrc	t9
   8:	jalrc	a0,t9
   c:	lw	at,0\(gp\)
			c: R_NANOMIPS_GOT_CALL	text_label
  10:	jalrc	at
			10: R_NANOMIPS_JALR16	text_label
  12:	lw	at,0\(gp\)
			12: R_NANOMIPS_GOT_CALL	weak_text_label
  16:	jalrc	at
			16: R_NANOMIPS_JALR16	weak_text_label
  18:	lw	at,0\(gp\)
			18: R_NANOMIPS_GOT_CALL	external_text_label
  1c:	jalrc	at
			1c: R_NANOMIPS_JALR16	external_text_label
  1e:	bc	0 <text_label>
			1e: R_NANOMIPS_PC25_S1	text_label
#pass
