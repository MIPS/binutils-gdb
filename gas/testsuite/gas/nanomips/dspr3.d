#objdump: -dr --prefix-addresses --show-raw-insn
#name: DSP ASE Rev3 for nanoMIPS
#as: -mdspr3
#source: dspr3.s

# Check DSP ASE Rev2 for nanoMIPS Instruction Assembly

.*: +file format .*nanomips.*

Disassembly of section .text:
[0-9a-f]+ <text_label> 2001 013f 	absq_s.qb	zero,at
[0-9a-f]+ <text_label\+0x4> 2062 090d 	addu.ph	at,t4,t5
[0-9a-f]+ <text_label\+0x8> 2083 150d 	addu_s.ph	t4,t5,a0
[0-9a-f]+ <text_label\+0xc> 20a4 194d 	adduh.qb	t5,a0,a1
[0-9a-f]+ <text_label\+0x10> 20c5 254d 	adduh_r.qb	a0,a1,a2
[0-9a-f]+ <text_label\+0x14> 20a6 0215 	append	a1,a2,0
[0-9a-f]+ <text_label\+0x18> 20a6 fa15 	append	a1,a2,31
[0-9a-f]+ <text_label\+0x1c> 20c7 301f 	extw	a2,a3,a2,0
[0-9a-f]+ <text_label\+0x20> 20c7 361f 	extw	a2,a3,a2,24
[0-9a-f]+ <text_label\+0x24> 20c7 341f 	extw	a2,a3,a2,16
[0-9a-f]+ <text_label\+0x28> 20c7 321f 	extw	a2,a3,a2,8
[0-9a-f]+ <text_label\+0x2c> 2107 3185 	cmpgdu.eq.qb	a2,a3,a4
[0-9a-f]+ <text_label\+0x30> 2128 39c5 	cmpgdu.lt.qb	a3,a4,a5
[0-9a-f]+ <text_label\+0x34> 2149 4205 	cmpgdu.le.qb	a4,a5,a6
[0-9a-f]+ <text_label\+0x38> 2149 00bf 	dpa.w.ph	\$ac0,a5,a6
[0-9a-f]+ <text_label\+0x3c> 216a 44bf 	dps.w.ph	\$ac1,a6,a7
[0-9a-f]+ <text_label\+0x40> 218b 8abf 	madd	\$ac2,a7,t0
[0-9a-f]+ <text_label\+0x44> 21ac dabf 	maddu	\$ac3,t0,t1
[0-9a-f]+ <text_label\+0x48> 21cd 2abf 	msub	\$ac0,t1,t2
[0-9a-f]+ <text_label\+0x4c> 21ee 7abf 	msubu	\$ac1,t2,t3
[0-9a-f]+ <text_label\+0x50> 2230 782d 	mul.ph	t3,s0,s1
[0-9a-f]+ <text_label\+0x54> 2251 842d 	mul_s.ph	s0,s1,s2
[0-9a-f]+ <text_label\+0x58> 2272 8995 	mulq_rs.w	s1,s2,s3
[0-9a-f]+ <text_label\+0x5c> 2293 9155 	mulq_s.ph	s2,s3,s4
[0-9a-f]+ <text_label\+0x60> 22b4 99d5 	mulq_s.w	s3,s4,s5
[0-9a-f]+ <text_label\+0x64> 22b4 acbf 	mulsa.w.ph	\$ac2,s4,s5
[0-9a-f]+ <text_label\+0x68> 22d5 ccbf 	mult	\$ac3,s5,s6
[0-9a-f]+ <text_label\+0x6c> 22f6 1cbf 	multu	\$ac0,s6,s7
[0-9a-f]+ <text_label\+0x70> 2338 b86d 	precr.qb.ph	s7,t8,t9
[0-9a-f]+ <text_label\+0x74> 2319 03cd 	precr_sra.ph.w	t8,t9,0
[0-9a-f]+ <text_label\+0x78> 2319 fbcd 	precr_sra.ph.w	t8,t9,31
[0-9a-f]+ <text_label\+0x7c> 233a 07cd 	precr_sra_r.ph.w	t9,k0,0
[0-9a-f]+ <text_label\+0x80> 233a ffcd 	precr_sra_r.ph.w	t9,k0,31
[0-9a-f]+ <text_label\+0x84> 237a d01f 	extw	k0,k0,k1,0
[0-9a-f]+ <text_label\+0x88> 237a d7df 	extw	k0,k0,k1,31
[0-9a-f]+ <text_label\+0x8c> 237c 01ff 	shra.qb	k1,gp,0
[0-9a-f]+ <text_label\+0x90> 237c e1ff 	shra.qb	k1,gp,7
[0-9a-f]+ <text_label\+0x94> 239d 11ff 	shra_r.qb	gp,sp,0
[0-9a-f]+ <text_label\+0x98> 239d f1ff 	shra_r.qb	gp,sp,7
[0-9a-f]+ <text_label\+0x9c> 23df e9cd 	shrav.qb	sp,fp,ra
[0-9a-f]+ <text_label\+0xa0> 23e0 f5cd 	shrav_r.qb	fp,ra,zero
[0-9a-f]+ <text_label\+0xa4> 23e0 03ff 	shrl.ph	ra,zero,0
[0-9a-f]+ <text_label\+0xa8> 23e0 f3ff 	shrl.ph	ra,zero,15
[0-9a-f]+ <text_label\+0xac> 2022 0315 	shrlv.ph	zero,at,t4
[0-9a-f]+ <text_label\+0xb0> 2062 0b0d 	subu.ph	at,t4,t5
[0-9a-f]+ <text_label\+0xb4> 2083 170d 	subu_s.ph	t4,t5,a0
[0-9a-f]+ <text_label\+0xb8> 20a4 1b4d 	subuh.qb	t5,a0,a1
[0-9a-f]+ <text_label\+0xbc> 20c5 274d 	subuh_r.qb	a0,a1,a2
[0-9a-f]+ <text_label\+0xc0> 20e6 284d 	addqh.ph	a1,a2,a3
[0-9a-f]+ <text_label\+0xc4> 2107 344d 	addqh_r.ph	a2,a3,a4
[0-9a-f]+ <text_label\+0xc8> 2128 388d 	addqh.w	a3,a4,a5
[0-9a-f]+ <text_label\+0xcc> 2149 448d 	addqh_r.w	a4,a5,a6
[0-9a-f]+ <text_label\+0xd0> 216a 4a4d 	subqh.ph	a5,a6,a7
[0-9a-f]+ <text_label\+0xd4> 218b 564d 	subqh_r.ph	a6,a7,t0
[0-9a-f]+ <text_label\+0xd8> 21ac 5a8d 	subqh.w	a7,t0,t1
[0-9a-f]+ <text_label\+0xdc> 21cd 668d 	subqh_r.w	t0,t1,t2
[0-9a-f]+ <text_label\+0xe0> 21cd 50bf 	dpax.w.ph	\$ac1,t1,t2
[0-9a-f]+ <text_label\+0xe4> 21ee 94bf 	dpsx.w.ph	\$ac2,t2,t3
[0-9a-f]+ <text_label\+0xe8> 220f e2bf 	dpaqx_s.w.ph	\$ac3,t3,s0
[0-9a-f]+ <text_label\+0xec> 2230 32bf 	dpaqx_sa.w.ph	\$ac0,s0,s1
[0-9a-f]+ <text_label\+0xf0> 2251 66bf 	dpsqx_s.w.ph	\$ac1,s1,s2
[0-9a-f]+ <text_label\+0xf4> 2272 b6bf 	dpsqx_sa.w.ph	\$ac2,s2,s3
	\.\.\.
