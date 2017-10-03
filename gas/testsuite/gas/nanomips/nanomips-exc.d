#objdump: -dr --prefix-addresses --show-raw-insn
#name: New nanoMIPS instructions
#source: nanomips-exc.s

# Check exclusive nanoMIPS instructions

.*: +file format .*nanomips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> bc01      	movep	a0,a1,a5,a4
[0-9a-f]+ <[^>]+> bd43      	movep	a1,a2,zero,a6
[0-9a-f]+ <[^>]+> bc8d      	movep	a2,a3,a1,a0
[0-9a-f]+ <[^>]+> bdcf      	movep	a3,a4,a3,a2
[0-9a-f]+ <[^>]+> be30      	movep	a0,a1,s0,s1
[0-9a-f]+ <[^>]+> bf72      	movep	a1,a2,s2,s3
[0-9a-f]+ <[^>]+> bebc      	movep	a2,a3,s4,s5
[0-9a-f]+ <[^>]+> bffe      	movep	a3,a4,s6,s7
[0-9a-f]+ <[^>]+> fce0      	movep	a4,a3,a0,a1
[0-9a-f]+ <[^>]+> fdc1      	movep	a5,a2,a1,a2
[0-9a-f]+ <[^>]+> fcaa      	movep	a6,a1,a2,a3
[0-9a-f]+ <[^>]+> fd8b      	movep	a7,a0,a3,a4
[0-9a-f]+ <[^>]+> fe90      	movep	s0,s4,a0,a1
[0-9a-f]+ <[^>]+> ff35      	movep	s5,s1,a1,a2
[0-9a-f]+ <[^>]+> feda      	movep	s2,s6,a2,a3
[0-9a-f]+ <[^>]+> ff7f      	movep	s7,s3,a3,a4
[0-9a-f]+ <[^>]+> bc01      	movep	a0,a1,a5,a4
[0-9a-f]+ <[^>]+> bd43      	movep	a1,a2,zero,a6
[0-9a-f]+ <[^>]+> bc8d      	movep	a2,a3,a1,a0
[0-9a-f]+ <[^>]+> bdcf      	movep	a3,a4,a3,a2
[0-9a-f]+ <[^>]+> be30      	movep	a0,a1,s0,s1
[0-9a-f]+ <[^>]+> bf72      	movep	a1,a2,s2,s3
[0-9a-f]+ <[^>]+> bebc      	movep	a2,a3,s4,s5
[0-9a-f]+ <[^>]+> bffe      	movep	a3,a4,s6,s7
[0-9a-f]+ <[^>]+> fce0      	movep	a4,a3,a0,a1
[0-9a-f]+ <[^>]+> fdc1      	movep	a5,a2,a1,a2
[0-9a-f]+ <[^>]+> fcaa      	movep	a6,a1,a2,a3
[0-9a-f]+ <[^>]+> fd8b      	movep	a7,a0,a3,a4
[0-9a-f]+ <[^>]+> fe90      	movep	s0,s4,a0,a1
[0-9a-f]+ <[^>]+> ff35      	movep	s5,s1,a1,a2
[0-9a-f]+ <[^>]+> feda      	movep	s2,s6,a2,a3
[0-9a-f]+ <[^>]+> ff7f      	movep	s7,s3,a3,a4
[0-9a-f]+ <[^>]+> 7400      	lw	a4,0\(a4\)
[0-9a-f]+ <[^>]+> 7521      	lw	a5,4\(a5\)
[0-9a-f]+ <[^>]+> 744a      	lw	a6,8\(a6\)
[0-9a-f]+ <[^>]+> 756b      	lw	a7,12\(a7\)
[0-9a-f]+ <[^>]+> 7404      	lw	a4,0\(a0\)
[0-9a-f]+ <[^>]+> 7525      	lw	a5,4\(a1\)
[0-9a-f]+ <[^>]+> 744e      	lw	a6,8\(a2\)
[0-9a-f]+ <[^>]+> 756f      	lw	a7,12\(a3\)
[0-9a-f]+ <[^>]+> 7410      	lw	a4,0\(s0\)
[0-9a-f]+ <[^>]+> 7531      	lw	a5,4\(s1\)
[0-9a-f]+ <[^>]+> 745a      	lw	a6,8\(s2\)
[0-9a-f]+ <[^>]+> 757b      	lw	a7,12\(s3\)
[0-9a-f]+ <[^>]+> 7414      	lw	a4,0\(s4\)
[0-9a-f]+ <[^>]+> 7535      	lw	a5,4\(s5\)
[0-9a-f]+ <[^>]+> 745e      	lw	a6,8\(s6\)
[0-9a-f]+ <[^>]+> 757f      	lw	a7,12\(s7\)
[0-9a-f]+ <[^>]+> 7480      	lw	a0,0\(a4\)
[0-9a-f]+ <[^>]+> 75a1      	lw	a1,4\(a5\)
[0-9a-f]+ <[^>]+> 74ca      	lw	a2,8\(a6\)
[0-9a-f]+ <[^>]+> 75eb      	lw	a3,12\(a7\)
[0-9a-f]+ <[^>]+> f600      	sw	s0,0\(a4\)
[0-9a-f]+ <[^>]+> f721      	sw	s1,4\(a5\)
[0-9a-f]+ <[^>]+> f64a      	sw	s2,8\(a6\)
[0-9a-f]+ <[^>]+> f76b      	sw	s3,12\(a7\)
[0-9a-f]+ <[^>]+> f680      	sw	s4,0\(a4\)
[0-9a-f]+ <[^>]+> f7a1      	sw	s5,4\(a5\)
[0-9a-f]+ <[^>]+> f6ca      	sw	s6,8\(a6\)
[0-9a-f]+ <[^>]+> f7eb      	sw	s7,12\(a7\)
[0-9a-f]+ <[^>]+> f684      	sw	s4,0\(a0\)
[0-9a-f]+ <[^>]+> f7a5      	sw	s5,4\(a1\)
[0-9a-f]+ <[^>]+> f6ce      	sw	s6,8\(a2\)
[0-9a-f]+ <[^>]+> f7ef      	sw	s7,12\(a3\)
[0-9a-f]+ <[^>]+> f690      	sw	s4,0\(s0\)
[0-9a-f]+ <[^>]+> f7b1      	sw	s5,4\(s1\)
[0-9a-f]+ <[^>]+> f6da      	sw	s6,8\(s2\)
[0-9a-f]+ <[^>]+> f7fb      	sw	s7,12\(s3\)
[0-9a-f]+ <[^>]+> f694      	sw	s4,0\(s4\)
[0-9a-f]+ <[^>]+> f7b5      	sw	s5,4\(s5\)
[0-9a-f]+ <[^>]+> f6de      	sw	s6,8\(s6\)
[0-9a-f]+ <[^>]+> f7ff      	sw	s7,12\(s7\)
[0-9a-f]+ <[^>]+> f494      	sw	a0,0\(s4\)
[0-9a-f]+ <[^>]+> f5b5      	sw	a1,4\(s5\)
[0-9a-f]+ <[^>]+> f4de      	sw	a2,8\(s6\)
[0-9a-f]+ <[^>]+> f5ff      	sw	a3,12\(s7\)
[0-9a-f]+ <[^>]+> f614      	sw	s0,0\(s4\)
[0-9a-f]+ <[^>]+> f735      	sw	s1,4\(s5\)
[0-9a-f]+ <[^>]+> f65e      	sw	s2,8\(s6\)
[0-9a-f]+ <[^>]+> f77f      	sw	s3,12\(s7\)
[0-9a-f]+ <[^>]+> 4803 8000 	brc	t5
[0-9a-f]+ <[^>]+> 481f 8200 	brsc	ra
[0-9a-f]+ <[^>]+> 4a11 8200 	balrsc	s0,s1
[0-9a-f]+ <[^>]+> 4bf1 8200 	balrsc	ra,s1
[0-9a-f]+ <[^>]+> 446d 2345 	addiu	t5,gp,74565
[0-9a-f]+ <[^>]+> 6062 5678 1234 	addiu	t5,gp,305419896
[0-9a-f]+ <[^>]+> 6062 dcbb fffe 	addiu	t5,gp,-74565
[0-9a-f]+ <[^>]+> 6062 a988 edcb 	addiu	t5,gp,-305419896
[0-9a-f]+ <[^>]+> 6061 2345 0001 	addiu	t5,t5,74565
[0-9a-f]+ <[^>]+> 6061 5678 1234 	addiu	t5,t5,305419896
[0-9a-f]+ <[^>]+> 6061 dcbb fffe 	addiu	t5,t5,-74565
[0-9a-f]+ <[^>]+> 6061 a988 edcb 	addiu	t5,t5,-305419896
[0-9a-f]+ <[^>]+> c84c 0800 	bgeiuc	t4,1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC11_S1	test
[0-9a-f]+ <[^>]+> c84f f800 	bgeiuc	t4,127,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC11_S1	test
[0-9a-f]+ <[^>]+> c85c 0800 	bltiuc	t4,1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC11_S1	test
[0-9a-f]+ <[^>]+> c85f f800 	bltiuc	t4,127,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC11_S1	test
[0-9a-f]+ <[^>]+> 2062 201f 	extw	a0,t4,t5,0x0
[0-9a-f]+ <[^>]+> 2062 261f 	extw	a0,t4,t5,0x18
[0-9a-f]+ <[^>]+> 2062 241f 	extw	a0,t4,t5,0x10
[0-9a-f]+ <[^>]+> 2062 221f 	extw	a0,t4,t5,0x8
[0-9a-f]+ <[^>]+> 2062 205f 	extw	a0,t4,t5,0x1
[0-9a-f]+ <[^>]+> 2062 209f 	extw	a0,t4,t5,0x2
[0-9a-f]+ <[^>]+> 2062 20df 	extw	a0,t4,t5,0x3
[0-9a-f]+ <[^>]+> 2062 211f 	extw	a0,t4,t5,0x4
[0-9a-f]+ <[^>]+> 1083      	move	a0,t5
[0-9a-f]+ <[^>]+> 2003 2290 	move	a0,t5
[0-9a-f]+ <[^>]+> 2062 261f 	extw	a0,t4,t5,0x18
[0-9a-f]+ <[^>]+> 2062 241f 	extw	a0,t4,t5,0x10
[0-9a-f]+ <[^>]+> 2062 221f 	extw	a0,t4,t5,0x8
[0-9a-f]+ <[^>]+> 5359      	lwxs	a0,a1\(a2\)
[0-9a-f]+ <[^>]+> 508f      	lwxs	a3,s0\(s1\)
[0-9a-f]+ <[^>]+> 5235      	lwxs	s2,s3\(a0\)
[0-9a-f]+ <[^>]+> 4200 0003 	sw	s0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	x
[0-9a-f]+ <[^>]+> d484      	sw	s1,16\(gp\)
[0-9a-f]+ <[^>]+> d484      	sw	s1,16\(gp\)
[0-9a-f]+ <[^>]+> d480      	sw	s1,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL7_S2	test
[0-9a-f]+ <[^>]+> 04a0 0000 	lapc	a1,00000000 <test>
			[0-9a-f]+: R_NANOMIPS_PC21_S1	test
