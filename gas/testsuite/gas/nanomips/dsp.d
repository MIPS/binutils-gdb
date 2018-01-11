#objdump: -dr --prefix-addresses --show-raw-insn
#name: DSP ASE for nanoMIPS
#as: -mdsp
#source: dsp.s

# Check MIPS DSP ASE for nanoMIPS Instruction Assembly

.*: +file format .*nanomips.*

Disassembly of section \.text:
[0-9a-f]+ <text_label> 2041 000d 	addq.ph	zero,at,t4
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2062 0c0d 	addq_s.ph	at,t4,t5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2083 1305 	addq_s.w	t4,t5,a0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 20a4 18cd 	addu.qb	t5,a0,a1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 20c5 24cd 	addu_s.qb	a0,a1,a2
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 20e6 2a0d 	subq.ph	a1,a2,a3
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2107 360d 	subq_s.ph	a2,a3,a4
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2128 3b45 	subq_s.w	a3,a4,a5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2149 42cd 	subu.qb	a4,a5,a6
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 216a 4ecd 	subu_s.qb	a5,a6,a7
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 218b 5385 	addsc	a6,a7,t0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 21ac 5bc5 	addwc	a7,t0,t1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 21cd 6295 	modsub	t0,t1,t2
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 21ae f13f 	raddu.w.qb	t1,t2
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 21cf 113f 	absq_s.ph	t2,t3
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 21f0 213f 	absq_s.w	t3,s0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2251 80ad 	precrq.qb.ph	s0,s1,s2
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2272 88ed 	precrq.ph.w	s1,s2,s3
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2293 912d 	precrq_rs.ph.w	s2,s3,s4
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 22b4 996d 	precrqu_s.qb.ph	s3,s4,s5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2295 513f 	preceq.w.phl	s4,s5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 22b6 613f 	preceq.w.phr	s5,s6
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 22d7 713f 	precequ.ph.qbl	s6,s7
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 22f8 913f 	precequ.ph.qbr	s7,t8
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2319 733f 	precequ.ph.qbla	t8,t9
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 233a 933f 	precequ.ph.qbra	t9,k0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 235b b13f 	preceu.ph.qbl	k0,k1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 237c d13f 	preceu.ph.qbr	k1,gp
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 239d b33f 	preceu.ph.qbla	gp,sp
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 23be d33f 	preceu.ph.qbra	sp,fp
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 23df 087f 	shll.qb	fp,ra,0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 23df e87f 	shll.qb	fp,ra,7
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2001 fb95 	shllv.qb	ra,zero,at
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2001 03b5 	shll.ph	zero,at,0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2001 f3b5 	shll.ph	zero,at,15
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2043 0b8d 	shllv.ph	at,t4,t5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2043 0bb5 	shll_s.ph	t4,t5,0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2043 fbb5 	shll_s.ph	t4,t5,15
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2085 1f8d 	shllv_s.ph	t5,a0,a1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2085 03f5 	shll_s.w	a0,a1,0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2085 fbf5 	shll_s.w	a0,a1,31
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 20c7 2bd5 	shllv_s.w	a1,a2,a3
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 20c7 187f 	shrl.qb	a2,a3,0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 20c7 f87f 	shrl.qb	a2,a3,7
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2109 3b55 	shrlv.qb	a3,a4,a5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2109 0335 	shra.ph	a4,a5,0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2109 f335 	shra.ph	a4,a5,15
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 214b 498d 	shrav.ph	a5,a6,a7
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 214b 0735 	shra_r.ph	a6,a7,0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 214b f735 	shra_r.ph	a6,a7,15
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 218d 5d8d 	shrav_r.ph	a7,t0,t1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 218d 02f5 	shra_r.w	t0,t1,0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 218d faf5 	shra_r.w	t0,t1,31
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 21cf 6ad5 	shrav_r.w	t1,t2,t3
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 220f 7095 	muleu_s.ph.qbl	t2,t3,s0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2230 78d5 	muleu_s.ph.qbr	t3,s0,s1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2251 8115 	mulq_rs.ph	s0,s1,s2
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2272 8825 	muleq_s.w.phl	s1,s2,s3
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2293 9065 	muleq_s.w.phr	s2,s3,s4
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2293 20bf 	dpau.h.qbl	\$ac0,s3,s4
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 22b4 70bf 	dpau.h.qbr	\$ac1,s4,s5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 22d5 a4bf 	dpsu.h.qbl	\$ac2,s5,s6
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 22f6 f4bf 	dpsu.h.qbr	\$ac3,s6,s7
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2317 02bf 	dpaq_s.w.ph	\$ac0,s7,t8
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2338 46bf 	dpsq_s.w.ph	\$ac1,t8,t9
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2359 bcbf 	mulsaq_s.w.ph	\$ac2,t9,k0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 237a d2bf 	dpaq_sa.l.w	\$ac3,k0,k1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 239b 16bf 	dpsq_sa.l.w	\$ac0,k1,gp
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 23bc 5a7f 	maq_s.w.phl	\$ac1,gp,sp
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 23dd 8a7f 	maq_s.w.phr	\$ac2,sp,fp
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 23fe fa7f 	maq_sa.w.phl	\$ac3,fp,ra
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 201f 2a7f 	maq_sa.w.phr	\$ac0,ra,zero
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2001 313f 	bitrev	zero,at
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2022 413f 	insv	at,t4
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2040 05ff 	repl.qb	t4,0x0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 205f e5ff 	repl.qb	t4,0xff
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2064 133f 	replv.qb	t5,a0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2090 003d 	repl.ph	a0,-512
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 208f f83d 	repl.ph	a0,511
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 20a6 033f 	replv.ph	a1,a2
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 20e6 0245 	cmpu.eq.qb	a2,a3
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2107 0285 	cmpu.lt.qb	a3,a4
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2128 02c5 	cmpu.le.qb	a4,a5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 216a 48c5 	cmpgu.eq.qb	a5,a6,a7
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 218b 5105 	cmpgu.lt.qb	a6,a7,t0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 21ac 5945 	cmpgu.le.qb	a7,t0,t1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 21ac 0005 	cmp.eq.ph	t0,t1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 21cd 0045 	cmp.lt.ph	t1,t2
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 21ee 0085 	cmp.le.ph	t2,t3
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2230 79ed 	pick.qb	t3,s0,s1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2251 822d 	pick.ph	s0,s1,s2
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2272 89ad 	packrl.ph	s1,s2,s3
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2240 4e7f 	extr.w	s2,\$ac1,0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 225f 4e7f 	extr.w	s2,\$ac1,31
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2260 9e7f 	extr_r.w	s3,\$ac2,0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 227f 9e7f 	extr_r.w	s3,\$ac2,31
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2280 ee7f 	extr_rs.w	s4,\$ac3,0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 229f ee7f 	extr_rs.w	s4,\$ac3,31
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 22a0 3e7f 	extr_s.h	s5,\$ac0,0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 22bf 3e7f 	extr_s.h	s5,\$ac0,31
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 22d7 7ebf 	extrv_s.h	s6,\$ac1,s7
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 22f8 8ebf 	extrv.w	s7,\$ac2,t8
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2319 debf 	extrv_r.w	t8,\$ac3,t9
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 233a 2ebf 	extrv_rs.w	t9,\$ac0,k0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2340 667f 	extp	k0,\$ac1,0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 235f 667f 	extp	k0,\$ac1,31
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 237c a8bf 	extpv	k1,\$ac2,gp
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2380 f67f 	extpdp	gp,\$ac3,0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 239f f67f 	extpdp	gp,\$ac3,31
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 23be 38bf 	extpdpv	sp,\$ac0,fp
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2020 401d 	shilo	\$ac1,-32
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 201f 401d 	shilo	\$ac1,31
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 201e 927f 	shilov	\$ac2,fp
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 201f c27f 	mthlip	ra,\$ac3
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2000 007f 	mfhi	zero,\$ac0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2020 507f 	mflo	at,\$ac1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2002 a07f 	mthi	t4,\$ac2
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2003 f07f 	mtlo	t5,\$ac3
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2080 167f 	wrdsp	a0,0x0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 208f d67f 	wrdsp	a0,0x3f
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 20bf d67f 	wrdsp	a1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 20c0 067f 	rddsp	a2,0x0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 20cf c67f 	rddsp	a2,0x3f
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 20ff c67f 	rddsp	a3
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 2149 4107 	lbux	a4,a5\(a6\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 216a 4a07 	lhx	a5,a6\(a7\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 218b 5407 	lwx	a6,a7\(t0\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 8804 4000 	bposge32c	00000000 <text_label>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	text_label
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 9008      	nop
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 218b 8abf 	madd	\$ac2,a7,t0
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 21ac dabf 	maddu	\$ac3,t0,t1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 21cd 2abf 	msub	\$ac0,t1,t2
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 21ee 7abf 	msubu	\$ac1,t2,t3
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 22d5 ccbf 	mult	\$ac3,s5,s6
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 22f6 1cbf 	multu	\$ac0,s6,s7
[0-9a-f]+ <text_label\+0x[0-9a-f]+> 9008      	nop
	\.\.\.
