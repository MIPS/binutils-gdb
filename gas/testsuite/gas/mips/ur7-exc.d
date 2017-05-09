#objdump: -dr --prefix-addresses --show-raw-insn
#name: New MIPSR7 instructions
#as: -mmicromips -mips32r7
#source: ur7-exc.s

# Check exclusive MIPSR7 instructions

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> bc01      	movep	a0,a1,t1,t0
[0-9a-f]+ <[^>]+> bd43      	movep	a1,a2,zero,t2
[0-9a-f]+ <[^>]+> bc8d      	movep	a2,a3,a1,a0
[0-9a-f]+ <[^>]+> bdcf      	movep	a3,t0,a3,a2
[0-9a-f]+ <[^>]+> be30      	movep	a0,a1,s0,s1
[0-9a-f]+ <[^>]+> bf72      	movep	a1,a2,s2,s3
[0-9a-f]+ <[^>]+> bebc      	movep	a2,a3,s4,s5
[0-9a-f]+ <[^>]+> bffe      	movep	a3,t0,s6,s7
[0-9a-f]+ <[^>]+> fce0      	movep	t0,a3,a0,a1
[0-9a-f]+ <[^>]+> fdc1      	movep	t1,a2,a1,a2
[0-9a-f]+ <[^>]+> fcaa      	movep	t2,a1,a2,a3
[0-9a-f]+ <[^>]+> fd8b      	movep	t3,a0,a3,t0
[0-9a-f]+ <[^>]+> fe90      	movep	s0,s4,a0,a1
[0-9a-f]+ <[^>]+> ff35      	movep	s5,s1,a1,a2
[0-9a-f]+ <[^>]+> feda      	movep	s2,s6,a2,a3
[0-9a-f]+ <[^>]+> ff7f      	movep	s7,s3,a3,t0
[0-9a-f]+ <[^>]+> 7400      	lw	t0,0\(t0\)
[0-9a-f]+ <[^>]+> 7521      	lw	t1,4\(t1\)
[0-9a-f]+ <[^>]+> 744a      	lw	t2,8\(t2\)
[0-9a-f]+ <[^>]+> 756b      	lw	t3,12\(t3\)
[0-9a-f]+ <[^>]+> 7404      	lw	t0,0\(a0\)
[0-9a-f]+ <[^>]+> 7525      	lw	t1,4\(a1\)
[0-9a-f]+ <[^>]+> 744e      	lw	t2,8\(a2\)
[0-9a-f]+ <[^>]+> 756f      	lw	t3,12\(a3\)
[0-9a-f]+ <[^>]+> 7410      	lw	t0,0\(s0\)
[0-9a-f]+ <[^>]+> 7531      	lw	t1,4\(s1\)
[0-9a-f]+ <[^>]+> 745a      	lw	t2,8\(s2\)
[0-9a-f]+ <[^>]+> 757b      	lw	t3,12\(s3\)
[0-9a-f]+ <[^>]+> 7414      	lw	t0,0\(s4\)
[0-9a-f]+ <[^>]+> 7535      	lw	t1,4\(s5\)
[0-9a-f]+ <[^>]+> 745e      	lw	t2,8\(s6\)
[0-9a-f]+ <[^>]+> 757f      	lw	t3,12\(s7\)
[0-9a-f]+ <[^>]+> 7480      	lw	a0,0\(t0\)
[0-9a-f]+ <[^>]+> 75a1      	lw	a1,4\(t1\)
[0-9a-f]+ <[^>]+> 74ca      	lw	a2,8\(t2\)
[0-9a-f]+ <[^>]+> 75eb      	lw	a3,12\(t3\)
[0-9a-f]+ <[^>]+> f600      	sw	s0,0\(t0\)
[0-9a-f]+ <[^>]+> f721      	sw	s1,4\(t1\)
[0-9a-f]+ <[^>]+> f64a      	sw	s2,8\(t2\)
[0-9a-f]+ <[^>]+> f76b      	sw	s3,12\(t3\)
[0-9a-f]+ <[^>]+> f680      	sw	s4,0\(t0\)
[0-9a-f]+ <[^>]+> f7a1      	sw	s5,4\(t1\)
[0-9a-f]+ <[^>]+> f6ca      	sw	s6,8\(t2\)
[0-9a-f]+ <[^>]+> f7eb      	sw	s7,12\(t3\)
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
[0-9a-f]+ <[^>]+> 4803 8000 	brc	v1
[0-9a-f]+ <[^>]+> 4810 8200 	brsc	s0
[0-9a-f]+ <[^>]+> 4a11 8200 	balrsc	s0,s1
[0-9a-f]+ <[^>]+> 4bf1 8200 	balrsc	ra,s1
[0-9a-f]+ <[^>]+> 446d 2345 	addiu	v1,gp,74565
[0-9a-f]+ <[^>]+> 6062 5678 1234 	addiu	v1,gp,305419896
[0-9a-f]+ <[^>]+> 6062 dcbb fffe 	addiu	v1,gp,-74565
[0-9a-f]+ <[^>]+> 6062 a988 edcb 	addiu	v1,gp,-305419896
[0-9a-f]+ <[^>]+> 6061 2345 0001 	addiu	v1,v1,74565
[0-9a-f]+ <[^>]+> 6061 5678 1234 	addiu	v1,v1,305419896
[0-9a-f]+ <[^>]+> 6061 dcbb fffe 	addiu	v1,v1,-74565
[0-9a-f]+ <[^>]+> 6061 a988 edcb 	addiu	v1,v1,-305419896
[0-9a-f]+ <[^>]+> c84c 0800 	bgeiuc	v0,1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC11_S1	test-0x4
[0-9a-f]+ <[^>]+> c84f f800 	bgeiuc	v0,127,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC11_S1	test-0x4
[0-9a-f]+ <[^>]+> c85c 0800 	bltiuc	v0,1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC11_S1	test-0x4
[0-9a-f]+ <[^>]+> c85f f800 	bltiuc	v0,127,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC11_S1	test-0x4
[0-9a-f]+ <[^>]+> 2062 201f 	extw	a0,v0,v1,0x0
[0-9a-f]+ <[^>]+> 2062 261f 	extw	a0,v0,v1,0x18
[0-9a-f]+ <[^>]+> 2062 241f 	extw	a0,v0,v1,0x10
[0-9a-f]+ <[^>]+> 2062 221f 	extw	a0,v0,v1,0x8
[0-9a-f]+ <[^>]+> 2062 205f 	extw	a0,v0,v1,0x1
[0-9a-f]+ <[^>]+> 2062 209f 	extw	a0,v0,v1,0x2
[0-9a-f]+ <[^>]+> 2062 20df 	extw	a0,v0,v1,0x3
[0-9a-f]+ <[^>]+> 2062 211f 	extw	a0,v0,v1,0x4
[0-9a-f]+ <[^>]+> 2002 2290 	move	a0,v0
[0-9a-f]+ <[^>]+> 2062 261f 	extw	a0,v0,v1,0x18
[0-9a-f]+ <[^>]+> 2062 241f 	extw	a0,v0,v1,0x10
[0-9a-f]+ <[^>]+> 2062 221f 	extw	a0,v0,v1,0x8
[0-9a-f]+ <[^>]+> 5359      	lwxs	a0,a1\(a2\)
[0-9a-f]+ <[^>]+> 508f      	lwxs	a3,s0\(s1\)
[0-9a-f]+ <[^>]+> 5235      	lwxs	s2,s3\(a0\)
[0-9a-f]+ <[^>]+> 4200 0003 	sw	s0,0\(gp\)
			104: R_MICROMIPS_GPREL19_S2	x