[0-9a-f]+ <[^>]+> 04a0 0000 	lapc	a1,00000000 <test2>
			[0-9a-f]+: R_NANOMIPS_PC21_S1	test2
[0-9a-f]+ <[^>]+> 8483 3fa0 	pref	0x4,4000\(t5\)
[0-9a-f]+ <[^>]+> a483 98e2 	pref	0x4,-30\(t5\)
[0-9a-f]+ <[^>]+> 8483 3000 	pref	0x4,0\(t5\)
			[0-9a-f]+: R_NANOMIPS_LO12	test
[0-9a-f]+ <[^>]+> c884 c000 	bbeqzc	a0,0x18,00000000 <test>
			[0-9a-f]+: R_NANOMIPS_PC11_S1	test
[0-9a-f]+ <[^>]+> c884 0800 	bbeqzc	a0,0x1,00000000 <test>
			[0-9a-f]+: R_NANOMIPS_PC11_S1	test
[0-9a-f]+ <[^>]+> c884 f800 	bbeqzc	a0,0x1f,00000000 <test>
			[0-9a-f]+: R_NANOMIPS_PC11_S1	test
[0-9a-f]+ <[^>]+> c894 0000 	bbnezc	a0,0x0,00000000 <test>
			[0-9a-f]+: R_NANOMIPS_PC11_S1	test
