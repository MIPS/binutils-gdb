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
#pass
