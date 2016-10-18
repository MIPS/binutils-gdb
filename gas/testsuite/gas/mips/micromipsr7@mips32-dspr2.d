#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS DSP ASE Rev2 for MIPS32R7
#as: -mdspr2 -32
#source: mips32-dspr2.s

# Check MIPS DSP ASE Rev2 for MIPS32R7 Instruction Assembly \(microMIPS\)

.*: +file format .*mips.*

Disassembly of section .text:
0+0000 <text_label> 2001 013f 	absq_s.qb	zero,at
0+0004 <text_label\+0x4> 2062 090d 	addu.ph	at,v0,v1
0+0008 <text_label\+0x8> 2083 150d 	addu_s.ph	v0,v1,a0
0+000c <text_label\+0xc> 20a4 194d 	adduh.qb	v1,a0,a1
0+0010 <text_label\+0x10> 20c5 254d 	adduh_r.qb	a0,a1,a2
0+0014 <text_label\+0x14> 20a6 0215 	append	a1,a2,0x0
0+0018 <text_label\+0x18> 20a6 fa15 	append	a1,a2,0x1f
0+001c <text_label\+0x1c> 20c7 08bf 	balign	a2,a3,0x0
0+0020 <text_label\+0x20> 20c7 48bf 	balign	a2,a3,0x1
0+0024 <text_label\+0x24> 20c7 88bf 	balign	a2,a3,0x2
0+0028 <text_label\+0x28> 20c7 c8bf 	balign	a2,a3,0x3
0+002c <text_label\+0x2c> 2107 3185 	cmpgdu.eq.qb	a2,a3,t0
0+0030 <text_label\+0x30> 2128 39c5 	cmpgdu.lt.qb	a3,t0,t1
0+0034 <text_label\+0x34> 2149 4205 	cmpgdu.le.qb	t0,t1,t2
0+0038 <text_label\+0x38> 2149 00bf 	dpa.w.ph	\$ac0,t1,t2
0+003c <text_label\+0x3c> 216a 44bf 	dps.w.ph	\$ac1,t2,t3
0+0040 <text_label\+0x40> 218b 8abf 	madd	\$ac2,t3,t4
0+0044 <text_label\+0x44> 21ac dabf 	maddu	\$ac3,t4,t5
0+0048 <text_label\+0x48> 21cd 2abf 	msub	\$ac0,t5,t6
0+004c <text_label\+0x4c> 21ee 7abf 	msubu	\$ac1,t6,t7
0+0050 <text_label\+0x50> 2230 782d 	mul.ph	t7,s0,s1
0+0054 <text_label\+0x54> 2251 842d 	mul_s.ph	s0,s1,s2
0+0058 <text_label\+0x58> 2272 8995 	mulq_rs.w	s1,s2,s3
0+005c <text_label\+0x5c> 2293 9155 	mulq_s.ph	s2,s3,s4
0+0060 <text_label\+0x60> 22b4 99d5 	mulq_s.w	s3,s4,s5
0+0064 <text_label\+0x64> 22b4 acbf 	mulsa.w.ph	\$ac2,s4,s5
0+0068 <text_label\+0x68> 22d5 ccbf 	mult	\$ac3,s5,s6
0+006c <text_label\+0x6c> 22f6 1cbf 	multu	\$ac0,s6,s7
0+0070 <text_label\+0x70> 2338 b86d 	precr.qb.ph	s7,t8,t9
0+0074 <text_label\+0x74> 2319 03cd 	precr_sra.ph.w	t8,t9,0x0
0+0078 <text_label\+0x78> 2319 fbcd 	precr_sra.ph.w	t8,t9,0x1f
0+007c <text_label\+0x7c> 233a 07cd 	precr_sra_r.ph.w	t9,k0,0x0
0+0080 <text_label\+0x80> 233a ffcd 	precr_sra_r.ph.w	t9,k0,0x1f
0+0084 <text_label\+0x84> 235b 0255 	prepend	k0,k1,0x0
0+0088 <text_label\+0x88> 235b fa55 	prepend	k0,k1,0x1f
0+008c <text_label\+0x8c> 237c 01ff 	shra.qb	k1,gp,0x0
0+0090 <text_label\+0x90> 237c e1ff 	shra.qb	k1,gp,0x7
0+0094 <text_label\+0x94> 239d 11ff 	shra_r.qb	gp,sp,0x0
0+0098 <text_label\+0x98> 239d f1ff 	shra_r.qb	gp,sp,0x7
0+009c <text_label\+0x9c> 23fe e9cd 	shrav.qb	sp,s8,ra
0+00a0 <text_label\+0xa0> 201f f5cd 	shrav_r.qb	s8,ra,zero
0+00a4 <text_label\+0xa4> 23e0 03ff 	shrl.ph	ra,zero,0x0
0+00a8 <text_label\+0xa8> 23e0 f3ff 	shrl.ph	ra,zero,0xf
0+00ac <text_label\+0xac> 2041 0315 	shrlv.ph	zero,at,v0
0+00b0 <text_label\+0xb0> 2062 0b0d 	subu.ph	at,v0,v1
0+00b4 <text_label\+0xb4> 2083 170d 	subu_s.ph	v0,v1,a0
0+00b8 <text_label\+0xb8> 20a4 1b4d 	subuh.qb	v1,a0,a1
0+00bc <text_label\+0xbc> 20c5 274d 	subuh_r.qb	a0,a1,a2
0+00c0 <text_label\+0xc0> 20e6 284d 	addqh.ph	a1,a2,a3
0+00c4 <text_label\+0xc4> 2107 344d 	addqh_r.ph	a2,a3,t0
0+00c8 <text_label\+0xc8> 2128 388d 	addqh.w	a3,t0,t1
0+00cc <text_label\+0xcc> 2149 448d 	addqh_r.w	t0,t1,t2
0+00d0 <text_label\+0xd0> 216a 4a4d 	subqh.ph	t1,t2,t3
0+00d4 <text_label\+0xd4> 218b 564d 	subqh_r.ph	t2,t3,t4
0+00d8 <text_label\+0xd8> 21ac 5a8d 	subqh.w	t3,t4,t5
0+00dc <text_label\+0xdc> 21cd 668d 	subqh_r.w	t4,t5,t6
0+00e0 <text_label\+0xe0> 21cd 50bf 	dpax.w.ph	\$ac1,t5,t6
0+00e4 <text_label\+0xe4> 21ee 94bf 	dpsx.w.ph	\$ac2,t6,t7
0+00e8 <text_label\+0xe8> 220f e2bf 	dpaqx_s.w.ph	\$ac3,t7,s0
0+00ec <text_label\+0xec> 2230 32bf 	dpaqx_sa.w.ph	\$ac0,s0,s1
0+00f0 <text_label\+0xf0> 2251 66bf 	dpsqx_s.w.ph	\$ac1,s1,s2
0+00f4 <text_label\+0xf4> 2272 b6bf 	dpsqx_sa.w.ph	\$ac2,s2,s3
	...
