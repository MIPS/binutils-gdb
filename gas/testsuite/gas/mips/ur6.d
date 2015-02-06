#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS microMIPS R6 instructions
#as: -32

# Check microMIPS R6 instructions

.*: +file format .*mips.*


Disassembly of section .text:
0+0000 <[^>]*> 5441 01b8 	maddf.s	\$f0,\$f1,\$f2
0+0004 <[^>]*> 54a4 1bb8 	maddf.d	\$f3,\$f4,\$f5
0+0008 <[^>]*> 5507 31f8 	msubf.s	\$f6,\$f7,\$f8
0+000c <[^>]*> 556a 4bf8 	msubf.d	\$f9,\$f10,\$f11
0+0010 <[^>]*> 5441 0005 	cmp.af.s	\$f0,\$f1,\$f2
0+0014 <[^>]*> 5441 0015 	cmp.af.d	\$f0,\$f1,\$f2
0+0018 <[^>]*> 5441 0045 	cmp.un.s	\$f0,\$f1,\$f2
0+001c <[^>]*> 5441 0055 	cmp.un.d	\$f0,\$f1,\$f2
0+0020 <[^>]*> 5441 0085 	cmp.eq.s	\$f0,\$f1,\$f2
0+0024 <[^>]*> 5441 0095 	cmp.eq.d	\$f0,\$f1,\$f2
0+0028 <[^>]*> 5441 00c5 	cmp.ueq.s	\$f0,\$f1,\$f2
0+002c <[^>]*> 5441 00d5 	cmp.ueq.d	\$f0,\$f1,\$f2
0+0030 <[^>]*> 5441 0105 	cmp.lt.s	\$f0,\$f1,\$f2
0+0034 <[^>]*> 5441 0115 	cmp.lt.d	\$f0,\$f1,\$f2
0+0038 <[^>]*> 5441 0145 	cmp.ult.s	\$f0,\$f1,\$f2
0+003c <[^>]*> 5441 0155 	cmp.ult.d	\$f0,\$f1,\$f2
0+0040 <[^>]*> 5441 0185 	cmp.le.s	\$f0,\$f1,\$f2
0+0044 <[^>]*> 5441 0195 	cmp.le.d	\$f0,\$f1,\$f2
0+0048 <[^>]*> 5441 01c5 	cmp.ule.s	\$f0,\$f1,\$f2
0+004c <[^>]*> 5441 01d5 	cmp.ule.d	\$f0,\$f1,\$f2
0+0050 <[^>]*> 5441 0205 	cmp.saf.s	\$f0,\$f1,\$f2
0+0054 <[^>]*> 5441 0215 	cmp.saf.d	\$f0,\$f1,\$f2
0+0058 <[^>]*> 5441 0245 	cmp.sun.s	\$f0,\$f1,\$f2
0+005c <[^>]*> 5441 0255 	cmp.sun.d	\$f0,\$f1,\$f2
0+0060 <[^>]*> 5441 0285 	cmp.seq.s	\$f0,\$f1,\$f2
0+0064 <[^>]*> 5441 0295 	cmp.seq.d	\$f0,\$f1,\$f2
0+0068 <[^>]*> 5441 02c5 	cmp.sueq.s	\$f0,\$f1,\$f2
0+006c <[^>]*> 5441 02d5 	cmp.sueq.d	\$f0,\$f1,\$f2
0+0070 <[^>]*> 5441 0305 	cmp.slt.s	\$f0,\$f1,\$f2
0+0074 <[^>]*> 5441 0315 	cmp.slt.d	\$f0,\$f1,\$f2
0+0078 <[^>]*> 5441 0345 	cmp.sult.s	\$f0,\$f1,\$f2
0+007c <[^>]*> 5441 0355 	cmp.sult.d	\$f0,\$f1,\$f2
0+0080 <[^>]*> 5441 0385 	cmp.sle.s	\$f0,\$f1,\$f2
0+0084 <[^>]*> 5441 0395 	cmp.sle.d	\$f0,\$f1,\$f2
0+0088 <[^>]*> 5441 03c5 	cmp.sule.s	\$f0,\$f1,\$f2
0+008c <[^>]*> 5441 03d5 	cmp.sule.d	\$f0,\$f1,\$f2
0+0090 <[^>]*> 5441 0445 	cmp.or.s	\$f0,\$f1,\$f2
0+0094 <[^>]*> 5441 0455 	cmp.or.d	\$f0,\$f1,\$f2
0+0098 <[^>]*> 5441 0485 	cmp.une.s	\$f0,\$f1,\$f2
0+009c <[^>]*> 5441 0495 	cmp.une.d	\$f0,\$f1,\$f2
0+00a0 <[^>]*> 5441 04c5 	cmp.ne.s	\$f0,\$f1,\$f2
0+00a4 <[^>]*> 5441 04d5 	cmp.ne.d	\$f0,\$f1,\$f2
0+00a8 <[^>]*> 5441 0645 	cmp.sor.s	\$f0,\$f1,\$f2
0+00ac <[^>]*> 5441 0655 	cmp.sor.d	\$f0,\$f1,\$f2
0+00b0 <[^>]*> 5441 0685 	cmp.sune.s	\$f0,\$f1,\$f2
0+00b4 <[^>]*> 5441 0695 	cmp.sune.d	\$f0,\$f1,\$f2
0+00b8 <[^>]*> 5441 06c5 	cmp.sne.s	\$f0,\$f1,\$f2
0+00bc <[^>]*> 5441 06d5 	cmp.sne.d	\$f0,\$f1,\$f2
0+00c0 <[^>]*> 4100 fffe 	bc1eqzc	\$f0,000000c0 <[^>]*>
[	]*c0: R_MICROMIPS_PC16_S1	.L11
0+00c4 <[^>]*> 411f fffe 	bc1eqzc	\$f31,000000c4 <[^>]*>
[	]*c4: R_MICROMIPS_PC16_S1	.L11
0+00c8 <[^>]*> 411f fffe 	bc1eqzc	\$f31,000000c8 <[^>]*>
[	]*c8: R_MICROMIPS_PC16_S1	new
0+00cc <[^>]*> 411f fffe 	bc1eqzc	\$f31,000000cc <[^>]*>
[	]*cc: R_MICROMIPS_PC16_S1	external_label
0+00d0 <[^>]*> 4120 fffe 	bc1nezc	\$f0,000000d0 <[^>]*>
[	]*d0: R_MICROMIPS_PC16_S1	.L11
0+00d4 <[^>]*> 413f fffe 	bc1nezc	\$f31,000000d4 <[^>]*>
[	]*d4: R_MICROMIPS_PC16_S1	.L11
0+00d8 <[^>]*> 413f fffe 	bc1nezc	\$f31,000000d8 <[^>]*>
[	]*d8: R_MICROMIPS_PC16_S1	new
0+00dc <[^>]*> 413f fffe 	bc1nezc	\$f31,000000dc <[^>]*>
[	]*dc: R_MICROMIPS_PC16_S1	external_label
0+00e0 <[^>]*> 4140 fffe 	bc2eqzc	\$0,000000e0 <[^>]*>
[	]*e0: R_MICROMIPS_PC16_S1	.L11
0+00e4 <[^>]*> 415f fffe 	bc2eqzc	\$31,000000e4 <[^>]*>
[	]*e4: R_MICROMIPS_PC16_S1	.L11
0+00e8 <[^>]*> 415f fffe 	bc2eqzc	\$31,000000e8 <[^>]*>
[	]*e8: R_MICROMIPS_PC16_S1	new
0+00ec <[^>]*> 415f fffe 	bc2eqzc	\$31,000000ec <[^>]*>
[	]*ec: R_MICROMIPS_PC16_S1	external_label
0+00f0 <[^>]*> 4160 fffe 	bc2nezc	\$0,000000f0 <[^>]*>
[	]*f0: R_MICROMIPS_PC16_S1	.L11
0+00f4 <[^>]*> 417f fffe 	bc2nezc	\$31,000000f4 <[^>]*>
[	]*f4: R_MICROMIPS_PC16_S1	.L11
0+00f8 <[^>]*> 417f fffe 	bc2nezc	\$31,000000f8 <[^>]*>
[	]*f8: R_MICROMIPS_PC16_S1	new
0+00fc <[^>]*> 417f fffe 	bc2nezc	\$31,000000fc <[^>]*>
[	]*fc: R_MICROMIPS_PC16_S1	external_label
0+0100 <[^>]*> 5441 00b8 	sel.s	\$f0,\$f1,\$f2
0+0104 <[^>]*> 5441 02b8 	sel.d	\$f0,\$f1,\$f2
0+0108 <[^>]*> 5441 0038 	seleqz.s	\$f0,\$f1,\$f2
0+010c <[^>]*> 5441 0238 	seleqz.d	\$f0,\$f1,\$f2
0+0110 <[^>]*> 5441 0078 	selnez.s	\$f0,\$f1,\$f2
0+0114 <[^>]*> 5441 0278 	selnez.d	\$f0,\$f1,\$f2
0+0118 <[^>]*> 0083 1140 	seleqz	v0,v1,a0
0+011c <[^>]*> 0083 1180 	selnez	v0,v1,a0
0+0120 <[^>]*> 0083 1018 	mul	v0,v1,a0
0+0124 <[^>]*> 0083 1058 	muh	v0,v1,a0
0+0128 <[^>]*> 0083 1098 	mulu	v0,v1,a0
0+012c <[^>]*> 0083 10d8 	muhu	v0,v1,a0
0+0130 <[^>]*> 0083 1118 	div	v0,v1,a0
0+0134 <[^>]*> 0083 1158 	mod	v0,v1,a0
0+0138 <[^>]*> 0083 1198 	divu	v0,v1,a0
0+013c <[^>]*> 0083 11d8 	modu	v0,v1,a0
0+0140 <[^>]*> 0083 100f 	lsa	v0,v1,a0,0x1
0+0144 <[^>]*> 0083 160f 	lsa	v0,v1,a0,0x4
0+0148 <[^>]*> 0062 201f 	align	a0,v0,v1,0
0+014c <[^>]*> 0062 221f 	align	a0,v0,v1,1
0+0150 <[^>]*> 0062 241f 	align	a0,v0,v1,2
0+0154 <[^>]*> 0062 261f 	align	a0,v0,v1,3
0+0158 <[^>]*> 0044 0b3c 	bitswap	a0,v0
0+015c <[^>]*> 7400 fffe 	bovc	zero,zero,0000015c <[^>]*>
[	]*15c: R_MICROMIPS_PC16_S1	ext
0+0160 <[^>]*> 7402 fffe 	bovc	v0,zero,00000160 <[^>]*>
[	]*160: R_MICROMIPS_PC16_S1	ext
0+0164 <[^>]*> 7402 fffe 	bovc	v0,zero,00000164 <[^>]*>
[	]*164: R_MICROMIPS_PC16_S1	ext
0+0168 <[^>]*> 7444 fffe 	bovc	a0,v0,00000168 <[^>]*>
[	]*168: R_MICROMIPS_PC16_S1	ext
0+016c <[^>]*> 7444 fffe 	bovc	a0,v0,0000016c <[^>]*>
[	]*16c: R_MICROMIPS_PC16_S1	ext
0+0170 <[^>]*> 7444 8000 	bovc	a0,v0,ffff0174 <[^>]*>
[	]*170: R_MICROMIPS_PC16_S1	L0
0+0174 <[^>]*> 7444 7fff 	bovc	a0,v0,00010176 <[^>]*>
[	]*174: R_MICROMIPS_PC16_S1	L0
0+0178 <[^>]*> 7444 fffe 	bovc	a0,v0,00000178 <[^>]*>
[	]*178: R_MICROMIPS_PC16_S1	.L11
0+017c <[^>]*> 7442 fffe 	bovc	v0,v0,0000017c <[^>]*>
[	]*17c: R_MICROMIPS_PC16_S1	ext
0+0180 <[^>]*> 7442 8000 	bovc	v0,v0,ffff0184 <[^>]*>
[	]*180: R_MICROMIPS_PC16_S1	L0
0+0184 <[^>]*> 7440 fffe 	beqzalc	v0,00000184 <[^>]*>
[	]*184: R_MICROMIPS_PC16_S1	ext
0+0188 <[^>]*> 7440 8000 	beqzalc	v0,ffff018c <[^>]*>
[	]*188: R_MICROMIPS_PC16_S1	L0
0+018c <[^>]*> 7440 7fff 	beqzalc	v0,0001018e <[^>]*>
[	]*18c: R_MICROMIPS_PC16_S1	L0
0+0190 <[^>]*> 7440 fffe 	beqzalc	v0,00000190 <[^>]*>
[	]*190: R_MICROMIPS_PC16_S1	.L11
0+0194 <[^>]*> 7462 fffe 	beqc	v0,v1,00000194 <[^>]*>
[	]*194: R_MICROMIPS_PC16_S1	ext
0+0198 <[^>]*> 7462 fffe 	beqc	v0,v1,00000198 <[^>]*>
[	]*198: R_MICROMIPS_PC16_S1	ext
0+019c <[^>]*> 7462 8000 	beqc	v0,v1,ffff01a0 <[^>]*>
[	]*19c: R_MICROMIPS_PC16_S1	L0
0+01a0 <[^>]*> 7462 7fff 	beqc	v0,v1,000101a2 <[^>]*>
[	]*1a0: R_MICROMIPS_PC16_S1	L0
0+01a4 <[^>]*> 7462 fffe 	beqc	v0,v1,000001a4 <[^>]*>
[	]*1a4: R_MICROMIPS_PC16_S1	.L11
0+01a8 <[^>]*> 7c00 fffe 	bnvc	zero,zero,000001a8 <[^>]*>
[	]*1a8: R_MICROMIPS_PC16_S1	ext
0+01ac <[^>]*> 7c02 fffe 	bnvc	v0,zero,000001ac <[^>]*>
[	]*1ac: R_MICROMIPS_PC16_S1	ext
0+01b0 <[^>]*> 7c02 fffe 	bnvc	v0,zero,000001b0 <[^>]*>
[	]*1b0: R_MICROMIPS_PC16_S1	ext
0+01b4 <[^>]*> 7c44 fffe 	bnvc	a0,v0,000001b4 <[^>]*>
[	]*1b4: R_MICROMIPS_PC16_S1	ext
0+01b8 <[^>]*> 7c44 fffe 	bnvc	a0,v0,000001b8 <[^>]*>
[	]*1b8: R_MICROMIPS_PC16_S1	ext
0+01bc <[^>]*> 7c44 8000 	bnvc	a0,v0,ffff01c0 <[^>]*>
[	]*1bc: R_MICROMIPS_PC16_S1	L0
0+01c0 <[^>]*> 7c44 7fff 	bnvc	a0,v0,000101c2 <[^>]*>
[	]*1c0: R_MICROMIPS_PC16_S1	L0
0+01c4 <[^>]*> 7c44 fffe 	bnvc	a0,v0,000001c4 <[^>]*>
[	]*1c4: R_MICROMIPS_PC16_S1	.L11
0+01c8 <[^>]*> 7c42 fffe 	bnvc	v0,v0,000001c8 <[^>]*>
[	]*1c8: R_MICROMIPS_PC16_S1	ext
0+01cc <[^>]*> 7c42 8000 	bnvc	v0,v0,ffff01d0 <[^>]*>
[	]*1cc: R_MICROMIPS_PC16_S1	L0
0+01d0 <[^>]*> 7c40 fffe 	bnezalc	v0,000001d0 <[^>]*>
[	]*1d0: R_MICROMIPS_PC16_S1	ext
0+01d4 <[^>]*> 7c40 8000 	bnezalc	v0,ffff01d8 <[^>]*>
[	]*1d4: R_MICROMIPS_PC16_S1	L0
0+01d8 <[^>]*> 7c40 7fff 	bnezalc	v0,000101da <[^>]*>
[	]*1d8: R_MICROMIPS_PC16_S1	L0
0+01dc <[^>]*> 7c40 fffe 	bnezalc	v0,000001dc <[^>]*>
[	]*1dc: R_MICROMIPS_PC16_S1	.L11
0+01e0 <[^>]*> 7c62 fffe 	bnec	v0,v1,000001e0 <[^>]*>
[	]*1e0: R_MICROMIPS_PC16_S1	ext
0+01e4 <[^>]*> 7c62 fffe 	bnec	v0,v1,000001e4 <[^>]*>
[	]*1e4: R_MICROMIPS_PC16_S1	ext
0+01e8 <[^>]*> 7c62 8000 	bnec	v0,v1,ffff01ec <[^>]*>
[	]*1e8: R_MICROMIPS_PC16_S1	L0
0+01ec <[^>]*> 7c62 7fff 	bnec	v0,v1,000101ee <[^>]*>
[	]*1ec: R_MICROMIPS_PC16_S1	L0
0+01f0 <[^>]*> 7c62 fffe 	bnec	v0,v1,000001f0 <[^>]*>
[	]*1f0: R_MICROMIPS_PC16_S1	.L11
0+01f4 <[^>]*> e440 fffe 	blezc	v0,000001f4 <[^>]*>
[	]*1f4: R_MICROMIPS_PC16_S1	ext
0+01f8 <[^>]*> e440 8000 	blezc	v0,ffff01fc <[^>]*>
[	]*1f8: R_MICROMIPS_PC16_S1	L0
0+01fc <[^>]*> e440 7fff 	blezc	v0,000101fe <[^>]*>
[	]*1fc: R_MICROMIPS_PC16_S1	L0
0+0200 <[^>]*> e440 fffe 	blezc	v0,00000200 <[^>]*>
[	]*200: R_MICROMIPS_PC16_S1	.L11
0+0204 <[^>]*> e442 fffe 	bgezc	v0,00000204 <[^>]*>
[	]*204: R_MICROMIPS_PC16_S1	ext
0+0208 <[^>]*> e442 8000 	bgezc	v0,ffff020c <[^>]*>
[	]*208: R_MICROMIPS_PC16_S1	L0
0+020c <[^>]*> e442 7fff 	bgezc	v0,0001020e <[^>]*>
[	]*20c: R_MICROMIPS_PC16_S1	L0
0+0210 <[^>]*> e442 fffe 	bgezc	v0,00000210 <[^>]*>
[	]*210: R_MICROMIPS_PC16_S1	f
0+0214 <[^>]*> e462 fffe 	bgec	v0,v1,00000214 <[^>]*>
[	]*214: R_MICROMIPS_PC16_S1	ext
0+0218 <[^>]*> e462 8000 	bgec	v0,v1,ffff021c <[^>]*>
[	]*218: R_MICROMIPS_PC16_S1	L0
0+021c <[^>]*> e462 7fff 	bgec	v0,v1,0001021e <[^>]*>
[	]*21c: R_MICROMIPS_PC16_S1	L0
0+0220 <[^>]*> e462 fffe 	bgec	v0,v1,00000220 <[^>]*>
[	]*220: R_MICROMIPS_PC16_S1	.L11
0+0224 <[^>]*> e443 fffe 	bgec	v1,v0,00000224 <[^>]*>
[	]*224: R_MICROMIPS_PC16_S1	.L11
0+0228 <[^>]*> c440 fffe 	bgtzc	v0,00000228 <[^>]*>
[	]*228: R_MICROMIPS_PC16_S1	ext
0+022c <[^>]*> c440 8000 	bgtzc	v0,ffff0230 <[^>]*>
[	]*22c: R_MICROMIPS_PC16_S1	L0
0+0230 <[^>]*> c440 7fff 	bgtzc	v0,00010232 <[^>]*>
[	]*230: R_MICROMIPS_PC16_S1	L0
0+0234 <[^>]*> c440 fffe 	bgtzc	v0,00000234 <[^>]*>
[	]*234: R_MICROMIPS_PC16_S1	.L11
0+0238 <[^>]*> c442 fffe 	bltzc	v0,00000238 <[^>]*>
[	]*238: R_MICROMIPS_PC16_S1	ext
0+023c <[^>]*> c442 8000 	bltzc	v0,ffff0240 <[^>]*>
[	]*23c: R_MICROMIPS_PC16_S1	L0
0+0240 <[^>]*> c442 7fff 	bltzc	v0,00010242 <[^>]*>
[	]*240: R_MICROMIPS_PC16_S1	L0
0+0244 <[^>]*> c442 fffe 	bltzc	v0,00000244 <[^>]*>
[	]*244: R_MICROMIPS_PC16_S1	.L11
0+0248 <[^>]*> c462 fffe 	bltc	v0,v1,00000248 <[^>]*>
[	]*248: R_MICROMIPS_PC16_S1	ext
0+024c <[^>]*> c462 8000 	bltc	v0,v1,ffff0250 <[^>]*>
[	]*24c: R_MICROMIPS_PC16_S1	L0
0+0250 <[^>]*> c462 7fff 	bltc	v0,v1,00010252 <[^>]*>
[	]*250: R_MICROMIPS_PC16_S1	L0
0+0254 <[^>]*> c462 fffe 	bltc	v0,v1,00000254 <[^>]*>
[	]*254: R_MICROMIPS_PC16_S1	.L11
0+0258 <[^>]*> c443 fffe 	bltc	v1,v0,00000258 <[^>]*>
[	]*258: R_MICROMIPS_PC16_S1	.L11
0+025c <[^>]*> c040 fffe 	blezalc	v0,0000025c <[^>]*>
[	]*25c: R_MICROMIPS_PC16_S1	ext
0+0260 <[^>]*> c040 8000 	blezalc	v0,ffff0264 <[^>]*>
[	]*260: R_MICROMIPS_PC16_S1	L0
0+0264 <[^>]*> c040 7fff 	blezalc	v0,00010266 <[^>]*>
[	]*264: R_MICROMIPS_PC16_S1	L0
0+0268 <[^>]*> c040 fffe 	blezalc	v0,00000268 <[^>]*>
[	]*268: R_MICROMIPS_PC16_S1	.L11
0+026c <[^>]*> c042 fffe 	bgezalc	v0,0000026c <[^>]*>
[	]*26c: R_MICROMIPS_PC16_S1	ext
0+0270 <[^>]*> c042 8000 	bgezalc	v0,ffff0274 <[^>]*>
[	]*270: R_MICROMIPS_PC16_S1	L0
0+0274 <[^>]*> c042 7fff 	bgezalc	v0,00010276 <[^>]*>
[	]*274: R_MICROMIPS_PC16_S1	L0
0+0278 <[^>]*> c042 fffe 	bgezalc	v0,00000278 <[^>]*>
[	]*278: R_MICROMIPS_PC16_S1	.L11
0+027c <[^>]*> c062 fffe 	bgeuc	v0,v1,0000027c <[^>]*>
[	]*27c: R_MICROMIPS_PC16_S1	ext
0+0280 <[^>]*> c062 8000 	bgeuc	v0,v1,ffff0284 <[^>]*>
[	]*280: R_MICROMIPS_PC16_S1	L0
0+0284 <[^>]*> c062 7fff 	bgeuc	v0,v1,00010286 <[^>]*>
[	]*284: R_MICROMIPS_PC16_S1	L0
0+0288 <[^>]*> c062 fffe 	bgeuc	v0,v1,00000288 <[^>]*>
[	]*288: R_MICROMIPS_PC16_S1	.L11
0+028c <[^>]*> c043 fffe 	bgeuc	v1,v0,0000028c <[^>]*>
[	]*28c: R_MICROMIPS_PC16_S1	.L11
0+0290 <[^>]*> e040 fffe 	bgtzalc	v0,00000290 <[^>]*>
[	]*290: R_MICROMIPS_PC16_S1	ext
0+0294 <[^>]*> e040 8000 	bgtzalc	v0,ffff0298 <[^>]*>
[	]*294: R_MICROMIPS_PC16_S1	L0
0+0298 <[^>]*> e040 7fff 	bgtzalc	v0,0001029a <[^>]*>
[	]*298: R_MICROMIPS_PC16_S1	L0
0+029c <[^>]*> e040 fffe 	bgtzalc	v0,0000029c <[^>]*>
[	]*29c: R_MICROMIPS_PC16_S1	.L11
0+02a0 <[^>]*> e042 fffe 	bltzalc	v0,000002a0 <[^>]*>
[	]*2a0: R_MICROMIPS_PC16_S1	ext
0+02a4 <[^>]*> e042 8000 	bltzalc	v0,ffff02a8 <[^>]*>
[	]*2a4: R_MICROMIPS_PC16_S1	L0
0+02a8 <[^>]*> e042 7fff 	bltzalc	v0,000102aa <[^>]*>
[	]*2a8: R_MICROMIPS_PC16_S1	L0
0+02ac <[^>]*> e042 fffe 	bltzalc	v0,000002ac <[^>]*>
[	]*2ac: R_MICROMIPS_PC16_S1	.L11
0+02b0 <[^>]*> e062 fffe 	bltuc	v0,v1,000002b0 <[^>]*>
[	]*2b0: R_MICROMIPS_PC16_S1	ext
0+02b4 <[^>]*> e062 8000 	bltuc	v0,v1,ffff02b8 <[^>]*>
[	]*2b4: R_MICROMIPS_PC16_S1	L0
0+02b8 <[^>]*> e062 7fff 	bltuc	v0,v1,000102ba <[^>]*>
[	]*2b8: R_MICROMIPS_PC16_S1	L0
0+02bc <[^>]*> e062 fffe 	bltuc	v0,v1,000002bc <[^>]*>
[	]*2bc: R_MICROMIPS_PC16_S1	.L11
0+02c0 <[^>]*> e043 fffe 	bltuc	v1,v0,000002c0 <[^>]*>
[	]*2c0: R_MICROMIPS_PC16_S1	.L11
0+02c4 <[^>]*> 97ff fffe 	bc	000002c4 <[^>]*>
[	]*2c4: R_MICROMIPS_PC26_S1	ext
0+02c8 <[^>]*> 9600 0000 	bc	fc0002cc <[^>]*>
[	]*2c8: R_MICROMIPS_PC26_S1	L0
0+02cc <[^>]*> 95ff ffff 	bc	040002ce <[^>]*>
[	]*2cc: R_MICROMIPS_PC26_S1	L0
0+02d0 <[^>]*> cfff      	bc	000002d0 <[^>]*>
[	]*2d0: R_MICROMIPS_PC10_S1	.L11
0+02d2 <[^>]*> b7ff fffe 	balc	000002d2 <[^>]*>
[	]*2d2: R_MICROMIPS_PC26_S1	ext
0+02d6 <[^>]*> b600 0000 	balc	fc0002da <[^>]*>
[	]*2d6: R_MICROMIPS_PC26_S1	L0
0+02da <[^>]*> b5ff ffff 	balc	040002dc <[^>]*>
[	]*2da: R_MICROMIPS_PC26_S1	L0
0+02de <[^>]*> b7ff fffe 	balc	000002de <[^>]*>
[	]*2de: R_MICROMIPS_PC26_S1	.L11
0+02e2 <[^>]*> 8d40      	beqzc	v0,00000264 <[^>]*>
[	]*2e2: R_MICROMIPS_PC7_S1	L0
0+02e4 <[^>]*> 8d3f      	beqzc	v0,00000364 <[^>]*>
[	]*2e4: R_MICROMIPS_PC7_S1	L0
0+02e6 <[^>]*> a05f fffe 	beqzc	v0,000002e6 <[^>]*>
[	]*2e6: R_MICROMIPS_PC21_S1	ext
0+02ea <[^>]*> a050 0000 	beqzc	v0,ffe002ee <[^>]*>
[	]*2ea: R_MICROMIPS_PC21_S1	L0
0+02ee <[^>]*> a04f ffff 	beqzc	v0,002002f0 <[^>]*>
[	]*2ee: R_MICROMIPS_PC21_S1	L0
0+02f2 <[^>]*> a05f fffe 	beqzc	v0,000002f2 <[^>]*>
[	]*2f2: R_MICROMIPS_PC21_S1	.L11
0+02f6 <[^>]*> a003 8000 	jic	v1,-32768
0+02fa <[^>]*> a003 7fff 	jic	v1,32767
0+02fe <[^>]*> 47e3      	jrc	ra
0+0300 <[^>]*> ad40      	bnezc	v0,00000282 <[^>]*>
[	]*300: R_MICROMIPS_PC7_S1	L0
0+0302 <[^>]*> ad3f      	bnezc	v0,00000382 <[^>]*>
[	]*302: R_MICROMIPS_PC7_S1	L0
0+0304 <[^>]*> a45f fffe 	bnezc	v0,00000304 <[^>]*>
[	]*304: R_MICROMIPS_PC21_S1	ext
0+0308 <[^>]*> a450 0000 	bnezc	v0,ffe0030c <[^>]*>
[	]*308: R_MICROMIPS_PC21_S1	L0
0+030c <[^>]*> a44f ffff 	bnezc	v0,0020030e <[^>]*>
[	]*30c: R_MICROMIPS_PC21_S1	L0
0+0310 <[^>]*> a45f fffe 	bnezc	v0,00000310 <[^>]*>
[	]*310: R_MICROMIPS_PC21_S1	.L11
0+0314 <[^>]*> a403 8000 	jialc	v1,-32768
0+0318 <[^>]*> a403 7fff 	jialc	v1,32767
0+031c <[^>]*> 1062 ffff 	aui	v1,v0,0xffff
0+0320 <[^>]*> 7884 0000 	lapc	a0,fff00320 <[^>]*>
[	]*320: R_MICROMIPS_PC19_S2	L0
0+0324 <[^>]*> 7883 ffff 	lapc	a0,00100320 <[^>]*>
[	]*324: R_MICROMIPS_PC19_S2	L0
0+0328 <[^>]*> 7884 0000 	lapc	a0,fff00328 <[^>]*>
0+032c <[^>]*> 7883 ffff 	lapc	a0,00100328 <[^>]*>
0+0330 <[^>]*> 7904 0000 	lapc	t0,fff00330 <[^>]*>
0+0334 <[^>]*> 7903 ffff 	lapc	t0,00100330 <[^>]*>
0+0338 <[^>]*> 787e ffff 	auipc	v1,0xffff
0+033c <[^>]*> 787f ffff 	aluipc	v1,0xffff
0+0340 <[^>]*> 7888 0000 	lwpc	a0,00000340 <[^>]*>
[	]*340: R_MICROMIPS_PC19_S2	.L11
0+0344 <[^>]*> 788c 0000 	lwpc	a0,fff00344 <[^>]*>
[	]*344: R_MICROMIPS_PC19_S2	L0
0+0348 <[^>]*> 788b ffff 	lwpc	a0,00100344 <[^>]*>
[	]*348: R_MICROMIPS_PC19_S2	L0
0+034c <[^>]*> 788c 0000 	lwpc	a0,fff0034c <[^>]*>
0+0350 <[^>]*> 788b ffff 	lwpc	a0,0010034c <[^>]*>
0+0354 <[^>]*> 5462 0020 	rint.s	\$f2,\$f3
0+0358 <[^>]*> 5462 0220 	rint.d	\$f2,\$f3
0+035c <[^>]*> 5462 0060 	class.s	\$f2,\$f3
0+0360 <[^>]*> 5462 0260 	class.d	\$f2,\$f3
0+0364 <[^>]*> 5483 1003 	min.s	\$f2,\$f3,\$f4
0+0368 <[^>]*> 5483 1203 	min.d	\$f2,\$f3,\$f4
0+036c <[^>]*> 5483 100b 	max.s	\$f2,\$f3,\$f4
0+0370 <[^>]*> 5483 120b 	max.d	\$f2,\$f3,\$f4
0+0374 <[^>]*> 5483 1023 	mina.s	\$f2,\$f3,\$f4
0+0378 <[^>]*> 5483 1223 	mina.d	\$f2,\$f3,\$f4
0+037c <[^>]*> 5483 102b 	maxa.s	\$f2,\$f3,\$f4
0+0380 <[^>]*> 5483 122b 	maxa.d	\$f2,\$f3,\$f4
0+0384 <[^>]*> 0002 0100 	lwxs	zero,zero\(v0\)
0+0388 <[^>]*> 4180 ffff 	synci	-1\(zero\)
0+038c <[^>]*> 1040 ffff 	lui	v0,0xffff
0+0390 <[^>]*> 4530      	not	v0,v1
0+0392 <[^>]*> 4538      	xor	v0,v0,v1
0+0394 <[^>]*> 4531      	and	v0,v0,v1
0+0396 <[^>]*> 4539      	or	v0,v0,v1
0+0398 <[^>]*> 2225 5000 	lwm	s0,ra,0\(a1\)
0+039c <[^>]*> 2225 d000 	swm	s0,ra,0\(a1\)
0+03a0 <[^>]*> 4463      	jrc	v1
0+03a2 <[^>]*> 444b      	jalrc	v0
0+03a4 <[^>]*> 4433      	jrcaddiusp	4
0+03a6 <[^>]*> 469b      	break	0xa
0+03a8 <[^>]*> 443b      	sdbbp
0+03aa <[^>]*> 443b      	sdbbp
0+03ac <[^>]*> 447b      	sdbbp	0x1
0+03ae <[^>]*> 47fb      	sdbbp	0xf
0+03b0 <[^>]*> 001f 1f3c 	jrc.hb	ra
0+03b4 <[^>]*> 03e0 1f3c 	jalrc.hb	zero
0+03b8 <[^>]*> 001f 1f3c 	jrc.hb	ra
0+03bc <[^>]*> 005f 1f3c 	jalrc.hb	v0,ra
0+03c0 <[^>]*> 0002 1f3c 	jrc.hb	v0
0+03c4 <[^>]*> 000a 1f3c 	jrc.hb	t2
0+03c8 <[^>]*> a05f fffe 	beqzc	v0,000003c8 <[^>]*>
[	]*3c8: R_MICROMIPS_PC21_S1	.L11
0+03cc <[^>]*> a45f fffe 	bnezc	v0,000003cc <[^>]*>
[	]*3cc: R_MICROMIPS_PC21_S1	.L11
0+03d0 <[^>]*> 0c00      	nop
0+03d2 <[^>]*> 0c00      	nop
