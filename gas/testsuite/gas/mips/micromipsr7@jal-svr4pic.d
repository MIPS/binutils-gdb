#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS32R7 jal-svr4pic
#as: -32 -KPIC
#source: jal-svr4pic.s

# Test the jal macro with -KPIC for R7.

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> e001 0002 	aluipc	gp,00000010 <_gp\+0x10>
			0: R_MICROMIPS_PCHI20_M12	_gp
0+0004 <text_label\+0x4> db30      	jalrc	t9
0+0006 <text_label\+0x6> 4899 0000 	jalrc	a0,t9
0+000a <text_label\+0xa> 873c 8000 	lw	t9,0\(gp\)
			a: R_MICROMIPS_GOT_DISP	.text\+0x1
0+000e <text_label\+0xe> 4bf9 0000 	jalrc	t9
			e: R_MICROMIPS_CALL_HI20	.text\+0x1
0+0012 <text_label\+0x12> 873c 8000 	lw	t9,0\(gp\)
			12: R_MICROMIPS_CALL	weak_text_label
0+0016 <text_label\+0x16> 4bf9 0000 	jalrc	t9
			16: R_MICROMIPS_CALL_HI20	weak_text_label
0+001a <text_label\+0x1a> 873c 8000 	lw	t9,0\(gp\)
			1a: R_MICROMIPS_CALL	external_text_label
0+001e <text_label\+0x1e> 4bf9 0000 	jalrc	t9
			1e: R_MICROMIPS_CALL_HI20	external_text_label
0+0022 <text_label\+0x22> 2800 0000 	bc	00000026 <text_label\+0x26>
			22: R_MICROMIPS_PC25_S1	text_label-0x4
0+0026 <text_label\+0x26> 9008      	nop
	\.\.\.
