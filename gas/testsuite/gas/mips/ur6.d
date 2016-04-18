#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS microMIPS R6 instructions
#as: -32

# Check microMIPS R6 instructions

.*: +file format .*mips.*


Disassembly of section .text:
[0-9a-f]+ <[^>]*> 5441 01b8 	maddf.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 54a4 1bb8 	maddf.d	\$f3,\$f4,\$f5
[0-9a-f]+ <[^>]*> 5507 31f8 	msubf.s	\$f6,\$f7,\$f8
[0-9a-f]+ <[^>]*> 556a 4bf8 	msubf.d	\$f9,\$f10,\$f11
[0-9a-f]+ <[^>]*> 5441 0005 	cmp.af.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0015 	cmp.af.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0045 	cmp.un.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0055 	cmp.un.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0085 	cmp.eq.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0095 	cmp.eq.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 00c5 	cmp.ueq.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 00d5 	cmp.ueq.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0105 	cmp.lt.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0115 	cmp.lt.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0145 	cmp.ult.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0155 	cmp.ult.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0185 	cmp.le.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0195 	cmp.le.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 01c5 	cmp.ule.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 01d5 	cmp.ule.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0205 	cmp.saf.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0215 	cmp.saf.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0245 	cmp.sun.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0255 	cmp.sun.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0285 	cmp.seq.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0295 	cmp.seq.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 02c5 	cmp.sueq.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 02d5 	cmp.sueq.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0305 	cmp.slt.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0315 	cmp.slt.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0345 	cmp.sult.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0355 	cmp.sult.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0385 	cmp.sle.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0395 	cmp.sle.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 03c5 	cmp.sule.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 03d5 	cmp.sule.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0445 	cmp.or.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0455 	cmp.or.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0485 	cmp.une.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0495 	cmp.une.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 04c5 	cmp.ne.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 04d5 	cmp.ne.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0645 	cmp.sor.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0655 	cmp.sor.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0685 	cmp.sune.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0695 	cmp.sune.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 06c5 	cmp.sne.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 06d5 	cmp.sne.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 4100 fffe 	bc1eqzc	\$f0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> 411f fffe 	bc1eqzc	\$f31,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> 411f fffe 	bc1eqzc	\$f31,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	new
[0-9a-f]+ <[^>]*> 411f fffe 	bc1eqzc	\$f31,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	external_label
[0-9a-f]+ <[^>]*> 4120 fffe 	bc1nezc	\$f0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> 413f fffe 	bc1nezc	\$f31,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> 413f fffe 	bc1nezc	\$f31,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	new
[0-9a-f]+ <[^>]*> 413f fffe 	bc1nezc	\$f31,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	external_label
[0-9a-f]+ <[^>]*> 4140 fffe 	bc2eqzc	\$0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> 415f fffe 	bc2eqzc	\$31,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> 415f fffe 	bc2eqzc	\$31,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	new
[0-9a-f]+ <[^>]*> 415f fffe 	bc2eqzc	\$31,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	external_label
[0-9a-f]+ <[^>]*> 4160 fffe 	bc2nezc	\$0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> 417f fffe 	bc2nezc	\$31,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> 417f fffe 	bc2nezc	\$31,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	new
[0-9a-f]+ <[^>]*> 417f fffe 	bc2nezc	\$31,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	external_label
[0-9a-f]+ <[^>]*> 5441 00b8 	sel.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 02b8 	sel.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0038 	seleqz.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0238 	seleqz.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0078 	selnez.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 5441 0278 	selnez.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]*> 0083 1140 	seleqz	v0,v1,a0
[0-9a-f]+ <[^>]*> 0083 1180 	selnez	v0,v1,a0
[0-9a-f]+ <[^>]*> 0083 1018 	mul	v0,v1,a0
[0-9a-f]+ <[^>]*> 0083 1058 	muh	v0,v1,a0
[0-9a-f]+ <[^>]*> 0083 1098 	mulu	v0,v1,a0
[0-9a-f]+ <[^>]*> 0083 10d8 	muhu	v0,v1,a0
[0-9a-f]+ <[^>]*> 0083 1118 	div	v0,v1,a0
[0-9a-f]+ <[^>]*> 0083 1158 	mod	v0,v1,a0
[0-9a-f]+ <[^>]*> 0083 1198 	divu	v0,v1,a0
[0-9a-f]+ <[^>]*> 0083 11d8 	modu	v0,v1,a0
[0-9a-f]+ <[^>]*> 0083 100f 	lsa	v0,v1,a0,0x1
[0-9a-f]+ <[^>]*> 0083 160f 	lsa	v0,v1,a0,0x4
[0-9a-f]+ <[^>]*> 0062 201f 	align	a0,v0,v1,0
[0-9a-f]+ <[^>]*> 0062 221f 	align	a0,v0,v1,1
[0-9a-f]+ <[^>]*> 0062 241f 	align	a0,v0,v1,2
[0-9a-f]+ <[^>]*> 0062 261f 	align	a0,v0,v1,3
[0-9a-f]+ <[^>]*> 0044 0b3c 	bitswap	a0,v0
[0-9a-f]+ <[^>]*> 7400 fffe 	bovc	zero,zero,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 7402 fffe 	bovc	v0,zero,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 7402 fffe 	bovc	v0,zero,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 7444 fffe 	bovc	a0,v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 7444 fffe 	bovc	a0,v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 7444 8000 	bovc	a0,v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> 7444 7fff 	bovc	a0,v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> 7444 fffe 	bovc	a0,v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> 7442 fffe 	bovc	v0,v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 7442 8000 	bovc	v0,v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> 7440 fffe 	beqzalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 7440 8000 	beqzalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> 7440 7fff 	beqzalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> 7440 fffe 	beqzalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> 7462 fffe 	beqc	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 7462 fffe 	beqc	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 7462 8000 	beqc	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> 7462 7fff 	beqc	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> 7462 fffe 	beqc	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> 7c00 fffe 	bnvc	zero,zero,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 7c02 fffe 	bnvc	v0,zero,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 7c02 fffe 	bnvc	v0,zero,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 7c44 fffe 	bnvc	a0,v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 7c44 fffe 	bnvc	a0,v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 7c44 8000 	bnvc	a0,v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> 7c44 7fff 	bnvc	a0,v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> 7c44 fffe 	bnvc	a0,v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> 7c42 fffe 	bnvc	v0,v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 7c42 8000 	bnvc	v0,v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> 7c40 fffe 	bnezalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 7c40 8000 	bnezalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> 7c40 7fff 	bnezalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> 7c40 fffe 	bnezalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> 7c62 fffe 	bnec	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 7c62 fffe 	bnec	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> 7c62 8000 	bnec	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> 7c62 7fff 	bnec	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> 7c62 fffe 	bnec	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> f440 fffe 	blezc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> f440 8000 	blezc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> f440 7fff 	blezc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> f440 fffe 	blezc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> f442 fffe 	bgezc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> f442 8000 	bgezc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> f442 7fff 	bgezc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> f442 fffe 	bgezc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	f
[0-9a-f]+ <[^>]*> f462 fffe 	bgec	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> f462 8000 	bgec	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> f462 7fff 	bgec	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> f462 fffe 	bgec	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> f443 fffe 	bgec	v1,v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> d440 fffe 	bgtzc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> d440 8000 	bgtzc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> d440 7fff 	bgtzc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> d440 fffe 	bgtzc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> d442 fffe 	bltzc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> d442 8000 	bltzc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> d442 7fff 	bltzc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> d442 fffe 	bltzc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> d462 fffe 	bltc	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> d462 8000 	bltc	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> d462 7fff 	bltc	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> d462 fffe 	bltc	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> d443 fffe 	bltc	v1,v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> c040 fffe 	blezalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> c040 8000 	blezalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> c040 7fff 	blezalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> c040 fffe 	blezalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> c042 fffe 	bgezalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> c042 8000 	bgezalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> c042 7fff 	bgezalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> c042 fffe 	bgezalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> c062 fffe 	bgeuc	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> c062 8000 	bgeuc	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> c062 7fff 	bgeuc	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> c062 fffe 	bgeuc	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> c043 fffe 	bgeuc	v1,v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> e040 fffe 	bgtzalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> e040 8000 	bgtzalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> e040 7fff 	bgtzalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> e040 fffe 	bgtzalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> e042 fffe 	bltzalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> e042 8000 	bltzalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> e042 7fff 	bltzalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> e042 fffe 	bltzalc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> e062 fffe 	bltuc	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	ext
[0-9a-f]+ <[^>]*> e062 8000 	bltuc	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> e062 7fff 	bltuc	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	L0
[0-9a-f]+ <[^>]*> e062 fffe 	bltuc	v0,v1,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> e043 fffe 	bltuc	v1,v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L11
[0-9a-f]+ <[^>]*> 97ff fffe 	bc	[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	ext
[0-9a-f]+ <[^>]*> 9600 0000 	bc	[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	L0
[0-9a-f]+ <[^>]*> 95ff ffff 	bc	[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	L0
[0-9a-f]+ <[^>]*> cfff      	bc	[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	.L11
[0-9a-f]+ <[^>]*> b7ff fffe 	balc	[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	ext
[0-9a-f]+ <[^>]*> b600 0000 	balc	[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	L0
[0-9a-f]+ <[^>]*> b5ff ffff 	balc	[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	L0
[0-9a-f]+ <[^>]*> b7ff fffe 	balc	[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	.L11
[0-9a-f]+ <[^>]*> 8d40      	beqzc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	L0
[0-9a-f]+ <[^>]*> 8d3f      	beqzc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	L0
[0-9a-f]+ <[^>]*> 805f fffe 	beqzc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	ext
[0-9a-f]+ <[^>]*> 8050 0000 	beqzc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	L0
[0-9a-f]+ <[^>]*> 804f ffff 	beqzc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	L0
[0-9a-f]+ <[^>]*> 805f fffe 	beqzc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	.L11
[0-9a-f]+ <[^>]*> 8003 8000 	jic	v1,-[0-9]+
[0-9a-f]+ <[^>]*> 8003 7fff 	jic	v1,[0-9]+
[0-9a-f]+ <[^>]*> 47e3      	jrc	ra
[0-9a-f]+ <[^>]*> ad40      	bnezc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	L0
[0-9a-f]+ <[^>]*> ad3f      	bnezc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	L0
[0-9a-f]+ <[^>]*> a05f fffe 	bnezc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	ext
[0-9a-f]+ <[^>]*> a050 0000 	bnezc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	L0
[0-9a-f]+ <[^>]*> a04f ffff 	bnezc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	L0
[0-9a-f]+ <[^>]*> a05f fffe 	bnezc	v0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	.L11
[0-9a-f]+ <[^>]*> a003 8000 	jialc	v1,-[0-9]+
[0-9a-f]+ <[^>]*> a003 7fff 	jialc	v1,[0-9]+
[0-9a-f]+ <[^>]*> 1062 ffff 	aui	v1,v0,0xffff
[0-9a-f]+ <[^>]*> 00000004 	sllv	zero,zero,zero
[0-9a-f]+ <[^>]*> 7887 fffc 	lapc	a0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC19_S2	.L21
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 7887 fffc 	lapc	a0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC19_S2	.L21
[0-9a-f]+ <[^>]*> cfff      	bc	[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	.L31
[0-9a-f]+ <[^>]*> 7884 0000 	lapc	a0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC19_S2	.L22
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 7884 0000 	lapc	a0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC19_S2	.L23
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 7883 ffff 	lapc	a0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC19_S2	.L24
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 7883 ffff 	lapc	a0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC19_S2	.L25
[0-9a-f]+ <[^>]*> 7884 0000 	lapc	a0,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 7883 ffff 	lapc	a0,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 7904 0000 	lapc	t0,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 7903 ffff 	lapc	t0,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 787e ffff 	auipc	v1,0xffff
[0-9a-f]+ <[^>]*> 787f ffff 	aluipc	v1,0xffff
[0-9a-f]+ <[^>]*> 7888 0000 	lwpc	a0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC19_S2	.L11
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 788c 0000 	lwpc	a0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC19_S2	.L26
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 788c 0000 	lwpc	a0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC19_S2	.L27
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 788b ffff 	lwpc	a0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC19_S2	.L28
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 788b ffff 	lwpc	a0,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC19_S2	.L29
[0-9a-f]+ <[^>]*> 788c 0000 	lwpc	a0,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 788b ffff 	lwpc	a0,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 5462 0020 	rint.s	\$f2,\$f3
[0-9a-f]+ <[^>]*> 5462 0220 	rint.d	\$f2,\$f3
[0-9a-f]+ <[^>]*> 5462 0060 	class.s	\$f2,\$f3
[0-9a-f]+ <[^>]*> 5462 0260 	class.d	\$f2,\$f3
[0-9a-f]+ <[^>]*> 5483 1003 	min.s	\$f2,\$f3,\$f4
[0-9a-f]+ <[^>]*> 5483 1203 	min.d	\$f2,\$f3,\$f4
[0-9a-f]+ <[^>]*> 5483 100b 	max.s	\$f2,\$f3,\$f4
[0-9a-f]+ <[^>]*> 5483 120b 	max.d	\$f2,\$f3,\$f4
[0-9a-f]+ <[^>]*> 5483 1023 	mina.s	\$f2,\$f3,\$f4
[0-9a-f]+ <[^>]*> 5483 1223 	mina.d	\$f2,\$f3,\$f4
[0-9a-f]+ <[^>]*> 5483 102b 	maxa.s	\$f2,\$f3,\$f4
[0-9a-f]+ <[^>]*> 5483 122b 	maxa.d	\$f2,\$f3,\$f4
[0-9a-f]+ <[^>]*> 4180 ffff 	synci	-1\(zero\)
[0-9a-f]+ <[^>]*> 1040 ffff 	lui	v0,0xffff
[0-9a-f]+ <[^>]*> 4530      	not	v0,v1
[0-9a-f]+ <[^>]*> 4538      	xor	v0,v0,v1
[0-9a-f]+ <[^>]*> 4531      	and	v0,v0,v1
[0-9a-f]+ <[^>]*> 4539      	or	v0,v0,v1
[0-9a-f]+ <[^>]*> 2225 5000 	lwm	s0,ra,0\(a1\)
[0-9a-f]+ <[^>]*> 2225 d000 	swm	s0,ra,0\(a1\)
[0-9a-f]+ <[^>]*> 4463      	jrc	v1
[0-9a-f]+ <[^>]*> 444b      	jalrc	v0
[0-9a-f]+ <[^>]*> 4433      	jrcaddiusp	4
[0-9a-f]+ <[^>]*> 469b      	break	0xa
[0-9a-f]+ <[^>]*> 443b      	sdbbp
[0-9a-f]+ <[^>]*> 443b      	sdbbp
[0-9a-f]+ <[^>]*> 447b      	sdbbp	0x1
[0-9a-f]+ <[^>]*> 47fb      	sdbbp	0xf
[0-9a-f]+ <[^>]*> 001f 1f3c 	jrc.hb	ra
[0-9a-f]+ <[^>]*> 03e0 1f3c 	jalrc.hb	zero
[0-9a-f]+ <[^>]*> 001f 1f3c 	jrc.hb	ra
[0-9a-f]+ <[^>]*> 005f 1f3c 	jalrc.hb	v0,ra
[0-9a-f]+ <[^>]*> 0002 1f3c 	jrc.hb	v0
[0-9a-f]+ <[^>]*> 000a 1f3c 	jrc.hb	t2
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 0c00      	nop
[0-9a-f]+ <[^>]*> 60a6 1040 	llwp	a1,a0,a2
[0-9a-f]+ <[^>]*> 60a6 9040 	scwp	a1,a0,a2
[0-9a-f]+ <[^>]*> 6085 b000 	sc	a0,0\(a1\)
[0-9a-f]+ <[^>]*> cfff      	bc	00000402 <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	.L1.1
[0-9a-f]+ <[^>]*> 6085 b000 	sc	a0,0\(a1\)
[0-9a-f]+ <[^>]*> cfff      	bc	00000408 <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	.L1.1
[0-9a-f]+ <[^>]*> 60a6 6440 	llwpe	a1,a0,a2
[0-9a-f]+ <[^>]*> 60a6 a040 	scwpe	a1,a0,a2
[0-9a-f]+ <[^>]*> 6085 ac00 	sce	a0,0\(a1\)
[0-9a-f]+ <[^>]*> cfff      	bc	00000416 <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	.L1.1
[0-9a-f]+ <[^>]*> 6085 ac00 	sce	a0,0\(a1\)
[0-9a-f]+ <[^>]*> cfff      	bc	0000041c <[^>]*>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	.L1.1
[0-9a-f]+ <[^>]*> 0004 01c0 	rdhwr	zero,\$4
[0-9a-f]+ <[^>]*> 0004 09c0 	rdhwr	zero,\$4,1
[0-9a-f]+ <[^>]*> 0004 11c0 	rdhwr	zero,\$4,2
[0-9a-f]+ <[^>]*> 0004 19c0 	rdhwr	zero,\$4,3
[0-9a-f]+ <[^>]*> 0004 21c0 	rdhwr	zero,\$4,4
[0-9a-f]+ <[^>]*> 0004 29c0 	rdhwr	zero,\$4,5
[0-9a-f]+ <[^>]*> 0004 31c0 	rdhwr	zero,\$4,6
[0-9a-f]+ <[^>]*> 0004 39c0 	rdhwr	zero,\$4,7
[0-9a-f]+ <[^>]*> 0000 003f 	sigrie	0x0
[0-9a-f]+ <[^>]*> 003f ffff 	sigrie	0xffff
[0-9a-f]+ <[^>]*> 0c00      	nop
	\.\.\.