[0-9a-f]+ <[^>]+> c894 8000 	bbnezc	a0,0x10,00000000 <test>
			[0-9a-f]+: R_NANOMIPS_PC11_S1	test
[0-9a-f]+ <[^>]+> 2083 0000 	teq	t5,a0
[0-9a-f]+ <[^>]+> 20c5 0400 	tne	a1,a2
[0-9a-f]+ <[^>]+> 2083 3000 	teq	t5,a0,0x6
[0-9a-f]+ <[^>]+> 20c5 3c00 	tne	a1,a2,0x7
[0-9a-f]+ <[^>]+> 606b 0000 0000 	lwpc	t5,00002710 <\*ABS\*\+0x2710>
			[0-9a-f]+: R_NANOMIPS_PC_I32	\*ABS\*\+0x2710
[0-9a-f]+ <[^>]+> 606f 0000 0000 	swpc	t5,00002710 <\*ABS\*\+0x2710>
			[0-9a-f]+: R_NANOMIPS_PC_I32	\*ABS\*\+0x2710
[0-9a-f]+ <[^>]+> 60bb 0000 0000 	ldpc	a1,00002710 <\*ABS\*\+0x2710>
			[0-9a-f]+: R_NANOMIPS_PC_I32	\*ABS\*\+0x2710
