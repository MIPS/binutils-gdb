#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS `.option picX' with relaxation 4
#as: -32 -mmicromips --relax-branch
#stderr: option-pic-relax-4.l

# Verify that relaxation is done according to the `.option picX' setting
# at the time the relevant instruction was assembled rather than at
# relaxation time.

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> 41bc 0000 	lui	gp,0x0
[ 	]*[0-9a-f]+: R_MICROMIPS_HI16	_gp_disp
[0-9a-f]+ <[^>]*> 339c 0000 	addiu	gp,gp,0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	_gp_disp
[0-9a-f]+ <[^>]*> 033c e150 	addu	gp,gp,t9
[0-9a-f]+ <[^>]*> 0c44      	move	v0,a0
[0-9a-f]+ <[^>]*> fc3c 0000 	lw	at,0\(gp\)
[ 	]*[0-9a-f]+: R_MICROMIPS_GOT16	bar
[0-9a-f]+ <[^>]*> 3021 0000 	addiu	at,at,0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	bar
[0-9a-f]+ <[^>]*> 4581      	jr	at
[0-9a-f]+ <[^>]*> 0c65      	move	v1,a1
[0-9a-f]+ <[^>]*> 0c00      	nop
	\.\.\.
[0-9a-f]+ <[^>]*> 45bf      	jrc	ra
	\.\.\.
