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
[0-9a-f]+ <[^>]+> 9400      	lw	t0,0\(t0\)
[0-9a-f]+ <[^>]+> 9521      	lw	t1,4\(t1\)
[0-9a-f]+ <[^>]+> 944a      	lw	t2,8\(t2\)
[0-9a-f]+ <[^>]+> 956b      	lw	t3,12\(t3\)
[0-9a-f]+ <[^>]+> 9404      	lw	t0,0\(a0\)
[0-9a-f]+ <[^>]+> 9525      	lw	t1,4\(a1\)
[0-9a-f]+ <[^>]+> 944e      	lw	t2,8\(a2\)
[0-9a-f]+ <[^>]+> 956f      	lw	t3,12\(a3\)
[0-9a-f]+ <[^>]+> 9410      	lw	t0,0\(s0\)
[0-9a-f]+ <[^>]+> 9531      	lw	t1,4\(s1\)
[0-9a-f]+ <[^>]+> 945a      	lw	t2,8\(s2\)
[0-9a-f]+ <[^>]+> 957b      	lw	t3,12\(s3\)
[0-9a-f]+ <[^>]+> 9414      	lw	t0,0\(s4\)
[0-9a-f]+ <[^>]+> 9535      	lw	t1,4\(s5\)
[0-9a-f]+ <[^>]+> 945e      	lw	t2,8\(s6\)
[0-9a-f]+ <[^>]+> 957f      	lw	t3,12\(s7\)
[0-9a-f]+ <[^>]+> 9480      	lw	a0,0\(t0\)
[0-9a-f]+ <[^>]+> 95a1      	lw	a1,4\(t1\)
[0-9a-f]+ <[^>]+> 94ca      	lw	a2,8\(t2\)
[0-9a-f]+ <[^>]+> 95eb      	lw	a3,12\(t3\)
[0-9a-f]+ <[^>]+> 9e00      	sw	s0,0\(t0\)
[0-9a-f]+ <[^>]+> 9f21      	sw	s1,4\(t1\)
[0-9a-f]+ <[^>]+> 9e4a      	sw	s2,8\(t2\)
[0-9a-f]+ <[^>]+> 9f6b      	sw	s3,12\(t3\)
[0-9a-f]+ <[^>]+> 9e80      	sw	s4,0\(t0\)
[0-9a-f]+ <[^>]+> 9fa1      	sw	s5,4\(t1\)
[0-9a-f]+ <[^>]+> 9eca      	sw	s6,8\(t2\)
[0-9a-f]+ <[^>]+> 9feb      	sw	s7,12\(t3\)
[0-9a-f]+ <[^>]+> 9e84      	sw	s4,0\(a0\)
[0-9a-f]+ <[^>]+> 9fa5      	sw	s5,4\(a1\)
[0-9a-f]+ <[^>]+> 9ece      	sw	s6,8\(a2\)
[0-9a-f]+ <[^>]+> 9fef      	sw	s7,12\(a3\)
[0-9a-f]+ <[^>]+> 9e90      	sw	s4,0\(s0\)
[0-9a-f]+ <[^>]+> 9fb1      	sw	s5,4\(s1\)
[0-9a-f]+ <[^>]+> 9eda      	sw	s6,8\(s2\)
[0-9a-f]+ <[^>]+> 9ffb      	sw	s7,12\(s3\)
[0-9a-f]+ <[^>]+> 9e94      	sw	s4,0\(s4\)
[0-9a-f]+ <[^>]+> 9fb5      	sw	s5,4\(s5\)
[0-9a-f]+ <[^>]+> 9ede      	sw	s6,8\(s6\)
[0-9a-f]+ <[^>]+> 9fff      	sw	s7,12\(s7\)
[0-9a-f]+ <[^>]+> 9c94      	sw	a0,0\(s4\)
[0-9a-f]+ <[^>]+> 9db5      	sw	a1,4\(s5\)
[0-9a-f]+ <[^>]+> 9cde      	sw	a2,8\(s6\)
[0-9a-f]+ <[^>]+> 9dff      	sw	a3,12\(s7\)
[0-9a-f]+ <[^>]+> 9e14      	sw	s0,0\(s4\)
[0-9a-f]+ <[^>]+> 9f35      	sw	s1,4\(s5\)
[0-9a-f]+ <[^>]+> 9e5e      	sw	s2,8\(s6\)
[0-9a-f]+ <[^>]+> 9f7f      	sw	s3,12\(s7\)
[0-9a-f]+ <[^>]+> 4803 8000 	brc	v1
[0-9a-f]+ <[^>]+> 4810 8200 	brsc	s0
[0-9a-f]+ <[^>]+> 4a11 8200 	balrsc	s0,s1
[0-9a-f]+ <[^>]+> 4bf1 8200 	balrsc	ra,s1
[0-9a-f]+ <[^>]+> 6062 0001 2345 	addiu	v1,gp,74565
[0-9a-f]+ <[^>]+> 6062 1234 5678 	addiu	v1,gp,305419896
[0-9a-f]+ <[^>]+> 6062 fffe dcbb 	addiu	v1,gp,-74565
[0-9a-f]+ <[^>]+> 6062 edcb a988 	addiu	v1,gp,-305419896
[0-9a-f]+ <[^>]+> 6061 0001 2345 	addiu	v1,v1,74565
[0-9a-f]+ <[^>]+> 6061 1234 5678 	addiu	v1,v1,305419896
[0-9a-f]+ <[^>]+> 6061 fffe dcbb 	addiu	v1,v1,-74565
[0-9a-f]+ <[^>]+> 6061 edcb a988 	addiu	v1,v1,-305419896
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
[0-9a-f]+ <[^>]+> 9008      	nop
	\.\.\.