[0-9a-f]+ <[^>]+> 611f 0000 0000 	sdpc	a4,00002710 <\*ABS\*\+0x2710>
			[0-9a-f]+: R_NANOMIPS_PC_I32	\*ABS\*\+0x2710
[0-9a-f]+ <[^>]+> 6063 0000 0000 	lapc	t5,00000000 <test>
			[0-9a-f]+: R_NANOMIPS_PC_I32	test
[0-9a-f]+ <[^>]+> 606b 0000 0000 	lwpc	t5,00000000 <test>
			[0-9a-f]+: R_NANOMIPS_PC_I32	test
[0-9a-f]+ <[^>]+> 606f 0000 0000 	swpc	t5,00000000 <test>
			[0-9a-f]+: R_NANOMIPS_PC_I32	test
[0-9a-f]+ <[^>]+> 60bb 0000 0000 	ldpc	a1,00000000 <test>
			[0-9a-f]+: R_NANOMIPS_PC_I32	test
[0-9a-f]+ <[^>]+> 611f 0000 0000 	sdpc	a4,00000000 <test>
			[0-9a-f]+: R_NANOMIPS_PC_I32	test
[0-9a-f]+ <[^>]+> a445 2104 	ualh	t4,4\(a1\)
[0-9a-f]+ <[^>]+> a445 2904 	uash	t4,4\(a1\)
[0-9a-f]+ <[^>]+> a445 4504 	ualwm	t4,4\(a1\),4
[0-9a-f]+ <[^>]+> a445 6d04 	uaswm	t4,4\(a1\),6
[0-9a-f]+ <[^>]+> a445 1504 	ualwm	t4,4\(a1\),1
[0-9a-f]+ <[^>]+> a445 1d04 	uaswm	t4,4\(a1\),1
[0-9a-f]+ <[^>]+> a445 0504 	ualwm	t4,4\(a1\),8
[0-9a-f]+ <[^>]+> a445 7d04 	uaswm	t4,4\(a1\),7
[0-9a-f]+ <[^>]+> a445 0404 	lwm	t4,4\(a1\),8
[0-9a-f]+ <[^>]+> a445 7c04 	swm	t4,4\(a1\),7
[0-9a-f]+ <[^>]+> a445 4704 	ualdm	t4,4\(a1\),4
[0-9a-f]+ <[^>]+> a445 6f04 	uasdm	t4,4\(a1\),6
[0-9a-f]+ <[^>]+> a445 1704 	ualdm	t4,4\(a1\),1
[0-9a-f]+ <[^>]+> a445 1f04 	uasdm	t4,4\(a1\),1
[0-9a-f]+ <[^>]+> a445 0704 	ualdm	t4,4\(a1\),8
[0-9a-f]+ <[^>]+> a445 7f04 	uasdm	t4,4\(a1\),7
[0-9a-f]+ <[^>]+> a445 0604 	ldm	t4,4\(a1\),8
[0-9a-f]+ <[^>]+> a445 7e04 	sdm	t4,4\(a1\),7
[0-9a-f]+ <[^>]+> 8043 d7c5 	rotx	t4,t5,0x5,30,1
[0-9a-f]+ <[^>]+> 8043 d01f 	bitrevw	t4,t5
[0-9a-f]+ <[^>]+> 8043 d01f 	bitrevw	t4,t5
[0-9a-f]+ <[^>]+> 8043 d247 	bitrevb	t4,t5
[0-9a-f]+ <[^>]+> 8043 d247 	bitrevb	t4,t5
[0-9a-f]+ <[^>]+> 8043 d247 	bitrevb	t4,t5
[0-9a-f]+ <[^>]+> 8043 d40f 	bitrevh	t4,t5
[0-9a-f]+ <[^>]+> 8043 d40f 	bitrevh	t4,t5
[0-9a-f]+ <[^>]+> 8043 d218 	byterevw	t4,t5
[0-9a-f]+ <[^>]+> 8043 d218 	byterevw	t4,t5
[0-9a-f]+ <[^>]+> 8043 d608 	byterevh	t4,t5
[0-9a-f]+ <[^>]+> 8043 d608 	byterevh	t4,t5
[0-9a-f]+ <[^>]+> 8043 d608 	byterevh	t4,t5
[0-9a-f]+ <[^>]+> 04bf fffd 	lapc	a1,0000021a <[^>]+>
[0-9a-f]+ <[^>]+> 04a0 0000 	lapc	a1,[0-9a-f]+ <test\+0x222>
[0-9a-f]+ <[^>]+> 04a0 0004 	lapc	a1,[0-9a-f]+ <test\+0x22a>
[0-9a-f]+ <[^>]+> 60a3 fffa ffff 	lapc	a1,00000226 <[^>]+>
[0-9a-f]+ <[^>]+> 60a3 0000 0000 	lapc	a1,[0-9a-f]+ <test\+0x232>
[0-9a-f]+ <[^>]+> 60a3 0002 0000 	lapc	a1,[0-9a-f]+ <test\+0x23a>
[0-9a-f]+ <[^>]+> 04bf fffe 	lapc	a1,0020023a <[^>]+>
[0-9a-f]+ <[^>]+> 60a3 fffe 001f 	lapc	a1,00200240 <[^>]+>
[0-9a-f]+ <[^>]+> 04a0 0001 	lapc	a1,[0-9a-f]+ <.*>
[0-9a-f]+ <[^>]+> 60a3 fffc ffdf 	lapc	a1,[0-9a-f]+ <[^>]+>
[0-9a-f]+ <[^>]+> e060 0002 	aluipc	t5,00000000 <test>
			[0-9a-f]+: R_NANOMIPS_PCHI20	test
