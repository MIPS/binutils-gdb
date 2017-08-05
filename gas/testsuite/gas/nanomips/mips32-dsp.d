#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS DSP ASE for nanoMIPS
#as: -mdsp
#source: mips32-dsp.s

# Check MIPS DSP ASE for nanoMIPS Instruction Assembly

.*: +file format .*nanomips.*

Disassembly of section \.text:
0+0000 <text_label> 2041 000d 	addq.ph	zero,at,t4
0+0004 <text_label\+0x4> 2062 0c0d 	addq_s.ph	at,t4,t5
0+0008 <text_label\+0x8> 2083 1305 	addq_s.w	t4,t5,a0
0+000c <text_label\+0xc> 20a4 18cd 	addu.qb	t5,a0,a1
0+0010 <text_label\+0x10> 20c5 24cd 	addu_s.qb	a0,a1,a2
0+0014 <text_label\+0x14> 20e6 2a0d 	subq.ph	a1,a2,a3
0+0018 <text_label\+0x18> 2107 360d 	subq_s.ph	a2,a3,a4
0+001c <text_label\+0x1c> 2128 3b45 	subq_s.w	a3,a4,a5
0+0020 <text_label\+0x20> 2149 42cd 	subu.qb	a4,a5,a6
0+0024 <text_label\+0x24> 216a 4ecd 	subu_s.qb	a5,a6,a7
0+0028 <text_label\+0x28> 218b 5385 	addsc	a6,a7,t0
0+002c <text_label\+0x2c> 21ac 5bc5 	addwc	a7,t0,t1
0+0030 <text_label\+0x30> 21cd 6295 	modsub	t0,t1,t2
0+0034 <text_label\+0x34> 21ae f13f 	raddu.w.qb	t1,t2
0+0038 <text_label\+0x38> 21cf 113f 	absq_s.ph	t2,t3
0+003c <text_label\+0x3c> 21f0 213f 	absq_s.w	t3,s0
0+0040 <text_label\+0x40> 2251 80ad 	precrq.qb.ph	s0,s1,s2
0+0044 <text_label\+0x44> 2272 88ed 	precrq.ph.w	s1,s2,s3
0+0048 <text_label\+0x48> 2293 912d 	precrq_rs.ph.w	s2,s3,s4
0+004c <text_label\+0x4c> 22b4 996d 	precrqu_s.qb.ph	s3,s4,s5
0+0050 <text_label\+0x50> 2295 513f 	preceq.w.phl	s4,s5
0+0054 <text_label\+0x54> 22b6 613f 	preceq.w.phr	s5,s6
0+0058 <text_label\+0x58> 22d7 713f 	precequ.ph.qbl	s6,s7
0+005c <text_label\+0x5c> 22f8 913f 	precequ.ph.qbr	s7,t8
0+0060 <text_label\+0x60> 2319 733f 	precequ.ph.qbla	t8,t9
0+0064 <text_label\+0x64> 233a 933f 	precequ.ph.qbra	t9,k0
0+0068 <text_label\+0x68> 235b b13f 	preceu.ph.qbl	k0,k1
0+006c <text_label\+0x6c> 237c d13f 	preceu.ph.qbr	k1,gp
0+0070 <text_label\+0x70> 239d b33f 	preceu.ph.qbla	gp,sp
0+0074 <text_label\+0x74> 23be d33f 	preceu.ph.qbra	sp,fp
0+0078 <text_label\+0x78> 23df 087f 	shll.qb	fp,ra,0x0
0+007c <text_label\+0x7c> 23df e87f 	shll.qb	fp,ra,0x7
0+0080 <text_label\+0x80> 2001 fb95 	shllv.qb	ra,zero,at
0+0084 <text_label\+0x84> 2001 03b5 	shll.ph	zero,at,0x0
0+0088 <text_label\+0x88> 2001 f3b5 	shll.ph	zero,at,0xf
0+008c <text_label\+0x8c> 2043 0b8d 	shllv.ph	at,t4,t5
0+0090 <text_label\+0x90> 2043 0bb5 	shll_s.ph	t4,t5,0x0
0+0094 <text_label\+0x94> 2043 fbb5 	shll_s.ph	t4,t5,0xf
0+0098 <text_label\+0x98> 2085 1f8d 	shllv_s.ph	t5,a0,a1
0+009c <text_label\+0x9c> 2085 03f5 	shll_s.w	a0,a1,0x0
0+00a0 <text_label\+0xa0> 2085 fbf5 	shll_s.w	a0,a1,0x1f
0+00a4 <text_label\+0xa4> 20c7 2bd5 	shllv_s.w	a1,a2,a3
0+00a8 <text_label\+0xa8> 20c7 187f 	shrl.qb	a2,a3,0x0
0+00ac <text_label\+0xac> 20c7 f87f 	shrl.qb	a2,a3,0x7
0+00b0 <text_label\+0xb0> 2109 3b55 	shrlv.qb	a3,a4,a5
0+00b4 <text_label\+0xb4> 2109 0335 	shra.ph	a4,a5,0x0
0+00b8 <text_label\+0xb8> 2109 f335 	shra.ph	a4,a5,0xf
0+00bc <text_label\+0xbc> 214b 498d 	shrav.ph	a5,a6,a7
0+00c0 <text_label\+0xc0> 214b 0735 	shra_r.ph	a6,a7,0x0
0+00c4 <text_label\+0xc4> 214b f735 	shra_r.ph	a6,a7,0xf
0+00c8 <text_label\+0xc8> 218d 5d8d 	shrav_r.ph	a7,t0,t1
0+00cc <text_label\+0xcc> 218d 02f5 	shra_r.w	t0,t1,0x0
0+00d0 <text_label\+0xd0> 218d faf5 	shra_r.w	t0,t1,0x1f
0+00d4 <text_label\+0xd4> 21cf 6ad5 	shrav_r.w	t1,t2,t3
0+00d8 <text_label\+0xd8> 220f 7095 	muleu_s.ph.qbl	t2,t3,s0
0+00dc <text_label\+0xdc> 2230 78d5 	muleu_s.ph.qbr	t3,s0,s1
0+00e0 <text_label\+0xe0> 2251 8115 	mulq_rs.ph	s0,s1,s2
0+00e4 <text_label\+0xe4> 2272 8825 	muleq_s.w.phl	s1,s2,s3
0+00e8 <text_label\+0xe8> 2293 9065 	muleq_s.w.phr	s2,s3,s4
0+00ec <text_label\+0xec> 2293 20bf 	dpau.h.qbl	\$ac0,s3,s4
0+00f0 <text_label\+0xf0> 22b4 70bf 	dpau.h.qbr	\$ac1,s4,s5
0+00f4 <text_label\+0xf4> 22d5 a4bf 	dpsu.h.qbl	\$ac2,s5,s6
0+00f8 <text_label\+0xf8> 22f6 f4bf 	dpsu.h.qbr	\$ac3,s6,s7
0+00fc <text_label\+0xfc> 2317 02bf 	dpaq_s.w.ph	\$ac0,s7,t8
0+0100 <text_label\+0x100> 2338 46bf 	dpsq_s.w.ph	\$ac1,t8,t9
0+0104 <text_label\+0x104> 2359 bcbf 	mulsaq_s.w.ph	\$ac2,t9,k0
0+0108 <text_label\+0x108> 237a d2bf 	dpaq_sa.l.w	\$ac3,k0,k1
0+010c <text_label\+0x10c> 239b 16bf 	dpsq_sa.l.w	\$ac0,k1,gp
0+0110 <text_label\+0x110> 23bc 5a7f 	maq_s.w.phl	\$ac1,gp,sp
0+0114 <text_label\+0x114> 23dd 8a7f 	maq_s.w.phr	\$ac2,sp,fp
0+0118 <text_label\+0x118> 23fe fa7f 	maq_sa.w.phl	\$ac3,fp,ra
0+011c <text_label\+0x11c> 201f 2a7f 	maq_sa.w.phr	\$ac0,ra,zero
0+0120 <text_label\+0x120> 8001 d01f 	bitrev	zero,at
0+0124 <text_label\+0x124> 2022 413f 	insv	at,t4
0+0128 <text_label\+0x128> 2040 05ff 	repl.qb	t4,0x0
0+012c <text_label\+0x12c> 205f e5ff 	repl.qb	t4,0xff
0+0130 <text_label\+0x130> 2064 133f 	replv.qb	t5,a0
0+0134 <text_label\+0x134> 2090 003d 	repl.ph	a0,-512
0+0138 <text_label\+0x138> 208f f83d 	repl.ph	a0,511
0+013c <text_label\+0x13c> 20a6 033f 	replv.ph	a1,a2
0+0140 <text_label\+0x140> 20e6 0245 	cmpu.eq.qb	a2,a3
0+0144 <text_label\+0x144> 2107 0285 	cmpu.lt.qb	a3,a4
0+0148 <text_label\+0x148> 2128 02c5 	cmpu.le.qb	a4,a5
0+014c <text_label\+0x14c> 216a 48c5 	cmpgu.eq.qb	a5,a6,a7
0+0150 <text_label\+0x150> 218b 5105 	cmpgu.lt.qb	a6,a7,t0
0+0154 <text_label\+0x154> 21ac 5945 	cmpgu.le.qb	a7,t0,t1
0+0158 <text_label\+0x158> 21ac 0005 	cmp.eq.ph	t0,t1
0+015c <text_label\+0x15c> 21cd 0045 	cmp.lt.ph	t1,t2
0+0160 <text_label\+0x160> 21ee 0085 	cmp.le.ph	t2,t3
0+0164 <text_label\+0x164> 2230 79ed 	pick.qb	t3,s0,s1
0+0168 <text_label\+0x168> 2251 822d 	pick.ph	s0,s1,s2
0+016c <text_label\+0x16c> 2272 89ad 	packrl.ph	s1,s2,s3
0+0170 <text_label\+0x170> 2240 4e7f 	extr.w	s2,\$ac1,0x0
0+0174 <text_label\+0x174> 225f 4e7f 	extr.w	s2,\$ac1,0x1f
0+0178 <text_label\+0x178> 2260 9e7f 	extr_r.w	s3,\$ac2,0x0
0+017c <text_label\+0x17c> 227f 9e7f 	extr_r.w	s3,\$ac2,0x1f
0+0180 <text_label\+0x180> 2280 ee7f 	extr_rs.w	s4,\$ac3,0x0
0+0184 <text_label\+0x184> 229f ee7f 	extr_rs.w	s4,\$ac3,0x1f
0+0188 <text_label\+0x188> 22a0 3e7f 	extr_s.h	s5,\$ac0,0x0
0+018c <text_label\+0x18c> 22bf 3e7f 	extr_s.h	s5,\$ac0,0x1f
0+0190 <text_label\+0x190> 22d7 7ebf 	extrv_s.h	s6,\$ac1,s7
0+0194 <text_label\+0x194> 22f8 8ebf 	extrv.w	s7,\$ac2,t8
0+0198 <text_label\+0x198> 2319 debf 	extrv_r.w	t8,\$ac3,t9
0+019c <text_label\+0x19c> 233a 2ebf 	extrv_rs.w	t9,\$ac0,k0
0+01a0 <text_label\+0x1a0> 2340 667f 	extp	k0,\$ac1,0x0
0+01a4 <text_label\+0x1a4> 235f 667f 	extp	k0,\$ac1,0x1f
0+01a8 <text_label\+0x1a8> 237c a8bf 	extpv	k1,\$ac2,gp
0+01ac <text_label\+0x1ac> 2380 f67f 	extpdp	gp,\$ac3,0x0
0+01b0 <text_label\+0x1b0> 239f f67f 	extpdp	gp,\$ac3,0x1f
0+01b4 <text_label\+0x1b4> 23be 38bf 	extpdpv	sp,\$ac0,fp
0+01b8 <text_label\+0x1b8> 2020 401d 	shilo	\$ac1,-32
0+01bc <text_label\+0x1bc> 201f 401d 	shilo	\$ac1,31
0+01c0 <text_label\+0x1c0> 201e 927f 	shilov	\$ac2,fp
0+01c4 <text_label\+0x1c4> 201f c27f 	mthlip	ra,\$ac3
0+01c8 <text_label\+0x1c8> 2000 007f 	mfhi	zero,\$ac0
0+01cc <text_label\+0x1cc> 2020 507f 	mflo	at,\$ac1
0+01d0 <text_label\+0x1d0> 2002 a07f 	mthi	t4,\$ac2
0+01d4 <text_label\+0x1d4> 2003 f07f 	mtlo	t5,\$ac3
0+01d8 <text_label\+0x1d8> 2080 167f 	wrdsp	a0,0x0
0+01dc <text_label\+0x1dc> 208f d67f 	wrdsp	a0,0x3f
0+01e0 <text_label\+0x1e0> 20bf d67f 	wrdsp	a1
0+01e4 <text_label\+0x1e4> 20c0 067f 	rddsp	a2,0x0
0+01e8 <text_label\+0x1e8> 20cf c67f 	rddsp	a2,0x3f
0+01ec <text_label\+0x1ec> 20ff c67f 	rddsp	a3
0+01f0 <text_label\+0x1f0> 2149 4107 	lbux	a4,a5\(a6\)
0+01f4 <text_label\+0x1f4> 216a 4a07 	lhx	a5,a6\(a7\)
0+01f8 <text_label\+0x1f8> 218b 5407 	lwx	a6,a7\(t0\)
0+01fc <text_label\+0x1fc> 8804 4000 	bposge32c	00000000 <text_label>
			1fc: R_NANOMIPS_PC14_S1	text_label
0+0200 <text_label\+0x200> 9008      	nop
0+0202 <text_label\+0x202> 218b 8abf 	madd	\$ac2,a7,t0
0+0206 <text_label\+0x206> 21ac dabf 	maddu	\$ac3,t0,t1
0+020a <text_label\+0x20a> 21cd 2abf 	msub	\$ac0,t1,t2
0+020e <text_label\+0x20e> 21ee 7abf 	msubu	\$ac1,t2,t3
0+0212 <text_label\+0x212> 22d5 ccbf 	mult	\$ac3,s5,s6
0+0216 <text_label\+0x216> 22f6 1cbf 	multu	\$ac0,s6,s7
0+021a <text_label\+0x21a> 9008      	nop
	\.\.\.