[0-9a-f]+ <[^>]+> 4220 0013 	sw	s1,16\(gp\)
[0-9a-f]+ <[^>]+> d484      	sw	s1,16\(gp\)
[0-9a-f]+ <[^>]+> d480      	sw	s1,0\(gp\)
			10e: R_MICROMIPS_GPREL7_S2	test
[0-9a-f]+ <[^>]+> 04a0 0000 	addiupc	a1,00000114 <[^>]+>
			110: R_MICROMIPS_PC21_S1	test-0x4
[0-9a-f]+ <[^>]+> 04a0 0000 	addiupc	a1,00000118 <[^>]+>
			114: R_MICROMIPS_PC21_S1	test2-0x4
[0-9a-f]+ <[^>]+> 8483 3fa0 	pref	0x4,4000\(v1\)
[0-9a-f]+ <[^>]+> a483 98e2 	pref	0x4,-30\(v1\)
[0-9a-f]+ <[^>]+> 8483 3000 	pref	0x4,0\(v1\)
			120: R_MICROMIPS_LO12	test
[0-9a-f]+ <[^>]+> c484 c000 	bbeqzc	a0,0x18,00000128 <[^>]+>
			124: R_MICROMIPS_PC11_S1	test-0x4
[0-9a-f]+ <[^>]+> c484 0800 	bbeqzc	a0,0x1,0000012c <[^>]+>
			128: R_MICROMIPS_PC11_S1	test-0x4
[0-9a-f]+ <[^>]+> c484 f800 	bbeqzc	a0,0x1f,00000130 <[^>]+>
			12c: R_MICROMIPS_PC11_S1	test-0x4
[0-9a-f]+ <[^>]+> c484 0000 	bbeqzc	a0,0x0,00000134 <[^>]+>
			130: R_MICROMIPS_PC11_S1	test-0x4
[0-9a-f]+ <[^>]+> c485 2000 	bbeqzc	a0,0x24,00000138 <[^>]+>
			134: R_MICROMIPS_PC11_S1	test-0x4