[0-9a-f]+ <[^>]+> e062 5002 	aluipc	t5,00025000 <[^>]+>
[0-9a-f]+ <[^>]+> 0063 0000 	addiu	t5,t5,0
			[0-9a-f]+: R_NANOMIPS_LO12	test
[0-9a-f]+ <[^>]+> b2c8      	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 3c02      	addu	a4,a4,a6
[0-9a-f]+ <[^>]+> b100      	addu	s0,s0,s2
[0-9a-f]+ <[^>]+> 3e97      	addu	s4,s4,s7
[0-9a-f]+ <[^>]+> 3ca3      	addu	a1,a1,a7
[0-9a-f]+ <[^>]+> 3c51      	addu	a6,a6,s1
[0-9a-f]+ <[^>]+> 3e76      	addu	s3,s3,s6
[0-9a-f]+ <[^>]+> 3ea1      	addu	s5,s5,a5
[0-9a-f]+ <[^>]+> 3c02      	addu	a4,a4,a6
[0-9a-f]+ <[^>]+> 3e97      	addu	s4,s4,s7
[0-9a-f]+ <[^>]+> 3ca3      	addu	a1,a1,a7
[0-9a-f]+ <[^>]+> 3c51      	addu	a6,a6,s1
[0-9a-f]+ <[^>]+> 3e76      	addu	s3,s3,s6
[0-9a-f]+ <[^>]+> 3ea1      	addu	s5,s5,a5
[0-9a-f]+ <[^>]+> 3ccf      	mul	a2,a2,a3
[0-9a-f]+ <[^>]+> 3c2b      	mul	a5,a5,a7
[0-9a-f]+ <[^>]+> 3e3b      	mul	s1,s1,s3
[0-9a-f]+ <[^>]+> 3edc      	mul	s6,s6,s4
[0-9a-f]+ <[^>]+> 3ce9      	mul	a3,a3,a5
[0-9a-f]+ <[^>]+> 3c78      	mul	a7,a7,s0
[0-9a-f]+ <[^>]+> 3e5d      	mul	s2,s2,s5
[0-9a-f]+ <[^>]+> 3ee8      	mul	s7,s7,a4
[0-9a-f]+ <[^>]+> 3ccf      	mul	a2,a2,a3
[0-9a-f]+ <[^>]+> 3c2b      	mul	a5,a5,a7
[0-9a-f]+ <[^>]+> 3e3b      	mul	s1,s1,s3
[0-9a-f]+ <[^>]+> 3edc      	mul	s6,s6,s4
[0-9a-f]+ <[^>]+> 3ce9      	mul	a3,a3,a5
[0-9a-f]+ <[^>]+> 3c78      	mul	a7,a7,s0
[0-9a-f]+ <[^>]+> 3e5d      	mul	s2,s2,s5
[0-9a-f]+ <[^>]+> 3ee8      	mul	s7,s7,a4
[0-9a-f]+ <[^>]+> dbef      	beqc	a2,a3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC4_S1	.L11
[0-9a-f]+ <[^>]+> 88c6 0000 	beqc	a2,a2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	.L11
[0-9a-f]+ <[^>]+> dbef      	beqc	a2,a3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC4_S1	.L11
[0-9a-f]+ <[^>]+> 9b00      	beqzc	a2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	.L11
[0-9a-f]+ <[^>]+> 8000 c000 	nop
[0-9a-f]+ <[^>]+> db7f      	bnec	a3,a2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC4_S1	.L21
[0-9a-f]+ <[^>]+> db6f      	bnec	a2,a2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC4_S1	.L21
[0-9a-f]+ <[^>]+> db7f      	bnec	a3,a2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC4_S1	.L21
[0-9a-f]+ <[^>]+> bb00      	bnezc	a2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	.L21
[0-9a-f]+ <[^>]+> 8000 c000 	nop
#pass
