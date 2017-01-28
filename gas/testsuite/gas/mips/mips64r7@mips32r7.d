#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPSR7 instructions
#as:
#stderr: mips32r7.l
#source: mips32r7.s

# Check MIPSR7 instructions

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> a400 1800 	pref	0x0,0\(zero\)
[0-9a-f]+ <[^>]+> 0020 07ff 	li	at,2047
[0-9a-f]+ <[^>]+> a401 1800 	pref	0x0,0\(at\)
[0-9a-f]+ <[^>]+> 0020 9800 	li	at,-2048
[0-9a-f]+ <[^>]+> a401 1800 	pref	0x0,0\(at\)
[0-9a-f]+ <[^>]+> 0020 0800 	li	at,2048
[0-9a-f]+ <[^>]+> a401 1800 	pref	0x0,0\(at\)
[0-9a-f]+ <[^>]+> 0020 97ff 	li	at,-2049
[0-9a-f]+ <[^>]+> a401 1800 	pref	0x0,0\(at\)
[0-9a-f]+ <[^>]+> a400 1800 	pref	0x0,0\(zero\)
[0-9a-f]+ <[^>]+> a400 1800 	pref	0x0,0\(zero\)
[0-9a-f]+ <[^>]+> a420 1800 	pref	0x1,0\(zero\)
[0-9a-f]+ <[^>]+> a440 1800 	pref	0x2,0\(zero\)
[0-9a-f]+ <[^>]+> a460 1800 	pref	0x3,0\(zero\)
[0-9a-f]+ <[^>]+> a480 1800 	pref	0x4,0\(zero\)
[0-9a-f]+ <[^>]+> a4a0 1800 	pref	0x5,0\(zero\)
[0-9a-f]+ <[^>]+> a4c0 1800 	pref	0x6,0\(zero\)
[0-9a-f]+ <[^>]+> a4e0 1800 	pref	0x7,0\(zero\)
[0-9a-f]+ <[^>]+> 0020 01ff 	li	at,511
[0-9a-f]+ <[^>]+> a4e1 1800 	pref	0x7,0\(at\)
[0-9a-f]+ <[^>]+> 0020 9e00 	li	at,-512
[0-9a-f]+ <[^>]+> a4e1 1800 	pref	0x7,0\(at\)
[0-9a-f]+ <[^>]+> 0020 07ff 	li	at,2047
[0-9a-f]+ <[^>]+> a7e1 1800 	synci	0\(at\)
[0-9a-f]+ <[^>]+> 0020 9800 	li	at,-2048
[0-9a-f]+ <[^>]+> a7e1 1800 	synci	0\(at\)
[0-9a-f]+ <[^>]+> 0020 0800 	li	at,2048
[0-9a-f]+ <[^>]+> a7e1 1800 	synci	0\(at\)
[0-9a-f]+ <[^>]+> 0020 97ff 	li	at,-2049
[0-9a-f]+ <[^>]+> a7e1 1800 	synci	0\(at\)
[0-9a-f]+ <[^>]+> e020 8000 	lui	at,0x8
[0-9a-f]+ <[^>]+> a461 98ff 	pref	0x3,-1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> a461 1800 	pref	0x3,0\(at\)
[0-9a-f]+ <[^>]+> 0022 07ff 	addiu	at,v0,2047
[0-9a-f]+ <[^>]+> a7e1 1800 	synci	0\(at\)
[0-9a-f]+ <[^>]+> 0022 9800 	addiu	at,v0,-2048
[0-9a-f]+ <[^>]+> a7e1 1800 	synci	0\(at\)
[0-9a-f]+ <[^>]+> 0022 0800 	addiu	at,v0,2048
[0-9a-f]+ <[^>]+> a7e1 1800 	synci	0\(at\)
[0-9a-f]+ <[^>]+> 0022 97ff 	addiu	at,v0,-2049
[0-9a-f]+ <[^>]+> a7e1 1800 	synci	0\(at\)
[0-9a-f]+ <[^>]+> e020 8000 	lui	at,0x8
[0-9a-f]+ <[^>]+> 2041 0950 	addu	at,at,v0
[0-9a-f]+ <[^>]+> a461 98ff 	pref	0x3,-1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2041 0950 	addu	at,at,v0
[0-9a-f]+ <[^>]+> a461 1800 	pref	0x3,0\(at\)
[0-9a-f]+ <[^>]+> 9008      	nop
[0-9a-f]+ <[^>]+> 9008      	nop
[0-9a-f]+ <[^>]+> 8000 c000 	nop
[0-9a-f]+ <[^>]+> 8000 c003 	ehb
[0-9a-f]+ <[^>]+> 8000 c005 	pause
[0-9a-f]+ <[^>]+> d17f      	li	s2,-1
[0-9a-f]+ <[^>]+> d1ff      	li	s3,-1
[0-9a-f]+ <[^>]+> d27f      	li	a0,-1
[0-9a-f]+ <[^>]+> d2ff      	li	a1,-1
[0-9a-f]+ <[^>]+> d37f      	li	a2,-1
[0-9a-f]+ <[^>]+> d3ff      	li	a3,-1
[0-9a-f]+ <[^>]+> d07f      	li	s0,-1
[0-9a-f]+ <[^>]+> d0ff      	li	s1,-1
[0-9a-f]+ <[^>]+> d080      	li	s1,0
[0-9a-f]+ <[^>]+> d0fd      	li	s1,125
[0-9a-f]+ <[^>]+> d0fe      	li	s1,126
[0-9a-f]+ <[^>]+> 0220 007f 	li	s1,127
[0-9a-f]+ <[^>]+> 0040 0000 	li	v0,0
[0-9a-f]+ <[^>]+> 0040 0001 	li	v0,1
[0-9a-f]+ <[^>]+> 6040 0000 7fff 	li	v0,0x7fff
[0-9a-f]+ <[^>]+> e05f 8ffd 	lui	v0,0xffff8
[0-9a-f]+ <[^>]+> 6040 0000 ffff 	li	v0,0xffff
[0-9a-f]+ <[^>]+> e041 0000 	lui	v0,0x10
[0-9a-f]+ <[^>]+> e05f 8ffd 	lui	v0,0xffff8
[0-9a-f]+ <[^>]+> 6040 ffff 8001 	li	v0,0xffff8001
[0-9a-f]+ <[^>]+> 6040 ffff ffff 	li	v0,0xffffffff
[0-9a-f]+ <[^>]+> 6040 1234 5678 	li	v0,0x12345678
[0-9a-f]+ <[^>]+> 2016 0290 	move	zero,s6
[0-9a-f]+ <[^>]+> 1056      	move	v0,s6
[0-9a-f]+ <[^>]+> 1076      	move	v1,s6
[0-9a-f]+ <[^>]+> 1096      	move	a0,s6
[0-9a-f]+ <[^>]+> 10b6      	move	a1,s6
[0-9a-f]+ <[^>]+> 10d6      	move	a2,s6
[0-9a-f]+ <[^>]+> 10f6      	move	a3,s6
[0-9a-f]+ <[^>]+> 1116      	move	t0,s6
[0-9a-f]+ <[^>]+> 1136      	move	t1,s6
[0-9a-f]+ <[^>]+> 1156      	move	t2,s6
[0-9a-f]+ <[^>]+> 13d6      	move	s8,s6
[0-9a-f]+ <[^>]+> 13f6      	move	ra,s6
[0-9a-f]+ <[^>]+> 2000 0290 	move	zero,zero
[0-9a-f]+ <[^>]+> 2002 0290 	move	zero,v0
[0-9a-f]+ <[^>]+> 2003 0290 	move	zero,v1
[0-9a-f]+ <[^>]+> 2004 0290 	move	zero,a0
[0-9a-f]+ <[^>]+> 2005 0290 	move	zero,a1
[0-9a-f]+ <[^>]+> 2006 0290 	move	zero,a2
[0-9a-f]+ <[^>]+> 2007 0290 	move	zero,a3
[0-9a-f]+ <[^>]+> 2008 0290 	move	zero,t0
[0-9a-f]+ <[^>]+> 2009 0290 	move	zero,t1
[0-9a-f]+ <[^>]+> 200a 0290 	move	zero,t2
[0-9a-f]+ <[^>]+> 201e 0290 	move	zero,s8
[0-9a-f]+ <[^>]+> 201f 0290 	move	zero,ra
[0-9a-f]+ <[^>]+> 12c2      	move	s6,v0
[0-9a-f]+ <[^>]+> 1056      	move	v0,s6
[0-9a-f]+ <[^>]+> 12c2      	move	s6,v0
[0-9a-f]+ <[^>]+> 2016 1290 	move	v0,s6
[0-9a-f]+ <[^>]+> 2002 b290 	move	s6,v0
[0-9a-f]+ <[^>]+> 1800      	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC10_S1	test-0x2
[0-9a-f]+ <[^>]+> 1800      	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC10_S1	test-0x2
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC25_S1	test-0x4
[0-9a-f]+ <[^>]+> 1800      	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC10_S1	\.L11-0x2
[0-9a-f]+ <[^>]+> 1800      	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC10_S1	\.L11-0x2
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC25_S1	\.L11-0x4
[0-9a-f]+ <[^>]+> 1800      	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC10_S1	\.L11-0x2
[0-9a-f]+ <[^>]+> 1800      	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC10_S1	\.L11-0x2
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC25_S1	\.L11-0x4
[0-9a-f]+ <[^>]+> 1043      	move	v0,v1
[0-9a-f]+ <[^>]+> 8803 8000 	bgezc	v1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	\.L0-0x4
[0-9a-f]+ <[^>]+> 2060 11d0 	negu	v0,v1
[0-9a-f]+ <[^>]+> 1044      	move	v0,a0
[0-9a-f]+ <[^>]+> 8804 8000 	bgezc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	\.L1-0x4
[0-9a-f]+ <[^>]+> 2080 11d0 	negu	v0,a0
[0-9a-f]+ <[^>]+> 8802 8000 	bgezc	v0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	\.L2-0x4
[0-9a-f]+ <[^>]+> 2040 11d0 	negu	v0,v0
[0-9a-f]+ <[^>]+> 8802 8000 	bgezc	v0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	\.L3-0x4
[0-9a-f]+ <[^>]+> 2040 11d0 	negu	v0,v0
[0-9a-f]+ <[^>]+> 2083 1110 	add	v0,v1,a0
[0-9a-f]+ <[^>]+> 23fe e910 	add	sp,s8,ra
[0-9a-f]+ <[^>]+> 2082 1110 	add	v0,v0,a0
[0-9a-f]+ <[^>]+> 2082 1110 	add	v0,v0,a0
[0-9a-f]+ <[^>]+> 0042 0000 	addiu	v0,v0,0
[0-9a-f]+ <[^>]+> 0042 0001 	addiu	v0,v0,1
[0-9a-f]+ <[^>]+> 6020 0000 7fff 	li	at,0x7fff
[0-9a-f]+ <[^>]+> 2022 1110 	add	v0,v0,at
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2022 1110 	add	v0,v0,at
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 2022 1110 	add	v0,v0,at
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2024 1910 	add	v1,a0,at
[0-9a-f]+ <[^>]+> 0064 0000 	addiu	v1,a0,0
[0-9a-f]+ <[^>]+> 6020 0000 7fff 	li	at,0x7fff
[0-9a-f]+ <[^>]+> 2024 1910 	add	v1,a0,at
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 2024 1910 	add	v1,a0,at
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 2023 1910 	add	v1,v1,at
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 2023 1910 	add	v1,v1,at
[0-9a-f]+ <[^>]+> 9018      	addiu	zero,zero,-8
[0-9a-f]+ <[^>]+> 9058      	addiu	v0,v0,-8
[0-9a-f]+ <[^>]+> 9078      	addiu	v1,v1,-8
[0-9a-f]+ <[^>]+> 9098      	addiu	a0,a0,-8
[0-9a-f]+ <[^>]+> 90b8      	addiu	a1,a1,-8
[0-9a-f]+ <[^>]+> 90d8      	addiu	a2,a2,-8
[0-9a-f]+ <[^>]+> 90f8      	addiu	a3,a3,-8
[0-9a-f]+ <[^>]+> 9118      	addiu	t0,t0,-8
[0-9a-f]+ <[^>]+> 9138      	addiu	t1,t1,-8
[0-9a-f]+ <[^>]+> 9158      	addiu	t2,t2,-8
[0-9a-f]+ <[^>]+> 93d8      	addiu	s8,s8,-8
[0-9a-f]+ <[^>]+> 93f8      	addiu	ra,ra,-8
[0-9a-f]+ <[^>]+> 93f9      	addiu	ra,ra,-7
[0-9a-f]+ <[^>]+> 93e8      	addiu	ra,ra,0
[0-9a-f]+ <[^>]+> 93e9      	addiu	ra,ra,1
[0-9a-f]+ <[^>]+> 93ee      	addiu	ra,ra,6
[0-9a-f]+ <[^>]+> 93ef      	addiu	ra,ra,7
[0-9a-f]+ <[^>]+> 03ff 0008 	addiu	ra,ra,8
[0-9a-f]+ <[^>]+> 03bd 9bf8 	addiu	sp,sp,-1032
[0-9a-f]+ <[^>]+> 03bd 9bfc 	addiu	sp,sp,-1028
[0-9a-f]+ <[^>]+> 03bd 9c00 	addiu	sp,sp,-1024
[0-9a-f]+ <[^>]+> 03bd 03fc 	addiu	sp,sp,1020
[0-9a-f]+ <[^>]+> 03bd 0400 	addiu	sp,sp,1024
[0-9a-f]+ <[^>]+> 03bd 0404 	addiu	sp,sp,1028
[0-9a-f]+ <[^>]+> 03bd 0404 	addiu	sp,sp,1028
[0-9a-f]+ <[^>]+> 03bd 0408 	addiu	sp,sp,1032
[0-9a-f]+ <[^>]+> 905f      	addiu	v0,v0,-1
[0-9a-f]+ <[^>]+> 0043 9fff 	addiu	v0,v1,-1
[0-9a-f]+ <[^>]+> 0044 9fff 	addiu	v0,a0,-1
[0-9a-f]+ <[^>]+> 0045 9fff 	addiu	v0,a1,-1
[0-9a-f]+ <[^>]+> 0046 9fff 	addiu	v0,a2,-1
[0-9a-f]+ <[^>]+> 0047 9fff 	addiu	v0,a3,-1
[0-9a-f]+ <[^>]+> 0050 9fff 	addiu	v0,s0,-1
[0-9a-f]+ <[^>]+> 0051 9fff 	addiu	v0,s1,-1
[0-9a-f]+ <[^>]+> 0051 0001 	addiu	v0,s1,1
[0-9a-f]+ <[^>]+> 9111      	addiu	s2,s1,4
[0-9a-f]+ <[^>]+> 9112      	addiu	s2,s1,8
[0-9a-f]+ <[^>]+> 9113      	addiu	s2,s1,12
[0-9a-f]+ <[^>]+> 9114      	addiu	s2,s1,16
[0-9a-f]+ <[^>]+> 9115      	addiu	s2,s1,20
[0-9a-f]+ <[^>]+> 9116      	addiu	s2,s1,24
[0-9a-f]+ <[^>]+> 9196      	addiu	s3,s1,24
[0-9a-f]+ <[^>]+> 9216      	addiu	a0,s1,24
[0-9a-f]+ <[^>]+> 9296      	addiu	a1,s1,24
[0-9a-f]+ <[^>]+> 9316      	addiu	a2,s1,24
[0-9a-f]+ <[^>]+> 9396      	addiu	a3,s1,24
[0-9a-f]+ <[^>]+> 9016      	addiu	s0,s1,24
[0-9a-f]+ <[^>]+> 9096      	addiu	s1,s1,24
[0-9a-f]+ <[^>]+> 7140      	addiu	s2,sp,0
[0-9a-f]+ <[^>]+> 7141      	addiu	s2,sp,4
[0-9a-f]+ <[^>]+> 717e      	addiu	s2,sp,248
[0-9a-f]+ <[^>]+> 717f      	addiu	s2,sp,252
[0-9a-f]+ <[^>]+> 005d 0100 	addiu	v0,sp,256
[0-9a-f]+ <[^>]+> 717f      	addiu	s2,sp,252
[0-9a-f]+ <[^>]+> 71ff      	addiu	s3,sp,252
[0-9a-f]+ <[^>]+> 727f      	addiu	a0,sp,252
[0-9a-f]+ <[^>]+> 72ff      	addiu	a1,sp,252
[0-9a-f]+ <[^>]+> 737f      	addiu	a2,sp,252
[0-9a-f]+ <[^>]+> 73ff      	addiu	a3,sp,252
[0-9a-f]+ <[^>]+> 707f      	addiu	s0,sp,252
[0-9a-f]+ <[^>]+> 70ff      	addiu	s1,sp,252
[0-9a-f]+ <[^>]+> 0064 8000 	addiu	v1,a0,-8192
[0-9a-f]+ <[^>]+> 91c0      	addiu	s3,a0,0
[0-9a-f]+ <[^>]+> 0064 1fff 	addiu	v1,a0,8191
[0-9a-f]+ <[^>]+> 0064 9fff 	addiu	v1,a0,-1
[0-9a-f]+ <[^>]+> 6061 0000 3fff 	addiu	v1,v1,16383
[0-9a-f]+ <[^>]+> 6061 0000 3fff 	addiu	v1,v1,16383
[0-9a-f]+ <[^>]+> 2016 1150 	move	v0,s6
[0-9a-f]+ <[^>]+> 2002 b150 	move	s6,v0
[0-9a-f]+ <[^>]+> 22c0 1150 	addu	v0,zero,s6
[0-9a-f]+ <[^>]+> 2040 b150 	addu	s6,zero,v0
[0-9a-f]+ <[^>]+> b134      	addu	s2,s3,s2
[0-9a-f]+ <[^>]+> b1b4      	addu	s2,s3,s3
[0-9a-f]+ <[^>]+> b234      	addu	s2,s3,a0
[0-9a-f]+ <[^>]+> b2b4      	addu	s2,s3,a1
[0-9a-f]+ <[^>]+> b334      	addu	s2,s3,a2
[0-9a-f]+ <[^>]+> b3b4      	addu	s2,s3,a3
[0-9a-f]+ <[^>]+> b034      	addu	s2,s3,s0
[0-9a-f]+ <[^>]+> b0b4      	addu	s2,s3,s1
[0-9a-f]+ <[^>]+> b0a4      	addu	s2,s2,s1
[0-9a-f]+ <[^>]+> b0b4      	addu	s2,s3,s1
[0-9a-f]+ <[^>]+> b0c4      	addu	s2,a0,s1
[0-9a-f]+ <[^>]+> b0d4      	addu	s2,a1,s1
[0-9a-f]+ <[^>]+> b0e4      	addu	s2,a2,s1
[0-9a-f]+ <[^>]+> b0f4      	addu	s2,a3,s1
[0-9a-f]+ <[^>]+> b084      	addu	s2,s0,s1
[0-9a-f]+ <[^>]+> b094      	addu	s2,s1,s1
[0-9a-f]+ <[^>]+> b0a4      	addu	s2,s2,s1
[0-9a-f]+ <[^>]+> b0a6      	addu	s3,s2,s1
[0-9a-f]+ <[^>]+> b0a8      	addu	a0,s2,s1
[0-9a-f]+ <[^>]+> b0aa      	addu	a1,s2,s1
[0-9a-f]+ <[^>]+> b0ac      	addu	a2,s2,s1
[0-9a-f]+ <[^>]+> b0ae      	addu	a3,s2,s1
[0-9a-f]+ <[^>]+> b0a0      	addu	s0,s2,s1
[0-9a-f]+ <[^>]+> b0a2      	addu	s1,s2,s1
[0-9a-f]+ <[^>]+> b17e      	addu	a3,a3,s2
[0-9a-f]+ <[^>]+> b17e      	addu	a3,a3,s2
[0-9a-f]+ <[^>]+> b3ae      	addu	a3,s2,a3
[0-9a-f]+ <[^>]+> 23fe e950 	addu	sp,s8,ra
[0-9a-f]+ <[^>]+> 0042 0000 	addiu	v0,v0,0
[0-9a-f]+ <[^>]+> 0042 0001 	addiu	v0,v0,1
[0-9a-f]+ <[^>]+> 6020 0000 7fff 	li	at,0x7fff
[0-9a-f]+ <[^>]+> 2022 1150 	addu	v0,v0,at
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2022 1150 	addu	v0,v0,at
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 2022 1150 	addu	v0,v0,at
[0-9a-f]+ <[^>]+> 5128      	and	s2,s2,s2
[0-9a-f]+ <[^>]+> 5138      	and	s2,s2,s3
[0-9a-f]+ <[^>]+> 5148      	and	s2,s2,a0
[0-9a-f]+ <[^>]+> 5158      	and	s2,s2,a1
[0-9a-f]+ <[^>]+> 5168      	and	s2,s2,a2
[0-9a-f]+ <[^>]+> 5178      	and	s2,s2,a3
[0-9a-f]+ <[^>]+> 5108      	and	s2,s2,s0
[0-9a-f]+ <[^>]+> 5118      	and	s2,s2,s1
[0-9a-f]+ <[^>]+> 51a8      	and	s3,s3,s2
[0-9a-f]+ <[^>]+> 5228      	and	a0,a0,s2
[0-9a-f]+ <[^>]+> 52a8      	and	a1,a1,s2
[0-9a-f]+ <[^>]+> 5328      	and	a2,a2,s2
[0-9a-f]+ <[^>]+> 53a8      	and	a3,a3,s2
[0-9a-f]+ <[^>]+> 5028      	and	s0,s0,s2
[0-9a-f]+ <[^>]+> 50a8      	and	s1,s1,s2
[0-9a-f]+ <[^>]+> 5138      	and	s2,s2,s3
[0-9a-f]+ <[^>]+> 5138      	and	s2,s2,s3
[0-9a-f]+ <[^>]+> 5138      	and	s2,s2,s3
[0-9a-f]+ <[^>]+> 5138      	and	s2,s2,s3
[0-9a-f]+ <[^>]+> 2062 1250 	and	v0,v0,v1
[0-9a-f]+ <[^>]+> f121      	andi	s2,s2,0x1
[0-9a-f]+ <[^>]+> f122      	andi	s2,s2,0x2
[0-9a-f]+ <[^>]+> f123      	andi	s2,s2,0x3
[0-9a-f]+ <[^>]+> f124      	andi	s2,s2,0x4
[0-9a-f]+ <[^>]+> f127      	andi	s2,s2,0x7
[0-9a-f]+ <[^>]+> f128      	andi	s2,s2,0x8
[0-9a-f]+ <[^>]+> f12f      	andi	s2,s2,0xf
[0-9a-f]+ <[^>]+> 8042 2010 	andi	v0,v0,16
[0-9a-f]+ <[^>]+> 8042 201f 	andi	v0,v0,31
[0-9a-f]+ <[^>]+> 8042 2020 	andi	v0,v0,32
[0-9a-f]+ <[^>]+> 8042 203f 	andi	v0,v0,63
[0-9a-f]+ <[^>]+> 8042 2040 	andi	v0,v0,64
[0-9a-f]+ <[^>]+> 8042 2080 	andi	v0,v0,128
[0-9a-f]+ <[^>]+> f12c      	andi	s2,s2,0xff
[0-9a-f]+ <[^>]+> 8042 2fff 	andi	v0,v0,4095
[0-9a-f]+ <[^>]+> f12d      	andi	s2,s2,0xffff
[0-9a-f]+ <[^>]+> f13d      	andi	s2,s3,0xffff
[0-9a-f]+ <[^>]+> f14d      	andi	s2,a0,0xffff
[0-9a-f]+ <[^>]+> f15d      	andi	s2,a1,0xffff
[0-9a-f]+ <[^>]+> f16d      	andi	s2,a2,0xffff
[0-9a-f]+ <[^>]+> f17d      	andi	s2,a3,0xffff
[0-9a-f]+ <[^>]+> f10d      	andi	s2,s0,0xffff
[0-9a-f]+ <[^>]+> f11d      	andi	s2,s1,0xffff
[0-9a-f]+ <[^>]+> f19d      	andi	s3,s1,0xffff
[0-9a-f]+ <[^>]+> f21d      	andi	a0,s1,0xffff
[0-9a-f]+ <[^>]+> f29d      	andi	a1,s1,0xffff
[0-9a-f]+ <[^>]+> f31d      	andi	a2,s1,0xffff
[0-9a-f]+ <[^>]+> f39d      	andi	a3,s1,0xffff
[0-9a-f]+ <[^>]+> f01d      	andi	s0,s1,0xffff
[0-9a-f]+ <[^>]+> f09d      	andi	s1,s1,0xffff
[0-9a-f]+ <[^>]+> f3fd      	andi	a3,a3,0xffff
[0-9a-f]+ <[^>]+> f3fd      	andi	a3,a3,0xffff
[0-9a-f]+ <[^>]+> f3fd      	andi	a3,a3,0xffff
[0-9a-f]+ <[^>]+> 2083 1250 	and	v0,v1,a0
[0-9a-f]+ <[^>]+> 2082 1250 	and	v0,v0,a0
[0-9a-f]+ <[^>]+> 2082 1250 	and	v0,v0,a0
[0-9a-f]+ <[^>]+> 8043 2000 	andi	v0,v1,0
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 2023 1250 	and	v0,v1,at
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2023 1250 	and	v0,v1,at
[0-9a-f]+ <[^>]+> 6020 ffff 0001 	li	at,0xffff0001
[0-9a-f]+ <[^>]+> 2023 1250 	and	v0,v1,at
[0-9a-f]+ <[^>]+> 9900      	beqzc	s2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9980      	beqzc	s3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9a00      	beqzc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9a80      	beqzc	a1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9b00      	beqzc	a2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9b80      	beqzc	a3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9800      	beqzc	s0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9880      	beqzc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9900      	beqzc	s2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9980      	beqzc	s3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9a00      	beqzc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9a80      	beqzc	a1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9b00      	beqzc	a2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9b80      	beqzc	a3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9800      	beqzc	s0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9880      	beqzc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9900      	beqzc	s2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9980      	beqzc	s3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9a00      	beqzc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9a80      	beqzc	a1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9b00      	beqzc	a2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9b80      	beqzc	a3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9800      	beqzc	s0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9880      	beqzc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> 9800      	beqzc	s0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> ea00 0000 	beqzc	s0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC20_S1	test2-0x4
[0-9a-f]+ <[^>]+> 9880      	beqzc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> ea20 0000 	beqzc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC20_S1	test2-0x4
[0-9a-f]+ <[^>]+> 9880      	beqzc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test2-0x2
[0-9a-f]+ <[^>]+> ea00 0000 	beqzc	s0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC20_S1	test2-0x4
[0-9a-f]+ <[^>]+> ca00 5000 	beqic	s0,10,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC11_S1	test2-0x4
[0-9a-f]+ <[^>]+> 6020 0000 7fff 	li	at,0x7fff
[0-9a-f]+ <[^>]+> 8830 0000 	beqc	s0,at,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test2-0x4
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 8830 0000 	beqc	s0,at,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test2-0x4
[0-9a-f]+ <[^>]+> b900      	bnezc	s2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> b980      	bnezc	s3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> ba00      	bnezc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> ba80      	bnezc	a1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> bb00      	bnezc	a2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> bb80      	bnezc	a3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> b800      	bnezc	s0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> b880      	bnezc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> b900      	bnezc	s2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> b980      	bnezc	s3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> ba00      	bnezc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> ba80      	bnezc	a1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> bb00      	bnezc	a2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> bb80      	bnezc	a3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> b800      	bnezc	s0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> b880      	bnezc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> b900      	bnezc	s2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> b980      	bnezc	s3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> ba00      	bnezc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> ba80      	bnezc	a1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> bb00      	bnezc	a2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> bb80      	bnezc	a3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> b800      	bnezc	s0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> b880      	bnezc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> b800      	bnezc	s0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC7_S1	test3-0x2
[0-9a-f]+ <[^>]+> ea10 0000 	bnezc	s0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC20_S1	test3-0x4
[0-9a-f]+ <[^>]+> ea30 0000 	bnezc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC20_S1	test2-0x4
[0-9a-f]+ <[^>]+> ea30 0000 	bnezc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC20_S1	test2-0x4
[0-9a-f]+ <[^>]+> ea30 0000 	bnezc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC20_S1	test2-0x4
[0-9a-f]+ <[^>]+> 1010      	break
[0-9a-f]+ <[^>]+> 1010      	break
[0-9a-f]+ <[^>]+> 1011      	break	0x1
[0-9a-f]+ <[^>]+> 1012      	break	0x2
[0-9a-f]+ <[^>]+> 1013      	break	0x3
[0-9a-f]+ <[^>]+> 1014      	break	0x4
[0-9a-f]+ <[^>]+> 1015      	break	0x5
[0-9a-f]+ <[^>]+> 1016      	break	0x6
[0-9a-f]+ <[^>]+> 1017      	break	0x7
[0-9a-f]+ <[^>]+> 0010 0008 	break	0x8
[0-9a-f]+ <[^>]+> 0010 0009 	break	0x9
[0-9a-f]+ <[^>]+> 0010 000a 	break	0xa
[0-9a-f]+ <[^>]+> 0010 000b 	break	0xb
[0-9a-f]+ <[^>]+> 0010 000c 	break	0xc
[0-9a-f]+ <[^>]+> 0010 000d 	break	0xd
[0-9a-f]+ <[^>]+> 0010 000e 	break	0xe
[0-9a-f]+ <[^>]+> 0010 000f 	break	0xf
[0-9a-f]+ <[^>]+> 0010 003f 	break	0x3f
[0-9a-f]+ <[^>]+> 0010 0040 	break	0x40
[0-9a-f]+ <[^>]+> 0010 03ff 	break	0x3ff
[0-9a-f]+ <[^>]+> 0010 0000 	break
[0-9a-f]+ <[^>]+> 0010 0000 	break
[0-9a-f]+ <[^>]+> 0010 0001 	break	0x1
[0-9a-f]+ <[^>]+> 0010 0002 	break	0x2
[0-9a-f]+ <[^>]+> 0010 000f 	break	0xf
[0-9a-f]+ <[^>]+> 0010 003f 	break	0x3f
[0-9a-f]+ <[^>]+> 0010 0040 	break	0x40
[0-9a-f]+ <[^>]+> 0010 03ff 	break	0x3ff
[0-9a-f]+ <[^>]+> a400 1900 	cache	0x0,0\(zero\)
[0-9a-f]+ <[^>]+> 0020 9800 	li	at,-2048
[0-9a-f]+ <[^>]+> a401 1900 	cache	0x0,0\(at\)
[0-9a-f]+ <[^>]+> 0020 07ff 	li	at,2047
[0-9a-f]+ <[^>]+> a401 1900 	cache	0x0,0\(at\)
[0-9a-f]+ <[^>]+> 0020 97ff 	li	at,-2049
[0-9a-f]+ <[^>]+> a401 1900 	cache	0x0,0\(at\)
[0-9a-f]+ <[^>]+> 0020 0800 	li	at,2048
[0-9a-f]+ <[^>]+> a401 1900 	cache	0x0,0\(at\)
[0-9a-f]+ <[^>]+> a402 1900 	cache	0x0,0\(v0\)
[0-9a-f]+ <[^>]+> 0022 9800 	addiu	at,v0,-2048
[0-9a-f]+ <[^>]+> a401 1900 	cache	0x0,0\(at\)
[0-9a-f]+ <[^>]+> 0022 07ff 	addiu	at,v0,2047
[0-9a-f]+ <[^>]+> a401 1900 	cache	0x0,0\(at\)
[0-9a-f]+ <[^>]+> 0022 97ff 	addiu	at,v0,-2049
[0-9a-f]+ <[^>]+> a401 1900 	cache	0x0,0\(at\)
[0-9a-f]+ <[^>]+> 0022 0800 	addiu	at,v0,2048
[0-9a-f]+ <[^>]+> a401 1900 	cache	0x0,0\(at\)
[0-9a-f]+ <[^>]+> a400 1900 	cache	0x0,0\(zero\)
[0-9a-f]+ <[^>]+> a400 1900 	cache	0x0,0\(zero\)
[0-9a-f]+ <[^>]+> a420 1900 	cache	0x1,0\(zero\)
[0-9a-f]+ <[^>]+> a440 1900 	cache	0x2,0\(zero\)
[0-9a-f]+ <[^>]+> a460 1900 	cache	0x3,0\(zero\)
[0-9a-f]+ <[^>]+> a480 1900 	cache	0x4,0\(zero\)
[0-9a-f]+ <[^>]+> a4a0 1900 	cache	0x5,0\(zero\)
[0-9a-f]+ <[^>]+> a4c0 1900 	cache	0x6,0\(zero\)
[0-9a-f]+ <[^>]+> a7e0 1900 	cache	0x1f,0\(zero\)
[0-9a-f]+ <[^>]+> 0020 07ff 	li	at,2047
[0-9a-f]+ <[^>]+> a7e1 1900 	cache	0x1f,0\(at\)
[0-9a-f]+ <[^>]+> 0020 9800 	li	at,-2048
[0-9a-f]+ <[^>]+> a7e1 1900 	cache	0x1f,0\(at\)
[0-9a-f]+ <[^>]+> 0020 07ff 	li	at,2047
[0-9a-f]+ <[^>]+> a401 1900 	cache	0x0,0\(at\)
[0-9a-f]+ <[^>]+> 0020 9800 	li	at,-2048
[0-9a-f]+ <[^>]+> a401 1900 	cache	0x0,0\(at\)
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2061 0950 	addu	at,at,v1
[0-9a-f]+ <[^>]+> a7e1 1900 	cache	0x1f,0\(at\)
[0-9a-f]+ <[^>]+> 0023 0800 	addiu	at,v1,2048
[0-9a-f]+ <[^>]+> a7e1 1900 	cache	0x1f,0\(at\)
[0-9a-f]+ <[^>]+> 0023 97ff 	addiu	at,v1,-2049
[0-9a-f]+ <[^>]+> a7e1 1900 	cache	0x1f,0\(at\)
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2061 0950 	addu	at,at,v1
[0-9a-f]+ <[^>]+> a7e1 1901 	cache	0x1f,1\(at\)
[0-9a-f]+ <[^>]+> a7e3 99ff 	cache	0x1f,-1\(v1\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2061 0950 	addu	at,at,v1
[0-9a-f]+ <[^>]+> a7e1 1900 	cache	0x1f,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2061 0950 	addu	at,at,v1
[0-9a-f]+ <[^>]+> a7e1 1901 	cache	0x1f,1\(at\)
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2061 0950 	addu	at,at,v1
[0-9a-f]+ <[^>]+> a7e1 99ff 	cache	0x1f,-1\(at\)
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> a7e1 1900 	cache	0x1f,0\(at\)
[0-9a-f]+ <[^>]+> 0020 0800 	li	at,2048
[0-9a-f]+ <[^>]+> a7e1 1900 	cache	0x1f,0\(at\)
[0-9a-f]+ <[^>]+> 0020 97ff 	li	at,-2049
[0-9a-f]+ <[^>]+> a7e1 1900 	cache	0x1f,0\(at\)
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> a7e1 1901 	cache	0x1f,1\(at\)
[0-9a-f]+ <[^>]+> a7e0 99ff 	cache	0x1f,-1\(zero\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> a7e1 1900 	cache	0x1f,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> a7e1 1901 	cache	0x1f,1\(at\)
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> a7e1 99ff 	cache	0x1f,-1\(at\)
[0-9a-f]+ <[^>]+> 2043 4b3f 	clo	v0,v1
[0-9a-f]+ <[^>]+> 2062 4b3f 	clo	v1,v0
[0-9a-f]+ <[^>]+> 2043 5b3f 	clz	v0,v1
[0-9a-f]+ <[^>]+> 2062 5b3f 	clz	v1,v0
[0-9a-f]+ <[^>]+> 2000 e37f 	deret
[0-9a-f]+ <[^>]+> 2000 477f 	di
[0-9a-f]+ <[^>]+> 2000 477f 	di
[0-9a-f]+ <[^>]+> 2040 477f 	di	v0
[0-9a-f]+ <[^>]+> 2060 477f 	di	v1
[0-9a-f]+ <[^>]+> 23c0 477f 	di	s8
[0-9a-f]+ <[^>]+> 23e0 477f 	di	ra
[0-9a-f]+ <[^>]+> 2062 0118 	div	zero,v0,v1
[0-9a-f]+ <[^>]+> 23fe 0118 	div	zero,s8,ra
[0-9a-f]+ <[^>]+> 2060 0118 	div	zero,zero,v1
[0-9a-f]+ <[^>]+> 23e0 0118 	div	zero,zero,ra
[0-9a-f]+ <[^>]+> 2003 1118 	div	v0,v1,zero
[0-9a-f]+ <[^>]+> 2083 1118 	div	v0,v1,a0
[0-9a-f]+ <[^>]+> 1017      	break	0x7
[0-9a-f]+ <[^>]+> 1060      	move	v1,zero
[0-9a-f]+ <[^>]+> 1060      	move	v1,zero
[0-9a-f]+ <[^>]+> 0020 0002 	li	at,2
[0-9a-f]+ <[^>]+> 2024 1918 	div	v1,a0,at
[0-9a-f]+ <[^>]+> 2062 0198 	divu	zero,v0,v1
[0-9a-f]+ <[^>]+> 23fe 0198 	divu	zero,s8,ra
[0-9a-f]+ <[^>]+> 2060 0198 	divu	zero,zero,v1
[0-9a-f]+ <[^>]+> 23e0 0198 	divu	zero,zero,ra
[0-9a-f]+ <[^>]+> 2003 1198 	divu	v0,v1,zero
[0-9a-f]+ <[^>]+> 2083 1198 	divu	v0,v1,a0
[0-9a-f]+ <[^>]+> 1017      	break	0x7
[0-9a-f]+ <[^>]+> 1060      	move	v1,zero
[0-9a-f]+ <[^>]+> 0020 9fff 	li	at,-1
[0-9a-f]+ <[^>]+> 2024 1998 	divu	v1,a0,at
[0-9a-f]+ <[^>]+> 0020 0002 	li	at,2
[0-9a-f]+ <[^>]+> 2024 1998 	divu	v1,a0,at
[0-9a-f]+ <[^>]+> 2000 577f 	ei
[0-9a-f]+ <[^>]+> 2000 577f 	ei
[0-9a-f]+ <[^>]+> 2040 577f 	ei	v0
[0-9a-f]+ <[^>]+> 2060 577f 	ei	v1
[0-9a-f]+ <[^>]+> 23c0 577f 	ei	s8
[0-9a-f]+ <[^>]+> 23e0 577f 	ei	ra
[0-9a-f]+ <[^>]+> 2000 f37f 	eret
[0-9a-f]+ <[^>]+> 8043 f385 	ext	v0,v1,0x5,0xf
[0-9a-f]+ <[^>]+> 8043 f7c0 	ext	v0,v1,0x0,0x20
[0-9a-f]+ <[^>]+> 8043 f01f 	ext	v0,v1,0x1f,0x1
[0-9a-f]+ <[^>]+> 83fe f01f 	ext	ra,s8,0x1f,0x1
[0-9a-f]+ <[^>]+> 8043 e4c5 	ins	v0,v1,0x5,0xf
[0-9a-f]+ <[^>]+> 8043 e7c0 	ins	v0,v1,0x0,0x20
[0-9a-f]+ <[^>]+> 8043 e7df 	ins	v0,v1,0x1f,0x1
[0-9a-f]+ <[^>]+> 83fe e7df 	ins	ra,s8,0x1f,0x1
[0-9a-f]+ <[^>]+> d800      	jrc	zero
[0-9a-f]+ <[^>]+> d840      	jrc	v0
[0-9a-f]+ <[^>]+> d860      	jrc	v1
[0-9a-f]+ <[^>]+> d880      	jrc	a0
[0-9a-f]+ <[^>]+> d8a0      	jrc	a1
[0-9a-f]+ <[^>]+> d8c0      	jrc	a2
[0-9a-f]+ <[^>]+> d8e0      	jrc	a3
[0-9a-f]+ <[^>]+> d900      	jrc	t0
[0-9a-f]+ <[^>]+> dbc0      	jrc	s8
[0-9a-f]+ <[^>]+> dbe0      	jrc	ra
[0-9a-f]+ <[^>]+> 4800 0000 	jrc	zero
[0-9a-f]+ <[^>]+> 4802 0000 	jrc	v0
[0-9a-f]+ <[^>]+> 4803 0000 	jrc	v1
[0-9a-f]+ <[^>]+> 4804 0000 	jrc	a0
[0-9a-f]+ <[^>]+> 4805 0000 	jrc	a1
[0-9a-f]+ <[^>]+> 4806 0000 	jrc	a2
[0-9a-f]+ <[^>]+> 4807 0000 	jrc	a3
[0-9a-f]+ <[^>]+> 4808 0000 	jrc	t0
[0-9a-f]+ <[^>]+> 481e 0000 	jrc	s8
[0-9a-f]+ <[^>]+> 481f 0000 	jrc	ra
[0-9a-f]+ <[^>]+> d800      	jrc	zero
[0-9a-f]+ <[^>]+> d840      	jrc	v0
[0-9a-f]+ <[^>]+> d860      	jrc	v1
[0-9a-f]+ <[^>]+> d880      	jrc	a0
[0-9a-f]+ <[^>]+> d8a0      	jrc	a1
[0-9a-f]+ <[^>]+> d8c0      	jrc	a2
[0-9a-f]+ <[^>]+> d8e0      	jrc	a3
[0-9a-f]+ <[^>]+> d900      	jrc	t0
[0-9a-f]+ <[^>]+> dbc0      	jrc	s8
[0-9a-f]+ <[^>]+> dbe0      	jrc	ra
[0-9a-f]+ <[^>]+> 4800 1000 	jrc\.hb	zero
[0-9a-f]+ <[^>]+> 4802 1000 	jrc\.hb	v0
[0-9a-f]+ <[^>]+> 4803 1000 	jrc\.hb	v1
[0-9a-f]+ <[^>]+> 4804 1000 	jrc\.hb	a0
[0-9a-f]+ <[^>]+> 4805 1000 	jrc\.hb	a1
[0-9a-f]+ <[^>]+> 4806 1000 	jrc\.hb	a2
[0-9a-f]+ <[^>]+> 4807 1000 	jrc\.hb	a3
[0-9a-f]+ <[^>]+> 4808 1000 	jrc\.hb	t0
[0-9a-f]+ <[^>]+> 481e 1000 	jrc\.hb	s8
[0-9a-f]+ <[^>]+> 481f 1000 	jrc\.hb	ra
[0-9a-f]+ <[^>]+> 4800 0000 	jrc	zero
[0-9a-f]+ <[^>]+> 4802 0000 	jrc	v0
[0-9a-f]+ <[^>]+> 4803 0000 	jrc	v1
[0-9a-f]+ <[^>]+> 4804 0000 	jrc	a0
[0-9a-f]+ <[^>]+> 4805 0000 	jrc	a1
[0-9a-f]+ <[^>]+> 4806 0000 	jrc	a2
[0-9a-f]+ <[^>]+> 4807 0000 	jrc	a3
[0-9a-f]+ <[^>]+> 4808 0000 	jrc	t0
[0-9a-f]+ <[^>]+> 481e 0000 	jrc	s8
[0-9a-f]+ <[^>]+> 481f 0000 	jrc	ra
[0-9a-f]+ <[^>]+> d810      	jalrc	zero
[0-9a-f]+ <[^>]+> d850      	jalrc	v0
[0-9a-f]+ <[^>]+> d870      	jalrc	v1
[0-9a-f]+ <[^>]+> d890      	jalrc	a0
[0-9a-f]+ <[^>]+> d8b0      	jalrc	a1
[0-9a-f]+ <[^>]+> d8d0      	jalrc	a2
[0-9a-f]+ <[^>]+> d8f0      	jalrc	a3
[0-9a-f]+ <[^>]+> d910      	jalrc	t0
[0-9a-f]+ <[^>]+> dbd0      	jalrc	s8
[0-9a-f]+ <[^>]+> 4be0 0000 	jalrc	zero
[0-9a-f]+ <[^>]+> 4be2 0000 	jalrc	v0
[0-9a-f]+ <[^>]+> 4be3 0000 	jalrc	v1
[0-9a-f]+ <[^>]+> 4be4 0000 	jalrc	a0
[0-9a-f]+ <[^>]+> 4be5 0000 	jalrc	a1
[0-9a-f]+ <[^>]+> 4be6 0000 	jalrc	a2
[0-9a-f]+ <[^>]+> 4be7 0000 	jalrc	a3
[0-9a-f]+ <[^>]+> 4be8 0000 	jalrc	t0
[0-9a-f]+ <[^>]+> 4bfe 0000 	jalrc	s8
[0-9a-f]+ <[^>]+> d810      	jalrc	zero
[0-9a-f]+ <[^>]+> d850      	jalrc	v0
[0-9a-f]+ <[^>]+> d870      	jalrc	v1
[0-9a-f]+ <[^>]+> d890      	jalrc	a0
[0-9a-f]+ <[^>]+> d8b0      	jalrc	a1
[0-9a-f]+ <[^>]+> d8d0      	jalrc	a2
[0-9a-f]+ <[^>]+> d8f0      	jalrc	a3
[0-9a-f]+ <[^>]+> d910      	jalrc	t0
[0-9a-f]+ <[^>]+> dbd0      	jalrc	s8
[0-9a-f]+ <[^>]+> 4bdf 0000 	jalrc	s8,ra
[0-9a-f]+ <[^>]+> 4840 0000 	jalrc	v0,zero
[0-9a-f]+ <[^>]+> 4862 0000 	jalrc	v1,v0
[0-9a-f]+ <[^>]+> 4843 0000 	jalrc	v0,v1
[0-9a-f]+ <[^>]+> 4844 0000 	jalrc	v0,a0
[0-9a-f]+ <[^>]+> 4845 0000 	jalrc	v0,a1
[0-9a-f]+ <[^>]+> 4846 0000 	jalrc	v0,a2
[0-9a-f]+ <[^>]+> 4847 0000 	jalrc	v0,a3
[0-9a-f]+ <[^>]+> 4848 0000 	jalrc	v0,t0
[0-9a-f]+ <[^>]+> 485e 0000 	jalrc	v0,s8
[0-9a-f]+ <[^>]+> 485f 0000 	jalrc	v0,ra
[0-9a-f]+ <[^>]+> 4be0 1000 	jalrc\.hb	zero
[0-9a-f]+ <[^>]+> 4be2 1000 	jalrc\.hb	v0
[0-9a-f]+ <[^>]+> 4be3 1000 	jalrc\.hb	v1
[0-9a-f]+ <[^>]+> 4be4 1000 	jalrc\.hb	a0
[0-9a-f]+ <[^>]+> 4be5 1000 	jalrc\.hb	a1
[0-9a-f]+ <[^>]+> 4be6 1000 	jalrc\.hb	a2
[0-9a-f]+ <[^>]+> 4be7 1000 	jalrc\.hb	a3
[0-9a-f]+ <[^>]+> 4be8 1000 	jalrc\.hb	t0
[0-9a-f]+ <[^>]+> 4bfe 1000 	jalrc\.hb	s8
[0-9a-f]+ <[^>]+> 4be0 1000 	jalrc\.hb	zero
[0-9a-f]+ <[^>]+> 4be2 1000 	jalrc\.hb	v0
[0-9a-f]+ <[^>]+> 4be3 1000 	jalrc\.hb	v1
[0-9a-f]+ <[^>]+> 4be4 1000 	jalrc\.hb	a0
[0-9a-f]+ <[^>]+> 4be5 1000 	jalrc\.hb	a1
[0-9a-f]+ <[^>]+> 4be6 1000 	jalrc\.hb	a2
[0-9a-f]+ <[^>]+> 4be7 1000 	jalrc\.hb	a3
[0-9a-f]+ <[^>]+> 4be8 1000 	jalrc\.hb	t0
[0-9a-f]+ <[^>]+> 4bfe 1000 	jalrc\.hb	s8
[0-9a-f]+ <[^>]+> 4bdf 1000 	jalrc\.hb	s8,ra
[0-9a-f]+ <[^>]+> 4840 1000 	jalrc\.hb	v0,zero
[0-9a-f]+ <[^>]+> 4862 1000 	jalrc\.hb	v1,v0
[0-9a-f]+ <[^>]+> 4843 1000 	jalrc\.hb	v0,v1
[0-9a-f]+ <[^>]+> 4844 1000 	jalrc\.hb	v0,a0
[0-9a-f]+ <[^>]+> 4845 1000 	jalrc\.hb	v0,a1
[0-9a-f]+ <[^>]+> 4846 1000 	jalrc\.hb	v0,a2
[0-9a-f]+ <[^>]+> 4847 1000 	jalrc\.hb	v0,a3
[0-9a-f]+ <[^>]+> 4848 1000 	jalrc\.hb	v0,t0
[0-9a-f]+ <[^>]+> 485e 1000 	jalrc\.hb	v0,s8
[0-9a-f]+ <[^>]+> 485f 1000 	jalrc\.hb	v0,ra
[0-9a-f]+ <[^>]+> 4843 0000 	jalrc	v0,v1
[0-9a-f]+ <[^>]+> 4bdf 0000 	jalrc	s8,ra
[0-9a-f]+ <[^>]+> d870      	jalrc	v1
[0-9a-f]+ <[^>]+> dbf0      	jalrc	ra
[0-9a-f]+ <[^>]+> 2a00 0000 	balc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC25_S1	test-0x4
[0-9a-f]+ <[^>]+> 2a00 0000 	balc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC25_S1	test2-0x4
[0-9a-f]+ <[^>]+> 6040 0000 0000 	li	v0,0x0
			[0-9a-f]+: R_MICROMIPS_32	test
[0-9a-f]+ <[^>]+> 8460 0000 	lb	v1,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 0004 	lb	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 0000 	lb	v1,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 0004 	lb	v1,4\(zero\)
[0-9a-f]+ <[^>]+> e060 7000 	lui	v1,0x7
[0-9a-f]+ <[^>]+> 8463 0fff 	lb	v1,4095\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 8463 0000 	lb	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e060 f000 	lui	v1,0xf
[0-9a-f]+ <[^>]+> 8463 0fff 	lb	v1,4095\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> 8463 0000 	lb	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 8463 0000 	lb	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> 8463 0001 	lb	v1,1\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 8463 0001 	lb	v1,1\(v1\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	v1,0xf0000
[0-9a-f]+ <[^>]+> 8463 0000 	lb	v1,0\(v1\)
[0-9a-f]+ <[^>]+> 0060 9fff 	li	v1,-1
[0-9a-f]+ <[^>]+> 8463 0000 	lb	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e074 5244 	lui	v1,0x12345
[0-9a-f]+ <[^>]+> 8463 0678 	lb	v1,1656\(v1\)
[0-9a-f]+ <[^>]+> 15c0      	lb	s3,0\(a0\)
[0-9a-f]+ <[^>]+> 15c0      	lb	s3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 0004 	lb	v1,4\(a0\)
[0-9a-f]+ <[^>]+> e060 7000 	lui	v1,0x7
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 0fff 	lb	v1,4095\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 0000 	lb	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e060 f000 	lui	v1,0xf
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 0fff 	lb	v1,4095\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 0000 	lb	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 0000 	lb	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 0001 	lb	v1,1\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 0001 	lb	v1,1\(v1\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	v1,0xf0000
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 0000 	lb	v1,0\(v1\)
[0-9a-f]+ <[^>]+> 0064 9fff 	addiu	v1,a0,-1
[0-9a-f]+ <[^>]+> 8463 0000 	lb	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e074 5244 	lui	v1,0x12345
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 0678 	lb	v1,1656\(v1\)
[0-9a-f]+ <[^>]+> a443 90ff 	lbu	v0,-1\(v1\)
[0-9a-f]+ <[^>]+> 1538      	lbu	s2,0\(s3\)
[0-9a-f]+ <[^>]+> 1538      	lbu	s2,0\(s3\)
[0-9a-f]+ <[^>]+> 1539      	lbu	s2,1\(s3\)
[0-9a-f]+ <[^>]+> 153a      	lbu	s2,2\(s3\)
[0-9a-f]+ <[^>]+> 153b      	lbu	s2,3\(s3\)
[0-9a-f]+ <[^>]+> 8443 2004 	lbu	v0,4\(v1\)
[0-9a-f]+ <[^>]+> 8443 2005 	lbu	v0,5\(v1\)
[0-9a-f]+ <[^>]+> 8443 2006 	lbu	v0,6\(v1\)
[0-9a-f]+ <[^>]+> 8443 2007 	lbu	v0,7\(v1\)
[0-9a-f]+ <[^>]+> 8443 2008 	lbu	v0,8\(v1\)
[0-9a-f]+ <[^>]+> 8443 2009 	lbu	v0,9\(v1\)
[0-9a-f]+ <[^>]+> 8443 200a 	lbu	v0,10\(v1\)
[0-9a-f]+ <[^>]+> 8443 200b 	lbu	v0,11\(v1\)
[0-9a-f]+ <[^>]+> 8443 200c 	lbu	v0,12\(v1\)
[0-9a-f]+ <[^>]+> 8443 200d 	lbu	v0,13\(v1\)
[0-9a-f]+ <[^>]+> 8443 200e 	lbu	v0,14\(v1\)
[0-9a-f]+ <[^>]+> 8442 200e 	lbu	v0,14\(v0\)
[0-9a-f]+ <[^>]+> 8444 200e 	lbu	v0,14\(a0\)
[0-9a-f]+ <[^>]+> 8445 200e 	lbu	v0,14\(a1\)
[0-9a-f]+ <[^>]+> 8446 200e 	lbu	v0,14\(a2\)
[0-9a-f]+ <[^>]+> 8447 200e 	lbu	v0,14\(a3\)
[0-9a-f]+ <[^>]+> 8450 200e 	lbu	v0,14\(s0\)
[0-9a-f]+ <[^>]+> 8451 200e 	lbu	v0,14\(s1\)
[0-9a-f]+ <[^>]+> 8471 200e 	lbu	v1,14\(s1\)
[0-9a-f]+ <[^>]+> 8491 200e 	lbu	a0,14\(s1\)
[0-9a-f]+ <[^>]+> 84b1 200e 	lbu	a1,14\(s1\)
[0-9a-f]+ <[^>]+> 84d1 200e 	lbu	a2,14\(s1\)
[0-9a-f]+ <[^>]+> 84f1 200e 	lbu	a3,14\(s1\)
[0-9a-f]+ <[^>]+> 8611 200e 	lbu	s0,14\(s1\)
[0-9a-f]+ <[^>]+> 8631 200e 	lbu	s1,14\(s1\)
[0-9a-f]+ <[^>]+> 8460 2000 	lbu	v1,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 2004 	lbu	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 2000 	lbu	v1,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 2004 	lbu	v1,4\(zero\)
[0-9a-f]+ <[^>]+> e060 7000 	lui	v1,0x7
[0-9a-f]+ <[^>]+> 8463 2fff 	lbu	v1,4095\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 8463 2000 	lbu	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e060 f000 	lui	v1,0xf
[0-9a-f]+ <[^>]+> 8463 2fff 	lbu	v1,4095\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> 8463 2000 	lbu	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 8463 2000 	lbu	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> 8463 2001 	lbu	v1,1\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 8463 2001 	lbu	v1,1\(v1\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	v1,0xf0000
[0-9a-f]+ <[^>]+> 8463 2000 	lbu	v1,0\(v1\)
[0-9a-f]+ <[^>]+> 0060 9fff 	li	v1,-1
[0-9a-f]+ <[^>]+> 8463 2000 	lbu	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e074 5244 	lui	v1,0x12345
[0-9a-f]+ <[^>]+> 8463 2678 	lbu	v1,1656\(v1\)
[0-9a-f]+ <[^>]+> 15c8      	lbu	s3,0\(a0\)
[0-9a-f]+ <[^>]+> 15c8      	lbu	s3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 2004 	lbu	v1,4\(a0\)
[0-9a-f]+ <[^>]+> e060 7000 	lui	v1,0x7
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 2fff 	lbu	v1,4095\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 2000 	lbu	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e060 f000 	lui	v1,0xf
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 2fff 	lbu	v1,4095\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 2000 	lbu	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 2000 	lbu	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 2001 	lbu	v1,1\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 2001 	lbu	v1,1\(v1\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	v1,0xf0000
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 2000 	lbu	v1,0\(v1\)
[0-9a-f]+ <[^>]+> 0064 9fff 	addiu	v1,a0,-1
[0-9a-f]+ <[^>]+> 8463 2000 	lbu	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e074 5244 	lui	v1,0x12345
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 2678 	lbu	v1,1656\(v1\)
[0-9a-f]+ <[^>]+> 8460 4000 	lh	v1,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 4004 	lh	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 4000 	lh	v1,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 4004 	lh	v1,4\(zero\)
[0-9a-f]+ <[^>]+> e060 7000 	lui	v1,0x7
[0-9a-f]+ <[^>]+> 8463 4fff 	lh	v1,4095\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 8463 4000 	lh	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e060 f000 	lui	v1,0xf
[0-9a-f]+ <[^>]+> 8463 4fff 	lh	v1,4095\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> 8463 4000 	lh	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 8463 4000 	lh	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> 8463 4001 	lh	v1,1\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 8463 4001 	lh	v1,1\(v1\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	v1,0xf0000
[0-9a-f]+ <[^>]+> 8463 4000 	lh	v1,0\(v1\)
[0-9a-f]+ <[^>]+> 0060 9fff 	li	v1,-1
[0-9a-f]+ <[^>]+> 8463 4000 	lh	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e074 5244 	lui	v1,0x12345
[0-9a-f]+ <[^>]+> 8463 4678 	lh	v1,1656\(v1\)
[0-9a-f]+ <[^>]+> 35c0      	lh	s3,0\(a0\)
[0-9a-f]+ <[^>]+> 35c0      	lh	s3,0\(a0\)
[0-9a-f]+ <[^>]+> 35c4      	lh	s3,4\(a0\)
[0-9a-f]+ <[^>]+> e060 7000 	lui	v1,0x7
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 4fff 	lh	v1,4095\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 4000 	lh	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e060 f000 	lui	v1,0xf
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 4fff 	lh	v1,4095\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 4000 	lh	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 4000 	lh	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 4001 	lh	v1,1\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 4001 	lh	v1,1\(v1\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	v1,0xf0000
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 4000 	lh	v1,0\(v1\)
[0-9a-f]+ <[^>]+> 0064 9fff 	addiu	v1,a0,-1
[0-9a-f]+ <[^>]+> 8463 4000 	lh	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e074 5244 	lui	v1,0x12345
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 4678 	lh	v1,1656\(v1\)
[0-9a-f]+ <[^>]+> 3538      	lhu	s2,0\(s3\)
[0-9a-f]+ <[^>]+> 3538      	lhu	s2,0\(s3\)
[0-9a-f]+ <[^>]+> 353a      	lhu	s2,2\(s3\)
[0-9a-f]+ <[^>]+> 353c      	lhu	s2,4\(s3\)
[0-9a-f]+ <[^>]+> 353e      	lhu	s2,6\(s3\)
[0-9a-f]+ <[^>]+> 8443 6008 	lhu	v0,8\(v1\)
[0-9a-f]+ <[^>]+> 8443 600a 	lhu	v0,10\(v1\)
[0-9a-f]+ <[^>]+> 8443 600c 	lhu	v0,12\(v1\)
[0-9a-f]+ <[^>]+> 8443 600e 	lhu	v0,14\(v1\)
[0-9a-f]+ <[^>]+> 8443 6010 	lhu	v0,16\(v1\)
[0-9a-f]+ <[^>]+> 8443 6012 	lhu	v0,18\(v1\)
[0-9a-f]+ <[^>]+> 8443 6014 	lhu	v0,20\(v1\)
[0-9a-f]+ <[^>]+> 8443 6016 	lhu	v0,22\(v1\)
[0-9a-f]+ <[^>]+> 8443 6018 	lhu	v0,24\(v1\)
[0-9a-f]+ <[^>]+> 8443 601a 	lhu	v0,26\(v1\)
[0-9a-f]+ <[^>]+> 8443 601c 	lhu	v0,28\(v1\)
[0-9a-f]+ <[^>]+> 8443 601e 	lhu	v0,30\(v1\)
[0-9a-f]+ <[^>]+> 8444 601e 	lhu	v0,30\(a0\)
[0-9a-f]+ <[^>]+> 8445 601e 	lhu	v0,30\(a1\)
[0-9a-f]+ <[^>]+> 8446 601e 	lhu	v0,30\(a2\)
[0-9a-f]+ <[^>]+> 8447 601e 	lhu	v0,30\(a3\)
[0-9a-f]+ <[^>]+> 8442 601e 	lhu	v0,30\(v0\)
[0-9a-f]+ <[^>]+> 8450 601e 	lhu	v0,30\(s0\)
[0-9a-f]+ <[^>]+> 8451 601e 	lhu	v0,30\(s1\)
[0-9a-f]+ <[^>]+> 8471 601e 	lhu	v1,30\(s1\)
[0-9a-f]+ <[^>]+> 8491 601e 	lhu	a0,30\(s1\)
[0-9a-f]+ <[^>]+> 84b1 601e 	lhu	a1,30\(s1\)
[0-9a-f]+ <[^>]+> 84d1 601e 	lhu	a2,30\(s1\)
[0-9a-f]+ <[^>]+> 84f1 601e 	lhu	a3,30\(s1\)
[0-9a-f]+ <[^>]+> 8611 601e 	lhu	s0,30\(s1\)
[0-9a-f]+ <[^>]+> 8631 601e 	lhu	s1,30\(s1\)
[0-9a-f]+ <[^>]+> 8460 6000 	lhu	v1,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 6004 	lhu	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 6000 	lhu	v1,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 6004 	lhu	v1,4\(zero\)
[0-9a-f]+ <[^>]+> e060 7000 	lui	v1,0x7
[0-9a-f]+ <[^>]+> 8463 6fff 	lhu	v1,4095\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 8463 6000 	lhu	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e060 f000 	lui	v1,0xf
[0-9a-f]+ <[^>]+> 8463 6fff 	lhu	v1,4095\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> 8463 6000 	lhu	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 8463 6000 	lhu	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> 8463 6001 	lhu	v1,1\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 8463 6001 	lhu	v1,1\(v1\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	v1,0xf0000
[0-9a-f]+ <[^>]+> 8463 6000 	lhu	v1,0\(v1\)
[0-9a-f]+ <[^>]+> 0060 9fff 	li	v1,-1
[0-9a-f]+ <[^>]+> 8463 6000 	lhu	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e074 5244 	lui	v1,0x12345
[0-9a-f]+ <[^>]+> 8463 6678 	lhu	v1,1656\(v1\)
[0-9a-f]+ <[^>]+> 35c8      	lhu	s3,0\(a0\)
[0-9a-f]+ <[^>]+> 35c8      	lhu	s3,0\(a0\)
[0-9a-f]+ <[^>]+> 35cc      	lhu	s3,4\(a0\)
[0-9a-f]+ <[^>]+> e060 7000 	lui	v1,0x7
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 6fff 	lhu	v1,4095\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 6000 	lhu	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e060 f000 	lui	v1,0xf
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 6fff 	lhu	v1,4095\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 6000 	lhu	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 6000 	lhu	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 6001 	lhu	v1,1\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 6001 	lhu	v1,1\(v1\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	v1,0xf0000
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 6000 	lhu	v1,0\(v1\)
[0-9a-f]+ <[^>]+> 0064 9fff 	addiu	v1,a0,-1
[0-9a-f]+ <[^>]+> 8463 6000 	lhu	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e074 5244 	lui	v1,0x12345
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 6678 	lhu	v1,1656\(v1\)
[0-9a-f]+ <[^>]+> a460 4100 	ll	v1,0\(zero\)
[0-9a-f]+ <[^>]+> a460 4100 	ll	v1,0\(zero\)
[0-9a-f]+ <[^>]+> a460 4104 	ll	v1,4\(zero\)
[0-9a-f]+ <[^>]+> a460 4104 	ll	v1,4\(zero\)
[0-9a-f]+ <[^>]+> e060 8000 	lui	v1,0x8
[0-9a-f]+ <[^>]+> a463 c1fc 	ll	v1,-4\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> a463 4100 	ll	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e061 0000 	lui	v1,0x10
[0-9a-f]+ <[^>]+> a463 c1fc 	ll	v1,-4\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> a463 4100 	ll	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> a463 4100 	ll	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> a463 4104 	ll	v1,4\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> a463 4104 	ll	v1,4\(v1\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	v1,0xf0000
[0-9a-f]+ <[^>]+> a463 4100 	ll	v1,0\(v1\)
[0-9a-f]+ <[^>]+> a460 c1fc 	ll	v1,-4\(zero\)
[0-9a-f]+ <[^>]+> 6060 1234 5600 	li	v1,0x12345600
[0-9a-f]+ <[^>]+> a463 c1e0 	ll	v1,-32\(v1\)
[0-9a-f]+ <[^>]+> a464 4100 	ll	v1,0\(a0\)
[0-9a-f]+ <[^>]+> a464 4100 	ll	v1,0\(a0\)
[0-9a-f]+ <[^>]+> a464 4104 	ll	v1,4\(a0\)
[0-9a-f]+ <[^>]+> e060 8000 	lui	v1,0x8
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> a463 c1fc 	ll	v1,-4\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> a463 4100 	ll	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e061 0000 	lui	v1,0x10
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> a463 c1fc 	ll	v1,-4\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> a463 4100 	ll	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> a463 4100 	ll	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> a463 4104 	ll	v1,4\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> a463 4104 	ll	v1,4\(v1\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	v1,0xf0000
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> a463 4100 	ll	v1,0\(v1\)
[0-9a-f]+ <[^>]+> a464 c1fc 	ll	v1,-4\(a0\)
[0-9a-f]+ <[^>]+> 6060 1234 5600 	li	v1,0x12345600
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> a463 c1e0 	ll	v1,-32\(v1\)
[0-9a-f]+ <[^>]+> e060 0000 	lui	v1,0x0
[0-9a-f]+ <[^>]+> e07f f0fc 	lui	v1,0x7fff
[0-9a-f]+ <[^>]+> e07f f1fc 	lui	v1,0xffff
[0-9a-f]+ <[^>]+> 7540      	lw	s2,0\(a0\)
[0-9a-f]+ <[^>]+> 7540      	lw	s2,0\(a0\)
[0-9a-f]+ <[^>]+> 7541      	lw	s2,4\(a0\)
[0-9a-f]+ <[^>]+> 7542      	lw	s2,8\(a0\)
[0-9a-f]+ <[^>]+> 7543      	lw	s2,12\(a0\)
[0-9a-f]+ <[^>]+> 7544      	lw	s2,16\(a0\)
[0-9a-f]+ <[^>]+> 7545      	lw	s2,20\(a0\)
[0-9a-f]+ <[^>]+> 7546      	lw	s2,24\(a0\)
[0-9a-f]+ <[^>]+> 7547      	lw	s2,28\(a0\)
[0-9a-f]+ <[^>]+> 7548      	lw	s2,32\(a0\)
[0-9a-f]+ <[^>]+> 7549      	lw	s2,36\(a0\)
[0-9a-f]+ <[^>]+> 754a      	lw	s2,40\(a0\)
[0-9a-f]+ <[^>]+> 754b      	lw	s2,44\(a0\)
[0-9a-f]+ <[^>]+> 754c      	lw	s2,48\(a0\)
[0-9a-f]+ <[^>]+> 754d      	lw	s2,52\(a0\)
[0-9a-f]+ <[^>]+> 754e      	lw	s2,56\(a0\)
[0-9a-f]+ <[^>]+> 754f      	lw	s2,60\(a0\)
[0-9a-f]+ <[^>]+> 755f      	lw	s2,60\(a1\)
[0-9a-f]+ <[^>]+> 756f      	lw	s2,60\(a2\)
[0-9a-f]+ <[^>]+> 757f      	lw	s2,60\(a3\)
[0-9a-f]+ <[^>]+> 752f      	lw	s2,60\(s2\)
[0-9a-f]+ <[^>]+> 753f      	lw	s2,60\(s3\)
[0-9a-f]+ <[^>]+> 750f      	lw	s2,60\(s0\)
[0-9a-f]+ <[^>]+> 751f      	lw	s2,60\(s1\)
[0-9a-f]+ <[^>]+> 759f      	lw	s3,60\(s1\)
[0-9a-f]+ <[^>]+> 761f      	lw	a0,60\(s1\)
[0-9a-f]+ <[^>]+> 769f      	lw	a1,60\(s1\)
[0-9a-f]+ <[^>]+> 771f      	lw	a2,60\(s1\)
[0-9a-f]+ <[^>]+> 779f      	lw	a3,60\(s1\)
[0-9a-f]+ <[^>]+> 741f      	lw	s0,60\(s1\)
[0-9a-f]+ <[^>]+> 749f      	lw	s1,60\(s1\)
[0-9a-f]+ <[^>]+> 5480      	lw	a0,0\(sp\)
[0-9a-f]+ <[^>]+> 5480      	lw	a0,0\(sp\)
[0-9a-f]+ <[^>]+> 5481      	lw	a0,4\(sp\)
[0-9a-f]+ <[^>]+> 5482      	lw	a0,8\(sp\)
[0-9a-f]+ <[^>]+> 5483      	lw	a0,12\(sp\)
[0-9a-f]+ <[^>]+> 5484      	lw	a0,16\(sp\)
[0-9a-f]+ <[^>]+> 5485      	lw	a0,20\(sp\)
[0-9a-f]+ <[^>]+> 549f      	lw	a0,124\(sp\)
[0-9a-f]+ <[^>]+> 545f      	lw	v0,124\(sp\)
[0-9a-f]+ <[^>]+> 545f      	lw	v0,124\(sp\)
[0-9a-f]+ <[^>]+> 547f      	lw	v1,124\(sp\)
[0-9a-f]+ <[^>]+> 549f      	lw	a0,124\(sp\)
[0-9a-f]+ <[^>]+> 54bf      	lw	a1,124\(sp\)
[0-9a-f]+ <[^>]+> 54df      	lw	a2,124\(sp\)
[0-9a-f]+ <[^>]+> 54ff      	lw	a3,124\(sp\)
[0-9a-f]+ <[^>]+> 551f      	lw	t0,124\(sp\)
[0-9a-f]+ <[^>]+> 553f      	lw	t1,124\(sp\)
[0-9a-f]+ <[^>]+> 555f      	lw	t2,124\(sp\)
[0-9a-f]+ <[^>]+> 57df      	lw	s8,124\(sp\)
[0-9a-f]+ <[^>]+> 57ff      	lw	ra,124\(sp\)
[0-9a-f]+ <[^>]+> 849d 81f8 	lw	a0,504\(sp\)
[0-9a-f]+ <[^>]+> 849d 81fc 	lw	a0,508\(sp\)
[0-9a-f]+ <[^>]+> 861d 81fc 	lw	s0,508\(sp\)
[0-9a-f]+ <[^>]+> 863d 81fc 	lw	s1,508\(sp\)
[0-9a-f]+ <[^>]+> 865d 81fc 	lw	s2,508\(sp\)
[0-9a-f]+ <[^>]+> 867d 81fc 	lw	s3,508\(sp\)
[0-9a-f]+ <[^>]+> 869d 81fc 	lw	s4,508\(sp\)
[0-9a-f]+ <[^>]+> 86bd 81fc 	lw	s5,508\(sp\)
[0-9a-f]+ <[^>]+> 87fd 81fc 	lw	ra,508\(sp\)
[0-9a-f]+ <[^>]+> 8460 8000 	lw	v1,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 8004 	lw	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 9460      	lw	v1,0\(zero\)
[0-9a-f]+ <[^>]+> 9460      	lw	v1,0\(zero\)
[0-9a-f]+ <[^>]+> 9460      	lw	v1,0\(zero\)
[0-9a-f]+ <[^>]+> 9560      	lw	v1,4\(zero\)
[0-9a-f]+ <[^>]+> e060 7000 	lui	v1,0x7
[0-9a-f]+ <[^>]+> 8463 8fff 	lw	v1,4095\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 8463 8000 	lw	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e060 f000 	lui	v1,0xf
[0-9a-f]+ <[^>]+> 8463 8fff 	lw	v1,4095\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> 8463 8000 	lw	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 8463 8000 	lw	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> 8463 8001 	lw	v1,1\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 8463 8001 	lw	v1,1\(v1\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	v1,0xf0000
[0-9a-f]+ <[^>]+> 8463 8000 	lw	v1,0\(v1\)
[0-9a-f]+ <[^>]+> 0060 9fff 	li	v1,-1
[0-9a-f]+ <[^>]+> 8463 8000 	lw	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e074 5244 	lui	v1,0x12345
[0-9a-f]+ <[^>]+> 8463 8678 	lw	v1,1656\(v1\)
[0-9a-f]+ <[^>]+> 75c0      	lw	s3,0\(a0\)
[0-9a-f]+ <[^>]+> 75c0      	lw	s3,0\(a0\)
[0-9a-f]+ <[^>]+> 75c1      	lw	s3,4\(a0\)
[0-9a-f]+ <[^>]+> e060 7000 	lui	v1,0x7
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 8fff 	lw	v1,4095\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 8000 	lw	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e060 f000 	lui	v1,0xf
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 8fff 	lw	v1,4095\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 8000 	lw	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 8000 	lw	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	v1,0xffff0
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 8001 	lw	v1,1\(v1\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	v1,0xffff8
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 8001 	lw	v1,1\(v1\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	v1,0xf0000
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 8000 	lw	v1,0\(v1\)
[0-9a-f]+ <[^>]+> 0064 9fff 	addiu	v1,a0,-1
[0-9a-f]+ <[^>]+> 8463 8000 	lw	v1,0\(v1\)
[0-9a-f]+ <[^>]+> e074 5244 	lui	v1,0x12345
[0-9a-f]+ <[^>]+> 2083 1950 	addu	v1,v1,a0
[0-9a-f]+ <[^>]+> 8463 8678 	lw	v1,1656\(v1\)
[0-9a-f]+ <[^>]+> 52c7      	lwxs	s3,a0\(a1\)
[0-9a-f]+ <[^>]+> 2040 0030 	mfc0	v0,c0_index
[0-9a-f]+ <[^>]+> 2041 0030 	mfc0	v0,c0_random
[0-9a-f]+ <[^>]+> 2042 0030 	mfc0	v0,c0_entrylo0
[0-9a-f]+ <[^>]+> 2043 0030 	mfc0	v0,c0_entrylo1
[0-9a-f]+ <[^>]+> 2044 0030 	mfc0	v0,c0_context
[0-9a-f]+ <[^>]+> 2045 0030 	mfc0	v0,c0_pagemask
[0-9a-f]+ <[^>]+> 2046 0030 	mfc0	v0,c0_wired
[0-9a-f]+ <[^>]+> 2047 0030 	mfc0	v0,c0_hwrena
[0-9a-f]+ <[^>]+> 2048 0030 	mfc0	v0,c0_badvaddr
[0-9a-f]+ <[^>]+> 2049 0030 	mfc0	v0,c0_count
[0-9a-f]+ <[^>]+> 204a 0030 	mfc0	v0,c0_entryhi
[0-9a-f]+ <[^>]+> 204b 0030 	mfc0	v0,c0_compare
[0-9a-f]+ <[^>]+> 204c 0030 	mfc0	v0,c0_status
[0-9a-f]+ <[^>]+> 204d 0030 	mfc0	v0,c0_cause
[0-9a-f]+ <[^>]+> 204e 0030 	mfc0	v0,c0_epc
[0-9a-f]+ <[^>]+> 204f 0030 	mfc0	v0,c0_prid
[0-9a-f]+ <[^>]+> 2050 0030 	mfc0	v0,c0_config
[0-9a-f]+ <[^>]+> 2051 0030 	mfc0	v0,c0_lladdr
[0-9a-f]+ <[^>]+> 2052 0030 	mfc0	v0,c0_watchlo
[0-9a-f]+ <[^>]+> 2053 0030 	mfc0	v0,c0_watchhi
[0-9a-f]+ <[^>]+> 2054 0030 	mfc0	v0,c0_xcontext
[0-9a-f]+ <[^>]+> 2055 0030 	mfc0	v0,\$21
[0-9a-f]+ <[^>]+> 2056 0030 	mfc0	v0,\$22
[0-9a-f]+ <[^>]+> 2057 0030 	mfc0	v0,c0_debug
[0-9a-f]+ <[^>]+> 2058 0030 	mfc0	v0,c0_depc
[0-9a-f]+ <[^>]+> 2059 0030 	mfc0	v0,c0_perfcnt
[0-9a-f]+ <[^>]+> 205a 0030 	mfc0	v0,c0_errctl
[0-9a-f]+ <[^>]+> 205b 0030 	mfc0	v0,c0_cacheerr
[0-9a-f]+ <[^>]+> 205c 0030 	mfc0	v0,c0_taglo
[0-9a-f]+ <[^>]+> 205d 0030 	mfc0	v0,c0_taghi
[0-9a-f]+ <[^>]+> 205e 0030 	mfc0	v0,c0_errorepc
[0-9a-f]+ <[^>]+> 205f 0030 	mfc0	v0,c0_desave
[0-9a-f]+ <[^>]+> 2040 0030 	mfc0	v0,c0_index
[0-9a-f]+ <[^>]+> 2040 0830 	mfc0	v0,c0_mvpcontrol
[0-9a-f]+ <[^>]+> 2040 1030 	mfc0	v0,c0_mvpconf0
[0-9a-f]+ <[^>]+> 2040 1830 	mfc0	v0,c0_mvpconf1
[0-9a-f]+ <[^>]+> 2040 2030 	mfc0	v0,\$0,4
[0-9a-f]+ <[^>]+> 2040 2830 	mfc0	v0,\$0,5
[0-9a-f]+ <[^>]+> 2040 3030 	mfc0	v0,\$0,6
[0-9a-f]+ <[^>]+> 2040 3830 	mfc0	v0,\$0,7
[0-9a-f]+ <[^>]+> 2041 0030 	mfc0	v0,c0_random
[0-9a-f]+ <[^>]+> 2041 0830 	mfc0	v0,c0_vpecontrol
[0-9a-f]+ <[^>]+> 2041 1030 	mfc0	v0,c0_vpeconf0
[0-9a-f]+ <[^>]+> 2041 1830 	mfc0	v0,c0_vpeconf1
[0-9a-f]+ <[^>]+> 2041 2030 	mfc0	v0,c0_yqmask
[0-9a-f]+ <[^>]+> 2041 2830 	mfc0	v0,c0_vpeschedule
[0-9a-f]+ <[^>]+> 2041 3030 	mfc0	v0,c0_vpeschefback
[0-9a-f]+ <[^>]+> 2041 3830 	mfc0	v0,\$1,7
[0-9a-f]+ <[^>]+> 2042 0030 	mfc0	v0,c0_entrylo0
[0-9a-f]+ <[^>]+> 2042 0830 	mfc0	v0,c0_tcstatus
[0-9a-f]+ <[^>]+> 2042 1030 	mfc0	v0,c0_tcbind
[0-9a-f]+ <[^>]+> 2042 1830 	mfc0	v0,c0_tcrestart
[0-9a-f]+ <[^>]+> 2042 2030 	mfc0	v0,c0_tchalt
[0-9a-f]+ <[^>]+> 2042 2830 	mfc0	v0,c0_tccontext
[0-9a-f]+ <[^>]+> 2042 3030 	mfc0	v0,c0_tcschedule
[0-9a-f]+ <[^>]+> 2042 3830 	mfc0	v0,c0_tcschefback
[0-9a-f]+ <[^>]+> 2062 1610 	movn	v0,v0,v1
[0-9a-f]+ <[^>]+> 2062 1610 	movn	v0,v0,v1
[0-9a-f]+ <[^>]+> 2083 1610 	movn	v0,v1,a0
[0-9a-f]+ <[^>]+> 2062 1210 	movz	v0,v0,v1
[0-9a-f]+ <[^>]+> 2062 1210 	movz	v0,v0,v1
[0-9a-f]+ <[^>]+> 2083 1210 	movz	v0,v1,a0
[0-9a-f]+ <[^>]+> 2040 0070 	mtc0	v0,c0_index
[0-9a-f]+ <[^>]+> 2041 0070 	mtc0	v0,c0_random
[0-9a-f]+ <[^>]+> 2042 0070 	mtc0	v0,c0_entrylo0
[0-9a-f]+ <[^>]+> 2043 0070 	mtc0	v0,c0_entrylo1
[0-9a-f]+ <[^>]+> 2044 0070 	mtc0	v0,c0_context
[0-9a-f]+ <[^>]+> 2045 0070 	mtc0	v0,c0_pagemask
[0-9a-f]+ <[^>]+> 2046 0070 	mtc0	v0,c0_wired
[0-9a-f]+ <[^>]+> 2047 0070 	mtc0	v0,c0_hwrena
[0-9a-f]+ <[^>]+> 2048 0070 	mtc0	v0,c0_badvaddr
[0-9a-f]+ <[^>]+> 2049 0070 	mtc0	v0,c0_count
[0-9a-f]+ <[^>]+> 204a 0070 	mtc0	v0,c0_entryhi
[0-9a-f]+ <[^>]+> 204b 0070 	mtc0	v0,c0_compare
[0-9a-f]+ <[^>]+> 204c 0070 	mtc0	v0,c0_status
[0-9a-f]+ <[^>]+> 204d 0070 	mtc0	v0,c0_cause
[0-9a-f]+ <[^>]+> 204e 0070 	mtc0	v0,c0_epc
[0-9a-f]+ <[^>]+> 204f 0070 	mtc0	v0,c0_prid
[0-9a-f]+ <[^>]+> 2050 0070 	mtc0	v0,c0_config
[0-9a-f]+ <[^>]+> 2051 0070 	mtc0	v0,c0_lladdr
[0-9a-f]+ <[^>]+> 2052 0070 	mtc0	v0,c0_watchlo
[0-9a-f]+ <[^>]+> 2053 0070 	mtc0	v0,c0_watchhi
[0-9a-f]+ <[^>]+> 2054 0070 	mtc0	v0,c0_xcontext
[0-9a-f]+ <[^>]+> 2055 0070 	mtc0	v0,\$21
[0-9a-f]+ <[^>]+> 2056 0070 	mtc0	v0,\$22
[0-9a-f]+ <[^>]+> 2057 0070 	mtc0	v0,c0_debug
[0-9a-f]+ <[^>]+> 2058 0070 	mtc0	v0,c0_depc
[0-9a-f]+ <[^>]+> 2059 0070 	mtc0	v0,c0_perfcnt
[0-9a-f]+ <[^>]+> 205a 0070 	mtc0	v0,c0_errctl
[0-9a-f]+ <[^>]+> 205b 0070 	mtc0	v0,c0_cacheerr
[0-9a-f]+ <[^>]+> 205c 0070 	mtc0	v0,c0_taglo
[0-9a-f]+ <[^>]+> 205d 0070 	mtc0	v0,c0_taghi
[0-9a-f]+ <[^>]+> 205e 0070 	mtc0	v0,c0_errorepc
[0-9a-f]+ <[^>]+> 205f 0070 	mtc0	v0,c0_desave
[0-9a-f]+ <[^>]+> 2040 0070 	mtc0	v0,c0_index
[0-9a-f]+ <[^>]+> 2040 0870 	mtc0	v0,c0_mvpcontrol
[0-9a-f]+ <[^>]+> 2040 1070 	mtc0	v0,c0_mvpconf0
[0-9a-f]+ <[^>]+> 2040 1870 	mtc0	v0,c0_mvpconf1
[0-9a-f]+ <[^>]+> 2040 2070 	mtc0	v0,\$0,4
[0-9a-f]+ <[^>]+> 2040 2870 	mtc0	v0,\$0,5
[0-9a-f]+ <[^>]+> 2040 3070 	mtc0	v0,\$0,6
[0-9a-f]+ <[^>]+> 2040 3870 	mtc0	v0,\$0,7
[0-9a-f]+ <[^>]+> 2041 0070 	mtc0	v0,c0_random
[0-9a-f]+ <[^>]+> 2041 0870 	mtc0	v0,c0_vpecontrol
[0-9a-f]+ <[^>]+> 2041 1070 	mtc0	v0,c0_vpeconf0
[0-9a-f]+ <[^>]+> 2041 1870 	mtc0	v0,c0_vpeconf1
[0-9a-f]+ <[^>]+> 2041 2070 	mtc0	v0,c0_yqmask
[0-9a-f]+ <[^>]+> 2041 2870 	mtc0	v0,c0_vpeschedule
[0-9a-f]+ <[^>]+> 2041 3070 	mtc0	v0,c0_vpeschefback
[0-9a-f]+ <[^>]+> 2041 3870 	mtc0	v0,\$1,7
[0-9a-f]+ <[^>]+> 2042 0070 	mtc0	v0,c0_entrylo0
[0-9a-f]+ <[^>]+> 2042 0870 	mtc0	v0,c0_tcstatus
[0-9a-f]+ <[^>]+> 2042 1070 	mtc0	v0,c0_tcbind
[0-9a-f]+ <[^>]+> 2042 1870 	mtc0	v0,c0_tcrestart
[0-9a-f]+ <[^>]+> 2042 2070 	mtc0	v0,c0_tchalt
[0-9a-f]+ <[^>]+> 2042 2870 	mtc0	v0,c0_tccontext
[0-9a-f]+ <[^>]+> 2042 3070 	mtc0	v0,c0_tcschedule
[0-9a-f]+ <[^>]+> 2042 3870 	mtc0	v0,c0_tcschefback
[0-9a-f]+ <[^>]+> 2083 1018 	mul	v0,v1,a0
[0-9a-f]+ <[^>]+> 23fe e818 	mul	sp,s8,ra
[0-9a-f]+ <[^>]+> 2082 1018 	mul	v0,v0,a0
[0-9a-f]+ <[^>]+> 2082 1018 	mul	v0,v0,a0
[0-9a-f]+ <[^>]+> 0020 0000 	li	at,0
[0-9a-f]+ <[^>]+> 2022 1018 	mul	v0,v0,at
[0-9a-f]+ <[^>]+> 0020 0001 	li	at,1
[0-9a-f]+ <[^>]+> 2022 1018 	mul	v0,v0,at
[0-9a-f]+ <[^>]+> 6020 0000 7fff 	li	at,0x7fff
[0-9a-f]+ <[^>]+> 2022 1018 	mul	v0,v0,at
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2022 1018 	mul	v0,v0,at
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 2022 1018 	mul	v0,v0,at
[0-9a-f]+ <[^>]+> 2060 1190 	neg	v0,v1
[0-9a-f]+ <[^>]+> 2040 1190 	neg	v0,v0
[0-9a-f]+ <[^>]+> 2040 1190 	neg	v0,v0
[0-9a-f]+ <[^>]+> 2060 11d0 	negu	v0,v1
[0-9a-f]+ <[^>]+> 2040 11d0 	negu	v0,v0
[0-9a-f]+ <[^>]+> 2040 11d0 	negu	v0,v0
[0-9a-f]+ <[^>]+> 2060 11d0 	negu	v0,v1
[0-9a-f]+ <[^>]+> 2040 11d0 	negu	v0,v0
[0-9a-f]+ <[^>]+> 2040 11d0 	negu	v0,v0
[0-9a-f]+ <[^>]+> 5120      	not	s2,s2
[0-9a-f]+ <[^>]+> 5120      	not	s2,s2
[0-9a-f]+ <[^>]+> 5130      	not	s2,s3
[0-9a-f]+ <[^>]+> 5140      	not	s2,a0
[0-9a-f]+ <[^>]+> 5150      	not	s2,a1
[0-9a-f]+ <[^>]+> 5160      	not	s2,a2
[0-9a-f]+ <[^>]+> 5170      	not	s2,a3
[0-9a-f]+ <[^>]+> 5100      	not	s2,s0
[0-9a-f]+ <[^>]+> 5110      	not	s2,s1
[0-9a-f]+ <[^>]+> 5190      	not	s3,s1
[0-9a-f]+ <[^>]+> 5210      	not	a0,s1
[0-9a-f]+ <[^>]+> 5290      	not	a1,s1
[0-9a-f]+ <[^>]+> 5310      	not	a2,s1
[0-9a-f]+ <[^>]+> 5390      	not	a3,s1
[0-9a-f]+ <[^>]+> 5010      	not	s0,s1
[0-9a-f]+ <[^>]+> 5090      	not	s1,s1
[0-9a-f]+ <[^>]+> 2007 12d0 	not	v0,a3
[0-9a-f]+ <[^>]+> 20e0 12d0 	nor	v0,zero,a3
[0-9a-f]+ <[^>]+> 2083 12d0 	nor	v0,v1,a0
[0-9a-f]+ <[^>]+> 23fe ead0 	nor	sp,s8,ra
[0-9a-f]+ <[^>]+> 2082 12d0 	nor	v0,v0,a0
[0-9a-f]+ <[^>]+> 2082 12d0 	nor	v0,v0,a0
[0-9a-f]+ <[^>]+> e020 8000 	lui	at,0x8
[0-9a-f]+ <[^>]+> 2023 12d0 	nor	v0,v1,at
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 2023 12d0 	nor	v0,v1,at
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2023 12d0 	nor	v0,v1,at
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2023 12d0 	nor	v0,v1,at
[0-9a-f]+ <[^>]+> 6020 ffff 7fff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2023 12d0 	nor	v0,v1,at
[0-9a-f]+ <[^>]+> 2016 1290 	move	v0,s6
[0-9a-f]+ <[^>]+> 2002 b290 	move	s6,v0
[0-9a-f]+ <[^>]+> 22c0 1290 	or	v0,zero,s6
[0-9a-f]+ <[^>]+> 2040 b290 	or	s6,zero,v0
[0-9a-f]+ <[^>]+> 512c      	or	s2,s2,s2
[0-9a-f]+ <[^>]+> 513c      	or	s2,s2,s3
[0-9a-f]+ <[^>]+> 514c      	or	s2,s2,a0
[0-9a-f]+ <[^>]+> 515c      	or	s2,s2,a1
[0-9a-f]+ <[^>]+> 516c      	or	s2,s2,a2
[0-9a-f]+ <[^>]+> 517c      	or	s2,s2,a3
[0-9a-f]+ <[^>]+> 510c      	or	s2,s2,s0
[0-9a-f]+ <[^>]+> 511c      	or	s2,s2,s1
[0-9a-f]+ <[^>]+> 51ac      	or	s3,s3,s2
[0-9a-f]+ <[^>]+> 522c      	or	a0,a0,s2
[0-9a-f]+ <[^>]+> 52ac      	or	a1,a1,s2
[0-9a-f]+ <[^>]+> 532c      	or	a2,a2,s2
[0-9a-f]+ <[^>]+> 53ac      	or	a3,a3,s2
[0-9a-f]+ <[^>]+> 502c      	or	s0,s0,s2
[0-9a-f]+ <[^>]+> 50ac      	or	s1,s1,s2
[0-9a-f]+ <[^>]+> 512c      	or	s2,s2,s2
[0-9a-f]+ <[^>]+> 513c      	or	s2,s2,s3
[0-9a-f]+ <[^>]+> 513c      	or	s2,s2,s3
[0-9a-f]+ <[^>]+> 2083 1290 	or	v0,v1,a0
[0-9a-f]+ <[^>]+> 23fe ea90 	or	sp,s8,ra
[0-9a-f]+ <[^>]+> 2082 1290 	or	v0,v0,a0
[0-9a-f]+ <[^>]+> 2082 1290 	or	v0,v0,a0
[0-9a-f]+ <[^>]+> e020 8000 	lui	at,0x8
[0-9a-f]+ <[^>]+> 2023 1290 	or	v0,v1,at
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 2023 1290 	or	v0,v1,at
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2023 1290 	or	v0,v1,at
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2023 1290 	or	v0,v1,at
[0-9a-f]+ <[^>]+> 6020 ffff 7fff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2023 1290 	or	v0,v1,at
[0-9a-f]+ <[^>]+> 8064 0000 	ori	v1,a0,0
[0-9a-f]+ <[^>]+> 8064 0fff 	ori	v1,a0,4095
[0-9a-f]+ <[^>]+> 2040 01c0 	rdhwr	v0,hwr_cpunum
[0-9a-f]+ <[^>]+> 2041 01c0 	rdhwr	v0,hwr_synci_step
[0-9a-f]+ <[^>]+> 2042 01c0 	rdhwr	v0,hwr_cc
[0-9a-f]+ <[^>]+> 2043 01c0 	rdhwr	v0,hwr_ccres
[0-9a-f]+ <[^>]+> 2044 01c0 	rdhwr	v0,\$4
[0-9a-f]+ <[^>]+> 2045 01c0 	rdhwr	v0,\$5
[0-9a-f]+ <[^>]+> 2046 01c0 	rdhwr	v0,\$6
[0-9a-f]+ <[^>]+> 2047 01c0 	rdhwr	v0,\$7
[0-9a-f]+ <[^>]+> 2048 01c0 	rdhwr	v0,\$8
[0-9a-f]+ <[^>]+> 2049 01c0 	rdhwr	v0,\$9
[0-9a-f]+ <[^>]+> 204a 01c0 	rdhwr	v0,\$10
[0-9a-f]+ <[^>]+> 2043 e17f 	rdpgpr	v0,v1
[0-9a-f]+ <[^>]+> 2042 e17f 	rdpgpr	v0,v0
[0-9a-f]+ <[^>]+> 2062 0158 	mod	zero,v0,v1
[0-9a-f]+ <[^>]+> 23fe 0158 	mod	zero,s8,ra
[0-9a-f]+ <[^>]+> 2060 0158 	mod	zero,zero,v1
[0-9a-f]+ <[^>]+> 23e0 0158 	mod	zero,zero,ra
[0-9a-f]+ <[^>]+> 2003 1158 	mod	v0,v1,zero
[0-9a-f]+ <[^>]+> 2083 1158 	mod	v0,v1,a0
[0-9a-f]+ <[^>]+> 1017      	break	0x7
[0-9a-f]+ <[^>]+> 1060      	move	v1,zero
[0-9a-f]+ <[^>]+> 1060      	move	v1,zero
[0-9a-f]+ <[^>]+> 0020 0002 	li	at,2
[0-9a-f]+ <[^>]+> 2024 1958 	mod	v1,a0,at
[0-9a-f]+ <[^>]+> 2080 11d0 	negu	v0,a0
[0-9a-f]+ <[^>]+> 2043 10d0 	rotr	v0,v1,v0
[0-9a-f]+ <[^>]+> 2080 09d0 	negu	at,a0
[0-9a-f]+ <[^>]+> 2022 10d0 	rotr	v0,v0,at
[0-9a-f]+ <[^>]+> 2060 11d0 	negu	v0,v1
[0-9a-f]+ <[^>]+> 2043 10d0 	rotr	v0,v1,v0
[0-9a-f]+ <[^>]+> 2040 11d0 	negu	v0,v0
[0-9a-f]+ <[^>]+> 2043 10d0 	rotr	v0,v1,v0
[0-9a-f]+ <[^>]+> 8043 c0c0 	rotr	v0,v1,0x0
[0-9a-f]+ <[^>]+> 8043 c0df 	rotr	v0,v1,0x1f
[0-9a-f]+ <[^>]+> 8043 c0c1 	rotr	v0,v1,0x1
[0-9a-f]+ <[^>]+> 8042 c0c1 	rotr	v0,v0,0x1
[0-9a-f]+ <[^>]+> 8042 c0c1 	rotr	v0,v0,0x1
[0-9a-f]+ <[^>]+> 8043 c0c0 	rotr	v0,v1,0x0
[0-9a-f]+ <[^>]+> 8043 c0c1 	rotr	v0,v1,0x1
[0-9a-f]+ <[^>]+> 8043 c0df 	rotr	v0,v1,0x1f
[0-9a-f]+ <[^>]+> 8042 c0df 	rotr	v0,v0,0x1f
[0-9a-f]+ <[^>]+> 8042 c0df 	rotr	v0,v0,0x1f
[0-9a-f]+ <[^>]+> 2083 10d0 	rotr	v0,v1,a0
[0-9a-f]+ <[^>]+> 2082 10d0 	rotr	v0,v0,a0
[0-9a-f]+ <[^>]+> 2083 10d0 	rotr	v0,v1,a0
[0-9a-f]+ <[^>]+> 2082 10d0 	rotr	v0,v0,a0
[0-9a-f]+ <[^>]+> 2083 10d0 	rotr	v0,v1,a0
[0-9a-f]+ <[^>]+> 2082 10d0 	rotr	v0,v0,a0
[0-9a-f]+ <[^>]+> 2083 10d0 	rotr	v0,v1,a0
[0-9a-f]+ <[^>]+> 2082 10d0 	rotr	v0,v0,a0
[0-9a-f]+ <[^>]+> 1434      	sb	zero,0\(s3\)
[0-9a-f]+ <[^>]+> 1434      	sb	zero,0\(s3\)
[0-9a-f]+ <[^>]+> 1435      	sb	zero,1\(s3\)
[0-9a-f]+ <[^>]+> 1436      	sb	zero,2\(s3\)
[0-9a-f]+ <[^>]+> 1437      	sb	zero,3\(s3\)
[0-9a-f]+ <[^>]+> 8403 1004 	sb	zero,4\(v1\)
[0-9a-f]+ <[^>]+> 8403 1005 	sb	zero,5\(v1\)
[0-9a-f]+ <[^>]+> 8403 1006 	sb	zero,6\(v1\)
[0-9a-f]+ <[^>]+> 8403 1007 	sb	zero,7\(v1\)
[0-9a-f]+ <[^>]+> 8403 1008 	sb	zero,8\(v1\)
[0-9a-f]+ <[^>]+> 8403 1009 	sb	zero,9\(v1\)
[0-9a-f]+ <[^>]+> 8403 100a 	sb	zero,10\(v1\)
[0-9a-f]+ <[^>]+> 8403 100b 	sb	zero,11\(v1\)
[0-9a-f]+ <[^>]+> 8403 100c 	sb	zero,12\(v1\)
[0-9a-f]+ <[^>]+> 8403 100d 	sb	zero,13\(v1\)
[0-9a-f]+ <[^>]+> 8403 100e 	sb	zero,14\(v1\)
[0-9a-f]+ <[^>]+> 8403 100f 	sb	zero,15\(v1\)
[0-9a-f]+ <[^>]+> 8443 100f 	sb	v0,15\(v1\)
[0-9a-f]+ <[^>]+> 8463 100f 	sb	v1,15\(v1\)
[0-9a-f]+ <[^>]+> 8483 100f 	sb	a0,15\(v1\)
[0-9a-f]+ <[^>]+> 84a3 100f 	sb	a1,15\(v1\)
[0-9a-f]+ <[^>]+> 84c3 100f 	sb	a2,15\(v1\)
[0-9a-f]+ <[^>]+> 84e3 100f 	sb	a3,15\(v1\)
[0-9a-f]+ <[^>]+> 8623 100f 	sb	s1,15\(v1\)
[0-9a-f]+ <[^>]+> 8624 100f 	sb	s1,15\(a0\)
[0-9a-f]+ <[^>]+> 8625 100f 	sb	s1,15\(a1\)
[0-9a-f]+ <[^>]+> 8626 100f 	sb	s1,15\(a2\)
[0-9a-f]+ <[^>]+> 8627 100f 	sb	s1,15\(a3\)
[0-9a-f]+ <[^>]+> 8622 100f 	sb	s1,15\(v0\)
[0-9a-f]+ <[^>]+> 8630 100f 	sb	s1,15\(s0\)
[0-9a-f]+ <[^>]+> 8631 100f 	sb	s1,15\(s1\)
[0-9a-f]+ <[^>]+> 8460 1004 	sb	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 1004 	sb	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 1fff 	sb	v1,4095\(zero\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 8461 1fff 	sb	v1,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 8461 1000 	sb	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 8461 1000 	sb	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 8461 1001 	sb	v1,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 8461 1001 	sb	v1,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 8461 1000 	sb	v1,0\(at\)
[0-9a-f]+ <[^>]+> 0020 9fff 	li	at,-1
[0-9a-f]+ <[^>]+> 8461 1000 	sb	v1,0\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 8461 1678 	sb	v1,1656\(at\)
[0-9a-f]+ <[^>]+> 8464 1000 	sb	v1,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 1000 	sb	v1,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 1fff 	sb	v1,4095\(a0\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 1fff 	sb	v1,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 1000 	sb	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 1000 	sb	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 1001 	sb	v1,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 1001 	sb	v1,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 1000 	sb	v1,0\(at\)
[0-9a-f]+ <[^>]+> 0024 9fff 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> 8461 1000 	sb	v1,0\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 1678 	sb	v1,1656\(at\)
[0-9a-f]+ <[^>]+> a460 4904 	sc	v1,4\(zero\)
[0-9a-f]+ <[^>]+> a460 4904 	sc	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 0020 07ff 	li	at,2047
[0-9a-f]+ <[^>]+> a461 4900 	sc	v1,0\(at\)
[0-9a-f]+ <[^>]+> 0020 9800 	li	at,-2048
[0-9a-f]+ <[^>]+> a461 4900 	sc	v1,0\(at\)
[0-9a-f]+ <[^>]+> e020 8000 	lui	at,0x8
[0-9a-f]+ <[^>]+> a461 c9fc 	sc	v1,-4\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> a461 4900 	sc	v1,0\(at\)
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> a461 c9fc 	sc	v1,-4\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> a461 4900 	sc	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> a461 4900 	sc	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> a461 4904 	sc	v1,4\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> a461 4904 	sc	v1,4\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> a461 4900 	sc	v1,0\(at\)
[0-9a-f]+ <[^>]+> a460 c9fc 	sc	v1,-4\(zero\)
[0-9a-f]+ <[^>]+> 6020 1234 5600 	li	at,0x12345600
[0-9a-f]+ <[^>]+> a461 c9e0 	sc	v1,-32\(at\)
[0-9a-f]+ <[^>]+> a464 4900 	sc	v1,0\(a0\)
[0-9a-f]+ <[^>]+> a464 4900 	sc	v1,0\(a0\)
[0-9a-f]+ <[^>]+> 0024 07ff 	addiu	at,a0,2047
[0-9a-f]+ <[^>]+> a461 4900 	sc	v1,0\(at\)
[0-9a-f]+ <[^>]+> 0024 9800 	addiu	at,a0,-2048
[0-9a-f]+ <[^>]+> a461 4900 	sc	v1,0\(at\)
[0-9a-f]+ <[^>]+> e020 8000 	lui	at,0x8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 c9fc 	sc	v1,-4\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 4900 	sc	v1,0\(at\)
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 c9fc 	sc	v1,-4\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 4900 	sc	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 4900 	sc	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 4904 	sc	v1,4\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 4904 	sc	v1,4\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 4900 	sc	v1,0\(at\)
[0-9a-f]+ <[^>]+> a464 c9fc 	sc	v1,-4\(a0\)
[0-9a-f]+ <[^>]+> 6020 1234 5600 	li	at,0x12345600
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 c9e0 	sc	v1,-32\(at\)
[0-9a-f]+ <[^>]+> 1018      	sdbbp	0x0
[0-9a-f]+ <[^>]+> 1018      	sdbbp	0x0
[0-9a-f]+ <[^>]+> 1019      	sdbbp	0x1
[0-9a-f]+ <[^>]+> 101a      	sdbbp	0x2
[0-9a-f]+ <[^>]+> 101b      	sdbbp	0x3
[0-9a-f]+ <[^>]+> 101c      	sdbbp	0x4
[0-9a-f]+ <[^>]+> 101d      	sdbbp	0x5
[0-9a-f]+ <[^>]+> 101e      	sdbbp	0x6
[0-9a-f]+ <[^>]+> 101f      	sdbbp	0x7
[0-9a-f]+ <[^>]+> 0018 0008 	sdbbp	0x8
[0-9a-f]+ <[^>]+> 0018 0009 	sdbbp	0x9
[0-9a-f]+ <[^>]+> 0018 000a 	sdbbp	0xa
[0-9a-f]+ <[^>]+> 0018 000b 	sdbbp	0xb
[0-9a-f]+ <[^>]+> 0018 000c 	sdbbp	0xc
[0-9a-f]+ <[^>]+> 0018 000d 	sdbbp	0xd
[0-9a-f]+ <[^>]+> 0018 000e 	sdbbp	0xe
[0-9a-f]+ <[^>]+> 0018 000f 	sdbbp	0xf
[0-9a-f]+ <[^>]+> 001f ffff 	sdbbp	0x7ffff
[0-9a-f]+ <[^>]+> 0018 0000 	sdbbp	0x0
[0-9a-f]+ <[^>]+> 0018 0001 	sdbbp	0x1
[0-9a-f]+ <[^>]+> 0018 0002 	sdbbp	0x2
[0-9a-f]+ <[^>]+> 0018 00ff 	sdbbp	0xff
[0-9a-f]+ <[^>]+> 2043 2b3f 	seb	v0,v1
[0-9a-f]+ <[^>]+> 2042 2b3f 	seb	v0,v0
[0-9a-f]+ <[^>]+> 2042 2b3f 	seb	v0,v0
[0-9a-f]+ <[^>]+> 2043 3b3f 	seh	v0,v1
[0-9a-f]+ <[^>]+> 2042 3b3f 	seh	v0,v0
[0-9a-f]+ <[^>]+> 2042 3b3f 	seh	v0,v0
[0-9a-f]+ <[^>]+> 2083 1310 	xor	v0,v1,a0
[0-9a-f]+ <[^>]+> 8042 5001 	sltiu	v0,v0,1
[0-9a-f]+ <[^>]+> 8043 5001 	sltiu	v0,v1,1
[0-9a-f]+ <[^>]+> 8044 5001 	sltiu	v0,a0,1
[0-9a-f]+ <[^>]+> 8043 5001 	sltiu	v0,v1,1
[0-9a-f]+ <[^>]+> 8043 1001 	xori	v0,v1,1
[0-9a-f]+ <[^>]+> 8042 5001 	sltiu	v0,v0,1
[0-9a-f]+ <[^>]+> 0043 0001 	addiu	v0,v1,1
[0-9a-f]+ <[^>]+> 8042 5001 	sltiu	v0,v0,1
[0-9a-f]+ <[^>]+> 6020 ffff 7fff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2023 1310 	xor	v0,v1,at
[0-9a-f]+ <[^>]+> 8042 5001 	sltiu	v0,v0,1
[0-9a-f]+ <[^>]+> 2083 1350 	slt	v0,v1,a0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 2082 1350 	slt	v0,v0,a0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 2082 1350 	slt	v0,v0,a0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 8043 4000 	slti	v0,v1,0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2023 1350 	slt	v0,v1,at
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 8043 4000 	slti	v0,v1,0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 6020 0000 7fff 	li	at,0x7fff
[0-9a-f]+ <[^>]+> 2023 1350 	slt	v0,v1,at
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 2023 1350 	slt	v0,v1,at
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2023 1350 	slt	v0,v1,at
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 6020 ffff 7fff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2023 1350 	slt	v0,v1,at
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 2083 1390 	sltu	v0,v1,a0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 2082 1390 	sltu	v0,v0,a0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 2082 1390 	sltu	v0,v0,a0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 8043 5000 	sltiu	v0,v1,0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2023 1390 	sltu	v0,v1,at
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 8043 5000 	sltiu	v0,v1,0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 6020 0000 7fff 	li	at,0x7fff
[0-9a-f]+ <[^>]+> 2023 1390 	sltu	v0,v1,at
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 2023 1390 	sltu	v0,v1,at
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2023 1390 	sltu	v0,v1,at
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 6020 ffff 7fff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2023 1390 	sltu	v0,v1,at
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 2064 1350 	slt	v0,a0,v1
[0-9a-f]+ <[^>]+> 2044 1350 	slt	v0,a0,v0
[0-9a-f]+ <[^>]+> 2044 1350 	slt	v0,a0,v0
[0-9a-f]+ <[^>]+> 0020 0000 	li	at,0
[0-9a-f]+ <[^>]+> 2061 1350 	slt	v0,at,v1
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2061 1350 	slt	v0,at,v1
[0-9a-f]+ <[^>]+> 0020 0000 	li	at,0
[0-9a-f]+ <[^>]+> 2061 1350 	slt	v0,at,v1
[0-9a-f]+ <[^>]+> 6020 0000 7fff 	li	at,0x7fff
[0-9a-f]+ <[^>]+> 2061 1350 	slt	v0,at,v1
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 2061 1350 	slt	v0,at,v1
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2061 1350 	slt	v0,at,v1
[0-9a-f]+ <[^>]+> 6020 ffff 7fff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2061 1350 	slt	v0,at,v1
[0-9a-f]+ <[^>]+> 2064 1390 	sltu	v0,a0,v1
[0-9a-f]+ <[^>]+> 2044 1390 	sltu	v0,a0,v0
[0-9a-f]+ <[^>]+> 2044 1390 	sltu	v0,a0,v0
[0-9a-f]+ <[^>]+> 0020 0000 	li	at,0
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	v0,at,v1
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	v0,at,v1
[0-9a-f]+ <[^>]+> 0020 0000 	li	at,0
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	v0,at,v1
[0-9a-f]+ <[^>]+> 6020 0000 7fff 	li	at,0x7fff
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	v0,at,v1
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	v0,at,v1
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	v0,at,v1
[0-9a-f]+ <[^>]+> 6020 ffff 7fff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	v0,at,v1
[0-9a-f]+ <[^>]+> 3531      	sh	s2,0\(s3\)
[0-9a-f]+ <[^>]+> 3531      	sh	s2,0\(s3\)
[0-9a-f]+ <[^>]+> 3533      	sh	s2,2\(s3\)
[0-9a-f]+ <[^>]+> 3535      	sh	s2,4\(s3\)
[0-9a-f]+ <[^>]+> 3537      	sh	s2,6\(s3\)
[0-9a-f]+ <[^>]+> 8443 5008 	sh	v0,8\(v1\)
[0-9a-f]+ <[^>]+> 8443 500a 	sh	v0,10\(v1\)
[0-9a-f]+ <[^>]+> 8443 500c 	sh	v0,12\(v1\)
[0-9a-f]+ <[^>]+> 8443 500e 	sh	v0,14\(v1\)
[0-9a-f]+ <[^>]+> 8443 5010 	sh	v0,16\(v1\)
[0-9a-f]+ <[^>]+> 8443 5012 	sh	v0,18\(v1\)
[0-9a-f]+ <[^>]+> 8443 5014 	sh	v0,20\(v1\)
[0-9a-f]+ <[^>]+> 8443 5016 	sh	v0,22\(v1\)
[0-9a-f]+ <[^>]+> 8443 5018 	sh	v0,24\(v1\)
[0-9a-f]+ <[^>]+> 8443 501a 	sh	v0,26\(v1\)
[0-9a-f]+ <[^>]+> 8443 501c 	sh	v0,28\(v1\)
[0-9a-f]+ <[^>]+> 8443 501e 	sh	v0,30\(v1\)
[0-9a-f]+ <[^>]+> 8444 501e 	sh	v0,30\(a0\)
[0-9a-f]+ <[^>]+> 8445 501e 	sh	v0,30\(a1\)
[0-9a-f]+ <[^>]+> 8446 501e 	sh	v0,30\(a2\)
[0-9a-f]+ <[^>]+> 8447 501e 	sh	v0,30\(a3\)
[0-9a-f]+ <[^>]+> 8442 501e 	sh	v0,30\(v0\)
[0-9a-f]+ <[^>]+> 8450 501e 	sh	v0,30\(s0\)
[0-9a-f]+ <[^>]+> 8451 501e 	sh	v0,30\(s1\)
[0-9a-f]+ <[^>]+> 8471 501e 	sh	v1,30\(s1\)
[0-9a-f]+ <[^>]+> 8491 501e 	sh	a0,30\(s1\)
[0-9a-f]+ <[^>]+> 84b1 501e 	sh	a1,30\(s1\)
[0-9a-f]+ <[^>]+> 84d1 501e 	sh	a2,30\(s1\)
[0-9a-f]+ <[^>]+> 84f1 501e 	sh	a3,30\(s1\)
[0-9a-f]+ <[^>]+> 8631 501e 	sh	s1,30\(s1\)
[0-9a-f]+ <[^>]+> 8411 501e 	sh	zero,30\(s1\)
[0-9a-f]+ <[^>]+> 8460 5004 	sh	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 5004 	sh	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 5fff 	sh	v1,4095\(zero\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 8461 5fff 	sh	v1,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 8461 5000 	sh	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 8461 5000 	sh	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 8461 5001 	sh	v1,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 8461 5001 	sh	v1,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 8461 5000 	sh	v1,0\(at\)
[0-9a-f]+ <[^>]+> 0020 9fff 	li	at,-1
[0-9a-f]+ <[^>]+> 8461 5000 	sh	v1,0\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 8461 5678 	sh	v1,1656\(at\)
[0-9a-f]+ <[^>]+> 8464 5000 	sh	v1,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 5000 	sh	v1,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 5fff 	sh	v1,4095\(a0\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5fff 	sh	v1,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5000 	sh	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5000 	sh	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5001 	sh	v1,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5001 	sh	v1,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5000 	sh	v1,0\(at\)
[0-9a-f]+ <[^>]+> 0024 9fff 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> 8461 5000 	sh	v1,0\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5678 	sh	v1,1656\(at\)
[0-9a-f]+ <[^>]+> 2064 1350 	slt	v0,a0,v1
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 2044 1350 	slt	v0,a0,v0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 2044 1350 	slt	v0,a0,v0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 0020 0000 	li	at,0
[0-9a-f]+ <[^>]+> 2061 1350 	slt	v0,at,v1
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2061 1350 	slt	v0,at,v1
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 0020 0000 	li	at,0
[0-9a-f]+ <[^>]+> 2061 1350 	slt	v0,at,v1
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 6020 0000 7fff 	li	at,0x7fff
[0-9a-f]+ <[^>]+> 2061 1350 	slt	v0,at,v1
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 2061 1350 	slt	v0,at,v1
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2061 1350 	slt	v0,at,v1
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 6020 ffff 7fff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2061 1350 	slt	v0,at,v1
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 2064 1390 	sltu	v0,a0,v1
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 2044 1390 	sltu	v0,a0,v0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 2044 1390 	sltu	v0,a0,v0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 0020 0000 	li	at,0
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	v0,at,v1
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	v0,at,v1
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 0020 0000 	li	at,0
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	v0,at,v1
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 6020 0000 7fff 	li	at,0x7fff
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	v0,at,v1
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	v0,at,v1
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	v0,at,v1
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 6020 ffff 7fff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	v0,at,v1
[0-9a-f]+ <[^>]+> 8042 1001 	xori	v0,v0,1
[0-9a-f]+ <[^>]+> 3121      	sll	s2,s2,1
[0-9a-f]+ <[^>]+> 3122      	sll	s2,s2,2
[0-9a-f]+ <[^>]+> 3123      	sll	s2,s2,3
[0-9a-f]+ <[^>]+> 3124      	sll	s2,s2,4
[0-9a-f]+ <[^>]+> 3125      	sll	s2,s2,5
[0-9a-f]+ <[^>]+> 3126      	sll	s2,s2,6
[0-9a-f]+ <[^>]+> 3127      	sll	s2,s2,7
[0-9a-f]+ <[^>]+> 3120      	sll	s2,s2,8
[0-9a-f]+ <[^>]+> 3130      	sll	s2,s3,8
[0-9a-f]+ <[^>]+> 3140      	sll	s2,a0,8
[0-9a-f]+ <[^>]+> 3150      	sll	s2,a1,8
[0-9a-f]+ <[^>]+> 3160      	sll	s2,a2,8
[0-9a-f]+ <[^>]+> 3170      	sll	s2,a3,8
[0-9a-f]+ <[^>]+> 3100      	sll	s2,s0,8
[0-9a-f]+ <[^>]+> 3110      	sll	s2,s1,8
[0-9a-f]+ <[^>]+> 31a0      	sll	s3,s2,8
[0-9a-f]+ <[^>]+> 3220      	sll	a0,s2,8
[0-9a-f]+ <[^>]+> 32a0      	sll	a1,s2,8
[0-9a-f]+ <[^>]+> 3320      	sll	a2,s2,8
[0-9a-f]+ <[^>]+> 33a0      	sll	a3,s2,8
[0-9a-f]+ <[^>]+> 3020      	sll	s0,s2,8
[0-9a-f]+ <[^>]+> 30a0      	sll	s1,s2,8
[0-9a-f]+ <[^>]+> 3121      	sll	s2,s2,1
[0-9a-f]+ <[^>]+> 31b1      	sll	s3,s3,1
[0-9a-f]+ <[^>]+> 2083 1010 	sll	v0,v1,a0
[0-9a-f]+ <[^>]+> 2082 1010 	sll	v0,v0,a0
[0-9a-f]+ <[^>]+> 2082 1010 	sll	v0,v0,a0
[0-9a-f]+ <[^>]+> 2082 1010 	sll	v0,v0,a0
[0-9a-f]+ <[^>]+> 8044 c000 	sll	v0,a0,0x0
[0-9a-f]+ <[^>]+> 8044 c001 	sll	v0,a0,0x1
[0-9a-f]+ <[^>]+> 8044 c01f 	sll	v0,a0,0x1f
[0-9a-f]+ <[^>]+> 8042 c01f 	sll	v0,v0,0x1f
[0-9a-f]+ <[^>]+> 8042 c01f 	sll	v0,v0,0x1f
[0-9a-f]+ <[^>]+> 2083 1350 	slt	v0,v1,a0
[0-9a-f]+ <[^>]+> 2082 1350 	slt	v0,v0,a0
[0-9a-f]+ <[^>]+> 2082 1350 	slt	v0,v0,a0
[0-9a-f]+ <[^>]+> 8043 4000 	slti	v0,v1,0
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2023 1350 	slt	v0,v1,at
[0-9a-f]+ <[^>]+> 8043 4000 	slti	v0,v1,0
[0-9a-f]+ <[^>]+> 6020 0000 7fff 	li	at,0x7fff
[0-9a-f]+ <[^>]+> 2023 1350 	slt	v0,v1,at
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 2023 1350 	slt	v0,v1,at
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2023 1350 	slt	v0,v1,at
[0-9a-f]+ <[^>]+> 6020 ffff 7fff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2023 1350 	slt	v0,v1,at
[0-9a-f]+ <[^>]+> 8064 4000 	slti	v1,a0,0
[0-9a-f]+ <[^>]+> 8064 4fff 	slti	v1,a0,4095
[0-9a-f]+ <[^>]+> 8064 5000 	sltiu	v1,a0,0
[0-9a-f]+ <[^>]+> 8064 5fff 	sltiu	v1,a0,4095
[0-9a-f]+ <[^>]+> 2083 1390 	sltu	v0,v1,a0
[0-9a-f]+ <[^>]+> 2082 1390 	sltu	v0,v0,a0
[0-9a-f]+ <[^>]+> 2082 1390 	sltu	v0,v0,a0
[0-9a-f]+ <[^>]+> 8043 5000 	sltiu	v0,v1,0
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2023 1390 	sltu	v0,v1,at
[0-9a-f]+ <[^>]+> 8043 5000 	sltiu	v0,v1,0
[0-9a-f]+ <[^>]+> 6020 0000 7fff 	li	at,0x7fff
[0-9a-f]+ <[^>]+> 2023 1390 	sltu	v0,v1,at
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 2023 1390 	sltu	v0,v1,at
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2023 1390 	sltu	v0,v1,at
[0-9a-f]+ <[^>]+> 6020 ffff 7fff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2023 1390 	sltu	v0,v1,at
[0-9a-f]+ <[^>]+> 2083 1310 	xor	v0,v1,a0
[0-9a-f]+ <[^>]+> 2040 1390 	sltu	v0,zero,v0
[0-9a-f]+ <[^>]+> 2080 1390 	sltu	v0,zero,a0
[0-9a-f]+ <[^>]+> 2060 1390 	sltu	v0,zero,v1
[0-9a-f]+ <[^>]+> 2060 1390 	sltu	v0,zero,v1
[0-9a-f]+ <[^>]+> 8043 1001 	xori	v0,v1,1
[0-9a-f]+ <[^>]+> 2040 1390 	sltu	v0,zero,v0
[0-9a-f]+ <[^>]+> 0043 0001 	addiu	v0,v1,1
[0-9a-f]+ <[^>]+> 2040 1390 	sltu	v0,zero,v0
[0-9a-f]+ <[^>]+> 6020 ffff 7fff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2023 1310 	xor	v0,v1,at
[0-9a-f]+ <[^>]+> 2040 1390 	sltu	v0,zero,v0
[0-9a-f]+ <[^>]+> 2083 1090 	sra	v0,v1,a0
[0-9a-f]+ <[^>]+> 2082 1090 	sra	v0,v0,a0
[0-9a-f]+ <[^>]+> 2082 1090 	sra	v0,v0,a0
[0-9a-f]+ <[^>]+> 2082 1090 	sra	v0,v0,a0
[0-9a-f]+ <[^>]+> 8044 c080 	sra	v0,a0,0x0
[0-9a-f]+ <[^>]+> 8044 c081 	sra	v0,a0,0x1
[0-9a-f]+ <[^>]+> 8044 c09f 	sra	v0,a0,0x1f
[0-9a-f]+ <[^>]+> 8042 c09f 	sra	v0,v0,0x1f
[0-9a-f]+ <[^>]+> 8042 c09f 	sra	v0,v0,0x1f
[0-9a-f]+ <[^>]+> 2083 1050 	srl	v0,v1,a0
[0-9a-f]+ <[^>]+> 2082 1050 	srl	v0,v0,a0
[0-9a-f]+ <[^>]+> 2082 1050 	srl	v0,v0,a0
[0-9a-f]+ <[^>]+> 2082 1050 	srl	v0,v0,a0
[0-9a-f]+ <[^>]+> 8044 c040 	srl	v0,a0,0x0
[0-9a-f]+ <[^>]+> 3149      	srl	s2,a0,1
[0-9a-f]+ <[^>]+> 8044 c05f 	srl	v0,a0,0x1f
[0-9a-f]+ <[^>]+> 8042 c05f 	srl	v0,v0,0x1f
[0-9a-f]+ <[^>]+> 8042 c05f 	srl	v0,v0,0x1f
[0-9a-f]+ <[^>]+> 3129      	srl	s2,s2,1
[0-9a-f]+ <[^>]+> 312a      	srl	s2,s2,2
[0-9a-f]+ <[^>]+> 312b      	srl	s2,s2,3
[0-9a-f]+ <[^>]+> 312c      	srl	s2,s2,4
[0-9a-f]+ <[^>]+> 312d      	srl	s2,s2,5
[0-9a-f]+ <[^>]+> 312e      	srl	s2,s2,6
[0-9a-f]+ <[^>]+> 312f      	srl	s2,s2,7
[0-9a-f]+ <[^>]+> 3128      	srl	s2,s2,8
[0-9a-f]+ <[^>]+> 3138      	srl	s2,s3,8
[0-9a-f]+ <[^>]+> 3148      	srl	s2,a0,8
[0-9a-f]+ <[^>]+> 3158      	srl	s2,a1,8
[0-9a-f]+ <[^>]+> 3168      	srl	s2,a2,8
[0-9a-f]+ <[^>]+> 3178      	srl	s2,a3,8
[0-9a-f]+ <[^>]+> 3108      	srl	s2,s0,8
[0-9a-f]+ <[^>]+> 3118      	srl	s2,s1,8
[0-9a-f]+ <[^>]+> 3128      	srl	s2,s2,8
[0-9a-f]+ <[^>]+> 31a8      	srl	s3,s2,8
[0-9a-f]+ <[^>]+> 3228      	srl	a0,s2,8
[0-9a-f]+ <[^>]+> 32a8      	srl	a1,s2,8
[0-9a-f]+ <[^>]+> 3328      	srl	a2,s2,8
[0-9a-f]+ <[^>]+> 33a8      	srl	a3,s2,8
[0-9a-f]+ <[^>]+> 3028      	srl	s0,s2,8
[0-9a-f]+ <[^>]+> 30a8      	srl	s1,s2,8
[0-9a-f]+ <[^>]+> 31b9      	srl	s3,s3,1
[0-9a-f]+ <[^>]+> 31b9      	srl	s3,s3,1
[0-9a-f]+ <[^>]+> 2083 1190 	sub	v0,v1,a0
[0-9a-f]+ <[^>]+> 23fe e990 	sub	sp,s8,ra
[0-9a-f]+ <[^>]+> 2082 1190 	sub	v0,v0,a0
[0-9a-f]+ <[^>]+> 2082 1190 	sub	v0,v0,a0
[0-9a-f]+ <[^>]+> 0042 0000 	addiu	v0,v0,0
[0-9a-f]+ <[^>]+> 0042 9fff 	addiu	v0,v0,-1
[0-9a-f]+ <[^>]+> 6020 0000 7fff 	li	at,0x7fff
[0-9a-f]+ <[^>]+> 2022 1190 	sub	v0,v0,at
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2022 1190 	sub	v0,v0,at
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 2022 1190 	sub	v0,v0,at
[0-9a-f]+ <[^>]+> b135      	subu	s2,s3,s2
[0-9a-f]+ <[^>]+> b1b5      	subu	s2,s3,s3
[0-9a-f]+ <[^>]+> b235      	subu	s2,s3,a0
[0-9a-f]+ <[^>]+> b2b5      	subu	s2,s3,a1
[0-9a-f]+ <[^>]+> b335      	subu	s2,s3,a2
[0-9a-f]+ <[^>]+> b3b5      	subu	s2,s3,a3
[0-9a-f]+ <[^>]+> b035      	subu	s2,s3,s0
[0-9a-f]+ <[^>]+> b0b5      	subu	s2,s3,s1
[0-9a-f]+ <[^>]+> b0a5      	subu	s2,s2,s1
[0-9a-f]+ <[^>]+> b0c5      	subu	s2,a0,s1
[0-9a-f]+ <[^>]+> b0d5      	subu	s2,a1,s1
[0-9a-f]+ <[^>]+> b0e5      	subu	s2,a2,s1
[0-9a-f]+ <[^>]+> b0f5      	subu	s2,a3,s1
[0-9a-f]+ <[^>]+> b085      	subu	s2,s0,s1
[0-9a-f]+ <[^>]+> b095      	subu	s2,s1,s1
[0-9a-f]+ <[^>]+> b0a5      	subu	s2,s2,s1
[0-9a-f]+ <[^>]+> b0a7      	subu	s3,s2,s1
[0-9a-f]+ <[^>]+> b0a9      	subu	a0,s2,s1
[0-9a-f]+ <[^>]+> b0ab      	subu	a1,s2,s1
[0-9a-f]+ <[^>]+> b0ad      	subu	a2,s2,s1
[0-9a-f]+ <[^>]+> b0af      	subu	a3,s2,s1
[0-9a-f]+ <[^>]+> b0a1      	subu	s0,s2,s1
[0-9a-f]+ <[^>]+> b0a3      	subu	s1,s2,s1
[0-9a-f]+ <[^>]+> b17f      	subu	a3,a3,s2
[0-9a-f]+ <[^>]+> b17f      	subu	a3,a3,s2
[0-9a-f]+ <[^>]+> 2083 11d0 	subu	v0,v1,a0
[0-9a-f]+ <[^>]+> 23fe e9d0 	subu	sp,s8,ra
[0-9a-f]+ <[^>]+> 2082 11d0 	subu	v0,v0,a0
[0-9a-f]+ <[^>]+> 2082 11d0 	subu	v0,v0,a0
[0-9a-f]+ <[^>]+> 0042 0000 	addiu	v0,v0,0
[0-9a-f]+ <[^>]+> 0042 9fff 	addiu	v0,v0,-1
[0-9a-f]+ <[^>]+> 6020 0000 7fff 	li	at,0x7fff
[0-9a-f]+ <[^>]+> 2022 11d0 	subu	v0,v0,at
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2022 11d0 	subu	v0,v0,at
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 2022 11d0 	subu	v0,v0,at
[0-9a-f]+ <[^>]+> f540      	sw	s2,0\(a0\)
[0-9a-f]+ <[^>]+> f540      	sw	s2,0\(a0\)
[0-9a-f]+ <[^>]+> f541      	sw	s2,4\(a0\)
[0-9a-f]+ <[^>]+> f542      	sw	s2,8\(a0\)
[0-9a-f]+ <[^>]+> f543      	sw	s2,12\(a0\)
[0-9a-f]+ <[^>]+> f544      	sw	s2,16\(a0\)
[0-9a-f]+ <[^>]+> f545      	sw	s2,20\(a0\)
[0-9a-f]+ <[^>]+> f546      	sw	s2,24\(a0\)
[0-9a-f]+ <[^>]+> f547      	sw	s2,28\(a0\)
[0-9a-f]+ <[^>]+> f548      	sw	s2,32\(a0\)
[0-9a-f]+ <[^>]+> f549      	sw	s2,36\(a0\)
[0-9a-f]+ <[^>]+> f54a      	sw	s2,40\(a0\)
[0-9a-f]+ <[^>]+> f54b      	sw	s2,44\(a0\)
[0-9a-f]+ <[^>]+> f54c      	sw	s2,48\(a0\)
[0-9a-f]+ <[^>]+> f54d      	sw	s2,52\(a0\)
[0-9a-f]+ <[^>]+> f54e      	sw	s2,56\(a0\)
[0-9a-f]+ <[^>]+> f54f      	sw	s2,60\(a0\)
[0-9a-f]+ <[^>]+> f55f      	sw	s2,60\(a1\)
[0-9a-f]+ <[^>]+> f56f      	sw	s2,60\(a2\)
[0-9a-f]+ <[^>]+> f57f      	sw	s2,60\(a3\)
[0-9a-f]+ <[^>]+> f50f      	sw	s2,60\(s0\)
[0-9a-f]+ <[^>]+> f51f      	sw	s2,60\(s1\)
[0-9a-f]+ <[^>]+> f52f      	sw	s2,60\(s2\)
[0-9a-f]+ <[^>]+> f53f      	sw	s2,60\(s3\)
[0-9a-f]+ <[^>]+> f5bf      	sw	s3,60\(s3\)
[0-9a-f]+ <[^>]+> f63f      	sw	a0,60\(s3\)
[0-9a-f]+ <[^>]+> f6bf      	sw	a1,60\(s3\)
[0-9a-f]+ <[^>]+> f73f      	sw	a2,60\(s3\)
[0-9a-f]+ <[^>]+> f7bf      	sw	a3,60\(s3\)
[0-9a-f]+ <[^>]+> f4bf      	sw	s1,60\(s3\)
[0-9a-f]+ <[^>]+> f43f      	sw	zero,60\(s3\)
[0-9a-f]+ <[^>]+> d400      	sw	zero,0\(sp\)
[0-9a-f]+ <[^>]+> d400      	sw	zero,0\(sp\)
[0-9a-f]+ <[^>]+> d401      	sw	zero,4\(sp\)
[0-9a-f]+ <[^>]+> d402      	sw	zero,8\(sp\)
[0-9a-f]+ <[^>]+> d403      	sw	zero,12\(sp\)
[0-9a-f]+ <[^>]+> d404      	sw	zero,16\(sp\)
[0-9a-f]+ <[^>]+> d405      	sw	zero,20\(sp\)
[0-9a-f]+ <[^>]+> d41e      	sw	zero,120\(sp\)
[0-9a-f]+ <[^>]+> d41f      	sw	zero,124\(sp\)
[0-9a-f]+ <[^>]+> d45f      	sw	v0,124\(sp\)
[0-9a-f]+ <[^>]+> d63f      	sw	s1,124\(sp\)
[0-9a-f]+ <[^>]+> d47f      	sw	v1,124\(sp\)
[0-9a-f]+ <[^>]+> d49f      	sw	a0,124\(sp\)
[0-9a-f]+ <[^>]+> d4bf      	sw	a1,124\(sp\)
[0-9a-f]+ <[^>]+> d4df      	sw	a2,124\(sp\)
[0-9a-f]+ <[^>]+> d4ff      	sw	a3,124\(sp\)
[0-9a-f]+ <[^>]+> d7ff      	sw	ra,124\(sp\)
[0-9a-f]+ <[^>]+> 8460 9004 	sw	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 9004 	sw	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 9fff 	sw	v1,4095\(zero\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 8461 9fff 	sw	v1,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 8461 9001 	sw	v1,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 8461 9001 	sw	v1,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 0020 9fff 	li	at,-1
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 8461 9678 	sw	v1,1656\(at\)
[0-9a-f]+ <[^>]+> 8464 9000 	sw	v1,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 9000 	sw	v1,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 9fff 	sw	v1,4095\(a0\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9fff 	sw	v1,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9001 	sw	v1,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9001 	sw	v1,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 0024 9fff 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9678 	sw	v1,1656\(at\)
[0-9a-f]+ <[^>]+> 8000 c006 	sync
[0-9a-f]+ <[^>]+> 8000 c006 	sync
[0-9a-f]+ <[^>]+> 8001 c006 	sync	0x1
[0-9a-f]+ <[^>]+> 8002 c006 	sync	0x2
[0-9a-f]+ <[^>]+> 8003 c006 	sync	0x3
[0-9a-f]+ <[^>]+> 8004 c006 	sync	0x4
[0-9a-f]+ <[^>]+> 801e c006 	sync	0x1e
[0-9a-f]+ <[^>]+> 801f c006 	sync	0x1f
[0-9a-f]+ <[^>]+> a7e0 1800 	synci	0\(zero\)
[0-9a-f]+ <[^>]+> a7e0 1800 	synci	0\(zero\)
[0-9a-f]+ <[^>]+> a7e0 1800 	synci	0\(zero\)
[0-9a-f]+ <[^>]+> a7e2 1800 	synci	0\(v0\)
[0-9a-f]+ <[^>]+> a7e3 1800 	synci	0\(v1\)
[0-9a-f]+ <[^>]+> a7e3 18ff 	synci	255\(v1\)
[0-9a-f]+ <[^>]+> a7e3 9800 	synci	-256\(v1\)
[0-9a-f]+ <[^>]+> 1008      	syscall
[0-9a-f]+ <[^>]+> 1008      	syscall
[0-9a-f]+ <[^>]+> 1009      	syscall	1
[0-9a-f]+ <[^>]+> 100a      	syscall	2
[0-9a-f]+ <[^>]+> 0008 00ff 	syscall	0xff
[0-9a-f]+ <[^>]+> 8460 4004 	lh	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 4004 	lh	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 4000 	lh	v1,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 4000 	lh	v1,0\(a0\)
[0-9a-f]+ <[^>]+> e020 7000 	lui	at,0x7
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 4ffb 	lh	v1,4091\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 4000 	lh	v1,0\(at\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 4fff 	lh	v1,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 4000 	lh	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 4000 	lh	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 4001 	lh	v1,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 4001 	lh	v1,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 4000 	lh	v1,0\(at\)
[0-9a-f]+ <[^>]+> 0024 9fff 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> 8461 4000 	lh	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8460 4004 	lh	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 4004 	lh	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 4000 	lh	v1,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 4000 	lh	v1,0\(a0\)
[0-9a-f]+ <[^>]+> e020 7000 	lui	at,0x7
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 4ffb 	lh	v1,4091\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 4000 	lh	v1,0\(at\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 4fff 	lh	v1,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 4000 	lh	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 4000 	lh	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 4001 	lh	v1,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 4001 	lh	v1,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 4000 	lh	v1,0\(at\)
[0-9a-f]+ <[^>]+> 0024 9fff 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> 8461 4000 	lh	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8460 8000 	lw	v1,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 8000 	lw	v1,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 8004 	lw	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 8004 	lw	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 87ff 	lw	v1,2047\(zero\)
[0-9a-f]+ <[^>]+> 0020 9800 	li	at,-2048
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8460 8800 	lw	v1,2048\(zero\)
[0-9a-f]+ <[^>]+> 0020 97ff 	li	at,-2049
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e020 7000 	lui	at,0x7
[0-9a-f]+ <[^>]+> 8461 8ffb 	lw	v1,4091\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 8461 8fff 	lw	v1,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 8461 8001 	lw	v1,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 8461 8001 	lw	v1,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 0020 9fff 	li	at,-1
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 8461 8678 	lw	v1,1656\(at\)
[0-9a-f]+ <[^>]+> 8464 8000 	lw	v1,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 8004 	lw	v1,4\(a0\)
[0-9a-f]+ <[^>]+> 8464 87ff 	lw	v1,2047\(a0\)
[0-9a-f]+ <[^>]+> 0024 9800 	addiu	at,a0,-2048
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8464 8800 	lw	v1,2048\(a0\)
[0-9a-f]+ <[^>]+> 0024 97ff 	addiu	at,a0,-2049
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e020 7000 	lui	at,0x7
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 8ffb 	lw	v1,4091\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 8fff 	lw	v1,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 8001 	lw	v1,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 8001 	lw	v1,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 0024 9fff 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 8678 	lw	v1,1656\(at\)
[0-9a-f]+ <[^>]+> 8460 5004 	sh	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 5004 	sh	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 5000 	sh	v1,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 5000 	sh	v1,0\(a0\)
[0-9a-f]+ <[^>]+> e020 7000 	lui	at,0x7
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5ffb 	sh	v1,4091\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5000 	sh	v1,0\(at\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5fff 	sh	v1,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5000 	sh	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5000 	sh	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5001 	sh	v1,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5001 	sh	v1,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5000 	sh	v1,0\(at\)
[0-9a-f]+ <[^>]+> 0024 9fff 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> 8461 5000 	sh	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8460 9000 	sw	v1,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 9000 	sw	v1,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 9004 	sw	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 9004 	sw	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 97ff 	sw	v1,2047\(zero\)
[0-9a-f]+ <[^>]+> 0020 9800 	li	at,-2048
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8460 9800 	sw	v1,2048\(zero\)
[0-9a-f]+ <[^>]+> 0020 97ff 	li	at,-2049
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e020 7000 	lui	at,0x7
[0-9a-f]+ <[^>]+> 8461 9ffb 	sw	v1,4091\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 8461 9fff 	sw	v1,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 8461 9001 	sw	v1,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 8461 9001 	sw	v1,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 0020 9fff 	li	at,-1
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 8461 9678 	sw	v1,1656\(at\)
[0-9a-f]+ <[^>]+> 8464 9000 	sw	v1,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 9004 	sw	v1,4\(a0\)
[0-9a-f]+ <[^>]+> 8464 97ff 	sw	v1,2047\(a0\)
[0-9a-f]+ <[^>]+> 0024 9800 	addiu	at,a0,-2048
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8464 9800 	sw	v1,2048\(a0\)
[0-9a-f]+ <[^>]+> 0024 97ff 	addiu	at,a0,-2049
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e020 7000 	lui	at,0x7
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9ffb 	sw	v1,4091\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9fff 	sw	v1,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9001 	sw	v1,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9001 	sw	v1,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 0024 9fff 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9678 	sw	v1,1656\(at\)
[0-9a-f]+ <[^>]+> 2000 c37f 	wait
[0-9a-f]+ <[^>]+> 2000 c37f 	wait
[0-9a-f]+ <[^>]+> 2001 c37f 	wait	0x1
[0-9a-f]+ <[^>]+> 20ff c37f 	wait	0xff
[0-9a-f]+ <[^>]+> 2043 f17f 	wrpgpr	v0,v1
[0-9a-f]+ <[^>]+> 2044 f17f 	wrpgpr	v0,a0
[0-9a-f]+ <[^>]+> 2042 f17f 	wrpgpr	v0,v0
[0-9a-f]+ <[^>]+> 2042 f17f 	wrpgpr	v0,v0
[0-9a-f]+ <[^>]+> 2043 7b3f 	wsbh	v0,v1
[0-9a-f]+ <[^>]+> 2044 7b3f 	wsbh	v0,a0
[0-9a-f]+ <[^>]+> 2042 7b3f 	wsbh	v0,v0
[0-9a-f]+ <[^>]+> 2042 7b3f 	wsbh	v0,v0
[0-9a-f]+ <[^>]+> 5124      	xor	s2,s2,s2
[0-9a-f]+ <[^>]+> 5134      	xor	s2,s2,s3
[0-9a-f]+ <[^>]+> 5144      	xor	s2,s2,a0
[0-9a-f]+ <[^>]+> 5154      	xor	s2,s2,a1
[0-9a-f]+ <[^>]+> 5164      	xor	s2,s2,a2
[0-9a-f]+ <[^>]+> 5174      	xor	s2,s2,a3
[0-9a-f]+ <[^>]+> 5104      	xor	s2,s2,s0
[0-9a-f]+ <[^>]+> 5114      	xor	s2,s2,s1
[0-9a-f]+ <[^>]+> 5194      	xor	s3,s3,s1
[0-9a-f]+ <[^>]+> 5214      	xor	a0,a0,s1
[0-9a-f]+ <[^>]+> 5294      	xor	a1,a1,s1
[0-9a-f]+ <[^>]+> 5314      	xor	a2,a2,s1
[0-9a-f]+ <[^>]+> 5394      	xor	a3,a3,s1
[0-9a-f]+ <[^>]+> 5014      	xor	s0,s0,s1
[0-9a-f]+ <[^>]+> 5094      	xor	s1,s1,s1
[0-9a-f]+ <[^>]+> 5134      	xor	s2,s2,s3
[0-9a-f]+ <[^>]+> 5134      	xor	s2,s2,s3
[0-9a-f]+ <[^>]+> 5134      	xor	s2,s2,s3
[0-9a-f]+ <[^>]+> 2083 1310 	xor	v0,v1,a0
[0-9a-f]+ <[^>]+> 23fe eb10 	xor	sp,s8,ra
[0-9a-f]+ <[^>]+> 2082 1310 	xor	v0,v0,a0
[0-9a-f]+ <[^>]+> 2082 1310 	xor	v0,v0,a0
[0-9a-f]+ <[^>]+> e020 8000 	lui	at,0x8
[0-9a-f]+ <[^>]+> 2023 1310 	xor	v0,v1,at
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 2023 1310 	xor	v0,v1,at
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2023 1310 	xor	v0,v1,at
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2023 1310 	xor	v0,v1,at
[0-9a-f]+ <[^>]+> 6020 ffff 7fff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2023 1310 	xor	v0,v1,at
[0-9a-f]+ <[^>]+> 8064 1000 	xori	v1,a0,0
[0-9a-f]+ <[^>]+> 8063 1fff 	xori	v1,v1,4095
[0-9a-f]+ <[^>]+> e920 0000 	beqzc	t1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC20_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8949 0000 	beqc	t1,t2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> e920 0000 	beqzc	t1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC20_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> c920 0800 	beqic	t1,1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC11_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 880a 8000 	bgezc	t2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 880a 8000 	bgezc	t2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8940 8000 	blezc	t2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 896a 8000 	bgec	t2,t3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 880a 8000 	bgezc	t2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a940 8000 	bgtzc	t2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> c948 1000 	bgeic	t2,2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC11_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC25_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8802 c000 	bgeuc	v0,zero,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8840 c000 	bgeuc	zero,v0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8862 c000 	bgeuc	v0,v1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC25_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> e850 0000 	bnezc	v0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC20_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> c84c 1000 	bgeuic	v0,2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC11_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8802 8000 	bgezc	v0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a840 8000 	bgtzc	v0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a802 8000 	bltzc	v0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 212a 0b50 	slt	at,t2,t1
[0-9a-f]+ <[^>]+> e830 0000 	bnezc	at,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC20_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 9008      	nop
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8809 8000 	bgezc	t1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a920 8000 	bgtzc	t1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> c928 1000 	bgeic	t1,2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC11_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 6020 8000 0001 	li	at,0x80000001
[0-9a-f]+ <[^>]+> 2029 0b50 	slt	at,t1,at
[0-9a-f]+ <[^>]+> e820 0000 	beqzc	at,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC20_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> e930 0000 	bnezc	t1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC20_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 9008      	nop
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 212a 0b90 	sltu	at,t2,t1
[0-9a-f]+ <[^>]+> e830 0000 	bnezc	at,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC20_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 9008      	nop
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 9008      	nop
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 9008      	nop
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> e930 0000 	bnezc	t1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC20_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> c92c 1000 	bgeuic	t1,2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC11_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a920 8000 	bgtzc	t1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8920 8000 	blezc	t1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 880a 8000 	bgezc	t2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 212a 0b50 	slt	at,t2,t1
[0-9a-f]+ <[^>]+> e820 0000 	beqzc	at,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC20_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC25_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a809 8000 	bltzc	t1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8920 8000 	blezc	t1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> c938 1000 	bltic	t1,2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC11_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> e920 0000 	beqzc	t1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC20_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC25_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 212a 0b90 	sltu	at,t2,t1
[0-9a-f]+ <[^>]+> e820 0000 	beqzc	at,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC20_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC25_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC25_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> e920 0000 	beqzc	t1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC20_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> c93c 1000 	bltuic	t1,2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC11_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8920 8000 	blezc	t1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a809 8000 	bltzc	t1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a940 8000 	bgtzc	t2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a949 8000 	bltc	t1,t2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a809 8000 	bltzc	t1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8920 8000 	blezc	t1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> c938 1000 	bltic	t1,2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC11_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a809 c000 	bltuc	t1,zero,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a940 c000 	bltuc	zero,t2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a949 c000 	bltuc	t1,t2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 9008      	nop
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> e920 0000 	beqzc	t1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC20_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> c93c 1000 	bltuic	t1,2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC11_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a809 8000 	bltzc	t1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> e930 0000 	bnezc	t1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC20_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a949 0000 	bnec	t1,t2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC14_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> e930 0000 	bnezc	t1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC20_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> c930 0800 	bneic	t1,1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC11_S1	test-0x4
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8460 d004 	sd	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 d004 	sd	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 6020 0000 7fff 	li	at,0x7fff
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 8461 9001 	sw	v1,1\(at\)
[0-9a-f]+ <[^>]+> 8481 9005 	sw	a0,5\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 8461 9001 	sw	v1,1\(at\)
[0-9a-f]+ <[^>]+> 8481 9005 	sw	a0,5\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> 0020 9fff 	li	at,-1
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 8461 9678 	sw	v1,1656\(at\)
[0-9a-f]+ <[^>]+> 8481 967c 	sw	a0,1660\(at\)
[0-9a-f]+ <[^>]+> 8464 d000 	sd	v1,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 d000 	sd	v1,0\(a0\)
[0-9a-f]+ <[^>]+> 6020 0000 7fff 	li	at,0x7fff
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 9001 	sw	v1,1\(at\)
[0-9a-f]+ <[^>]+> 8481 9005 	sw	a0,5\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 9001 	sw	v1,1\(at\)
[0-9a-f]+ <[^>]+> 8481 9005 	sw	a0,5\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> 0024 9fff 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> 8461 9000 	sw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 9678 	sw	v1,1656\(at\)
[0-9a-f]+ <[^>]+> 8481 967c 	sw	a0,1660\(at\)
[0-9a-f]+ <[^>]+> 8460 c004 	ld	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 c004 	ld	v1,4\(zero\)
[0-9a-f]+ <[^>]+> 6020 0000 7fff 	li	at,0x7fff
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 8461 8001 	lw	v1,1\(at\)
[0-9a-f]+ <[^>]+> 8481 8005 	lw	a0,5\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 8461 8001 	lw	v1,1\(at\)
[0-9a-f]+ <[^>]+> 8481 8005 	lw	a0,5\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> 0020 9fff 	li	at,-1
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 8461 8678 	lw	v1,1656\(at\)
[0-9a-f]+ <[^>]+> 8481 867c 	lw	a0,1660\(at\)
[0-9a-f]+ <[^>]+> 8464 c000 	ld	v1,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 c000 	ld	v1,0\(a0\)
[0-9a-f]+ <[^>]+> 6020 0000 7fff 	li	at,0x7fff
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> 6020 0000 ffff 	li	at,0xffff
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 8001 	lw	v1,1\(at\)
[0-9a-f]+ <[^>]+> 8481 8005 	lw	a0,5\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 8001 	lw	v1,1\(at\)
[0-9a-f]+ <[^>]+> 8481 8005 	lw	a0,5\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> 0024 9fff 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> 8461 8000 	lw	v1,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 8678 	lw	v1,1656\(at\)
[0-9a-f]+ <[^>]+> 8481 867c 	lw	a0,1660\(at\)
[0-9a-f]+ <[^>]+> 1fa0      	restore\.jrc	0
[0-9a-f]+ <[^>]+> 1fa2      	restore\.jrc	8
[0-9a-f]+ <[^>]+> 1fa4      	restore\.jrc	16
[0-9a-f]+ <[^>]+> 1fa6      	restore\.jrc	24
[0-9a-f]+ <[^>]+> 1fa8      	restore\.jrc	32
[0-9a-f]+ <[^>]+> 1faa      	restore\.jrc	40
[0-9a-f]+ <[^>]+> 03bd 0004 	addiu	sp,sp,4
[0-9a-f]+ <[^>]+> 481f 0000 	jrc	ra
[0-9a-f]+ <[^>]+> 03bd 000c 	addiu	sp,sp,12
[0-9a-f]+ <[^>]+> 481f 0000 	jrc	ra
[0-9a-f]+ <[^>]+> 03bd 0014 	addiu	sp,sp,20
[0-9a-f]+ <[^>]+> 481f 0000 	jrc	ra
[0-9a-f]+ <[^>]+> 03bd 001c 	addiu	sp,sp,28
[0-9a-f]+ <[^>]+> 481f 0000 	jrc	ra
[0-9a-f]+ <[^>]+> 03bd 0024 	addiu	sp,sp,36
[0-9a-f]+ <[^>]+> 481f 0000 	jrc	ra
[0-9a-f]+ <[^>]+> 1fbe      	restore\.jrc	120
[0-9a-f]+ <[^>]+> 03bd 007c 	addiu	sp,sp,124
[0-9a-f]+ <[^>]+> 481f 0000 	jrc	ra
[0-9a-f]+ <[^>]+> a460 7100 	ldc2	\$3,0\(zero\)
[0-9a-f]+ <[^>]+> a460 7100 	ldc2	\$3,0\(zero\)
[0-9a-f]+ <[^>]+> a460 7104 	ldc2	\$3,4\(zero\)
[0-9a-f]+ <[^>]+> a460 7104 	ldc2	\$3,4\(zero\)
[0-9a-f]+ <[^>]+> a464 7100 	ldc2	\$3,0\(a0\)
[0-9a-f]+ <[^>]+> a464 7100 	ldc2	\$3,0\(a0\)
[0-9a-f]+ <[^>]+> e020 8000 	lui	at,0x8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 f1ff 	ldc2	\$3,-1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 7100 	ldc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 f1ff 	ldc2	\$3,-1\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 7100 	ldc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 7100 	ldc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 7101 	ldc2	\$3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 7101 	ldc2	\$3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 7100 	ldc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> a464 f1ff 	ldc2	\$3,-1\(a0\)
[0-9a-f]+ <[^>]+> 6020 1234 5600 	li	at,0x12345600
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 7178 	ldc2	\$3,120\(at\)
[0-9a-f]+ <[^>]+> a460 5100 	lwc2	\$3,0\(zero\)
[0-9a-f]+ <[^>]+> a460 5100 	lwc2	\$3,0\(zero\)
[0-9a-f]+ <[^>]+> a460 5104 	lwc2	\$3,4\(zero\)
[0-9a-f]+ <[^>]+> a460 5104 	lwc2	\$3,4\(zero\)
[0-9a-f]+ <[^>]+> a464 5100 	lwc2	\$3,0\(a0\)
[0-9a-f]+ <[^>]+> a464 5100 	lwc2	\$3,0\(a0\)
[0-9a-f]+ <[^>]+> e020 8000 	lui	at,0x8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 d1ff 	lwc2	\$3,-1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 5100 	lwc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 d1ff 	lwc2	\$3,-1\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 5100 	lwc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 5100 	lwc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 5101 	lwc2	\$3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 5101 	lwc2	\$3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 5100 	lwc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> a464 d1ff 	lwc2	\$3,-1\(a0\)
[0-9a-f]+ <[^>]+> 6020 1234 5600 	li	at,0x12345600
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 5178 	lwc2	\$3,120\(at\)
[0-9a-f]+ <[^>]+> 20a0 4d3f 	mfc2	a1,\$0
[0-9a-f]+ <[^>]+> 20a1 4d3f 	mfc2	a1,\$1
[0-9a-f]+ <[^>]+> 20a2 4d3f 	mfc2	a1,\$2
[0-9a-f]+ <[^>]+> 20a3 4d3f 	mfc2	a1,\$3
[0-9a-f]+ <[^>]+> 20a4 4d3f 	mfc2	a1,\$4
[0-9a-f]+ <[^>]+> 20a5 4d3f 	mfc2	a1,\$5
[0-9a-f]+ <[^>]+> 20a6 4d3f 	mfc2	a1,\$6
[0-9a-f]+ <[^>]+> 20a7 4d3f 	mfc2	a1,\$7
[0-9a-f]+ <[^>]+> 20a8 4d3f 	mfc2	a1,\$8
[0-9a-f]+ <[^>]+> 20a9 4d3f 	mfc2	a1,\$9
[0-9a-f]+ <[^>]+> 20aa 4d3f 	mfc2	a1,\$10
[0-9a-f]+ <[^>]+> 20ab 4d3f 	mfc2	a1,\$11
[0-9a-f]+ <[^>]+> 20ac 4d3f 	mfc2	a1,\$12
[0-9a-f]+ <[^>]+> 20ad 4d3f 	mfc2	a1,\$13
[0-9a-f]+ <[^>]+> 20ae 4d3f 	mfc2	a1,\$14
[0-9a-f]+ <[^>]+> 20af 4d3f 	mfc2	a1,\$15
[0-9a-f]+ <[^>]+> 20b0 4d3f 	mfc2	a1,\$16
[0-9a-f]+ <[^>]+> 20b1 4d3f 	mfc2	a1,\$17
[0-9a-f]+ <[^>]+> 20b2 4d3f 	mfc2	a1,\$18
[0-9a-f]+ <[^>]+> 20b3 4d3f 	mfc2	a1,\$19
[0-9a-f]+ <[^>]+> 20b4 4d3f 	mfc2	a1,\$20
[0-9a-f]+ <[^>]+> 20b5 4d3f 	mfc2	a1,\$21
[0-9a-f]+ <[^>]+> 20b6 4d3f 	mfc2	a1,\$22
[0-9a-f]+ <[^>]+> 20b7 4d3f 	mfc2	a1,\$23
[0-9a-f]+ <[^>]+> 20b8 4d3f 	mfc2	a1,\$24
[0-9a-f]+ <[^>]+> 20b9 4d3f 	mfc2	a1,\$25
[0-9a-f]+ <[^>]+> 20ba 4d3f 	mfc2	a1,\$26
[0-9a-f]+ <[^>]+> 20bb 4d3f 	mfc2	a1,\$27
[0-9a-f]+ <[^>]+> 20bc 4d3f 	mfc2	a1,\$28
[0-9a-f]+ <[^>]+> 20bd 4d3f 	mfc2	a1,\$29
[0-9a-f]+ <[^>]+> 20be 4d3f 	mfc2	a1,\$30
[0-9a-f]+ <[^>]+> 20bf 4d3f 	mfc2	a1,\$31
[0-9a-f]+ <[^>]+> 20a0 8d3f 	mfhc2	a1,\$0
[0-9a-f]+ <[^>]+> 20a1 8d3f 	mfhc2	a1,\$1
[0-9a-f]+ <[^>]+> 20a2 8d3f 	mfhc2	a1,\$2
[0-9a-f]+ <[^>]+> 20a3 8d3f 	mfhc2	a1,\$3
[0-9a-f]+ <[^>]+> 20a4 8d3f 	mfhc2	a1,\$4
[0-9a-f]+ <[^>]+> 20a5 8d3f 	mfhc2	a1,\$5
[0-9a-f]+ <[^>]+> 20a6 8d3f 	mfhc2	a1,\$6
[0-9a-f]+ <[^>]+> 20a7 8d3f 	mfhc2	a1,\$7
[0-9a-f]+ <[^>]+> 20a8 8d3f 	mfhc2	a1,\$8
[0-9a-f]+ <[^>]+> 20a9 8d3f 	mfhc2	a1,\$9
[0-9a-f]+ <[^>]+> 20aa 8d3f 	mfhc2	a1,\$10
[0-9a-f]+ <[^>]+> 20ab 8d3f 	mfhc2	a1,\$11
[0-9a-f]+ <[^>]+> 20ac 8d3f 	mfhc2	a1,\$12
[0-9a-f]+ <[^>]+> 20ad 8d3f 	mfhc2	a1,\$13
[0-9a-f]+ <[^>]+> 20ae 8d3f 	mfhc2	a1,\$14
[0-9a-f]+ <[^>]+> 20af 8d3f 	mfhc2	a1,\$15
[0-9a-f]+ <[^>]+> 20b0 8d3f 	mfhc2	a1,\$16
[0-9a-f]+ <[^>]+> 20b1 8d3f 	mfhc2	a1,\$17
[0-9a-f]+ <[^>]+> 20b2 8d3f 	mfhc2	a1,\$18
[0-9a-f]+ <[^>]+> 20b3 8d3f 	mfhc2	a1,\$19
[0-9a-f]+ <[^>]+> 20b4 8d3f 	mfhc2	a1,\$20
[0-9a-f]+ <[^>]+> 20b5 8d3f 	mfhc2	a1,\$21
[0-9a-f]+ <[^>]+> 20b6 8d3f 	mfhc2	a1,\$22
[0-9a-f]+ <[^>]+> 20b7 8d3f 	mfhc2	a1,\$23
[0-9a-f]+ <[^>]+> 20b8 8d3f 	mfhc2	a1,\$24
[0-9a-f]+ <[^>]+> 20b9 8d3f 	mfhc2	a1,\$25
[0-9a-f]+ <[^>]+> 20ba 8d3f 	mfhc2	a1,\$26
[0-9a-f]+ <[^>]+> 20bb 8d3f 	mfhc2	a1,\$27
[0-9a-f]+ <[^>]+> 20bc 8d3f 	mfhc2	a1,\$28
[0-9a-f]+ <[^>]+> 20bd 8d3f 	mfhc2	a1,\$29
[0-9a-f]+ <[^>]+> 20be 8d3f 	mfhc2	a1,\$30
[0-9a-f]+ <[^>]+> 20bf 8d3f 	mfhc2	a1,\$31
[0-9a-f]+ <[^>]+> 20a0 5d3f 	mtc2	a1,\$0
[0-9a-f]+ <[^>]+> 20a1 5d3f 	mtc2	a1,\$1
[0-9a-f]+ <[^>]+> 20a2 5d3f 	mtc2	a1,\$2
[0-9a-f]+ <[^>]+> 20a3 5d3f 	mtc2	a1,\$3
[0-9a-f]+ <[^>]+> 20a4 5d3f 	mtc2	a1,\$4
[0-9a-f]+ <[^>]+> 20a5 5d3f 	mtc2	a1,\$5
[0-9a-f]+ <[^>]+> 20a6 5d3f 	mtc2	a1,\$6
[0-9a-f]+ <[^>]+> 20a7 5d3f 	mtc2	a1,\$7
[0-9a-f]+ <[^>]+> 20a8 5d3f 	mtc2	a1,\$8
[0-9a-f]+ <[^>]+> 20a9 5d3f 	mtc2	a1,\$9
[0-9a-f]+ <[^>]+> 20aa 5d3f 	mtc2	a1,\$10
[0-9a-f]+ <[^>]+> 20ab 5d3f 	mtc2	a1,\$11
[0-9a-f]+ <[^>]+> 20ac 5d3f 	mtc2	a1,\$12
[0-9a-f]+ <[^>]+> 20ad 5d3f 	mtc2	a1,\$13
[0-9a-f]+ <[^>]+> 20ae 5d3f 	mtc2	a1,\$14
[0-9a-f]+ <[^>]+> 20af 5d3f 	mtc2	a1,\$15
[0-9a-f]+ <[^>]+> 20b0 5d3f 	mtc2	a1,\$16
[0-9a-f]+ <[^>]+> 20b1 5d3f 	mtc2	a1,\$17
[0-9a-f]+ <[^>]+> 20b2 5d3f 	mtc2	a1,\$18
[0-9a-f]+ <[^>]+> 20b3 5d3f 	mtc2	a1,\$19
[0-9a-f]+ <[^>]+> 20b4 5d3f 	mtc2	a1,\$20
[0-9a-f]+ <[^>]+> 20b5 5d3f 	mtc2	a1,\$21
[0-9a-f]+ <[^>]+> 20b6 5d3f 	mtc2	a1,\$22
[0-9a-f]+ <[^>]+> 20b7 5d3f 	mtc2	a1,\$23
[0-9a-f]+ <[^>]+> 20b8 5d3f 	mtc2	a1,\$24
[0-9a-f]+ <[^>]+> 20b9 5d3f 	mtc2	a1,\$25
[0-9a-f]+ <[^>]+> 20ba 5d3f 	mtc2	a1,\$26
[0-9a-f]+ <[^>]+> 20bb 5d3f 	mtc2	a1,\$27
[0-9a-f]+ <[^>]+> 20bc 5d3f 	mtc2	a1,\$28
[0-9a-f]+ <[^>]+> 20bd 5d3f 	mtc2	a1,\$29
[0-9a-f]+ <[^>]+> 20be 5d3f 	mtc2	a1,\$30
[0-9a-f]+ <[^>]+> 20bf 5d3f 	mtc2	a1,\$31
[0-9a-f]+ <[^>]+> 20a0 9d3f 	mthc2	a1,\$0
[0-9a-f]+ <[^>]+> 20a1 9d3f 	mthc2	a1,\$1
[0-9a-f]+ <[^>]+> 20a2 9d3f 	mthc2	a1,\$2
[0-9a-f]+ <[^>]+> 20a3 9d3f 	mthc2	a1,\$3
[0-9a-f]+ <[^>]+> 20a4 9d3f 	mthc2	a1,\$4
[0-9a-f]+ <[^>]+> 20a5 9d3f 	mthc2	a1,\$5
[0-9a-f]+ <[^>]+> 20a6 9d3f 	mthc2	a1,\$6
[0-9a-f]+ <[^>]+> 20a7 9d3f 	mthc2	a1,\$7
[0-9a-f]+ <[^>]+> 20a8 9d3f 	mthc2	a1,\$8
[0-9a-f]+ <[^>]+> 20a9 9d3f 	mthc2	a1,\$9
[0-9a-f]+ <[^>]+> 20aa 9d3f 	mthc2	a1,\$10
[0-9a-f]+ <[^>]+> 20ab 9d3f 	mthc2	a1,\$11
[0-9a-f]+ <[^>]+> 20ac 9d3f 	mthc2	a1,\$12
[0-9a-f]+ <[^>]+> 20ad 9d3f 	mthc2	a1,\$13
[0-9a-f]+ <[^>]+> 20ae 9d3f 	mthc2	a1,\$14
[0-9a-f]+ <[^>]+> 20af 9d3f 	mthc2	a1,\$15
[0-9a-f]+ <[^>]+> 20b0 9d3f 	mthc2	a1,\$16
[0-9a-f]+ <[^>]+> 20b1 9d3f 	mthc2	a1,\$17
[0-9a-f]+ <[^>]+> 20b2 9d3f 	mthc2	a1,\$18
[0-9a-f]+ <[^>]+> 20b3 9d3f 	mthc2	a1,\$19
[0-9a-f]+ <[^>]+> 20b4 9d3f 	mthc2	a1,\$20
[0-9a-f]+ <[^>]+> 20b5 9d3f 	mthc2	a1,\$21
[0-9a-f]+ <[^>]+> 20b6 9d3f 	mthc2	a1,\$22
[0-9a-f]+ <[^>]+> 20b7 9d3f 	mthc2	a1,\$23
[0-9a-f]+ <[^>]+> 20b8 9d3f 	mthc2	a1,\$24
[0-9a-f]+ <[^>]+> 20b9 9d3f 	mthc2	a1,\$25
[0-9a-f]+ <[^>]+> 20ba 9d3f 	mthc2	a1,\$26
[0-9a-f]+ <[^>]+> 20bb 9d3f 	mthc2	a1,\$27
[0-9a-f]+ <[^>]+> 20bc 9d3f 	mthc2	a1,\$28
[0-9a-f]+ <[^>]+> 20bd 9d3f 	mthc2	a1,\$29
[0-9a-f]+ <[^>]+> 20be 9d3f 	mthc2	a1,\$30
[0-9a-f]+ <[^>]+> 20bf 9d3f 	mthc2	a1,\$31
[0-9a-f]+ <[^>]+> a460 7900 	sdc2	\$3,0\(zero\)
[0-9a-f]+ <[^>]+> a460 7900 	sdc2	\$3,0\(zero\)
[0-9a-f]+ <[^>]+> a460 7904 	sdc2	\$3,4\(zero\)
[0-9a-f]+ <[^>]+> a460 7904 	sdc2	\$3,4\(zero\)
[0-9a-f]+ <[^>]+> a464 7900 	sdc2	\$3,0\(a0\)
[0-9a-f]+ <[^>]+> a464 7900 	sdc2	\$3,0\(a0\)
[0-9a-f]+ <[^>]+> e020 8000 	lui	at,0x8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 f9ff 	sdc2	\$3,-1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 7900 	sdc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 f9ff 	sdc2	\$3,-1\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 7900 	sdc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 7900 	sdc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 7901 	sdc2	\$3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 7901 	sdc2	\$3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 7900 	sdc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> a464 f9ff 	sdc2	\$3,-1\(a0\)
[0-9a-f]+ <[^>]+> 6020 1234 5600 	li	at,0x12345600
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 7978 	sdc2	\$3,120\(at\)
[0-9a-f]+ <[^>]+> a460 5900 	swc2	\$3,0\(zero\)
[0-9a-f]+ <[^>]+> a460 5900 	swc2	\$3,0\(zero\)
[0-9a-f]+ <[^>]+> a460 5904 	swc2	\$3,4\(zero\)
[0-9a-f]+ <[^>]+> a460 5904 	swc2	\$3,4\(zero\)
[0-9a-f]+ <[^>]+> a464 5900 	swc2	\$3,0\(a0\)
[0-9a-f]+ <[^>]+> a464 5900 	swc2	\$3,0\(a0\)
[0-9a-f]+ <[^>]+> e020 8000 	lui	at,0x8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 d9ff 	swc2	\$3,-1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 5900 	swc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 d9ff 	swc2	\$3,-1\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 5900 	swc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 5900 	swc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 5901 	swc2	\$3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 5901 	swc2	\$3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 5900 	swc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> a464 d9ff 	swc2	\$3,-1\(a0\)
[0-9a-f]+ <[^>]+> 6020 1234 5600 	li	at,0x12345600
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 5978 	swc2	\$3,120\(at\)
[0-9a-f]+ <[^>]+> 0023 0000 	addiu	at,v1,0
			[0-9a-f]+: R_MICROMIPS_LO12	test
[0-9a-f]+ <[^>]+> a401 1900 	cache	0x0,0\(at\)
[0-9a-f]+ <[^>]+> 0043 0000 	addiu	v0,v1,0
			[0-9a-f]+: R_MICROMIPS_LO12	test
[0-9a-f]+ <[^>]+> a442 4100 	ll	v0,0\(v0\)
[0-9a-f]+ <[^>]+> 0023 0000 	addiu	at,v1,0
			[0-9a-f]+: R_MICROMIPS_LO12	test
[0-9a-f]+ <[^>]+> a441 4900 	sc	v0,0\(at\)
[0-9a-f]+ <[^>]+> 0023 0000 	addiu	at,v1,0
			[0-9a-f]+: R_MICROMIPS_LO12	test
[0-9a-f]+ <[^>]+> a601 5100 	lwc2	\$16,0\(at\)
[0-9a-f]+ <[^>]+> 0023 0000 	addiu	at,v1,0
			[0-9a-f]+: R_MICROMIPS_LO12	test
[0-9a-f]+ <[^>]+> a601 5900 	swc2	\$16,0\(at\)
[0-9a-f]+ <[^>]+> 0018 03ff 	sdbbp	0x3ff
[0-9a-f]+ <[^>]+> 23ff c37f 	wait	0x3ff
[0-9a-f]+ <[^>]+> 0008 03ff 	syscall	0x3ff
[0-9a-f]+ <[^>]+> 9008      	nop
[0-9a-f]+ <[^>]+> 9008      	nop
[0-9a-f]+ <[^>]+> a001 037b 	abs\.s	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 037b 	abs\.s	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 037b 	abs\.s	\$f2,\$f2
[0-9a-f]+ <[^>]+> a042 037b 	abs\.s	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 237b 	abs\.d	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 237b 	abs\.d	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 237b 	abs\.d	\$f2,\$f2
[0-9a-f]+ <[^>]+> a042 237b 	abs\.d	\$f2,\$f2
[0-9a-f]+ <[^>]+> a041 0030 	add\.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]+> a3fe e830 	add\.s	\$f29,\$f30,\$f31
[0-9a-f]+ <[^>]+> a3dd e830 	add\.s	\$f29,\$f29,\$f30
[0-9a-f]+ <[^>]+> a3dd e830 	add\.s	\$f29,\$f29,\$f30
[0-9a-f]+ <[^>]+> a041 0130 	add\.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]+> a3fe e930 	add\.d	\$f29,\$f30,\$f31
[0-9a-f]+ <[^>]+> a3dd e930 	add\.d	\$f29,\$f29,\$f30
[0-9a-f]+ <[^>]+> a3dd e930 	add\.d	\$f29,\$f29,\$f30
[0-9a-f]+ <[^>]+> a001 533b 	ceil\.l\.d	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 533b 	ceil\.l\.d	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 533b 	ceil\.l\.d	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 133b 	ceil\.l\.s	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 133b 	ceil\.l\.s	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 133b 	ceil\.l\.s	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 5b3b 	ceil\.w\.d	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 5b3b 	ceil\.w\.d	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 5b3b 	ceil\.w\.d	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 1b3b 	ceil\.w\.s	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 1b3b 	ceil\.w\.s	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 1b3b 	ceil\.w\.s	\$f2,\$f2
[0-9a-f]+ <[^>]+> a0a0 103b 	cfc1	a1,\$f0
[0-9a-f]+ <[^>]+> a0a1 103b 	cfc1	a1,\$f1
[0-9a-f]+ <[^>]+> a0a2 103b 	cfc1	a1,\$f2
[0-9a-f]+ <[^>]+> a0a3 103b 	cfc1	a1,\$f3
[0-9a-f]+ <[^>]+> a0a4 103b 	cfc1	a1,\$f4
[0-9a-f]+ <[^>]+> a0a5 103b 	cfc1	a1,\$f5
[0-9a-f]+ <[^>]+> a0a6 103b 	cfc1	a1,\$f6
[0-9a-f]+ <[^>]+> a0a7 103b 	cfc1	a1,\$f7
[0-9a-f]+ <[^>]+> a0a8 103b 	cfc1	a1,\$f8
[0-9a-f]+ <[^>]+> a0a9 103b 	cfc1	a1,\$f9
[0-9a-f]+ <[^>]+> a0aa 103b 	cfc1	a1,\$f10
[0-9a-f]+ <[^>]+> a0ab 103b 	cfc1	a1,\$f11
[0-9a-f]+ <[^>]+> a0ac 103b 	cfc1	a1,\$f12
[0-9a-f]+ <[^>]+> a0ad 103b 	cfc1	a1,\$f13
[0-9a-f]+ <[^>]+> a0ae 103b 	cfc1	a1,\$f14
[0-9a-f]+ <[^>]+> a0af 103b 	cfc1	a1,\$f15
[0-9a-f]+ <[^>]+> a0b0 103b 	cfc1	a1,\$f16
[0-9a-f]+ <[^>]+> a0b1 103b 	cfc1	a1,\$f17
[0-9a-f]+ <[^>]+> a0b2 103b 	cfc1	a1,\$f18
[0-9a-f]+ <[^>]+> a0b3 103b 	cfc1	a1,\$f19
[0-9a-f]+ <[^>]+> a0b4 103b 	cfc1	a1,\$f20
[0-9a-f]+ <[^>]+> a0b5 103b 	cfc1	a1,\$f21
[0-9a-f]+ <[^>]+> a0b6 103b 	cfc1	a1,\$f22
[0-9a-f]+ <[^>]+> a0b7 103b 	cfc1	a1,\$f23
[0-9a-f]+ <[^>]+> a0b8 103b 	cfc1	a1,\$f24
[0-9a-f]+ <[^>]+> a0b9 103b 	cfc1	a1,\$f25
[0-9a-f]+ <[^>]+> a0ba 103b 	cfc1	a1,\$f26
[0-9a-f]+ <[^>]+> a0bb 103b 	cfc1	a1,\$f27
[0-9a-f]+ <[^>]+> a0bc 103b 	cfc1	a1,\$f28
[0-9a-f]+ <[^>]+> a0bd 103b 	cfc1	a1,\$f29
[0-9a-f]+ <[^>]+> a0be 103b 	cfc1	a1,\$f30
[0-9a-f]+ <[^>]+> a0bf 103b 	cfc1	a1,\$f31
[0-9a-f]+ <[^>]+> a0a0 103b 	cfc1	a1,\$f0
[0-9a-f]+ <[^>]+> a0a1 103b 	cfc1	a1,\$f1
[0-9a-f]+ <[^>]+> a0a2 103b 	cfc1	a1,\$f2
[0-9a-f]+ <[^>]+> a0a3 103b 	cfc1	a1,\$f3
[0-9a-f]+ <[^>]+> a0a4 103b 	cfc1	a1,\$f4
[0-9a-f]+ <[^>]+> a0a5 103b 	cfc1	a1,\$f5
[0-9a-f]+ <[^>]+> a0a6 103b 	cfc1	a1,\$f6
[0-9a-f]+ <[^>]+> a0a7 103b 	cfc1	a1,\$f7
[0-9a-f]+ <[^>]+> a0a8 103b 	cfc1	a1,\$f8
[0-9a-f]+ <[^>]+> a0a9 103b 	cfc1	a1,\$f9
[0-9a-f]+ <[^>]+> a0aa 103b 	cfc1	a1,\$f10
[0-9a-f]+ <[^>]+> a0ab 103b 	cfc1	a1,\$f11
[0-9a-f]+ <[^>]+> a0ac 103b 	cfc1	a1,\$f12
[0-9a-f]+ <[^>]+> a0ad 103b 	cfc1	a1,\$f13
[0-9a-f]+ <[^>]+> a0ae 103b 	cfc1	a1,\$f14
[0-9a-f]+ <[^>]+> a0af 103b 	cfc1	a1,\$f15
[0-9a-f]+ <[^>]+> a0b0 103b 	cfc1	a1,\$f16
[0-9a-f]+ <[^>]+> a0b1 103b 	cfc1	a1,\$f17
[0-9a-f]+ <[^>]+> a0b2 103b 	cfc1	a1,\$f18
[0-9a-f]+ <[^>]+> a0b3 103b 	cfc1	a1,\$f19
[0-9a-f]+ <[^>]+> a0b4 103b 	cfc1	a1,\$f20
[0-9a-f]+ <[^>]+> a0b5 103b 	cfc1	a1,\$f21
[0-9a-f]+ <[^>]+> a0b6 103b 	cfc1	a1,\$f22
[0-9a-f]+ <[^>]+> a0b7 103b 	cfc1	a1,\$f23
[0-9a-f]+ <[^>]+> a0b8 103b 	cfc1	a1,\$f24
[0-9a-f]+ <[^>]+> a0b9 103b 	cfc1	a1,\$f25
[0-9a-f]+ <[^>]+> a0ba 103b 	cfc1	a1,\$f26
[0-9a-f]+ <[^>]+> a0bb 103b 	cfc1	a1,\$f27
[0-9a-f]+ <[^>]+> a0bc 103b 	cfc1	a1,\$f28
[0-9a-f]+ <[^>]+> a0bd 103b 	cfc1	a1,\$f29
[0-9a-f]+ <[^>]+> a0be 103b 	cfc1	a1,\$f30
[0-9a-f]+ <[^>]+> a0bf 103b 	cfc1	a1,\$f31
[0-9a-f]+ <[^>]+> 20a0 cd3f 	cfc2	a1,\$0
[0-9a-f]+ <[^>]+> 20a1 cd3f 	cfc2	a1,\$1
[0-9a-f]+ <[^>]+> 20a2 cd3f 	cfc2	a1,\$2
[0-9a-f]+ <[^>]+> 20a3 cd3f 	cfc2	a1,\$3
[0-9a-f]+ <[^>]+> 20a4 cd3f 	cfc2	a1,\$4
[0-9a-f]+ <[^>]+> 20a5 cd3f 	cfc2	a1,\$5
[0-9a-f]+ <[^>]+> 20a6 cd3f 	cfc2	a1,\$6
[0-9a-f]+ <[^>]+> 20a7 cd3f 	cfc2	a1,\$7
[0-9a-f]+ <[^>]+> 20a8 cd3f 	cfc2	a1,\$8
[0-9a-f]+ <[^>]+> 20a9 cd3f 	cfc2	a1,\$9
[0-9a-f]+ <[^>]+> 20aa cd3f 	cfc2	a1,\$10
[0-9a-f]+ <[^>]+> 20ab cd3f 	cfc2	a1,\$11
[0-9a-f]+ <[^>]+> 20ac cd3f 	cfc2	a1,\$12
[0-9a-f]+ <[^>]+> 20ad cd3f 	cfc2	a1,\$13
[0-9a-f]+ <[^>]+> 20ae cd3f 	cfc2	a1,\$14
[0-9a-f]+ <[^>]+> 20af cd3f 	cfc2	a1,\$15
[0-9a-f]+ <[^>]+> 20b0 cd3f 	cfc2	a1,\$16
[0-9a-f]+ <[^>]+> 20b1 cd3f 	cfc2	a1,\$17
[0-9a-f]+ <[^>]+> 20b2 cd3f 	cfc2	a1,\$18
[0-9a-f]+ <[^>]+> 20b3 cd3f 	cfc2	a1,\$19
[0-9a-f]+ <[^>]+> 20b4 cd3f 	cfc2	a1,\$20
[0-9a-f]+ <[^>]+> 20b5 cd3f 	cfc2	a1,\$21
[0-9a-f]+ <[^>]+> 20b6 cd3f 	cfc2	a1,\$22
[0-9a-f]+ <[^>]+> 20b7 cd3f 	cfc2	a1,\$23
[0-9a-f]+ <[^>]+> 20b8 cd3f 	cfc2	a1,\$24
[0-9a-f]+ <[^>]+> 20b9 cd3f 	cfc2	a1,\$25
[0-9a-f]+ <[^>]+> 20ba cd3f 	cfc2	a1,\$26
[0-9a-f]+ <[^>]+> 20bb cd3f 	cfc2	a1,\$27
[0-9a-f]+ <[^>]+> 20bc cd3f 	cfc2	a1,\$28
[0-9a-f]+ <[^>]+> 20bd cd3f 	cfc2	a1,\$29
[0-9a-f]+ <[^>]+> 20be cd3f 	cfc2	a1,\$30
[0-9a-f]+ <[^>]+> 20bf cd3f 	cfc2	a1,\$31
[0-9a-f]+ <[^>]+> a0a0 183b 	ctc1	a1,\$f0
[0-9a-f]+ <[^>]+> a0a1 183b 	ctc1	a1,\$f1
[0-9a-f]+ <[^>]+> a0a2 183b 	ctc1	a1,\$f2
[0-9a-f]+ <[^>]+> a0a3 183b 	ctc1	a1,\$f3
[0-9a-f]+ <[^>]+> a0a4 183b 	ctc1	a1,\$f4
[0-9a-f]+ <[^>]+> a0a5 183b 	ctc1	a1,\$f5
[0-9a-f]+ <[^>]+> a0a6 183b 	ctc1	a1,\$f6
[0-9a-f]+ <[^>]+> a0a7 183b 	ctc1	a1,\$f7
[0-9a-f]+ <[^>]+> a0a8 183b 	ctc1	a1,\$f8
[0-9a-f]+ <[^>]+> a0a9 183b 	ctc1	a1,\$f9
[0-9a-f]+ <[^>]+> a0aa 183b 	ctc1	a1,\$f10
[0-9a-f]+ <[^>]+> a0ab 183b 	ctc1	a1,\$f11
[0-9a-f]+ <[^>]+> a0ac 183b 	ctc1	a1,\$f12
[0-9a-f]+ <[^>]+> a0ad 183b 	ctc1	a1,\$f13
[0-9a-f]+ <[^>]+> a0ae 183b 	ctc1	a1,\$f14
[0-9a-f]+ <[^>]+> a0af 183b 	ctc1	a1,\$f15
[0-9a-f]+ <[^>]+> a0b0 183b 	ctc1	a1,\$f16
[0-9a-f]+ <[^>]+> a0b1 183b 	ctc1	a1,\$f17
[0-9a-f]+ <[^>]+> a0b2 183b 	ctc1	a1,\$f18
[0-9a-f]+ <[^>]+> a0b3 183b 	ctc1	a1,\$f19
[0-9a-f]+ <[^>]+> a0b4 183b 	ctc1	a1,\$f20
[0-9a-f]+ <[^>]+> a0b5 183b 	ctc1	a1,\$f21
[0-9a-f]+ <[^>]+> a0b6 183b 	ctc1	a1,\$f22
[0-9a-f]+ <[^>]+> a0b7 183b 	ctc1	a1,\$f23
[0-9a-f]+ <[^>]+> a0b8 183b 	ctc1	a1,\$f24
[0-9a-f]+ <[^>]+> a0b9 183b 	ctc1	a1,\$f25
[0-9a-f]+ <[^>]+> a0ba 183b 	ctc1	a1,\$f26
[0-9a-f]+ <[^>]+> a0bb 183b 	ctc1	a1,\$f27
[0-9a-f]+ <[^>]+> a0bc 183b 	ctc1	a1,\$f28
[0-9a-f]+ <[^>]+> a0bd 183b 	ctc1	a1,\$f29
[0-9a-f]+ <[^>]+> a0be 183b 	ctc1	a1,\$f30
[0-9a-f]+ <[^>]+> a0bf 183b 	ctc1	a1,\$f31
[0-9a-f]+ <[^>]+> a0a0 183b 	ctc1	a1,\$f0
[0-9a-f]+ <[^>]+> a0a1 183b 	ctc1	a1,\$f1
[0-9a-f]+ <[^>]+> a0a2 183b 	ctc1	a1,\$f2
[0-9a-f]+ <[^>]+> a0a3 183b 	ctc1	a1,\$f3
[0-9a-f]+ <[^>]+> a0a4 183b 	ctc1	a1,\$f4
[0-9a-f]+ <[^>]+> a0a5 183b 	ctc1	a1,\$f5
[0-9a-f]+ <[^>]+> a0a6 183b 	ctc1	a1,\$f6
[0-9a-f]+ <[^>]+> a0a7 183b 	ctc1	a1,\$f7
[0-9a-f]+ <[^>]+> a0a8 183b 	ctc1	a1,\$f8
[0-9a-f]+ <[^>]+> a0a9 183b 	ctc1	a1,\$f9
[0-9a-f]+ <[^>]+> a0aa 183b 	ctc1	a1,\$f10
[0-9a-f]+ <[^>]+> a0ab 183b 	ctc1	a1,\$f11
[0-9a-f]+ <[^>]+> a0ac 183b 	ctc1	a1,\$f12
[0-9a-f]+ <[^>]+> a0ad 183b 	ctc1	a1,\$f13
[0-9a-f]+ <[^>]+> a0ae 183b 	ctc1	a1,\$f14
[0-9a-f]+ <[^>]+> a0af 183b 	ctc1	a1,\$f15
[0-9a-f]+ <[^>]+> a0b0 183b 	ctc1	a1,\$f16
[0-9a-f]+ <[^>]+> a0b1 183b 	ctc1	a1,\$f17
[0-9a-f]+ <[^>]+> a0b2 183b 	ctc1	a1,\$f18
[0-9a-f]+ <[^>]+> a0b3 183b 	ctc1	a1,\$f19
[0-9a-f]+ <[^>]+> a0b4 183b 	ctc1	a1,\$f20
[0-9a-f]+ <[^>]+> a0b5 183b 	ctc1	a1,\$f21
[0-9a-f]+ <[^>]+> a0b6 183b 	ctc1	a1,\$f22
[0-9a-f]+ <[^>]+> a0b7 183b 	ctc1	a1,\$f23
[0-9a-f]+ <[^>]+> a0b8 183b 	ctc1	a1,\$f24
[0-9a-f]+ <[^>]+> a0b9 183b 	ctc1	a1,\$f25
[0-9a-f]+ <[^>]+> a0ba 183b 	ctc1	a1,\$f26
[0-9a-f]+ <[^>]+> a0bb 183b 	ctc1	a1,\$f27
[0-9a-f]+ <[^>]+> a0bc 183b 	ctc1	a1,\$f28
[0-9a-f]+ <[^>]+> a0bd 183b 	ctc1	a1,\$f29
[0-9a-f]+ <[^>]+> a0be 183b 	ctc1	a1,\$f30
[0-9a-f]+ <[^>]+> a0bf 183b 	ctc1	a1,\$f31
[0-9a-f]+ <[^>]+> 20a0 dd3f 	ctc2	a1,\$0
[0-9a-f]+ <[^>]+> 20a1 dd3f 	ctc2	a1,\$1
[0-9a-f]+ <[^>]+> 20a2 dd3f 	ctc2	a1,\$2
[0-9a-f]+ <[^>]+> 20a3 dd3f 	ctc2	a1,\$3
[0-9a-f]+ <[^>]+> 20a4 dd3f 	ctc2	a1,\$4
[0-9a-f]+ <[^>]+> 20a5 dd3f 	ctc2	a1,\$5
[0-9a-f]+ <[^>]+> 20a6 dd3f 	ctc2	a1,\$6
[0-9a-f]+ <[^>]+> 20a7 dd3f 	ctc2	a1,\$7
[0-9a-f]+ <[^>]+> 20a8 dd3f 	ctc2	a1,\$8
[0-9a-f]+ <[^>]+> 20a9 dd3f 	ctc2	a1,\$9
[0-9a-f]+ <[^>]+> 20aa dd3f 	ctc2	a1,\$10
[0-9a-f]+ <[^>]+> 20ab dd3f 	ctc2	a1,\$11
[0-9a-f]+ <[^>]+> 20ac dd3f 	ctc2	a1,\$12
[0-9a-f]+ <[^>]+> 20ad dd3f 	ctc2	a1,\$13
[0-9a-f]+ <[^>]+> 20ae dd3f 	ctc2	a1,\$14
[0-9a-f]+ <[^>]+> 20af dd3f 	ctc2	a1,\$15
[0-9a-f]+ <[^>]+> 20b0 dd3f 	ctc2	a1,\$16
[0-9a-f]+ <[^>]+> 20b1 dd3f 	ctc2	a1,\$17
[0-9a-f]+ <[^>]+> 20b2 dd3f 	ctc2	a1,\$18
[0-9a-f]+ <[^>]+> 20b3 dd3f 	ctc2	a1,\$19
[0-9a-f]+ <[^>]+> 20b4 dd3f 	ctc2	a1,\$20
[0-9a-f]+ <[^>]+> 20b5 dd3f 	ctc2	a1,\$21
[0-9a-f]+ <[^>]+> 20b6 dd3f 	ctc2	a1,\$22
[0-9a-f]+ <[^>]+> 20b7 dd3f 	ctc2	a1,\$23
[0-9a-f]+ <[^>]+> 20b8 dd3f 	ctc2	a1,\$24
[0-9a-f]+ <[^>]+> 20b9 dd3f 	ctc2	a1,\$25
[0-9a-f]+ <[^>]+> 20ba dd3f 	ctc2	a1,\$26
[0-9a-f]+ <[^>]+> 20bb dd3f 	ctc2	a1,\$27
[0-9a-f]+ <[^>]+> 20bc dd3f 	ctc2	a1,\$28
[0-9a-f]+ <[^>]+> 20bd dd3f 	ctc2	a1,\$29
[0-9a-f]+ <[^>]+> 20be dd3f 	ctc2	a1,\$30
[0-9a-f]+ <[^>]+> 20bf dd3f 	ctc2	a1,\$31
[0-9a-f]+ <[^>]+> a001 537b 	cvt\.d\.l	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 537b 	cvt\.d\.l	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 537b 	cvt\.d\.l	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 137b 	cvt\.d\.s	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 137b 	cvt\.d\.s	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 137b 	cvt\.d\.s	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 337b 	cvt\.d\.w	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 337b 	cvt\.d\.w	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 337b 	cvt\.d\.w	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 013b 	cvt\.l\.s	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 013b 	cvt\.l\.s	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 013b 	cvt\.l\.s	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 413b 	cvt\.l\.d	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 413b 	cvt\.l\.d	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 413b 	cvt\.l\.d	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 5b7b 	cvt\.s\.l	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 5b7b 	cvt\.s\.l	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 5b7b 	cvt\.s\.l	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 1b7b 	cvt\.s\.d	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 1b7b 	cvt\.s\.d	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 1b7b 	cvt\.s\.d	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 3b7b 	cvt\.s\.w	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 3b7b 	cvt\.s\.w	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 3b7b 	cvt\.s\.w	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 213b 	cvt\.s\.pl	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 213b 	cvt\.s\.pl	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 213b 	cvt\.s\.pl	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 293b 	cvt\.s\.pu	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 293b 	cvt\.s\.pu	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 293b 	cvt\.s\.pu	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 093b 	cvt\.w\.s	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 093b 	cvt\.w\.s	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 093b 	cvt\.w\.s	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 493b 	cvt\.w\.d	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 493b 	cvt\.w\.d	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 493b 	cvt\.w\.d	\$f2,\$f2
[0-9a-f]+ <[^>]+> a041 01f0 	div\.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]+> a3fe e9f0 	div\.d	\$f29,\$f30,\$f31
[0-9a-f]+ <[^>]+> a3dd e9f0 	div\.d	\$f29,\$f29,\$f30
[0-9a-f]+ <[^>]+> a3dd e9f0 	div\.d	\$f29,\$f29,\$f30
[0-9a-f]+ <[^>]+> a041 00f0 	div\.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]+> a3fe e8f0 	div\.s	\$f29,\$f30,\$f31
[0-9a-f]+ <[^>]+> a3dd e8f0 	div\.s	\$f29,\$f29,\$f30
[0-9a-f]+ <[^>]+> a3dd e8f0 	div\.s	\$f29,\$f29,\$f30
[0-9a-f]+ <[^>]+> a001 433b 	floor\.l\.d	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 433b 	floor\.l\.d	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 433b 	floor\.l\.d	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 033b 	floor\.l\.s	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 033b 	floor\.l\.s	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 033b 	floor\.l\.s	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 4b3b 	floor\.w\.d	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 4b3b 	floor\.w\.d	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 4b3b 	floor\.w\.d	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 0b3b 	floor\.w\.s	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 0b3b 	floor\.w\.s	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 0b3b 	floor\.w\.s	\$f2,\$f2
[0-9a-f]+ <[^>]+> 8460 e000 	ldc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 e000 	ldc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 e004 	ldc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 e004 	ldc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 e000 	ldc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 e000 	ldc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> e020 7000 	lui	at,0x7
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 efff 	ldc1	\$f3,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 efff 	ldc1	\$f3,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e001 	ldc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e001 	ldc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 9fff 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e678 	ldc1	\$f3,1656\(at\)
[0-9a-f]+ <[^>]+> 8460 e000 	ldc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 e000 	ldc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 e004 	ldc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 e004 	ldc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 e000 	ldc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 e000 	ldc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> e020 7000 	lui	at,0x7
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 efff 	ldc1	\$f3,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 efff 	ldc1	\$f3,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e001 	ldc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e001 	ldc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 9fff 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e678 	ldc1	\$f3,1656\(at\)
[0-9a-f]+ <[^>]+> 8460 e000 	ldc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 e000 	ldc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 e004 	ldc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 e004 	ldc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 e000 	ldc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 e000 	ldc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> e020 7000 	lui	at,0x7
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 efff 	ldc1	\$f3,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 2000 0707 	ldc1x	\$f0,zero\(zero\)
[0-9a-f]+ <[^>]+> 2040 0707 	ldc1x	\$f0,zero\(v0\)
[0-9a-f]+ <[^>]+> 23e0 0707 	ldc1x	\$f0,zero\(ra\)
[0-9a-f]+ <[^>]+> 23e2 0707 	ldc1x	\$f0,v0\(ra\)
[0-9a-f]+ <[^>]+> 23ff 0707 	ldc1x	\$f0,ra\(ra\)
[0-9a-f]+ <[^>]+> 23ff 0f07 	ldc1x	\$f1,ra\(ra\)
[0-9a-f]+ <[^>]+> 23ff 1707 	ldc1x	\$f2,ra\(ra\)
[0-9a-f]+ <[^>]+> 23ff ff07 	ldc1x	\$f31,ra\(ra\)
[0-9a-f]+ <[^>]+> 8460 a000 	lwc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 a000 	lwc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 a004 	lwc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 a004 	lwc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 a000 	lwc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 a000 	lwc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> e020 7000 	lui	at,0x7
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 afff 	lwc1	\$f3,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 afff 	lwc1	\$f3,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a001 	lwc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a001 	lwc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 9fff 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a678 	lwc1	\$f3,1656\(at\)
[0-9a-f]+ <[^>]+> 8460 a000 	lwc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 a000 	lwc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 a004 	lwc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 a004 	lwc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 a000 	lwc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 a000 	lwc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> e020 7000 	lui	at,0x7
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 afff 	lwc1	\$f3,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 afff 	lwc1	\$f3,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a001 	lwc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a001 	lwc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 9fff 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a678 	lwc1	\$f3,1656\(at\)
[0-9a-f]+ <[^>]+> 8460 a000 	lwc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 a000 	lwc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 a004 	lwc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 a004 	lwc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 a000 	lwc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 a000 	lwc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> e020 7000 	lui	at,0x7
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 afff 	lwc1	\$f3,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 afff 	lwc1	\$f3,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a001 	lwc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a001 	lwc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 9fff 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a678 	lwc1	\$f3,1656\(at\)
[0-9a-f]+ <[^>]+> 2000 0507 	lwc1x	\$f0,zero\(zero\)
[0-9a-f]+ <[^>]+> 2040 0507 	lwc1x	\$f0,zero\(v0\)
[0-9a-f]+ <[^>]+> 23e0 0507 	lwc1x	\$f0,zero\(ra\)
[0-9a-f]+ <[^>]+> 23e2 0507 	lwc1x	\$f0,v0\(ra\)
[0-9a-f]+ <[^>]+> 23ff 0507 	lwc1x	\$f0,ra\(ra\)
[0-9a-f]+ <[^>]+> 23ff 0d07 	lwc1x	\$f1,ra\(ra\)
[0-9a-f]+ <[^>]+> 23ff 1507 	lwc1x	\$f2,ra\(ra\)
[0-9a-f]+ <[^>]+> 23ff fd07 	lwc1x	\$f31,ra\(ra\)
[0-9a-f]+ <[^>]+> a0a0 203b 	mfc1	a1,\$f0
[0-9a-f]+ <[^>]+> a0a1 203b 	mfc1	a1,\$f1
[0-9a-f]+ <[^>]+> a0a2 203b 	mfc1	a1,\$f2
[0-9a-f]+ <[^>]+> a0a3 203b 	mfc1	a1,\$f3
[0-9a-f]+ <[^>]+> a0a4 203b 	mfc1	a1,\$f4
[0-9a-f]+ <[^>]+> a0a5 203b 	mfc1	a1,\$f5
[0-9a-f]+ <[^>]+> a0a6 203b 	mfc1	a1,\$f6
[0-9a-f]+ <[^>]+> a0a7 203b 	mfc1	a1,\$f7
[0-9a-f]+ <[^>]+> a0a8 203b 	mfc1	a1,\$f8
[0-9a-f]+ <[^>]+> a0a9 203b 	mfc1	a1,\$f9
[0-9a-f]+ <[^>]+> a0aa 203b 	mfc1	a1,\$f10
[0-9a-f]+ <[^>]+> a0ab 203b 	mfc1	a1,\$f11
[0-9a-f]+ <[^>]+> a0ac 203b 	mfc1	a1,\$f12
[0-9a-f]+ <[^>]+> a0ad 203b 	mfc1	a1,\$f13
[0-9a-f]+ <[^>]+> a0ae 203b 	mfc1	a1,\$f14
[0-9a-f]+ <[^>]+> a0af 203b 	mfc1	a1,\$f15
[0-9a-f]+ <[^>]+> a0b0 203b 	mfc1	a1,\$f16
[0-9a-f]+ <[^>]+> a0b1 203b 	mfc1	a1,\$f17
[0-9a-f]+ <[^>]+> a0b2 203b 	mfc1	a1,\$f18
[0-9a-f]+ <[^>]+> a0b3 203b 	mfc1	a1,\$f19
[0-9a-f]+ <[^>]+> a0b4 203b 	mfc1	a1,\$f20
[0-9a-f]+ <[^>]+> a0b5 203b 	mfc1	a1,\$f21
[0-9a-f]+ <[^>]+> a0b6 203b 	mfc1	a1,\$f22
[0-9a-f]+ <[^>]+> a0b7 203b 	mfc1	a1,\$f23
[0-9a-f]+ <[^>]+> a0b8 203b 	mfc1	a1,\$f24
[0-9a-f]+ <[^>]+> a0b9 203b 	mfc1	a1,\$f25
[0-9a-f]+ <[^>]+> a0ba 203b 	mfc1	a1,\$f26
[0-9a-f]+ <[^>]+> a0bb 203b 	mfc1	a1,\$f27
[0-9a-f]+ <[^>]+> a0bc 203b 	mfc1	a1,\$f28
[0-9a-f]+ <[^>]+> a0bd 203b 	mfc1	a1,\$f29
[0-9a-f]+ <[^>]+> a0be 203b 	mfc1	a1,\$f30
[0-9a-f]+ <[^>]+> a0bf 203b 	mfc1	a1,\$f31
[0-9a-f]+ <[^>]+> a0a0 203b 	mfc1	a1,\$f0
[0-9a-f]+ <[^>]+> a0a1 203b 	mfc1	a1,\$f1
[0-9a-f]+ <[^>]+> a0a2 203b 	mfc1	a1,\$f2
[0-9a-f]+ <[^>]+> a0a3 203b 	mfc1	a1,\$f3
[0-9a-f]+ <[^>]+> a0a4 203b 	mfc1	a1,\$f4
[0-9a-f]+ <[^>]+> a0a5 203b 	mfc1	a1,\$f5
[0-9a-f]+ <[^>]+> a0a6 203b 	mfc1	a1,\$f6
[0-9a-f]+ <[^>]+> a0a7 203b 	mfc1	a1,\$f7
[0-9a-f]+ <[^>]+> a0a8 203b 	mfc1	a1,\$f8
[0-9a-f]+ <[^>]+> a0a9 203b 	mfc1	a1,\$f9
[0-9a-f]+ <[^>]+> a0aa 203b 	mfc1	a1,\$f10
[0-9a-f]+ <[^>]+> a0ab 203b 	mfc1	a1,\$f11
[0-9a-f]+ <[^>]+> a0ac 203b 	mfc1	a1,\$f12
[0-9a-f]+ <[^>]+> a0ad 203b 	mfc1	a1,\$f13
[0-9a-f]+ <[^>]+> a0ae 203b 	mfc1	a1,\$f14
[0-9a-f]+ <[^>]+> a0af 203b 	mfc1	a1,\$f15
[0-9a-f]+ <[^>]+> a0b0 203b 	mfc1	a1,\$f16
[0-9a-f]+ <[^>]+> a0b1 203b 	mfc1	a1,\$f17
[0-9a-f]+ <[^>]+> a0b2 203b 	mfc1	a1,\$f18
[0-9a-f]+ <[^>]+> a0b3 203b 	mfc1	a1,\$f19
[0-9a-f]+ <[^>]+> a0b4 203b 	mfc1	a1,\$f20
[0-9a-f]+ <[^>]+> a0b5 203b 	mfc1	a1,\$f21
[0-9a-f]+ <[^>]+> a0b6 203b 	mfc1	a1,\$f22
[0-9a-f]+ <[^>]+> a0b7 203b 	mfc1	a1,\$f23
[0-9a-f]+ <[^>]+> a0b8 203b 	mfc1	a1,\$f24
[0-9a-f]+ <[^>]+> a0b9 203b 	mfc1	a1,\$f25
[0-9a-f]+ <[^>]+> a0ba 203b 	mfc1	a1,\$f26
[0-9a-f]+ <[^>]+> a0bb 203b 	mfc1	a1,\$f27
[0-9a-f]+ <[^>]+> a0bc 203b 	mfc1	a1,\$f28
[0-9a-f]+ <[^>]+> a0bd 203b 	mfc1	a1,\$f29
[0-9a-f]+ <[^>]+> a0be 203b 	mfc1	a1,\$f30
[0-9a-f]+ <[^>]+> a0bf 203b 	mfc1	a1,\$f31
[0-9a-f]+ <[^>]+> a0a0 303b 	mfhc1	a1,\$f0
[0-9a-f]+ <[^>]+> a0a1 303b 	mfhc1	a1,\$f1
[0-9a-f]+ <[^>]+> a0a2 303b 	mfhc1	a1,\$f2
[0-9a-f]+ <[^>]+> a0a3 303b 	mfhc1	a1,\$f3
[0-9a-f]+ <[^>]+> a0a4 303b 	mfhc1	a1,\$f4
[0-9a-f]+ <[^>]+> a0a5 303b 	mfhc1	a1,\$f5
[0-9a-f]+ <[^>]+> a0a6 303b 	mfhc1	a1,\$f6
[0-9a-f]+ <[^>]+> a0a7 303b 	mfhc1	a1,\$f7
[0-9a-f]+ <[^>]+> a0a8 303b 	mfhc1	a1,\$f8
[0-9a-f]+ <[^>]+> a0a9 303b 	mfhc1	a1,\$f9
[0-9a-f]+ <[^>]+> a0aa 303b 	mfhc1	a1,\$f10
[0-9a-f]+ <[^>]+> a0ab 303b 	mfhc1	a1,\$f11
[0-9a-f]+ <[^>]+> a0ac 303b 	mfhc1	a1,\$f12
[0-9a-f]+ <[^>]+> a0ad 303b 	mfhc1	a1,\$f13
[0-9a-f]+ <[^>]+> a0ae 303b 	mfhc1	a1,\$f14
[0-9a-f]+ <[^>]+> a0af 303b 	mfhc1	a1,\$f15
[0-9a-f]+ <[^>]+> a0b0 303b 	mfhc1	a1,\$f16
[0-9a-f]+ <[^>]+> a0b1 303b 	mfhc1	a1,\$f17
[0-9a-f]+ <[^>]+> a0b2 303b 	mfhc1	a1,\$f18
[0-9a-f]+ <[^>]+> a0b3 303b 	mfhc1	a1,\$f19
[0-9a-f]+ <[^>]+> a0b4 303b 	mfhc1	a1,\$f20
[0-9a-f]+ <[^>]+> a0b5 303b 	mfhc1	a1,\$f21
[0-9a-f]+ <[^>]+> a0b6 303b 	mfhc1	a1,\$f22
[0-9a-f]+ <[^>]+> a0b7 303b 	mfhc1	a1,\$f23
[0-9a-f]+ <[^>]+> a0b8 303b 	mfhc1	a1,\$f24
[0-9a-f]+ <[^>]+> a0b9 303b 	mfhc1	a1,\$f25
[0-9a-f]+ <[^>]+> a0ba 303b 	mfhc1	a1,\$f26
[0-9a-f]+ <[^>]+> a0bb 303b 	mfhc1	a1,\$f27
[0-9a-f]+ <[^>]+> a0bc 303b 	mfhc1	a1,\$f28
[0-9a-f]+ <[^>]+> a0bd 303b 	mfhc1	a1,\$f29
[0-9a-f]+ <[^>]+> a0be 303b 	mfhc1	a1,\$f30
[0-9a-f]+ <[^>]+> a0bf 303b 	mfhc1	a1,\$f31
[0-9a-f]+ <[^>]+> a0a0 303b 	mfhc1	a1,\$f0
[0-9a-f]+ <[^>]+> a0a1 303b 	mfhc1	a1,\$f1
[0-9a-f]+ <[^>]+> a0a2 303b 	mfhc1	a1,\$f2
[0-9a-f]+ <[^>]+> a0a3 303b 	mfhc1	a1,\$f3
[0-9a-f]+ <[^>]+> a0a4 303b 	mfhc1	a1,\$f4
[0-9a-f]+ <[^>]+> a0a5 303b 	mfhc1	a1,\$f5
[0-9a-f]+ <[^>]+> a0a6 303b 	mfhc1	a1,\$f6
[0-9a-f]+ <[^>]+> a0a7 303b 	mfhc1	a1,\$f7
[0-9a-f]+ <[^>]+> a0a8 303b 	mfhc1	a1,\$f8
[0-9a-f]+ <[^>]+> a0a9 303b 	mfhc1	a1,\$f9
[0-9a-f]+ <[^>]+> a0aa 303b 	mfhc1	a1,\$f10
[0-9a-f]+ <[^>]+> a0ab 303b 	mfhc1	a1,\$f11
[0-9a-f]+ <[^>]+> a0ac 303b 	mfhc1	a1,\$f12
[0-9a-f]+ <[^>]+> a0ad 303b 	mfhc1	a1,\$f13
[0-9a-f]+ <[^>]+> a0ae 303b 	mfhc1	a1,\$f14
[0-9a-f]+ <[^>]+> a0af 303b 	mfhc1	a1,\$f15
[0-9a-f]+ <[^>]+> a0b0 303b 	mfhc1	a1,\$f16
[0-9a-f]+ <[^>]+> a0b1 303b 	mfhc1	a1,\$f17
[0-9a-f]+ <[^>]+> a0b2 303b 	mfhc1	a1,\$f18
[0-9a-f]+ <[^>]+> a0b3 303b 	mfhc1	a1,\$f19
[0-9a-f]+ <[^>]+> a0b4 303b 	mfhc1	a1,\$f20
[0-9a-f]+ <[^>]+> a0b5 303b 	mfhc1	a1,\$f21
[0-9a-f]+ <[^>]+> a0b6 303b 	mfhc1	a1,\$f22
[0-9a-f]+ <[^>]+> a0b7 303b 	mfhc1	a1,\$f23
[0-9a-f]+ <[^>]+> a0b8 303b 	mfhc1	a1,\$f24
[0-9a-f]+ <[^>]+> a0b9 303b 	mfhc1	a1,\$f25
[0-9a-f]+ <[^>]+> a0ba 303b 	mfhc1	a1,\$f26
[0-9a-f]+ <[^>]+> a0bb 303b 	mfhc1	a1,\$f27
[0-9a-f]+ <[^>]+> a0bc 303b 	mfhc1	a1,\$f28
[0-9a-f]+ <[^>]+> a0bd 303b 	mfhc1	a1,\$f29
[0-9a-f]+ <[^>]+> a0be 303b 	mfhc1	a1,\$f30
[0-9a-f]+ <[^>]+> a0bf 303b 	mfhc1	a1,\$f31
[0-9a-f]+ <[^>]+> a001 207b 	mov\.d	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 207b 	mov\.d	\$f30,\$f31
[0-9a-f]+ <[^>]+> a001 007b 	mov\.s	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 007b 	mov\.s	\$f30,\$f31
[0-9a-f]+ <[^>]+> a0a0 283b 	mtc1	a1,\$f0
[0-9a-f]+ <[^>]+> a0a1 283b 	mtc1	a1,\$f1
[0-9a-f]+ <[^>]+> a0a2 283b 	mtc1	a1,\$f2
[0-9a-f]+ <[^>]+> a0a3 283b 	mtc1	a1,\$f3
[0-9a-f]+ <[^>]+> a0a4 283b 	mtc1	a1,\$f4
[0-9a-f]+ <[^>]+> a0a5 283b 	mtc1	a1,\$f5
[0-9a-f]+ <[^>]+> a0a6 283b 	mtc1	a1,\$f6
[0-9a-f]+ <[^>]+> a0a7 283b 	mtc1	a1,\$f7
[0-9a-f]+ <[^>]+> a0a8 283b 	mtc1	a1,\$f8
[0-9a-f]+ <[^>]+> a0a9 283b 	mtc1	a1,\$f9
[0-9a-f]+ <[^>]+> a0aa 283b 	mtc1	a1,\$f10
[0-9a-f]+ <[^>]+> a0ab 283b 	mtc1	a1,\$f11
[0-9a-f]+ <[^>]+> a0ac 283b 	mtc1	a1,\$f12
[0-9a-f]+ <[^>]+> a0ad 283b 	mtc1	a1,\$f13
[0-9a-f]+ <[^>]+> a0ae 283b 	mtc1	a1,\$f14
[0-9a-f]+ <[^>]+> a0af 283b 	mtc1	a1,\$f15
[0-9a-f]+ <[^>]+> a0b0 283b 	mtc1	a1,\$f16
[0-9a-f]+ <[^>]+> a0b1 283b 	mtc1	a1,\$f17
[0-9a-f]+ <[^>]+> a0b2 283b 	mtc1	a1,\$f18
[0-9a-f]+ <[^>]+> a0b3 283b 	mtc1	a1,\$f19
[0-9a-f]+ <[^>]+> a0b4 283b 	mtc1	a1,\$f20
[0-9a-f]+ <[^>]+> a0b5 283b 	mtc1	a1,\$f21
[0-9a-f]+ <[^>]+> a0b6 283b 	mtc1	a1,\$f22
[0-9a-f]+ <[^>]+> a0b7 283b 	mtc1	a1,\$f23
[0-9a-f]+ <[^>]+> a0b8 283b 	mtc1	a1,\$f24
[0-9a-f]+ <[^>]+> a0b9 283b 	mtc1	a1,\$f25
[0-9a-f]+ <[^>]+> a0ba 283b 	mtc1	a1,\$f26
[0-9a-f]+ <[^>]+> a0bb 283b 	mtc1	a1,\$f27
[0-9a-f]+ <[^>]+> a0bc 283b 	mtc1	a1,\$f28
[0-9a-f]+ <[^>]+> a0bd 283b 	mtc1	a1,\$f29
[0-9a-f]+ <[^>]+> a0be 283b 	mtc1	a1,\$f30
[0-9a-f]+ <[^>]+> a0bf 283b 	mtc1	a1,\$f31
[0-9a-f]+ <[^>]+> a0a0 283b 	mtc1	a1,\$f0
[0-9a-f]+ <[^>]+> a0a1 283b 	mtc1	a1,\$f1
[0-9a-f]+ <[^>]+> a0a2 283b 	mtc1	a1,\$f2
[0-9a-f]+ <[^>]+> a0a3 283b 	mtc1	a1,\$f3
[0-9a-f]+ <[^>]+> a0a4 283b 	mtc1	a1,\$f4
[0-9a-f]+ <[^>]+> a0a5 283b 	mtc1	a1,\$f5
[0-9a-f]+ <[^>]+> a0a6 283b 	mtc1	a1,\$f6
[0-9a-f]+ <[^>]+> a0a7 283b 	mtc1	a1,\$f7
[0-9a-f]+ <[^>]+> a0a8 283b 	mtc1	a1,\$f8
[0-9a-f]+ <[^>]+> a0a9 283b 	mtc1	a1,\$f9
[0-9a-f]+ <[^>]+> a0aa 283b 	mtc1	a1,\$f10
[0-9a-f]+ <[^>]+> a0ab 283b 	mtc1	a1,\$f11
[0-9a-f]+ <[^>]+> a0ac 283b 	mtc1	a1,\$f12
[0-9a-f]+ <[^>]+> a0ad 283b 	mtc1	a1,\$f13
[0-9a-f]+ <[^>]+> a0ae 283b 	mtc1	a1,\$f14
[0-9a-f]+ <[^>]+> a0af 283b 	mtc1	a1,\$f15
[0-9a-f]+ <[^>]+> a0b0 283b 	mtc1	a1,\$f16
[0-9a-f]+ <[^>]+> a0b1 283b 	mtc1	a1,\$f17
[0-9a-f]+ <[^>]+> a0b2 283b 	mtc1	a1,\$f18
[0-9a-f]+ <[^>]+> a0b3 283b 	mtc1	a1,\$f19
[0-9a-f]+ <[^>]+> a0b4 283b 	mtc1	a1,\$f20
[0-9a-f]+ <[^>]+> a0b5 283b 	mtc1	a1,\$f21
[0-9a-f]+ <[^>]+> a0b6 283b 	mtc1	a1,\$f22
[0-9a-f]+ <[^>]+> a0b7 283b 	mtc1	a1,\$f23
[0-9a-f]+ <[^>]+> a0b8 283b 	mtc1	a1,\$f24
[0-9a-f]+ <[^>]+> a0b9 283b 	mtc1	a1,\$f25
[0-9a-f]+ <[^>]+> a0ba 283b 	mtc1	a1,\$f26
[0-9a-f]+ <[^>]+> a0bb 283b 	mtc1	a1,\$f27
[0-9a-f]+ <[^>]+> a0bc 283b 	mtc1	a1,\$f28
[0-9a-f]+ <[^>]+> a0bd 283b 	mtc1	a1,\$f29
[0-9a-f]+ <[^>]+> a0be 283b 	mtc1	a1,\$f30
[0-9a-f]+ <[^>]+> a0bf 283b 	mtc1	a1,\$f31
[0-9a-f]+ <[^>]+> a0a0 383b 	mthc1	a1,\$f0
[0-9a-f]+ <[^>]+> a0a1 383b 	mthc1	a1,\$f1
[0-9a-f]+ <[^>]+> a0a2 383b 	mthc1	a1,\$f2
[0-9a-f]+ <[^>]+> a0a3 383b 	mthc1	a1,\$f3
[0-9a-f]+ <[^>]+> a0a4 383b 	mthc1	a1,\$f4
[0-9a-f]+ <[^>]+> a0a5 383b 	mthc1	a1,\$f5
[0-9a-f]+ <[^>]+> a0a6 383b 	mthc1	a1,\$f6
[0-9a-f]+ <[^>]+> a0a7 383b 	mthc1	a1,\$f7
[0-9a-f]+ <[^>]+> a0a8 383b 	mthc1	a1,\$f8
[0-9a-f]+ <[^>]+> a0a9 383b 	mthc1	a1,\$f9
[0-9a-f]+ <[^>]+> a0aa 383b 	mthc1	a1,\$f10
[0-9a-f]+ <[^>]+> a0ab 383b 	mthc1	a1,\$f11
[0-9a-f]+ <[^>]+> a0ac 383b 	mthc1	a1,\$f12
[0-9a-f]+ <[^>]+> a0ad 383b 	mthc1	a1,\$f13
[0-9a-f]+ <[^>]+> a0ae 383b 	mthc1	a1,\$f14
[0-9a-f]+ <[^>]+> a0af 383b 	mthc1	a1,\$f15
[0-9a-f]+ <[^>]+> a0b0 383b 	mthc1	a1,\$f16
[0-9a-f]+ <[^>]+> a0b1 383b 	mthc1	a1,\$f17
[0-9a-f]+ <[^>]+> a0b2 383b 	mthc1	a1,\$f18
[0-9a-f]+ <[^>]+> a0b3 383b 	mthc1	a1,\$f19
[0-9a-f]+ <[^>]+> a0b4 383b 	mthc1	a1,\$f20
[0-9a-f]+ <[^>]+> a0b5 383b 	mthc1	a1,\$f21
[0-9a-f]+ <[^>]+> a0b6 383b 	mthc1	a1,\$f22
[0-9a-f]+ <[^>]+> a0b7 383b 	mthc1	a1,\$f23
[0-9a-f]+ <[^>]+> a0b8 383b 	mthc1	a1,\$f24
[0-9a-f]+ <[^>]+> a0b9 383b 	mthc1	a1,\$f25
[0-9a-f]+ <[^>]+> a0ba 383b 	mthc1	a1,\$f26
[0-9a-f]+ <[^>]+> a0bb 383b 	mthc1	a1,\$f27
[0-9a-f]+ <[^>]+> a0bc 383b 	mthc1	a1,\$f28
[0-9a-f]+ <[^>]+> a0bd 383b 	mthc1	a1,\$f29
[0-9a-f]+ <[^>]+> a0be 383b 	mthc1	a1,\$f30
[0-9a-f]+ <[^>]+> a0bf 383b 	mthc1	a1,\$f31
[0-9a-f]+ <[^>]+> a0a0 383b 	mthc1	a1,\$f0
[0-9a-f]+ <[^>]+> a0a1 383b 	mthc1	a1,\$f1
[0-9a-f]+ <[^>]+> a0a2 383b 	mthc1	a1,\$f2
[0-9a-f]+ <[^>]+> a0a3 383b 	mthc1	a1,\$f3
[0-9a-f]+ <[^>]+> a0a4 383b 	mthc1	a1,\$f4
[0-9a-f]+ <[^>]+> a0a5 383b 	mthc1	a1,\$f5
[0-9a-f]+ <[^>]+> a0a6 383b 	mthc1	a1,\$f6
[0-9a-f]+ <[^>]+> a0a7 383b 	mthc1	a1,\$f7
[0-9a-f]+ <[^>]+> a0a8 383b 	mthc1	a1,\$f8
[0-9a-f]+ <[^>]+> a0a9 383b 	mthc1	a1,\$f9
[0-9a-f]+ <[^>]+> a0aa 383b 	mthc1	a1,\$f10
[0-9a-f]+ <[^>]+> a0ab 383b 	mthc1	a1,\$f11
[0-9a-f]+ <[^>]+> a0ac 383b 	mthc1	a1,\$f12
[0-9a-f]+ <[^>]+> a0ad 383b 	mthc1	a1,\$f13
[0-9a-f]+ <[^>]+> a0ae 383b 	mthc1	a1,\$f14
[0-9a-f]+ <[^>]+> a0af 383b 	mthc1	a1,\$f15
[0-9a-f]+ <[^>]+> a0b0 383b 	mthc1	a1,\$f16
[0-9a-f]+ <[^>]+> a0b1 383b 	mthc1	a1,\$f17
[0-9a-f]+ <[^>]+> a0b2 383b 	mthc1	a1,\$f18
[0-9a-f]+ <[^>]+> a0b3 383b 	mthc1	a1,\$f19
[0-9a-f]+ <[^>]+> a0b4 383b 	mthc1	a1,\$f20
[0-9a-f]+ <[^>]+> a0b5 383b 	mthc1	a1,\$f21
[0-9a-f]+ <[^>]+> a0b6 383b 	mthc1	a1,\$f22
[0-9a-f]+ <[^>]+> a0b7 383b 	mthc1	a1,\$f23
[0-9a-f]+ <[^>]+> a0b8 383b 	mthc1	a1,\$f24
[0-9a-f]+ <[^>]+> a0b9 383b 	mthc1	a1,\$f25
[0-9a-f]+ <[^>]+> a0ba 383b 	mthc1	a1,\$f26
[0-9a-f]+ <[^>]+> a0bb 383b 	mthc1	a1,\$f27
[0-9a-f]+ <[^>]+> a0bc 383b 	mthc1	a1,\$f28
[0-9a-f]+ <[^>]+> a0bd 383b 	mthc1	a1,\$f29
[0-9a-f]+ <[^>]+> a0be 383b 	mthc1	a1,\$f30
[0-9a-f]+ <[^>]+> a0bf 383b 	mthc1	a1,\$f31
[0-9a-f]+ <[^>]+> a041 00b0 	mul\.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]+> a3fe e8b0 	mul\.s	\$f29,\$f30,\$f31
[0-9a-f]+ <[^>]+> a3dd e8b0 	mul\.s	\$f29,\$f29,\$f30
[0-9a-f]+ <[^>]+> a3dd e8b0 	mul\.s	\$f29,\$f29,\$f30
[0-9a-f]+ <[^>]+> a041 01b0 	mul\.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]+> a3fe e9b0 	mul\.d	\$f29,\$f30,\$f31
[0-9a-f]+ <[^>]+> a3dd e9b0 	mul\.d	\$f29,\$f29,\$f30
[0-9a-f]+ <[^>]+> a3dd e9b0 	mul\.d	\$f29,\$f29,\$f30
[0-9a-f]+ <[^>]+> a001 0b7b 	neg\.s	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 0b7b 	neg\.s	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 0b7b 	neg\.s	\$f2,\$f2
[0-9a-f]+ <[^>]+> a042 0b7b 	neg\.s	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 2b7b 	neg\.d	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 2b7b 	neg\.d	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 2b7b 	neg\.d	\$f2,\$f2
[0-9a-f]+ <[^>]+> a042 2b7b 	neg\.d	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 123b 	recip\.s	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 123b 	recip\.s	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 123b 	recip\.s	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 523b 	recip\.d	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 523b 	recip\.d	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 523b 	recip\.d	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 333b 	round\.l\.s	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 333b 	round\.l\.s	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 333b 	round\.l\.s	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 733b 	round\.l\.d	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 733b 	round\.l\.d	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 733b 	round\.l\.d	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 3b3b 	round\.w\.s	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 3b3b 	round\.w\.s	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 3b3b 	round\.w\.s	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 7b3b 	round\.w\.d	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 7b3b 	round\.w\.d	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 7b3b 	round\.w\.d	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 023b 	rsqrt\.s	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 023b 	rsqrt\.s	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 023b 	rsqrt\.s	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 423b 	rsqrt\.d	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 423b 	rsqrt\.d	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 423b 	rsqrt\.d	\$f2,\$f2
[0-9a-f]+ <[^>]+> 8460 f000 	sdc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 f000 	sdc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 f004 	sdc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 f004 	sdc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 f000 	sdc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 f000 	sdc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> e020 7000 	lui	at,0x7
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 ffff 	sdc1	\$f3,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 ffff 	sdc1	\$f3,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f001 	sdc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f001 	sdc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 9fff 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f678 	sdc1	\$f3,1656\(at\)
[0-9a-f]+ <[^>]+> 8460 f000 	sdc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 f000 	sdc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 f004 	sdc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 f004 	sdc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 f000 	sdc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 f000 	sdc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> e020 7000 	lui	at,0x7
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 ffff 	sdc1	\$f3,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 ffff 	sdc1	\$f3,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f001 	sdc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f001 	sdc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 9fff 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f678 	sdc1	\$f3,1656\(at\)
[0-9a-f]+ <[^>]+> 8460 f000 	sdc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 f000 	sdc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 f004 	sdc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 f004 	sdc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 f000 	sdc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 f000 	sdc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> e020 7000 	lui	at,0x7
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 ffff 	sdc1	\$f3,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 2000 0787 	sdc1x	\$f0,zero\(zero\)
[0-9a-f]+ <[^>]+> 2040 0787 	sdc1x	\$f0,zero\(v0\)
[0-9a-f]+ <[^>]+> 23e0 0787 	sdc1x	\$f0,zero\(ra\)
[0-9a-f]+ <[^>]+> 23e2 0787 	sdc1x	\$f0,v0\(ra\)
[0-9a-f]+ <[^>]+> 23ff 0787 	sdc1x	\$f0,ra\(ra\)
[0-9a-f]+ <[^>]+> 23ff 0f87 	sdc1x	\$f1,ra\(ra\)
[0-9a-f]+ <[^>]+> 23ff 1787 	sdc1x	\$f2,ra\(ra\)
[0-9a-f]+ <[^>]+> 23ff ff87 	sdc1x	\$f31,ra\(ra\)
[0-9a-f]+ <[^>]+> a001 0a3b 	sqrt\.s	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 0a3b 	sqrt\.s	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 0a3b 	sqrt\.s	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 4a3b 	sqrt\.d	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 4a3b 	sqrt\.d	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 4a3b 	sqrt\.d	\$f2,\$f2
[0-9a-f]+ <[^>]+> a041 0070 	sub\.s	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]+> a3fe e870 	sub\.s	\$f29,\$f30,\$f31
[0-9a-f]+ <[^>]+> a3dd e870 	sub\.s	\$f29,\$f29,\$f30
[0-9a-f]+ <[^>]+> a3dd e870 	sub\.s	\$f29,\$f29,\$f30
[0-9a-f]+ <[^>]+> a041 0170 	sub\.d	\$f0,\$f1,\$f2
[0-9a-f]+ <[^>]+> a3fe e970 	sub\.d	\$f29,\$f30,\$f31
[0-9a-f]+ <[^>]+> a3dd e970 	sub\.d	\$f29,\$f29,\$f30
[0-9a-f]+ <[^>]+> a3dd e970 	sub\.d	\$f29,\$f29,\$f30
[0-9a-f]+ <[^>]+> 8460 b000 	swc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 b000 	swc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 b004 	swc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 b004 	swc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 b000 	swc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 b000 	swc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> e020 7000 	lui	at,0x7
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 bfff 	swc1	\$f3,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 bfff 	swc1	\$f3,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b001 	swc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b001 	swc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 9fff 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b678 	swc1	\$f3,1656\(at\)
[0-9a-f]+ <[^>]+> 8460 b000 	swc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 b000 	swc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 b004 	swc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 b004 	swc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 b000 	swc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 b000 	swc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> e020 7000 	lui	at,0x7
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 bfff 	swc1	\$f3,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 bfff 	swc1	\$f3,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b001 	swc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b001 	swc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 9fff 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b678 	swc1	\$f3,1656\(at\)
[0-9a-f]+ <[^>]+> 8460 b000 	swc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 b000 	swc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 b004 	swc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 b004 	swc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 b000 	swc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 b000 	swc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> e020 7000 	lui	at,0x7
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 bfff 	swc1	\$f3,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e020 f000 	lui	at,0xf
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 bfff 	swc1	\$f3,4095\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,0xffff0
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b001 	swc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b001 	swc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,0xf0000
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 9fff 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,0x12345
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b678 	swc1	\$f3,1656\(at\)
[0-9a-f]+ <[^>]+> 2000 0587 	swc1x	\$f0,zero\(zero\)
[0-9a-f]+ <[^>]+> 2040 0587 	swc1x	\$f0,zero\(v0\)
[0-9a-f]+ <[^>]+> 23e0 0587 	swc1x	\$f0,zero\(ra\)
[0-9a-f]+ <[^>]+> 23e2 0587 	swc1x	\$f0,v0\(ra\)
[0-9a-f]+ <[^>]+> 23ff 0587 	swc1x	\$f0,ra\(ra\)
[0-9a-f]+ <[^>]+> 23ff 0d87 	swc1x	\$f1,ra\(ra\)
[0-9a-f]+ <[^>]+> 23ff 1587 	swc1x	\$f2,ra\(ra\)
[0-9a-f]+ <[^>]+> 23ff fd87 	swc1x	\$f31,ra\(ra\)
[0-9a-f]+ <[^>]+> a001 233b 	trunc\.l\.s	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 233b 	trunc\.l\.s	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 233b 	trunc\.l\.s	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 633b 	trunc\.l\.d	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 633b 	trunc\.l\.d	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 633b 	trunc\.l\.d	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 2b3b 	trunc\.w\.s	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 2b3b 	trunc\.w\.s	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 2b3b 	trunc\.w\.s	\$f2,\$f2
[0-9a-f]+ <[^>]+> a001 6b3b 	trunc\.w\.d	\$f0,\$f1
[0-9a-f]+ <[^>]+> a3df 6b3b 	trunc\.w\.d	\$f30,\$f31
[0-9a-f]+ <[^>]+> a042 6b3b 	trunc\.w\.d	\$f2,\$f2
[0-9a-f]+ <[^>]+> 3800      	balc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_MICROMIPS_PC10_S1	test_delay_slot-0x2
[0-9a-f]+ <[^>]+> d850      	jalrc	v0
[0-9a-f]+ <[^>]+> 4be2 0000 	jalrc	v0
[0-9a-f]+ <[^>]+> d840      	jrc	v0
[0-9a-f]+ <[^>]+> 4802 0000 	jrc	v0
[0-9a-f]+ <[^>]+> 4be2 1000 	jalrc\.hb	v0
[0-9a-f]+ <[^>]+> 4802 1000 	jrc\.hb	v0
[0-9a-f]+ <[^>]+> b540      	lw	s2,-256\(gp\)
[0-9a-f]+ <[^>]+> b5c0      	lw	s3,-256\(gp\)
[0-9a-f]+ <[^>]+> b640      	lw	a0,-256\(gp\)
[0-9a-f]+ <[^>]+> b6c0      	lw	a1,-256\(gp\)
[0-9a-f]+ <[^>]+> b740      	lw	a2,-256\(gp\)
[0-9a-f]+ <[^>]+> b7c0      	lw	a3,-256\(gp\)
[0-9a-f]+ <[^>]+> b440      	lw	s0,-256\(gp\)
[0-9a-f]+ <[^>]+> b4c0      	lw	s1,-256\(gp\)
[0-9a-f]+ <[^>]+> b4c1      	lw	s1,-252\(gp\)
[0-9a-f]+ <[^>]+> b4ff      	lw	s1,-4\(gp\)
[0-9a-f]+ <[^>]+> 4220 0002 	lw	s1,0\(gp\)
[0-9a-f]+ <[^>]+> 4220 0006 	lw	s1,4\(gp\)
[0-9a-f]+ <[^>]+> 4220 00fa 	lw	s1,248\(gp\)
[0-9a-f]+ <[^>]+> 4220 00fe 	lw	s1,252\(gp\)
[0-9a-f]+ <[^>]+> 4220 0102 	lw	s1,256\(gp\)
[0-9a-f]+ <[^>]+> 023c 9efc 	addiu	s1,gp,-260
[0-9a-f]+ <[^>]+> 8631 8000 	lw	s1,0\(s1\)
[0-9a-f]+ <[^>]+> 863c 8001 	lw	s1,1\(gp\)
[0-9a-f]+ <[^>]+> 863c 8002 	lw	s1,2\(gp\)
[0-9a-f]+ <[^>]+> 863c 8003 	lw	s1,3\(gp\)
[0-9a-f]+ <[^>]+> a63c c0ff 	lw	s1,-1\(gp\)
[0-9a-f]+ <[^>]+> a63c c0fe 	lw	s1,-2\(gp\)
[0-9a-f]+ <[^>]+> a63c c0fd 	lw	s1,-3\(gp\)
[0-9a-f]+ <[^>]+> 863b 8000 	lw	s1,0\(k1\)
[0-9a-f]+ <[^>]+> bd00      	movep	a1,a2,zero,zero
[0-9a-f]+ <[^>]+> bc08      	movep	a2,a3,zero,zero
[0-9a-f]+ <[^>]+> bc00      	movep	a0,a1,zero,zero
[0-9a-f]+ <[^>]+> bd00      	movep	a1,a2,zero,zero
[0-9a-f]+ <[^>]+> bc08      	movep	a2,a3,zero,zero
[0-9a-f]+ <[^>]+> bc19      	movep	a2,a3,s1,zero
[0-9a-f]+ <[^>]+> bc0a      	movep	a2,a3,v0,zero
[0-9a-f]+ <[^>]+> bc0b      	movep	a2,a3,v1,zero
[0-9a-f]+ <[^>]+> bc18      	movep	a2,a3,s0,zero
[0-9a-f]+ <[^>]+> bc1a      	movep	a2,a3,s2,zero
[0-9a-f]+ <[^>]+> bc1b      	movep	a2,a3,s3,zero
[0-9a-f]+ <[^>]+> bc1c      	movep	a2,a3,s4,zero
[0-9a-f]+ <[^>]+> be3c      	movep	a2,a3,s4,s1
[0-9a-f]+ <[^>]+> bc5c      	movep	a2,a3,s4,v0
[0-9a-f]+ <[^>]+> bc7c      	movep	a2,a3,s4,v1
[0-9a-f]+ <[^>]+> be1c      	movep	a2,a3,s4,s0
[0-9a-f]+ <[^>]+> be5c      	movep	a2,a3,s4,s2
[0-9a-f]+ <[^>]+> be7c      	movep	a2,a3,s4,s3
[0-9a-f]+ <[^>]+> be9c      	movep	a2,a3,s4,s4
[0-9a-f]+ <[^>]+> 446c 0000 	lwc1	\$f3,0\(gp\)
[0-9a-f]+ <[^>]+> 446c 0000 	lwc1	\$f3,0\(gp\)
[0-9a-f]+ <[^>]+> 446c 0004 	lwc1	\$f3,4\(gp\)
[0-9a-f]+ <[^>]+> 446c 4000 	lwc1	\$f3,16384\(gp\)
[0-9a-f]+ <[^>]+> 446f fffc 	lwc1	\$f3,262140\(gp\)
[0-9a-f]+ <[^>]+> 446c 0001 	swc1	\$f3,0\(gp\)
[0-9a-f]+ <[^>]+> 446c 0001 	swc1	\$f3,0\(gp\)
[0-9a-f]+ <[^>]+> 446c 0005 	swc1	\$f3,4\(gp\)
[0-9a-f]+ <[^>]+> 446c 4001 	swc1	\$f3,16384\(gp\)
[0-9a-f]+ <[^>]+> 446f fffd 	swc1	\$f3,262140\(gp\)
[0-9a-f]+ <[^>]+> 8042 2fff 	andi	v0,v0,4095
[0-9a-f]+ <[^>]+> 8043 f300 	ext	v0,v1,0x0,0xd
[0-9a-f]+ <[^>]+> 8044 f340 	ext	v0,a0,0x0,0xe
[0-9a-f]+ <[^>]+> 8045 f380 	ext	v0,a1,0x0,0xf
[0-9a-f]+ <[^>]+> 8046 f3c0 	ext	v0,a2,0x0,0x10
[0-9a-f]+ <[^>]+> 8047 f500 	ext	v0,a3,0x0,0x15
[0-9a-f]+ <[^>]+> 8048 f540 	ext	v0,t0,0x0,0x16
[0-9a-f]+ <[^>]+> 8049 f580 	ext	v0,t1,0x0,0x17
[0-9a-f]+ <[^>]+> 8050 f5c0 	ext	v0,s0,0x0,0x18
[0-9a-f]+ <[^>]+> 9008      	nop
[0-9a-f]+ <[^>]+> 9008      	nop
