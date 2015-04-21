#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS jal-svr4pic noreorder
#as: -32 -KPIC
#source: jal-svr4pic-noreorder.s

# Test the jal macro with -KPIC and `.set noreorder' (microMIPS).

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> 1380 0000 	lui	gp,0x0
[ 	]*[0-9a-f]+: R_MICROMIPS_HI16	_gp_disp
[0-9a-f]+ <[^>]*> 339c 0000 	addiu	gp,gp,0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	_gp_disp
[0-9a-f]+ <[^>]*> 033c e150 	addu	gp,gp,t9
[0-9a-f]+ <[^>]*> fb9d 0000 	sw	gp,0\(sp\)
[0-9a-f]+ <[^>]*> 472b      	jalrc	t9
[0-9a-f]+ <[^>]*> ff9d 0000 	lw	gp,0\(sp\)
[0-9a-f]+ <[^>]*> 0099 0f3c 	jalrc	a0,t9
[0-9a-f]+ <[^>]*> ff9d 0000 	lw	gp,0\(sp\)
[0-9a-f]+ <[^>]*> ff3c 0000 	lw	t9,0\(gp\)
[ 	]*[0-9a-f]+: R_MICROMIPS_GOT16	text_label
[0-9a-f]+ <[^>]*> 3339 0000 	addiu	t9,t9,0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	text_label
[0-9a-f]+ <[^>]*> 03f9 0f3c 	jalrc	t9
[ 	]*[0-9a-f]+: R_MICROMIPS_JALR	text_label
[0-9a-f]+ <[^>]*> ff9d 0000 	lw	gp,0\(sp\)
[0-9a-f]+ <[^>]*> ff3c 0000 	lw	t9,0\(gp\)
[ 	]*[0-9a-f]+: R_MICROMIPS_CALL16	weak_text_label
[0-9a-f]+ <[^>]*> 03f9 0f3c 	jalrc	t9
[ 	]*[0-9a-f]+: R_MICROMIPS_JALR	weak_text_label
[0-9a-f]+ <[^>]*> ff9d 0000 	lw	gp,0\(sp\)
[0-9a-f]+ <[^>]*> ff3c 0000 	lw	t9,0\(gp\)
[ 	]*[0-9a-f]+: R_MICROMIPS_CALL16	external_text_label
[0-9a-f]+ <[^>]*> 03f9 0f3c 	jalrc	t9
[ 	]*[0-9a-f]+: R_MICROMIPS_JALR	external_text_label
[0-9a-f]+ <[^>]*> ff9d 0000 	lw	gp,0\(sp\)
([0-9a-f]+) <[^>]*> 97ff fffe 	bc	\1 <.*>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	text_label
[0-9a-f]+ <[^>]*> 0c00      	nop
	\.\.\.
