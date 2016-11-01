#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPSR7 instructions
#as: -mmicromips -mips32r7
#source: ur7.s
#stderr: ur7.l

# Check MIPSR7 instructions

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <test> a400 1800 	pref	0x0,0\(zero\)
0+0004 <test\+0x4> 0020 07ff 	li	at,2047
0+0008 <test\+0x8> a401 1800 	pref	0x0,0\(at\)
0+000c <test\+0xc> 0020 9800 	li	at,-2048
0+0010 <test\+0x10> a401 1800 	pref	0x0,0\(at\)
0+0014 <test\+0x14> 0020 0800 	li	at,2048
0+0018 <test\+0x18> a401 1800 	pref	0x0,0\(at\)
0+001c <test\+0x1c> 0020 97ff 	li	at,-2049
0+0020 <test\+0x20> a401 1800 	pref	0x0,0\(at\)
0+0024 <test\+0x24> a400 1800 	pref	0x0,0\(zero\)
0+0028 <test\+0x28> a400 1800 	pref	0x0,0\(zero\)
0+002c <test\+0x2c> a420 1800 	pref	0x1,0\(zero\)
0+0030 <test\+0x30> a440 1800 	pref	0x2,0\(zero\)
0+0034 <test\+0x34> a460 1800 	pref	0x3,0\(zero\)
0+0038 <test\+0x38> a480 1800 	pref	0x4,0\(zero\)
0+003c <test\+0x3c> a4a0 1800 	pref	0x5,0\(zero\)
0+0040 <test\+0x40> a4c0 1800 	pref	0x6,0\(zero\)
0+0044 <test\+0x44> a4e0 1800 	pref	0x7,0\(zero\)
0+0048 <test\+0x48> 0020 01ff 	li	at,511
0+004c <test\+0x4c> a4e1 1800 	pref	0x7,0\(at\)
0+0050 <test\+0x50> 0020 9e00 	li	at,-512
0+0054 <test\+0x54> a4e1 1800 	pref	0x7,0\(at\)
0+0058 <test\+0x58> 0020 07ff 	li	at,2047
0+005c <test\+0x5c> a7e1 1800 	synci	0\(at\)
0+0060 <test\+0x60> 0020 9800 	li	at,-2048
0+0064 <test\+0x64> a7e1 1800 	synci	0\(at\)
0+0068 <test\+0x68> 0020 0800 	li	at,2048
0+006c <test\+0x6c> a7e1 1800 	synci	0\(at\)
0+0070 <test\+0x70> 0020 97ff 	li	at,-2049
0+0074 <test\+0x74> a7e1 1800 	synci	0\(at\)
0+0078 <test\+0x78> e020 8000 	lui	at,0x8
0+007c <test\+0x7c> a461 98ff 	pref	0x3,-1\(at\)
0+0080 <test\+0x80> e03f 8ffd 	lui	at,0xffff8
0+0084 <test\+0x84> a461 1800 	pref	0x3,0\(at\)
0+0088 <test\+0x88> 0022 07ff 	addiu	at,v0,2047
0+008c <test\+0x8c> a7e1 1800 	synci	0\(at\)
0+0090 <test\+0x90> 0022 9800 	addiu	at,v0,-2048
0+0094 <test\+0x94> a7e1 1800 	synci	0\(at\)
0+0098 <test\+0x98> 0022 0800 	addiu	at,v0,2048
0+009c <test\+0x9c> a7e1 1800 	synci	0\(at\)
0+00a0 <test\+0xa0> 0022 97ff 	addiu	at,v0,-2049
0+00a4 <test\+0xa4> a7e1 1800 	synci	0\(at\)
0+00a8 <test\+0xa8> e020 8000 	lui	at,0x8
0+00ac <test\+0xac> 2041 0950 	addu	at,at,v0
0+00b0 <test\+0xb0> a461 98ff 	pref	0x3,-1\(at\)
0+00b4 <test\+0xb4> e03f 8ffd 	lui	at,0xffff8
0+00b8 <test\+0xb8> 2041 0950 	addu	at,at,v0
0+00bc <test\+0xbc> a461 1800 	pref	0x3,0\(at\)
0+00c0 <test\+0xc0> 9008      	nop
0+00c2 <test\+0xc2> 9008      	nop
0+00c4 <test\+0xc4> 8000 c000 	nop
0+00c8 <test\+0xc8> 8000 c003 	ehb
0+00cc <test\+0xcc> 8000 c005 	pause
0+00d0 <test\+0xd0> d17f      	li	v0,-1
0+00d2 <test\+0xd2> d1ff      	li	v1,-1
0+00d4 <test\+0xd4> d27f      	li	a0,-1
0+00d6 <test\+0xd6> d2ff      	li	a1,-1
0+00d8 <test\+0xd8> d37f      	li	a2,-1
0+00da <test\+0xda> d3ff      	li	a3,-1
0+00dc <test\+0xdc> d07f      	li	s0,-1
0+00de <test\+0xde> d0ff      	li	s1,-1
0+00e0 <test\+0xe0> d080      	li	s1,0
0+00e2 <test\+0xe2> d0fd      	li	s1,125
0+00e4 <test\+0xe4> d0fe      	li	s1,126
0+00e6 <test\+0xe6> 8220 007f 	li	s1,127
0+00ea <test\+0xea> 8040 0000 	li	v0,0
0+00ee <test\+0xee> 8040 0001 	li	v0,1
0+00f2 <test\+0xf2> 6040 0000 7fff 	li	v0,0x7fff
0+00f8 <test\+0xf8> e05f 8ffd 	lui	v0,0xffff8
0+00fc <test\+0xfc> 6040 0000 ffff 	li	v0,0xffff
0+0102 <test\+0x102> e041 0000 	lui	v0,0x10
0+0106 <test\+0x106> e05f 8ffd 	lui	v0,0xffff8
0+010a <test\+0x10a> 6040 ffff 8001 	li	v0,0xffff8001
0+0110 <test\+0x110> 6040 ffff ffff 	li	v0,0xffffffff
0+0116 <test\+0x116> 6040 1234 5678 	li	v0,0x12345678
0+011c <test\+0x11c> 1016      	break	0x6
0+011e <test\+0x11e> 1056      	move	v0,s6
0+0120 <test\+0x120> 1076      	move	v1,s6
0+0122 <test\+0x122> 1096      	move	a0,s6
0+0124 <test\+0x124> 10b6      	move	a1,s6
0+0126 <test\+0x126> 10d6      	move	a2,s6
0+0128 <test\+0x128> 10f6      	move	a3,s6
0+012a <test\+0x12a> 1116      	move	t0,s6
0+012c <test\+0x12c> 1136      	move	t1,s6
0+012e <test\+0x12e> 1156      	move	t2,s6
0+0130 <test\+0x130> 13d6      	move	s8,s6
0+0132 <test\+0x132> 13f6      	move	ra,s6
0+0134 <test\+0x134> 1000      	move	zero,zero
0+0136 <test\+0x136> 1002      	move	zero,v0
0+0138 <test\+0x138> 1003      	move	zero,v1
0+013a <test\+0x13a> 1004      	move	zero,a0
0+013c <test\+0x13c> 1005      	move	zero,a1
0+013e <test\+0x13e> 1006      	move	zero,a2
0+0140 <test\+0x140> 1007      	move	zero,a3
0+0142 <test\+0x142> 1008      	move	zero,t0
0+0144 <test\+0x144> 1009      	move	zero,t1
0+0146 <test\+0x146> 100a      	move	zero,t2
0+0148 <test\+0x148> 101e      	sdbbp	0x6
0+014a <test\+0x14a> 101f      	sdbbp	0x7
0+014c <test\+0x14c> 12c2      	move	s6,v0
0+014e <test\+0x14e> 1056      	move	v0,s6
0+0150 <test\+0x150> 12c2      	move	s6,v0
0+0152 <test\+0x152> 2016 1290 	move	v0,s6
0+0156 <test\+0x156> 2002 b290 	move	s6,v0
0+015a <test\+0x15a> 1800      	bc	0000015c <test\+0x15c>
			15a: R_MICROMIPS_PC10_S1	test-0x2
0+015c <test\+0x15c> 1800      	bc	0000015e <test\+0x15e>
			15c: R_MICROMIPS_PC10_S1	test-0x2
0+015e <test\+0x15e> 2800 0000 	bc	00000162 <test\+0x162>
			15e: R_MICROMIPS_PC25_S1	test-0x4
0+0162 <test\+0x162> 1800      	bc	000002ce <\.L3\+0x138>
			162: R_MICROMIPS_PC10_S1	\.L11-0x2
0+0164 <test\+0x164> 1800      	bc	000002d0 <\.L3\+0x13a>
			164: R_MICROMIPS_PC10_S1	\.L11-0x2
0+0166 <test\+0x166> 2800 0000 	bc	000002d4 <\.L3\+0x13e>
			166: R_MICROMIPS_PC25_S1	\.L11-0x4
0+016a <\.L11> 1800      	bc	000002d6 <\.L3\+0x140>
			16a: R_MICROMIPS_PC10_S1	\.L11-0x2
0+016c <\.L11\+0x2> 1800      	bc	000002d8 <\.L3\+0x142>
			16c: R_MICROMIPS_PC10_S1	\.L11-0x2
0+016e <\.L11\+0x4> 2800 0000 	bc	000002dc <\.L3\+0x146>
			16e: R_MICROMIPS_PC25_S1	\.L11-0x4
0+0172 <\.L11\+0x8> 1043      	move	v0,v1
0+0174 <\.L11\+0xa> 8803 8000 	bgezc	v1,000002f4 <\.L3\+0x15e>
			174: R_MICROMIPS_PC14_S1	\.L0-0x4
0+0178 <\.L11\+0xe> 2060 11d0 	negu	v0,v1
0+017c <\.L0> 1044      	move	v0,a0
0+017e <\.L0\+0x2> 8804 8000 	bgezc	a0,00000308 <\.L3\+0x172>
			17e: R_MICROMIPS_PC14_S1	\.L1-0x4
0+0182 <\.L0\+0x6> 2080 11d0 	negu	v0,a0
0+0186 <\.L1> 8802 8000 	bgezc	v0,00000318 <\.L3\+0x182>
			186: R_MICROMIPS_PC14_S1	\.L2-0x4
0+018a <\.L1\+0x4> 2040 11d0 	negu	v0,v0
0+018e <\.L2> 8802 8000 	bgezc	v0,00000328 <\.L3\+0x192>
			18e: R_MICROMIPS_PC14_S1	\.L3-0x4
0+0192 <\.L2\+0x4> 2040 11d0 	negu	v0,v0
0+0196 <\.L3> 2083 1110 	add	v0,v1,a0
0+019a <\.L3\+0x4> 23fe e910 	add	sp,s8,ra
0+019e <\.L3\+0x8> 2082 1110 	add	v0,v0,a0
0+01a2 <\.L3\+0xc> 2082 1110 	add	v0,v0,a0
0+01a6 <\.L3\+0x10> 0042 0000 	addiu	v0,v0,0
0+01aa <\.L3\+0x14> 0042 0001 	addiu	v0,v0,1
0+01ae <\.L3\+0x18> 6020 0000 7fff 	li	at,0x7fff
0+01b4 <\.L3\+0x1e> 2022 1110 	add	v0,v0,at
0+01b8 <\.L3\+0x22> e03f 8ffd 	lui	at,0xffff8
0+01bc <\.L3\+0x26> 2022 1110 	add	v0,v0,at
0+01c0 <\.L3\+0x2a> 6020 0000 ffff 	li	at,0xffff
0+01c6 <\.L3\+0x30> 2022 1110 	add	v0,v0,at
0+01ca <\.L3\+0x34> e03f 8ffd 	lui	at,0xffff8
0+01ce <\.L3\+0x38> 2024 1910 	add	v1,a0,at
0+01d2 <\.L3\+0x3c> 0064 0000 	addiu	v1,a0,0
0+01d6 <\.L3\+0x40> 6020 0000 7fff 	li	at,0x7fff
0+01dc <\.L3\+0x46> 2024 1910 	add	v1,a0,at
0+01e0 <\.L3\+0x4a> 6020 0000 ffff 	li	at,0xffff
0+01e6 <\.L3\+0x50> 2024 1910 	add	v1,a0,at
0+01ea <\.L3\+0x54> 6020 0000 ffff 	li	at,0xffff
0+01f0 <\.L3\+0x5a> 2023 1910 	add	v1,v1,at
0+01f4 <\.L3\+0x5e> 6020 0000 ffff 	li	at,0xffff
0+01fa <\.L3\+0x64> 2023 1910 	add	v1,v1,at
0+01fe <\.L3\+0x68> 9018      	addiu	zero,zero,-8
0+0200 <\.L3\+0x6a> 9058      	addiu	v0,v0,-8
0+0202 <\.L3\+0x6c> 9078      	addiu	v1,v1,-8
0+0204 <\.L3\+0x6e> 9098      	addiu	a0,a0,-8
0+0206 <\.L3\+0x70> 90b8      	addiu	a1,a1,-8
0+0208 <\.L3\+0x72> 90d8      	addiu	a2,a2,-8
0+020a <\.L3\+0x74> 90f8      	addiu	a3,a3,-8
0+020c <\.L3\+0x76> 9118      	addiu	t0,t0,-8
0+020e <\.L3\+0x78> 9138      	addiu	t1,t1,-8
0+0210 <\.L3\+0x7a> 9158      	addiu	t2,t2,-8
0+0212 <\.L3\+0x7c> 93d8      	addiu	s8,s8,-8
0+0214 <\.L3\+0x7e> 93f8      	addiu	ra,ra,-8
0+0216 <\.L3\+0x80> 93f9      	addiu	ra,ra,-7
0+0218 <\.L3\+0x82> 93e8      	addiu	ra,ra,0
0+021a <\.L3\+0x84> 93e9      	addiu	ra,ra,1
0+021c <\.L3\+0x86> 93ee      	addiu	ra,ra,6
0+021e <\.L3\+0x88> 93ef      	addiu	ra,ra,7
0+0220 <\.L3\+0x8a> 03ff 0008 	addiu	ra,ra,8
0+0224 <\.L3\+0x8e> 03bd 9bf8 	addiu	sp,sp,-1032
0+0228 <\.L3\+0x92> 03bd 9bfc 	addiu	sp,sp,-1028
0+022c <\.L3\+0x96> 03bd 9c00 	addiu	sp,sp,-1024
0+0230 <\.L3\+0x9a> 03bd 03fc 	addiu	sp,sp,1020
0+0234 <\.L3\+0x9e> 03bd 0400 	addiu	sp,sp,1024
0+0238 <\.L3\+0xa2> 03bd 0404 	addiu	sp,sp,1028
0+023c <\.L3\+0xa6> 03bd 0404 	addiu	sp,sp,1028
0+0240 <\.L3\+0xaa> 03bd 0408 	addiu	sp,sp,1032
0+0244 <\.L3\+0xae> 905f      	addiu	v0,v0,-1
0+0246 <\.L3\+0xb0> 0043 9fff 	addiu	v0,v1,-1
0+024a <\.L3\+0xb4> 0044 9fff 	addiu	v0,a0,-1
0+024e <\.L3\+0xb8> 0045 9fff 	addiu	v0,a1,-1
0+0252 <\.L3\+0xbc> 0046 9fff 	addiu	v0,a2,-1
0+0256 <\.L3\+0xc0> 0047 9fff 	addiu	v0,a3,-1
0+025a <\.L3\+0xc4> 0050 9fff 	addiu	v0,s0,-1
0+025e <\.L3\+0xc8> 0051 9fff 	addiu	v0,s1,-1
0+0262 <\.L3\+0xcc> 0051 0001 	addiu	v0,s1,1
0+0266 <\.L3\+0xd0> 9111      	addiu	v0,s1,4
0+0268 <\.L3\+0xd2> 9112      	addiu	v0,s1,8
0+026a <\.L3\+0xd4> 9113      	addiu	v0,s1,12
0+026c <\.L3\+0xd6> 9114      	addiu	v0,s1,16
0+026e <\.L3\+0xd8> 9115      	addiu	v0,s1,20
0+0270 <\.L3\+0xda> 9116      	addiu	v0,s1,24
0+0272 <\.L3\+0xdc> 9196      	addiu	v1,s1,24
0+0274 <\.L3\+0xde> 9216      	addiu	a0,s1,24
0+0276 <\.L3\+0xe0> 9296      	addiu	a1,s1,24
0+0278 <\.L3\+0xe2> 9316      	addiu	a2,s1,24
0+027a <\.L3\+0xe4> 9396      	addiu	a3,s1,24
0+027c <\.L3\+0xe6> 9016      	addiu	s0,s1,24
0+027e <\.L3\+0xe8> 9096      	addiu	s1,s1,24
0+0280 <\.L3\+0xea> 7140      	addiu	v0,sp,0
0+0282 <\.L3\+0xec> 7141      	addiu	v0,sp,4
0+0284 <\.L3\+0xee> 717e      	addiu	v0,sp,248
0+0286 <\.L3\+0xf0> 717f      	addiu	v0,sp,252
0+0288 <\.L3\+0xf2> 005d 0100 	addiu	v0,sp,256
0+028c <\.L3\+0xf6> 717f      	addiu	v0,sp,252
0+028e <\.L3\+0xf8> 71ff      	addiu	v1,sp,252
0+0290 <\.L3\+0xfa> 727f      	addiu	a0,sp,252
0+0292 <\.L3\+0xfc> 72ff      	addiu	a1,sp,252
0+0294 <\.L3\+0xfe> 737f      	addiu	a2,sp,252
0+0296 <\.L3\+0x100> 73ff      	addiu	a3,sp,252
0+0298 <\.L3\+0x102> 707f      	addiu	s0,sp,252
0+029a <\.L3\+0x104> 70ff      	addiu	s1,sp,252
0+029c <\.L3\+0x106> 0064 8000 	addiu	v1,a0,-8192
0+02a0 <\.L3\+0x10a> 91c0      	addiu	v1,a0,0
0+02a2 <\.L3\+0x10c> 0064 1fff 	addiu	v1,a0,8191
0+02a6 <\.L3\+0x110> 0064 9fff 	addiu	v1,a0,-1
0+02aa <\.L3\+0x114> 0063 9fff 	addiu	v1,v1,-1
0+02ae <\.L3\+0x118> 0063 9fff 	addiu	v1,v1,-1
0+02b2 <\.L3\+0x11c> 2016 1150 	addu	v0,s6,zero
0+02b6 <\.L3\+0x120> 2002 b150 	addu	s6,v0,zero
0+02ba <\.L3\+0x124> 22c0 1150 	addu	v0,zero,s6
0+02be <\.L3\+0x128> 2040 b150 	addu	s6,zero,v0
0+02c2 <\.L3\+0x12c> b134      	addu	v0,v1,v0
0+02c4 <\.L3\+0x12e> b1b4      	addu	v0,v1,v1
0+02c6 <\.L3\+0x130> b234      	addu	v0,v1,a0
0+02c8 <\.L3\+0x132> b2b4      	addu	v0,v1,a1
0+02ca <\.L3\+0x134> b334      	addu	v0,v1,a2
0+02cc <\.L3\+0x136> b3b4      	addu	v0,v1,a3
0+02ce <\.L3\+0x138> b034      	addu	v0,v1,s0
0+02d0 <\.L3\+0x13a> b0b4      	addu	v0,v1,s1
0+02d2 <\.L3\+0x13c> b0a4      	addu	v0,v0,s1
0+02d4 <\.L3\+0x13e> b0b4      	addu	v0,v1,s1
0+02d6 <\.L3\+0x140> b0c4      	addu	v0,a0,s1
0+02d8 <\.L3\+0x142> b0d4      	addu	v0,a1,s1
0+02da <\.L3\+0x144> b0e4      	addu	v0,a2,s1
0+02dc <\.L3\+0x146> b0f4      	addu	v0,a3,s1
0+02de <\.L3\+0x148> b084      	addu	v0,s0,s1
0+02e0 <\.L3\+0x14a> b094      	addu	v0,s1,s1
0+02e2 <\.L3\+0x14c> b0a4      	addu	v0,v0,s1
0+02e4 <\.L3\+0x14e> b0a6      	addu	v1,v0,s1
0+02e6 <\.L3\+0x150> b0a8      	addu	a0,v0,s1
0+02e8 <\.L3\+0x152> b0aa      	addu	a1,v0,s1
0+02ea <\.L3\+0x154> b0ac      	addu	a2,v0,s1
0+02ec <\.L3\+0x156> b0ae      	addu	a3,v0,s1
0+02ee <\.L3\+0x158> b0a0      	addu	s0,v0,s1
0+02f0 <\.L3\+0x15a> b0a2      	addu	s1,v0,s1
0+02f2 <\.L3\+0x15c> b17e      	addu	a3,a3,v0
0+02f4 <\.L3\+0x15e> b17e      	addu	a3,a3,v0
0+02f6 <\.L3\+0x160> b3ae      	addu	a3,v0,a3
0+02f8 <\.L3\+0x162> 23fe e950 	addu	sp,s8,ra
0+02fc <\.L3\+0x166> 0042 0000 	addiu	v0,v0,0
0+0300 <\.L3\+0x16a> 0042 0001 	addiu	v0,v0,1
0+0304 <\.L3\+0x16e> 6020 0000 7fff 	li	at,0x7fff
0+030a <\.L3\+0x174> 2022 1150 	addu	v0,v0,at
0+030e <\.L3\+0x178> e03f 8ffd 	lui	at,0xffff8
0+0312 <\.L3\+0x17c> 2022 1150 	addu	v0,v0,at
0+0316 <\.L3\+0x180> 6020 0000 ffff 	li	at,0xffff
0+031c <\.L3\+0x186> 2022 1150 	addu	v0,v0,at
0+0320 <\.L3\+0x18a> 5128      	and	v0,v0,v0
0+0322 <\.L3\+0x18c> 5138      	and	v0,v0,v1
0+0324 <\.L3\+0x18e> 5148      	and	v0,v0,a0
0+0326 <\.L3\+0x190> 5158      	and	v0,v0,a1
0+0328 <\.L3\+0x192> 5168      	and	v0,v0,a2
0+032a <\.L3\+0x194> 5178      	and	v0,v0,a3
0+032c <\.L3\+0x196> 5108      	and	v0,v0,s0
0+032e <\.L3\+0x198> 5118      	and	v0,v0,s1
0+0330 <\.L3\+0x19a> 51a8      	and	v1,v1,v0
0+0332 <\.L3\+0x19c> 5228      	and	a0,a0,v0
0+0334 <\.L3\+0x19e> 52a8      	and	a1,a1,v0
0+0336 <\.L3\+0x1a0> 5328      	and	a2,a2,v0
0+0338 <\.L3\+0x1a2> 53a8      	and	a3,a3,v0
0+033a <\.L3\+0x1a4> 5028      	and	s0,s0,v0
0+033c <\.L3\+0x1a6> 50a8      	and	s1,s1,v0
0+033e <\.L3\+0x1a8> 5138      	and	v0,v0,v1
0+0340 <\.L3\+0x1aa> 5138      	and	v0,v0,v1
0+0342 <\.L3\+0x1ac> 5138      	and	v0,v0,v1
0+0344 <\.L3\+0x1ae> 5138      	and	v0,v0,v1
0+0346 <\.L3\+0x1b0> 2062 1250 	and	v0,v0,v1
0+034a <\.L3\+0x1b4> f121      	andi	v0,v0,0x1
0+034c <\.L3\+0x1b6> f122      	andi	v0,v0,0x2
0+034e <\.L3\+0x1b8> f123      	andi	v0,v0,0x3
0+0350 <\.L3\+0x1ba> f124      	andi	v0,v0,0x4
0+0352 <\.L3\+0x1bc> f127      	andi	v0,v0,0x7
0+0354 <\.L3\+0x1be> f128      	andi	v0,v0,0x8
0+0356 <\.L3\+0x1c0> f12f      	andi	v0,v0,0xf
0+0358 <\.L3\+0x1c2> 8042 2010 	andi	v0,v0,16
0+035c <\.L3\+0x1c6> 8042 201f 	andi	v0,v0,31
0+0360 <\.L3\+0x1ca> 8042 2020 	andi	v0,v0,32
0+0364 <\.L3\+0x1ce> 8042 203f 	andi	v0,v0,63
0+0368 <\.L3\+0x1d2> 8042 2040 	andi	v0,v0,64
0+036c <\.L3\+0x1d6> 8042 2080 	andi	v0,v0,128
0+0370 <\.L3\+0x1da> f12c      	andi	v0,v0,0xff
0+0372 <\.L3\+0x1dc> 8042 2fff 	andi	v0,v0,4095
0+0376 <\.L3\+0x1e0> f12d      	andi	v0,v0,0xffff
0+0378 <\.L3\+0x1e2> f13d      	andi	v0,v1,0xffff
0+037a <\.L3\+0x1e4> f14d      	andi	v0,a0,0xffff
0+037c <\.L3\+0x1e6> f15d      	andi	v0,a1,0xffff
0+037e <\.L3\+0x1e8> f16d      	andi	v0,a2,0xffff
0+0380 <\.L3\+0x1ea> f17d      	andi	v0,a3,0xffff
0+0382 <\.L3\+0x1ec> f10d      	andi	v0,s0,0xffff
0+0384 <\.L3\+0x1ee> f11d      	andi	v0,s1,0xffff
0+0386 <\.L3\+0x1f0> f19d      	andi	v1,s1,0xffff
0+0388 <\.L3\+0x1f2> f21d      	andi	a0,s1,0xffff
0+038a <\.L3\+0x1f4> f29d      	andi	a1,s1,0xffff
0+038c <\.L3\+0x1f6> f31d      	andi	a2,s1,0xffff
0+038e <\.L3\+0x1f8> f39d      	andi	a3,s1,0xffff
0+0390 <\.L3\+0x1fa> f01d      	andi	s0,s1,0xffff
0+0392 <\.L3\+0x1fc> f09d      	andi	s1,s1,0xffff
0+0394 <\.L3\+0x1fe> f3fd      	andi	a3,a3,0xffff
0+0396 <\.L3\+0x200> f3fd      	andi	a3,a3,0xffff
0+0398 <\.L3\+0x202> f3fd      	andi	a3,a3,0xffff
0+039a <\.L3\+0x204> 2083 1250 	and	v0,v1,a0
0+039e <\.L3\+0x208> 2082 1250 	and	v0,v0,a0
0+03a2 <\.L3\+0x20c> 2082 1250 	and	v0,v0,a0
0+03a6 <\.L3\+0x210> 8043 2000 	andi	v0,v1,0
0+03aa <\.L3\+0x214> 6020 0000 ffff 	li	at,0xffff
0+03b0 <\.L3\+0x21a> 2023 1250 	and	v0,v1,at
0+03b4 <\.L3\+0x21e> e021 0000 	lui	at,0x10
0+03b8 <\.L3\+0x222> 2023 1250 	and	v0,v1,at
0+03bc <\.L3\+0x226> 6020 ffff 0001 	li	at,0xffff0001
0+03c2 <\.L3\+0x22c> 2023 1250 	and	v0,v1,at
0+03c6 <test2> 9900      	beqzc	v0,0000078e <test3\+0x332>
			3c6: R_MICROMIPS_PC7_S1	test2-0x2
0+03c8 <test2\+0x2> 9980      	beqzc	v1,00000790 <test3\+0x334>
			3c8: R_MICROMIPS_PC7_S1	test2-0x2
0+03ca <test2\+0x4> 9a00      	beqzc	a0,00000792 <test3\+0x336>
			3ca: R_MICROMIPS_PC7_S1	test2-0x2
0+03cc <test2\+0x6> 9a80      	beqzc	a1,00000794 <test3\+0x338>
			3cc: R_MICROMIPS_PC7_S1	test2-0x2
0+03ce <test2\+0x8> 9b00      	beqzc	a2,00000796 <test3\+0x33a>
			3ce: R_MICROMIPS_PC7_S1	test2-0x2
0+03d0 <test2\+0xa> 9b80      	beqzc	a3,00000798 <test3\+0x33c>
			3d0: R_MICROMIPS_PC7_S1	test2-0x2
0+03d2 <test2\+0xc> 9800      	beqzc	s0,0000079a <test3\+0x33e>
			3d2: R_MICROMIPS_PC7_S1	test2-0x2
0+03d4 <test2\+0xe> 9880      	beqzc	s1,0000079c <test3\+0x340>
			3d4: R_MICROMIPS_PC7_S1	test2-0x2
0+03d6 <test2\+0x10> 9900      	beqzc	v0,0000079e <test3\+0x342>
			3d6: R_MICROMIPS_PC7_S1	test2-0x2
0+03d8 <test2\+0x12> 9980      	beqzc	v1,000007a0 <test3\+0x344>
			3d8: R_MICROMIPS_PC7_S1	test2-0x2
0+03da <test2\+0x14> 9a00      	beqzc	a0,000007a2 <test3\+0x346>
			3da: R_MICROMIPS_PC7_S1	test2-0x2
0+03dc <test2\+0x16> 9a80      	beqzc	a1,000007a4 <test3\+0x348>
			3dc: R_MICROMIPS_PC7_S1	test2-0x2
0+03de <test2\+0x18> 9b00      	beqzc	a2,000007a6 <test3\+0x34a>
			3de: R_MICROMIPS_PC7_S1	test2-0x2
0+03e0 <test2\+0x1a> 9b80      	beqzc	a3,000007a8 <test3\+0x34c>
			3e0: R_MICROMIPS_PC7_S1	test2-0x2
0+03e2 <test2\+0x1c> 9800      	beqzc	s0,000007aa <test3\+0x34e>
			3e2: R_MICROMIPS_PC7_S1	test2-0x2
0+03e4 <test2\+0x1e> 9880      	beqzc	s1,000007ac <test3\+0x350>
			3e4: R_MICROMIPS_PC7_S1	test2-0x2
0+03e6 <test2\+0x20> 9900      	beqzc	v0,000007ae <test3\+0x352>
			3e6: R_MICROMIPS_PC7_S1	test2-0x2
0+03e8 <test2\+0x22> 9980      	beqzc	v1,000007b0 <test3\+0x354>
			3e8: R_MICROMIPS_PC7_S1	test2-0x2
0+03ea <test2\+0x24> 9a00      	beqzc	a0,000007b2 <test3\+0x356>
			3ea: R_MICROMIPS_PC7_S1	test2-0x2
0+03ec <test2\+0x26> 9a80      	beqzc	a1,000007b4 <test3\+0x358>
			3ec: R_MICROMIPS_PC7_S1	test2-0x2
0+03ee <test2\+0x28> 9b00      	beqzc	a2,000007b6 <test3\+0x35a>
			3ee: R_MICROMIPS_PC7_S1	test2-0x2
0+03f0 <test2\+0x2a> 9b80      	beqzc	a3,000007b8 <test3\+0x35c>
			3f0: R_MICROMIPS_PC7_S1	test2-0x2
0+03f2 <test2\+0x2c> 9800      	beqzc	s0,000007ba <test3\+0x35e>
			3f2: R_MICROMIPS_PC7_S1	test2-0x2
0+03f4 <test2\+0x2e> 9880      	beqzc	s1,000007bc <test3\+0x360>
			3f4: R_MICROMIPS_PC7_S1	test2-0x2
0+03f6 <test2\+0x30> 9800      	beqzc	s0,000007be <test3\+0x362>
			3f6: R_MICROMIPS_PC7_S1	test2-0x2
0+03f8 <test2\+0x32> ea00 0000 	beqzc	s0,000007c2 <test3\+0x366>
			3f8: R_MICROMIPS_PC20_S1	test2-0x4
0+03fc <test2\+0x36> 9880      	beqzc	s1,000007c4 <test3\+0x368>
			3fc: R_MICROMIPS_PC7_S1	test2-0x2
0+03fe <test2\+0x38> ea20 0000 	beqzc	s1,000007c8 <test3\+0x36c>
			3fe: R_MICROMIPS_PC20_S1	test2-0x4
0+0402 <test2\+0x3c> 9880      	beqzc	s1,000007ca <test3\+0x36e>
			402: R_MICROMIPS_PC7_S1	test2-0x2
0+0404 <test2\+0x3e> ea00 0000 	beqzc	s0,000007ce <test3\+0x372>
			404: R_MICROMIPS_PC20_S1	test2-0x4
0+0408 <test2\+0x42> ca00 5000 	beqic	s0,10,000007d2 <test3\+0x376>
			408: R_MICROMIPS_PC11_S1	test2-0x4
0+040c <test2\+0x46> 6020 0000 7fff 	li	at,0x7fff
0+0412 <test2\+0x4c> 8830 0000 	beqc	s0,at,000007dc <test3\+0x380>
			412: R_MICROMIPS_PC14_S1	test2-0x4
0+0416 <test2\+0x50> e021 0000 	lui	at,0x10
0+041a <test2\+0x54> 8830 0000 	beqc	s0,at,000007e4 <test3\+0x388>
			41a: R_MICROMIPS_PC14_S1	test2-0x4
0+041e <test2\+0x58> b900      	bnezc	v0,0000087c <test3\+0x420>
			41e: R_MICROMIPS_PC7_S1	test3-0x2
0+0420 <test2\+0x5a> b980      	bnezc	v1,0000087e <test3\+0x422>
			420: R_MICROMIPS_PC7_S1	test3-0x2
0+0422 <test2\+0x5c> ba00      	bnezc	a0,00000880 <test3\+0x424>
			422: R_MICROMIPS_PC7_S1	test3-0x2
0+0424 <test2\+0x5e> ba80      	bnezc	a1,00000882 <test3\+0x426>
			424: R_MICROMIPS_PC7_S1	test3-0x2
0+0426 <test2\+0x60> bb00      	bnezc	a2,00000884 <test3\+0x428>
			426: R_MICROMIPS_PC7_S1	test3-0x2
0+0428 <test2\+0x62> bb80      	bnezc	a3,00000886 <test3\+0x42a>
			428: R_MICROMIPS_PC7_S1	test3-0x2
0+042a <test2\+0x64> b800      	bnezc	s0,00000888 <test3\+0x42c>
			42a: R_MICROMIPS_PC7_S1	test3-0x2
0+042c <test2\+0x66> b880      	bnezc	s1,0000088a <test3\+0x42e>
			42c: R_MICROMIPS_PC7_S1	test3-0x2
0+042e <test2\+0x68> b900      	bnezc	v0,0000088c <test3\+0x430>
			42e: R_MICROMIPS_PC7_S1	test3-0x2
0+0430 <test2\+0x6a> b980      	bnezc	v1,0000088e <test3\+0x432>
			430: R_MICROMIPS_PC7_S1	test3-0x2
0+0432 <test2\+0x6c> ba00      	bnezc	a0,00000890 <test3\+0x434>
			432: R_MICROMIPS_PC7_S1	test3-0x2
0+0434 <test2\+0x6e> ba80      	bnezc	a1,00000892 <test3\+0x436>
			434: R_MICROMIPS_PC7_S1	test3-0x2
0+0436 <test2\+0x70> bb00      	bnezc	a2,00000894 <test3\+0x438>
			436: R_MICROMIPS_PC7_S1	test3-0x2
0+0438 <test2\+0x72> bb80      	bnezc	a3,00000896 <test3\+0x43a>
			438: R_MICROMIPS_PC7_S1	test3-0x2
0+043a <test2\+0x74> b800      	bnezc	s0,00000898 <test3\+0x43c>
			43a: R_MICROMIPS_PC7_S1	test3-0x2
0+043c <test2\+0x76> b880      	bnezc	s1,0000089a <test3\+0x43e>
			43c: R_MICROMIPS_PC7_S1	test3-0x2
0+043e <test2\+0x78> b900      	bnezc	v0,0000089c <test3\+0x440>
			43e: R_MICROMIPS_PC7_S1	test3-0x2
0+0440 <test2\+0x7a> b980      	bnezc	v1,0000089e <test3\+0x442>
			440: R_MICROMIPS_PC7_S1	test3-0x2
0+0442 <test2\+0x7c> ba00      	bnezc	a0,000008a0 <test3\+0x444>
			442: R_MICROMIPS_PC7_S1	test3-0x2
0+0444 <test2\+0x7e> ba80      	bnezc	a1,000008a2 <test3\+0x446>
			444: R_MICROMIPS_PC7_S1	test3-0x2
0+0446 <test2\+0x80> bb00      	bnezc	a2,000008a4 <test3\+0x448>
			446: R_MICROMIPS_PC7_S1	test3-0x2
0+0448 <test2\+0x82> bb80      	bnezc	a3,000008a6 <test3\+0x44a>
			448: R_MICROMIPS_PC7_S1	test3-0x2
0+044a <test2\+0x84> b800      	bnezc	s0,000008a8 <test3\+0x44c>
			44a: R_MICROMIPS_PC7_S1	test3-0x2
0+044c <test2\+0x86> b880      	bnezc	s1,000008aa <test3\+0x44e>
			44c: R_MICROMIPS_PC7_S1	test3-0x2
0+044e <test2\+0x88> b800      	bnezc	s0,000008ac <test3\+0x450>
			44e: R_MICROMIPS_PC7_S1	test3-0x2
0+0450 <test2\+0x8a> ea10 0000 	bnezc	s0,000008b0 <test3\+0x454>
			450: R_MICROMIPS_PC20_S1	test3-0x4
0+0454 <test2\+0x8e> ea30 0000 	bnezc	s1,0000081e <test3\+0x3c2>
			454: R_MICROMIPS_PC20_S1	test2-0x4
0+0458 <test2\+0x92> ea30 0000 	bnezc	s1,00000822 <test3\+0x3c6>
			458: R_MICROMIPS_PC20_S1	test2-0x4
0+045c <test3> ea30 0000 	bnezc	s1,00000826 <test3\+0x3ca>
			45c: R_MICROMIPS_PC20_S1	test2-0x4
0+0460 <test3\+0x4> 1010      	break
0+0462 <test3\+0x6> 1010      	break
0+0464 <test3\+0x8> 1011      	break	0x1
0+0466 <test3\+0xa> 1012      	break	0x2
0+0468 <test3\+0xc> 1013      	break	0x3
0+046a <test3\+0xe> 1014      	break	0x4
0+046c <test3\+0x10> 1015      	break	0x5
0+046e <test3\+0x12> 1016      	break	0x6
0+0470 <test3\+0x14> 1017      	break	0x7
0+0472 <test3\+0x16> 0010 0008 	break	0x8
0+0476 <test3\+0x1a> 0010 0009 	break	0x9
0+047a <test3\+0x1e> 0010 000a 	break	0xa
0+047e <test3\+0x22> 0010 000b 	break	0xb
0+0482 <test3\+0x26> 0010 000c 	break	0xc
0+0486 <test3\+0x2a> 0010 000d 	break	0xd
0+048a <test3\+0x2e> 0010 000e 	break	0xe
0+048e <test3\+0x32> 0010 000f 	break	0xf
0+0492 <test3\+0x36> 0010 003f 	break	0x3f
0+0496 <test3\+0x3a> 0010 0040 	break	0x40
0+049a <test3\+0x3e> 0010 03ff 	break	0x3ff
0+049e <test3\+0x42> 0010 0000 	break
0+04a2 <test3\+0x46> 0010 0000 	break
0+04a6 <test3\+0x4a> 0010 0001 	break	0x1
0+04aa <test3\+0x4e> 0010 0002 	break	0x2
0+04ae <test3\+0x52> 0010 000f 	break	0xf
0+04b2 <test3\+0x56> 0010 003f 	break	0x3f
0+04b6 <test3\+0x5a> 0010 0040 	break	0x40
0+04ba <test3\+0x5e> 0010 03ff 	break	0x3ff
0+04be <test3\+0x62> a400 1900 	cache	0x0,0\(zero\)
0+04c2 <test3\+0x66> 0020 9800 	li	at,-2048
0+04c6 <test3\+0x6a> a401 1900 	cache	0x0,0\(at\)
0+04ca <test3\+0x6e> 0020 07ff 	li	at,2047
0+04ce <test3\+0x72> a401 1900 	cache	0x0,0\(at\)
0+04d2 <test3\+0x76> 0020 97ff 	li	at,-2049
0+04d6 <test3\+0x7a> a401 1900 	cache	0x0,0\(at\)
0+04da <test3\+0x7e> 0020 0800 	li	at,2048
0+04de <test3\+0x82> a401 1900 	cache	0x0,0\(at\)
0+04e2 <test3\+0x86> a402 1900 	cache	0x0,0\(v0\)
0+04e6 <test3\+0x8a> 0022 9800 	addiu	at,v0,-2048
0+04ea <test3\+0x8e> a401 1900 	cache	0x0,0\(at\)
0+04ee <test3\+0x92> 0022 07ff 	addiu	at,v0,2047
0+04f2 <test3\+0x96> a401 1900 	cache	0x0,0\(at\)
0+04f6 <test3\+0x9a> 0022 97ff 	addiu	at,v0,-2049
0+04fa <test3\+0x9e> a401 1900 	cache	0x0,0\(at\)
0+04fe <test3\+0xa2> 0022 0800 	addiu	at,v0,2048
0+0502 <test3\+0xa6> a401 1900 	cache	0x0,0\(at\)
0+0506 <test3\+0xaa> a400 1900 	cache	0x0,0\(zero\)
0+050a <test3\+0xae> a400 1900 	cache	0x0,0\(zero\)
0+050e <test3\+0xb2> a420 1900 	cache	0x1,0\(zero\)
0+0512 <test3\+0xb6> a440 1900 	cache	0x2,0\(zero\)
0+0516 <test3\+0xba> a460 1900 	cache	0x3,0\(zero\)
0+051a <test3\+0xbe> a480 1900 	cache	0x4,0\(zero\)
0+051e <test3\+0xc2> a4a0 1900 	cache	0x5,0\(zero\)
0+0522 <test3\+0xc6> a4c0 1900 	cache	0x6,0\(zero\)
0+0526 <test3\+0xca> a7e0 1900 	cache	0x1f,0\(zero\)
0+052a <test3\+0xce> 0020 07ff 	li	at,2047
0+052e <test3\+0xd2> a7e1 1900 	cache	0x1f,0\(at\)
0+0532 <test3\+0xd6> 0020 9800 	li	at,-2048
0+0536 <test3\+0xda> a7e1 1900 	cache	0x1f,0\(at\)
0+053a <test3\+0xde> 0020 07ff 	li	at,2047
0+053e <test3\+0xe2> a401 1900 	cache	0x0,0\(at\)
0+0542 <test3\+0xe6> 0020 9800 	li	at,-2048
0+0546 <test3\+0xea> a401 1900 	cache	0x0,0\(at\)
0+054a <test3\+0xee> e021 0000 	lui	at,0x10
0+054e <test3\+0xf2> 2061 0950 	addu	at,at,v1
0+0552 <test3\+0xf6> a7e1 1900 	cache	0x1f,0\(at\)
0+0556 <test3\+0xfa> 0023 0800 	addiu	at,v1,2048
0+055a <test3\+0xfe> a7e1 1900 	cache	0x1f,0\(at\)
0+055e <test3\+0x102> 0023 97ff 	addiu	at,v1,-2049
0+0562 <test3\+0x106> a7e1 1900 	cache	0x1f,0\(at\)
0+0566 <test3\+0x10a> e021 0000 	lui	at,0x10
0+056a <test3\+0x10e> 2061 0950 	addu	at,at,v1
0+056e <test3\+0x112> a7e1 1901 	cache	0x1f,1\(at\)
0+0572 <test3\+0x116> a7e3 99ff 	cache	0x1f,-1\(v1\)
0+0576 <test3\+0x11a> e03f 0ffd 	lui	at,0xffff0
0+057a <test3\+0x11e> 2061 0950 	addu	at,at,v1
0+057e <test3\+0x122> a7e1 1900 	cache	0x1f,0\(at\)
0+0582 <test3\+0x126> e03f 0ffd 	lui	at,0xffff0
0+0586 <test3\+0x12a> 2061 0950 	addu	at,at,v1
0+058a <test3\+0x12e> a7e1 1901 	cache	0x1f,1\(at\)
0+058e <test3\+0x132> e021 0000 	lui	at,0x10
0+0592 <test3\+0x136> 2061 0950 	addu	at,at,v1
0+0596 <test3\+0x13a> a7e1 99ff 	cache	0x1f,-1\(at\)
0+059a <test3\+0x13e> e021 0000 	lui	at,0x10
0+059e <test3\+0x142> a7e1 1900 	cache	0x1f,0\(at\)
0+05a2 <test3\+0x146> 0020 0800 	li	at,2048
0+05a6 <test3\+0x14a> a7e1 1900 	cache	0x1f,0\(at\)
0+05aa <test3\+0x14e> 0020 97ff 	li	at,-2049
0+05ae <test3\+0x152> a7e1 1900 	cache	0x1f,0\(at\)
0+05b2 <test3\+0x156> e021 0000 	lui	at,0x10
0+05b6 <test3\+0x15a> a7e1 1901 	cache	0x1f,1\(at\)
0+05ba <test3\+0x15e> a7e0 99ff 	cache	0x1f,-1\(zero\)
0+05be <test3\+0x162> e03f 0ffd 	lui	at,0xffff0
0+05c2 <test3\+0x166> a7e1 1900 	cache	0x1f,0\(at\)
0+05c6 <test3\+0x16a> e03f 0ffd 	lui	at,0xffff0
0+05ca <test3\+0x16e> a7e1 1901 	cache	0x1f,1\(at\)
0+05ce <test3\+0x172> e021 0000 	lui	at,0x10
0+05d2 <test3\+0x176> a7e1 99ff 	cache	0x1f,-1\(at\)
0+05d6 <test3\+0x17a> 2043 4b3f 	clo	v0,v1
0+05da <test3\+0x17e> 2062 4b3f 	clo	v1,v0
0+05de <test3\+0x182> 2043 5b3f 	clz	v0,v1
0+05e2 <test3\+0x186> 2062 5b3f 	clz	v1,v0
0+05e6 <test3\+0x18a> 2000 e37f 	deret
0+05ea <test3\+0x18e> 2000 477f 	di
0+05ee <test3\+0x192> 2000 477f 	di
0+05f2 <test3\+0x196> 2040 477f 	di	v0
0+05f6 <test3\+0x19a> 2060 477f 	di	v1
0+05fa <test3\+0x19e> 23c0 477f 	di	s8
0+05fe <test3\+0x1a2> 23e0 477f 	di	ra
0+0602 <test3\+0x1a6> 2062 0118 	div	zero,v0,v1
0+0606 <test3\+0x1aa> 23fe 0118 	div	zero,s8,ra
0+060a <test3\+0x1ae> 2060 0118 	div	zero,zero,v1
0+060e <test3\+0x1b2> 23e0 0118 	div	zero,zero,ra
0+0612 <test3\+0x1b6> 2003 1118 	div	v0,v1,zero
0+0616 <test3\+0x1ba> 2083 1118 	div	v0,v1,a0
0+061a <test3\+0x1be> 1017      	break	0x7
0+061c <test3\+0x1c0> 1060      	move	v1,zero
0+061e <test3\+0x1c2> 1060      	move	v1,zero
0+0620 <test3\+0x1c4> 0020 0002 	li	at,2
0+0624 <test3\+0x1c8> 2024 1918 	div	v1,a0,at
0+0628 <test3\+0x1cc> 2062 0198 	divu	zero,v0,v1
0+062c <test3\+0x1d0> 23fe 0198 	divu	zero,s8,ra
0+0630 <test3\+0x1d4> 2060 0198 	divu	zero,zero,v1
0+0634 <test3\+0x1d8> 23e0 0198 	divu	zero,zero,ra
0+0638 <test3\+0x1dc> 2003 1198 	divu	v0,v1,zero
0+063c <test3\+0x1e0> 2083 1198 	divu	v0,v1,a0
0+0640 <test3\+0x1e4> 1017      	break	0x7
0+0642 <test3\+0x1e6> 1060      	move	v1,zero
0+0644 <test3\+0x1e8> 0020 9fff 	li	at,-1
0+0648 <test3\+0x1ec> 2024 1998 	divu	v1,a0,at
0+064c <test3\+0x1f0> 0020 0002 	li	at,2
0+0650 <test3\+0x1f4> 2024 1998 	divu	v1,a0,at
0+0654 <test3\+0x1f8> 2000 577f 	ei
0+0658 <test3\+0x1fc> 2000 577f 	ei
0+065c <test3\+0x200> 2040 577f 	ei	v0
0+0660 <test3\+0x204> 2060 577f 	ei	v1
0+0664 <test3\+0x208> 23c0 577f 	ei	s8
0+0668 <test3\+0x20c> 23e0 577f 	ei	ra
0+066c <test3\+0x210> 2000 f37f 	eret
0+0670 <test3\+0x214> 8043 f385 	ext	v0,v1,0x5,0xf
0+0674 <test3\+0x218> 8043 f7c0 	ext	v0,v1,0x0,0x20
0+0678 <test3\+0x21c> 8043 f01f 	ext	v0,v1,0x1f,0x1
0+067c <test3\+0x220> 83fe f01f 	ext	ra,s8,0x1f,0x1
0+0680 <test3\+0x224> 8043 e4c5 	ins	v0,v1,0x5,0xf
0+0684 <test3\+0x228> 8043 e7c0 	ins	v0,v1,0x0,0x20
0+0688 <test3\+0x22c> 8043 e7df 	ins	v0,v1,0x1f,0x1
0+068c <test3\+0x230> 83fe e7df 	ins	ra,s8,0x1f,0x1
0+0690 <test3\+0x234> d800      	jrc	zero
0+0692 <test3\+0x236> d840      	jrc	v0
0+0694 <test3\+0x238> d860      	jrc	v1
0+0696 <test3\+0x23a> d880      	jrc	a0
0+0698 <test3\+0x23c> d8a0      	jrc	a1
0+069a <test3\+0x23e> d8c0      	jrc	a2
0+069c <test3\+0x240> d8e0      	jrc	a3
0+069e <test3\+0x242> d900      	jrc	t0
0+06a0 <test3\+0x244> dbc0      	jrc	s8
0+06a2 <test3\+0x246> dbe0      	jrc	ra
0+06a4 <test3\+0x248> 4800 0000 	jrc	zero
0+06a8 <test3\+0x24c> 4802 0000 	jrc	v0
0+06ac <test3\+0x250> 4803 0000 	jrc	v1
0+06b0 <test3\+0x254> 4804 0000 	jrc	a0
0+06b4 <test3\+0x258> 4805 0000 	jrc	a1
0+06b8 <test3\+0x25c> 4806 0000 	jrc	a2
0+06bc <test3\+0x260> 4807 0000 	jrc	a3
0+06c0 <test3\+0x264> 4808 0000 	jrc	t0
0+06c4 <test3\+0x268> 481e 0000 	jrc	s8
0+06c8 <test3\+0x26c> 481f 0000 	jrc	ra
0+06cc <test3\+0x270> d800      	jrc	zero
0+06ce <test3\+0x272> d840      	jrc	v0
0+06d0 <test3\+0x274> d860      	jrc	v1
0+06d2 <test3\+0x276> d880      	jrc	a0
0+06d4 <test3\+0x278> d8a0      	jrc	a1
0+06d6 <test3\+0x27a> d8c0      	jrc	a2
0+06d8 <test3\+0x27c> d8e0      	jrc	a3
0+06da <test3\+0x27e> d900      	jrc	t0
0+06dc <test3\+0x280> dbc0      	jrc	s8
0+06de <test3\+0x282> dbe0      	jrc	ra
0+06e0 <test3\+0x284> 4800 1000 	jrc\.hb	zero
0+06e4 <test3\+0x288> 4802 1000 	jrc\.hb	v0
0+06e8 <test3\+0x28c> 4803 1000 	jrc\.hb	v1
0+06ec <test3\+0x290> 4804 1000 	jrc\.hb	a0
0+06f0 <test3\+0x294> 4805 1000 	jrc\.hb	a1
0+06f4 <test3\+0x298> 4806 1000 	jrc\.hb	a2
0+06f8 <test3\+0x29c> 4807 1000 	jrc\.hb	a3
0+06fc <test3\+0x2a0> 4808 1000 	jrc\.hb	t0
0+0700 <test3\+0x2a4> 481e 1000 	jrc\.hb	s8
0+0704 <test3\+0x2a8> 481f 1000 	jrc\.hb	ra
0+0708 <test3\+0x2ac> 4800 0000 	jrc	zero
0+070c <test3\+0x2b0> 4802 0000 	jrc	v0
0+0710 <test3\+0x2b4> 4803 0000 	jrc	v1
0+0714 <test3\+0x2b8> 4804 0000 	jrc	a0
0+0718 <test3\+0x2bc> 4805 0000 	jrc	a1
0+071c <test3\+0x2c0> 4806 0000 	jrc	a2
0+0720 <test3\+0x2c4> 4807 0000 	jrc	a3
0+0724 <test3\+0x2c8> 4808 0000 	jrc	t0
0+0728 <test3\+0x2cc> 481e 0000 	jrc	s8
0+072c <test3\+0x2d0> 481f 0000 	jrc	ra
0+0730 <test3\+0x2d4> d810      	jalrc	zero
0+0732 <test3\+0x2d6> d850      	jalrc	v0
0+0734 <test3\+0x2d8> d870      	jalrc	v1
0+0736 <test3\+0x2da> d890      	jalrc	a0
0+0738 <test3\+0x2dc> d8b0      	jalrc	a1
0+073a <test3\+0x2de> d8d0      	jalrc	a2
0+073c <test3\+0x2e0> d8f0      	jalrc	a3
0+073e <test3\+0x2e2> d910      	jalrc	t0
0+0740 <test3\+0x2e4> dbd0      	jalrc	s8
0+0742 <test3\+0x2e6> 4be0 0000 	jalrc	zero
0+0746 <test3\+0x2ea> 4be2 0000 	jalrc	v0
0+074a <test3\+0x2ee> 4be3 0000 	jalrc	v1
0+074e <test3\+0x2f2> 4be4 0000 	jalrc	a0
0+0752 <test3\+0x2f6> 4be5 0000 	jalrc	a1
0+0756 <test3\+0x2fa> 4be6 0000 	jalrc	a2
0+075a <test3\+0x2fe> 4be7 0000 	jalrc	a3
0+075e <test3\+0x302> 4be8 0000 	jalrc	t0
0+0762 <test3\+0x306> 4bfe 0000 	jalrc	s8
0+0766 <test3\+0x30a> d810      	jalrc	zero
0+0768 <test3\+0x30c> d850      	jalrc	v0
0+076a <test3\+0x30e> d870      	jalrc	v1
0+076c <test3\+0x310> d890      	jalrc	a0
0+076e <test3\+0x312> d8b0      	jalrc	a1
0+0770 <test3\+0x314> d8d0      	jalrc	a2
0+0772 <test3\+0x316> d8f0      	jalrc	a3
0+0774 <test3\+0x318> d910      	jalrc	t0
0+0776 <test3\+0x31a> dbd0      	jalrc	s8
0+0778 <test3\+0x31c> 4bdf 0000 	jalrc	s8,ra
0+077c <test3\+0x320> 4840 0000 	jalrc	v0,zero
0+0780 <test3\+0x324> 4862 0000 	jalrc	v1,v0
0+0784 <test3\+0x328> 4843 0000 	jalrc	v0,v1
0+0788 <test3\+0x32c> 4844 0000 	jalrc	v0,a0
0+078c <test3\+0x330> 4845 0000 	jalrc	v0,a1
0+0790 <test3\+0x334> 4846 0000 	jalrc	v0,a2
0+0794 <test3\+0x338> 4847 0000 	jalrc	v0,a3
0+0798 <test3\+0x33c> 4848 0000 	jalrc	v0,t0
0+079c <test3\+0x340> 485e 0000 	jalrc	v0,s8
0+07a0 <test3\+0x344> 485f 0000 	jalrc	v0,ra
0+07a4 <test3\+0x348> 4be0 1000 	jalrc\.hb	zero
0+07a8 <test3\+0x34c> 4be2 1000 	jalrc\.hb	v0
0+07ac <test3\+0x350> 4be3 1000 	jalrc\.hb	v1
0+07b0 <test3\+0x354> 4be4 1000 	jalrc\.hb	a0
0+07b4 <test3\+0x358> 4be5 1000 	jalrc\.hb	a1
0+07b8 <test3\+0x35c> 4be6 1000 	jalrc\.hb	a2
0+07bc <test3\+0x360> 4be7 1000 	jalrc\.hb	a3
0+07c0 <test3\+0x364> 4be8 1000 	jalrc\.hb	t0
0+07c4 <test3\+0x368> 4bfe 1000 	jalrc\.hb	s8
0+07c8 <test3\+0x36c> 4be0 1000 	jalrc\.hb	zero
0+07cc <test3\+0x370> 4be2 1000 	jalrc\.hb	v0
0+07d0 <test3\+0x374> 4be3 1000 	jalrc\.hb	v1
0+07d4 <test3\+0x378> 4be4 1000 	jalrc\.hb	a0
0+07d8 <test3\+0x37c> 4be5 1000 	jalrc\.hb	a1
0+07dc <test3\+0x380> 4be6 1000 	jalrc\.hb	a2
0+07e0 <test3\+0x384> 4be7 1000 	jalrc\.hb	a3
0+07e4 <test3\+0x388> 4be8 1000 	jalrc\.hb	t0
0+07e8 <test3\+0x38c> 4bfe 1000 	jalrc\.hb	s8
0+07ec <test3\+0x390> 4bdf 1000 	jalrc\.hb	s8,ra
0+07f0 <test3\+0x394> 4840 1000 	jalrc\.hb	v0,zero
0+07f4 <test3\+0x398> 4862 1000 	jalrc\.hb	v1,v0
0+07f8 <test3\+0x39c> 4843 1000 	jalrc\.hb	v0,v1
0+07fc <test3\+0x3a0> 4844 1000 	jalrc\.hb	v0,a0
0+0800 <test3\+0x3a4> 4845 1000 	jalrc\.hb	v0,a1
0+0804 <test3\+0x3a8> 4846 1000 	jalrc\.hb	v0,a2
0+0808 <test3\+0x3ac> 4847 1000 	jalrc\.hb	v0,a3
0+080c <test3\+0x3b0> 4848 1000 	jalrc\.hb	v0,t0
0+0810 <test3\+0x3b4> 485e 1000 	jalrc\.hb	v0,s8
0+0814 <test3\+0x3b8> 485f 1000 	jalrc\.hb	v0,ra
0+0818 <test3\+0x3bc> 4843 0000 	jalrc	v0,v1
0+081c <test3\+0x3c0> 4bdf 0000 	jalrc	s8,ra
0+0820 <test3\+0x3c4> d870      	jalrc	v1
0+0822 <test3\+0x3c6> dbf0      	jalrc	ra
0+0824 <test3\+0x3c8> 2a00 0000 	balc	00000828 <test3\+0x3cc>
			824: R_MICROMIPS_PC25_S1	test-0x4
0+0828 <test3\+0x3cc> 2a00 0000 	balc	00000bf2 <test3\+0x796>
			828: R_MICROMIPS_PC25_S1	test2-0x4
0+082c <test3\+0x3d0> 6040 0000 0000 	li	v0,0x0
			82e: R_MICROMIPS_32	test
0+0832 <test3\+0x3d6> 8460 0000 	lb	v1,0\(zero\)
0+0836 <test3\+0x3da> 8460 0004 	lb	v1,4\(zero\)
0+083a <test3\+0x3de> 8460 0000 	lb	v1,0\(zero\)
0+083e <test3\+0x3e2> 8460 0004 	lb	v1,4\(zero\)
0+0842 <test3\+0x3e6> e060 7000 	lui	v1,0x7
0+0846 <test3\+0x3ea> 8463 0fff 	lb	v1,4095\(v1\)
0+084a <test3\+0x3ee> e07f 8ffd 	lui	v1,0xffff8
0+084e <test3\+0x3f2> 8463 0000 	lb	v1,0\(v1\)
0+0852 <test3\+0x3f6> e060 f000 	lui	v1,0xf
0+0856 <test3\+0x3fa> 8463 0fff 	lb	v1,4095\(v1\)
0+085a <test3\+0x3fe> e07f 0ffd 	lui	v1,0xffff0
0+085e <test3\+0x402> 8463 0000 	lb	v1,0\(v1\)
0+0862 <test3\+0x406> e07f 8ffd 	lui	v1,0xffff8
0+0866 <test3\+0x40a> 8463 0000 	lb	v1,0\(v1\)
0+086a <test3\+0x40e> e07f 0ffd 	lui	v1,0xffff0
0+086e <test3\+0x412> 8463 0001 	lb	v1,1\(v1\)
0+0872 <test3\+0x416> e07f 8ffd 	lui	v1,0xffff8
0+0876 <test3\+0x41a> 8463 0001 	lb	v1,1\(v1\)
0+087a <test3\+0x41e> e060 0e01 	lui	v1,0xf0000
0+087e <test3\+0x422> 8463 0000 	lb	v1,0\(v1\)
0+0882 <test3\+0x426> 0060 9fff 	li	v1,-1
0+0886 <test3\+0x42a> 8463 0000 	lb	v1,0\(v1\)
0+088a <test3\+0x42e> e074 5244 	lui	v1,0x12345
0+088e <test3\+0x432> 8463 0678 	lb	v1,1656\(v1\)
0+0892 <test3\+0x436> 15c0      	lb	v1,0\(a0\)
0+0894 <test3\+0x438> 15c0      	lb	v1,0\(a0\)
0+0896 <test3\+0x43a> 8464 0004 	lb	v1,4\(a0\)
0+089a <test3\+0x43e> e060 7000 	lui	v1,0x7
0+089e <test3\+0x442> 2083 1950 	addu	v1,v1,a0
0+08a2 <test3\+0x446> 8463 0fff 	lb	v1,4095\(v1\)
0+08a6 <test3\+0x44a> e07f 8ffd 	lui	v1,0xffff8
0+08aa <test3\+0x44e> 2083 1950 	addu	v1,v1,a0
0+08ae <test3\+0x452> 8463 0000 	lb	v1,0\(v1\)
0+08b2 <test3\+0x456> e060 f000 	lui	v1,0xf
0+08b6 <test3\+0x45a> 2083 1950 	addu	v1,v1,a0
0+08ba <test3\+0x45e> 8463 0fff 	lb	v1,4095\(v1\)
0+08be <test3\+0x462> e07f 0ffd 	lui	v1,0xffff0
0+08c2 <test3\+0x466> 2083 1950 	addu	v1,v1,a0
0+08c6 <test3\+0x46a> 8463 0000 	lb	v1,0\(v1\)
0+08ca <test3\+0x46e> e07f 8ffd 	lui	v1,0xffff8
0+08ce <test3\+0x472> 2083 1950 	addu	v1,v1,a0
0+08d2 <test3\+0x476> 8463 0000 	lb	v1,0\(v1\)
0+08d6 <test3\+0x47a> e07f 0ffd 	lui	v1,0xffff0
0+08da <test3\+0x47e> 2083 1950 	addu	v1,v1,a0
0+08de <test3\+0x482> 8463 0001 	lb	v1,1\(v1\)
0+08e2 <test3\+0x486> e07f 8ffd 	lui	v1,0xffff8
0+08e6 <test3\+0x48a> 2083 1950 	addu	v1,v1,a0
0+08ea <test3\+0x48e> 8463 0001 	lb	v1,1\(v1\)
0+08ee <test3\+0x492> e060 0e01 	lui	v1,0xf0000
0+08f2 <test3\+0x496> 2083 1950 	addu	v1,v1,a0
0+08f6 <test3\+0x49a> 8463 0000 	lb	v1,0\(v1\)
0+08fa <test3\+0x49e> 0064 9fff 	addiu	v1,a0,-1
0+08fe <test3\+0x4a2> 8463 0000 	lb	v1,0\(v1\)
0+0902 <test3\+0x4a6> e074 5244 	lui	v1,0x12345
0+0906 <test3\+0x4aa> 2083 1950 	addu	v1,v1,a0
0+090a <test3\+0x4ae> 8463 0678 	lb	v1,1656\(v1\)
0+090e <test3\+0x4b2> a443 90ff 	lbu	v0,-1\(v1\)
0+0912 <test3\+0x4b6> 1538      	lbu	v0,0\(v1\)
0+0914 <test3\+0x4b8> 1538      	lbu	v0,0\(v1\)
0+0916 <test3\+0x4ba> 1539      	lbu	v0,1\(v1\)
0+0918 <test3\+0x4bc> 153a      	lbu	v0,2\(v1\)
0+091a <test3\+0x4be> 153b      	lbu	v0,3\(v1\)
0+091c <test3\+0x4c0> 8443 2004 	lbu	v0,4\(v1\)
0+0920 <test3\+0x4c4> 8443 2005 	lbu	v0,5\(v1\)
0+0924 <test3\+0x4c8> 8443 2006 	lbu	v0,6\(v1\)
0+0928 <test3\+0x4cc> 8443 2007 	lbu	v0,7\(v1\)
0+092c <test3\+0x4d0> 8443 2008 	lbu	v0,8\(v1\)
0+0930 <test3\+0x4d4> 8443 2009 	lbu	v0,9\(v1\)
0+0934 <test3\+0x4d8> 8443 200a 	lbu	v0,10\(v1\)
0+0938 <test3\+0x4dc> 8443 200b 	lbu	v0,11\(v1\)
0+093c <test3\+0x4e0> 8443 200c 	lbu	v0,12\(v1\)
0+0940 <test3\+0x4e4> 8443 200d 	lbu	v0,13\(v1\)
0+0944 <test3\+0x4e8> 8443 200e 	lbu	v0,14\(v1\)
0+0948 <test3\+0x4ec> 8442 200e 	lbu	v0,14\(v0\)
0+094c <test3\+0x4f0> 8444 200e 	lbu	v0,14\(a0\)
0+0950 <test3\+0x4f4> 8445 200e 	lbu	v0,14\(a1\)
0+0954 <test3\+0x4f8> 8446 200e 	lbu	v0,14\(a2\)
0+0958 <test3\+0x4fc> 8447 200e 	lbu	v0,14\(a3\)
0+095c <test3\+0x500> 8450 200e 	lbu	v0,14\(s0\)
0+0960 <test3\+0x504> 8451 200e 	lbu	v0,14\(s1\)
0+0964 <test3\+0x508> 8471 200e 	lbu	v1,14\(s1\)
0+0968 <test3\+0x50c> 8491 200e 	lbu	a0,14\(s1\)
0+096c <test3\+0x510> 84b1 200e 	lbu	a1,14\(s1\)
0+0970 <test3\+0x514> 84d1 200e 	lbu	a2,14\(s1\)
0+0974 <test3\+0x518> 84f1 200e 	lbu	a3,14\(s1\)
0+0978 <test3\+0x51c> 8611 200e 	lbu	s0,14\(s1\)
0+097c <test3\+0x520> 8631 200e 	lbu	s1,14\(s1\)
0+0980 <test3\+0x524> 8460 2000 	lbu	v1,0\(zero\)
0+0984 <test3\+0x528> 8460 2004 	lbu	v1,4\(zero\)
0+0988 <test3\+0x52c> 8460 2000 	lbu	v1,0\(zero\)
0+098c <test3\+0x530> 8460 2004 	lbu	v1,4\(zero\)
0+0990 <test3\+0x534> e060 7000 	lui	v1,0x7
0+0994 <test3\+0x538> 8463 2fff 	lbu	v1,4095\(v1\)
0+0998 <test3\+0x53c> e07f 8ffd 	lui	v1,0xffff8
0+099c <test3\+0x540> 8463 2000 	lbu	v1,0\(v1\)
0+09a0 <test3\+0x544> e060 f000 	lui	v1,0xf
0+09a4 <test3\+0x548> 8463 2fff 	lbu	v1,4095\(v1\)
0+09a8 <test3\+0x54c> e07f 0ffd 	lui	v1,0xffff0
0+09ac <test3\+0x550> 8463 2000 	lbu	v1,0\(v1\)
0+09b0 <test3\+0x554> e07f 8ffd 	lui	v1,0xffff8
0+09b4 <test3\+0x558> 8463 2000 	lbu	v1,0\(v1\)
0+09b8 <test3\+0x55c> e07f 0ffd 	lui	v1,0xffff0
0+09bc <test3\+0x560> 8463 2001 	lbu	v1,1\(v1\)
0+09c0 <test3\+0x564> e07f 8ffd 	lui	v1,0xffff8
0+09c4 <test3\+0x568> 8463 2001 	lbu	v1,1\(v1\)
0+09c8 <test3\+0x56c> e060 0e01 	lui	v1,0xf0000
0+09cc <test3\+0x570> 8463 2000 	lbu	v1,0\(v1\)
0+09d0 <test3\+0x574> 0060 9fff 	li	v1,-1
0+09d4 <test3\+0x578> 8463 2000 	lbu	v1,0\(v1\)
0+09d8 <test3\+0x57c> e074 5244 	lui	v1,0x12345
0+09dc <test3\+0x580> 8463 2678 	lbu	v1,1656\(v1\)
0+09e0 <test3\+0x584> 15c8      	lbu	v1,0\(a0\)
0+09e2 <test3\+0x586> 15c8      	lbu	v1,0\(a0\)
0+09e4 <test3\+0x588> 8464 2004 	lbu	v1,4\(a0\)
0+09e8 <test3\+0x58c> e060 7000 	lui	v1,0x7
0+09ec <test3\+0x590> 2083 1950 	addu	v1,v1,a0
0+09f0 <test3\+0x594> 8463 2fff 	lbu	v1,4095\(v1\)
0+09f4 <test3\+0x598> e07f 8ffd 	lui	v1,0xffff8
0+09f8 <test3\+0x59c> 2083 1950 	addu	v1,v1,a0
0+09fc <test3\+0x5a0> 8463 2000 	lbu	v1,0\(v1\)
0+0a00 <test3\+0x5a4> e060 f000 	lui	v1,0xf
0+0a04 <test3\+0x5a8> 2083 1950 	addu	v1,v1,a0
0+0a08 <test3\+0x5ac> 8463 2fff 	lbu	v1,4095\(v1\)
0+0a0c <test3\+0x5b0> e07f 0ffd 	lui	v1,0xffff0
0+0a10 <test3\+0x5b4> 2083 1950 	addu	v1,v1,a0
0+0a14 <test3\+0x5b8> 8463 2000 	lbu	v1,0\(v1\)
0+0a18 <test3\+0x5bc> e07f 8ffd 	lui	v1,0xffff8
0+0a1c <test3\+0x5c0> 2083 1950 	addu	v1,v1,a0
0+0a20 <test3\+0x5c4> 8463 2000 	lbu	v1,0\(v1\)
0+0a24 <test3\+0x5c8> e07f 0ffd 	lui	v1,0xffff0
0+0a28 <test3\+0x5cc> 2083 1950 	addu	v1,v1,a0
0+0a2c <test3\+0x5d0> 8463 2001 	lbu	v1,1\(v1\)
0+0a30 <test3\+0x5d4> e07f 8ffd 	lui	v1,0xffff8
0+0a34 <test3\+0x5d8> 2083 1950 	addu	v1,v1,a0
0+0a38 <test3\+0x5dc> 8463 2001 	lbu	v1,1\(v1\)
0+0a3c <test3\+0x5e0> e060 0e01 	lui	v1,0xf0000
0+0a40 <test3\+0x5e4> 2083 1950 	addu	v1,v1,a0
0+0a44 <test3\+0x5e8> 8463 2000 	lbu	v1,0\(v1\)
0+0a48 <test3\+0x5ec> 0064 9fff 	addiu	v1,a0,-1
0+0a4c <test3\+0x5f0> 8463 2000 	lbu	v1,0\(v1\)
0+0a50 <test3\+0x5f4> e074 5244 	lui	v1,0x12345
0+0a54 <test3\+0x5f8> 2083 1950 	addu	v1,v1,a0
0+0a58 <test3\+0x5fc> 8463 2678 	lbu	v1,1656\(v1\)
0+0a5c <test3\+0x600> 8460 4000 	lh	v1,0\(zero\)
0+0a60 <test3\+0x604> 8460 4004 	lh	v1,4\(zero\)
0+0a64 <test3\+0x608> 8460 4000 	lh	v1,0\(zero\)
0+0a68 <test3\+0x60c> 8460 4004 	lh	v1,4\(zero\)
0+0a6c <test3\+0x610> e060 7000 	lui	v1,0x7
0+0a70 <test3\+0x614> 8463 4fff 	lh	v1,4095\(v1\)
0+0a74 <test3\+0x618> e07f 8ffd 	lui	v1,0xffff8
0+0a78 <test3\+0x61c> 8463 4000 	lh	v1,0\(v1\)
0+0a7c <test3\+0x620> e060 f000 	lui	v1,0xf
0+0a80 <test3\+0x624> 8463 4fff 	lh	v1,4095\(v1\)
0+0a84 <test3\+0x628> e07f 0ffd 	lui	v1,0xffff0
0+0a88 <test3\+0x62c> 8463 4000 	lh	v1,0\(v1\)
0+0a8c <test3\+0x630> e07f 8ffd 	lui	v1,0xffff8
0+0a90 <test3\+0x634> 8463 4000 	lh	v1,0\(v1\)
0+0a94 <test3\+0x638> e07f 0ffd 	lui	v1,0xffff0
0+0a98 <test3\+0x63c> 8463 4001 	lh	v1,1\(v1\)
0+0a9c <test3\+0x640> e07f 8ffd 	lui	v1,0xffff8
0+0aa0 <test3\+0x644> 8463 4001 	lh	v1,1\(v1\)
0+0aa4 <test3\+0x648> e060 0e01 	lui	v1,0xf0000
0+0aa8 <test3\+0x64c> 8463 4000 	lh	v1,0\(v1\)
0+0aac <test3\+0x650> 0060 9fff 	li	v1,-1
0+0ab0 <test3\+0x654> 8463 4000 	lh	v1,0\(v1\)
0+0ab4 <test3\+0x658> e074 5244 	lui	v1,0x12345
0+0ab8 <test3\+0x65c> 8463 4678 	lh	v1,1656\(v1\)
0+0abc <test3\+0x660> 35c0      	lh	v1,0\(a0\)
0+0abe <test3\+0x662> 35c0      	lh	v1,0\(a0\)
0+0ac0 <test3\+0x664> 35c4      	lh	v1,4\(a0\)
0+0ac2 <test3\+0x666> e060 7000 	lui	v1,0x7
0+0ac6 <test3\+0x66a> 2083 1950 	addu	v1,v1,a0
0+0aca <test3\+0x66e> 8463 4fff 	lh	v1,4095\(v1\)
0+0ace <test3\+0x672> e07f 8ffd 	lui	v1,0xffff8
0+0ad2 <test3\+0x676> 2083 1950 	addu	v1,v1,a0
0+0ad6 <test3\+0x67a> 8463 4000 	lh	v1,0\(v1\)
0+0ada <test3\+0x67e> e060 f000 	lui	v1,0xf
0+0ade <test3\+0x682> 2083 1950 	addu	v1,v1,a0
0+0ae2 <test3\+0x686> 8463 4fff 	lh	v1,4095\(v1\)
0+0ae6 <test3\+0x68a> e07f 0ffd 	lui	v1,0xffff0
0+0aea <test3\+0x68e> 2083 1950 	addu	v1,v1,a0
0+0aee <test3\+0x692> 8463 4000 	lh	v1,0\(v1\)
0+0af2 <test3\+0x696> e07f 8ffd 	lui	v1,0xffff8
0+0af6 <test3\+0x69a> 2083 1950 	addu	v1,v1,a0
0+0afa <test3\+0x69e> 8463 4000 	lh	v1,0\(v1\)
0+0afe <test3\+0x6a2> e07f 0ffd 	lui	v1,0xffff0
0+0b02 <test3\+0x6a6> 2083 1950 	addu	v1,v1,a0
0+0b06 <test3\+0x6aa> 8463 4001 	lh	v1,1\(v1\)
0+0b0a <test3\+0x6ae> e07f 8ffd 	lui	v1,0xffff8
0+0b0e <test3\+0x6b2> 2083 1950 	addu	v1,v1,a0
0+0b12 <test3\+0x6b6> 8463 4001 	lh	v1,1\(v1\)
0+0b16 <test3\+0x6ba> e060 0e01 	lui	v1,0xf0000
0+0b1a <test3\+0x6be> 2083 1950 	addu	v1,v1,a0
0+0b1e <test3\+0x6c2> 8463 4000 	lh	v1,0\(v1\)
0+0b22 <test3\+0x6c6> 0064 9fff 	addiu	v1,a0,-1
0+0b26 <test3\+0x6ca> 8463 4000 	lh	v1,0\(v1\)
0+0b2a <test3\+0x6ce> e074 5244 	lui	v1,0x12345
0+0b2e <test3\+0x6d2> 2083 1950 	addu	v1,v1,a0
0+0b32 <test3\+0x6d6> 8463 4678 	lh	v1,1656\(v1\)
0+0b36 <test3\+0x6da> 3538      	lhu	v0,0\(v1\)
0+0b38 <test3\+0x6dc> 3538      	lhu	v0,0\(v1\)
0+0b3a <test3\+0x6de> 353a      	lhu	v0,2\(v1\)
0+0b3c <test3\+0x6e0> 353c      	lhu	v0,4\(v1\)
0+0b3e <test3\+0x6e2> 353e      	lhu	v0,6\(v1\)
0+0b40 <test3\+0x6e4> 8443 6008 	lhu	v0,8\(v1\)
0+0b44 <test3\+0x6e8> 8443 600a 	lhu	v0,10\(v1\)
0+0b48 <test3\+0x6ec> 8443 600c 	lhu	v0,12\(v1\)
0+0b4c <test3\+0x6f0> 8443 600e 	lhu	v0,14\(v1\)
0+0b50 <test3\+0x6f4> 8443 6010 	lhu	v0,16\(v1\)
0+0b54 <test3\+0x6f8> 8443 6012 	lhu	v0,18\(v1\)
0+0b58 <test3\+0x6fc> 8443 6014 	lhu	v0,20\(v1\)
0+0b5c <test3\+0x700> 8443 6016 	lhu	v0,22\(v1\)
0+0b60 <test3\+0x704> 8443 6018 	lhu	v0,24\(v1\)
0+0b64 <test3\+0x708> 8443 601a 	lhu	v0,26\(v1\)
0+0b68 <test3\+0x70c> 8443 601c 	lhu	v0,28\(v1\)
0+0b6c <test3\+0x710> 8443 601e 	lhu	v0,30\(v1\)
0+0b70 <test3\+0x714> 8444 601e 	lhu	v0,30\(a0\)
0+0b74 <test3\+0x718> 8445 601e 	lhu	v0,30\(a1\)
0+0b78 <test3\+0x71c> 8446 601e 	lhu	v0,30\(a2\)
0+0b7c <test3\+0x720> 8447 601e 	lhu	v0,30\(a3\)
0+0b80 <test3\+0x724> 8442 601e 	lhu	v0,30\(v0\)
0+0b84 <test3\+0x728> 8450 601e 	lhu	v0,30\(s0\)
0+0b88 <test3\+0x72c> 8451 601e 	lhu	v0,30\(s1\)
0+0b8c <test3\+0x730> 8471 601e 	lhu	v1,30\(s1\)
0+0b90 <test3\+0x734> 8491 601e 	lhu	a0,30\(s1\)
0+0b94 <test3\+0x738> 84b1 601e 	lhu	a1,30\(s1\)
0+0b98 <test3\+0x73c> 84d1 601e 	lhu	a2,30\(s1\)
0+0b9c <test3\+0x740> 84f1 601e 	lhu	a3,30\(s1\)
0+0ba0 <test3\+0x744> 8611 601e 	lhu	s0,30\(s1\)
0+0ba4 <test3\+0x748> 8631 601e 	lhu	s1,30\(s1\)
0+0ba8 <test3\+0x74c> 8460 6000 	lhu	v1,0\(zero\)
0+0bac <test3\+0x750> 8460 6004 	lhu	v1,4\(zero\)
0+0bb0 <test3\+0x754> 8460 6000 	lhu	v1,0\(zero\)
0+0bb4 <test3\+0x758> 8460 6004 	lhu	v1,4\(zero\)
0+0bb8 <test3\+0x75c> e060 7000 	lui	v1,0x7
0+0bbc <test3\+0x760> 8463 6fff 	lhu	v1,4095\(v1\)
0+0bc0 <test3\+0x764> e07f 8ffd 	lui	v1,0xffff8
0+0bc4 <test3\+0x768> 8463 6000 	lhu	v1,0\(v1\)
0+0bc8 <test3\+0x76c> e060 f000 	lui	v1,0xf
0+0bcc <test3\+0x770> 8463 6fff 	lhu	v1,4095\(v1\)
0+0bd0 <test3\+0x774> e07f 0ffd 	lui	v1,0xffff0
0+0bd4 <test3\+0x778> 8463 6000 	lhu	v1,0\(v1\)
0+0bd8 <test3\+0x77c> e07f 8ffd 	lui	v1,0xffff8
0+0bdc <test3\+0x780> 8463 6000 	lhu	v1,0\(v1\)
0+0be0 <test3\+0x784> e07f 0ffd 	lui	v1,0xffff0
0+0be4 <test3\+0x788> 8463 6001 	lhu	v1,1\(v1\)
0+0be8 <test3\+0x78c> e07f 8ffd 	lui	v1,0xffff8
0+0bec <test3\+0x790> 8463 6001 	lhu	v1,1\(v1\)
0+0bf0 <test3\+0x794> e060 0e01 	lui	v1,0xf0000
0+0bf4 <test3\+0x798> 8463 6000 	lhu	v1,0\(v1\)
0+0bf8 <test3\+0x79c> 0060 9fff 	li	v1,-1
0+0bfc <test3\+0x7a0> 8463 6000 	lhu	v1,0\(v1\)
0+0c00 <test3\+0x7a4> e074 5244 	lui	v1,0x12345
0+0c04 <test3\+0x7a8> 8463 6678 	lhu	v1,1656\(v1\)
0+0c08 <test3\+0x7ac> 35c8      	lhu	v1,0\(a0\)
0+0c0a <test3\+0x7ae> 35c8      	lhu	v1,0\(a0\)
0+0c0c <test3\+0x7b0> 35cc      	lhu	v1,4\(a0\)
0+0c0e <test3\+0x7b2> e060 7000 	lui	v1,0x7
0+0c12 <test3\+0x7b6> 2083 1950 	addu	v1,v1,a0
0+0c16 <test3\+0x7ba> 8463 6fff 	lhu	v1,4095\(v1\)
0+0c1a <test3\+0x7be> e07f 8ffd 	lui	v1,0xffff8
0+0c1e <test3\+0x7c2> 2083 1950 	addu	v1,v1,a0
0+0c22 <test3\+0x7c6> 8463 6000 	lhu	v1,0\(v1\)
0+0c26 <test3\+0x7ca> e060 f000 	lui	v1,0xf
0+0c2a <test3\+0x7ce> 2083 1950 	addu	v1,v1,a0
0+0c2e <test3\+0x7d2> 8463 6fff 	lhu	v1,4095\(v1\)
0+0c32 <test3\+0x7d6> e07f 0ffd 	lui	v1,0xffff0
0+0c36 <test3\+0x7da> 2083 1950 	addu	v1,v1,a0
0+0c3a <test3\+0x7de> 8463 6000 	lhu	v1,0\(v1\)
0+0c3e <test3\+0x7e2> e07f 8ffd 	lui	v1,0xffff8
0+0c42 <test3\+0x7e6> 2083 1950 	addu	v1,v1,a0
0+0c46 <test3\+0x7ea> 8463 6000 	lhu	v1,0\(v1\)
0+0c4a <test3\+0x7ee> e07f 0ffd 	lui	v1,0xffff0
0+0c4e <test3\+0x7f2> 2083 1950 	addu	v1,v1,a0
0+0c52 <test3\+0x7f6> 8463 6001 	lhu	v1,1\(v1\)
0+0c56 <test3\+0x7fa> e07f 8ffd 	lui	v1,0xffff8
0+0c5a <test3\+0x7fe> 2083 1950 	addu	v1,v1,a0
0+0c5e <test3\+0x802> 8463 6001 	lhu	v1,1\(v1\)
0+0c62 <test3\+0x806> e060 0e01 	lui	v1,0xf0000
0+0c66 <test3\+0x80a> 2083 1950 	addu	v1,v1,a0
0+0c6a <test3\+0x80e> 8463 6000 	lhu	v1,0\(v1\)
0+0c6e <test3\+0x812> 0064 9fff 	addiu	v1,a0,-1
0+0c72 <test3\+0x816> 8463 6000 	lhu	v1,0\(v1\)
0+0c76 <test3\+0x81a> e074 5244 	lui	v1,0x12345
0+0c7a <test3\+0x81e> 2083 1950 	addu	v1,v1,a0
0+0c7e <test3\+0x822> 8463 6678 	lhu	v1,1656\(v1\)
0+0c82 <test3\+0x826> a460 4100 	ll	v1,0\(zero\)
0+0c86 <test3\+0x82a> a460 4100 	ll	v1,0\(zero\)
0+0c8a <test3\+0x82e> a460 4104 	ll	v1,4\(zero\)
0+0c8e <test3\+0x832> a460 4104 	ll	v1,4\(zero\)
0+0c92 <test3\+0x836> e060 8000 	lui	v1,0x8
0+0c96 <test3\+0x83a> a463 c1fc 	ll	v1,-4\(v1\)
0+0c9a <test3\+0x83e> e07f 8ffd 	lui	v1,0xffff8
0+0c9e <test3\+0x842> a463 4100 	ll	v1,0\(v1\)
0+0ca2 <test3\+0x846> e061 0000 	lui	v1,0x10
0+0ca6 <test3\+0x84a> a463 c1fc 	ll	v1,-4\(v1\)
0+0caa <test3\+0x84e> e07f 0ffd 	lui	v1,0xffff0
0+0cae <test3\+0x852> a463 4100 	ll	v1,0\(v1\)
0+0cb2 <test3\+0x856> e07f 8ffd 	lui	v1,0xffff8
0+0cb6 <test3\+0x85a> a463 4100 	ll	v1,0\(v1\)
0+0cba <test3\+0x85e> e07f 0ffd 	lui	v1,0xffff0
0+0cbe <test3\+0x862> a463 4104 	ll	v1,4\(v1\)
0+0cc2 <test3\+0x866> e07f 8ffd 	lui	v1,0xffff8
0+0cc6 <test3\+0x86a> a463 4104 	ll	v1,4\(v1\)
0+0cca <test3\+0x86e> e060 0e01 	lui	v1,0xf0000
0+0cce <test3\+0x872> a463 4100 	ll	v1,0\(v1\)
0+0cd2 <test3\+0x876> a460 c1fc 	ll	v1,-4\(zero\)
0+0cd6 <test3\+0x87a> 6060 1234 5600 	li	v1,0x12345600
0+0cdc <test3\+0x880> a463 c1e0 	ll	v1,-32\(v1\)
0+0ce0 <test3\+0x884> a464 4100 	ll	v1,0\(a0\)
0+0ce4 <test3\+0x888> a464 4100 	ll	v1,0\(a0\)
0+0ce8 <test3\+0x88c> a464 4104 	ll	v1,4\(a0\)
0+0cec <test3\+0x890> e060 8000 	lui	v1,0x8
0+0cf0 <test3\+0x894> 2083 1950 	addu	v1,v1,a0
0+0cf4 <test3\+0x898> a463 c1fc 	ll	v1,-4\(v1\)
0+0cf8 <test3\+0x89c> e07f 8ffd 	lui	v1,0xffff8
0+0cfc <test3\+0x8a0> 2083 1950 	addu	v1,v1,a0
0+0d00 <test3\+0x8a4> a463 4100 	ll	v1,0\(v1\)
0+0d04 <test3\+0x8a8> e061 0000 	lui	v1,0x10
0+0d08 <test3\+0x8ac> 2083 1950 	addu	v1,v1,a0
0+0d0c <test3\+0x8b0> a463 c1fc 	ll	v1,-4\(v1\)
0+0d10 <test3\+0x8b4> e07f 0ffd 	lui	v1,0xffff0
0+0d14 <test3\+0x8b8> 2083 1950 	addu	v1,v1,a0
0+0d18 <test3\+0x8bc> a463 4100 	ll	v1,0\(v1\)
0+0d1c <test3\+0x8c0> e07f 8ffd 	lui	v1,0xffff8
0+0d20 <test3\+0x8c4> 2083 1950 	addu	v1,v1,a0
0+0d24 <test3\+0x8c8> a463 4100 	ll	v1,0\(v1\)
0+0d28 <test3\+0x8cc> e07f 0ffd 	lui	v1,0xffff0
0+0d2c <test3\+0x8d0> 2083 1950 	addu	v1,v1,a0
0+0d30 <test3\+0x8d4> a463 4104 	ll	v1,4\(v1\)
0+0d34 <test3\+0x8d8> e07f 8ffd 	lui	v1,0xffff8
0+0d38 <test3\+0x8dc> 2083 1950 	addu	v1,v1,a0
0+0d3c <test3\+0x8e0> a463 4104 	ll	v1,4\(v1\)
0+0d40 <test3\+0x8e4> e060 0e01 	lui	v1,0xf0000
0+0d44 <test3\+0x8e8> 2083 1950 	addu	v1,v1,a0
0+0d48 <test3\+0x8ec> a463 4100 	ll	v1,0\(v1\)
0+0d4c <test3\+0x8f0> a464 c1fc 	ll	v1,-4\(a0\)
0+0d50 <test3\+0x8f4> 6060 1234 5600 	li	v1,0x12345600
0+0d56 <test3\+0x8fa> 2083 1950 	addu	v1,v1,a0
0+0d5a <test3\+0x8fe> a463 c1e0 	ll	v1,-32\(v1\)
0+0d5e <test3\+0x902> e060 0000 	lui	v1,0x0
0+0d62 <test3\+0x906> e07f f0fc 	lui	v1,0x7fff
0+0d66 <test3\+0x90a> e07f f1fc 	lui	v1,0xffff
0+0d6a <test3\+0x90e> 7540      	lw	v0,0\(a0\)
0+0d6c <test3\+0x910> 7540      	lw	v0,0\(a0\)
0+0d6e <test3\+0x912> 7541      	lw	v0,4\(a0\)
0+0d70 <test3\+0x914> 7542      	lw	v0,8\(a0\)
0+0d72 <test3\+0x916> 7543      	lw	v0,12\(a0\)
0+0d74 <test3\+0x918> 7544      	lw	v0,16\(a0\)
0+0d76 <test3\+0x91a> 7545      	lw	v0,20\(a0\)
0+0d78 <test3\+0x91c> 7546      	lw	v0,24\(a0\)
0+0d7a <test3\+0x91e> 7547      	lw	v0,28\(a0\)
0+0d7c <test3\+0x920> 7548      	lw	v0,32\(a0\)
0+0d7e <test3\+0x922> 7549      	lw	v0,36\(a0\)
0+0d80 <test3\+0x924> 754a      	lw	v0,40\(a0\)
0+0d82 <test3\+0x926> 754b      	lw	v0,44\(a0\)
0+0d84 <test3\+0x928> 754c      	lw	v0,48\(a0\)
0+0d86 <test3\+0x92a> 754d      	lw	v0,52\(a0\)
0+0d88 <test3\+0x92c> 754e      	lw	v0,56\(a0\)
0+0d8a <test3\+0x92e> 754f      	lw	v0,60\(a0\)
0+0d8c <test3\+0x930> 755f      	lw	v0,60\(a1\)
0+0d8e <test3\+0x932> 756f      	lw	v0,60\(a2\)
0+0d90 <test3\+0x934> 757f      	lw	v0,60\(a3\)
0+0d92 <test3\+0x936> 752f      	lw	v0,60\(v0\)
0+0d94 <test3\+0x938> 753f      	lw	v0,60\(v1\)
0+0d96 <test3\+0x93a> 750f      	lw	v0,60\(s0\)
0+0d98 <test3\+0x93c> 751f      	lw	v0,60\(s1\)
0+0d9a <test3\+0x93e> 759f      	lw	v1,60\(s1\)
0+0d9c <test3\+0x940> 761f      	lw	a0,60\(s1\)
0+0d9e <test3\+0x942> 769f      	lw	a1,60\(s1\)
0+0da0 <test3\+0x944> 771f      	lw	a2,60\(s1\)
0+0da2 <test3\+0x946> 779f      	lw	a3,60\(s1\)
0+0da4 <test3\+0x948> 741f      	lw	s0,60\(s1\)
0+0da6 <test3\+0x94a> 749f      	lw	s1,60\(s1\)
0+0da8 <test3\+0x94c> 5480      	lw	a0,0\(sp\)
0+0daa <test3\+0x94e> 5480      	lw	a0,0\(sp\)
0+0dac <test3\+0x950> 5481      	lw	a0,4\(sp\)
0+0dae <test3\+0x952> 5482      	lw	a0,8\(sp\)
0+0db0 <test3\+0x954> 5483      	lw	a0,12\(sp\)
0+0db2 <test3\+0x956> 5484      	lw	a0,16\(sp\)
0+0db4 <test3\+0x958> 5485      	lw	a0,20\(sp\)
0+0db6 <test3\+0x95a> 549f      	lw	a0,124\(sp\)
0+0db8 <test3\+0x95c> 545f      	lw	v0,124\(sp\)
0+0dba <test3\+0x95e> 545f      	lw	v0,124\(sp\)
0+0dbc <test3\+0x960> 547f      	lw	v1,124\(sp\)
0+0dbe <test3\+0x962> 549f      	lw	a0,124\(sp\)
0+0dc0 <test3\+0x964> 54bf      	lw	a1,124\(sp\)
0+0dc2 <test3\+0x966> 54df      	lw	a2,124\(sp\)
0+0dc4 <test3\+0x968> 54ff      	lw	a3,124\(sp\)
0+0dc6 <test3\+0x96a> 551f      	lw	t0,124\(sp\)
0+0dc8 <test3\+0x96c> 553f      	lw	t1,124\(sp\)
0+0dca <test3\+0x96e> 555f      	lw	t2,124\(sp\)
0+0dcc <test3\+0x970> 57df      	lw	s8,124\(sp\)
0+0dce <test3\+0x972> 57ff      	lw	ra,124\(sp\)
0+0dd0 <test3\+0x974> 849d 81f8 	lw	a0,504\(sp\)
0+0dd4 <test3\+0x978> 849d 81fc 	lw	a0,508\(sp\)
0+0dd8 <test3\+0x97c> 861d 81fc 	lw	s0,508\(sp\)
0+0ddc <test3\+0x980> 863d 81fc 	lw	s1,508\(sp\)
0+0de0 <test3\+0x984> 865d 81fc 	lw	s2,508\(sp\)
0+0de4 <test3\+0x988> 867d 81fc 	lw	s3,508\(sp\)
0+0de8 <test3\+0x98c> 869d 81fc 	lw	s4,508\(sp\)
0+0dec <test3\+0x990> 86bd 81fc 	lw	s5,508\(sp\)
0+0df0 <test3\+0x994> 87fd 81fc 	lw	ra,508\(sp\)
0+0df4 <test3\+0x998> 8460 8000 	lw	v1,0\(zero\)
0+0df8 <test3\+0x99c> 8460 8004 	lw	v1,4\(zero\)
0+0dfc <test3\+0x9a0> 9460      	lw	v1,0\(zero\)
0+0dfe <test3\+0x9a2> 9460      	lw	v1,0\(zero\)
0+0e00 <test3\+0x9a4> 9460      	lw	v1,0\(zero\)
0+0e02 <test3\+0x9a6> 9560      	lw	v1,4\(zero\)
0+0e04 <test3\+0x9a8> e060 7000 	lui	v1,0x7
0+0e08 <test3\+0x9ac> 8463 8fff 	lw	v1,4095\(v1\)
0+0e0c <test3\+0x9b0> e07f 8ffd 	lui	v1,0xffff8
0+0e10 <test3\+0x9b4> 8463 8000 	lw	v1,0\(v1\)
0+0e14 <test3\+0x9b8> e060 f000 	lui	v1,0xf
0+0e18 <test3\+0x9bc> 8463 8fff 	lw	v1,4095\(v1\)
0+0e1c <test3\+0x9c0> e07f 0ffd 	lui	v1,0xffff0
0+0e20 <test3\+0x9c4> 8463 8000 	lw	v1,0\(v1\)
0+0e24 <test3\+0x9c8> e07f 8ffd 	lui	v1,0xffff8
0+0e28 <test3\+0x9cc> 8463 8000 	lw	v1,0\(v1\)
0+0e2c <test3\+0x9d0> e07f 0ffd 	lui	v1,0xffff0
0+0e30 <test3\+0x9d4> 8463 8001 	lw	v1,1\(v1\)
0+0e34 <test3\+0x9d8> e07f 8ffd 	lui	v1,0xffff8
0+0e38 <test3\+0x9dc> 8463 8001 	lw	v1,1\(v1\)
0+0e3c <test3\+0x9e0> e060 0e01 	lui	v1,0xf0000
0+0e40 <test3\+0x9e4> 8463 8000 	lw	v1,0\(v1\)
0+0e44 <test3\+0x9e8> 0060 9fff 	li	v1,-1
0+0e48 <test3\+0x9ec> 8463 8000 	lw	v1,0\(v1\)
0+0e4c <test3\+0x9f0> e074 5244 	lui	v1,0x12345
0+0e50 <test3\+0x9f4> 8463 8678 	lw	v1,1656\(v1\)
0+0e54 <test3\+0x9f8> 75c0      	lw	v1,0\(a0\)
0+0e56 <test3\+0x9fa> 75c0      	lw	v1,0\(a0\)
0+0e58 <test3\+0x9fc> 75c1      	lw	v1,4\(a0\)
0+0e5a <test3\+0x9fe> e060 7000 	lui	v1,0x7
0+0e5e <test3\+0xa02> 2083 1950 	addu	v1,v1,a0
0+0e62 <test3\+0xa06> 8463 8fff 	lw	v1,4095\(v1\)
0+0e66 <test3\+0xa0a> e07f 8ffd 	lui	v1,0xffff8
0+0e6a <test3\+0xa0e> 2083 1950 	addu	v1,v1,a0
0+0e6e <test3\+0xa12> 8463 8000 	lw	v1,0\(v1\)
0+0e72 <test3\+0xa16> e060 f000 	lui	v1,0xf
0+0e76 <test3\+0xa1a> 2083 1950 	addu	v1,v1,a0
0+0e7a <test3\+0xa1e> 8463 8fff 	lw	v1,4095\(v1\)
0+0e7e <test3\+0xa22> e07f 0ffd 	lui	v1,0xffff0
0+0e82 <test3\+0xa26> 2083 1950 	addu	v1,v1,a0
0+0e86 <test3\+0xa2a> 8463 8000 	lw	v1,0\(v1\)
0+0e8a <test3\+0xa2e> e07f 8ffd 	lui	v1,0xffff8
0+0e8e <test3\+0xa32> 2083 1950 	addu	v1,v1,a0
0+0e92 <test3\+0xa36> 8463 8000 	lw	v1,0\(v1\)
0+0e96 <test3\+0xa3a> e07f 0ffd 	lui	v1,0xffff0
0+0e9a <test3\+0xa3e> 2083 1950 	addu	v1,v1,a0
0+0e9e <test3\+0xa42> 8463 8001 	lw	v1,1\(v1\)
0+0ea2 <test3\+0xa46> e07f 8ffd 	lui	v1,0xffff8
0+0ea6 <test3\+0xa4a> 2083 1950 	addu	v1,v1,a0
0+0eaa <test3\+0xa4e> 8463 8001 	lw	v1,1\(v1\)
0+0eae <test3\+0xa52> e060 0e01 	lui	v1,0xf0000
0+0eb2 <test3\+0xa56> 2083 1950 	addu	v1,v1,a0
0+0eb6 <test3\+0xa5a> 8463 8000 	lw	v1,0\(v1\)
0+0eba <test3\+0xa5e> 0064 9fff 	addiu	v1,a0,-1
0+0ebe <test3\+0xa62> 8463 8000 	lw	v1,0\(v1\)
0+0ec2 <test3\+0xa66> e074 5244 	lui	v1,0x12345
0+0ec6 <test3\+0xa6a> 2083 1950 	addu	v1,v1,a0
0+0eca <test3\+0xa6e> 8463 8678 	lw	v1,1656\(v1\)
0+0ece <test3\+0xa72> 52c7      	lwxs	v1,a0\(a1\)
0+0ed0 <test3\+0xa74> 2040 0030 	mfc0	v0,c0_index
0+0ed4 <test3\+0xa78> 2041 0030 	mfc0	v0,c0_random
0+0ed8 <test3\+0xa7c> 2042 0030 	mfc0	v0,c0_entrylo0
0+0edc <test3\+0xa80> 2043 0030 	mfc0	v0,c0_entrylo1
0+0ee0 <test3\+0xa84> 2044 0030 	mfc0	v0,c0_context
0+0ee4 <test3\+0xa88> 2045 0030 	mfc0	v0,c0_pagemask
0+0ee8 <test3\+0xa8c> 2046 0030 	mfc0	v0,c0_wired
0+0eec <test3\+0xa90> 2047 0030 	mfc0	v0,c0_hwrena
0+0ef0 <test3\+0xa94> 2048 0030 	mfc0	v0,c0_badvaddr
0+0ef4 <test3\+0xa98> 2049 0030 	mfc0	v0,c0_count
0+0ef8 <test3\+0xa9c> 204a 0030 	mfc0	v0,c0_entryhi
0+0efc <test3\+0xaa0> 204b 0030 	mfc0	v0,c0_compare
0+0f00 <test3\+0xaa4> 204c 0030 	mfc0	v0,c0_status
0+0f04 <test3\+0xaa8> 204d 0030 	mfc0	v0,c0_cause
0+0f08 <test3\+0xaac> 204e 0030 	mfc0	v0,c0_epc
0+0f0c <test3\+0xab0> 204f 0030 	mfc0	v0,c0_prid
0+0f10 <test3\+0xab4> 2050 0030 	mfc0	v0,c0_config
0+0f14 <test3\+0xab8> 2051 0030 	mfc0	v0,c0_lladdr
0+0f18 <test3\+0xabc> 2052 0030 	mfc0	v0,c0_watchlo
0+0f1c <test3\+0xac0> 2053 0030 	mfc0	v0,c0_watchhi
0+0f20 <test3\+0xac4> 2054 0030 	mfc0	v0,c0_xcontext
0+0f24 <test3\+0xac8> 2055 0030 	mfc0	v0,\$21
0+0f28 <test3\+0xacc> 2056 0030 	mfc0	v0,\$22
0+0f2c <test3\+0xad0> 2057 0030 	mfc0	v0,c0_debug
0+0f30 <test3\+0xad4> 2058 0030 	mfc0	v0,c0_depc
0+0f34 <test3\+0xad8> 2059 0030 	mfc0	v0,c0_perfcnt
0+0f38 <test3\+0xadc> 205a 0030 	mfc0	v0,c0_errctl
0+0f3c <test3\+0xae0> 205b 0030 	mfc0	v0,c0_cacheerr
0+0f40 <test3\+0xae4> 205c 0030 	mfc0	v0,c0_taglo
0+0f44 <test3\+0xae8> 205d 0030 	mfc0	v0,c0_taghi
0+0f48 <test3\+0xaec> 205e 0030 	mfc0	v0,c0_errorepc
0+0f4c <test3\+0xaf0> 205f 0030 	mfc0	v0,c0_desave
0+0f50 <test3\+0xaf4> 2040 0030 	mfc0	v0,c0_index
0+0f54 <test3\+0xaf8> 2040 0830 	mfc0	v0,c0_mvpcontrol
0+0f58 <test3\+0xafc> 2040 1030 	mfc0	v0,c0_mvpconf0
0+0f5c <test3\+0xb00> 2040 1830 	mfc0	v0,c0_mvpconf1
0+0f60 <test3\+0xb04> 2040 2030 	mfc0	v0,\$0,4
0+0f64 <test3\+0xb08> 2040 2830 	mfc0	v0,\$0,5
0+0f68 <test3\+0xb0c> 2040 3030 	mfc0	v0,\$0,6
0+0f6c <test3\+0xb10> 2040 3830 	mfc0	v0,\$0,7
0+0f70 <test3\+0xb14> 2041 0030 	mfc0	v0,c0_random
0+0f74 <test3\+0xb18> 2041 0830 	mfc0	v0,c0_vpecontrol
0+0f78 <test3\+0xb1c> 2041 1030 	mfc0	v0,c0_vpeconf0
0+0f7c <test3\+0xb20> 2041 1830 	mfc0	v0,c0_vpeconf1
0+0f80 <test3\+0xb24> 2041 2030 	mfc0	v0,c0_yqmask
0+0f84 <test3\+0xb28> 2041 2830 	mfc0	v0,c0_vpeschedule
0+0f88 <test3\+0xb2c> 2041 3030 	mfc0	v0,c0_vpeschefback
0+0f8c <test3\+0xb30> 2041 3830 	mfc0	v0,\$1,7
0+0f90 <test3\+0xb34> 2042 0030 	mfc0	v0,c0_entrylo0
0+0f94 <test3\+0xb38> 2042 0830 	mfc0	v0,c0_tcstatus
0+0f98 <test3\+0xb3c> 2042 1030 	mfc0	v0,c0_tcbind
0+0f9c <test3\+0xb40> 2042 1830 	mfc0	v0,c0_tcrestart
0+0fa0 <test3\+0xb44> 2042 2030 	mfc0	v0,c0_tchalt
0+0fa4 <test3\+0xb48> 2042 2830 	mfc0	v0,c0_tccontext
0+0fa8 <test3\+0xb4c> 2042 3030 	mfc0	v0,c0_tcschedule
0+0fac <test3\+0xb50> 2042 3830 	mfc0	v0,c0_tcschefback
0+0fb0 <test3\+0xb54> 2062 1610 	movn	v0,v0,v1
0+0fb4 <test3\+0xb58> 2062 1610 	movn	v0,v0,v1
0+0fb8 <test3\+0xb5c> 2083 1610 	movn	v0,v1,a0
0+0fbc <test3\+0xb60> 2062 1210 	movz	v0,v0,v1
0+0fc0 <test3\+0xb64> 2062 1210 	movz	v0,v0,v1
0+0fc4 <test3\+0xb68> 2083 1210 	movz	v0,v1,a0
0+0fc8 <test3\+0xb6c> 2040 0070 	mtc0	v0,c0_index
0+0fcc <test3\+0xb70> 2041 0070 	mtc0	v0,c0_random
0+0fd0 <test3\+0xb74> 2042 0070 	mtc0	v0,c0_entrylo0
0+0fd4 <test3\+0xb78> 2043 0070 	mtc0	v0,c0_entrylo1
0+0fd8 <test3\+0xb7c> 2044 0070 	mtc0	v0,c0_context
0+0fdc <test3\+0xb80> 2045 0070 	mtc0	v0,c0_pagemask
0+0fe0 <test3\+0xb84> 2046 0070 	mtc0	v0,c0_wired
0+0fe4 <test3\+0xb88> 2047 0070 	mtc0	v0,c0_hwrena
0+0fe8 <test3\+0xb8c> 2048 0070 	mtc0	v0,c0_badvaddr
0+0fec <test3\+0xb90> 2049 0070 	mtc0	v0,c0_count
0+0ff0 <test3\+0xb94> 204a 0070 	mtc0	v0,c0_entryhi
0+0ff4 <test3\+0xb98> 204b 0070 	mtc0	v0,c0_compare
0+0ff8 <test3\+0xb9c> 204c 0070 	mtc0	v0,c0_status
0+0ffc <test3\+0xba0> 204d 0070 	mtc0	v0,c0_cause
0+1000 <test3\+0xba4> 204e 0070 	mtc0	v0,c0_epc
0+1004 <test3\+0xba8> 204f 0070 	mtc0	v0,c0_prid
0+1008 <test3\+0xbac> 2050 0070 	mtc0	v0,c0_config
0+100c <test3\+0xbb0> 2051 0070 	mtc0	v0,c0_lladdr
0+1010 <test3\+0xbb4> 2052 0070 	mtc0	v0,c0_watchlo
0+1014 <test3\+0xbb8> 2053 0070 	mtc0	v0,c0_watchhi
0+1018 <test3\+0xbbc> 2054 0070 	mtc0	v0,c0_xcontext
0+101c <test3\+0xbc0> 2055 0070 	mtc0	v0,\$21
0+1020 <test3\+0xbc4> 2056 0070 	mtc0	v0,\$22
0+1024 <test3\+0xbc8> 2057 0070 	mtc0	v0,c0_debug
0+1028 <test3\+0xbcc> 2058 0070 	mtc0	v0,c0_depc
0+102c <test3\+0xbd0> 2059 0070 	mtc0	v0,c0_perfcnt
0+1030 <test3\+0xbd4> 205a 0070 	mtc0	v0,c0_errctl
0+1034 <test3\+0xbd8> 205b 0070 	mtc0	v0,c0_cacheerr
0+1038 <test3\+0xbdc> 205c 0070 	mtc0	v0,c0_taglo
0+103c <test3\+0xbe0> 205d 0070 	mtc0	v0,c0_taghi
0+1040 <test3\+0xbe4> 205e 0070 	mtc0	v0,c0_errorepc
0+1044 <test3\+0xbe8> 205f 0070 	mtc0	v0,c0_desave
0+1048 <test3\+0xbec> 2040 0070 	mtc0	v0,c0_index
0+104c <test3\+0xbf0> 2040 0870 	mtc0	v0,c0_mvpcontrol
0+1050 <test3\+0xbf4> 2040 1070 	mtc0	v0,c0_mvpconf0
0+1054 <test3\+0xbf8> 2040 1870 	mtc0	v0,c0_mvpconf1
0+1058 <test3\+0xbfc> 2040 2070 	mtc0	v0,\$0,4
0+105c <test3\+0xc00> 2040 2870 	mtc0	v0,\$0,5
0+1060 <test3\+0xc04> 2040 3070 	mtc0	v0,\$0,6
0+1064 <test3\+0xc08> 2040 3870 	mtc0	v0,\$0,7
0+1068 <test3\+0xc0c> 2041 0070 	mtc0	v0,c0_random
0+106c <test3\+0xc10> 2041 0870 	mtc0	v0,c0_vpecontrol
0+1070 <test3\+0xc14> 2041 1070 	mtc0	v0,c0_vpeconf0
0+1074 <test3\+0xc18> 2041 1870 	mtc0	v0,c0_vpeconf1
0+1078 <test3\+0xc1c> 2041 2070 	mtc0	v0,c0_yqmask
0+107c <test3\+0xc20> 2041 2870 	mtc0	v0,c0_vpeschedule
0+1080 <test3\+0xc24> 2041 3070 	mtc0	v0,c0_vpeschefback
0+1084 <test3\+0xc28> 2041 3870 	mtc0	v0,\$1,7
0+1088 <test3\+0xc2c> 2042 0070 	mtc0	v0,c0_entrylo0
0+108c <test3\+0xc30> 2042 0870 	mtc0	v0,c0_tcstatus
0+1090 <test3\+0xc34> 2042 1070 	mtc0	v0,c0_tcbind
0+1094 <test3\+0xc38> 2042 1870 	mtc0	v0,c0_tcrestart
0+1098 <test3\+0xc3c> 2042 2070 	mtc0	v0,c0_tchalt
0+109c <test3\+0xc40> 2042 2870 	mtc0	v0,c0_tccontext
0+10a0 <test3\+0xc44> 2042 3070 	mtc0	v0,c0_tcschedule
0+10a4 <test3\+0xc48> 2042 3870 	mtc0	v0,c0_tcschefback
0+10a8 <test3\+0xc4c> 2083 1018 	mul	v0,v1,a0
0+10ac <test3\+0xc50> 23fe e818 	mul	sp,s8,ra
0+10b0 <test3\+0xc54> 2082 1018 	mul	v0,v0,a0
0+10b4 <test3\+0xc58> 2082 1018 	mul	v0,v0,a0
0+10b8 <test3\+0xc5c> 0020 0000 	li	at,0
0+10bc <test3\+0xc60> 2022 1018 	mul	v0,v0,at
0+10c0 <test3\+0xc64> 0020 0001 	li	at,1
0+10c4 <test3\+0xc68> 2022 1018 	mul	v0,v0,at
0+10c8 <test3\+0xc6c> 6020 0000 7fff 	li	at,0x7fff
0+10ce <test3\+0xc72> 2022 1018 	mul	v0,v0,at
0+10d2 <test3\+0xc76> e03f 8ffd 	lui	at,0xffff8
0+10d6 <test3\+0xc7a> 2022 1018 	mul	v0,v0,at
0+10da <test3\+0xc7e> 6020 0000 ffff 	li	at,0xffff
0+10e0 <test3\+0xc84> 2022 1018 	mul	v0,v0,at
0+10e4 <test3\+0xc88> 2060 1190 	neg	v0,v1
0+10e8 <test3\+0xc8c> 2040 1190 	neg	v0,v0
0+10ec <test3\+0xc90> 2040 1190 	neg	v0,v0
0+10f0 <test3\+0xc94> 2060 11d0 	negu	v0,v1
0+10f4 <test3\+0xc98> 2040 11d0 	negu	v0,v0
0+10f8 <test3\+0xc9c> 2040 11d0 	negu	v0,v0
0+10fc <test3\+0xca0> 2060 11d0 	negu	v0,v1
0+1100 <test3\+0xca4> 2040 11d0 	negu	v0,v0
0+1104 <test3\+0xca8> 2040 11d0 	negu	v0,v0
0+1108 <test3\+0xcac> 5120      	not	v0,v0
0+110a <test3\+0xcae> 5120      	not	v0,v0
0+110c <test3\+0xcb0> 5130      	not	v0,v1
0+110e <test3\+0xcb2> 5140      	not	v0,a0
0+1110 <test3\+0xcb4> 5150      	not	v0,a1
0+1112 <test3\+0xcb6> 5160      	not	v0,a2
0+1114 <test3\+0xcb8> 5170      	not	v0,a3
0+1116 <test3\+0xcba> 5100      	not	v0,s0
0+1118 <test3\+0xcbc> 5110      	not	v0,s1
0+111a <test3\+0xcbe> 5190      	not	v1,s1
0+111c <test3\+0xcc0> 5210      	not	a0,s1
0+111e <test3\+0xcc2> 5290      	not	a1,s1
0+1120 <test3\+0xcc4> 5310      	not	a2,s1
0+1122 <test3\+0xcc6> 5390      	not	a3,s1
0+1124 <test3\+0xcc8> 5010      	not	s0,s1
0+1126 <test3\+0xcca> 5090      	not	s1,s1
0+1128 <test3\+0xccc> 2007 12d0 	not	v0,a3
0+112c <test3\+0xcd0> 20e0 12d0 	nor	v0,zero,a3
0+1130 <test3\+0xcd4> 2083 12d0 	nor	v0,v1,a0
0+1134 <test3\+0xcd8> 23fe ead0 	nor	sp,s8,ra
0+1138 <test3\+0xcdc> 2082 12d0 	nor	v0,v0,a0
0+113c <test3\+0xce0> 2082 12d0 	nor	v0,v0,a0
0+1140 <test3\+0xce4> e020 8000 	lui	at,0x8
0+1144 <test3\+0xce8> 2023 12d0 	nor	v0,v1,at
0+1148 <test3\+0xcec> 6020 0000 ffff 	li	at,0xffff
0+114e <test3\+0xcf2> 2023 12d0 	nor	v0,v1,at
0+1152 <test3\+0xcf6> e021 0000 	lui	at,0x10
0+1156 <test3\+0xcfa> 2023 12d0 	nor	v0,v1,at
0+115a <test3\+0xcfe> e03f 8ffd 	lui	at,0xffff8
0+115e <test3\+0xd02> 2023 12d0 	nor	v0,v1,at
0+1162 <test3\+0xd06> 6020 ffff 7fff 	li	at,0xffff7fff
0+1168 <test3\+0xd0c> 2023 12d0 	nor	v0,v1,at
0+116c <test3\+0xd10> 2016 1290 	move	v0,s6
0+1170 <test3\+0xd14> 2002 b290 	move	s6,v0
0+1174 <test3\+0xd18> 22c0 1290 	or	v0,zero,s6
0+1178 <test3\+0xd1c> 2040 b290 	or	s6,zero,v0
0+117c <test3\+0xd20> 512c      	or	v0,v0,v0
0+117e <test3\+0xd22> 513c      	or	v0,v0,v1
0+1180 <test3\+0xd24> 514c      	or	v0,v0,a0
0+1182 <test3\+0xd26> 515c      	or	v0,v0,a1
0+1184 <test3\+0xd28> 516c      	or	v0,v0,a2
0+1186 <test3\+0xd2a> 517c      	or	v0,v0,a3
0+1188 <test3\+0xd2c> 510c      	or	v0,v0,s0
0+118a <test3\+0xd2e> 511c      	or	v0,v0,s1
0+118c <test3\+0xd30> 51ac      	or	v1,v1,v0
0+118e <test3\+0xd32> 522c      	or	a0,a0,v0
0+1190 <test3\+0xd34> 52ac      	or	a1,a1,v0
0+1192 <test3\+0xd36> 532c      	or	a2,a2,v0
0+1194 <test3\+0xd38> 53ac      	or	a3,a3,v0
0+1196 <test3\+0xd3a> 502c      	or	s0,s0,v0
0+1198 <test3\+0xd3c> 50ac      	or	s1,s1,v0
0+119a <test3\+0xd3e> 512c      	or	v0,v0,v0
0+119c <test3\+0xd40> 513c      	or	v0,v0,v1
0+119e <test3\+0xd42> 513c      	or	v0,v0,v1
0+11a0 <test3\+0xd44> 2083 1290 	or	v0,v1,a0
0+11a4 <test3\+0xd48> 23fe ea90 	or	sp,s8,ra
0+11a8 <test3\+0xd4c> 2082 1290 	or	v0,v0,a0
0+11ac <test3\+0xd50> 2082 1290 	or	v0,v0,a0
0+11b0 <test3\+0xd54> e020 8000 	lui	at,0x8
0+11b4 <test3\+0xd58> 2023 1290 	or	v0,v1,at
0+11b8 <test3\+0xd5c> 6020 0000 ffff 	li	at,0xffff
0+11be <test3\+0xd62> 2023 1290 	or	v0,v1,at
0+11c2 <test3\+0xd66> e021 0000 	lui	at,0x10
0+11c6 <test3\+0xd6a> 2023 1290 	or	v0,v1,at
0+11ca <test3\+0xd6e> e03f 8ffd 	lui	at,0xffff8
0+11ce <test3\+0xd72> 2023 1290 	or	v0,v1,at
0+11d2 <test3\+0xd76> 6020 ffff 7fff 	li	at,0xffff7fff
0+11d8 <test3\+0xd7c> 2023 1290 	or	v0,v1,at
0+11dc <test3\+0xd80> 8064 0000 	ori	v1,a0,0
0+11e0 <test3\+0xd84> 8064 0fff 	ori	v1,a0,4095
0+11e4 <test3\+0xd88> 2040 01c0 	rdhwr	v0,hwr_cpunum
0+11e8 <test3\+0xd8c> 2041 01c0 	rdhwr	v0,hwr_synci_step
0+11ec <test3\+0xd90> 2042 01c0 	rdhwr	v0,hwr_cc
0+11f0 <test3\+0xd94> 2043 01c0 	rdhwr	v0,hwr_ccres
0+11f4 <test3\+0xd98> 2044 01c0 	rdhwr	v0,\$4
0+11f8 <test3\+0xd9c> 2045 01c0 	rdhwr	v0,\$5
0+11fc <test3\+0xda0> 2046 01c0 	rdhwr	v0,\$6
0+1200 <test3\+0xda4> 2047 01c0 	rdhwr	v0,\$7
0+1204 <test3\+0xda8> 2048 01c0 	rdhwr	v0,\$8
0+1208 <test3\+0xdac> 2049 01c0 	rdhwr	v0,\$9
0+120c <test3\+0xdb0> 204a 01c0 	rdhwr	v0,\$10
0+1210 <test3\+0xdb4> 2043 e17f 	rdpgpr	v0,v1
0+1214 <test3\+0xdb8> 2042 e17f 	rdpgpr	v0,v0
0+1218 <test3\+0xdbc> 2062 0158 	mod	zero,v0,v1
0+121c <test3\+0xdc0> 23fe 0158 	mod	zero,s8,ra
0+1220 <test3\+0xdc4> 2060 0158 	mod	zero,zero,v1
0+1224 <test3\+0xdc8> 23e0 0158 	mod	zero,zero,ra
0+1228 <test3\+0xdcc> 2003 1158 	mod	v0,v1,zero
0+122c <test3\+0xdd0> 2083 1158 	mod	v0,v1,a0
0+1230 <test3\+0xdd4> 1017      	break	0x7
0+1232 <test3\+0xdd6> 1060      	move	v1,zero
0+1234 <test3\+0xdd8> 1060      	move	v1,zero
0+1236 <test3\+0xdda> 0020 0002 	li	at,2
0+123a <test3\+0xdde> 2024 1958 	mod	v1,a0,at
0+123e <test3\+0xde2> 2080 11d0 	negu	v0,a0
0+1242 <test3\+0xde6> 2043 10d0 	rotr	v0,v1,v0
0+1246 <test3\+0xdea> 2080 09d0 	negu	at,a0
0+124a <test3\+0xdee> 2022 10d0 	rotr	v0,v0,at
0+124e <test3\+0xdf2> 2060 11d0 	negu	v0,v1
0+1252 <test3\+0xdf6> 2043 10d0 	rotr	v0,v1,v0
0+1256 <test3\+0xdfa> 2040 11d0 	negu	v0,v0
0+125a <test3\+0xdfe> 2043 10d0 	rotr	v0,v1,v0
0+125e <test3\+0xe02> 8043 c0c0 	rotr	v0,v1,0x0
0+1262 <test3\+0xe06> 8043 c0df 	rotr	v0,v1,0x1f
0+1266 <test3\+0xe0a> 8043 c0c1 	rotr	v0,v1,0x1
0+126a <test3\+0xe0e> 8042 c0c1 	rotr	v0,v0,0x1
0+126e <test3\+0xe12> 8042 c0c1 	rotr	v0,v0,0x1
0+1272 <test3\+0xe16> 8043 c0c0 	rotr	v0,v1,0x0
0+1276 <test3\+0xe1a> 8043 c0c1 	rotr	v0,v1,0x1
0+127a <test3\+0xe1e> 8043 c0df 	rotr	v0,v1,0x1f
0+127e <test3\+0xe22> 8042 c0df 	rotr	v0,v0,0x1f
0+1282 <test3\+0xe26> 8042 c0df 	rotr	v0,v0,0x1f
0+1286 <test3\+0xe2a> 2083 10d0 	rotr	v0,v1,a0
0+128a <test3\+0xe2e> 2082 10d0 	rotr	v0,v0,a0
0+128e <test3\+0xe32> 2083 10d0 	rotr	v0,v1,a0
0+1292 <test3\+0xe36> 2082 10d0 	rotr	v0,v0,a0
0+1296 <test3\+0xe3a> 2083 10d0 	rotr	v0,v1,a0
0+129a <test3\+0xe3e> 2082 10d0 	rotr	v0,v0,a0
0+129e <test3\+0xe42> 2083 10d0 	rotr	v0,v1,a0
0+12a2 <test3\+0xe46> 2082 10d0 	rotr	v0,v0,a0
0+12a6 <test3\+0xe4a> 1434      	sb	zero,0\(v1\)
0+12a8 <test3\+0xe4c> 1434      	sb	zero,0\(v1\)
0+12aa <test3\+0xe4e> 1435      	sb	zero,1\(v1\)
0+12ac <test3\+0xe50> 1436      	sb	zero,2\(v1\)
0+12ae <test3\+0xe52> 1437      	sb	zero,3\(v1\)
0+12b0 <test3\+0xe54> 8403 1004 	sb	zero,4\(v1\)
0+12b4 <test3\+0xe58> 8403 1005 	sb	zero,5\(v1\)
0+12b8 <test3\+0xe5c> 8403 1006 	sb	zero,6\(v1\)
0+12bc <test3\+0xe60> 8403 1007 	sb	zero,7\(v1\)
0+12c0 <test3\+0xe64> 8403 1008 	sb	zero,8\(v1\)
0+12c4 <test3\+0xe68> 8403 1009 	sb	zero,9\(v1\)
0+12c8 <test3\+0xe6c> 8403 100a 	sb	zero,10\(v1\)
0+12cc <test3\+0xe70> 8403 100b 	sb	zero,11\(v1\)
0+12d0 <test3\+0xe74> 8403 100c 	sb	zero,12\(v1\)
0+12d4 <test3\+0xe78> 8403 100d 	sb	zero,13\(v1\)
0+12d8 <test3\+0xe7c> 8403 100e 	sb	zero,14\(v1\)
0+12dc <test3\+0xe80> 8403 100f 	sb	zero,15\(v1\)
0+12e0 <test3\+0xe84> 8443 100f 	sb	v0,15\(v1\)
0+12e4 <test3\+0xe88> 8463 100f 	sb	v1,15\(v1\)
0+12e8 <test3\+0xe8c> 8483 100f 	sb	a0,15\(v1\)
0+12ec <test3\+0xe90> 84a3 100f 	sb	a1,15\(v1\)
0+12f0 <test3\+0xe94> 84c3 100f 	sb	a2,15\(v1\)
0+12f4 <test3\+0xe98> 84e3 100f 	sb	a3,15\(v1\)
0+12f8 <test3\+0xe9c> 8623 100f 	sb	s1,15\(v1\)
0+12fc <test3\+0xea0> 8624 100f 	sb	s1,15\(a0\)
0+1300 <test3\+0xea4> 8625 100f 	sb	s1,15\(a1\)
0+1304 <test3\+0xea8> 8626 100f 	sb	s1,15\(a2\)
0+1308 <test3\+0xeac> 8627 100f 	sb	s1,15\(a3\)
0+130c <test3\+0xeb0> 8622 100f 	sb	s1,15\(v0\)
0+1310 <test3\+0xeb4> 8630 100f 	sb	s1,15\(s0\)
0+1314 <test3\+0xeb8> 8631 100f 	sb	s1,15\(s1\)
0+1318 <test3\+0xebc> 8460 1004 	sb	v1,4\(zero\)
0+131c <test3\+0xec0> 8460 1004 	sb	v1,4\(zero\)
0+1320 <test3\+0xec4> 8460 1fff 	sb	v1,4095\(zero\)
0+1324 <test3\+0xec8> e020 f000 	lui	at,0xf
0+1328 <test3\+0xecc> 8461 1fff 	sb	v1,4095\(at\)
0+132c <test3\+0xed0> e03f 0ffd 	lui	at,0xffff0
0+1330 <test3\+0xed4> 8461 1000 	sb	v1,0\(at\)
0+1334 <test3\+0xed8> e03f 8ffd 	lui	at,0xffff8
0+1338 <test3\+0xedc> 8461 1000 	sb	v1,0\(at\)
0+133c <test3\+0xee0> e03f 0ffd 	lui	at,0xffff0
0+1340 <test3\+0xee4> 8461 1001 	sb	v1,1\(at\)
0+1344 <test3\+0xee8> e03f 8ffd 	lui	at,0xffff8
0+1348 <test3\+0xeec> 8461 1001 	sb	v1,1\(at\)
0+134c <test3\+0xef0> e020 0e01 	lui	at,0xf0000
0+1350 <test3\+0xef4> 8461 1000 	sb	v1,0\(at\)
0+1354 <test3\+0xef8> 0020 9fff 	li	at,-1
0+1358 <test3\+0xefc> 8461 1000 	sb	v1,0\(at\)
0+135c <test3\+0xf00> e034 5244 	lui	at,0x12345
0+1360 <test3\+0xf04> 8461 1678 	sb	v1,1656\(at\)
0+1364 <test3\+0xf08> 8464 1000 	sb	v1,0\(a0\)
0+1368 <test3\+0xf0c> 8464 1000 	sb	v1,0\(a0\)
0+136c <test3\+0xf10> 8464 1fff 	sb	v1,4095\(a0\)
0+1370 <test3\+0xf14> e020 f000 	lui	at,0xf
0+1374 <test3\+0xf18> 2081 0950 	addu	at,at,a0
0+1378 <test3\+0xf1c> 8461 1fff 	sb	v1,4095\(at\)
0+137c <test3\+0xf20> e03f 0ffd 	lui	at,0xffff0
0+1380 <test3\+0xf24> 2081 0950 	addu	at,at,a0
0+1384 <test3\+0xf28> 8461 1000 	sb	v1,0\(at\)
0+1388 <test3\+0xf2c> e03f 8ffd 	lui	at,0xffff8
0+138c <test3\+0xf30> 2081 0950 	addu	at,at,a0
0+1390 <test3\+0xf34> 8461 1000 	sb	v1,0\(at\)
0+1394 <test3\+0xf38> e03f 0ffd 	lui	at,0xffff0
0+1398 <test3\+0xf3c> 2081 0950 	addu	at,at,a0
0+139c <test3\+0xf40> 8461 1001 	sb	v1,1\(at\)
0+13a0 <test3\+0xf44> e03f 8ffd 	lui	at,0xffff8
0+13a4 <test3\+0xf48> 2081 0950 	addu	at,at,a0
0+13a8 <test3\+0xf4c> 8461 1001 	sb	v1,1\(at\)
0+13ac <test3\+0xf50> e020 0e01 	lui	at,0xf0000
0+13b0 <test3\+0xf54> 2081 0950 	addu	at,at,a0
0+13b4 <test3\+0xf58> 8461 1000 	sb	v1,0\(at\)
0+13b8 <test3\+0xf5c> 0024 9fff 	addiu	at,a0,-1
0+13bc <test3\+0xf60> 8461 1000 	sb	v1,0\(at\)
0+13c0 <test3\+0xf64> e034 5244 	lui	at,0x12345
0+13c4 <test3\+0xf68> 2081 0950 	addu	at,at,a0
0+13c8 <test3\+0xf6c> 8461 1678 	sb	v1,1656\(at\)
0+13cc <test3\+0xf70> a460 4904 	sc	v1,4\(zero\)
0+13d0 <test3\+0xf74> a460 4904 	sc	v1,4\(zero\)
0+13d4 <test3\+0xf78> 0020 07ff 	li	at,2047
0+13d8 <test3\+0xf7c> a461 4900 	sc	v1,0\(at\)
0+13dc <test3\+0xf80> 0020 9800 	li	at,-2048
0+13e0 <test3\+0xf84> a461 4900 	sc	v1,0\(at\)
0+13e4 <test3\+0xf88> e020 8000 	lui	at,0x8
0+13e8 <test3\+0xf8c> a461 c9fc 	sc	v1,-4\(at\)
0+13ec <test3\+0xf90> e03f 8ffd 	lui	at,0xffff8
0+13f0 <test3\+0xf94> a461 4900 	sc	v1,0\(at\)
0+13f4 <test3\+0xf98> e021 0000 	lui	at,0x10
0+13f8 <test3\+0xf9c> a461 c9fc 	sc	v1,-4\(at\)
0+13fc <test3\+0xfa0> e03f 0ffd 	lui	at,0xffff0
0+1400 <test3\+0xfa4> a461 4900 	sc	v1,0\(at\)
0+1404 <test3\+0xfa8> e03f 8ffd 	lui	at,0xffff8
0+1408 <test3\+0xfac> a461 4900 	sc	v1,0\(at\)
0+140c <test3\+0xfb0> e03f 0ffd 	lui	at,0xffff0
0+1410 <test3\+0xfb4> a461 4904 	sc	v1,4\(at\)
0+1414 <test3\+0xfb8> e03f 8ffd 	lui	at,0xffff8
0+1418 <test3\+0xfbc> a461 4904 	sc	v1,4\(at\)
0+141c <test3\+0xfc0> e020 0e01 	lui	at,0xf0000
0+1420 <test3\+0xfc4> a461 4900 	sc	v1,0\(at\)
0+1424 <test3\+0xfc8> a460 c9fc 	sc	v1,-4\(zero\)
0+1428 <test3\+0xfcc> 6020 1234 5600 	li	at,0x12345600
0+142e <test3\+0xfd2> a461 c9e0 	sc	v1,-32\(at\)
0+1432 <test3\+0xfd6> a464 4900 	sc	v1,0\(a0\)
0+1436 <test3\+0xfda> a464 4900 	sc	v1,0\(a0\)
0+143a <test3\+0xfde> 0024 07ff 	addiu	at,a0,2047
0+143e <test3\+0xfe2> a461 4900 	sc	v1,0\(at\)
0+1442 <test3\+0xfe6> 0024 9800 	addiu	at,a0,-2048
0+1446 <test3\+0xfea> a461 4900 	sc	v1,0\(at\)
0+144a <test3\+0xfee> e020 8000 	lui	at,0x8
0+144e <test3\+0xff2> 2081 0950 	addu	at,at,a0
0+1452 <test3\+0xff6> a461 c9fc 	sc	v1,-4\(at\)
0+1456 <test3\+0xffa> e03f 8ffd 	lui	at,0xffff8
0+145a <test3\+0xffe> 2081 0950 	addu	at,at,a0
0+145e <test3\+0x1002> a461 4900 	sc	v1,0\(at\)
0+1462 <test3\+0x1006> e021 0000 	lui	at,0x10
0+1466 <test3\+0x100a> 2081 0950 	addu	at,at,a0
0+146a <test3\+0x100e> a461 c9fc 	sc	v1,-4\(at\)
0+146e <test3\+0x1012> e03f 0ffd 	lui	at,0xffff0
0+1472 <test3\+0x1016> 2081 0950 	addu	at,at,a0
0+1476 <test3\+0x101a> a461 4900 	sc	v1,0\(at\)
0+147a <test3\+0x101e> e03f 8ffd 	lui	at,0xffff8
0+147e <test3\+0x1022> 2081 0950 	addu	at,at,a0
0+1482 <test3\+0x1026> a461 4900 	sc	v1,0\(at\)
0+1486 <test3\+0x102a> e03f 0ffd 	lui	at,0xffff0
0+148a <test3\+0x102e> 2081 0950 	addu	at,at,a0
0+148e <test3\+0x1032> a461 4904 	sc	v1,4\(at\)
0+1492 <test3\+0x1036> e03f 8ffd 	lui	at,0xffff8
0+1496 <test3\+0x103a> 2081 0950 	addu	at,at,a0
0+149a <test3\+0x103e> a461 4904 	sc	v1,4\(at\)
0+149e <test3\+0x1042> e020 0e01 	lui	at,0xf0000
0+14a2 <test3\+0x1046> 2081 0950 	addu	at,at,a0
0+14a6 <test3\+0x104a> a461 4900 	sc	v1,0\(at\)
0+14aa <test3\+0x104e> a464 c9fc 	sc	v1,-4\(a0\)
0+14ae <test3\+0x1052> 6020 1234 5600 	li	at,0x12345600
0+14b4 <test3\+0x1058> 2081 0950 	addu	at,at,a0
0+14b8 <test3\+0x105c> a461 c9e0 	sc	v1,-32\(at\)
0+14bc <test3\+0x1060> 1018      	sdbbp	0x0
0+14be <test3\+0x1062> 1018      	sdbbp	0x0
0+14c0 <test3\+0x1064> 1019      	sdbbp	0x1
0+14c2 <test3\+0x1066> 101a      	sdbbp	0x2
0+14c4 <test3\+0x1068> 101b      	sdbbp	0x3
0+14c6 <test3\+0x106a> 101c      	sdbbp	0x4
0+14c8 <test3\+0x106c> 101d      	sdbbp	0x5
0+14ca <test3\+0x106e> 101e      	sdbbp	0x6
0+14cc <test3\+0x1070> 101f      	sdbbp	0x7
0+14ce <test3\+0x1072> 0018 0008 	sdbbp	0x8
0+14d2 <test3\+0x1076> 0018 0009 	sdbbp	0x9
0+14d6 <test3\+0x107a> 0018 000a 	sdbbp	0xa
0+14da <test3\+0x107e> 0018 000b 	sdbbp	0xb
0+14de <test3\+0x1082> 0018 000c 	sdbbp	0xc
0+14e2 <test3\+0x1086> 0018 000d 	sdbbp	0xd
0+14e6 <test3\+0x108a> 0018 000e 	sdbbp	0xe
0+14ea <test3\+0x108e> 0018 000f 	sdbbp	0xf
0+14ee <test3\+0x1092> 001f ffff 	sdbbp	0x7ffff
0+14f2 <test3\+0x1096> 0018 0000 	sdbbp	0x0
0+14f6 <test3\+0x109a> 0018 0001 	sdbbp	0x1
0+14fa <test3\+0x109e> 0018 0002 	sdbbp	0x2
0+14fe <test3\+0x10a2> 0018 00ff 	sdbbp	0xff
0+1502 <test3\+0x10a6> 2043 2b3f 	seb	v0,v1
0+1506 <test3\+0x10aa> 2042 2b3f 	seb	v0,v0
0+150a <test3\+0x10ae> 2042 2b3f 	seb	v0,v0
0+150e <test3\+0x10b2> 2043 3b3f 	seh	v0,v1
0+1512 <test3\+0x10b6> 2042 3b3f 	seh	v0,v0
0+1516 <test3\+0x10ba> 2042 3b3f 	seh	v0,v0
0+151a <test3\+0x10be> 2083 1310 	xor	v0,v1,a0
0+151e <test3\+0x10c2> 8042 5001 	sltiu	v0,v0,1
0+1522 <test3\+0x10c6> 8043 5001 	sltiu	v0,v1,1
0+1526 <test3\+0x10ca> 8044 5001 	sltiu	v0,a0,1
0+152a <test3\+0x10ce> 8043 5001 	sltiu	v0,v1,1
0+152e <test3\+0x10d2> 8043 1001 	xori	v0,v1,1
0+1532 <test3\+0x10d6> 8042 5001 	sltiu	v0,v0,1
0+1536 <test3\+0x10da> 0043 0001 	addiu	v0,v1,1
0+153a <test3\+0x10de> 8042 5001 	sltiu	v0,v0,1
0+153e <test3\+0x10e2> 6020 ffff 7fff 	li	at,0xffff7fff
0+1544 <test3\+0x10e8> 2023 1310 	xor	v0,v1,at
0+1548 <test3\+0x10ec> 8042 5001 	sltiu	v0,v0,1
0+154c <test3\+0x10f0> 2083 1350 	slt	v0,v1,a0
0+1550 <test3\+0x10f4> 8042 1001 	xori	v0,v0,1
0+1554 <test3\+0x10f8> 2082 1350 	slt	v0,v0,a0
0+1558 <test3\+0x10fc> 8042 1001 	xori	v0,v0,1
0+155c <test3\+0x1100> 2082 1350 	slt	v0,v0,a0
0+1560 <test3\+0x1104> 8042 1001 	xori	v0,v0,1
0+1564 <test3\+0x1108> 8043 4000 	slti	v0,v1,0
0+1568 <test3\+0x110c> 8042 1001 	xori	v0,v0,1
0+156c <test3\+0x1110> e03f 8ffd 	lui	at,0xffff8
0+1570 <test3\+0x1114> 2023 1350 	slt	v0,v1,at
0+1574 <test3\+0x1118> 8042 1001 	xori	v0,v0,1
0+1578 <test3\+0x111c> 8043 4000 	slti	v0,v1,0
0+157c <test3\+0x1120> 8042 1001 	xori	v0,v0,1
0+1580 <test3\+0x1124> 6020 0000 7fff 	li	at,0x7fff
0+1586 <test3\+0x112a> 2023 1350 	slt	v0,v1,at
0+158a <test3\+0x112e> 8042 1001 	xori	v0,v0,1
0+158e <test3\+0x1132> 6020 0000 ffff 	li	at,0xffff
0+1594 <test3\+0x1138> 2023 1350 	slt	v0,v1,at
0+1598 <test3\+0x113c> 8042 1001 	xori	v0,v0,1
0+159c <test3\+0x1140> e021 0000 	lui	at,0x10
0+15a0 <test3\+0x1144> 2023 1350 	slt	v0,v1,at
0+15a4 <test3\+0x1148> 8042 1001 	xori	v0,v0,1
0+15a8 <test3\+0x114c> 6020 ffff 7fff 	li	at,0xffff7fff
0+15ae <test3\+0x1152> 2023 1350 	slt	v0,v1,at
0+15b2 <test3\+0x1156> 8042 1001 	xori	v0,v0,1
0+15b6 <test3\+0x115a> 2083 1390 	sltu	v0,v1,a0
0+15ba <test3\+0x115e> 8042 1001 	xori	v0,v0,1
0+15be <test3\+0x1162> 2082 1390 	sltu	v0,v0,a0
0+15c2 <test3\+0x1166> 8042 1001 	xori	v0,v0,1
0+15c6 <test3\+0x116a> 2082 1390 	sltu	v0,v0,a0
0+15ca <test3\+0x116e> 8042 1001 	xori	v0,v0,1
0+15ce <test3\+0x1172> 8043 5000 	sltiu	v0,v1,0
0+15d2 <test3\+0x1176> 8042 1001 	xori	v0,v0,1
0+15d6 <test3\+0x117a> e03f 8ffd 	lui	at,0xffff8
0+15da <test3\+0x117e> 2023 1390 	sltu	v0,v1,at
0+15de <test3\+0x1182> 8042 1001 	xori	v0,v0,1
0+15e2 <test3\+0x1186> 8043 5000 	sltiu	v0,v1,0
0+15e6 <test3\+0x118a> 8042 1001 	xori	v0,v0,1
0+15ea <test3\+0x118e> 6020 0000 7fff 	li	at,0x7fff
0+15f0 <test3\+0x1194> 2023 1390 	sltu	v0,v1,at
0+15f4 <test3\+0x1198> 8042 1001 	xori	v0,v0,1
0+15f8 <test3\+0x119c> 6020 0000 ffff 	li	at,0xffff
0+15fe <test3\+0x11a2> 2023 1390 	sltu	v0,v1,at
0+1602 <test3\+0x11a6> 8042 1001 	xori	v0,v0,1
0+1606 <test3\+0x11aa> e021 0000 	lui	at,0x10
0+160a <test3\+0x11ae> 2023 1390 	sltu	v0,v1,at
0+160e <test3\+0x11b2> 8042 1001 	xori	v0,v0,1
0+1612 <test3\+0x11b6> 6020 ffff 7fff 	li	at,0xffff7fff
0+1618 <test3\+0x11bc> 2023 1390 	sltu	v0,v1,at
0+161c <test3\+0x11c0> 8042 1001 	xori	v0,v0,1
0+1620 <test3\+0x11c4> 2064 1350 	slt	v0,a0,v1
0+1624 <test3\+0x11c8> 2044 1350 	slt	v0,a0,v0
0+1628 <test3\+0x11cc> 2044 1350 	slt	v0,a0,v0
0+162c <test3\+0x11d0> 0020 0000 	li	at,0
0+1630 <test3\+0x11d4> 2061 1350 	slt	v0,at,v1
0+1634 <test3\+0x11d8> e03f 8ffd 	lui	at,0xffff8
0+1638 <test3\+0x11dc> 2061 1350 	slt	v0,at,v1
0+163c <test3\+0x11e0> 0020 0000 	li	at,0
0+1640 <test3\+0x11e4> 2061 1350 	slt	v0,at,v1
0+1644 <test3\+0x11e8> 6020 0000 7fff 	li	at,0x7fff
0+164a <test3\+0x11ee> 2061 1350 	slt	v0,at,v1
0+164e <test3\+0x11f2> 6020 0000 ffff 	li	at,0xffff
0+1654 <test3\+0x11f8> 2061 1350 	slt	v0,at,v1
0+1658 <test3\+0x11fc> e021 0000 	lui	at,0x10
0+165c <test3\+0x1200> 2061 1350 	slt	v0,at,v1
0+1660 <test3\+0x1204> 6020 ffff 7fff 	li	at,0xffff7fff
0+1666 <test3\+0x120a> 2061 1350 	slt	v0,at,v1
0+166a <test3\+0x120e> 2064 1390 	sltu	v0,a0,v1
0+166e <test3\+0x1212> 2044 1390 	sltu	v0,a0,v0
0+1672 <test3\+0x1216> 2044 1390 	sltu	v0,a0,v0
0+1676 <test3\+0x121a> 0020 0000 	li	at,0
0+167a <test3\+0x121e> 2061 1390 	sltu	v0,at,v1
0+167e <test3\+0x1222> e03f 8ffd 	lui	at,0xffff8
0+1682 <test3\+0x1226> 2061 1390 	sltu	v0,at,v1
0+1686 <test3\+0x122a> 0020 0000 	li	at,0
0+168a <test3\+0x122e> 2061 1390 	sltu	v0,at,v1
0+168e <test3\+0x1232> 6020 0000 7fff 	li	at,0x7fff
0+1694 <test3\+0x1238> 2061 1390 	sltu	v0,at,v1
0+1698 <test3\+0x123c> 6020 0000 ffff 	li	at,0xffff
0+169e <test3\+0x1242> 2061 1390 	sltu	v0,at,v1
0+16a2 <test3\+0x1246> e021 0000 	lui	at,0x10
0+16a6 <test3\+0x124a> 2061 1390 	sltu	v0,at,v1
0+16aa <test3\+0x124e> 6020 ffff 7fff 	li	at,0xffff7fff
0+16b0 <test3\+0x1254> 2061 1390 	sltu	v0,at,v1
0+16b4 <test3\+0x1258> 3531      	sh	v0,0\(v1\)
0+16b6 <test3\+0x125a> 3531      	sh	v0,0\(v1\)
0+16b8 <test3\+0x125c> 3533      	sh	v0,2\(v1\)
0+16ba <test3\+0x125e> 3535      	sh	v0,4\(v1\)
0+16bc <test3\+0x1260> 3537      	sh	v0,6\(v1\)
0+16be <test3\+0x1262> 8443 5008 	sh	v0,8\(v1\)
0+16c2 <test3\+0x1266> 8443 500a 	sh	v0,10\(v1\)
0+16c6 <test3\+0x126a> 8443 500c 	sh	v0,12\(v1\)
0+16ca <test3\+0x126e> 8443 500e 	sh	v0,14\(v1\)
0+16ce <test3\+0x1272> 8443 5010 	sh	v0,16\(v1\)
0+16d2 <test3\+0x1276> 8443 5012 	sh	v0,18\(v1\)
0+16d6 <test3\+0x127a> 8443 5014 	sh	v0,20\(v1\)
0+16da <test3\+0x127e> 8443 5016 	sh	v0,22\(v1\)
0+16de <test3\+0x1282> 8443 5018 	sh	v0,24\(v1\)
0+16e2 <test3\+0x1286> 8443 501a 	sh	v0,26\(v1\)
0+16e6 <test3\+0x128a> 8443 501c 	sh	v0,28\(v1\)
0+16ea <test3\+0x128e> 8443 501e 	sh	v0,30\(v1\)
0+16ee <test3\+0x1292> 8444 501e 	sh	v0,30\(a0\)
0+16f2 <test3\+0x1296> 8445 501e 	sh	v0,30\(a1\)
0+16f6 <test3\+0x129a> 8446 501e 	sh	v0,30\(a2\)
0+16fa <test3\+0x129e> 8447 501e 	sh	v0,30\(a3\)
0+16fe <test3\+0x12a2> 8442 501e 	sh	v0,30\(v0\)
0+1702 <test3\+0x12a6> 8450 501e 	sh	v0,30\(s0\)
0+1706 <test3\+0x12aa> 8451 501e 	sh	v0,30\(s1\)
0+170a <test3\+0x12ae> 8471 501e 	sh	v1,30\(s1\)
0+170e <test3\+0x12b2> 8491 501e 	sh	a0,30\(s1\)
0+1712 <test3\+0x12b6> 84b1 501e 	sh	a1,30\(s1\)
0+1716 <test3\+0x12ba> 84d1 501e 	sh	a2,30\(s1\)
0+171a <test3\+0x12be> 84f1 501e 	sh	a3,30\(s1\)
0+171e <test3\+0x12c2> 8631 501e 	sh	s1,30\(s1\)
0+1722 <test3\+0x12c6> 8411 501e 	sh	zero,30\(s1\)
0+1726 <test3\+0x12ca> 8460 5004 	sh	v1,4\(zero\)
0+172a <test3\+0x12ce> 8460 5004 	sh	v1,4\(zero\)
0+172e <test3\+0x12d2> 8460 5fff 	sh	v1,4095\(zero\)
0+1732 <test3\+0x12d6> e020 f000 	lui	at,0xf
0+1736 <test3\+0x12da> 8461 5fff 	sh	v1,4095\(at\)
0+173a <test3\+0x12de> e03f 0ffd 	lui	at,0xffff0
0+173e <test3\+0x12e2> 8461 5000 	sh	v1,0\(at\)
0+1742 <test3\+0x12e6> e03f 8ffd 	lui	at,0xffff8
0+1746 <test3\+0x12ea> 8461 5000 	sh	v1,0\(at\)
0+174a <test3\+0x12ee> e03f 0ffd 	lui	at,0xffff0
0+174e <test3\+0x12f2> 8461 5001 	sh	v1,1\(at\)
0+1752 <test3\+0x12f6> e03f 8ffd 	lui	at,0xffff8
0+1756 <test3\+0x12fa> 8461 5001 	sh	v1,1\(at\)
0+175a <test3\+0x12fe> e020 0e01 	lui	at,0xf0000
0+175e <test3\+0x1302> 8461 5000 	sh	v1,0\(at\)
0+1762 <test3\+0x1306> 0020 9fff 	li	at,-1
0+1766 <test3\+0x130a> 8461 5000 	sh	v1,0\(at\)
0+176a <test3\+0x130e> e034 5244 	lui	at,0x12345
0+176e <test3\+0x1312> 8461 5678 	sh	v1,1656\(at\)
0+1772 <test3\+0x1316> 8464 5000 	sh	v1,0\(a0\)
0+1776 <test3\+0x131a> 8464 5000 	sh	v1,0\(a0\)
0+177a <test3\+0x131e> 8464 5fff 	sh	v1,4095\(a0\)
0+177e <test3\+0x1322> e020 f000 	lui	at,0xf
0+1782 <test3\+0x1326> 2081 0950 	addu	at,at,a0
0+1786 <test3\+0x132a> 8461 5fff 	sh	v1,4095\(at\)
0+178a <test3\+0x132e> e03f 0ffd 	lui	at,0xffff0
0+178e <test3\+0x1332> 2081 0950 	addu	at,at,a0
0+1792 <test3\+0x1336> 8461 5000 	sh	v1,0\(at\)
0+1796 <test3\+0x133a> e03f 8ffd 	lui	at,0xffff8
0+179a <test3\+0x133e> 2081 0950 	addu	at,at,a0
0+179e <test3\+0x1342> 8461 5000 	sh	v1,0\(at\)
0+17a2 <test3\+0x1346> e03f 0ffd 	lui	at,0xffff0
0+17a6 <test3\+0x134a> 2081 0950 	addu	at,at,a0
0+17aa <test3\+0x134e> 8461 5001 	sh	v1,1\(at\)
0+17ae <test3\+0x1352> e03f 8ffd 	lui	at,0xffff8
0+17b2 <test3\+0x1356> 2081 0950 	addu	at,at,a0
0+17b6 <test3\+0x135a> 8461 5001 	sh	v1,1\(at\)
0+17ba <test3\+0x135e> e020 0e01 	lui	at,0xf0000
0+17be <test3\+0x1362> 2081 0950 	addu	at,at,a0
0+17c2 <test3\+0x1366> 8461 5000 	sh	v1,0\(at\)
0+17c6 <test3\+0x136a> 0024 9fff 	addiu	at,a0,-1
0+17ca <test3\+0x136e> 8461 5000 	sh	v1,0\(at\)
0+17ce <test3\+0x1372> e034 5244 	lui	at,0x12345
0+17d2 <test3\+0x1376> 2081 0950 	addu	at,at,a0
0+17d6 <test3\+0x137a> 8461 5678 	sh	v1,1656\(at\)
0+17da <test3\+0x137e> 2064 1350 	slt	v0,a0,v1
0+17de <test3\+0x1382> 8042 1001 	xori	v0,v0,1
0+17e2 <test3\+0x1386> 2044 1350 	slt	v0,a0,v0
0+17e6 <test3\+0x138a> 8042 1001 	xori	v0,v0,1
0+17ea <test3\+0x138e> 2044 1350 	slt	v0,a0,v0
0+17ee <test3\+0x1392> 8042 1001 	xori	v0,v0,1
0+17f2 <test3\+0x1396> 0020 0000 	li	at,0
0+17f6 <test3\+0x139a> 2061 1350 	slt	v0,at,v1
0+17fa <test3\+0x139e> 8042 1001 	xori	v0,v0,1
0+17fe <test3\+0x13a2> e03f 8ffd 	lui	at,0xffff8
0+1802 <test3\+0x13a6> 2061 1350 	slt	v0,at,v1
0+1806 <test3\+0x13aa> 8042 1001 	xori	v0,v0,1
0+180a <test3\+0x13ae> 0020 0000 	li	at,0
0+180e <test3\+0x13b2> 2061 1350 	slt	v0,at,v1
0+1812 <test3\+0x13b6> 8042 1001 	xori	v0,v0,1
0+1816 <test3\+0x13ba> 6020 0000 7fff 	li	at,0x7fff
0+181c <test3\+0x13c0> 2061 1350 	slt	v0,at,v1
0+1820 <test3\+0x13c4> 8042 1001 	xori	v0,v0,1
0+1824 <test3\+0x13c8> 6020 0000 ffff 	li	at,0xffff
0+182a <test3\+0x13ce> 2061 1350 	slt	v0,at,v1
0+182e <test3\+0x13d2> 8042 1001 	xori	v0,v0,1
0+1832 <test3\+0x13d6> e021 0000 	lui	at,0x10
0+1836 <test3\+0x13da> 2061 1350 	slt	v0,at,v1
0+183a <test3\+0x13de> 8042 1001 	xori	v0,v0,1
0+183e <test3\+0x13e2> 6020 ffff 7fff 	li	at,0xffff7fff
0+1844 <test3\+0x13e8> 2061 1350 	slt	v0,at,v1
0+1848 <test3\+0x13ec> 8042 1001 	xori	v0,v0,1
0+184c <test3\+0x13f0> 2064 1390 	sltu	v0,a0,v1
0+1850 <test3\+0x13f4> 8042 1001 	xori	v0,v0,1
0+1854 <test3\+0x13f8> 2044 1390 	sltu	v0,a0,v0
0+1858 <test3\+0x13fc> 8042 1001 	xori	v0,v0,1
0+185c <test3\+0x1400> 2044 1390 	sltu	v0,a0,v0
0+1860 <test3\+0x1404> 8042 1001 	xori	v0,v0,1
0+1864 <test3\+0x1408> 0020 0000 	li	at,0
0+1868 <test3\+0x140c> 2061 1390 	sltu	v0,at,v1
0+186c <test3\+0x1410> 8042 1001 	xori	v0,v0,1
0+1870 <test3\+0x1414> e03f 8ffd 	lui	at,0xffff8
0+1874 <test3\+0x1418> 2061 1390 	sltu	v0,at,v1
0+1878 <test3\+0x141c> 8042 1001 	xori	v0,v0,1
0+187c <test3\+0x1420> 0020 0000 	li	at,0
0+1880 <test3\+0x1424> 2061 1390 	sltu	v0,at,v1
0+1884 <test3\+0x1428> 8042 1001 	xori	v0,v0,1
0+1888 <test3\+0x142c> 6020 0000 7fff 	li	at,0x7fff
0+188e <test3\+0x1432> 2061 1390 	sltu	v0,at,v1
0+1892 <test3\+0x1436> 8042 1001 	xori	v0,v0,1
0+1896 <test3\+0x143a> 6020 0000 ffff 	li	at,0xffff
0+189c <test3\+0x1440> 2061 1390 	sltu	v0,at,v1
0+18a0 <test3\+0x1444> 8042 1001 	xori	v0,v0,1
0+18a4 <test3\+0x1448> e021 0000 	lui	at,0x10
0+18a8 <test3\+0x144c> 2061 1390 	sltu	v0,at,v1
0+18ac <test3\+0x1450> 8042 1001 	xori	v0,v0,1
0+18b0 <test3\+0x1454> 6020 ffff 7fff 	li	at,0xffff7fff
0+18b6 <test3\+0x145a> 2061 1390 	sltu	v0,at,v1
0+18ba <test3\+0x145e> 8042 1001 	xori	v0,v0,1
0+18be <test3\+0x1462> 3121      	sll	v0,v0,1
0+18c0 <test3\+0x1464> 3122      	sll	v0,v0,2
0+18c2 <test3\+0x1466> 3123      	sll	v0,v0,3
0+18c4 <test3\+0x1468> 3124      	sll	v0,v0,4
0+18c6 <test3\+0x146a> 3125      	sll	v0,v0,5
0+18c8 <test3\+0x146c> 3126      	sll	v0,v0,6
0+18ca <test3\+0x146e> 3127      	sll	v0,v0,7
0+18cc <test3\+0x1470> 3120      	sll	v0,v0,8
0+18ce <test3\+0x1472> 3130      	sll	v0,v1,8
0+18d0 <test3\+0x1474> 3140      	sll	v0,a0,8
0+18d2 <test3\+0x1476> 3150      	sll	v0,a1,8
0+18d4 <test3\+0x1478> 3160      	sll	v0,a2,8
0+18d6 <test3\+0x147a> 3170      	sll	v0,a3,8
0+18d8 <test3\+0x147c> 3100      	sll	v0,s0,8
0+18da <test3\+0x147e> 3110      	sll	v0,s1,8
0+18dc <test3\+0x1480> 31a0      	sll	v1,v0,8
0+18de <test3\+0x1482> 3220      	sll	a0,v0,8
0+18e0 <test3\+0x1484> 32a0      	sll	a1,v0,8
0+18e2 <test3\+0x1486> 3320      	sll	a2,v0,8
0+18e4 <test3\+0x1488> 33a0      	sll	a3,v0,8
0+18e6 <test3\+0x148a> 3020      	sll	s0,v0,8
0+18e8 <test3\+0x148c> 30a0      	sll	s1,v0,8
0+18ea <test3\+0x148e> 3121      	sll	v0,v0,1
0+18ec <test3\+0x1490> 31b1      	sll	v1,v1,1
0+18ee <test3\+0x1492> 2083 1010 	sll	v0,v1,a0
0+18f2 <test3\+0x1496> 2082 1010 	sll	v0,v0,a0
0+18f6 <test3\+0x149a> 2082 1010 	sll	v0,v0,a0
0+18fa <test3\+0x149e> 2082 1010 	sll	v0,v0,a0
0+18fe <test3\+0x14a2> 8044 c000 	sll	v0,a0,0x0
0+1902 <test3\+0x14a6> 8044 c001 	sll	v0,a0,0x1
0+1906 <test3\+0x14aa> 8044 c01f 	sll	v0,a0,0x1f
0+190a <test3\+0x14ae> 8042 c01f 	sll	v0,v0,0x1f
0+190e <test3\+0x14b2> 8042 c01f 	sll	v0,v0,0x1f
0+1912 <test3\+0x14b6> 2083 1350 	slt	v0,v1,a0
0+1916 <test3\+0x14ba> 2082 1350 	slt	v0,v0,a0
0+191a <test3\+0x14be> 2082 1350 	slt	v0,v0,a0
0+191e <test3\+0x14c2> 8043 4000 	slti	v0,v1,0
0+1922 <test3\+0x14c6> e03f 8ffd 	lui	at,0xffff8
0+1926 <test3\+0x14ca> 2023 1350 	slt	v0,v1,at
0+192a <test3\+0x14ce> 8043 4000 	slti	v0,v1,0
0+192e <test3\+0x14d2> 6020 0000 7fff 	li	at,0x7fff
0+1934 <test3\+0x14d8> 2023 1350 	slt	v0,v1,at
0+1938 <test3\+0x14dc> 6020 0000 ffff 	li	at,0xffff
0+193e <test3\+0x14e2> 2023 1350 	slt	v0,v1,at
0+1942 <test3\+0x14e6> e021 0000 	lui	at,0x10
0+1946 <test3\+0x14ea> 2023 1350 	slt	v0,v1,at
0+194a <test3\+0x14ee> 6020 ffff 7fff 	li	at,0xffff7fff
0+1950 <test3\+0x14f4> 2023 1350 	slt	v0,v1,at
0+1954 <test3\+0x14f8> 8064 4000 	slti	v1,a0,0
0+1958 <test3\+0x14fc> 8064 4fff 	slti	v1,a0,4095
0+195c <test3\+0x1500> 8064 5000 	sltiu	v1,a0,0
0+1960 <test3\+0x1504> 8064 5fff 	sltiu	v1,a0,4095
0+1964 <test3\+0x1508> 2083 1390 	sltu	v0,v1,a0
0+1968 <test3\+0x150c> 2082 1390 	sltu	v0,v0,a0
0+196c <test3\+0x1510> 2082 1390 	sltu	v0,v0,a0
0+1970 <test3\+0x1514> 8043 5000 	sltiu	v0,v1,0
0+1974 <test3\+0x1518> e03f 8ffd 	lui	at,0xffff8
0+1978 <test3\+0x151c> 2023 1390 	sltu	v0,v1,at
0+197c <test3\+0x1520> 8043 5000 	sltiu	v0,v1,0
0+1980 <test3\+0x1524> 6020 0000 7fff 	li	at,0x7fff
0+1986 <test3\+0x152a> 2023 1390 	sltu	v0,v1,at
0+198a <test3\+0x152e> 6020 0000 ffff 	li	at,0xffff
0+1990 <test3\+0x1534> 2023 1390 	sltu	v0,v1,at
0+1994 <test3\+0x1538> e021 0000 	lui	at,0x10
0+1998 <test3\+0x153c> 2023 1390 	sltu	v0,v1,at
0+199c <test3\+0x1540> 6020 ffff 7fff 	li	at,0xffff7fff
0+19a2 <test3\+0x1546> 2023 1390 	sltu	v0,v1,at
0+19a6 <test3\+0x154a> 2083 1310 	xor	v0,v1,a0
0+19aa <test3\+0x154e> 2040 1390 	sltu	v0,zero,v0
0+19ae <test3\+0x1552> 2080 1390 	sltu	v0,zero,a0
0+19b2 <test3\+0x1556> 2060 1390 	sltu	v0,zero,v1
0+19b6 <test3\+0x155a> 2060 1390 	sltu	v0,zero,v1
0+19ba <test3\+0x155e> 8043 1001 	xori	v0,v1,1
0+19be <test3\+0x1562> 2040 1390 	sltu	v0,zero,v0
0+19c2 <test3\+0x1566> 0043 0001 	addiu	v0,v1,1
0+19c6 <test3\+0x156a> 2040 1390 	sltu	v0,zero,v0
0+19ca <test3\+0x156e> 6020 ffff 7fff 	li	at,0xffff7fff
0+19d0 <test3\+0x1574> 2023 1310 	xor	v0,v1,at
0+19d4 <test3\+0x1578> 2040 1390 	sltu	v0,zero,v0
0+19d8 <test3\+0x157c> 2083 1090 	sra	v0,v1,a0
0+19dc <test3\+0x1580> 2082 1090 	sra	v0,v0,a0
0+19e0 <test3\+0x1584> 2082 1090 	sra	v0,v0,a0
0+19e4 <test3\+0x1588> 2082 1090 	sra	v0,v0,a0
0+19e8 <test3\+0x158c> 8044 c080 	sra	v0,a0,0x0
0+19ec <test3\+0x1590> 8044 c081 	sra	v0,a0,0x1
0+19f0 <test3\+0x1594> 8044 c09f 	sra	v0,a0,0x1f
0+19f4 <test3\+0x1598> 8042 c09f 	sra	v0,v0,0x1f
0+19f8 <test3\+0x159c> 8042 c09f 	sra	v0,v0,0x1f
0+19fc <test3\+0x15a0> 2083 1050 	srl	v0,v1,a0
0+1a00 <test3\+0x15a4> 2082 1050 	srl	v0,v0,a0
0+1a04 <test3\+0x15a8> 2082 1050 	srl	v0,v0,a0
0+1a08 <test3\+0x15ac> 2082 1050 	srl	v0,v0,a0
0+1a0c <test3\+0x15b0> 8044 c040 	srl	v0,a0,0x0
0+1a10 <test3\+0x15b4> 3149      	srl	v0,a0,1
0+1a12 <test3\+0x15b6> 8044 c05f 	srl	v0,a0,0x1f
0+1a16 <test3\+0x15ba> 8042 c05f 	srl	v0,v0,0x1f
0+1a1a <test3\+0x15be> 8042 c05f 	srl	v0,v0,0x1f
0+1a1e <test3\+0x15c2> 3129      	srl	v0,v0,1
0+1a20 <test3\+0x15c4> 312a      	srl	v0,v0,2
0+1a22 <test3\+0x15c6> 312b      	srl	v0,v0,3
0+1a24 <test3\+0x15c8> 312c      	srl	v0,v0,4
0+1a26 <test3\+0x15ca> 312d      	srl	v0,v0,5
0+1a28 <test3\+0x15cc> 312e      	srl	v0,v0,6
0+1a2a <test3\+0x15ce> 312f      	srl	v0,v0,7
0+1a2c <test3\+0x15d0> 3128      	srl	v0,v0,8
0+1a2e <test3\+0x15d2> 3138      	srl	v0,v1,8
0+1a30 <test3\+0x15d4> 3148      	srl	v0,a0,8
0+1a32 <test3\+0x15d6> 3158      	srl	v0,a1,8
0+1a34 <test3\+0x15d8> 3168      	srl	v0,a2,8
0+1a36 <test3\+0x15da> 3178      	srl	v0,a3,8
0+1a38 <test3\+0x15dc> 3108      	srl	v0,s0,8
0+1a3a <test3\+0x15de> 3118      	srl	v0,s1,8
0+1a3c <test3\+0x15e0> 3128      	srl	v0,v0,8
0+1a3e <test3\+0x15e2> 31a8      	srl	v1,v0,8
0+1a40 <test3\+0x15e4> 3228      	srl	a0,v0,8
0+1a42 <test3\+0x15e6> 32a8      	srl	a1,v0,8
0+1a44 <test3\+0x15e8> 3328      	srl	a2,v0,8
0+1a46 <test3\+0x15ea> 33a8      	srl	a3,v0,8
0+1a48 <test3\+0x15ec> 3028      	srl	s0,v0,8
0+1a4a <test3\+0x15ee> 30a8      	srl	s1,v0,8
0+1a4c <test3\+0x15f0> 31b9      	srl	v1,v1,1
0+1a4e <test3\+0x15f2> 31b9      	srl	v1,v1,1
0+1a50 <test3\+0x15f4> 2083 1190 	sub	v0,v1,a0
0+1a54 <test3\+0x15f8> 23fe e990 	sub	sp,s8,ra
0+1a58 <test3\+0x15fc> 2082 1190 	sub	v0,v0,a0
0+1a5c <test3\+0x1600> 2082 1190 	sub	v0,v0,a0
0+1a60 <test3\+0x1604> 0042 0000 	addiu	v0,v0,0
0+1a64 <test3\+0x1608> 0042 9fff 	addiu	v0,v0,-1
0+1a68 <test3\+0x160c> 6020 0000 7fff 	li	at,0x7fff
0+1a6e <test3\+0x1612> 2022 1190 	sub	v0,v0,at
0+1a72 <test3\+0x1616> e03f 8ffd 	lui	at,0xffff8
0+1a76 <test3\+0x161a> 2022 1190 	sub	v0,v0,at
0+1a7a <test3\+0x161e> 6020 0000 ffff 	li	at,0xffff
0+1a80 <test3\+0x1624> 2022 1190 	sub	v0,v0,at
0+1a84 <test3\+0x1628> b135      	subu	v0,v1,v0
0+1a86 <test3\+0x162a> b1b5      	subu	v0,v1,v1
0+1a88 <test3\+0x162c> b235      	subu	v0,v1,a0
0+1a8a <test3\+0x162e> b2b5      	subu	v0,v1,a1
0+1a8c <test3\+0x1630> b335      	subu	v0,v1,a2
0+1a8e <test3\+0x1632> b3b5      	subu	v0,v1,a3
0+1a90 <test3\+0x1634> b035      	subu	v0,v1,s0
0+1a92 <test3\+0x1636> b0b5      	subu	v0,v1,s1
0+1a94 <test3\+0x1638> b0a5      	subu	v0,v0,s1
0+1a96 <test3\+0x163a> b0c5      	subu	v0,a0,s1
0+1a98 <test3\+0x163c> b0d5      	subu	v0,a1,s1
0+1a9a <test3\+0x163e> b0e5      	subu	v0,a2,s1
0+1a9c <test3\+0x1640> b0f5      	subu	v0,a3,s1
0+1a9e <test3\+0x1642> b085      	subu	v0,s0,s1
0+1aa0 <test3\+0x1644> b095      	subu	v0,s1,s1
0+1aa2 <test3\+0x1646> b0a5      	subu	v0,v0,s1
0+1aa4 <test3\+0x1648> b0a7      	subu	v1,v0,s1
0+1aa6 <test3\+0x164a> b0a9      	subu	a0,v0,s1
0+1aa8 <test3\+0x164c> b0ab      	subu	a1,v0,s1
0+1aaa <test3\+0x164e> b0ad      	subu	a2,v0,s1
0+1aac <test3\+0x1650> b0af      	subu	a3,v0,s1
0+1aae <test3\+0x1652> b0a1      	subu	s0,v0,s1
0+1ab0 <test3\+0x1654> b0a3      	subu	s1,v0,s1
0+1ab2 <test3\+0x1656> b17f      	subu	a3,a3,v0
0+1ab4 <test3\+0x1658> b17f      	subu	a3,a3,v0
0+1ab6 <test3\+0x165a> 2083 11d0 	subu	v0,v1,a0
0+1aba <test3\+0x165e> 23fe e9d0 	subu	sp,s8,ra
0+1abe <test3\+0x1662> 2082 11d0 	subu	v0,v0,a0
0+1ac2 <test3\+0x1666> 2082 11d0 	subu	v0,v0,a0
0+1ac6 <test3\+0x166a> 0042 0000 	addiu	v0,v0,0
0+1aca <test3\+0x166e> 0042 9fff 	addiu	v0,v0,-1
0+1ace <test3\+0x1672> 6020 0000 7fff 	li	at,0x7fff
0+1ad4 <test3\+0x1678> 2022 11d0 	subu	v0,v0,at
0+1ad8 <test3\+0x167c> e03f 8ffd 	lui	at,0xffff8
0+1adc <test3\+0x1680> 2022 11d0 	subu	v0,v0,at
0+1ae0 <test3\+0x1684> 6020 0000 ffff 	li	at,0xffff
0+1ae6 <test3\+0x168a> 2022 11d0 	subu	v0,v0,at
0+1aea <test3\+0x168e> f540      	sw	v0,0\(a0\)
0+1aec <test3\+0x1690> f540      	sw	v0,0\(a0\)
0+1aee <test3\+0x1692> f541      	sw	v0,4\(a0\)
0+1af0 <test3\+0x1694> f542      	sw	v0,8\(a0\)
0+1af2 <test3\+0x1696> f543      	sw	v0,12\(a0\)
0+1af4 <test3\+0x1698> f544      	sw	v0,16\(a0\)
0+1af6 <test3\+0x169a> f545      	sw	v0,20\(a0\)
0+1af8 <test3\+0x169c> f546      	sw	v0,24\(a0\)
0+1afa <test3\+0x169e> f547      	sw	v0,28\(a0\)
0+1afc <test3\+0x16a0> f548      	sw	v0,32\(a0\)
0+1afe <test3\+0x16a2> f549      	sw	v0,36\(a0\)
0+1b00 <test3\+0x16a4> f54a      	sw	v0,40\(a0\)
0+1b02 <test3\+0x16a6> f54b      	sw	v0,44\(a0\)
0+1b04 <test3\+0x16a8> f54c      	sw	v0,48\(a0\)
0+1b06 <test3\+0x16aa> f54d      	sw	v0,52\(a0\)
0+1b08 <test3\+0x16ac> f54e      	sw	v0,56\(a0\)
0+1b0a <test3\+0x16ae> f54f      	sw	v0,60\(a0\)
0+1b0c <test3\+0x16b0> f55f      	sw	v0,60\(a1\)
0+1b0e <test3\+0x16b2> f56f      	sw	v0,60\(a2\)
0+1b10 <test3\+0x16b4> f57f      	sw	v0,60\(a3\)
0+1b12 <test3\+0x16b6> f50f      	sw	v0,60\(s0\)
0+1b14 <test3\+0x16b8> f51f      	sw	v0,60\(s1\)
0+1b16 <test3\+0x16ba> f52f      	sw	v0,60\(v0\)
0+1b18 <test3\+0x16bc> f53f      	sw	v0,60\(v1\)
0+1b1a <test3\+0x16be> f5bf      	sw	v1,60\(v1\)
0+1b1c <test3\+0x16c0> f63f      	sw	a0,60\(v1\)
0+1b1e <test3\+0x16c2> f6bf      	sw	a1,60\(v1\)
0+1b20 <test3\+0x16c4> f73f      	sw	a2,60\(v1\)
0+1b22 <test3\+0x16c6> f7bf      	sw	a3,60\(v1\)
0+1b24 <test3\+0x16c8> f4bf      	sw	s1,60\(v1\)
0+1b26 <test3\+0x16ca> f43f      	sw	zero,60\(v1\)
0+1b28 <test3\+0x16cc> d400      	sw	zero,0\(sp\)
0+1b2a <test3\+0x16ce> d400      	sw	zero,0\(sp\)
0+1b2c <test3\+0x16d0> d401      	sw	zero,4\(sp\)
0+1b2e <test3\+0x16d2> d402      	sw	zero,8\(sp\)
0+1b30 <test3\+0x16d4> d403      	sw	zero,12\(sp\)
0+1b32 <test3\+0x16d6> d404      	sw	zero,16\(sp\)
0+1b34 <test3\+0x16d8> d405      	sw	zero,20\(sp\)
0+1b36 <test3\+0x16da> d41e      	sw	zero,120\(sp\)
0+1b38 <test3\+0x16dc> d41f      	sw	zero,124\(sp\)
0+1b3a <test3\+0x16de> d45f      	sw	v0,124\(sp\)
0+1b3c <test3\+0x16e0> d63f      	sw	s1,124\(sp\)
0+1b3e <test3\+0x16e2> d47f      	sw	v1,124\(sp\)
0+1b40 <test3\+0x16e4> d49f      	sw	a0,124\(sp\)
0+1b42 <test3\+0x16e6> d4bf      	sw	a1,124\(sp\)
0+1b44 <test3\+0x16e8> d4df      	sw	a2,124\(sp\)
0+1b46 <test3\+0x16ea> d4ff      	sw	a3,124\(sp\)
0+1b48 <test3\+0x16ec> d7ff      	sw	ra,124\(sp\)
0+1b4a <test3\+0x16ee> 8460 9004 	sw	v1,4\(zero\)
0+1b4e <test3\+0x16f2> 8460 9004 	sw	v1,4\(zero\)
0+1b52 <test3\+0x16f6> 8460 9fff 	sw	v1,4095\(zero\)
0+1b56 <test3\+0x16fa> e020 f000 	lui	at,0xf
0+1b5a <test3\+0x16fe> 8461 9fff 	sw	v1,4095\(at\)
0+1b5e <test3\+0x1702> e03f 0ffd 	lui	at,0xffff0
0+1b62 <test3\+0x1706> 8461 9000 	sw	v1,0\(at\)
0+1b66 <test3\+0x170a> e03f 8ffd 	lui	at,0xffff8
0+1b6a <test3\+0x170e> 8461 9000 	sw	v1,0\(at\)
0+1b6e <test3\+0x1712> e03f 0ffd 	lui	at,0xffff0
0+1b72 <test3\+0x1716> 8461 9001 	sw	v1,1\(at\)
0+1b76 <test3\+0x171a> e03f 8ffd 	lui	at,0xffff8
0+1b7a <test3\+0x171e> 8461 9001 	sw	v1,1\(at\)
0+1b7e <test3\+0x1722> e020 0e01 	lui	at,0xf0000
0+1b82 <test3\+0x1726> 8461 9000 	sw	v1,0\(at\)
0+1b86 <test3\+0x172a> 0020 9fff 	li	at,-1
0+1b8a <test3\+0x172e> 8461 9000 	sw	v1,0\(at\)
0+1b8e <test3\+0x1732> e034 5244 	lui	at,0x12345
0+1b92 <test3\+0x1736> 8461 9678 	sw	v1,1656\(at\)
0+1b96 <test3\+0x173a> 8464 9000 	sw	v1,0\(a0\)
0+1b9a <test3\+0x173e> 8464 9000 	sw	v1,0\(a0\)
0+1b9e <test3\+0x1742> 8464 9fff 	sw	v1,4095\(a0\)
0+1ba2 <test3\+0x1746> e020 f000 	lui	at,0xf
0+1ba6 <test3\+0x174a> 2081 0950 	addu	at,at,a0
0+1baa <test3\+0x174e> 8461 9fff 	sw	v1,4095\(at\)
0+1bae <test3\+0x1752> e03f 0ffd 	lui	at,0xffff0
0+1bb2 <test3\+0x1756> 2081 0950 	addu	at,at,a0
0+1bb6 <test3\+0x175a> 8461 9000 	sw	v1,0\(at\)
0+1bba <test3\+0x175e> e03f 8ffd 	lui	at,0xffff8
0+1bbe <test3\+0x1762> 2081 0950 	addu	at,at,a0
0+1bc2 <test3\+0x1766> 8461 9000 	sw	v1,0\(at\)
0+1bc6 <test3\+0x176a> e03f 0ffd 	lui	at,0xffff0
0+1bca <test3\+0x176e> 2081 0950 	addu	at,at,a0
0+1bce <test3\+0x1772> 8461 9001 	sw	v1,1\(at\)
0+1bd2 <test3\+0x1776> e03f 8ffd 	lui	at,0xffff8
0+1bd6 <test3\+0x177a> 2081 0950 	addu	at,at,a0
0+1bda <test3\+0x177e> 8461 9001 	sw	v1,1\(at\)
0+1bde <test3\+0x1782> e020 0e01 	lui	at,0xf0000
0+1be2 <test3\+0x1786> 2081 0950 	addu	at,at,a0
0+1be6 <test3\+0x178a> 8461 9000 	sw	v1,0\(at\)
0+1bea <test3\+0x178e> 0024 9fff 	addiu	at,a0,-1
0+1bee <test3\+0x1792> 8461 9000 	sw	v1,0\(at\)
0+1bf2 <test3\+0x1796> e034 5244 	lui	at,0x12345
0+1bf6 <test3\+0x179a> 2081 0950 	addu	at,at,a0
0+1bfa <test3\+0x179e> 8461 9678 	sw	v1,1656\(at\)
0+1bfe <test3\+0x17a2> 8000 c006 	sync
0+1c02 <test3\+0x17a6> 8000 c006 	sync
0+1c06 <test3\+0x17aa> 8001 c006 	sync	0x1
0+1c0a <test3\+0x17ae> 8002 c006 	sync	0x2
0+1c0e <test3\+0x17b2> 8003 c006 	sync	0x3
0+1c12 <test3\+0x17b6> 8004 c006 	sync	0x4
0+1c16 <test3\+0x17ba> 801e c006 	sync	0x1e
0+1c1a <test3\+0x17be> 801f c006 	sync	0x1f
0+1c1e <test3\+0x17c2> a7e0 1800 	synci	0\(zero\)
0+1c22 <test3\+0x17c6> a7e0 1800 	synci	0\(zero\)
0+1c26 <test3\+0x17ca> a7e0 1800 	synci	0\(zero\)
0+1c2a <test3\+0x17ce> a7e2 1800 	synci	0\(v0\)
0+1c2e <test3\+0x17d2> a7e3 1800 	synci	0\(v1\)
0+1c32 <test3\+0x17d6> a7e3 18ff 	synci	255\(v1\)
0+1c36 <test3\+0x17da> a7e3 9800 	synci	-256\(v1\)
0+1c3a <test3\+0x17de> 1008      	move	zero,t0
0+1c3c <test3\+0x17e0> 1008      	move	zero,t0
0+1c3e <test3\+0x17e2> 1009      	move	zero,t1
0+1c40 <test3\+0x17e4> 100a      	move	zero,t2
0+1c42 <test3\+0x17e6> 0008 00ff 	syscall	0xff
0+1c46 <test3\+0x17ea> 8460 4004 	lh	v1,4\(zero\)
0+1c4a <test3\+0x17ee> 8460 4004 	lh	v1,4\(zero\)
0+1c4e <test3\+0x17f2> 8464 4000 	lh	v1,0\(a0\)
0+1c52 <test3\+0x17f6> 8464 4000 	lh	v1,0\(a0\)
0+1c56 <test3\+0x17fa> e020 7000 	lui	at,0x7
0+1c5a <test3\+0x17fe> 2081 0950 	addu	at,at,a0
0+1c5e <test3\+0x1802> 8461 4ffb 	lh	v1,4091\(at\)
0+1c62 <test3\+0x1806> e03f 8ffd 	lui	at,0xffff8
0+1c66 <test3\+0x180a> 2081 0950 	addu	at,at,a0
0+1c6a <test3\+0x180e> 8461 4000 	lh	v1,0\(at\)
0+1c6e <test3\+0x1812> e020 f000 	lui	at,0xf
0+1c72 <test3\+0x1816> 2081 0950 	addu	at,at,a0
0+1c76 <test3\+0x181a> 8461 4fff 	lh	v1,4095\(at\)
0+1c7a <test3\+0x181e> e03f 0ffd 	lui	at,0xffff0
0+1c7e <test3\+0x1822> 2081 0950 	addu	at,at,a0
0+1c82 <test3\+0x1826> 8461 4000 	lh	v1,0\(at\)
0+1c86 <test3\+0x182a> e03f 8ffd 	lui	at,0xffff8
0+1c8a <test3\+0x182e> 2081 0950 	addu	at,at,a0
0+1c8e <test3\+0x1832> 8461 4000 	lh	v1,0\(at\)
0+1c92 <test3\+0x1836> e03f 0ffd 	lui	at,0xffff0
0+1c96 <test3\+0x183a> 2081 0950 	addu	at,at,a0
0+1c9a <test3\+0x183e> 8461 4001 	lh	v1,1\(at\)
0+1c9e <test3\+0x1842> e03f 8ffd 	lui	at,0xffff8
0+1ca2 <test3\+0x1846> 2081 0950 	addu	at,at,a0
0+1ca6 <test3\+0x184a> 8461 4001 	lh	v1,1\(at\)
0+1caa <test3\+0x184e> e020 0e01 	lui	at,0xf0000
0+1cae <test3\+0x1852> 2081 0950 	addu	at,at,a0
0+1cb2 <test3\+0x1856> 8461 4000 	lh	v1,0\(at\)
0+1cb6 <test3\+0x185a> 0024 9fff 	addiu	at,a0,-1
0+1cba <test3\+0x185e> 8461 4000 	lh	v1,0\(at\)
0+1cbe <test3\+0x1862> 8460 4004 	lh	v1,4\(zero\)
0+1cc2 <test3\+0x1866> 8460 4004 	lh	v1,4\(zero\)
0+1cc6 <test3\+0x186a> 8464 4000 	lh	v1,0\(a0\)
0+1cca <test3\+0x186e> 8464 4000 	lh	v1,0\(a0\)
0+1cce <test3\+0x1872> e020 7000 	lui	at,0x7
0+1cd2 <test3\+0x1876> 2081 0950 	addu	at,at,a0
0+1cd6 <test3\+0x187a> 8461 4ffb 	lh	v1,4091\(at\)
0+1cda <test3\+0x187e> e03f 8ffd 	lui	at,0xffff8
0+1cde <test3\+0x1882> 2081 0950 	addu	at,at,a0
0+1ce2 <test3\+0x1886> 8461 4000 	lh	v1,0\(at\)
0+1ce6 <test3\+0x188a> e020 f000 	lui	at,0xf
0+1cea <test3\+0x188e> 2081 0950 	addu	at,at,a0
0+1cee <test3\+0x1892> 8461 4fff 	lh	v1,4095\(at\)
0+1cf2 <test3\+0x1896> e03f 0ffd 	lui	at,0xffff0
0+1cf6 <test3\+0x189a> 2081 0950 	addu	at,at,a0
0+1cfa <test3\+0x189e> 8461 4000 	lh	v1,0\(at\)
0+1cfe <test3\+0x18a2> e03f 8ffd 	lui	at,0xffff8
0+1d02 <test3\+0x18a6> 2081 0950 	addu	at,at,a0
0+1d06 <test3\+0x18aa> 8461 4000 	lh	v1,0\(at\)
0+1d0a <test3\+0x18ae> e03f 0ffd 	lui	at,0xffff0
0+1d0e <test3\+0x18b2> 2081 0950 	addu	at,at,a0
0+1d12 <test3\+0x18b6> 8461 4001 	lh	v1,1\(at\)
0+1d16 <test3\+0x18ba> e03f 8ffd 	lui	at,0xffff8
0+1d1a <test3\+0x18be> 2081 0950 	addu	at,at,a0
0+1d1e <test3\+0x18c2> 8461 4001 	lh	v1,1\(at\)
0+1d22 <test3\+0x18c6> e020 0e01 	lui	at,0xf0000
0+1d26 <test3\+0x18ca> 2081 0950 	addu	at,at,a0
0+1d2a <test3\+0x18ce> 8461 4000 	lh	v1,0\(at\)
0+1d2e <test3\+0x18d2> 0024 9fff 	addiu	at,a0,-1
0+1d32 <test3\+0x18d6> 8461 4000 	lh	v1,0\(at\)
0+1d36 <test3\+0x18da> 8460 8000 	lw	v1,0\(zero\)
0+1d3a <test3\+0x18de> 8460 8000 	lw	v1,0\(zero\)
0+1d3e <test3\+0x18e2> 8460 8004 	lw	v1,4\(zero\)
0+1d42 <test3\+0x18e6> 8460 8004 	lw	v1,4\(zero\)
0+1d46 <test3\+0x18ea> 8460 87ff 	lw	v1,2047\(zero\)
0+1d4a <test3\+0x18ee> 0020 9800 	li	at,-2048
0+1d4e <test3\+0x18f2> 8461 8000 	lw	v1,0\(at\)
0+1d52 <test3\+0x18f6> 8460 8800 	lw	v1,2048\(zero\)
0+1d56 <test3\+0x18fa> 0020 97ff 	li	at,-2049
0+1d5a <test3\+0x18fe> 8461 8000 	lw	v1,0\(at\)
0+1d5e <test3\+0x1902> e020 7000 	lui	at,0x7
0+1d62 <test3\+0x1906> 8461 8ffb 	lw	v1,4091\(at\)
0+1d66 <test3\+0x190a> e03f 8ffd 	lui	at,0xffff8
0+1d6a <test3\+0x190e> 8461 8000 	lw	v1,0\(at\)
0+1d6e <test3\+0x1912> e020 f000 	lui	at,0xf
0+1d72 <test3\+0x1916> 8461 8fff 	lw	v1,4095\(at\)
0+1d76 <test3\+0x191a> e03f 0ffd 	lui	at,0xffff0
0+1d7a <test3\+0x191e> 8461 8000 	lw	v1,0\(at\)
0+1d7e <test3\+0x1922> e03f 8ffd 	lui	at,0xffff8
0+1d82 <test3\+0x1926> 8461 8000 	lw	v1,0\(at\)
0+1d86 <test3\+0x192a> e03f 0ffd 	lui	at,0xffff0
0+1d8a <test3\+0x192e> 8461 8001 	lw	v1,1\(at\)
0+1d8e <test3\+0x1932> e03f 8ffd 	lui	at,0xffff8
0+1d92 <test3\+0x1936> 8461 8001 	lw	v1,1\(at\)
0+1d96 <test3\+0x193a> e020 0e01 	lui	at,0xf0000
0+1d9a <test3\+0x193e> 8461 8000 	lw	v1,0\(at\)
0+1d9e <test3\+0x1942> 0020 9fff 	li	at,-1
0+1da2 <test3\+0x1946> 8461 8000 	lw	v1,0\(at\)
0+1da6 <test3\+0x194a> e034 5244 	lui	at,0x12345
0+1daa <test3\+0x194e> 8461 8678 	lw	v1,1656\(at\)
0+1dae <test3\+0x1952> 8464 8000 	lw	v1,0\(a0\)
0+1db2 <test3\+0x1956> 8464 8004 	lw	v1,4\(a0\)
0+1db6 <test3\+0x195a> 8464 87ff 	lw	v1,2047\(a0\)
0+1dba <test3\+0x195e> 0024 9800 	addiu	at,a0,-2048
0+1dbe <test3\+0x1962> 8461 8000 	lw	v1,0\(at\)
0+1dc2 <test3\+0x1966> 8464 8800 	lw	v1,2048\(a0\)
0+1dc6 <test3\+0x196a> 0024 97ff 	addiu	at,a0,-2049
0+1dca <test3\+0x196e> 8461 8000 	lw	v1,0\(at\)
0+1dce <test3\+0x1972> e020 7000 	lui	at,0x7
0+1dd2 <test3\+0x1976> 2081 0950 	addu	at,at,a0
0+1dd6 <test3\+0x197a> 8461 8ffb 	lw	v1,4091\(at\)
0+1dda <test3\+0x197e> e03f 8ffd 	lui	at,0xffff8
0+1dde <test3\+0x1982> 2081 0950 	addu	at,at,a0
0+1de2 <test3\+0x1986> 8461 8000 	lw	v1,0\(at\)
0+1de6 <test3\+0x198a> e020 f000 	lui	at,0xf
0+1dea <test3\+0x198e> 2081 0950 	addu	at,at,a0
0+1dee <test3\+0x1992> 8461 8fff 	lw	v1,4095\(at\)
0+1df2 <test3\+0x1996> e03f 0ffd 	lui	at,0xffff0
0+1df6 <test3\+0x199a> 2081 0950 	addu	at,at,a0
0+1dfa <test3\+0x199e> 8461 8000 	lw	v1,0\(at\)
0+1dfe <test3\+0x19a2> e03f 8ffd 	lui	at,0xffff8
0+1e02 <test3\+0x19a6> 2081 0950 	addu	at,at,a0
0+1e06 <test3\+0x19aa> 8461 8000 	lw	v1,0\(at\)
0+1e0a <test3\+0x19ae> e03f 0ffd 	lui	at,0xffff0
0+1e0e <test3\+0x19b2> 2081 0950 	addu	at,at,a0
0+1e12 <test3\+0x19b6> 8461 8001 	lw	v1,1\(at\)
0+1e16 <test3\+0x19ba> e03f 8ffd 	lui	at,0xffff8
0+1e1a <test3\+0x19be> 2081 0950 	addu	at,at,a0
0+1e1e <test3\+0x19c2> 8461 8001 	lw	v1,1\(at\)
0+1e22 <test3\+0x19c6> e020 0e01 	lui	at,0xf0000
0+1e26 <test3\+0x19ca> 2081 0950 	addu	at,at,a0
0+1e2a <test3\+0x19ce> 8461 8000 	lw	v1,0\(at\)
0+1e2e <test3\+0x19d2> 0024 9fff 	addiu	at,a0,-1
0+1e32 <test3\+0x19d6> 8461 8000 	lw	v1,0\(at\)
0+1e36 <test3\+0x19da> e034 5244 	lui	at,0x12345
0+1e3a <test3\+0x19de> 2081 0950 	addu	at,at,a0
0+1e3e <test3\+0x19e2> 8461 8678 	lw	v1,1656\(at\)
0+1e42 <test3\+0x19e6> 8460 5004 	sh	v1,4\(zero\)
0+1e46 <test3\+0x19ea> 8460 5004 	sh	v1,4\(zero\)
0+1e4a <test3\+0x19ee> 8464 5000 	sh	v1,0\(a0\)
0+1e4e <test3\+0x19f2> 8464 5000 	sh	v1,0\(a0\)
0+1e52 <test3\+0x19f6> e020 7000 	lui	at,0x7
0+1e56 <test3\+0x19fa> 2081 0950 	addu	at,at,a0
0+1e5a <test3\+0x19fe> 8461 5ffb 	sh	v1,4091\(at\)
0+1e5e <test3\+0x1a02> e03f 8ffd 	lui	at,0xffff8
0+1e62 <test3\+0x1a06> 2081 0950 	addu	at,at,a0
0+1e66 <test3\+0x1a0a> 8461 5000 	sh	v1,0\(at\)
0+1e6a <test3\+0x1a0e> e020 f000 	lui	at,0xf
0+1e6e <test3\+0x1a12> 2081 0950 	addu	at,at,a0
0+1e72 <test3\+0x1a16> 8461 5fff 	sh	v1,4095\(at\)
0+1e76 <test3\+0x1a1a> e03f 0ffd 	lui	at,0xffff0
0+1e7a <test3\+0x1a1e> 2081 0950 	addu	at,at,a0
0+1e7e <test3\+0x1a22> 8461 5000 	sh	v1,0\(at\)
0+1e82 <test3\+0x1a26> e03f 8ffd 	lui	at,0xffff8
0+1e86 <test3\+0x1a2a> 2081 0950 	addu	at,at,a0
0+1e8a <test3\+0x1a2e> 8461 5000 	sh	v1,0\(at\)
0+1e8e <test3\+0x1a32> e03f 0ffd 	lui	at,0xffff0
0+1e92 <test3\+0x1a36> 2081 0950 	addu	at,at,a0
0+1e96 <test3\+0x1a3a> 8461 5001 	sh	v1,1\(at\)
0+1e9a <test3\+0x1a3e> e03f 8ffd 	lui	at,0xffff8
0+1e9e <test3\+0x1a42> 2081 0950 	addu	at,at,a0
0+1ea2 <test3\+0x1a46> 8461 5001 	sh	v1,1\(at\)
0+1ea6 <test3\+0x1a4a> e020 0e01 	lui	at,0xf0000
0+1eaa <test3\+0x1a4e> 2081 0950 	addu	at,at,a0
0+1eae <test3\+0x1a52> 8461 5000 	sh	v1,0\(at\)
0+1eb2 <test3\+0x1a56> 0024 9fff 	addiu	at,a0,-1
0+1eb6 <test3\+0x1a5a> 8461 5000 	sh	v1,0\(at\)
0+1eba <test3\+0x1a5e> 8460 9000 	sw	v1,0\(zero\)
0+1ebe <test3\+0x1a62> 8460 9000 	sw	v1,0\(zero\)
0+1ec2 <test3\+0x1a66> 8460 9004 	sw	v1,4\(zero\)
0+1ec6 <test3\+0x1a6a> 8460 9004 	sw	v1,4\(zero\)
0+1eca <test3\+0x1a6e> 8460 97ff 	sw	v1,2047\(zero\)
0+1ece <test3\+0x1a72> 0020 9800 	li	at,-2048
0+1ed2 <test3\+0x1a76> 8461 9000 	sw	v1,0\(at\)
0+1ed6 <test3\+0x1a7a> 8460 9800 	sw	v1,2048\(zero\)
0+1eda <test3\+0x1a7e> 0020 97ff 	li	at,-2049
0+1ede <test3\+0x1a82> 8461 9000 	sw	v1,0\(at\)
0+1ee2 <test3\+0x1a86> e020 7000 	lui	at,0x7
0+1ee6 <test3\+0x1a8a> 8461 9ffb 	sw	v1,4091\(at\)
0+1eea <test3\+0x1a8e> e03f 8ffd 	lui	at,0xffff8
0+1eee <test3\+0x1a92> 8461 9000 	sw	v1,0\(at\)
0+1ef2 <test3\+0x1a96> e020 f000 	lui	at,0xf
0+1ef6 <test3\+0x1a9a> 8461 9fff 	sw	v1,4095\(at\)
0+1efa <test3\+0x1a9e> e03f 0ffd 	lui	at,0xffff0
0+1efe <test3\+0x1aa2> 8461 9000 	sw	v1,0\(at\)
0+1f02 <test3\+0x1aa6> e03f 8ffd 	lui	at,0xffff8
0+1f06 <test3\+0x1aaa> 8461 9000 	sw	v1,0\(at\)
0+1f0a <test3\+0x1aae> e03f 0ffd 	lui	at,0xffff0
0+1f0e <test3\+0x1ab2> 8461 9001 	sw	v1,1\(at\)
0+1f12 <test3\+0x1ab6> e03f 8ffd 	lui	at,0xffff8
0+1f16 <test3\+0x1aba> 8461 9001 	sw	v1,1\(at\)
0+1f1a <test3\+0x1abe> e020 0e01 	lui	at,0xf0000
0+1f1e <test3\+0x1ac2> 8461 9000 	sw	v1,0\(at\)
0+1f22 <test3\+0x1ac6> 0020 9fff 	li	at,-1
0+1f26 <test3\+0x1aca> 8461 9000 	sw	v1,0\(at\)
0+1f2a <test3\+0x1ace> e034 5244 	lui	at,0x12345
0+1f2e <test3\+0x1ad2> 8461 9678 	sw	v1,1656\(at\)
0+1f32 <test3\+0x1ad6> 8464 9000 	sw	v1,0\(a0\)
0+1f36 <test3\+0x1ada> 8464 9004 	sw	v1,4\(a0\)
0+1f3a <test3\+0x1ade> 8464 97ff 	sw	v1,2047\(a0\)
0+1f3e <test3\+0x1ae2> 0024 9800 	addiu	at,a0,-2048
0+1f42 <test3\+0x1ae6> 8461 9000 	sw	v1,0\(at\)
0+1f46 <test3\+0x1aea> 8464 9800 	sw	v1,2048\(a0\)
0+1f4a <test3\+0x1aee> 0024 97ff 	addiu	at,a0,-2049
0+1f4e <test3\+0x1af2> 8461 9000 	sw	v1,0\(at\)
0+1f52 <test3\+0x1af6> e020 7000 	lui	at,0x7
0+1f56 <test3\+0x1afa> 2081 0950 	addu	at,at,a0
0+1f5a <test3\+0x1afe> 8461 9ffb 	sw	v1,4091\(at\)
0+1f5e <test3\+0x1b02> e03f 8ffd 	lui	at,0xffff8
0+1f62 <test3\+0x1b06> 2081 0950 	addu	at,at,a0
0+1f66 <test3\+0x1b0a> 8461 9000 	sw	v1,0\(at\)
0+1f6a <test3\+0x1b0e> e020 f000 	lui	at,0xf
0+1f6e <test3\+0x1b12> 2081 0950 	addu	at,at,a0
0+1f72 <test3\+0x1b16> 8461 9fff 	sw	v1,4095\(at\)
0+1f76 <test3\+0x1b1a> e03f 0ffd 	lui	at,0xffff0
0+1f7a <test3\+0x1b1e> 2081 0950 	addu	at,at,a0
0+1f7e <test3\+0x1b22> 8461 9000 	sw	v1,0\(at\)
0+1f82 <test3\+0x1b26> e03f 8ffd 	lui	at,0xffff8
0+1f86 <test3\+0x1b2a> 2081 0950 	addu	at,at,a0
0+1f8a <test3\+0x1b2e> 8461 9000 	sw	v1,0\(at\)
0+1f8e <test3\+0x1b32> e03f 0ffd 	lui	at,0xffff0
0+1f92 <test3\+0x1b36> 2081 0950 	addu	at,at,a0
0+1f96 <test3\+0x1b3a> 8461 9001 	sw	v1,1\(at\)
0+1f9a <test3\+0x1b3e> e03f 8ffd 	lui	at,0xffff8
0+1f9e <test3\+0x1b42> 2081 0950 	addu	at,at,a0
0+1fa2 <test3\+0x1b46> 8461 9001 	sw	v1,1\(at\)
0+1fa6 <test3\+0x1b4a> e020 0e01 	lui	at,0xf0000
0+1faa <test3\+0x1b4e> 2081 0950 	addu	at,at,a0
0+1fae <test3\+0x1b52> 8461 9000 	sw	v1,0\(at\)
0+1fb2 <test3\+0x1b56> 0024 9fff 	addiu	at,a0,-1
0+1fb6 <test3\+0x1b5a> 8461 9000 	sw	v1,0\(at\)
0+1fba <test3\+0x1b5e> e034 5244 	lui	at,0x12345
0+1fbe <test3\+0x1b62> 2081 0950 	addu	at,at,a0
0+1fc2 <test3\+0x1b66> 8461 9678 	sw	v1,1656\(at\)
0+1fc6 <test3\+0x1b6a> 2000 c37f 	wait
0+1fca <test3\+0x1b6e> 2000 c37f 	wait
0+1fce <test3\+0x1b72> 2001 c37f 	wait	0x1
0+1fd2 <test3\+0x1b76> 20ff c37f 	wait	0xff
0+1fd6 <test3\+0x1b7a> 2043 f17f 	wrpgpr	v0,v1
0+1fda <test3\+0x1b7e> 2044 f17f 	wrpgpr	v0,a0
0+1fde <test3\+0x1b82> 2042 f17f 	wrpgpr	v0,v0
0+1fe2 <test3\+0x1b86> 2042 f17f 	wrpgpr	v0,v0
0+1fe6 <test3\+0x1b8a> 2043 7b3f 	wsbh	v0,v1
0+1fea <test3\+0x1b8e> 2044 7b3f 	wsbh	v0,a0
0+1fee <test3\+0x1b92> 2042 7b3f 	wsbh	v0,v0
0+1ff2 <test3\+0x1b96> 2042 7b3f 	wsbh	v0,v0
0+1ff6 <test3\+0x1b9a> 5124      	xor	v0,v0,v0
0+1ff8 <test3\+0x1b9c> 5134      	xor	v0,v0,v1
0+1ffa <test3\+0x1b9e> 5144      	xor	v0,v0,a0
0+1ffc <test3\+0x1ba0> 5154      	xor	v0,v0,a1
0+1ffe <test3\+0x1ba2> 5164      	xor	v0,v0,a2
0+2000 <test3\+0x1ba4> 5174      	xor	v0,v0,a3
0+2002 <test3\+0x1ba6> 5104      	xor	v0,v0,s0
0+2004 <test3\+0x1ba8> 5114      	xor	v0,v0,s1
0+2006 <test3\+0x1baa> 5194      	xor	v1,v1,s1
0+2008 <test3\+0x1bac> 5214      	xor	a0,a0,s1
0+200a <test3\+0x1bae> 5294      	xor	a1,a1,s1
0+200c <test3\+0x1bb0> 5314      	xor	a2,a2,s1
0+200e <test3\+0x1bb2> 5394      	xor	a3,a3,s1
0+2010 <test3\+0x1bb4> 5014      	xor	s0,s0,s1
0+2012 <test3\+0x1bb6> 5094      	xor	s1,s1,s1
0+2014 <test3\+0x1bb8> 5134      	xor	v0,v0,v1
0+2016 <test3\+0x1bba> 5134      	xor	v0,v0,v1
0+2018 <test3\+0x1bbc> 5134      	xor	v0,v0,v1
0+201a <test3\+0x1bbe> 2083 1310 	xor	v0,v1,a0
0+201e <test3\+0x1bc2> 23fe eb10 	xor	sp,s8,ra
0+2022 <test3\+0x1bc6> 2082 1310 	xor	v0,v0,a0
0+2026 <test3\+0x1bca> 2082 1310 	xor	v0,v0,a0
0+202a <test3\+0x1bce> e020 8000 	lui	at,0x8
0+202e <test3\+0x1bd2> 2023 1310 	xor	v0,v1,at
0+2032 <test3\+0x1bd6> 6020 0000 ffff 	li	at,0xffff
0+2038 <test3\+0x1bdc> 2023 1310 	xor	v0,v1,at
0+203c <test3\+0x1be0> e021 0000 	lui	at,0x10
0+2040 <test3\+0x1be4> 2023 1310 	xor	v0,v1,at
0+2044 <test3\+0x1be8> e03f 8ffd 	lui	at,0xffff8
0+2048 <test3\+0x1bec> 2023 1310 	xor	v0,v1,at
0+204c <test3\+0x1bf0> 6020 ffff 7fff 	li	at,0xffff7fff
0+2052 <test3\+0x1bf6> 2023 1310 	xor	v0,v1,at
0+2056 <test3\+0x1bfa> 8064 1000 	xori	v1,a0,0
0+205a <test3\+0x1bfe> 8063 1fff 	xori	v1,v1,4095
0+205e <test3\+0x1c02> e920 0000 	beqzc	t1,00002062 <test3\+0x1c06>
			205e: R_MICROMIPS_PC20_S1	test-0x4
0+2062 <test3\+0x1c06> b2c6      	addu	v1,a0,a1
0+2064 <test3\+0x1c08> 8949 0000 	beqc	t1,t2,00002068 <test3\+0x1c0c>
			2064: R_MICROMIPS_PC14_S1	test-0x4
0+2068 <test3\+0x1c0c> b2c6      	addu	v1,a0,a1
0+206a <test3\+0x1c0e> e920 0000 	beqzc	t1,0000206e <test3\+0x1c12>
			206a: R_MICROMIPS_PC20_S1	test-0x4
0+206e <test3\+0x1c12> b2c6      	addu	v1,a0,a1
0+2070 <test3\+0x1c14> c920 0800 	beqic	t1,1,00002074 <test3\+0x1c18>
			2070: R_MICROMIPS_PC11_S1	test-0x4
0+2074 <test3\+0x1c18> b2c6      	addu	v1,a0,a1
0+2076 <test3\+0x1c1a> 880a 8000 	bgezc	t2,0000207a <test3\+0x1c1e>
			2076: R_MICROMIPS_PC14_S1	test-0x4
0+207a <test3\+0x1c1e> b2c6      	addu	v1,a0,a1
0+207c <test3\+0x1c20> 880a 8000 	bgezc	t2,00002080 <test3\+0x1c24>
			207c: R_MICROMIPS_PC14_S1	test-0x4
0+2080 <test3\+0x1c24> b2c6      	addu	v1,a0,a1
0+2082 <test3\+0x1c26> 8940 8000 	blezc	t2,00002086 <test3\+0x1c2a>
			2082: R_MICROMIPS_PC14_S1	test-0x4
0+2086 <test3\+0x1c2a> b2c6      	addu	v1,a0,a1
0+2088 <test3\+0x1c2c> 896a 8000 	bgec	t2,t3,0000208c <test3\+0x1c30>
			2088: R_MICROMIPS_PC14_S1	test-0x4
0+208c <test3\+0x1c30> b2c6      	addu	v1,a0,a1
0+208e <test3\+0x1c32> 880a 8000 	bgezc	t2,00002092 <test3\+0x1c36>
			208e: R_MICROMIPS_PC14_S1	test-0x4
0+2092 <test3\+0x1c36> b2c6      	addu	v1,a0,a1
0+2094 <test3\+0x1c38> a940 8000 	bgtzc	t2,00002098 <test3\+0x1c3c>
			2094: R_MICROMIPS_PC14_S1	test-0x4
0+2098 <test3\+0x1c3c> b2c6      	addu	v1,a0,a1
0+209a <test3\+0x1c3e> c948 1000 	bgeic	t2,2,0000209e <test3\+0x1c42>
			209a: R_MICROMIPS_PC11_S1	test-0x4
0+209e <test3\+0x1c42> b2c6      	addu	v1,a0,a1
0+20a0 <test3\+0x1c44> 2800 0000 	bc	000020a4 <test3\+0x1c48>
			20a0: R_MICROMIPS_PC25_S1	test-0x4
0+20a4 <test3\+0x1c48> b2c6      	addu	v1,a0,a1
0+20a6 <test3\+0x1c4a> 8802 c000 	bgeuc	v0,zero,000020aa <test3\+0x1c4e>
			20a6: R_MICROMIPS_PC14_S1	test-0x4
0+20aa <test3\+0x1c4e> b2c6      	addu	v1,a0,a1
0+20ac <test3\+0x1c50> 8840 c000 	bgeuc	zero,v0,000020b0 <test3\+0x1c54>
			20ac: R_MICROMIPS_PC14_S1	test-0x4
0+20b0 <test3\+0x1c54> b2c6      	addu	v1,a0,a1
0+20b2 <test3\+0x1c56> 8862 c000 	bgeuc	v0,v1,000020b6 <test3\+0x1c5a>
			20b2: R_MICROMIPS_PC14_S1	test-0x4
0+20b6 <test3\+0x1c5a> b2c6      	addu	v1,a0,a1
0+20b8 <test3\+0x1c5c> 2800 0000 	bc	000020bc <test3\+0x1c60>
			20b8: R_MICROMIPS_PC25_S1	test-0x4
0+20bc <test3\+0x1c60> b2c6      	addu	v1,a0,a1
0+20be <test3\+0x1c62> e850 0000 	bnezc	v0,000020c2 <test3\+0x1c66>
			20be: R_MICROMIPS_PC20_S1	test-0x4
0+20c2 <test3\+0x1c66> b2c6      	addu	v1,a0,a1
0+20c4 <test3\+0x1c68> c84c 1000 	bgeuic	v0,2,000020c8 <test3\+0x1c6c>
			20c4: R_MICROMIPS_PC11_S1	test-0x4
0+20c8 <test3\+0x1c6c> b2c6      	addu	v1,a0,a1
0+20ca <test3\+0x1c6e> 8802 8000 	bgezc	v0,000020ce <test3\+0x1c72>
			20ca: R_MICROMIPS_PC14_S1	test-0x4
0+20ce <test3\+0x1c72> b2c6      	addu	v1,a0,a1
0+20d0 <test3\+0x1c74> a840 8000 	bgtzc	v0,000020d4 <test3\+0x1c78>
			20d0: R_MICROMIPS_PC14_S1	test-0x4
0+20d4 <test3\+0x1c78> b2c6      	addu	v1,a0,a1
0+20d6 <test3\+0x1c7a> a802 8000 	bltzc	v0,000020da <test3\+0x1c7e>
			20d6: R_MICROMIPS_PC14_S1	test-0x4
0+20da <test3\+0x1c7e> b2c6      	addu	v1,a0,a1
0+20dc <test3\+0x1c80> 212a 0b50 	slt	at,t2,t1
0+20e0 <test3\+0x1c84> e830 0000 	bnezc	at,000020e4 <test3\+0x1c88>
			20e0: R_MICROMIPS_PC20_S1	test-0x4
0+20e4 <test3\+0x1c88> b2c6      	addu	v1,a0,a1
0+20e6 <test3\+0x1c8a> 9008      	nop
0+20e8 <test3\+0x1c8c> b2c6      	addu	v1,a0,a1
0+20ea <test3\+0x1c8e> 8809 8000 	bgezc	t1,000020ee <test3\+0x1c92>
			20ea: R_MICROMIPS_PC14_S1	test-0x4
0+20ee <test3\+0x1c92> b2c6      	addu	v1,a0,a1
0+20f0 <test3\+0x1c94> a920 8000 	bgtzc	t1,000020f4 <test3\+0x1c98>
			20f0: R_MICROMIPS_PC14_S1	test-0x4
0+20f4 <test3\+0x1c98> b2c6      	addu	v1,a0,a1
0+20f6 <test3\+0x1c9a> c928 1000 	bgeic	t1,2,000020fa <test3\+0x1c9e>
			20f6: R_MICROMIPS_PC11_S1	test-0x4
0+20fa <test3\+0x1c9e> b2c6      	addu	v1,a0,a1
0+20fc <test3\+0x1ca0> 6020 8000 0001 	li	at,0x80000001
0+2102 <test3\+0x1ca6> 2029 0b50 	slt	at,t1,at
0+2106 <test3\+0x1caa> e820 0000 	beqzc	at,0000210a <test3\+0x1cae>
			2106: R_MICROMIPS_PC20_S1	test-0x4
0+210a <test3\+0x1cae> b2c6      	addu	v1,a0,a1
0+210c <test3\+0x1cb0> e930 0000 	bnezc	t1,00002110 <test3\+0x1cb4>
			210c: R_MICROMIPS_PC20_S1	test-0x4
0+2110 <test3\+0x1cb4> b2c6      	addu	v1,a0,a1
0+2112 <test3\+0x1cb6> 9008      	nop
0+2114 <test3\+0x1cb8> b2c6      	addu	v1,a0,a1
0+2116 <test3\+0x1cba> 212a 0b90 	sltu	at,t2,t1
0+211a <test3\+0x1cbe> e830 0000 	bnezc	at,0000211e <test3\+0x1cc2>
			211a: R_MICROMIPS_PC20_S1	test-0x4
0+211e <test3\+0x1cc2> b2c6      	addu	v1,a0,a1
0+2120 <test3\+0x1cc4> 9008      	nop
0+2122 <test3\+0x1cc6> b2c6      	addu	v1,a0,a1
0+2124 <test3\+0x1cc8> 9008      	nop
0+2126 <test3\+0x1cca> b2c6      	addu	v1,a0,a1
0+2128 <test3\+0x1ccc> 9008      	nop
0+212a <test3\+0x1cce> b2c6      	addu	v1,a0,a1
0+212c <test3\+0x1cd0> e930 0000 	bnezc	t1,00002130 <test3\+0x1cd4>
			212c: R_MICROMIPS_PC20_S1	test-0x4
0+2130 <test3\+0x1cd4> b2c6      	addu	v1,a0,a1
0+2132 <test3\+0x1cd6> c92c 1000 	bgeuic	t1,2,00002136 <test3\+0x1cda>
			2132: R_MICROMIPS_PC11_S1	test-0x4
0+2136 <test3\+0x1cda> b2c6      	addu	v1,a0,a1
0+2138 <test3\+0x1cdc> a920 8000 	bgtzc	t1,0000213c <test3\+0x1ce0>
			2138: R_MICROMIPS_PC14_S1	test-0x4
0+213c <test3\+0x1ce0> b2c6      	addu	v1,a0,a1
0+213e <test3\+0x1ce2> 8920 8000 	blezc	t1,00002142 <test3\+0x1ce6>
			213e: R_MICROMIPS_PC14_S1	test-0x4
0+2142 <test3\+0x1ce6> b2c6      	addu	v1,a0,a1
0+2144 <test3\+0x1ce8> 880a 8000 	bgezc	t2,00002148 <test3\+0x1cec>
			2144: R_MICROMIPS_PC14_S1	test-0x4
0+2148 <test3\+0x1cec> b2c6      	addu	v1,a0,a1
0+214a <test3\+0x1cee> 212a 0b50 	slt	at,t2,t1
0+214e <test3\+0x1cf2> e820 0000 	beqzc	at,00002152 <test3\+0x1cf6>
			214e: R_MICROMIPS_PC20_S1	test-0x4
0+2152 <test3\+0x1cf6> b2c6      	addu	v1,a0,a1
0+2154 <test3\+0x1cf8> 2800 0000 	bc	00002158 <test3\+0x1cfc>
			2154: R_MICROMIPS_PC25_S1	test-0x4
0+2158 <test3\+0x1cfc> b2c6      	addu	v1,a0,a1
0+215a <test3\+0x1cfe> a809 8000 	bltzc	t1,0000215e <test3\+0x1d02>
			215a: R_MICROMIPS_PC14_S1	test-0x4
0+215e <test3\+0x1d02> b2c6      	addu	v1,a0,a1
0+2160 <test3\+0x1d04> 8920 8000 	blezc	t1,00002164 <test3\+0x1d08>
			2160: R_MICROMIPS_PC14_S1	test-0x4
0+2164 <test3\+0x1d08> b2c6      	addu	v1,a0,a1
0+2166 <test3\+0x1d0a> c938 1000 	bltic	t1,2,0000216a <test3\+0x1d0e>
			2166: R_MICROMIPS_PC11_S1	test-0x4
0+216a <test3\+0x1d0e> b2c6      	addu	v1,a0,a1
0+216c <test3\+0x1d10> e920 0000 	beqzc	t1,00002170 <test3\+0x1d14>
			216c: R_MICROMIPS_PC20_S1	test-0x4
0+2170 <test3\+0x1d14> b2c6      	addu	v1,a0,a1
0+2172 <test3\+0x1d16> 2800 0000 	bc	00002176 <test3\+0x1d1a>
			2172: R_MICROMIPS_PC25_S1	test-0x4
0+2176 <test3\+0x1d1a> b2c6      	addu	v1,a0,a1
0+2178 <test3\+0x1d1c> 212a 0b90 	sltu	at,t2,t1
0+217c <test3\+0x1d20> e820 0000 	beqzc	at,00002180 <test3\+0x1d24>
			217c: R_MICROMIPS_PC20_S1	test-0x4
0+2180 <test3\+0x1d24> b2c6      	addu	v1,a0,a1
0+2182 <test3\+0x1d26> 2800 0000 	bc	00002186 <test3\+0x1d2a>
			2182: R_MICROMIPS_PC25_S1	test-0x4
0+2186 <test3\+0x1d2a> b2c6      	addu	v1,a0,a1
0+2188 <test3\+0x1d2c> 2800 0000 	bc	0000218c <test3\+0x1d30>
			2188: R_MICROMIPS_PC25_S1	test-0x4
0+218c <test3\+0x1d30> b2c6      	addu	v1,a0,a1
0+218e <test3\+0x1d32> e920 0000 	beqzc	t1,00002192 <test3\+0x1d36>
			218e: R_MICROMIPS_PC20_S1	test-0x4
0+2192 <test3\+0x1d36> b2c6      	addu	v1,a0,a1
0+2194 <test3\+0x1d38> c93c 1000 	bltuic	t1,2,00002198 <test3\+0x1d3c>
			2194: R_MICROMIPS_PC11_S1	test-0x4
0+2198 <test3\+0x1d3c> b2c6      	addu	v1,a0,a1
0+219a <test3\+0x1d3e> 8920 8000 	blezc	t1,0000219e <test3\+0x1d42>
			219a: R_MICROMIPS_PC14_S1	test-0x4
0+219e <test3\+0x1d42> b2c6      	addu	v1,a0,a1
0+21a0 <test3\+0x1d44> a809 8000 	bltzc	t1,000021a4 <test3\+0x1d48>
			21a0: R_MICROMIPS_PC14_S1	test-0x4
0+21a4 <test3\+0x1d48> b2c6      	addu	v1,a0,a1
0+21a6 <test3\+0x1d4a> a940 8000 	bgtzc	t2,000021aa <test3\+0x1d4e>
			21a6: R_MICROMIPS_PC14_S1	test-0x4
0+21aa <test3\+0x1d4e> b2c6      	addu	v1,a0,a1
0+21ac <test3\+0x1d50> a949 8000 	bltc	t1,t2,000021b0 <test3\+0x1d54>
			21ac: R_MICROMIPS_PC14_S1	test-0x4
0+21b0 <test3\+0x1d54> b2c6      	addu	v1,a0,a1
0+21b2 <test3\+0x1d56> a809 8000 	bltzc	t1,000021b6 <test3\+0x1d5a>
			21b2: R_MICROMIPS_PC14_S1	test-0x4
0+21b6 <test3\+0x1d5a> b2c6      	addu	v1,a0,a1
0+21b8 <test3\+0x1d5c> 8920 8000 	blezc	t1,000021bc <test3\+0x1d60>
			21b8: R_MICROMIPS_PC14_S1	test-0x4
0+21bc <test3\+0x1d60> b2c6      	addu	v1,a0,a1
0+21be <test3\+0x1d62> c938 1000 	bltic	t1,2,000021c2 <test3\+0x1d66>
			21be: R_MICROMIPS_PC11_S1	test-0x4
0+21c2 <test3\+0x1d66> b2c6      	addu	v1,a0,a1
0+21c4 <test3\+0x1d68> a809 c000 	bltuc	t1,zero,000021c8 <test3\+0x1d6c>
			21c4: R_MICROMIPS_PC14_S1	test-0x4
0+21c8 <test3\+0x1d6c> b2c6      	addu	v1,a0,a1
0+21ca <test3\+0x1d6e> a940 c000 	bltuc	zero,t2,000021ce <test3\+0x1d72>
			21ca: R_MICROMIPS_PC14_S1	test-0x4
0+21ce <test3\+0x1d72> b2c6      	addu	v1,a0,a1
0+21d0 <test3\+0x1d74> a949 c000 	bltuc	t1,t2,000021d4 <test3\+0x1d78>
			21d0: R_MICROMIPS_PC14_S1	test-0x4
0+21d4 <test3\+0x1d78> b2c6      	addu	v1,a0,a1
0+21d6 <test3\+0x1d7a> 9008      	nop
0+21d8 <test3\+0x1d7c> b2c6      	addu	v1,a0,a1
0+21da <test3\+0x1d7e> e920 0000 	beqzc	t1,000021de <test3\+0x1d82>
			21da: R_MICROMIPS_PC20_S1	test-0x4
0+21de <test3\+0x1d82> b2c6      	addu	v1,a0,a1
0+21e0 <test3\+0x1d84> c93c 1000 	bltuic	t1,2,000021e4 <test3\+0x1d88>
			21e0: R_MICROMIPS_PC11_S1	test-0x4
0+21e4 <test3\+0x1d88> b2c6      	addu	v1,a0,a1
0+21e6 <test3\+0x1d8a> a809 8000 	bltzc	t1,000021ea <test3\+0x1d8e>
			21e6: R_MICROMIPS_PC14_S1	test-0x4
0+21ea <test3\+0x1d8e> b2c6      	addu	v1,a0,a1
0+21ec <test3\+0x1d90> e930 0000 	bnezc	t1,000021f0 <test3\+0x1d94>
			21ec: R_MICROMIPS_PC20_S1	test-0x4
0+21f0 <test3\+0x1d94> b2c6      	addu	v1,a0,a1
0+21f2 <test3\+0x1d96> a949 0000 	bnec	t1,t2,000021f6 <test3\+0x1d9a>
			21f2: R_MICROMIPS_PC14_S1	test-0x4
0+21f6 <test3\+0x1d9a> b2c6      	addu	v1,a0,a1
0+21f8 <test3\+0x1d9c> e930 0000 	bnezc	t1,000021fc <test3\+0x1da0>
			21f8: R_MICROMIPS_PC20_S1	test-0x4
0+21fc <test3\+0x1da0> b2c6      	addu	v1,a0,a1
0+21fe <test3\+0x1da2> c930 0800 	bneic	t1,1,00002202 <test3\+0x1da6>
			21fe: R_MICROMIPS_PC11_S1	test-0x4
0+2202 <test3\+0x1da6> b2c6      	addu	v1,a0,a1
0+2204 <test3\+0x1da8> 8460 9004 	sw	v1,4\(zero\)
0+2208 <test3\+0x1dac> 8480 9008 	sw	a0,8\(zero\)
0+220c <test3\+0x1db0> 8460 9004 	sw	v1,4\(zero\)
0+2210 <test3\+0x1db4> 8480 9008 	sw	a0,8\(zero\)
0+2214 <test3\+0x1db8> 6020 0000 7fff 	li	at,0x7fff
0+221a <test3\+0x1dbe> 8461 9000 	sw	v1,0\(at\)
0+221e <test3\+0x1dc2> 8481 9004 	sw	a0,4\(at\)
0+2222 <test3\+0x1dc6> e03f 8ffd 	lui	at,0xffff8
0+2226 <test3\+0x1dca> 8461 9000 	sw	v1,0\(at\)
0+222a <test3\+0x1dce> 8481 9004 	sw	a0,4\(at\)
0+222e <test3\+0x1dd2> 6020 0000 ffff 	li	at,0xffff
0+2234 <test3\+0x1dd8> 8461 9000 	sw	v1,0\(at\)
0+2238 <test3\+0x1ddc> 8481 9004 	sw	a0,4\(at\)
0+223c <test3\+0x1de0> e03f 0ffd 	lui	at,0xffff0
0+2240 <test3\+0x1de4> 8461 9000 	sw	v1,0\(at\)
0+2244 <test3\+0x1de8> 8481 9004 	sw	a0,4\(at\)
0+2248 <test3\+0x1dec> e03f 8ffd 	lui	at,0xffff8
0+224c <test3\+0x1df0> 8461 9000 	sw	v1,0\(at\)
0+2250 <test3\+0x1df4> 8481 9004 	sw	a0,4\(at\)
0+2254 <test3\+0x1df8> e03f 0ffd 	lui	at,0xffff0
0+2258 <test3\+0x1dfc> 8461 9001 	sw	v1,1\(at\)
0+225c <test3\+0x1e00> 8481 9005 	sw	a0,5\(at\)
0+2260 <test3\+0x1e04> e03f 8ffd 	lui	at,0xffff8
0+2264 <test3\+0x1e08> 8461 9001 	sw	v1,1\(at\)
0+2268 <test3\+0x1e0c> 8481 9005 	sw	a0,5\(at\)
0+226c <test3\+0x1e10> e020 0e01 	lui	at,0xf0000
0+2270 <test3\+0x1e14> 8461 9000 	sw	v1,0\(at\)
0+2274 <test3\+0x1e18> 8481 9004 	sw	a0,4\(at\)
0+2278 <test3\+0x1e1c> 8460 9fff 	sw	v1,4095\(zero\)
0+227c <test3\+0x1e20> 8480 9003 	sw	a0,3\(zero\)
0+2280 <test3\+0x1e24> e034 5244 	lui	at,0x12345
0+2284 <test3\+0x1e28> 8461 9678 	sw	v1,1656\(at\)
0+2288 <test3\+0x1e2c> 8481 967c 	sw	a0,1660\(at\)
0+228c <test3\+0x1e30> 8464 9000 	sw	v1,0\(a0\)
0+2290 <test3\+0x1e34> 8484 9004 	sw	a0,4\(a0\)
0+2294 <test3\+0x1e38> 8464 9000 	sw	v1,0\(a0\)
0+2298 <test3\+0x1e3c> 8484 9004 	sw	a0,4\(a0\)
0+229c <test3\+0x1e40> 6020 0000 7fff 	li	at,0x7fff
0+22a2 <test3\+0x1e46> 2024 0950 	addu	at,a0,at
0+22a6 <test3\+0x1e4a> 8461 9000 	sw	v1,0\(at\)
0+22aa <test3\+0x1e4e> 8481 9004 	sw	a0,4\(at\)
0+22ae <test3\+0x1e52> e03f 8ffd 	lui	at,0xffff8
0+22b2 <test3\+0x1e56> 2024 0950 	addu	at,a0,at
0+22b6 <test3\+0x1e5a> 8461 9000 	sw	v1,0\(at\)
0+22ba <test3\+0x1e5e> 8481 9004 	sw	a0,4\(at\)
0+22be <test3\+0x1e62> 6020 0000 ffff 	li	at,0xffff
0+22c4 <test3\+0x1e68> 2024 0950 	addu	at,a0,at
0+22c8 <test3\+0x1e6c> 8461 9000 	sw	v1,0\(at\)
0+22cc <test3\+0x1e70> 8481 9004 	sw	a0,4\(at\)
0+22d0 <test3\+0x1e74> e03f 0ffd 	lui	at,0xffff0
0+22d4 <test3\+0x1e78> 2024 0950 	addu	at,a0,at
0+22d8 <test3\+0x1e7c> 8461 9000 	sw	v1,0\(at\)
0+22dc <test3\+0x1e80> 8481 9004 	sw	a0,4\(at\)
0+22e0 <test3\+0x1e84> e03f 8ffd 	lui	at,0xffff8
0+22e4 <test3\+0x1e88> 2024 0950 	addu	at,a0,at
0+22e8 <test3\+0x1e8c> 8461 9000 	sw	v1,0\(at\)
0+22ec <test3\+0x1e90> 8481 9004 	sw	a0,4\(at\)
0+22f0 <test3\+0x1e94> e03f 0ffd 	lui	at,0xffff0
0+22f4 <test3\+0x1e98> 2024 0950 	addu	at,a0,at
0+22f8 <test3\+0x1e9c> 8461 9001 	sw	v1,1\(at\)
0+22fc <test3\+0x1ea0> 8481 9005 	sw	a0,5\(at\)
0+2300 <test3\+0x1ea4> e03f 8ffd 	lui	at,0xffff8
0+2304 <test3\+0x1ea8> 2024 0950 	addu	at,a0,at
0+2308 <test3\+0x1eac> 8461 9001 	sw	v1,1\(at\)
0+230c <test3\+0x1eb0> 8481 9005 	sw	a0,5\(at\)
0+2310 <test3\+0x1eb4> e020 0e01 	lui	at,0xf0000
0+2314 <test3\+0x1eb8> 2024 0950 	addu	at,a0,at
0+2318 <test3\+0x1ebc> 8461 9000 	sw	v1,0\(at\)
0+231c <test3\+0x1ec0> 8481 9004 	sw	a0,4\(at\)
0+2320 <test3\+0x1ec4> 8464 9fff 	sw	v1,4095\(a0\)
0+2324 <test3\+0x1ec8> 8484 9003 	sw	a0,3\(a0\)
0+2328 <test3\+0x1ecc> e034 5244 	lui	at,0x12345
0+232c <test3\+0x1ed0> 2024 0950 	addu	at,a0,at
0+2330 <test3\+0x1ed4> 8461 9678 	sw	v1,1656\(at\)
0+2334 <test3\+0x1ed8> 8481 967c 	sw	a0,1660\(at\)
0+2338 <test3\+0x1edc> 8460 8004 	lw	v1,4\(zero\)
0+233c <test3\+0x1ee0> 8480 8008 	lw	a0,8\(zero\)
0+2340 <test3\+0x1ee4> 8460 8004 	lw	v1,4\(zero\)
0+2344 <test3\+0x1ee8> 8480 8008 	lw	a0,8\(zero\)
0+2348 <test3\+0x1eec> 6020 0000 7fff 	li	at,0x7fff
0+234e <test3\+0x1ef2> 8461 8000 	lw	v1,0\(at\)
0+2352 <test3\+0x1ef6> 8481 8004 	lw	a0,4\(at\)
0+2356 <test3\+0x1efa> e03f 8ffd 	lui	at,0xffff8
0+235a <test3\+0x1efe> 8461 8000 	lw	v1,0\(at\)
0+235e <test3\+0x1f02> 8481 8004 	lw	a0,4\(at\)
0+2362 <test3\+0x1f06> 6020 0000 ffff 	li	at,0xffff
0+2368 <test3\+0x1f0c> 8461 8000 	lw	v1,0\(at\)
0+236c <test3\+0x1f10> 8481 8004 	lw	a0,4\(at\)
0+2370 <test3\+0x1f14> e03f 0ffd 	lui	at,0xffff0
0+2374 <test3\+0x1f18> 8461 8000 	lw	v1,0\(at\)
0+2378 <test3\+0x1f1c> 8481 8004 	lw	a0,4\(at\)
0+237c <test3\+0x1f20> e03f 8ffd 	lui	at,0xffff8
0+2380 <test3\+0x1f24> 8461 8000 	lw	v1,0\(at\)
0+2384 <test3\+0x1f28> 8481 8004 	lw	a0,4\(at\)
0+2388 <test3\+0x1f2c> e03f 0ffd 	lui	at,0xffff0
0+238c <test3\+0x1f30> 8461 8001 	lw	v1,1\(at\)
0+2390 <test3\+0x1f34> 8481 8005 	lw	a0,5\(at\)
0+2394 <test3\+0x1f38> e03f 8ffd 	lui	at,0xffff8
0+2398 <test3\+0x1f3c> 8461 8001 	lw	v1,1\(at\)
0+239c <test3\+0x1f40> 8481 8005 	lw	a0,5\(at\)
0+23a0 <test3\+0x1f44> e020 0e01 	lui	at,0xf0000
0+23a4 <test3\+0x1f48> 8461 8000 	lw	v1,0\(at\)
0+23a8 <test3\+0x1f4c> 8481 8004 	lw	a0,4\(at\)
0+23ac <test3\+0x1f50> 8460 8fff 	lw	v1,4095\(zero\)
0+23b0 <test3\+0x1f54> 8480 8003 	lw	a0,3\(zero\)
0+23b4 <test3\+0x1f58> e034 5244 	lui	at,0x12345
0+23b8 <test3\+0x1f5c> 8461 8678 	lw	v1,1656\(at\)
0+23bc <test3\+0x1f60> 8481 867c 	lw	a0,1660\(at\)
0+23c0 <test3\+0x1f64> 8464 8000 	lw	v1,0\(a0\)
0+23c4 <test3\+0x1f68> 8484 8004 	lw	a0,4\(a0\)
0+23c8 <test3\+0x1f6c> 8464 8000 	lw	v1,0\(a0\)
0+23cc <test3\+0x1f70> 8484 8004 	lw	a0,4\(a0\)
0+23d0 <test3\+0x1f74> 6020 0000 7fff 	li	at,0x7fff
0+23d6 <test3\+0x1f7a> 2024 0950 	addu	at,a0,at
0+23da <test3\+0x1f7e> 8461 8000 	lw	v1,0\(at\)
0+23de <test3\+0x1f82> 8481 8004 	lw	a0,4\(at\)
0+23e2 <test3\+0x1f86> e03f 8ffd 	lui	at,0xffff8
0+23e6 <test3\+0x1f8a> 2024 0950 	addu	at,a0,at
0+23ea <test3\+0x1f8e> 8461 8000 	lw	v1,0\(at\)
0+23ee <test3\+0x1f92> 8481 8004 	lw	a0,4\(at\)
0+23f2 <test3\+0x1f96> 6020 0000 ffff 	li	at,0xffff
0+23f8 <test3\+0x1f9c> 2024 0950 	addu	at,a0,at
0+23fc <test3\+0x1fa0> 8461 8000 	lw	v1,0\(at\)
0+2400 <test3\+0x1fa4> 8481 8004 	lw	a0,4\(at\)
0+2404 <test3\+0x1fa8> e03f 0ffd 	lui	at,0xffff0
0+2408 <test3\+0x1fac> 2024 0950 	addu	at,a0,at
0+240c <test3\+0x1fb0> 8461 8000 	lw	v1,0\(at\)
0+2410 <test3\+0x1fb4> 8481 8004 	lw	a0,4\(at\)
0+2414 <test3\+0x1fb8> e03f 8ffd 	lui	at,0xffff8
0+2418 <test3\+0x1fbc> 2024 0950 	addu	at,a0,at
0+241c <test3\+0x1fc0> 8461 8000 	lw	v1,0\(at\)
0+2420 <test3\+0x1fc4> 8481 8004 	lw	a0,4\(at\)
0+2424 <test3\+0x1fc8> e03f 0ffd 	lui	at,0xffff0
0+2428 <test3\+0x1fcc> 2024 0950 	addu	at,a0,at
0+242c <test3\+0x1fd0> 8461 8001 	lw	v1,1\(at\)
0+2430 <test3\+0x1fd4> 8481 8005 	lw	a0,5\(at\)
0+2434 <test3\+0x1fd8> e03f 8ffd 	lui	at,0xffff8
0+2438 <test3\+0x1fdc> 2024 0950 	addu	at,a0,at
0+243c <test3\+0x1fe0> 8461 8001 	lw	v1,1\(at\)
0+2440 <test3\+0x1fe4> 8481 8005 	lw	a0,5\(at\)
0+2444 <test3\+0x1fe8> e020 0e01 	lui	at,0xf0000
0+2448 <test3\+0x1fec> 2024 0950 	addu	at,a0,at
0+244c <test3\+0x1ff0> 8461 8000 	lw	v1,0\(at\)
0+2450 <test3\+0x1ff4> 8481 8004 	lw	a0,4\(at\)
0+2454 <test3\+0x1ff8> 8464 8fff 	lw	v1,4095\(a0\)
0+2458 <test3\+0x1ffc> 8484 8003 	lw	a0,3\(a0\)
0+245c <test3\+0x2000> e034 5244 	lui	at,0x12345
0+2460 <test3\+0x2004> 2024 0950 	addu	at,a0,at
0+2464 <test3\+0x2008> 8461 8678 	lw	v1,1656\(at\)
0+2468 <test3\+0x200c> 8481 867c 	lw	a0,1660\(at\)
0+246c <test3\+0x2010> 1fa0      	restore\.jrc	0
0+246e <test3\+0x2012> 1fa2      	restore\.jrc	8
0+2470 <test3\+0x2014> 1fa4      	restore\.jrc	16
0+2472 <test3\+0x2016> 1fa6      	restore\.jrc	24
0+2474 <test3\+0x2018> 1fa8      	restore\.jrc	32
0+2476 <test3\+0x201a> 1faa      	restore\.jrc	40
0+2478 <test3\+0x201c> 03bd 0004 	addiu	sp,sp,4
0+247c <test3\+0x2020> 481f 0000 	jrc	ra
0+2480 <test3\+0x2024> 03bd 000c 	addiu	sp,sp,12
0+2484 <test3\+0x2028> 481f 0000 	jrc	ra
0+2488 <test3\+0x202c> 03bd 0014 	addiu	sp,sp,20
0+248c <test3\+0x2030> 481f 0000 	jrc	ra
0+2490 <test3\+0x2034> 03bd 001c 	addiu	sp,sp,28
0+2494 <test3\+0x2038> 481f 0000 	jrc	ra
0+2498 <test3\+0x203c> 03bd 0024 	addiu	sp,sp,36
0+249c <test3\+0x2040> 481f 0000 	jrc	ra
0+24a0 <test3\+0x2044> 1fbe      	restore\.jrc	120
0+24a2 <test3\+0x2046> 03bd 007c 	addiu	sp,sp,124
0+24a6 <test3\+0x204a> 481f 0000 	jrc	ra
0+24aa <test3\+0x204e> a460 7100 	ldc2	\$3,0\(zero\)
0+24ae <test3\+0x2052> a460 7100 	ldc2	\$3,0\(zero\)
0+24b2 <test3\+0x2056> a460 7104 	ldc2	\$3,4\(zero\)
0+24b6 <test3\+0x205a> a460 7104 	ldc2	\$3,4\(zero\)
0+24ba <test3\+0x205e> a464 7100 	ldc2	\$3,0\(a0\)
0+24be <test3\+0x2062> a464 7100 	ldc2	\$3,0\(a0\)
0+24c2 <test3\+0x2066> e020 8000 	lui	at,0x8
0+24c6 <test3\+0x206a> 2081 0950 	addu	at,at,a0
0+24ca <test3\+0x206e> a461 f1ff 	ldc2	\$3,-1\(at\)
0+24ce <test3\+0x2072> e03f 8ffd 	lui	at,0xffff8
0+24d2 <test3\+0x2076> 2081 0950 	addu	at,at,a0
0+24d6 <test3\+0x207a> a461 7100 	ldc2	\$3,0\(at\)
0+24da <test3\+0x207e> e021 0000 	lui	at,0x10
0+24de <test3\+0x2082> 2081 0950 	addu	at,at,a0
0+24e2 <test3\+0x2086> a461 f1ff 	ldc2	\$3,-1\(at\)
0+24e6 <test3\+0x208a> e03f 0ffd 	lui	at,0xffff0
0+24ea <test3\+0x208e> 2081 0950 	addu	at,at,a0
0+24ee <test3\+0x2092> a461 7100 	ldc2	\$3,0\(at\)
0+24f2 <test3\+0x2096> e03f 8ffd 	lui	at,0xffff8
0+24f6 <test3\+0x209a> 2081 0950 	addu	at,at,a0
0+24fa <test3\+0x209e> a461 7100 	ldc2	\$3,0\(at\)
0+24fe <test3\+0x20a2> e03f 0ffd 	lui	at,0xffff0
0+2502 <test3\+0x20a6> 2081 0950 	addu	at,at,a0
0+2506 <test3\+0x20aa> a461 7101 	ldc2	\$3,1\(at\)
0+250a <test3\+0x20ae> e03f 8ffd 	lui	at,0xffff8
0+250e <test3\+0x20b2> 2081 0950 	addu	at,at,a0
0+2512 <test3\+0x20b6> a461 7101 	ldc2	\$3,1\(at\)
0+2516 <test3\+0x20ba> e020 0e01 	lui	at,0xf0000
0+251a <test3\+0x20be> 2081 0950 	addu	at,at,a0
0+251e <test3\+0x20c2> a461 7100 	ldc2	\$3,0\(at\)
0+2522 <test3\+0x20c6> a464 f1ff 	ldc2	\$3,-1\(a0\)
0+2526 <test3\+0x20ca> 6020 1234 5600 	li	at,0x12345600
0+252c <test3\+0x20d0> 2081 0950 	addu	at,at,a0
0+2530 <test3\+0x20d4> a461 7178 	ldc2	\$3,120\(at\)
0+2534 <test3\+0x20d8> a460 5100 	lwc2	\$3,0\(zero\)
0+2538 <test3\+0x20dc> a460 5100 	lwc2	\$3,0\(zero\)
0+253c <test3\+0x20e0> a460 5104 	lwc2	\$3,4\(zero\)
0+2540 <test3\+0x20e4> a460 5104 	lwc2	\$3,4\(zero\)
0+2544 <test3\+0x20e8> a464 5100 	lwc2	\$3,0\(a0\)
0+2548 <test3\+0x20ec> a464 5100 	lwc2	\$3,0\(a0\)
0+254c <test3\+0x20f0> e020 8000 	lui	at,0x8
0+2550 <test3\+0x20f4> 2081 0950 	addu	at,at,a0
0+2554 <test3\+0x20f8> a461 d1ff 	lwc2	\$3,-1\(at\)
0+2558 <test3\+0x20fc> e03f 8ffd 	lui	at,0xffff8
0+255c <test3\+0x2100> 2081 0950 	addu	at,at,a0
0+2560 <test3\+0x2104> a461 5100 	lwc2	\$3,0\(at\)
0+2564 <test3\+0x2108> e021 0000 	lui	at,0x10
0+2568 <test3\+0x210c> 2081 0950 	addu	at,at,a0
0+256c <test3\+0x2110> a461 d1ff 	lwc2	\$3,-1\(at\)
0+2570 <test3\+0x2114> e03f 0ffd 	lui	at,0xffff0
0+2574 <test3\+0x2118> 2081 0950 	addu	at,at,a0
0+2578 <test3\+0x211c> a461 5100 	lwc2	\$3,0\(at\)
0+257c <test3\+0x2120> e03f 8ffd 	lui	at,0xffff8
0+2580 <test3\+0x2124> 2081 0950 	addu	at,at,a0
0+2584 <test3\+0x2128> a461 5100 	lwc2	\$3,0\(at\)
0+2588 <test3\+0x212c> e03f 0ffd 	lui	at,0xffff0
0+258c <test3\+0x2130> 2081 0950 	addu	at,at,a0
0+2590 <test3\+0x2134> a461 5101 	lwc2	\$3,1\(at\)
0+2594 <test3\+0x2138> e03f 8ffd 	lui	at,0xffff8
0+2598 <test3\+0x213c> 2081 0950 	addu	at,at,a0
0+259c <test3\+0x2140> a461 5101 	lwc2	\$3,1\(at\)
0+25a0 <test3\+0x2144> e020 0e01 	lui	at,0xf0000
0+25a4 <test3\+0x2148> 2081 0950 	addu	at,at,a0
0+25a8 <test3\+0x214c> a461 5100 	lwc2	\$3,0\(at\)
0+25ac <test3\+0x2150> a464 d1ff 	lwc2	\$3,-1\(a0\)
0+25b0 <test3\+0x2154> 6020 1234 5600 	li	at,0x12345600
0+25b6 <test3\+0x215a> 2081 0950 	addu	at,at,a0
0+25ba <test3\+0x215e> a461 5178 	lwc2	\$3,120\(at\)
0+25be <test3\+0x2162> 20a0 4d3f 	mfc2	a1,\$0
0+25c2 <test3\+0x2166> 20a1 4d3f 	mfc2	a1,\$1
0+25c6 <test3\+0x216a> 20a2 4d3f 	mfc2	a1,\$2
0+25ca <test3\+0x216e> 20a3 4d3f 	mfc2	a1,\$3
0+25ce <test3\+0x2172> 20a4 4d3f 	mfc2	a1,\$4
0+25d2 <test3\+0x2176> 20a5 4d3f 	mfc2	a1,\$5
0+25d6 <test3\+0x217a> 20a6 4d3f 	mfc2	a1,\$6
0+25da <test3\+0x217e> 20a7 4d3f 	mfc2	a1,\$7
0+25de <test3\+0x2182> 20a8 4d3f 	mfc2	a1,\$8
0+25e2 <test3\+0x2186> 20a9 4d3f 	mfc2	a1,\$9
0+25e6 <test3\+0x218a> 20aa 4d3f 	mfc2	a1,\$10
0+25ea <test3\+0x218e> 20ab 4d3f 	mfc2	a1,\$11
0+25ee <test3\+0x2192> 20ac 4d3f 	mfc2	a1,\$12
0+25f2 <test3\+0x2196> 20ad 4d3f 	mfc2	a1,\$13
0+25f6 <test3\+0x219a> 20ae 4d3f 	mfc2	a1,\$14
0+25fa <test3\+0x219e> 20af 4d3f 	mfc2	a1,\$15
0+25fe <test3\+0x21a2> 20b0 4d3f 	mfc2	a1,\$16
0+2602 <test3\+0x21a6> 20b1 4d3f 	mfc2	a1,\$17
0+2606 <test3\+0x21aa> 20b2 4d3f 	mfc2	a1,\$18
0+260a <test3\+0x21ae> 20b3 4d3f 	mfc2	a1,\$19
0+260e <test3\+0x21b2> 20b4 4d3f 	mfc2	a1,\$20
0+2612 <test3\+0x21b6> 20b5 4d3f 	mfc2	a1,\$21
0+2616 <test3\+0x21ba> 20b6 4d3f 	mfc2	a1,\$22
0+261a <test3\+0x21be> 20b7 4d3f 	mfc2	a1,\$23
0+261e <test3\+0x21c2> 20b8 4d3f 	mfc2	a1,\$24
0+2622 <test3\+0x21c6> 20b9 4d3f 	mfc2	a1,\$25
0+2626 <test3\+0x21ca> 20ba 4d3f 	mfc2	a1,\$26
0+262a <test3\+0x21ce> 20bb 4d3f 	mfc2	a1,\$27
0+262e <test3\+0x21d2> 20bc 4d3f 	mfc2	a1,\$28
0+2632 <test3\+0x21d6> 20bd 4d3f 	mfc2	a1,\$29
0+2636 <test3\+0x21da> 20be 4d3f 	mfc2	a1,\$30
0+263a <test3\+0x21de> 20bf 4d3f 	mfc2	a1,\$31
0+263e <test3\+0x21e2> 20a0 8d3f 	mfhc2	a1,\$0
0+2642 <test3\+0x21e6> 20a1 8d3f 	mfhc2	a1,\$1
0+2646 <test3\+0x21ea> 20a2 8d3f 	mfhc2	a1,\$2
0+264a <test3\+0x21ee> 20a3 8d3f 	mfhc2	a1,\$3
0+264e <test3\+0x21f2> 20a4 8d3f 	mfhc2	a1,\$4
0+2652 <test3\+0x21f6> 20a5 8d3f 	mfhc2	a1,\$5
0+2656 <test3\+0x21fa> 20a6 8d3f 	mfhc2	a1,\$6
0+265a <test3\+0x21fe> 20a7 8d3f 	mfhc2	a1,\$7
0+265e <test3\+0x2202> 20a8 8d3f 	mfhc2	a1,\$8
0+2662 <test3\+0x2206> 20a9 8d3f 	mfhc2	a1,\$9
0+2666 <test3\+0x220a> 20aa 8d3f 	mfhc2	a1,\$10
0+266a <test3\+0x220e> 20ab 8d3f 	mfhc2	a1,\$11
0+266e <test3\+0x2212> 20ac 8d3f 	mfhc2	a1,\$12
0+2672 <test3\+0x2216> 20ad 8d3f 	mfhc2	a1,\$13
0+2676 <test3\+0x221a> 20ae 8d3f 	mfhc2	a1,\$14
0+267a <test3\+0x221e> 20af 8d3f 	mfhc2	a1,\$15
0+267e <test3\+0x2222> 20b0 8d3f 	mfhc2	a1,\$16
0+2682 <test3\+0x2226> 20b1 8d3f 	mfhc2	a1,\$17
0+2686 <test3\+0x222a> 20b2 8d3f 	mfhc2	a1,\$18
0+268a <test3\+0x222e> 20b3 8d3f 	mfhc2	a1,\$19
0+268e <test3\+0x2232> 20b4 8d3f 	mfhc2	a1,\$20
0+2692 <test3\+0x2236> 20b5 8d3f 	mfhc2	a1,\$21
0+2696 <test3\+0x223a> 20b6 8d3f 	mfhc2	a1,\$22
0+269a <test3\+0x223e> 20b7 8d3f 	mfhc2	a1,\$23
0+269e <test3\+0x2242> 20b8 8d3f 	mfhc2	a1,\$24
0+26a2 <test3\+0x2246> 20b9 8d3f 	mfhc2	a1,\$25
0+26a6 <test3\+0x224a> 20ba 8d3f 	mfhc2	a1,\$26
0+26aa <test3\+0x224e> 20bb 8d3f 	mfhc2	a1,\$27
0+26ae <test3\+0x2252> 20bc 8d3f 	mfhc2	a1,\$28
0+26b2 <test3\+0x2256> 20bd 8d3f 	mfhc2	a1,\$29
0+26b6 <test3\+0x225a> 20be 8d3f 	mfhc2	a1,\$30
0+26ba <test3\+0x225e> 20bf 8d3f 	mfhc2	a1,\$31
0+26be <test3\+0x2262> 20a0 5d3f 	mtc2	a1,\$0
0+26c2 <test3\+0x2266> 20a1 5d3f 	mtc2	a1,\$1
0+26c6 <test3\+0x226a> 20a2 5d3f 	mtc2	a1,\$2
0+26ca <test3\+0x226e> 20a3 5d3f 	mtc2	a1,\$3
0+26ce <test3\+0x2272> 20a4 5d3f 	mtc2	a1,\$4
0+26d2 <test3\+0x2276> 20a5 5d3f 	mtc2	a1,\$5
0+26d6 <test3\+0x227a> 20a6 5d3f 	mtc2	a1,\$6
0+26da <test3\+0x227e> 20a7 5d3f 	mtc2	a1,\$7
0+26de <test3\+0x2282> 20a8 5d3f 	mtc2	a1,\$8
0+26e2 <test3\+0x2286> 20a9 5d3f 	mtc2	a1,\$9
0+26e6 <test3\+0x228a> 20aa 5d3f 	mtc2	a1,\$10
0+26ea <test3\+0x228e> 20ab 5d3f 	mtc2	a1,\$11
0+26ee <test3\+0x2292> 20ac 5d3f 	mtc2	a1,\$12
0+26f2 <test3\+0x2296> 20ad 5d3f 	mtc2	a1,\$13
0+26f6 <test3\+0x229a> 20ae 5d3f 	mtc2	a1,\$14
0+26fa <test3\+0x229e> 20af 5d3f 	mtc2	a1,\$15
0+26fe <test3\+0x22a2> 20b0 5d3f 	mtc2	a1,\$16
0+2702 <test3\+0x22a6> 20b1 5d3f 	mtc2	a1,\$17
0+2706 <test3\+0x22aa> 20b2 5d3f 	mtc2	a1,\$18
0+270a <test3\+0x22ae> 20b3 5d3f 	mtc2	a1,\$19
0+270e <test3\+0x22b2> 20b4 5d3f 	mtc2	a1,\$20
0+2712 <test3\+0x22b6> 20b5 5d3f 	mtc2	a1,\$21
0+2716 <test3\+0x22ba> 20b6 5d3f 	mtc2	a1,\$22
0+271a <test3\+0x22be> 20b7 5d3f 	mtc2	a1,\$23
0+271e <test3\+0x22c2> 20b8 5d3f 	mtc2	a1,\$24
0+2722 <test3\+0x22c6> 20b9 5d3f 	mtc2	a1,\$25
0+2726 <test3\+0x22ca> 20ba 5d3f 	mtc2	a1,\$26
0+272a <test3\+0x22ce> 20bb 5d3f 	mtc2	a1,\$27
0+272e <test3\+0x22d2> 20bc 5d3f 	mtc2	a1,\$28
0+2732 <test3\+0x22d6> 20bd 5d3f 	mtc2	a1,\$29
0+2736 <test3\+0x22da> 20be 5d3f 	mtc2	a1,\$30
0+273a <test3\+0x22de> 20bf 5d3f 	mtc2	a1,\$31
0+273e <test3\+0x22e2> 20a0 9d3f 	mthc2	a1,\$0
0+2742 <test3\+0x22e6> 20a1 9d3f 	mthc2	a1,\$1
0+2746 <test3\+0x22ea> 20a2 9d3f 	mthc2	a1,\$2
0+274a <test3\+0x22ee> 20a3 9d3f 	mthc2	a1,\$3
0+274e <test3\+0x22f2> 20a4 9d3f 	mthc2	a1,\$4
0+2752 <test3\+0x22f6> 20a5 9d3f 	mthc2	a1,\$5
0+2756 <test3\+0x22fa> 20a6 9d3f 	mthc2	a1,\$6
0+275a <test3\+0x22fe> 20a7 9d3f 	mthc2	a1,\$7
0+275e <test3\+0x2302> 20a8 9d3f 	mthc2	a1,\$8
0+2762 <test3\+0x2306> 20a9 9d3f 	mthc2	a1,\$9
0+2766 <test3\+0x230a> 20aa 9d3f 	mthc2	a1,\$10
0+276a <test3\+0x230e> 20ab 9d3f 	mthc2	a1,\$11
0+276e <test3\+0x2312> 20ac 9d3f 	mthc2	a1,\$12
0+2772 <test3\+0x2316> 20ad 9d3f 	mthc2	a1,\$13
0+2776 <test3\+0x231a> 20ae 9d3f 	mthc2	a1,\$14
0+277a <test3\+0x231e> 20af 9d3f 	mthc2	a1,\$15
0+277e <test3\+0x2322> 20b0 9d3f 	mthc2	a1,\$16
0+2782 <test3\+0x2326> 20b1 9d3f 	mthc2	a1,\$17
0+2786 <test3\+0x232a> 20b2 9d3f 	mthc2	a1,\$18
0+278a <test3\+0x232e> 20b3 9d3f 	mthc2	a1,\$19
0+278e <test3\+0x2332> 20b4 9d3f 	mthc2	a1,\$20
0+2792 <test3\+0x2336> 20b5 9d3f 	mthc2	a1,\$21
0+2796 <test3\+0x233a> 20b6 9d3f 	mthc2	a1,\$22
0+279a <test3\+0x233e> 20b7 9d3f 	mthc2	a1,\$23
0+279e <test3\+0x2342> 20b8 9d3f 	mthc2	a1,\$24
0+27a2 <test3\+0x2346> 20b9 9d3f 	mthc2	a1,\$25
0+27a6 <test3\+0x234a> 20ba 9d3f 	mthc2	a1,\$26
0+27aa <test3\+0x234e> 20bb 9d3f 	mthc2	a1,\$27
0+27ae <test3\+0x2352> 20bc 9d3f 	mthc2	a1,\$28
0+27b2 <test3\+0x2356> 20bd 9d3f 	mthc2	a1,\$29
0+27b6 <test3\+0x235a> 20be 9d3f 	mthc2	a1,\$30
0+27ba <test3\+0x235e> 20bf 9d3f 	mthc2	a1,\$31
0+27be <test3\+0x2362> a460 7900 	sdc2	\$3,0\(zero\)
0+27c2 <test3\+0x2366> a460 7900 	sdc2	\$3,0\(zero\)
0+27c6 <test3\+0x236a> a460 7904 	sdc2	\$3,4\(zero\)
0+27ca <test3\+0x236e> a460 7904 	sdc2	\$3,4\(zero\)
0+27ce <test3\+0x2372> a464 7900 	sdc2	\$3,0\(a0\)
0+27d2 <test3\+0x2376> a464 7900 	sdc2	\$3,0\(a0\)
0+27d6 <test3\+0x237a> e020 8000 	lui	at,0x8
0+27da <test3\+0x237e> 2081 0950 	addu	at,at,a0
0+27de <test3\+0x2382> a461 f9ff 	sdc2	\$3,-1\(at\)
0+27e2 <test3\+0x2386> e03f 8ffd 	lui	at,0xffff8
0+27e6 <test3\+0x238a> 2081 0950 	addu	at,at,a0
0+27ea <test3\+0x238e> a461 7900 	sdc2	\$3,0\(at\)
0+27ee <test3\+0x2392> e021 0000 	lui	at,0x10
0+27f2 <test3\+0x2396> 2081 0950 	addu	at,at,a0
0+27f6 <test3\+0x239a> a461 f9ff 	sdc2	\$3,-1\(at\)
0+27fa <test3\+0x239e> e03f 0ffd 	lui	at,0xffff0
0+27fe <test3\+0x23a2> 2081 0950 	addu	at,at,a0
0+2802 <test3\+0x23a6> a461 7900 	sdc2	\$3,0\(at\)
0+2806 <test3\+0x23aa> e03f 8ffd 	lui	at,0xffff8
0+280a <test3\+0x23ae> 2081 0950 	addu	at,at,a0
0+280e <test3\+0x23b2> a461 7900 	sdc2	\$3,0\(at\)
0+2812 <test3\+0x23b6> e03f 0ffd 	lui	at,0xffff0
0+2816 <test3\+0x23ba> 2081 0950 	addu	at,at,a0
0+281a <test3\+0x23be> a461 7901 	sdc2	\$3,1\(at\)
0+281e <test3\+0x23c2> e03f 8ffd 	lui	at,0xffff8
0+2822 <test3\+0x23c6> 2081 0950 	addu	at,at,a0
0+2826 <test3\+0x23ca> a461 7901 	sdc2	\$3,1\(at\)
0+282a <test3\+0x23ce> e020 0e01 	lui	at,0xf0000
0+282e <test3\+0x23d2> 2081 0950 	addu	at,at,a0
0+2832 <test3\+0x23d6> a461 7900 	sdc2	\$3,0\(at\)
0+2836 <test3\+0x23da> a464 f9ff 	sdc2	\$3,-1\(a0\)
0+283a <test3\+0x23de> 6020 1234 5600 	li	at,0x12345600
0+2840 <test3\+0x23e4> 2081 0950 	addu	at,at,a0
0+2844 <test3\+0x23e8> a461 7978 	sdc2	\$3,120\(at\)
0+2848 <test3\+0x23ec> a460 5900 	swc2	\$3,0\(zero\)
0+284c <test3\+0x23f0> a460 5900 	swc2	\$3,0\(zero\)
0+2850 <test3\+0x23f4> a460 5904 	swc2	\$3,4\(zero\)
0+2854 <test3\+0x23f8> a460 5904 	swc2	\$3,4\(zero\)
0+2858 <test3\+0x23fc> a464 5900 	swc2	\$3,0\(a0\)
0+285c <test3\+0x2400> a464 5900 	swc2	\$3,0\(a0\)
0+2860 <test3\+0x2404> e020 8000 	lui	at,0x8
0+2864 <test3\+0x2408> 2081 0950 	addu	at,at,a0
0+2868 <test3\+0x240c> a461 d9ff 	swc2	\$3,-1\(at\)
0+286c <test3\+0x2410> e03f 8ffd 	lui	at,0xffff8
0+2870 <test3\+0x2414> 2081 0950 	addu	at,at,a0
0+2874 <test3\+0x2418> a461 5900 	swc2	\$3,0\(at\)
0+2878 <test3\+0x241c> e021 0000 	lui	at,0x10
0+287c <test3\+0x2420> 2081 0950 	addu	at,at,a0
0+2880 <test3\+0x2424> a461 d9ff 	swc2	\$3,-1\(at\)
0+2884 <test3\+0x2428> e03f 0ffd 	lui	at,0xffff0
0+2888 <test3\+0x242c> 2081 0950 	addu	at,at,a0
0+288c <test3\+0x2430> a461 5900 	swc2	\$3,0\(at\)
0+2890 <test3\+0x2434> e03f 8ffd 	lui	at,0xffff8
0+2894 <test3\+0x2438> 2081 0950 	addu	at,at,a0
0+2898 <test3\+0x243c> a461 5900 	swc2	\$3,0\(at\)
0+289c <test3\+0x2440> e03f 0ffd 	lui	at,0xffff0
0+28a0 <test3\+0x2444> 2081 0950 	addu	at,at,a0
0+28a4 <test3\+0x2448> a461 5901 	swc2	\$3,1\(at\)
0+28a8 <test3\+0x244c> e03f 8ffd 	lui	at,0xffff8
0+28ac <test3\+0x2450> 2081 0950 	addu	at,at,a0
0+28b0 <test3\+0x2454> a461 5901 	swc2	\$3,1\(at\)
0+28b4 <test3\+0x2458> e020 0e01 	lui	at,0xf0000
0+28b8 <test3\+0x245c> 2081 0950 	addu	at,at,a0
0+28bc <test3\+0x2460> a461 5900 	swc2	\$3,0\(at\)
0+28c0 <test3\+0x2464> a464 d9ff 	swc2	\$3,-1\(a0\)
0+28c4 <test3\+0x2468> 6020 1234 5600 	li	at,0x12345600
0+28ca <test3\+0x246e> 2081 0950 	addu	at,at,a0
0+28ce <test3\+0x2472> a461 5978 	swc2	\$3,120\(at\)
0+28d2 <test3\+0x2476> 6020 0000 0000 	li	at,0x0
			28d4: R_MICROMIPS_32	test
0+28d8 <test3\+0x247c> 2061 0950 	addu	at,at,v1
0+28dc <test3\+0x2480> a401 1900 	cache	0x0,0\(at\)
0+28e0 <test3\+0x2484> 6040 0000 0000 	li	v0,0x0
			28e2: R_MICROMIPS_32	test
0+28e6 <test3\+0x248a> 2062 1150 	addu	v0,v0,v1
0+28ea <test3\+0x248e> a442 4100 	ll	v0,0\(v0\)
0+28ee <test3\+0x2492> 6020 0000 0000 	li	at,0x0
			28f0: R_MICROMIPS_32	test
0+28f4 <test3\+0x2498> 2061 0950 	addu	at,at,v1
0+28f8 <test3\+0x249c> a441 4900 	sc	v0,0\(at\)
0+28fc <test3\+0x24a0> 6020 0000 0000 	li	at,0x0
			28fe: R_MICROMIPS_32	test
0+2902 <test3\+0x24a6> 2061 0950 	addu	at,at,v1
0+2906 <test3\+0x24aa> a601 5100 	lwc2	\$16,0\(at\)
0+290a <test3\+0x24ae> 6020 0000 0000 	li	at,0x0
			290c: R_MICROMIPS_32	test
0+2910 <test3\+0x24b4> 2061 0950 	addu	at,at,v1
0+2914 <test3\+0x24b8> a601 5900 	swc2	\$16,0\(at\)
0+2918 <test3\+0x24bc> 0018 03ff 	sdbbp	0x3ff
0+291c <test3\+0x24c0> 23ff c37f 	wait	0x3ff
0+2920 <test3\+0x24c4> 0008 03ff 	syscall	0x3ff
0+2924 <test3\+0x24c8> 9008      	nop
0+2926 <test3\+0x24ca> 9008      	nop
0+2928 <fp_test> a001 037b 	abs\.s	\$f0,\$f1
0+292c <fp_test\+0x4> a3df 037b 	abs\.s	\$f30,\$f31
0+2930 <fp_test\+0x8> a042 037b 	abs\.s	\$f2,\$f2
0+2934 <fp_test\+0xc> a042 037b 	abs\.s	\$f2,\$f2
0+2938 <fp_test\+0x10> a001 237b 	abs\.d	\$f0,\$f1
0+293c <fp_test\+0x14> a3df 237b 	abs\.d	\$f30,\$f31
0+2940 <fp_test\+0x18> a042 237b 	abs\.d	\$f2,\$f2
0+2944 <fp_test\+0x1c> a042 237b 	abs\.d	\$f2,\$f2
0+2948 <fp_test\+0x20> a041 0030 	add\.s	\$f0,\$f1,\$f2
0+294c <fp_test\+0x24> a3fe e830 	add\.s	\$f29,\$f30,\$f31
0+2950 <fp_test\+0x28> a3dd e830 	add\.s	\$f29,\$f29,\$f30
0+2954 <fp_test\+0x2c> a3dd e830 	add\.s	\$f29,\$f29,\$f30
0+2958 <fp_test\+0x30> a041 0130 	add\.d	\$f0,\$f1,\$f2
0+295c <fp_test\+0x34> a3fe e930 	add\.d	\$f29,\$f30,\$f31
0+2960 <fp_test\+0x38> a3dd e930 	add\.d	\$f29,\$f29,\$f30
0+2964 <fp_test\+0x3c> a3dd e930 	add\.d	\$f29,\$f29,\$f30
0+2968 <fp_test\+0x40> a001 533b 	ceil\.l\.d	\$f0,\$f1
0+296c <fp_test\+0x44> a3df 533b 	ceil\.l\.d	\$f30,\$f31
0+2970 <fp_test\+0x48> a042 533b 	ceil\.l\.d	\$f2,\$f2
0+2974 <fp_test\+0x4c> a001 133b 	ceil\.l\.s	\$f0,\$f1
0+2978 <fp_test\+0x50> a3df 133b 	ceil\.l\.s	\$f30,\$f31
0+297c <fp_test\+0x54> a042 133b 	ceil\.l\.s	\$f2,\$f2
0+2980 <fp_test\+0x58> a001 5b3b 	ceil\.w\.d	\$f0,\$f1
0+2984 <fp_test\+0x5c> a3df 5b3b 	ceil\.w\.d	\$f30,\$f31
0+2988 <fp_test\+0x60> a042 5b3b 	ceil\.w\.d	\$f2,\$f2
0+298c <fp_test\+0x64> a001 1b3b 	ceil\.w\.s	\$f0,\$f1
0+2990 <fp_test\+0x68> a3df 1b3b 	ceil\.w\.s	\$f30,\$f31
0+2994 <fp_test\+0x6c> a042 1b3b 	ceil\.w\.s	\$f2,\$f2
0+2998 <fp_test\+0x70> a0a0 103b 	cfc1	a1,\$f0
0+299c <fp_test\+0x74> a0a1 103b 	cfc1	a1,\$f1
0+29a0 <fp_test\+0x78> a0a2 103b 	cfc1	a1,\$f2
0+29a4 <fp_test\+0x7c> a0a3 103b 	cfc1	a1,\$f3
0+29a8 <fp_test\+0x80> a0a4 103b 	cfc1	a1,\$f4
0+29ac <fp_test\+0x84> a0a5 103b 	cfc1	a1,\$f5
0+29b0 <fp_test\+0x88> a0a6 103b 	cfc1	a1,\$f6
0+29b4 <fp_test\+0x8c> a0a7 103b 	cfc1	a1,\$f7
0+29b8 <fp_test\+0x90> a0a8 103b 	cfc1	a1,\$f8
0+29bc <fp_test\+0x94> a0a9 103b 	cfc1	a1,\$f9
0+29c0 <fp_test\+0x98> a0aa 103b 	cfc1	a1,\$f10
0+29c4 <fp_test\+0x9c> a0ab 103b 	cfc1	a1,\$f11
0+29c8 <fp_test\+0xa0> a0ac 103b 	cfc1	a1,\$f12
0+29cc <fp_test\+0xa4> a0ad 103b 	cfc1	a1,\$f13
0+29d0 <fp_test\+0xa8> a0ae 103b 	cfc1	a1,\$f14
0+29d4 <fp_test\+0xac> a0af 103b 	cfc1	a1,\$f15
0+29d8 <fp_test\+0xb0> a0b0 103b 	cfc1	a1,\$f16
0+29dc <fp_test\+0xb4> a0b1 103b 	cfc1	a1,\$f17
0+29e0 <fp_test\+0xb8> a0b2 103b 	cfc1	a1,\$f18
0+29e4 <fp_test\+0xbc> a0b3 103b 	cfc1	a1,\$f19
0+29e8 <fp_test\+0xc0> a0b4 103b 	cfc1	a1,\$f20
0+29ec <fp_test\+0xc4> a0b5 103b 	cfc1	a1,\$f21
0+29f0 <fp_test\+0xc8> a0b6 103b 	cfc1	a1,\$f22
0+29f4 <fp_test\+0xcc> a0b7 103b 	cfc1	a1,\$f23
0+29f8 <fp_test\+0xd0> a0b8 103b 	cfc1	a1,\$f24
0+29fc <fp_test\+0xd4> a0b9 103b 	cfc1	a1,\$f25
0+2a00 <fp_test\+0xd8> a0ba 103b 	cfc1	a1,\$f26
0+2a04 <fp_test\+0xdc> a0bb 103b 	cfc1	a1,\$f27
0+2a08 <fp_test\+0xe0> a0bc 103b 	cfc1	a1,\$f28
0+2a0c <fp_test\+0xe4> a0bd 103b 	cfc1	a1,\$f29
0+2a10 <fp_test\+0xe8> a0be 103b 	cfc1	a1,\$f30
0+2a14 <fp_test\+0xec> a0bf 103b 	cfc1	a1,\$f31
0+2a18 <fp_test\+0xf0> a0a0 103b 	cfc1	a1,\$f0
0+2a1c <fp_test\+0xf4> a0a1 103b 	cfc1	a1,\$f1
0+2a20 <fp_test\+0xf8> a0a2 103b 	cfc1	a1,\$f2
0+2a24 <fp_test\+0xfc> a0a3 103b 	cfc1	a1,\$f3
0+2a28 <fp_test\+0x100> a0a4 103b 	cfc1	a1,\$f4
0+2a2c <fp_test\+0x104> a0a5 103b 	cfc1	a1,\$f5
0+2a30 <fp_test\+0x108> a0a6 103b 	cfc1	a1,\$f6
0+2a34 <fp_test\+0x10c> a0a7 103b 	cfc1	a1,\$f7
0+2a38 <fp_test\+0x110> a0a8 103b 	cfc1	a1,\$f8
0+2a3c <fp_test\+0x114> a0a9 103b 	cfc1	a1,\$f9
0+2a40 <fp_test\+0x118> a0aa 103b 	cfc1	a1,\$f10
0+2a44 <fp_test\+0x11c> a0ab 103b 	cfc1	a1,\$f11
0+2a48 <fp_test\+0x120> a0ac 103b 	cfc1	a1,\$f12
0+2a4c <fp_test\+0x124> a0ad 103b 	cfc1	a1,\$f13
0+2a50 <fp_test\+0x128> a0ae 103b 	cfc1	a1,\$f14
0+2a54 <fp_test\+0x12c> a0af 103b 	cfc1	a1,\$f15
0+2a58 <fp_test\+0x130> a0b0 103b 	cfc1	a1,\$f16
0+2a5c <fp_test\+0x134> a0b1 103b 	cfc1	a1,\$f17
0+2a60 <fp_test\+0x138> a0b2 103b 	cfc1	a1,\$f18
0+2a64 <fp_test\+0x13c> a0b3 103b 	cfc1	a1,\$f19
0+2a68 <fp_test\+0x140> a0b4 103b 	cfc1	a1,\$f20
0+2a6c <fp_test\+0x144> a0b5 103b 	cfc1	a1,\$f21
0+2a70 <fp_test\+0x148> a0b6 103b 	cfc1	a1,\$f22
0+2a74 <fp_test\+0x14c> a0b7 103b 	cfc1	a1,\$f23
0+2a78 <fp_test\+0x150> a0b8 103b 	cfc1	a1,\$f24
0+2a7c <fp_test\+0x154> a0b9 103b 	cfc1	a1,\$f25
0+2a80 <fp_test\+0x158> a0ba 103b 	cfc1	a1,\$f26
0+2a84 <fp_test\+0x15c> a0bb 103b 	cfc1	a1,\$f27
0+2a88 <fp_test\+0x160> a0bc 103b 	cfc1	a1,\$f28
0+2a8c <fp_test\+0x164> a0bd 103b 	cfc1	a1,\$f29
0+2a90 <fp_test\+0x168> a0be 103b 	cfc1	a1,\$f30
0+2a94 <fp_test\+0x16c> a0bf 103b 	cfc1	a1,\$f31
0+2a98 <fp_test\+0x170> 20a0 cd3f 	cfc2	a1,\$0
0+2a9c <fp_test\+0x174> 20a1 cd3f 	cfc2	a1,\$1
0+2aa0 <fp_test\+0x178> 20a2 cd3f 	cfc2	a1,\$2
0+2aa4 <fp_test\+0x17c> 20a3 cd3f 	cfc2	a1,\$3
0+2aa8 <fp_test\+0x180> 20a4 cd3f 	cfc2	a1,\$4
0+2aac <fp_test\+0x184> 20a5 cd3f 	cfc2	a1,\$5
0+2ab0 <fp_test\+0x188> 20a6 cd3f 	cfc2	a1,\$6
0+2ab4 <fp_test\+0x18c> 20a7 cd3f 	cfc2	a1,\$7
0+2ab8 <fp_test\+0x190> 20a8 cd3f 	cfc2	a1,\$8
0+2abc <fp_test\+0x194> 20a9 cd3f 	cfc2	a1,\$9
0+2ac0 <fp_test\+0x198> 20aa cd3f 	cfc2	a1,\$10
0+2ac4 <fp_test\+0x19c> 20ab cd3f 	cfc2	a1,\$11
0+2ac8 <fp_test\+0x1a0> 20ac cd3f 	cfc2	a1,\$12
0+2acc <fp_test\+0x1a4> 20ad cd3f 	cfc2	a1,\$13
0+2ad0 <fp_test\+0x1a8> 20ae cd3f 	cfc2	a1,\$14
0+2ad4 <fp_test\+0x1ac> 20af cd3f 	cfc2	a1,\$15
0+2ad8 <fp_test\+0x1b0> 20b0 cd3f 	cfc2	a1,\$16
0+2adc <fp_test\+0x1b4> 20b1 cd3f 	cfc2	a1,\$17
0+2ae0 <fp_test\+0x1b8> 20b2 cd3f 	cfc2	a1,\$18
0+2ae4 <fp_test\+0x1bc> 20b3 cd3f 	cfc2	a1,\$19
0+2ae8 <fp_test\+0x1c0> 20b4 cd3f 	cfc2	a1,\$20
0+2aec <fp_test\+0x1c4> 20b5 cd3f 	cfc2	a1,\$21
0+2af0 <fp_test\+0x1c8> 20b6 cd3f 	cfc2	a1,\$22
0+2af4 <fp_test\+0x1cc> 20b7 cd3f 	cfc2	a1,\$23
0+2af8 <fp_test\+0x1d0> 20b8 cd3f 	cfc2	a1,\$24
0+2afc <fp_test\+0x1d4> 20b9 cd3f 	cfc2	a1,\$25
0+2b00 <fp_test\+0x1d8> 20ba cd3f 	cfc2	a1,\$26
0+2b04 <fp_test\+0x1dc> 20bb cd3f 	cfc2	a1,\$27
0+2b08 <fp_test\+0x1e0> 20bc cd3f 	cfc2	a1,\$28
0+2b0c <fp_test\+0x1e4> 20bd cd3f 	cfc2	a1,\$29
0+2b10 <fp_test\+0x1e8> 20be cd3f 	cfc2	a1,\$30
0+2b14 <fp_test\+0x1ec> 20bf cd3f 	cfc2	a1,\$31
0+2b18 <fp_test\+0x1f0> a0a0 183b 	ctc1	a1,\$f0
0+2b1c <fp_test\+0x1f4> a0a1 183b 	ctc1	a1,\$f1
0+2b20 <fp_test\+0x1f8> a0a2 183b 	ctc1	a1,\$f2
0+2b24 <fp_test\+0x1fc> a0a3 183b 	ctc1	a1,\$f3
0+2b28 <fp_test\+0x200> a0a4 183b 	ctc1	a1,\$f4
0+2b2c <fp_test\+0x204> a0a5 183b 	ctc1	a1,\$f5
0+2b30 <fp_test\+0x208> a0a6 183b 	ctc1	a1,\$f6
0+2b34 <fp_test\+0x20c> a0a7 183b 	ctc1	a1,\$f7
0+2b38 <fp_test\+0x210> a0a8 183b 	ctc1	a1,\$f8
0+2b3c <fp_test\+0x214> a0a9 183b 	ctc1	a1,\$f9
0+2b40 <fp_test\+0x218> a0aa 183b 	ctc1	a1,\$f10
0+2b44 <fp_test\+0x21c> a0ab 183b 	ctc1	a1,\$f11
0+2b48 <fp_test\+0x220> a0ac 183b 	ctc1	a1,\$f12
0+2b4c <fp_test\+0x224> a0ad 183b 	ctc1	a1,\$f13
0+2b50 <fp_test\+0x228> a0ae 183b 	ctc1	a1,\$f14
0+2b54 <fp_test\+0x22c> a0af 183b 	ctc1	a1,\$f15
0+2b58 <fp_test\+0x230> a0b0 183b 	ctc1	a1,\$f16
0+2b5c <fp_test\+0x234> a0b1 183b 	ctc1	a1,\$f17
0+2b60 <fp_test\+0x238> a0b2 183b 	ctc1	a1,\$f18
0+2b64 <fp_test\+0x23c> a0b3 183b 	ctc1	a1,\$f19
0+2b68 <fp_test\+0x240> a0b4 183b 	ctc1	a1,\$f20
0+2b6c <fp_test\+0x244> a0b5 183b 	ctc1	a1,\$f21
0+2b70 <fp_test\+0x248> a0b6 183b 	ctc1	a1,\$f22
0+2b74 <fp_test\+0x24c> a0b7 183b 	ctc1	a1,\$f23
0+2b78 <fp_test\+0x250> a0b8 183b 	ctc1	a1,\$f24
0+2b7c <fp_test\+0x254> a0b9 183b 	ctc1	a1,\$f25
0+2b80 <fp_test\+0x258> a0ba 183b 	ctc1	a1,\$f26
0+2b84 <fp_test\+0x25c> a0bb 183b 	ctc1	a1,\$f27
0+2b88 <fp_test\+0x260> a0bc 183b 	ctc1	a1,\$f28
0+2b8c <fp_test\+0x264> a0bd 183b 	ctc1	a1,\$f29
0+2b90 <fp_test\+0x268> a0be 183b 	ctc1	a1,\$f30
0+2b94 <fp_test\+0x26c> a0bf 183b 	ctc1	a1,\$f31
0+2b98 <fp_test\+0x270> a0a0 183b 	ctc1	a1,\$f0
0+2b9c <fp_test\+0x274> a0a1 183b 	ctc1	a1,\$f1
0+2ba0 <fp_test\+0x278> a0a2 183b 	ctc1	a1,\$f2
0+2ba4 <fp_test\+0x27c> a0a3 183b 	ctc1	a1,\$f3
0+2ba8 <fp_test\+0x280> a0a4 183b 	ctc1	a1,\$f4
0+2bac <fp_test\+0x284> a0a5 183b 	ctc1	a1,\$f5
0+2bb0 <fp_test\+0x288> a0a6 183b 	ctc1	a1,\$f6
0+2bb4 <fp_test\+0x28c> a0a7 183b 	ctc1	a1,\$f7
0+2bb8 <fp_test\+0x290> a0a8 183b 	ctc1	a1,\$f8
0+2bbc <fp_test\+0x294> a0a9 183b 	ctc1	a1,\$f9
0+2bc0 <fp_test\+0x298> a0aa 183b 	ctc1	a1,\$f10
0+2bc4 <fp_test\+0x29c> a0ab 183b 	ctc1	a1,\$f11
0+2bc8 <fp_test\+0x2a0> a0ac 183b 	ctc1	a1,\$f12
0+2bcc <fp_test\+0x2a4> a0ad 183b 	ctc1	a1,\$f13
0+2bd0 <fp_test\+0x2a8> a0ae 183b 	ctc1	a1,\$f14
0+2bd4 <fp_test\+0x2ac> a0af 183b 	ctc1	a1,\$f15
0+2bd8 <fp_test\+0x2b0> a0b0 183b 	ctc1	a1,\$f16
0+2bdc <fp_test\+0x2b4> a0b1 183b 	ctc1	a1,\$f17
0+2be0 <fp_test\+0x2b8> a0b2 183b 	ctc1	a1,\$f18
0+2be4 <fp_test\+0x2bc> a0b3 183b 	ctc1	a1,\$f19
0+2be8 <fp_test\+0x2c0> a0b4 183b 	ctc1	a1,\$f20
0+2bec <fp_test\+0x2c4> a0b5 183b 	ctc1	a1,\$f21
0+2bf0 <fp_test\+0x2c8> a0b6 183b 	ctc1	a1,\$f22
0+2bf4 <fp_test\+0x2cc> a0b7 183b 	ctc1	a1,\$f23
0+2bf8 <fp_test\+0x2d0> a0b8 183b 	ctc1	a1,\$f24
0+2bfc <fp_test\+0x2d4> a0b9 183b 	ctc1	a1,\$f25
0+2c00 <fp_test\+0x2d8> a0ba 183b 	ctc1	a1,\$f26
0+2c04 <fp_test\+0x2dc> a0bb 183b 	ctc1	a1,\$f27
0+2c08 <fp_test\+0x2e0> a0bc 183b 	ctc1	a1,\$f28
0+2c0c <fp_test\+0x2e4> a0bd 183b 	ctc1	a1,\$f29
0+2c10 <fp_test\+0x2e8> a0be 183b 	ctc1	a1,\$f30
0+2c14 <fp_test\+0x2ec> a0bf 183b 	ctc1	a1,\$f31
0+2c18 <fp_test\+0x2f0> 20a0 dd3f 	ctc2	a1,\$0
0+2c1c <fp_test\+0x2f4> 20a1 dd3f 	ctc2	a1,\$1
0+2c20 <fp_test\+0x2f8> 20a2 dd3f 	ctc2	a1,\$2
0+2c24 <fp_test\+0x2fc> 20a3 dd3f 	ctc2	a1,\$3
0+2c28 <fp_test\+0x300> 20a4 dd3f 	ctc2	a1,\$4
0+2c2c <fp_test\+0x304> 20a5 dd3f 	ctc2	a1,\$5
0+2c30 <fp_test\+0x308> 20a6 dd3f 	ctc2	a1,\$6
0+2c34 <fp_test\+0x30c> 20a7 dd3f 	ctc2	a1,\$7
0+2c38 <fp_test\+0x310> 20a8 dd3f 	ctc2	a1,\$8
0+2c3c <fp_test\+0x314> 20a9 dd3f 	ctc2	a1,\$9
0+2c40 <fp_test\+0x318> 20aa dd3f 	ctc2	a1,\$10
0+2c44 <fp_test\+0x31c> 20ab dd3f 	ctc2	a1,\$11
0+2c48 <fp_test\+0x320> 20ac dd3f 	ctc2	a1,\$12
0+2c4c <fp_test\+0x324> 20ad dd3f 	ctc2	a1,\$13
0+2c50 <fp_test\+0x328> 20ae dd3f 	ctc2	a1,\$14
0+2c54 <fp_test\+0x32c> 20af dd3f 	ctc2	a1,\$15
0+2c58 <fp_test\+0x330> 20b0 dd3f 	ctc2	a1,\$16
0+2c5c <fp_test\+0x334> 20b1 dd3f 	ctc2	a1,\$17
0+2c60 <fp_test\+0x338> 20b2 dd3f 	ctc2	a1,\$18
0+2c64 <fp_test\+0x33c> 20b3 dd3f 	ctc2	a1,\$19
0+2c68 <fp_test\+0x340> 20b4 dd3f 	ctc2	a1,\$20
0+2c6c <fp_test\+0x344> 20b5 dd3f 	ctc2	a1,\$21
0+2c70 <fp_test\+0x348> 20b6 dd3f 	ctc2	a1,\$22
0+2c74 <fp_test\+0x34c> 20b7 dd3f 	ctc2	a1,\$23
0+2c78 <fp_test\+0x350> 20b8 dd3f 	ctc2	a1,\$24
0+2c7c <fp_test\+0x354> 20b9 dd3f 	ctc2	a1,\$25
0+2c80 <fp_test\+0x358> 20ba dd3f 	ctc2	a1,\$26
0+2c84 <fp_test\+0x35c> 20bb dd3f 	ctc2	a1,\$27
0+2c88 <fp_test\+0x360> 20bc dd3f 	ctc2	a1,\$28
0+2c8c <fp_test\+0x364> 20bd dd3f 	ctc2	a1,\$29
0+2c90 <fp_test\+0x368> 20be dd3f 	ctc2	a1,\$30
0+2c94 <fp_test\+0x36c> 20bf dd3f 	ctc2	a1,\$31
0+2c98 <fp_test\+0x370> a001 537b 	cvt\.d\.l	\$f0,\$f1
0+2c9c <fp_test\+0x374> a3df 537b 	cvt\.d\.l	\$f30,\$f31
0+2ca0 <fp_test\+0x378> a042 537b 	cvt\.d\.l	\$f2,\$f2
0+2ca4 <fp_test\+0x37c> a001 137b 	cvt\.d\.s	\$f0,\$f1
0+2ca8 <fp_test\+0x380> a3df 137b 	cvt\.d\.s	\$f30,\$f31
0+2cac <fp_test\+0x384> a042 137b 	cvt\.d\.s	\$f2,\$f2
0+2cb0 <fp_test\+0x388> a001 337b 	cvt\.d\.w	\$f0,\$f1
0+2cb4 <fp_test\+0x38c> a3df 337b 	cvt\.d\.w	\$f30,\$f31
0+2cb8 <fp_test\+0x390> a042 337b 	cvt\.d\.w	\$f2,\$f2
0+2cbc <fp_test\+0x394> a001 013b 	cvt\.l\.s	\$f0,\$f1
0+2cc0 <fp_test\+0x398> a3df 013b 	cvt\.l\.s	\$f30,\$f31
0+2cc4 <fp_test\+0x39c> a042 013b 	cvt\.l\.s	\$f2,\$f2
0+2cc8 <fp_test\+0x3a0> a001 413b 	cvt\.l\.d	\$f0,\$f1
0+2ccc <fp_test\+0x3a4> a3df 413b 	cvt\.l\.d	\$f30,\$f31
0+2cd0 <fp_test\+0x3a8> a042 413b 	cvt\.l\.d	\$f2,\$f2
0+2cd4 <fp_test\+0x3ac> a001 5b7b 	cvt\.s\.l	\$f0,\$f1
0+2cd8 <fp_test\+0x3b0> a3df 5b7b 	cvt\.s\.l	\$f30,\$f31
0+2cdc <fp_test\+0x3b4> a042 5b7b 	cvt\.s\.l	\$f2,\$f2
0+2ce0 <fp_test\+0x3b8> a001 1b7b 	cvt\.s\.d	\$f0,\$f1
0+2ce4 <fp_test\+0x3bc> a3df 1b7b 	cvt\.s\.d	\$f30,\$f31
0+2ce8 <fp_test\+0x3c0> a042 1b7b 	cvt\.s\.d	\$f2,\$f2
0+2cec <fp_test\+0x3c4> a001 3b7b 	cvt\.s\.w	\$f0,\$f1
0+2cf0 <fp_test\+0x3c8> a3df 3b7b 	cvt\.s\.w	\$f30,\$f31
0+2cf4 <fp_test\+0x3cc> a042 3b7b 	cvt\.s\.w	\$f2,\$f2
0+2cf8 <fp_test\+0x3d0> a001 213b 	cvt\.s\.pl	\$f0,\$f1
0+2cfc <fp_test\+0x3d4> a3df 213b 	cvt\.s\.pl	\$f30,\$f31
0+2d00 <fp_test\+0x3d8> a042 213b 	cvt\.s\.pl	\$f2,\$f2
0+2d04 <fp_test\+0x3dc> a001 293b 	cvt\.s\.pu	\$f0,\$f1
0+2d08 <fp_test\+0x3e0> a3df 293b 	cvt\.s\.pu	\$f30,\$f31
0+2d0c <fp_test\+0x3e4> a042 293b 	cvt\.s\.pu	\$f2,\$f2
0+2d10 <fp_test\+0x3e8> a001 093b 	cvt\.w\.s	\$f0,\$f1
0+2d14 <fp_test\+0x3ec> a3df 093b 	cvt\.w\.s	\$f30,\$f31
0+2d18 <fp_test\+0x3f0> a042 093b 	cvt\.w\.s	\$f2,\$f2
0+2d1c <fp_test\+0x3f4> a001 493b 	cvt\.w\.d	\$f0,\$f1
0+2d20 <fp_test\+0x3f8> a3df 493b 	cvt\.w\.d	\$f30,\$f31
0+2d24 <fp_test\+0x3fc> a042 493b 	cvt\.w\.d	\$f2,\$f2
0+2d28 <fp_test\+0x400> a041 01f0 	div\.d	\$f0,\$f1,\$f2
0+2d2c <fp_test\+0x404> a3fe e9f0 	div\.d	\$f29,\$f30,\$f31
0+2d30 <fp_test\+0x408> a3dd e9f0 	div\.d	\$f29,\$f29,\$f30
0+2d34 <fp_test\+0x40c> a3dd e9f0 	div\.d	\$f29,\$f29,\$f30
0+2d38 <fp_test\+0x410> a041 00f0 	div\.s	\$f0,\$f1,\$f2
0+2d3c <fp_test\+0x414> a3fe e8f0 	div\.s	\$f29,\$f30,\$f31
0+2d40 <fp_test\+0x418> a3dd e8f0 	div\.s	\$f29,\$f29,\$f30
0+2d44 <fp_test\+0x41c> a3dd e8f0 	div\.s	\$f29,\$f29,\$f30
0+2d48 <fp_test\+0x420> a001 433b 	floor\.l\.d	\$f0,\$f1
0+2d4c <fp_test\+0x424> a3df 433b 	floor\.l\.d	\$f30,\$f31
0+2d50 <fp_test\+0x428> a042 433b 	floor\.l\.d	\$f2,\$f2
0+2d54 <fp_test\+0x42c> a001 033b 	floor\.l\.s	\$f0,\$f1
0+2d58 <fp_test\+0x430> a3df 033b 	floor\.l\.s	\$f30,\$f31
0+2d5c <fp_test\+0x434> a042 033b 	floor\.l\.s	\$f2,\$f2
0+2d60 <fp_test\+0x438> a001 4b3b 	floor\.w\.d	\$f0,\$f1
0+2d64 <fp_test\+0x43c> a3df 4b3b 	floor\.w\.d	\$f30,\$f31
0+2d68 <fp_test\+0x440> a042 4b3b 	floor\.w\.d	\$f2,\$f2
0+2d6c <fp_test\+0x444> a001 0b3b 	floor\.w\.s	\$f0,\$f1
0+2d70 <fp_test\+0x448> a3df 0b3b 	floor\.w\.s	\$f30,\$f31
0+2d74 <fp_test\+0x44c> a042 0b3b 	floor\.w\.s	\$f2,\$f2
0+2d78 <fp_test\+0x450> 8460 e000 	ldc1	\$f3,0\(zero\)
0+2d7c <fp_test\+0x454> 8460 e000 	ldc1	\$f3,0\(zero\)
0+2d80 <fp_test\+0x458> 8460 e004 	ldc1	\$f3,4\(zero\)
0+2d84 <fp_test\+0x45c> 8460 e004 	ldc1	\$f3,4\(zero\)
0+2d88 <fp_test\+0x460> 8464 e000 	ldc1	\$f3,0\(a0\)
0+2d8c <fp_test\+0x464> 8464 e000 	ldc1	\$f3,0\(a0\)
0+2d90 <fp_test\+0x468> e020 7000 	lui	at,0x7
0+2d94 <fp_test\+0x46c> 2081 0950 	addu	at,at,a0
0+2d98 <fp_test\+0x470> 8461 efff 	ldc1	\$f3,4095\(at\)
0+2d9c <fp_test\+0x474> e03f 8ffd 	lui	at,0xffff8
0+2da0 <fp_test\+0x478> 2081 0950 	addu	at,at,a0
0+2da4 <fp_test\+0x47c> 8461 e000 	ldc1	\$f3,0\(at\)
0+2da8 <fp_test\+0x480> e020 f000 	lui	at,0xf
0+2dac <fp_test\+0x484> 2081 0950 	addu	at,at,a0
0+2db0 <fp_test\+0x488> 8461 efff 	ldc1	\$f3,4095\(at\)
0+2db4 <fp_test\+0x48c> e03f 0ffd 	lui	at,0xffff0
0+2db8 <fp_test\+0x490> 2081 0950 	addu	at,at,a0
0+2dbc <fp_test\+0x494> 8461 e000 	ldc1	\$f3,0\(at\)
0+2dc0 <fp_test\+0x498> e03f 8ffd 	lui	at,0xffff8
0+2dc4 <fp_test\+0x49c> 2081 0950 	addu	at,at,a0
0+2dc8 <fp_test\+0x4a0> 8461 e000 	ldc1	\$f3,0\(at\)
0+2dcc <fp_test\+0x4a4> e03f 0ffd 	lui	at,0xffff0
0+2dd0 <fp_test\+0x4a8> 2081 0950 	addu	at,at,a0
0+2dd4 <fp_test\+0x4ac> 8461 e001 	ldc1	\$f3,1\(at\)
0+2dd8 <fp_test\+0x4b0> e03f 8ffd 	lui	at,0xffff8
0+2ddc <fp_test\+0x4b4> 2081 0950 	addu	at,at,a0
0+2de0 <fp_test\+0x4b8> 8461 e001 	ldc1	\$f3,1\(at\)
0+2de4 <fp_test\+0x4bc> e020 0e01 	lui	at,0xf0000
0+2de8 <fp_test\+0x4c0> 2081 0950 	addu	at,at,a0
0+2dec <fp_test\+0x4c4> 8461 e000 	ldc1	\$f3,0\(at\)
0+2df0 <fp_test\+0x4c8> 0024 9fff 	addiu	at,a0,-1
0+2df4 <fp_test\+0x4cc> 8461 e000 	ldc1	\$f3,0\(at\)
0+2df8 <fp_test\+0x4d0> e034 5244 	lui	at,0x12345
0+2dfc <fp_test\+0x4d4> 2081 0950 	addu	at,at,a0
0+2e00 <fp_test\+0x4d8> 8461 e678 	ldc1	\$f3,1656\(at\)
0+2e04 <fp_test\+0x4dc> 8460 e000 	ldc1	\$f3,0\(zero\)
0+2e08 <fp_test\+0x4e0> 8460 e000 	ldc1	\$f3,0\(zero\)
0+2e0c <fp_test\+0x4e4> 8460 e004 	ldc1	\$f3,4\(zero\)
0+2e10 <fp_test\+0x4e8> 8460 e004 	ldc1	\$f3,4\(zero\)
0+2e14 <fp_test\+0x4ec> 8464 e000 	ldc1	\$f3,0\(a0\)
0+2e18 <fp_test\+0x4f0> 8464 e000 	ldc1	\$f3,0\(a0\)
0+2e1c <fp_test\+0x4f4> e020 7000 	lui	at,0x7
0+2e20 <fp_test\+0x4f8> 2081 0950 	addu	at,at,a0
0+2e24 <fp_test\+0x4fc> 8461 efff 	ldc1	\$f3,4095\(at\)
0+2e28 <fp_test\+0x500> e03f 8ffd 	lui	at,0xffff8
0+2e2c <fp_test\+0x504> 2081 0950 	addu	at,at,a0
0+2e30 <fp_test\+0x508> 8461 e000 	ldc1	\$f3,0\(at\)
0+2e34 <fp_test\+0x50c> e020 f000 	lui	at,0xf
0+2e38 <fp_test\+0x510> 2081 0950 	addu	at,at,a0
0+2e3c <fp_test\+0x514> 8461 efff 	ldc1	\$f3,4095\(at\)
0+2e40 <fp_test\+0x518> e03f 0ffd 	lui	at,0xffff0
0+2e44 <fp_test\+0x51c> 2081 0950 	addu	at,at,a0
0+2e48 <fp_test\+0x520> 8461 e000 	ldc1	\$f3,0\(at\)
0+2e4c <fp_test\+0x524> e03f 8ffd 	lui	at,0xffff8
0+2e50 <fp_test\+0x528> 2081 0950 	addu	at,at,a0
0+2e54 <fp_test\+0x52c> 8461 e000 	ldc1	\$f3,0\(at\)
0+2e58 <fp_test\+0x530> e03f 0ffd 	lui	at,0xffff0
0+2e5c <fp_test\+0x534> 2081 0950 	addu	at,at,a0
0+2e60 <fp_test\+0x538> 8461 e001 	ldc1	\$f3,1\(at\)
0+2e64 <fp_test\+0x53c> e03f 8ffd 	lui	at,0xffff8
0+2e68 <fp_test\+0x540> 2081 0950 	addu	at,at,a0
0+2e6c <fp_test\+0x544> 8461 e001 	ldc1	\$f3,1\(at\)
0+2e70 <fp_test\+0x548> e020 0e01 	lui	at,0xf0000
0+2e74 <fp_test\+0x54c> 2081 0950 	addu	at,at,a0
0+2e78 <fp_test\+0x550> 8461 e000 	ldc1	\$f3,0\(at\)
0+2e7c <fp_test\+0x554> 0024 9fff 	addiu	at,a0,-1
0+2e80 <fp_test\+0x558> 8461 e000 	ldc1	\$f3,0\(at\)
0+2e84 <fp_test\+0x55c> e034 5244 	lui	at,0x12345
0+2e88 <fp_test\+0x560> 2081 0950 	addu	at,at,a0
0+2e8c <fp_test\+0x564> 8461 e678 	ldc1	\$f3,1656\(at\)
0+2e90 <fp_test\+0x568> 8460 e000 	ldc1	\$f3,0\(zero\)
0+2e94 <fp_test\+0x56c> 8460 e000 	ldc1	\$f3,0\(zero\)
0+2e98 <fp_test\+0x570> 8460 e004 	ldc1	\$f3,4\(zero\)
0+2e9c <fp_test\+0x574> 8460 e004 	ldc1	\$f3,4\(zero\)
0+2ea0 <fp_test\+0x578> 8464 e000 	ldc1	\$f3,0\(a0\)
0+2ea4 <fp_test\+0x57c> 8464 e000 	ldc1	\$f3,0\(a0\)
0+2ea8 <fp_test\+0x580> e020 7000 	lui	at,0x7
0+2eac <fp_test\+0x584> 2081 0950 	addu	at,at,a0
0+2eb0 <fp_test\+0x588> 8461 efff 	ldc1	\$f3,4095\(at\)
0+2eb4 <fp_test\+0x58c> e03f 8ffd 	lui	at,0xffff8
0+2eb8 <fp_test\+0x590> 2081 0950 	addu	at,at,a0
0+2ebc <fp_test\+0x594> 8461 e000 	ldc1	\$f3,0\(at\)
0+2ec0 <fp_test\+0x598> 2000 0707 	ldc1x	\$f0,zero\(zero\)
0+2ec4 <fp_test\+0x59c> 2040 0707 	ldc1x	\$f0,zero\(v0\)
0+2ec8 <fp_test\+0x5a0> 23e0 0707 	ldc1x	\$f0,zero\(ra\)
0+2ecc <fp_test\+0x5a4> 23e2 0707 	ldc1x	\$f0,v0\(ra\)
0+2ed0 <fp_test\+0x5a8> 23ff 0707 	ldc1x	\$f0,ra\(ra\)
0+2ed4 <fp_test\+0x5ac> 23ff 0f07 	ldc1x	\$f1,ra\(ra\)
0+2ed8 <fp_test\+0x5b0> 23ff 1707 	ldc1x	\$f2,ra\(ra\)
0+2edc <fp_test\+0x5b4> 23ff ff07 	ldc1x	\$f31,ra\(ra\)
0+2ee0 <fp_test\+0x5b8> 8460 a000 	lwc1	\$f3,0\(zero\)
0+2ee4 <fp_test\+0x5bc> 8460 a000 	lwc1	\$f3,0\(zero\)
0+2ee8 <fp_test\+0x5c0> 8460 a004 	lwc1	\$f3,4\(zero\)
0+2eec <fp_test\+0x5c4> 8460 a004 	lwc1	\$f3,4\(zero\)
0+2ef0 <fp_test\+0x5c8> 8464 a000 	lwc1	\$f3,0\(a0\)
0+2ef4 <fp_test\+0x5cc> 8464 a000 	lwc1	\$f3,0\(a0\)
0+2ef8 <fp_test\+0x5d0> e020 7000 	lui	at,0x7
0+2efc <fp_test\+0x5d4> 2081 0950 	addu	at,at,a0
0+2f00 <fp_test\+0x5d8> 8461 afff 	lwc1	\$f3,4095\(at\)
0+2f04 <fp_test\+0x5dc> e03f 8ffd 	lui	at,0xffff8
0+2f08 <fp_test\+0x5e0> 2081 0950 	addu	at,at,a0
0+2f0c <fp_test\+0x5e4> 8461 a000 	lwc1	\$f3,0\(at\)
0+2f10 <fp_test\+0x5e8> e020 f000 	lui	at,0xf
0+2f14 <fp_test\+0x5ec> 2081 0950 	addu	at,at,a0
0+2f18 <fp_test\+0x5f0> 8461 afff 	lwc1	\$f3,4095\(at\)
0+2f1c <fp_test\+0x5f4> e03f 0ffd 	lui	at,0xffff0
0+2f20 <fp_test\+0x5f8> 2081 0950 	addu	at,at,a0
0+2f24 <fp_test\+0x5fc> 8461 a000 	lwc1	\$f3,0\(at\)
0+2f28 <fp_test\+0x600> e03f 8ffd 	lui	at,0xffff8
0+2f2c <fp_test\+0x604> 2081 0950 	addu	at,at,a0
0+2f30 <fp_test\+0x608> 8461 a000 	lwc1	\$f3,0\(at\)
0+2f34 <fp_test\+0x60c> e03f 0ffd 	lui	at,0xffff0
0+2f38 <fp_test\+0x610> 2081 0950 	addu	at,at,a0
0+2f3c <fp_test\+0x614> 8461 a001 	lwc1	\$f3,1\(at\)
0+2f40 <fp_test\+0x618> e03f 8ffd 	lui	at,0xffff8
0+2f44 <fp_test\+0x61c> 2081 0950 	addu	at,at,a0
0+2f48 <fp_test\+0x620> 8461 a001 	lwc1	\$f3,1\(at\)
0+2f4c <fp_test\+0x624> e020 0e01 	lui	at,0xf0000
0+2f50 <fp_test\+0x628> 2081 0950 	addu	at,at,a0
0+2f54 <fp_test\+0x62c> 8461 a000 	lwc1	\$f3,0\(at\)
0+2f58 <fp_test\+0x630> 0024 9fff 	addiu	at,a0,-1
0+2f5c <fp_test\+0x634> 8461 a000 	lwc1	\$f3,0\(at\)
0+2f60 <fp_test\+0x638> e034 5244 	lui	at,0x12345
0+2f64 <fp_test\+0x63c> 2081 0950 	addu	at,at,a0
0+2f68 <fp_test\+0x640> 8461 a678 	lwc1	\$f3,1656\(at\)
0+2f6c <fp_test\+0x644> 8460 a000 	lwc1	\$f3,0\(zero\)
0+2f70 <fp_test\+0x648> 8460 a000 	lwc1	\$f3,0\(zero\)
0+2f74 <fp_test\+0x64c> 8460 a004 	lwc1	\$f3,4\(zero\)
0+2f78 <fp_test\+0x650> 8460 a004 	lwc1	\$f3,4\(zero\)
0+2f7c <fp_test\+0x654> 8464 a000 	lwc1	\$f3,0\(a0\)
0+2f80 <fp_test\+0x658> 8464 a000 	lwc1	\$f3,0\(a0\)
0+2f84 <fp_test\+0x65c> e020 7000 	lui	at,0x7
0+2f88 <fp_test\+0x660> 2081 0950 	addu	at,at,a0
0+2f8c <fp_test\+0x664> 8461 afff 	lwc1	\$f3,4095\(at\)
0+2f90 <fp_test\+0x668> e03f 8ffd 	lui	at,0xffff8
0+2f94 <fp_test\+0x66c> 2081 0950 	addu	at,at,a0
0+2f98 <fp_test\+0x670> 8461 a000 	lwc1	\$f3,0\(at\)
0+2f9c <fp_test\+0x674> e020 f000 	lui	at,0xf
0+2fa0 <fp_test\+0x678> 2081 0950 	addu	at,at,a0
0+2fa4 <fp_test\+0x67c> 8461 afff 	lwc1	\$f3,4095\(at\)
0+2fa8 <fp_test\+0x680> e03f 0ffd 	lui	at,0xffff0
0+2fac <fp_test\+0x684> 2081 0950 	addu	at,at,a0
0+2fb0 <fp_test\+0x688> 8461 a000 	lwc1	\$f3,0\(at\)
0+2fb4 <fp_test\+0x68c> e03f 8ffd 	lui	at,0xffff8
0+2fb8 <fp_test\+0x690> 2081 0950 	addu	at,at,a0
0+2fbc <fp_test\+0x694> 8461 a000 	lwc1	\$f3,0\(at\)
0+2fc0 <fp_test\+0x698> e03f 0ffd 	lui	at,0xffff0
0+2fc4 <fp_test\+0x69c> 2081 0950 	addu	at,at,a0
0+2fc8 <fp_test\+0x6a0> 8461 a001 	lwc1	\$f3,1\(at\)
0+2fcc <fp_test\+0x6a4> e03f 8ffd 	lui	at,0xffff8
0+2fd0 <fp_test\+0x6a8> 2081 0950 	addu	at,at,a0
0+2fd4 <fp_test\+0x6ac> 8461 a001 	lwc1	\$f3,1\(at\)
0+2fd8 <fp_test\+0x6b0> e020 0e01 	lui	at,0xf0000
0+2fdc <fp_test\+0x6b4> 2081 0950 	addu	at,at,a0
0+2fe0 <fp_test\+0x6b8> 8461 a000 	lwc1	\$f3,0\(at\)
0+2fe4 <fp_test\+0x6bc> 0024 9fff 	addiu	at,a0,-1
0+2fe8 <fp_test\+0x6c0> 8461 a000 	lwc1	\$f3,0\(at\)
0+2fec <fp_test\+0x6c4> e034 5244 	lui	at,0x12345
0+2ff0 <fp_test\+0x6c8> 2081 0950 	addu	at,at,a0
0+2ff4 <fp_test\+0x6cc> 8461 a678 	lwc1	\$f3,1656\(at\)
0+2ff8 <fp_test\+0x6d0> 8460 a000 	lwc1	\$f3,0\(zero\)
0+2ffc <fp_test\+0x6d4> 8460 a000 	lwc1	\$f3,0\(zero\)
0+3000 <fp_test\+0x6d8> 8460 a004 	lwc1	\$f3,4\(zero\)
0+3004 <fp_test\+0x6dc> 8460 a004 	lwc1	\$f3,4\(zero\)
0+3008 <fp_test\+0x6e0> 8464 a000 	lwc1	\$f3,0\(a0\)
0+300c <fp_test\+0x6e4> 8464 a000 	lwc1	\$f3,0\(a0\)
0+3010 <fp_test\+0x6e8> e020 7000 	lui	at,0x7
0+3014 <fp_test\+0x6ec> 2081 0950 	addu	at,at,a0
0+3018 <fp_test\+0x6f0> 8461 afff 	lwc1	\$f3,4095\(at\)
0+301c <fp_test\+0x6f4> e03f 8ffd 	lui	at,0xffff8
0+3020 <fp_test\+0x6f8> 2081 0950 	addu	at,at,a0
0+3024 <fp_test\+0x6fc> 8461 a000 	lwc1	\$f3,0\(at\)
0+3028 <fp_test\+0x700> e020 f000 	lui	at,0xf
0+302c <fp_test\+0x704> 2081 0950 	addu	at,at,a0
0+3030 <fp_test\+0x708> 8461 afff 	lwc1	\$f3,4095\(at\)
0+3034 <fp_test\+0x70c> e03f 0ffd 	lui	at,0xffff0
0+3038 <fp_test\+0x710> 2081 0950 	addu	at,at,a0
0+303c <fp_test\+0x714> 8461 a000 	lwc1	\$f3,0\(at\)
0+3040 <fp_test\+0x718> e03f 8ffd 	lui	at,0xffff8
0+3044 <fp_test\+0x71c> 2081 0950 	addu	at,at,a0
0+3048 <fp_test\+0x720> 8461 a000 	lwc1	\$f3,0\(at\)
0+304c <fp_test\+0x724> e03f 0ffd 	lui	at,0xffff0
0+3050 <fp_test\+0x728> 2081 0950 	addu	at,at,a0
0+3054 <fp_test\+0x72c> 8461 a001 	lwc1	\$f3,1\(at\)
0+3058 <fp_test\+0x730> e03f 8ffd 	lui	at,0xffff8
0+305c <fp_test\+0x734> 2081 0950 	addu	at,at,a0
0+3060 <fp_test\+0x738> 8461 a001 	lwc1	\$f3,1\(at\)
0+3064 <fp_test\+0x73c> e020 0e01 	lui	at,0xf0000
0+3068 <fp_test\+0x740> 2081 0950 	addu	at,at,a0
0+306c <fp_test\+0x744> 8461 a000 	lwc1	\$f3,0\(at\)
0+3070 <fp_test\+0x748> 0024 9fff 	addiu	at,a0,-1
0+3074 <fp_test\+0x74c> 8461 a000 	lwc1	\$f3,0\(at\)
0+3078 <fp_test\+0x750> e034 5244 	lui	at,0x12345
0+307c <fp_test\+0x754> 2081 0950 	addu	at,at,a0
0+3080 <fp_test\+0x758> 8461 a678 	lwc1	\$f3,1656\(at\)
0+3084 <fp_test\+0x75c> 2000 0507 	lwc1x	\$f0,zero\(zero\)
0+3088 <fp_test\+0x760> 2040 0507 	lwc1x	\$f0,zero\(v0\)
0+308c <fp_test\+0x764> 23e0 0507 	lwc1x	\$f0,zero\(ra\)
0+3090 <fp_test\+0x768> 23e2 0507 	lwc1x	\$f0,v0\(ra\)
0+3094 <fp_test\+0x76c> 23ff 0507 	lwc1x	\$f0,ra\(ra\)
0+3098 <fp_test\+0x770> 23ff 0d07 	lwc1x	\$f1,ra\(ra\)
0+309c <fp_test\+0x774> 23ff 1507 	lwc1x	\$f2,ra\(ra\)
0+30a0 <fp_test\+0x778> 23ff fd07 	lwc1x	\$f31,ra\(ra\)
0+30a4 <fp_test\+0x77c> a0a0 203b 	mfc1	a1,\$f0
0+30a8 <fp_test\+0x780> a0a1 203b 	mfc1	a1,\$f1
0+30ac <fp_test\+0x784> a0a2 203b 	mfc1	a1,\$f2
0+30b0 <fp_test\+0x788> a0a3 203b 	mfc1	a1,\$f3
0+30b4 <fp_test\+0x78c> a0a4 203b 	mfc1	a1,\$f4
0+30b8 <fp_test\+0x790> a0a5 203b 	mfc1	a1,\$f5
0+30bc <fp_test\+0x794> a0a6 203b 	mfc1	a1,\$f6
0+30c0 <fp_test\+0x798> a0a7 203b 	mfc1	a1,\$f7
0+30c4 <fp_test\+0x79c> a0a8 203b 	mfc1	a1,\$f8
0+30c8 <fp_test\+0x7a0> a0a9 203b 	mfc1	a1,\$f9
0+30cc <fp_test\+0x7a4> a0aa 203b 	mfc1	a1,\$f10
0+30d0 <fp_test\+0x7a8> a0ab 203b 	mfc1	a1,\$f11
0+30d4 <fp_test\+0x7ac> a0ac 203b 	mfc1	a1,\$f12
0+30d8 <fp_test\+0x7b0> a0ad 203b 	mfc1	a1,\$f13
0+30dc <fp_test\+0x7b4> a0ae 203b 	mfc1	a1,\$f14
0+30e0 <fp_test\+0x7b8> a0af 203b 	mfc1	a1,\$f15
0+30e4 <fp_test\+0x7bc> a0b0 203b 	mfc1	a1,\$f16
0+30e8 <fp_test\+0x7c0> a0b1 203b 	mfc1	a1,\$f17
0+30ec <fp_test\+0x7c4> a0b2 203b 	mfc1	a1,\$f18
0+30f0 <fp_test\+0x7c8> a0b3 203b 	mfc1	a1,\$f19
0+30f4 <fp_test\+0x7cc> a0b4 203b 	mfc1	a1,\$f20
0+30f8 <fp_test\+0x7d0> a0b5 203b 	mfc1	a1,\$f21
0+30fc <fp_test\+0x7d4> a0b6 203b 	mfc1	a1,\$f22
0+3100 <fp_test\+0x7d8> a0b7 203b 	mfc1	a1,\$f23
0+3104 <fp_test\+0x7dc> a0b8 203b 	mfc1	a1,\$f24
0+3108 <fp_test\+0x7e0> a0b9 203b 	mfc1	a1,\$f25
0+310c <fp_test\+0x7e4> a0ba 203b 	mfc1	a1,\$f26
0+3110 <fp_test\+0x7e8> a0bb 203b 	mfc1	a1,\$f27
0+3114 <fp_test\+0x7ec> a0bc 203b 	mfc1	a1,\$f28
0+3118 <fp_test\+0x7f0> a0bd 203b 	mfc1	a1,\$f29
0+311c <fp_test\+0x7f4> a0be 203b 	mfc1	a1,\$f30
0+3120 <fp_test\+0x7f8> a0bf 203b 	mfc1	a1,\$f31
0+3124 <fp_test\+0x7fc> a0a0 203b 	mfc1	a1,\$f0
0+3128 <fp_test\+0x800> a0a1 203b 	mfc1	a1,\$f1
0+312c <fp_test\+0x804> a0a2 203b 	mfc1	a1,\$f2
0+3130 <fp_test\+0x808> a0a3 203b 	mfc1	a1,\$f3
0+3134 <fp_test\+0x80c> a0a4 203b 	mfc1	a1,\$f4
0+3138 <fp_test\+0x810> a0a5 203b 	mfc1	a1,\$f5
0+313c <fp_test\+0x814> a0a6 203b 	mfc1	a1,\$f6
0+3140 <fp_test\+0x818> a0a7 203b 	mfc1	a1,\$f7
0+3144 <fp_test\+0x81c> a0a8 203b 	mfc1	a1,\$f8
0+3148 <fp_test\+0x820> a0a9 203b 	mfc1	a1,\$f9
0+314c <fp_test\+0x824> a0aa 203b 	mfc1	a1,\$f10
0+3150 <fp_test\+0x828> a0ab 203b 	mfc1	a1,\$f11
0+3154 <fp_test\+0x82c> a0ac 203b 	mfc1	a1,\$f12
0+3158 <fp_test\+0x830> a0ad 203b 	mfc1	a1,\$f13
0+315c <fp_test\+0x834> a0ae 203b 	mfc1	a1,\$f14
0+3160 <fp_test\+0x838> a0af 203b 	mfc1	a1,\$f15
0+3164 <fp_test\+0x83c> a0b0 203b 	mfc1	a1,\$f16
0+3168 <fp_test\+0x840> a0b1 203b 	mfc1	a1,\$f17
0+316c <fp_test\+0x844> a0b2 203b 	mfc1	a1,\$f18
0+3170 <fp_test\+0x848> a0b3 203b 	mfc1	a1,\$f19
0+3174 <fp_test\+0x84c> a0b4 203b 	mfc1	a1,\$f20
0+3178 <fp_test\+0x850> a0b5 203b 	mfc1	a1,\$f21
0+317c <fp_test\+0x854> a0b6 203b 	mfc1	a1,\$f22
0+3180 <fp_test\+0x858> a0b7 203b 	mfc1	a1,\$f23
0+3184 <fp_test\+0x85c> a0b8 203b 	mfc1	a1,\$f24
0+3188 <fp_test\+0x860> a0b9 203b 	mfc1	a1,\$f25
0+318c <fp_test\+0x864> a0ba 203b 	mfc1	a1,\$f26
0+3190 <fp_test\+0x868> a0bb 203b 	mfc1	a1,\$f27
0+3194 <fp_test\+0x86c> a0bc 203b 	mfc1	a1,\$f28
0+3198 <fp_test\+0x870> a0bd 203b 	mfc1	a1,\$f29
0+319c <fp_test\+0x874> a0be 203b 	mfc1	a1,\$f30
0+31a0 <fp_test\+0x878> a0bf 203b 	mfc1	a1,\$f31
0+31a4 <fp_test\+0x87c> a0a0 303b 	mfhc1	a1,\$f0
0+31a8 <fp_test\+0x880> a0a1 303b 	mfhc1	a1,\$f1
0+31ac <fp_test\+0x884> a0a2 303b 	mfhc1	a1,\$f2
0+31b0 <fp_test\+0x888> a0a3 303b 	mfhc1	a1,\$f3
0+31b4 <fp_test\+0x88c> a0a4 303b 	mfhc1	a1,\$f4
0+31b8 <fp_test\+0x890> a0a5 303b 	mfhc1	a1,\$f5
0+31bc <fp_test\+0x894> a0a6 303b 	mfhc1	a1,\$f6
0+31c0 <fp_test\+0x898> a0a7 303b 	mfhc1	a1,\$f7
0+31c4 <fp_test\+0x89c> a0a8 303b 	mfhc1	a1,\$f8
0+31c8 <fp_test\+0x8a0> a0a9 303b 	mfhc1	a1,\$f9
0+31cc <fp_test\+0x8a4> a0aa 303b 	mfhc1	a1,\$f10
0+31d0 <fp_test\+0x8a8> a0ab 303b 	mfhc1	a1,\$f11
0+31d4 <fp_test\+0x8ac> a0ac 303b 	mfhc1	a1,\$f12
0+31d8 <fp_test\+0x8b0> a0ad 303b 	mfhc1	a1,\$f13
0+31dc <fp_test\+0x8b4> a0ae 303b 	mfhc1	a1,\$f14
0+31e0 <fp_test\+0x8b8> a0af 303b 	mfhc1	a1,\$f15
0+31e4 <fp_test\+0x8bc> a0b0 303b 	mfhc1	a1,\$f16
0+31e8 <fp_test\+0x8c0> a0b1 303b 	mfhc1	a1,\$f17
0+31ec <fp_test\+0x8c4> a0b2 303b 	mfhc1	a1,\$f18
0+31f0 <fp_test\+0x8c8> a0b3 303b 	mfhc1	a1,\$f19
0+31f4 <fp_test\+0x8cc> a0b4 303b 	mfhc1	a1,\$f20
0+31f8 <fp_test\+0x8d0> a0b5 303b 	mfhc1	a1,\$f21
0+31fc <fp_test\+0x8d4> a0b6 303b 	mfhc1	a1,\$f22
0+3200 <fp_test\+0x8d8> a0b7 303b 	mfhc1	a1,\$f23
0+3204 <fp_test\+0x8dc> a0b8 303b 	mfhc1	a1,\$f24
0+3208 <fp_test\+0x8e0> a0b9 303b 	mfhc1	a1,\$f25
0+320c <fp_test\+0x8e4> a0ba 303b 	mfhc1	a1,\$f26
0+3210 <fp_test\+0x8e8> a0bb 303b 	mfhc1	a1,\$f27
0+3214 <fp_test\+0x8ec> a0bc 303b 	mfhc1	a1,\$f28
0+3218 <fp_test\+0x8f0> a0bd 303b 	mfhc1	a1,\$f29
0+321c <fp_test\+0x8f4> a0be 303b 	mfhc1	a1,\$f30
0+3220 <fp_test\+0x8f8> a0bf 303b 	mfhc1	a1,\$f31
0+3224 <fp_test\+0x8fc> a0a0 303b 	mfhc1	a1,\$f0
0+3228 <fp_test\+0x900> a0a1 303b 	mfhc1	a1,\$f1
0+322c <fp_test\+0x904> a0a2 303b 	mfhc1	a1,\$f2
0+3230 <fp_test\+0x908> a0a3 303b 	mfhc1	a1,\$f3
0+3234 <fp_test\+0x90c> a0a4 303b 	mfhc1	a1,\$f4
0+3238 <fp_test\+0x910> a0a5 303b 	mfhc1	a1,\$f5
0+323c <fp_test\+0x914> a0a6 303b 	mfhc1	a1,\$f6
0+3240 <fp_test\+0x918> a0a7 303b 	mfhc1	a1,\$f7
0+3244 <fp_test\+0x91c> a0a8 303b 	mfhc1	a1,\$f8
0+3248 <fp_test\+0x920> a0a9 303b 	mfhc1	a1,\$f9
0+324c <fp_test\+0x924> a0aa 303b 	mfhc1	a1,\$f10
0+3250 <fp_test\+0x928> a0ab 303b 	mfhc1	a1,\$f11
0+3254 <fp_test\+0x92c> a0ac 303b 	mfhc1	a1,\$f12
0+3258 <fp_test\+0x930> a0ad 303b 	mfhc1	a1,\$f13
0+325c <fp_test\+0x934> a0ae 303b 	mfhc1	a1,\$f14
0+3260 <fp_test\+0x938> a0af 303b 	mfhc1	a1,\$f15
0+3264 <fp_test\+0x93c> a0b0 303b 	mfhc1	a1,\$f16
0+3268 <fp_test\+0x940> a0b1 303b 	mfhc1	a1,\$f17
0+326c <fp_test\+0x944> a0b2 303b 	mfhc1	a1,\$f18
0+3270 <fp_test\+0x948> a0b3 303b 	mfhc1	a1,\$f19
0+3274 <fp_test\+0x94c> a0b4 303b 	mfhc1	a1,\$f20
0+3278 <fp_test\+0x950> a0b5 303b 	mfhc1	a1,\$f21
0+327c <fp_test\+0x954> a0b6 303b 	mfhc1	a1,\$f22
0+3280 <fp_test\+0x958> a0b7 303b 	mfhc1	a1,\$f23
0+3284 <fp_test\+0x95c> a0b8 303b 	mfhc1	a1,\$f24
0+3288 <fp_test\+0x960> a0b9 303b 	mfhc1	a1,\$f25
0+328c <fp_test\+0x964> a0ba 303b 	mfhc1	a1,\$f26
0+3290 <fp_test\+0x968> a0bb 303b 	mfhc1	a1,\$f27
0+3294 <fp_test\+0x96c> a0bc 303b 	mfhc1	a1,\$f28
0+3298 <fp_test\+0x970> a0bd 303b 	mfhc1	a1,\$f29
0+329c <fp_test\+0x974> a0be 303b 	mfhc1	a1,\$f30
0+32a0 <fp_test\+0x978> a0bf 303b 	mfhc1	a1,\$f31
0+32a4 <fp_test\+0x97c> a001 207b 	mov\.d	\$f0,\$f1
0+32a8 <fp_test\+0x980> a3df 207b 	mov\.d	\$f30,\$f31
0+32ac <fp_test\+0x984> a001 007b 	mov\.s	\$f0,\$f1
0+32b0 <fp_test\+0x988> a3df 007b 	mov\.s	\$f30,\$f31
0+32b4 <fp_test\+0x98c> a0a0 283b 	mtc1	a1,\$f0
0+32b8 <fp_test\+0x990> a0a1 283b 	mtc1	a1,\$f1
0+32bc <fp_test\+0x994> a0a2 283b 	mtc1	a1,\$f2
0+32c0 <fp_test\+0x998> a0a3 283b 	mtc1	a1,\$f3
0+32c4 <fp_test\+0x99c> a0a4 283b 	mtc1	a1,\$f4
0+32c8 <fp_test\+0x9a0> a0a5 283b 	mtc1	a1,\$f5
0+32cc <fp_test\+0x9a4> a0a6 283b 	mtc1	a1,\$f6
0+32d0 <fp_test\+0x9a8> a0a7 283b 	mtc1	a1,\$f7
0+32d4 <fp_test\+0x9ac> a0a8 283b 	mtc1	a1,\$f8
0+32d8 <fp_test\+0x9b0> a0a9 283b 	mtc1	a1,\$f9
0+32dc <fp_test\+0x9b4> a0aa 283b 	mtc1	a1,\$f10
0+32e0 <fp_test\+0x9b8> a0ab 283b 	mtc1	a1,\$f11
0+32e4 <fp_test\+0x9bc> a0ac 283b 	mtc1	a1,\$f12
0+32e8 <fp_test\+0x9c0> a0ad 283b 	mtc1	a1,\$f13
0+32ec <fp_test\+0x9c4> a0ae 283b 	mtc1	a1,\$f14
0+32f0 <fp_test\+0x9c8> a0af 283b 	mtc1	a1,\$f15
0+32f4 <fp_test\+0x9cc> a0b0 283b 	mtc1	a1,\$f16
0+32f8 <fp_test\+0x9d0> a0b1 283b 	mtc1	a1,\$f17
0+32fc <fp_test\+0x9d4> a0b2 283b 	mtc1	a1,\$f18
0+3300 <fp_test\+0x9d8> a0b3 283b 	mtc1	a1,\$f19
0+3304 <fp_test\+0x9dc> a0b4 283b 	mtc1	a1,\$f20
0+3308 <fp_test\+0x9e0> a0b5 283b 	mtc1	a1,\$f21
0+330c <fp_test\+0x9e4> a0b6 283b 	mtc1	a1,\$f22
0+3310 <fp_test\+0x9e8> a0b7 283b 	mtc1	a1,\$f23
0+3314 <fp_test\+0x9ec> a0b8 283b 	mtc1	a1,\$f24
0+3318 <fp_test\+0x9f0> a0b9 283b 	mtc1	a1,\$f25
0+331c <fp_test\+0x9f4> a0ba 283b 	mtc1	a1,\$f26
0+3320 <fp_test\+0x9f8> a0bb 283b 	mtc1	a1,\$f27
0+3324 <fp_test\+0x9fc> a0bc 283b 	mtc1	a1,\$f28
0+3328 <fp_test\+0xa00> a0bd 283b 	mtc1	a1,\$f29
0+332c <fp_test\+0xa04> a0be 283b 	mtc1	a1,\$f30
0+3330 <fp_test\+0xa08> a0bf 283b 	mtc1	a1,\$f31
0+3334 <fp_test\+0xa0c> a0a0 283b 	mtc1	a1,\$f0
0+3338 <fp_test\+0xa10> a0a1 283b 	mtc1	a1,\$f1
0+333c <fp_test\+0xa14> a0a2 283b 	mtc1	a1,\$f2
0+3340 <fp_test\+0xa18> a0a3 283b 	mtc1	a1,\$f3
0+3344 <fp_test\+0xa1c> a0a4 283b 	mtc1	a1,\$f4
0+3348 <fp_test\+0xa20> a0a5 283b 	mtc1	a1,\$f5
0+334c <fp_test\+0xa24> a0a6 283b 	mtc1	a1,\$f6
0+3350 <fp_test\+0xa28> a0a7 283b 	mtc1	a1,\$f7
0+3354 <fp_test\+0xa2c> a0a8 283b 	mtc1	a1,\$f8
0+3358 <fp_test\+0xa30> a0a9 283b 	mtc1	a1,\$f9
0+335c <fp_test\+0xa34> a0aa 283b 	mtc1	a1,\$f10
0+3360 <fp_test\+0xa38> a0ab 283b 	mtc1	a1,\$f11
0+3364 <fp_test\+0xa3c> a0ac 283b 	mtc1	a1,\$f12
0+3368 <fp_test\+0xa40> a0ad 283b 	mtc1	a1,\$f13
0+336c <fp_test\+0xa44> a0ae 283b 	mtc1	a1,\$f14
0+3370 <fp_test\+0xa48> a0af 283b 	mtc1	a1,\$f15
0+3374 <fp_test\+0xa4c> a0b0 283b 	mtc1	a1,\$f16
0+3378 <fp_test\+0xa50> a0b1 283b 	mtc1	a1,\$f17
0+337c <fp_test\+0xa54> a0b2 283b 	mtc1	a1,\$f18
0+3380 <fp_test\+0xa58> a0b3 283b 	mtc1	a1,\$f19
0+3384 <fp_test\+0xa5c> a0b4 283b 	mtc1	a1,\$f20
0+3388 <fp_test\+0xa60> a0b5 283b 	mtc1	a1,\$f21
0+338c <fp_test\+0xa64> a0b6 283b 	mtc1	a1,\$f22
0+3390 <fp_test\+0xa68> a0b7 283b 	mtc1	a1,\$f23
0+3394 <fp_test\+0xa6c> a0b8 283b 	mtc1	a1,\$f24
0+3398 <fp_test\+0xa70> a0b9 283b 	mtc1	a1,\$f25
0+339c <fp_test\+0xa74> a0ba 283b 	mtc1	a1,\$f26
0+33a0 <fp_test\+0xa78> a0bb 283b 	mtc1	a1,\$f27
0+33a4 <fp_test\+0xa7c> a0bc 283b 	mtc1	a1,\$f28
0+33a8 <fp_test\+0xa80> a0bd 283b 	mtc1	a1,\$f29
0+33ac <fp_test\+0xa84> a0be 283b 	mtc1	a1,\$f30
0+33b0 <fp_test\+0xa88> a0bf 283b 	mtc1	a1,\$f31
0+33b4 <fp_test\+0xa8c> a0a0 383b 	mthc1	a1,\$f0
0+33b8 <fp_test\+0xa90> a0a1 383b 	mthc1	a1,\$f1
0+33bc <fp_test\+0xa94> a0a2 383b 	mthc1	a1,\$f2
0+33c0 <fp_test\+0xa98> a0a3 383b 	mthc1	a1,\$f3
0+33c4 <fp_test\+0xa9c> a0a4 383b 	mthc1	a1,\$f4
0+33c8 <fp_test\+0xaa0> a0a5 383b 	mthc1	a1,\$f5
0+33cc <fp_test\+0xaa4> a0a6 383b 	mthc1	a1,\$f6
0+33d0 <fp_test\+0xaa8> a0a7 383b 	mthc1	a1,\$f7
0+33d4 <fp_test\+0xaac> a0a8 383b 	mthc1	a1,\$f8
0+33d8 <fp_test\+0xab0> a0a9 383b 	mthc1	a1,\$f9
0+33dc <fp_test\+0xab4> a0aa 383b 	mthc1	a1,\$f10
0+33e0 <fp_test\+0xab8> a0ab 383b 	mthc1	a1,\$f11
0+33e4 <fp_test\+0xabc> a0ac 383b 	mthc1	a1,\$f12
0+33e8 <fp_test\+0xac0> a0ad 383b 	mthc1	a1,\$f13
0+33ec <fp_test\+0xac4> a0ae 383b 	mthc1	a1,\$f14
0+33f0 <fp_test\+0xac8> a0af 383b 	mthc1	a1,\$f15
0+33f4 <fp_test\+0xacc> a0b0 383b 	mthc1	a1,\$f16
0+33f8 <fp_test\+0xad0> a0b1 383b 	mthc1	a1,\$f17
0+33fc <fp_test\+0xad4> a0b2 383b 	mthc1	a1,\$f18
0+3400 <fp_test\+0xad8> a0b3 383b 	mthc1	a1,\$f19
0+3404 <fp_test\+0xadc> a0b4 383b 	mthc1	a1,\$f20
0+3408 <fp_test\+0xae0> a0b5 383b 	mthc1	a1,\$f21
0+340c <fp_test\+0xae4> a0b6 383b 	mthc1	a1,\$f22
0+3410 <fp_test\+0xae8> a0b7 383b 	mthc1	a1,\$f23
0+3414 <fp_test\+0xaec> a0b8 383b 	mthc1	a1,\$f24
0+3418 <fp_test\+0xaf0> a0b9 383b 	mthc1	a1,\$f25
0+341c <fp_test\+0xaf4> a0ba 383b 	mthc1	a1,\$f26
0+3420 <fp_test\+0xaf8> a0bb 383b 	mthc1	a1,\$f27
0+3424 <fp_test\+0xafc> a0bc 383b 	mthc1	a1,\$f28
0+3428 <fp_test\+0xb00> a0bd 383b 	mthc1	a1,\$f29
0+342c <fp_test\+0xb04> a0be 383b 	mthc1	a1,\$f30
0+3430 <fp_test\+0xb08> a0bf 383b 	mthc1	a1,\$f31
0+3434 <fp_test\+0xb0c> a0a0 383b 	mthc1	a1,\$f0
0+3438 <fp_test\+0xb10> a0a1 383b 	mthc1	a1,\$f1
0+343c <fp_test\+0xb14> a0a2 383b 	mthc1	a1,\$f2
0+3440 <fp_test\+0xb18> a0a3 383b 	mthc1	a1,\$f3
0+3444 <fp_test\+0xb1c> a0a4 383b 	mthc1	a1,\$f4
0+3448 <fp_test\+0xb20> a0a5 383b 	mthc1	a1,\$f5
0+344c <fp_test\+0xb24> a0a6 383b 	mthc1	a1,\$f6
0+3450 <fp_test\+0xb28> a0a7 383b 	mthc1	a1,\$f7
0+3454 <fp_test\+0xb2c> a0a8 383b 	mthc1	a1,\$f8
0+3458 <fp_test\+0xb30> a0a9 383b 	mthc1	a1,\$f9
0+345c <fp_test\+0xb34> a0aa 383b 	mthc1	a1,\$f10
0+3460 <fp_test\+0xb38> a0ab 383b 	mthc1	a1,\$f11
0+3464 <fp_test\+0xb3c> a0ac 383b 	mthc1	a1,\$f12
0+3468 <fp_test\+0xb40> a0ad 383b 	mthc1	a1,\$f13
0+346c <fp_test\+0xb44> a0ae 383b 	mthc1	a1,\$f14
0+3470 <fp_test\+0xb48> a0af 383b 	mthc1	a1,\$f15
0+3474 <fp_test\+0xb4c> a0b0 383b 	mthc1	a1,\$f16
0+3478 <fp_test\+0xb50> a0b1 383b 	mthc1	a1,\$f17
0+347c <fp_test\+0xb54> a0b2 383b 	mthc1	a1,\$f18
0+3480 <fp_test\+0xb58> a0b3 383b 	mthc1	a1,\$f19
0+3484 <fp_test\+0xb5c> a0b4 383b 	mthc1	a1,\$f20
0+3488 <fp_test\+0xb60> a0b5 383b 	mthc1	a1,\$f21
0+348c <fp_test\+0xb64> a0b6 383b 	mthc1	a1,\$f22
0+3490 <fp_test\+0xb68> a0b7 383b 	mthc1	a1,\$f23
0+3494 <fp_test\+0xb6c> a0b8 383b 	mthc1	a1,\$f24
0+3498 <fp_test\+0xb70> a0b9 383b 	mthc1	a1,\$f25
0+349c <fp_test\+0xb74> a0ba 383b 	mthc1	a1,\$f26
0+34a0 <fp_test\+0xb78> a0bb 383b 	mthc1	a1,\$f27
0+34a4 <fp_test\+0xb7c> a0bc 383b 	mthc1	a1,\$f28
0+34a8 <fp_test\+0xb80> a0bd 383b 	mthc1	a1,\$f29
0+34ac <fp_test\+0xb84> a0be 383b 	mthc1	a1,\$f30
0+34b0 <fp_test\+0xb88> a0bf 383b 	mthc1	a1,\$f31
0+34b4 <fp_test\+0xb8c> a041 00b0 	mul\.s	\$f0,\$f1,\$f2
0+34b8 <fp_test\+0xb90> a3fe e8b0 	mul\.s	\$f29,\$f30,\$f31
0+34bc <fp_test\+0xb94> a3dd e8b0 	mul\.s	\$f29,\$f29,\$f30
0+34c0 <fp_test\+0xb98> a3dd e8b0 	mul\.s	\$f29,\$f29,\$f30
0+34c4 <fp_test\+0xb9c> a041 01b0 	mul\.d	\$f0,\$f1,\$f2
0+34c8 <fp_test\+0xba0> a3fe e9b0 	mul\.d	\$f29,\$f30,\$f31
0+34cc <fp_test\+0xba4> a3dd e9b0 	mul\.d	\$f29,\$f29,\$f30
0+34d0 <fp_test\+0xba8> a3dd e9b0 	mul\.d	\$f29,\$f29,\$f30
0+34d4 <fp_test\+0xbac> a001 0b7b 	neg\.s	\$f0,\$f1
0+34d8 <fp_test\+0xbb0> a3df 0b7b 	neg\.s	\$f30,\$f31
0+34dc <fp_test\+0xbb4> a042 0b7b 	neg\.s	\$f2,\$f2
0+34e0 <fp_test\+0xbb8> a042 0b7b 	neg\.s	\$f2,\$f2
0+34e4 <fp_test\+0xbbc> a001 2b7b 	neg\.d	\$f0,\$f1
0+34e8 <fp_test\+0xbc0> a3df 2b7b 	neg\.d	\$f30,\$f31
0+34ec <fp_test\+0xbc4> a042 2b7b 	neg\.d	\$f2,\$f2
0+34f0 <fp_test\+0xbc8> a042 2b7b 	neg\.d	\$f2,\$f2
0+34f4 <fp_test\+0xbcc> a001 123b 	recip\.s	\$f0,\$f1
0+34f8 <fp_test\+0xbd0> a3df 123b 	recip\.s	\$f30,\$f31
0+34fc <fp_test\+0xbd4> a042 123b 	recip\.s	\$f2,\$f2
0+3500 <fp_test\+0xbd8> a001 523b 	recip\.d	\$f0,\$f1
0+3504 <fp_test\+0xbdc> a3df 523b 	recip\.d	\$f30,\$f31
0+3508 <fp_test\+0xbe0> a042 523b 	recip\.d	\$f2,\$f2
0+350c <fp_test\+0xbe4> a001 333b 	round\.l\.s	\$f0,\$f1
0+3510 <fp_test\+0xbe8> a3df 333b 	round\.l\.s	\$f30,\$f31
0+3514 <fp_test\+0xbec> a042 333b 	round\.l\.s	\$f2,\$f2
0+3518 <fp_test\+0xbf0> a001 733b 	round\.l\.d	\$f0,\$f1
0+351c <fp_test\+0xbf4> a3df 733b 	round\.l\.d	\$f30,\$f31
0+3520 <fp_test\+0xbf8> a042 733b 	round\.l\.d	\$f2,\$f2
0+3524 <fp_test\+0xbfc> a001 3b3b 	round\.w\.s	\$f0,\$f1
0+3528 <fp_test\+0xc00> a3df 3b3b 	round\.w\.s	\$f30,\$f31
0+352c <fp_test\+0xc04> a042 3b3b 	round\.w\.s	\$f2,\$f2
0+3530 <fp_test\+0xc08> a001 7b3b 	round\.w\.d	\$f0,\$f1
0+3534 <fp_test\+0xc0c> a3df 7b3b 	round\.w\.d	\$f30,\$f31
0+3538 <fp_test\+0xc10> a042 7b3b 	round\.w\.d	\$f2,\$f2
0+353c <fp_test\+0xc14> a001 023b 	rsqrt\.s	\$f0,\$f1
0+3540 <fp_test\+0xc18> a3df 023b 	rsqrt\.s	\$f30,\$f31
0+3544 <fp_test\+0xc1c> a042 023b 	rsqrt\.s	\$f2,\$f2
0+3548 <fp_test\+0xc20> a001 423b 	rsqrt\.d	\$f0,\$f1
0+354c <fp_test\+0xc24> a3df 423b 	rsqrt\.d	\$f30,\$f31
0+3550 <fp_test\+0xc28> a042 423b 	rsqrt\.d	\$f2,\$f2
0+3554 <fp_test\+0xc2c> 8460 f000 	sdc1	\$f3,0\(zero\)
0+3558 <fp_test\+0xc30> 8460 f000 	sdc1	\$f3,0\(zero\)
0+355c <fp_test\+0xc34> 8460 f004 	sdc1	\$f3,4\(zero\)
0+3560 <fp_test\+0xc38> 8460 f004 	sdc1	\$f3,4\(zero\)
0+3564 <fp_test\+0xc3c> 8464 f000 	sdc1	\$f3,0\(a0\)
0+3568 <fp_test\+0xc40> 8464 f000 	sdc1	\$f3,0\(a0\)
0+356c <fp_test\+0xc44> e020 7000 	lui	at,0x7
0+3570 <fp_test\+0xc48> 2081 0950 	addu	at,at,a0
0+3574 <fp_test\+0xc4c> 8461 ffff 	sdc1	\$f3,4095\(at\)
0+3578 <fp_test\+0xc50> e03f 8ffd 	lui	at,0xffff8
0+357c <fp_test\+0xc54> 2081 0950 	addu	at,at,a0
0+3580 <fp_test\+0xc58> 8461 f000 	sdc1	\$f3,0\(at\)
0+3584 <fp_test\+0xc5c> e020 f000 	lui	at,0xf
0+3588 <fp_test\+0xc60> 2081 0950 	addu	at,at,a0
0+358c <fp_test\+0xc64> 8461 ffff 	sdc1	\$f3,4095\(at\)
0+3590 <fp_test\+0xc68> e03f 0ffd 	lui	at,0xffff0
0+3594 <fp_test\+0xc6c> 2081 0950 	addu	at,at,a0
0+3598 <fp_test\+0xc70> 8461 f000 	sdc1	\$f3,0\(at\)
0+359c <fp_test\+0xc74> e03f 8ffd 	lui	at,0xffff8
0+35a0 <fp_test\+0xc78> 2081 0950 	addu	at,at,a0
0+35a4 <fp_test\+0xc7c> 8461 f000 	sdc1	\$f3,0\(at\)
0+35a8 <fp_test\+0xc80> e03f 0ffd 	lui	at,0xffff0
0+35ac <fp_test\+0xc84> 2081 0950 	addu	at,at,a0
0+35b0 <fp_test\+0xc88> 8461 f001 	sdc1	\$f3,1\(at\)
0+35b4 <fp_test\+0xc8c> e03f 8ffd 	lui	at,0xffff8
0+35b8 <fp_test\+0xc90> 2081 0950 	addu	at,at,a0
0+35bc <fp_test\+0xc94> 8461 f001 	sdc1	\$f3,1\(at\)
0+35c0 <fp_test\+0xc98> e020 0e01 	lui	at,0xf0000
0+35c4 <fp_test\+0xc9c> 2081 0950 	addu	at,at,a0
0+35c8 <fp_test\+0xca0> 8461 f000 	sdc1	\$f3,0\(at\)
0+35cc <fp_test\+0xca4> 0024 9fff 	addiu	at,a0,-1
0+35d0 <fp_test\+0xca8> 8461 f000 	sdc1	\$f3,0\(at\)
0+35d4 <fp_test\+0xcac> e034 5244 	lui	at,0x12345
0+35d8 <fp_test\+0xcb0> 2081 0950 	addu	at,at,a0
0+35dc <fp_test\+0xcb4> 8461 f678 	sdc1	\$f3,1656\(at\)
0+35e0 <fp_test\+0xcb8> 8460 f000 	sdc1	\$f3,0\(zero\)
0+35e4 <fp_test\+0xcbc> 8460 f000 	sdc1	\$f3,0\(zero\)
0+35e8 <fp_test\+0xcc0> 8460 f004 	sdc1	\$f3,4\(zero\)
0+35ec <fp_test\+0xcc4> 8460 f004 	sdc1	\$f3,4\(zero\)
0+35f0 <fp_test\+0xcc8> 8464 f000 	sdc1	\$f3,0\(a0\)
0+35f4 <fp_test\+0xccc> 8464 f000 	sdc1	\$f3,0\(a0\)
0+35f8 <fp_test\+0xcd0> e020 7000 	lui	at,0x7
0+35fc <fp_test\+0xcd4> 2081 0950 	addu	at,at,a0
0+3600 <fp_test\+0xcd8> 8461 ffff 	sdc1	\$f3,4095\(at\)
0+3604 <fp_test\+0xcdc> e03f 8ffd 	lui	at,0xffff8
0+3608 <fp_test\+0xce0> 2081 0950 	addu	at,at,a0
0+360c <fp_test\+0xce4> 8461 f000 	sdc1	\$f3,0\(at\)
0+3610 <fp_test\+0xce8> e020 f000 	lui	at,0xf
0+3614 <fp_test\+0xcec> 2081 0950 	addu	at,at,a0
0+3618 <fp_test\+0xcf0> 8461 ffff 	sdc1	\$f3,4095\(at\)
0+361c <fp_test\+0xcf4> e03f 0ffd 	lui	at,0xffff0
0+3620 <fp_test\+0xcf8> 2081 0950 	addu	at,at,a0
0+3624 <fp_test\+0xcfc> 8461 f000 	sdc1	\$f3,0\(at\)
0+3628 <fp_test\+0xd00> e03f 8ffd 	lui	at,0xffff8
0+362c <fp_test\+0xd04> 2081 0950 	addu	at,at,a0
0+3630 <fp_test\+0xd08> 8461 f000 	sdc1	\$f3,0\(at\)
0+3634 <fp_test\+0xd0c> e03f 0ffd 	lui	at,0xffff0
0+3638 <fp_test\+0xd10> 2081 0950 	addu	at,at,a0
0+363c <fp_test\+0xd14> 8461 f001 	sdc1	\$f3,1\(at\)
0+3640 <fp_test\+0xd18> e03f 8ffd 	lui	at,0xffff8
0+3644 <fp_test\+0xd1c> 2081 0950 	addu	at,at,a0
0+3648 <fp_test\+0xd20> 8461 f001 	sdc1	\$f3,1\(at\)
0+364c <fp_test\+0xd24> e020 0e01 	lui	at,0xf0000
0+3650 <fp_test\+0xd28> 2081 0950 	addu	at,at,a0
0+3654 <fp_test\+0xd2c> 8461 f000 	sdc1	\$f3,0\(at\)
0+3658 <fp_test\+0xd30> 0024 9fff 	addiu	at,a0,-1
0+365c <fp_test\+0xd34> 8461 f000 	sdc1	\$f3,0\(at\)
0+3660 <fp_test\+0xd38> e034 5244 	lui	at,0x12345
0+3664 <fp_test\+0xd3c> 2081 0950 	addu	at,at,a0
0+3668 <fp_test\+0xd40> 8461 f678 	sdc1	\$f3,1656\(at\)
0+366c <fp_test\+0xd44> 8460 f000 	sdc1	\$f3,0\(zero\)
0+3670 <fp_test\+0xd48> 8460 f000 	sdc1	\$f3,0\(zero\)
0+3674 <fp_test\+0xd4c> 8460 f004 	sdc1	\$f3,4\(zero\)
0+3678 <fp_test\+0xd50> 8460 f004 	sdc1	\$f3,4\(zero\)
0+367c <fp_test\+0xd54> 8464 f000 	sdc1	\$f3,0\(a0\)
0+3680 <fp_test\+0xd58> 8464 f000 	sdc1	\$f3,0\(a0\)
0+3684 <fp_test\+0xd5c> e020 7000 	lui	at,0x7
0+3688 <fp_test\+0xd60> 2081 0950 	addu	at,at,a0
0+368c <fp_test\+0xd64> 8461 ffff 	sdc1	\$f3,4095\(at\)
0+3690 <fp_test\+0xd68> e03f 8ffd 	lui	at,0xffff8
0+3694 <fp_test\+0xd6c> 2081 0950 	addu	at,at,a0
0+3698 <fp_test\+0xd70> 8461 f000 	sdc1	\$f3,0\(at\)
0+369c <fp_test\+0xd74> 2000 0787 	sdc1x	\$f0,zero\(zero\)
0+36a0 <fp_test\+0xd78> 2040 0787 	sdc1x	\$f0,zero\(v0\)
0+36a4 <fp_test\+0xd7c> 23e0 0787 	sdc1x	\$f0,zero\(ra\)
0+36a8 <fp_test\+0xd80> 23e2 0787 	sdc1x	\$f0,v0\(ra\)
0+36ac <fp_test\+0xd84> 23ff 0787 	sdc1x	\$f0,ra\(ra\)
0+36b0 <fp_test\+0xd88> 23ff 0f87 	sdc1x	\$f1,ra\(ra\)
0+36b4 <fp_test\+0xd8c> 23ff 1787 	sdc1x	\$f2,ra\(ra\)
0+36b8 <fp_test\+0xd90> 23ff ff87 	sdc1x	\$f31,ra\(ra\)
0+36bc <fp_test\+0xd94> a001 0a3b 	sqrt\.s	\$f0,\$f1
0+36c0 <fp_test\+0xd98> a3df 0a3b 	sqrt\.s	\$f30,\$f31
0+36c4 <fp_test\+0xd9c> a042 0a3b 	sqrt\.s	\$f2,\$f2
0+36c8 <fp_test\+0xda0> a001 4a3b 	sqrt\.d	\$f0,\$f1
0+36cc <fp_test\+0xda4> a3df 4a3b 	sqrt\.d	\$f30,\$f31
0+36d0 <fp_test\+0xda8> a042 4a3b 	sqrt\.d	\$f2,\$f2
0+36d4 <fp_test\+0xdac> a041 0070 	sub\.s	\$f0,\$f1,\$f2
0+36d8 <fp_test\+0xdb0> a3fe e870 	sub\.s	\$f29,\$f30,\$f31
0+36dc <fp_test\+0xdb4> a3dd e870 	sub\.s	\$f29,\$f29,\$f30
0+36e0 <fp_test\+0xdb8> a3dd e870 	sub\.s	\$f29,\$f29,\$f30
0+36e4 <fp_test\+0xdbc> a041 0170 	sub\.d	\$f0,\$f1,\$f2
0+36e8 <fp_test\+0xdc0> a3fe e970 	sub\.d	\$f29,\$f30,\$f31
0+36ec <fp_test\+0xdc4> a3dd e970 	sub\.d	\$f29,\$f29,\$f30
0+36f0 <fp_test\+0xdc8> a3dd e970 	sub\.d	\$f29,\$f29,\$f30
0+36f4 <fp_test\+0xdcc> 8460 b000 	swc1	\$f3,0\(zero\)
0+36f8 <fp_test\+0xdd0> 8460 b000 	swc1	\$f3,0\(zero\)
0+36fc <fp_test\+0xdd4> 8460 b004 	swc1	\$f3,4\(zero\)
0+3700 <fp_test\+0xdd8> 8460 b004 	swc1	\$f3,4\(zero\)
0+3704 <fp_test\+0xddc> 8464 b000 	swc1	\$f3,0\(a0\)
0+3708 <fp_test\+0xde0> 8464 b000 	swc1	\$f3,0\(a0\)
0+370c <fp_test\+0xde4> e020 7000 	lui	at,0x7
0+3710 <fp_test\+0xde8> 2081 0950 	addu	at,at,a0
0+3714 <fp_test\+0xdec> 8461 bfff 	swc1	\$f3,4095\(at\)
0+3718 <fp_test\+0xdf0> e03f 8ffd 	lui	at,0xffff8
0+371c <fp_test\+0xdf4> 2081 0950 	addu	at,at,a0
0+3720 <fp_test\+0xdf8> 8461 b000 	swc1	\$f3,0\(at\)
0+3724 <fp_test\+0xdfc> e020 f000 	lui	at,0xf
0+3728 <fp_test\+0xe00> 2081 0950 	addu	at,at,a0
0+372c <fp_test\+0xe04> 8461 bfff 	swc1	\$f3,4095\(at\)
0+3730 <fp_test\+0xe08> e03f 0ffd 	lui	at,0xffff0
0+3734 <fp_test\+0xe0c> 2081 0950 	addu	at,at,a0
0+3738 <fp_test\+0xe10> 8461 b000 	swc1	\$f3,0\(at\)
0+373c <fp_test\+0xe14> e03f 8ffd 	lui	at,0xffff8
0+3740 <fp_test\+0xe18> 2081 0950 	addu	at,at,a0
0+3744 <fp_test\+0xe1c> 8461 b000 	swc1	\$f3,0\(at\)
0+3748 <fp_test\+0xe20> e03f 0ffd 	lui	at,0xffff0
0+374c <fp_test\+0xe24> 2081 0950 	addu	at,at,a0
0+3750 <fp_test\+0xe28> 8461 b001 	swc1	\$f3,1\(at\)
0+3754 <fp_test\+0xe2c> e03f 8ffd 	lui	at,0xffff8
0+3758 <fp_test\+0xe30> 2081 0950 	addu	at,at,a0
0+375c <fp_test\+0xe34> 8461 b001 	swc1	\$f3,1\(at\)
0+3760 <fp_test\+0xe38> e020 0e01 	lui	at,0xf0000
0+3764 <fp_test\+0xe3c> 2081 0950 	addu	at,at,a0
0+3768 <fp_test\+0xe40> 8461 b000 	swc1	\$f3,0\(at\)
0+376c <fp_test\+0xe44> 0024 9fff 	addiu	at,a0,-1
0+3770 <fp_test\+0xe48> 8461 b000 	swc1	\$f3,0\(at\)
0+3774 <fp_test\+0xe4c> e034 5244 	lui	at,0x12345
0+3778 <fp_test\+0xe50> 2081 0950 	addu	at,at,a0
0+377c <fp_test\+0xe54> 8461 b678 	swc1	\$f3,1656\(at\)
0+3780 <fp_test\+0xe58> 8460 b000 	swc1	\$f3,0\(zero\)
0+3784 <fp_test\+0xe5c> 8460 b000 	swc1	\$f3,0\(zero\)
0+3788 <fp_test\+0xe60> 8460 b004 	swc1	\$f3,4\(zero\)
0+378c <fp_test\+0xe64> 8460 b004 	swc1	\$f3,4\(zero\)
0+3790 <fp_test\+0xe68> 8464 b000 	swc1	\$f3,0\(a0\)
0+3794 <fp_test\+0xe6c> 8464 b000 	swc1	\$f3,0\(a0\)
0+3798 <fp_test\+0xe70> e020 7000 	lui	at,0x7
0+379c <fp_test\+0xe74> 2081 0950 	addu	at,at,a0
0+37a0 <fp_test\+0xe78> 8461 bfff 	swc1	\$f3,4095\(at\)
0+37a4 <fp_test\+0xe7c> e03f 8ffd 	lui	at,0xffff8
0+37a8 <fp_test\+0xe80> 2081 0950 	addu	at,at,a0
0+37ac <fp_test\+0xe84> 8461 b000 	swc1	\$f3,0\(at\)
0+37b0 <fp_test\+0xe88> e020 f000 	lui	at,0xf
0+37b4 <fp_test\+0xe8c> 2081 0950 	addu	at,at,a0
0+37b8 <fp_test\+0xe90> 8461 bfff 	swc1	\$f3,4095\(at\)
0+37bc <fp_test\+0xe94> e03f 0ffd 	lui	at,0xffff0
0+37c0 <fp_test\+0xe98> 2081 0950 	addu	at,at,a0
0+37c4 <fp_test\+0xe9c> 8461 b000 	swc1	\$f3,0\(at\)
0+37c8 <fp_test\+0xea0> e03f 8ffd 	lui	at,0xffff8
0+37cc <fp_test\+0xea4> 2081 0950 	addu	at,at,a0
0+37d0 <fp_test\+0xea8> 8461 b000 	swc1	\$f3,0\(at\)
0+37d4 <fp_test\+0xeac> e03f 0ffd 	lui	at,0xffff0
0+37d8 <fp_test\+0xeb0> 2081 0950 	addu	at,at,a0
0+37dc <fp_test\+0xeb4> 8461 b001 	swc1	\$f3,1\(at\)
0+37e0 <fp_test\+0xeb8> e03f 8ffd 	lui	at,0xffff8
0+37e4 <fp_test\+0xebc> 2081 0950 	addu	at,at,a0
0+37e8 <fp_test\+0xec0> 8461 b001 	swc1	\$f3,1\(at\)
0+37ec <fp_test\+0xec4> e020 0e01 	lui	at,0xf0000
0+37f0 <fp_test\+0xec8> 2081 0950 	addu	at,at,a0
0+37f4 <fp_test\+0xecc> 8461 b000 	swc1	\$f3,0\(at\)
0+37f8 <fp_test\+0xed0> 0024 9fff 	addiu	at,a0,-1
0+37fc <fp_test\+0xed4> 8461 b000 	swc1	\$f3,0\(at\)
0+3800 <fp_test\+0xed8> e034 5244 	lui	at,0x12345
0+3804 <fp_test\+0xedc> 2081 0950 	addu	at,at,a0
0+3808 <fp_test\+0xee0> 8461 b678 	swc1	\$f3,1656\(at\)
0+380c <fp_test\+0xee4> 8460 b000 	swc1	\$f3,0\(zero\)
0+3810 <fp_test\+0xee8> 8460 b000 	swc1	\$f3,0\(zero\)
0+3814 <fp_test\+0xeec> 8460 b004 	swc1	\$f3,4\(zero\)
0+3818 <fp_test\+0xef0> 8460 b004 	swc1	\$f3,4\(zero\)
0+381c <fp_test\+0xef4> 8464 b000 	swc1	\$f3,0\(a0\)
0+3820 <fp_test\+0xef8> 8464 b000 	swc1	\$f3,0\(a0\)
0+3824 <fp_test\+0xefc> e020 7000 	lui	at,0x7
0+3828 <fp_test\+0xf00> 2081 0950 	addu	at,at,a0
0+382c <fp_test\+0xf04> 8461 bfff 	swc1	\$f3,4095\(at\)
0+3830 <fp_test\+0xf08> e03f 8ffd 	lui	at,0xffff8
0+3834 <fp_test\+0xf0c> 2081 0950 	addu	at,at,a0
0+3838 <fp_test\+0xf10> 8461 b000 	swc1	\$f3,0\(at\)
0+383c <fp_test\+0xf14> e020 f000 	lui	at,0xf
0+3840 <fp_test\+0xf18> 2081 0950 	addu	at,at,a0
0+3844 <fp_test\+0xf1c> 8461 bfff 	swc1	\$f3,4095\(at\)
0+3848 <fp_test\+0xf20> e03f 0ffd 	lui	at,0xffff0
0+384c <fp_test\+0xf24> 2081 0950 	addu	at,at,a0
0+3850 <fp_test\+0xf28> 8461 b000 	swc1	\$f3,0\(at\)
0+3854 <fp_test\+0xf2c> e03f 8ffd 	lui	at,0xffff8
0+3858 <fp_test\+0xf30> 2081 0950 	addu	at,at,a0
0+385c <fp_test\+0xf34> 8461 b000 	swc1	\$f3,0\(at\)
0+3860 <fp_test\+0xf38> e03f 0ffd 	lui	at,0xffff0
0+3864 <fp_test\+0xf3c> 2081 0950 	addu	at,at,a0
0+3868 <fp_test\+0xf40> 8461 b001 	swc1	\$f3,1\(at\)
0+386c <fp_test\+0xf44> e03f 8ffd 	lui	at,0xffff8
0+3870 <fp_test\+0xf48> 2081 0950 	addu	at,at,a0
0+3874 <fp_test\+0xf4c> 8461 b001 	swc1	\$f3,1\(at\)
0+3878 <fp_test\+0xf50> e020 0e01 	lui	at,0xf0000
0+387c <fp_test\+0xf54> 2081 0950 	addu	at,at,a0
0+3880 <fp_test\+0xf58> 8461 b000 	swc1	\$f3,0\(at\)
0+3884 <fp_test\+0xf5c> 0024 9fff 	addiu	at,a0,-1
0+3888 <fp_test\+0xf60> 8461 b000 	swc1	\$f3,0\(at\)
0+388c <fp_test\+0xf64> e034 5244 	lui	at,0x12345
0+3890 <fp_test\+0xf68> 2081 0950 	addu	at,at,a0
0+3894 <fp_test\+0xf6c> 8461 b678 	swc1	\$f3,1656\(at\)
0+3898 <fp_test\+0xf70> 2000 0587 	swc1x	\$f0,zero\(zero\)
0+389c <fp_test\+0xf74> 2040 0587 	swc1x	\$f0,zero\(v0\)
0+38a0 <fp_test\+0xf78> 23e0 0587 	swc1x	\$f0,zero\(ra\)
0+38a4 <fp_test\+0xf7c> 23e2 0587 	swc1x	\$f0,v0\(ra\)
0+38a8 <fp_test\+0xf80> 23ff 0587 	swc1x	\$f0,ra\(ra\)
0+38ac <fp_test\+0xf84> 23ff 0d87 	swc1x	\$f1,ra\(ra\)
0+38b0 <fp_test\+0xf88> 23ff 1587 	swc1x	\$f2,ra\(ra\)
0+38b4 <fp_test\+0xf8c> 23ff fd87 	swc1x	\$f31,ra\(ra\)
0+38b8 <fp_test\+0xf90> a001 233b 	trunc\.l\.s	\$f0,\$f1
0+38bc <fp_test\+0xf94> a3df 233b 	trunc\.l\.s	\$f30,\$f31
0+38c0 <fp_test\+0xf98> a042 233b 	trunc\.l\.s	\$f2,\$f2
0+38c4 <fp_test\+0xf9c> a001 633b 	trunc\.l\.d	\$f0,\$f1
0+38c8 <fp_test\+0xfa0> a3df 633b 	trunc\.l\.d	\$f30,\$f31
0+38cc <fp_test\+0xfa4> a042 633b 	trunc\.l\.d	\$f2,\$f2
0+38d0 <fp_test\+0xfa8> a001 2b3b 	trunc\.w\.s	\$f0,\$f1
0+38d4 <fp_test\+0xfac> a3df 2b3b 	trunc\.w\.s	\$f30,\$f31
0+38d8 <fp_test\+0xfb0> a042 2b3b 	trunc\.w\.s	\$f2,\$f2
0+38dc <fp_test\+0xfb4> a001 6b3b 	trunc\.w\.d	\$f0,\$f1
0+38e0 <fp_test\+0xfb8> a3df 6b3b 	trunc\.w\.d	\$f30,\$f31
0+38e4 <fp_test\+0xfbc> a042 6b3b 	trunc\.w\.d	\$f2,\$f2
0+38e8 <test_delay_slot> 3800      	balc	000071d2 <test_spec107\+0x3888>
			38e8: R_MICROMIPS_PC10_S1	test_delay_slot-0x2
0+38ea <test_delay_slot\+0x2> d850      	jalrc	v0
0+38ec <test_delay_slot\+0x4> 4be2 0000 	jalrc	v0
0+38f0 <test_delay_slot\+0x8> d840      	jrc	v0
0+38f2 <test_delay_slot\+0xa> 4802 0000 	jrc	v0
0+38f6 <test_delay_slot\+0xe> 4be2 1000 	jalrc\.hb	v0
0+38fa <test_delay_slot\+0x12> 4802 1000 	jrc\.hb	v0
0+38fe <test_spec102> b540      	lw	v0,-256\(gp\)
0+3900 <test_spec102\+0x2> b5c0      	lw	v1,-256\(gp\)
0+3902 <test_spec102\+0x4> b640      	lw	a0,-256\(gp\)
0+3904 <test_spec102\+0x6> b6c0      	lw	a1,-256\(gp\)
0+3906 <test_spec102\+0x8> b740      	lw	a2,-256\(gp\)
0+3908 <test_spec102\+0xa> b7c0      	lw	a3,-256\(gp\)
0+390a <test_spec102\+0xc> b440      	lw	s0,-256\(gp\)
0+390c <test_spec102\+0xe> b4c0      	lw	s1,-256\(gp\)
0+390e <test_spec102\+0x10> b4c1      	lw	s1,-252\(gp\)
0+3910 <test_spec102\+0x12> b4ff      	lw	s1,-4\(gp\)
0+3912 <test_spec102\+0x14> 4220 0002 	lw	s1,0\(gp\)
0+3916 <test_spec102\+0x18> 4220 0006 	lw	s1,4\(gp\)
0+391a <test_spec102\+0x1c> 4220 00fa 	lw	s1,248\(gp\)
0+391e <test_spec102\+0x20> 4220 00fe 	lw	s1,252\(gp\)
0+3922 <test_spec102\+0x24> 4220 0102 	lw	s1,256\(gp\)
0+3926 <test_spec102\+0x28> 023c 9efc 	addiu	s1,gp,-260
0+392a <test_spec102\+0x2c> 8631 8000 	lw	s1,0\(s1\)
0+392e <test_spec102\+0x30> 863c 8001 	lw	s1,1\(gp\)
0+3932 <test_spec102\+0x34> 863c 8002 	lw	s1,2\(gp\)
0+3936 <test_spec102\+0x38> 863c 8003 	lw	s1,3\(gp\)
0+393a <test_spec102\+0x3c> a63c c0ff 	lw	s1,-1\(gp\)
0+393e <test_spec102\+0x40> a63c c0fe 	lw	s1,-2\(gp\)
0+3942 <test_spec102\+0x44> a63c c0fd 	lw	s1,-3\(gp\)
0+3946 <test_spec102\+0x48> 863b 8000 	lw	s1,0\(k1\)
0+394a <test_spec107> bd00      	movep	a1,a2,zero,zero
0+394c <test_spec107\+0x2> bc08      	movep	a2,a3,zero,zero
0+394e <test_spec107\+0x4> bc08      	movep	a2,a3,zero,zero
0+3950 <test_spec107\+0x6> bc00      	movep	a0,a1,zero,zero
0+3952 <test_spec107\+0x8> bd00      	movep	a1,a2,zero,zero
0+3954 <test_spec107\+0xa> bc08      	movep	a2,a3,zero,zero
0+3956 <test_spec107\+0xc> bc19      	movep	a2,a3,s1,zero
0+3958 <test_spec107\+0xe> bc0a      	movep	a2,a3,v0,zero
0+395a <test_spec107\+0x10> bc0b      	movep	a2,a3,v1,zero
0+395c <test_spec107\+0x12> bc18      	movep	a2,a3,s0,zero
0+395e <test_spec107\+0x14> bc1a      	movep	a2,a3,s2,zero
0+3960 <test_spec107\+0x16> bc1b      	movep	a2,a3,s3,zero
0+3962 <test_spec107\+0x18> bc1c      	movep	a2,a3,s4,zero
0+3964 <test_spec107\+0x1a> be3c      	movep	a2,a3,s4,s1
0+3966 <test_spec107\+0x1c> bc5c      	movep	a2,a3,s4,v0
0+3968 <test_spec107\+0x1e> bc7c      	movep	a2,a3,s4,v1
0+396a <test_spec107\+0x20> be1c      	movep	a2,a3,s4,s0
0+396c <test_spec107\+0x22> be5c      	movep	a2,a3,s4,s2
0+396e <test_spec107\+0x24> be7c      	movep	a2,a3,s4,s3
0+3970 <test_spec107\+0x26> be9c      	movep	a2,a3,s4,s4
0+3972 <test_spec107\+0x28> 446c 0000 	lwc1	\$f3,0\(gp\)
0+3976 <test_spec107\+0x2c> 446c 0000 	lwc1	\$f3,0\(gp\)
0+397a <test_spec107\+0x30> 446c 0004 	lwc1	\$f3,4\(gp\)
0+397e <test_spec107\+0x34> 446c 4000 	lwc1	\$f3,16384\(gp\)
0+3982 <test_spec107\+0x38> 446f fffc 	lwc1	\$f3,262140\(gp\)
0+3986 <test_spec107\+0x3c> 446c 0001 	swc1	\$f3,0\(gp\)
0+398a <test_spec107\+0x40> 446c 0001 	swc1	\$f3,0\(gp\)
0+398e <test_spec107\+0x44> 446c 0005 	swc1	\$f3,4\(gp\)
0+3992 <test_spec107\+0x48> 446c 4001 	swc1	\$f3,16384\(gp\)
0+3996 <test_spec107\+0x4c> 446f fffd 	swc1	\$f3,262140\(gp\)
0+399a <test_spec107\+0x50> 9008      	nop
0+399c <test_spec107\+0x52> 9008      	nop
0+399e <test_spec107\+0x54> 9008      	nop
