#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS microMIPS pre-R6 to R6 mapping
#as: -32

# Check mapping of microMIPS pre-R6 to R6 translation

.*.o:     file format elf32-trad.*mips


Disassembly of section .text:
[0-9a-f]+ <[^>]*> cfff      	bc	[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	.L11
[0-9a-f]+ <[^>]*> cfff      	bc	[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	.L11
[0-9a-f]+ <[^>]*> 97ff fffe 	bc	[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	.L11
[0-9a-f]+ <[^>]*> b7ff fffe 	balc	[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	.L11
[0-9a-f]+ <[^>]*> 805f fffe 	beqzc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	.L11
[0-9a-f]+ <[^>]*> 805f fffe 	beqzc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	.L11
[0-9a-f]+ <[^>]*> 8d7f      	beqzc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	.L11
[0-9a-f]+ <[^>]*> 8dff      	beqzc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	ext
[0-9a-f]+ <[^>]*> 8dff      	beqzc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	ext
[0-9a-f]+ <[^>]*> 807f fffe 	beqzc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	ext
[0-9a-f]+ <[^>]*> 807f fffe 	beqzc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	ext
[0-9a-f]+ <[^>]*> 7462 fffe 	beqc	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 7462 fffe 	beqc	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 8dff      	beqzc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	ext
[0-9a-f]+ <[^>]*> 807f fffe 	beqzc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	ext
[0-9a-f]+ <[^>]*> a05f fffe 	bnezc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	.L11
[0-9a-f]+ <[^>]*> a05f fffe 	bnezc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	.L11
[0-9a-f]+ <[^>]*> ad7f      	bnezc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	.L11
[0-9a-f]+ <[^>]*> adff      	bnezc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	ext
[0-9a-f]+ <[^>]*> adff      	bnezc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	ext
[0-9a-f]+ <[^>]*> a07f fffe 	bnezc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	ext
[0-9a-f]+ <[^>]*> a07f fffe 	bnezc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	ext
[0-9a-f]+ <[^>]*> 7c62 fffe 	bnec	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 7c62 fffe 	bnec	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> adff      	bnezc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	ext
[0-9a-f]+ <[^>]*> a07f fffe 	bnezc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	ext
[0-9a-f]+ <[^>]*> f442 fffe 	bgezc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> d442 fffe 	bltzc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> e042 fffe 	bltzalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> c042 fffe 	bgezalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 4483      	jrc	a0
[0-9a-f]+ <[^>]*> 4443      	jrc	v0
[0-9a-f]+ <[^>]*> 8002 0000 	jrc	v0
[0-9a-f]+ <[^>]*> 97ff fffe 	bc	[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	.L11
[0-9a-f]+ <[^>]*> 97ff fffe 	bc	[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	.L11
[0-9a-f]+ <[^>]*> b7ff fffe 	balc	[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	.L11
[0-9a-f]+ <[^>]*> 8004 0000 	jrc	a0
[0-9a-f]+ <[^>]*> 8004 0000 	jrc	a0
[0-9a-f]+ <[^>]*> 448b      	jalrc	a0
[0-9a-f]+ <[^>]*> 03e4 0f3c 	jalrc	a0
[0-9a-f]+ <[^>]*> 0085 0f3c 	jalrc	a0,a1
[0-9a-f]+ <[^>]*> 0085 0f3c 	jalrc	a0,a1
[0-9a-f]+ <[^>]*> 444b      	jalrc	v0
[0-9a-f]+ <[^>]*> 444b      	jalrc	v0
[0-9a-f]+ <[^>]*> 444b      	jalrc	v0
[0-9a-f]+ <[^>]*> 0004 1f3c 	jrc.hb	a0
[0-9a-f]+ <[^>]*> 03e4 1f3c 	jalrc.hb	a0
[0-9a-f]+ <[^>]*> 0085 1f3c 	jalrc.hb	a0,a1
[0-9a-f]+ <[^>]*> 4513      	jrcaddiusp	32
[0-9a-f]+ <[^>]*> cfff      	bc	[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	.L11
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> cfff      	bc	[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	.L11
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 97ff fffe 	bc	[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	.L11
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 805f fffe 	beqzc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	.L11
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 805f fffe 	beqzc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	.L11
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 8d7f      	beqzc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	.L11
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 8dff      	beqzc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	ext
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 8dff      	beqzc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	ext
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 807f fffe 	beqzc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	ext
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 807f fffe 	beqzc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	ext
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 7462 fffe 	beqc	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 7462 fffe 	beqc	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 8dff      	beqzc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	ext
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 807f fffe 	beqzc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	ext
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> ad7f      	bnezc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	.L11
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> a05f fffe 	bnezc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	.L11
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> ad7f      	bnezc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	.L11
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> adff      	bnezc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	ext
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> adff      	bnezc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	ext
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> a07f fffe 	bnezc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	ext
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 7c62 fffe 	bnec	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 7c62 fffe 	bnec	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> adff      	bnezc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	ext
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> a07f fffe 	bnezc	v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	ext
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> f442 fffe 	bgezc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> d442 fffe 	bltzc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 4483      	jrc	a0
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 4443      	jrc	v0
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 8002 0000 	jrc	v0
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 97ff fffe 	bc	[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	.L11
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 97ff fffe 	bc	[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	.L11
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 8004 0000 	jrc	a0
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 8004 0000 	jrc	a0
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 0004 1f3c 	jrc.hb	a0
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 4513      	jrcaddiusp	32
[0-9a-f]+ <[^>]*> ed0f      	li	v0,15
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 0c00      	nop
	\.\.\.