[0-9a-f]+ <[^>]+> 2083 0000 	teq	v1,a0
[0-9a-f]+ <[^>]+> 20c5 0400 	tne	a1,a2
[0-9a-f]+ <[^>]+> 3c02      	addu	t0,t0,t2
[0-9a-f]+ <[^>]+> 3e96      	addu	s4,s4,s6
[0-9a-f]+ <[^>]+> 0460 0000 	addiupc	v1,00000148 <[^>]+>
			144: R_MICROMIPS_PC21_S1	\*ABS\*\+0xffffffa
[0-9a-f]+ <[^>]+> 606b 2710 0000 	lwpc	v1,0000285f <[^>]+>
			14a: R_MICROMIPS_PC32	\*ABS\*\+0x2710
[0-9a-f]+ <[^>]+> 606f 2710 0000 	swpc	v1,00002865 <[^>]+>
			150: R_MICROMIPS_PC32	\*ABS\*\+0x2710
[0-9a-f]+ <[^>]+> 60bb 2710 0000 	ldpc	a1,0000286b <[^>]+>
			156: R_MICROMIPS_PC32	\*ABS\*\+0x2710
[0-9a-f]+ <[^>]+> 611f 2710 0000 	sdpc	t0,00002871 <[^>]+>
			15c: R_MICROMIPS_PC32	\*ABS\*\+0x2710
[0-9a-f]+ <[^>]+> 6063 0000 0000 	addiupc	v1,00000167 <[^>]+>
			162: R_MICROMIPS_PC32	test
[0-9a-f]+ <[^>]+> 606b 0000 0000 	lwpc	v1,0000016d <[^>]+>
			168: R_MICROMIPS_PC32	test
[0-9a-f]+ <[^>]+> 606f 0000 0000 	swpc	v1,00000173 <[^>]+>
			16e: R_MICROMIPS_PC32	test
[0-9a-f]+ <[^>]+> 60bb 0000 0000 	ldpc	a1,00000179 <[^>]+>
			174: R_MICROMIPS_PC32	test
[0-9a-f]+ <[^>]+> 611f 0000 0000 	sdpc	t0,0000017f <[^>]+>
			17a: R_MICROMIPS_PC32	test
[0-9a-f]+ <[^>]+> a445 2104 	ualh	v0,4\(a1\)
[0-9a-f]+ <[^>]+> a445 2904 	uash	v0,4\(a1\)
[0-9a-f]+ <[^>]+> a445 4504 	ualwm	v0,4\(a1\),4
[0-9a-f]+ <[^>]+> a445 6d04 	uaswm	v0,4\(a1\),6
[0-9a-f]+ <[^>]+> a445 1504 	ualwm	v0,4\(a1\),1
[0-9a-f]+ <[^>]+> a445 1d04 	uaswm	v0,4\(a1\),1
[0-9a-f]+ <[^>]+> a445 0504 	ualwm	v0,4\(a1\),8
[0-9a-f]+ <[^>]+> a445 7d04 	uaswm	v0,4\(a1\),7
[0-9a-f]+ <[^>]+> a445 0404 	lwm	v0,4\(a1\),8
[0-9a-f]+ <[^>]+> a445 7c04 	swm	v0,4\(a1\),7
[0-9a-f]+ <[^>]+> a445 4704 	ualdm	v0,4\(a1\),4
[0-9a-f]+ <[^>]+> a445 6f04 	uasdm	v0,4\(a1\),6
[0-9a-f]+ <[^>]+> a445 1704 	ualdm	v0,4\(a1\),1
[0-9a-f]+ <[^>]+> a445 1f04 	uasdm	v0,4\(a1\),1
[0-9a-f]+ <[^>]+> a445 0704 	ualdm	v0,4\(a1\),8
[0-9a-f]+ <[^>]+> a445 7f04 	uasdm	v0,4\(a1\),7
[0-9a-f]+ <[^>]+> a445 0604 	ldm	v0,4\(a1\),8
[0-9a-f]+ <[^>]+> a445 7e04 	sdm	v0,4\(a1\),7
[0-9a-f]+ <[^>]+> 8043 d7c5 	rotx	v0,v1,0x5,30,1
[0-9a-f]+ <[^>]+> 8043 d01f 	bitrev	v0,v1
[0-9a-f]+ <[^>]+> 8043 d01f 	bitrev	v0,v1
[0-9a-f]+ <[^>]+> 8043 d247 	bitswap	v0,v1
[0-9a-f]+ <[^>]+> 8043 d247 	bitswap	v0,v1
[0-9a-f]+ <[^>]+> 8043 d40f 	bitswaph	v0,v1
[0-9a-f]+ <[^>]+> 8043 d40f 	bitswaph	v0,v1
[0-9a-f]+ <[^>]+> 8043 d218 	byterev	v0,v1
[0-9a-f]+ <[^>]+> 8043 d218 	byterev	v0,v1
[0-9a-f]+ <[^>]+> 8043 d608 	wsbh	v0,v1
[0-9a-f]+ <[^>]+> 8043 d608 	wsbh	v0,v1
[0-9a-f]+ <[^>]+> 9008      	nop
	\.\.\.
