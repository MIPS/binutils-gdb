#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS instructions
#as:
#stderr: nanomips.l

# Check nanoMIPS instructions

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> 8400 3000 	pref	0x0,0\(zero\)
[0-9a-f]+ <[^>]+> 8400 37ff 	pref	0x0,2047\(zero\)
[0-9a-f]+ <[^>]+> 8020 8800 	li	at,-2048
[0-9a-f]+ <[^>]+> a401 1800 	pref	0x0,0\(at\)
[0-9a-f]+ <[^>]+> 8400 3800 	pref	0x0,2048\(zero\)
[0-9a-f]+ <[^>]+> 8020 8801 	li	at,-2049
[0-9a-f]+ <[^>]+> a401 1800 	pref	0x0,0\(at\)
[0-9a-f]+ <[^>]+> 8400 3000 	pref	0x0,0\(zero\)
[0-9a-f]+ <[^>]+> 8400 3000 	pref	0x0,0\(zero\)
[0-9a-f]+ <[^>]+> 8420 3000 	pref	0x1,0\(zero\)
[0-9a-f]+ <[^>]+> 8440 3000 	pref	0x2,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 3000 	pref	0x3,0\(zero\)
[0-9a-f]+ <[^>]+> 8480 3000 	pref	0x4,0\(zero\)
[0-9a-f]+ <[^>]+> 84a0 3000 	pref	0x5,0\(zero\)
[0-9a-f]+ <[^>]+> 84c0 3000 	pref	0x6,0\(zero\)
[0-9a-f]+ <[^>]+> 84e0 3000 	pref	0x7,0\(zero\)
[0-9a-f]+ <[^>]+> 84e0 31ff 	pref	0x7,511\(zero\)
[0-9a-f]+ <[^>]+> 8020 8200 	li	at,-512
[0-9a-f]+ <[^>]+> a4e1 1800 	pref	0x7,0\(at\)
[0-9a-f]+ <[^>]+> 0020 7fff 	li	at,32767
[0-9a-f]+ <[^>]+> a461 1800 	pref	0x3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> a461 1800 	pref	0x3,0\(at\)
[0-9a-f]+ <[^>]+> 0022 7fff 	addiu	at,t4,32767
[0-9a-f]+ <[^>]+> a461 1800 	pref	0x3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2041 0950 	addu	at,at,t4
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
[0-9a-f]+ <[^>]+> 1180      	move	t0,zero
[0-9a-f]+ <[^>]+> 1320      	move	t9,zero
[0-9a-f]+ <[^>]+> 0040 0000 	li	t4,0
[0-9a-f]+ <[^>]+> 0040 0001 	li	t4,1
[0-9a-f]+ <[^>]+> 0040 7fff 	li	t4,32767
[0-9a-f]+ <[^>]+> e05f 8ffd 	lui	t4,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 0040 ffff 	li	t4,65535
[0-9a-f]+ <[^>]+> e041 0000 	lui	t4,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> e05f 8ffd 	lui	t4,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 6040 8001 ffff 	li	t4,0xffff8001
[0-9a-f]+ <[^>]+> 8040 8001 	li	t4,-1
[0-9a-f]+ <[^>]+> 6040 5678 1234 	li	t4,0x12345678
[0-9a-f]+ <[^>]+> 8060 8001 	li	t5,-1
[0-9a-f]+ <[^>]+> d27f      	li	a0,-1
[0-9a-f]+ <[^>]+> 2016 0290 	move	zero,s6
[0-9a-f]+ <[^>]+> 1056      	move	t4,s6
[0-9a-f]+ <[^>]+> 1076      	move	t5,s6
[0-9a-f]+ <[^>]+> 1096      	move	a0,s6
[0-9a-f]+ <[^>]+> 10b6      	move	a1,s6
[0-9a-f]+ <[^>]+> 10d6      	move	a2,s6
[0-9a-f]+ <[^>]+> 10f6      	move	a3,s6
[0-9a-f]+ <[^>]+> 1116      	move	a4,s6
[0-9a-f]+ <[^>]+> 1136      	move	a5,s6
[0-9a-f]+ <[^>]+> 1156      	move	a6,s6
[0-9a-f]+ <[^>]+> 13d6      	move	fp,s6
[0-9a-f]+ <[^>]+> 13f6      	move	ra,s6
[0-9a-f]+ <[^>]+> 2000 0290 	move	zero,zero
[0-9a-f]+ <[^>]+> 2002 0290 	move	zero,t4
[0-9a-f]+ <[^>]+> 2003 0290 	move	zero,t5
[0-9a-f]+ <[^>]+> 2004 0290 	move	zero,a0
[0-9a-f]+ <[^>]+> 2005 0290 	move	zero,a1
[0-9a-f]+ <[^>]+> 2006 0290 	move	zero,a2
[0-9a-f]+ <[^>]+> 2007 0290 	move	zero,a3
[0-9a-f]+ <[^>]+> 2008 0290 	move	zero,a4
[0-9a-f]+ <[^>]+> 2009 0290 	move	zero,a5
[0-9a-f]+ <[^>]+> 200a 0290 	move	zero,a6
[0-9a-f]+ <[^>]+> 201e 0290 	move	zero,fp
[0-9a-f]+ <[^>]+> 201f 0290 	move	zero,ra
[0-9a-f]+ <[^>]+> 12c2      	move	s6,t4
[0-9a-f]+ <[^>]+> 1056      	move	t4,s6
[0-9a-f]+ <[^>]+> 12c2      	move	s6,t4
[0-9a-f]+ <[^>]+> 2016 1290 	move	t4,s6
[0-9a-f]+ <[^>]+> 2002 b290 	move	s6,t4
[0-9a-f]+ <[^>]+> 1800      	bc	[0-9a-f]+ <test>
			[0-9a-f]+: R_NANOMIPS_PC10_S1	test
[0-9a-f]+ <[^>]+> 1800      	bc	[0-9a-f]+ <test>
			[0-9a-f]+: R_NANOMIPS_PC10_S1	test
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <test>
			[0-9a-f]+: R_NANOMIPS_PC25_S1	test
[0-9a-f]+ <[^>]+> 1800      	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC10_S1	\.L11
[0-9a-f]+ <[^>]+> 1800      	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC10_S1	\.L11
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC25_S1	\.L11
[0-9a-f]+ <[^>]+> 1800      	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC10_S1	\.L11
[0-9a-f]+ <[^>]+> 1800      	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC10_S1	\.L11
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC25_S1	\.L11
[0-9a-f]+ <[^>]+> 1043      	move	t4,t5
[0-9a-f]+ <[^>]+> 8803 8000 	bgezc	t5,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	\.L0
[0-9a-f]+ <[^>]+> 2060 11d0 	negu	t4,t5
[0-9a-f]+ <[^>]+> 1044      	move	t4,a0
[0-9a-f]+ <[^>]+> 8804 8000 	bgezc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	\.L1
[0-9a-f]+ <[^>]+> 2080 11d0 	negu	t4,a0
[0-9a-f]+ <[^>]+> 8802 8000 	bgezc	t4,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	\.L2
[0-9a-f]+ <[^>]+> 2040 11d0 	negu	t4,t4
[0-9a-f]+ <[^>]+> 8802 8000 	bgezc	t4,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	\.L3
[0-9a-f]+ <[^>]+> 2040 11d0 	negu	t4,t4
[0-9a-f]+ <[^>]+> 2083 1110 	add	t4,t5,a0
[0-9a-f]+ <[^>]+> 23fe e910 	add	sp,fp,ra
[0-9a-f]+ <[^>]+> 2082 1110 	add	t4,t4,a0
[0-9a-f]+ <[^>]+> 2082 1110 	add	t4,t4,a0
[0-9a-f]+ <[^>]+> 0042 0000 	addiu	t4,t4,0
[0-9a-f]+ <[^>]+> 0020 0001 	li	at,1
[0-9a-f]+ <[^>]+> 2022 1110 	add	t4,t4,at
[0-9a-f]+ <[^>]+> 0020 7fff 	li	at,32767
[0-9a-f]+ <[^>]+> 2022 1110 	add	t4,t4,at
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2022 1110 	add	t4,t4,at
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> 2022 1110 	add	t4,t4,at
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2024 1910 	add	t5,a0,at
[0-9a-f]+ <[^>]+> 0064 0000 	addiu	t5,a0,0
[0-9a-f]+ <[^>]+> 0020 7fff 	li	at,32767
[0-9a-f]+ <[^>]+> 2024 1910 	add	t5,a0,at
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> 2024 1910 	add	t5,a0,at
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> 2023 1910 	add	t5,t5,at
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> 2023 1910 	add	t5,t5,at
[0-9a-f]+ <[^>]+> 9018      	addiu	zero,zero,-8
[0-9a-f]+ <[^>]+> 9058      	addiu	t4,t4,-8
[0-9a-f]+ <[^>]+> 9078      	addiu	t5,t5,-8
[0-9a-f]+ <[^>]+> 9098      	addiu	a0,a0,-8
[0-9a-f]+ <[^>]+> 90b8      	addiu	a1,a1,-8
[0-9a-f]+ <[^>]+> 90d8      	addiu	a2,a2,-8
[0-9a-f]+ <[^>]+> 90f8      	addiu	a3,a3,-8
[0-9a-f]+ <[^>]+> 9118      	addiu	a4,a4,-8
[0-9a-f]+ <[^>]+> 9138      	addiu	a5,a5,-8
[0-9a-f]+ <[^>]+> 9158      	addiu	a6,a6,-8
[0-9a-f]+ <[^>]+> 93d8      	addiu	fp,fp,-8
[0-9a-f]+ <[^>]+> 93f8      	addiu	ra,ra,-8
[0-9a-f]+ <[^>]+> 93f9      	addiu	ra,ra,-7
[0-9a-f]+ <[^>]+> 93e8      	addiu	ra,ra,0
[0-9a-f]+ <[^>]+> 93e9      	addiu	ra,ra,1
[0-9a-f]+ <[^>]+> 93ee      	addiu	ra,ra,6
[0-9a-f]+ <[^>]+> 93ef      	addiu	ra,ra,7
[0-9a-f]+ <[^>]+> 03ff 0008 	addiu	ra,ra,8
[0-9a-f]+ <[^>]+> 83bd 8408 	addiu	sp,sp,-1032
[0-9a-f]+ <[^>]+> 83bd 8404 	addiu	sp,sp,-1028
[0-9a-f]+ <[^>]+> 83bd 8400 	addiu	sp,sp,-1024
[0-9a-f]+ <[^>]+> 03bd 03fc 	addiu	sp,sp,1020
[0-9a-f]+ <[^>]+> 03bd 0400 	addiu	sp,sp,1024
[0-9a-f]+ <[^>]+> 03bd 0404 	addiu	sp,sp,1028
[0-9a-f]+ <[^>]+> 03bd 0404 	addiu	sp,sp,1028
[0-9a-f]+ <[^>]+> 03bd 0408 	addiu	sp,sp,1032
[0-9a-f]+ <[^>]+> 905f      	addiu	t4,t4,-1
[0-9a-f]+ <[^>]+> 8043 8001 	addiu	t4,t5,-1
[0-9a-f]+ <[^>]+> 8044 8001 	addiu	t4,a0,-1
[0-9a-f]+ <[^>]+> 8045 8001 	addiu	t4,a1,-1
[0-9a-f]+ <[^>]+> 8046 8001 	addiu	t4,a2,-1
[0-9a-f]+ <[^>]+> 8047 8001 	addiu	t4,a3,-1
[0-9a-f]+ <[^>]+> 8050 8001 	addiu	t4,s0,-1
[0-9a-f]+ <[^>]+> 8051 8001 	addiu	t4,s1,-1
[0-9a-f]+ <[^>]+> 0051 0001 	addiu	t4,s1,1
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
[0-9a-f]+ <[^>]+> 005d 0100 	addiu	t4,sp,256
[0-9a-f]+ <[^>]+> 717f      	addiu	s2,sp,252
[0-9a-f]+ <[^>]+> 71ff      	addiu	s3,sp,252
[0-9a-f]+ <[^>]+> 727f      	addiu	a0,sp,252
[0-9a-f]+ <[^>]+> 72ff      	addiu	a1,sp,252
[0-9a-f]+ <[^>]+> 737f      	addiu	a2,sp,252
[0-9a-f]+ <[^>]+> 73ff      	addiu	a3,sp,252
[0-9a-f]+ <[^>]+> 707f      	addiu	s0,sp,252
[0-9a-f]+ <[^>]+> 70ff      	addiu	s1,sp,252
[0-9a-f]+ <[^>]+> 8064 8fff 	addiu	t5,a0,-4095
[0-9a-f]+ <[^>]+> 91c0      	addiu	s3,a0,0
[0-9a-f]+ <[^>]+> 0064 1fff 	addiu	t5,a0,8191
[0-9a-f]+ <[^>]+> 0064 3fff 	addiu	t5,a0,16383
[0-9a-f]+ <[^>]+> 0063 3fff 	addiu	t5,t5,16383
[0-9a-f]+ <[^>]+> 0063 3fff 	addiu	t5,t5,16383
[0-9a-f]+ <[^>]+> 2016 1150 	move	t4,s6
[0-9a-f]+ <[^>]+> 2002 b150 	move	s6,t4
[0-9a-f]+ <[^>]+> 22c0 1150 	addu	t4,zero,s6
[0-9a-f]+ <[^>]+> 2040 b150 	addu	s6,zero,t4
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
[0-9a-f]+ <[^>]+> 23fe e950 	addu	sp,fp,ra
[0-9a-f]+ <[^>]+> 0042 0000 	addiu	t4,t4,0
[0-9a-f]+ <[^>]+> 0042 0001 	addiu	t4,t4,1
[0-9a-f]+ <[^>]+> 0042 7fff 	addiu	t4,t4,32767
[0-9a-f]+ <[^>]+> 6041 8000 ffff 	addiu	t4,t4,-32768
[0-9a-f]+ <[^>]+> 0042 ffff 	addiu	t4,t4,65535
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
[0-9a-f]+ <[^>]+> 2062 1250 	and	t4,t4,t5
[0-9a-f]+ <[^>]+> f121      	andi	s2,s2,0x1
[0-9a-f]+ <[^>]+> f122      	andi	s2,s2,0x2
[0-9a-f]+ <[^>]+> f123      	andi	s2,s2,0x3
[0-9a-f]+ <[^>]+> f124      	andi	s2,s2,0x4
[0-9a-f]+ <[^>]+> f127      	andi	s2,s2,0x7
[0-9a-f]+ <[^>]+> f128      	andi	s2,s2,0x8
[0-9a-f]+ <[^>]+> f12f      	andi	s2,s2,0xf
[0-9a-f]+ <[^>]+> 8042 2010 	andi	t4,t4,16
[0-9a-f]+ <[^>]+> 8042 201f 	andi	t4,t4,31
[0-9a-f]+ <[^>]+> 8042 2020 	andi	t4,t4,32
[0-9a-f]+ <[^>]+> 8042 203f 	andi	t4,t4,63
[0-9a-f]+ <[^>]+> 8042 2040 	andi	t4,t4,64
[0-9a-f]+ <[^>]+> 8042 2080 	andi	t4,t4,128
[0-9a-f]+ <[^>]+> f12c      	andi	s2,s2,0xff
[0-9a-f]+ <[^>]+> 8042 2fff 	andi	t4,t4,4095
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
[0-9a-f]+ <[^>]+> 2083 1250 	and	t4,t5,a0
[0-9a-f]+ <[^>]+> 2082 1250 	and	t4,t4,a0
[0-9a-f]+ <[^>]+> 2082 1250 	and	t4,t4,a0
[0-9a-f]+ <[^>]+> 8043 2000 	andi	t4,t5,0
[0-9a-f]+ <[^>]+> 8043 2fff 	andi	t4,t5,4095
[0-9a-f]+ <[^>]+> 0020 1000 	li	at,4096
[0-9a-f]+ <[^>]+> 2023 1250 	and	t4,t5,at
[0-9a-f]+ <[^>]+> 6020 0001 ffff 	li	at,0xffff0001
[0-9a-f]+ <[^>]+> 2023 1250 	and	t4,t5,at
[0-9a-f]+ <[^>]+> 9900      	beqzc	s2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9980      	beqzc	s3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9a00      	beqzc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9a80      	beqzc	a1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9b00      	beqzc	a2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9b80      	beqzc	a3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9800      	beqzc	s0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9880      	beqzc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9900      	beqzc	s2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9980      	beqzc	s3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9a00      	beqzc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9a80      	beqzc	a1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9b00      	beqzc	a2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9b80      	beqzc	a3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9800      	beqzc	s0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9880      	beqzc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9900      	beqzc	s2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9980      	beqzc	s3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9a00      	beqzc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9a80      	beqzc	a1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9b00      	beqzc	a2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9b80      	beqzc	a3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9800      	beqzc	s0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9880      	beqzc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 9800      	beqzc	s0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 8a00 0000 	beqzc	s0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test2
[0-9a-f]+ <[^>]+> 9880      	beqzc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 8a20 0000 	beqzc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test2
[0-9a-f]+ <[^>]+> 9880      	beqzc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test2
[0-9a-f]+ <[^>]+> 8a00 0000 	beqzc	s0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test2
[0-9a-f]+ <[^>]+> ca00 5000 	beqic	s0,10,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC11_S1	test2
[0-9a-f]+ <[^>]+> 0020 7fff 	li	at,32767
[0-9a-f]+ <[^>]+> 8830 0000 	beqc	s0,at,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test2
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> 8830 0000 	beqc	s0,at,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test2
[0-9a-f]+ <[^>]+> b900      	bnezc	s2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> b980      	bnezc	s3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> ba00      	bnezc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> ba80      	bnezc	a1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> bb00      	bnezc	a2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> bb80      	bnezc	a3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> b800      	bnezc	s0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> b880      	bnezc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> b900      	bnezc	s2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> b980      	bnezc	s3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> ba00      	bnezc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> ba80      	bnezc	a1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> bb00      	bnezc	a2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> bb80      	bnezc	a3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> b800      	bnezc	s0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> b880      	bnezc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> b900      	bnezc	s2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> b980      	bnezc	s3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> ba00      	bnezc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> ba80      	bnezc	a1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> bb00      	bnezc	a2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> bb80      	bnezc	a3,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> b800      	bnezc	s0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> b880      	bnezc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> b800      	bnezc	s0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test3
[0-9a-f]+ <[^>]+> aa00 0000 	bnezc	s0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test3
[0-9a-f]+ <[^>]+> aa20 0000 	bnezc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test2
[0-9a-f]+ <[^>]+> aa20 0000 	bnezc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test2
[0-9a-f]+ <[^>]+> aa20 0000 	bnezc	s1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test2
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
[0-9a-f]+ <[^>]+> a400 3900 	cache	0x0,0\(zero\)
[0-9a-f]+ <[^>]+> 8020 8800 	li	at,-2048
[0-9a-f]+ <[^>]+> a401 3900 	cache	0x0,0\(at\)
[0-9a-f]+ <[^>]+> 0020 07ff 	li	at,2047
[0-9a-f]+ <[^>]+> a401 3900 	cache	0x0,0\(at\)
[0-9a-f]+ <[^>]+> 8020 8801 	li	at,-2049
[0-9a-f]+ <[^>]+> a401 3900 	cache	0x0,0\(at\)
[0-9a-f]+ <[^>]+> 0020 0800 	li	at,2048
[0-9a-f]+ <[^>]+> a401 3900 	cache	0x0,0\(at\)
[0-9a-f]+ <[^>]+> a402 3900 	cache	0x0,0\(t4\)
[0-9a-f]+ <[^>]+> 8022 8800 	addiu	at,t4,-2048
[0-9a-f]+ <[^>]+> a401 3900 	cache	0x0,0\(at\)
[0-9a-f]+ <[^>]+> 0022 07ff 	addiu	at,t4,2047
[0-9a-f]+ <[^>]+> a401 3900 	cache	0x0,0\(at\)
[0-9a-f]+ <[^>]+> 8022 8801 	addiu	at,t4,-2049
[0-9a-f]+ <[^>]+> a401 3900 	cache	0x0,0\(at\)
[0-9a-f]+ <[^>]+> 0022 0800 	addiu	at,t4,2048
[0-9a-f]+ <[^>]+> a401 3900 	cache	0x0,0\(at\)
[0-9a-f]+ <[^>]+> a400 3900 	cache	0x0,0\(zero\)
[0-9a-f]+ <[^>]+> a400 3900 	cache	0x0,0\(zero\)
[0-9a-f]+ <[^>]+> a420 3900 	cache	0x1,0\(zero\)
[0-9a-f]+ <[^>]+> a440 3900 	cache	0x2,0\(zero\)
[0-9a-f]+ <[^>]+> a460 3900 	cache	0x3,0\(zero\)
[0-9a-f]+ <[^>]+> a480 3900 	cache	0x4,0\(zero\)
[0-9a-f]+ <[^>]+> a4a0 3900 	cache	0x5,0\(zero\)
[0-9a-f]+ <[^>]+> a4c0 3900 	cache	0x6,0\(zero\)
[0-9a-f]+ <[^>]+> a7e0 3900 	cache	0x1f,0\(zero\)
[0-9a-f]+ <[^>]+> 0020 07ff 	li	at,2047
[0-9a-f]+ <[^>]+> a7e1 3900 	cache	0x1f,0\(at\)
[0-9a-f]+ <[^>]+> 8020 8800 	li	at,-2048
[0-9a-f]+ <[^>]+> a7e1 3900 	cache	0x1f,0\(at\)
[0-9a-f]+ <[^>]+> 0020 07ff 	li	at,2047
[0-9a-f]+ <[^>]+> a401 3900 	cache	0x0,0\(at\)
[0-9a-f]+ <[^>]+> 8020 8800 	li	at,-2048
[0-9a-f]+ <[^>]+> a401 3900 	cache	0x0,0\(at\)
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> 2061 0950 	addu	at,at,t5
[0-9a-f]+ <[^>]+> a7e1 3900 	cache	0x1f,0\(at\)
[0-9a-f]+ <[^>]+> 0023 0800 	addiu	at,t5,2048
[0-9a-f]+ <[^>]+> a7e1 3900 	cache	0x1f,0\(at\)
[0-9a-f]+ <[^>]+> 8023 8801 	addiu	at,t5,-2049
[0-9a-f]+ <[^>]+> a7e1 3900 	cache	0x1f,0\(at\)
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> 2061 0950 	addu	at,at,t5
[0-9a-f]+ <[^>]+> a7e1 3901 	cache	0x1f,1\(at\)
[0-9a-f]+ <[^>]+> a7e3 b9ff 	cache	0x1f,-1\(t5\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2061 0950 	addu	at,at,t5
[0-9a-f]+ <[^>]+> a7e1 3900 	cache	0x1f,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2061 0950 	addu	at,at,t5
[0-9a-f]+ <[^>]+> a7e1 3901 	cache	0x1f,1\(at\)
[0-9a-f]+ <[^>]+> 0023 ffff 	addiu	at,t5,65535
[0-9a-f]+ <[^>]+> a7e1 3900 	cache	0x1f,0\(at\)
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> a7e1 3900 	cache	0x1f,0\(at\)
[0-9a-f]+ <[^>]+> 0020 0800 	li	at,2048
[0-9a-f]+ <[^>]+> a7e1 3900 	cache	0x1f,0\(at\)
[0-9a-f]+ <[^>]+> 8020 8801 	li	at,-2049
[0-9a-f]+ <[^>]+> a7e1 3900 	cache	0x1f,0\(at\)
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> a7e1 3901 	cache	0x1f,1\(at\)
[0-9a-f]+ <[^>]+> a7e0 b9ff 	cache	0x1f,-1\(zero\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> a7e1 3900 	cache	0x1f,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> a7e1 3901 	cache	0x1f,1\(at\)
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> a7e1 3900 	cache	0x1f,0\(at\)
[0-9a-f]+ <[^>]+> 2043 4b3f 	clo	t4,t5
[0-9a-f]+ <[^>]+> 2062 4b3f 	clo	t5,t4
[0-9a-f]+ <[^>]+> 2043 5b3f 	clz	t4,t5
[0-9a-f]+ <[^>]+> 2062 5b3f 	clz	t5,t4
[0-9a-f]+ <[^>]+> 2000 e37f 	deret
[0-9a-f]+ <[^>]+> 2000 477f 	di
[0-9a-f]+ <[^>]+> 2000 477f 	di
[0-9a-f]+ <[^>]+> 2040 477f 	di	t4
[0-9a-f]+ <[^>]+> 2060 477f 	di	t5
[0-9a-f]+ <[^>]+> 23c0 477f 	di	fp
[0-9a-f]+ <[^>]+> 23e0 477f 	di	ra
[0-9a-f]+ <[^>]+> 2062 0118 	div	zero,t4,t5
[0-9a-f]+ <[^>]+> 23fe 0118 	div	zero,fp,ra
[0-9a-f]+ <[^>]+> 2060 0118 	div	zero,zero,t5
[0-9a-f]+ <[^>]+> 23e0 0118 	div	zero,zero,ra
[0-9a-f]+ <[^>]+> 2003 1118 	div	t4,t5,zero
[0-9a-f]+ <[^>]+> 2083 1118 	div	t4,t5,a0
[0-9a-f]+ <[^>]+> 1017      	break	0x7
[0-9a-f]+ <[^>]+> 1064      	move	t5,a0
[0-9a-f]+ <[^>]+> 2080 1990 	neg	t5,a0
[0-9a-f]+ <[^>]+> 0020 0002 	li	at,2
[0-9a-f]+ <[^>]+> 2024 1918 	div	t5,a0,at
[0-9a-f]+ <[^>]+> 2062 0198 	divu	zero,t4,t5
[0-9a-f]+ <[^>]+> 23fe 0198 	divu	zero,fp,ra
[0-9a-f]+ <[^>]+> 2060 0198 	divu	zero,zero,t5
[0-9a-f]+ <[^>]+> 23e0 0198 	divu	zero,zero,ra
[0-9a-f]+ <[^>]+> 2003 1198 	divu	t4,t5,zero
[0-9a-f]+ <[^>]+> 2083 1198 	divu	t4,t5,a0
[0-9a-f]+ <[^>]+> 1017      	break	0x7
[0-9a-f]+ <[^>]+> 1064      	move	t5,a0
[0-9a-f]+ <[^>]+> 8020 8001 	li	at,-1
[0-9a-f]+ <[^>]+> 2024 1998 	divu	t5,a0,at
[0-9a-f]+ <[^>]+> 0020 0002 	li	at,2
[0-9a-f]+ <[^>]+> 2024 1998 	divu	t5,a0,at
[0-9a-f]+ <[^>]+> 2000 577f 	ei
[0-9a-f]+ <[^>]+> 2000 577f 	ei
[0-9a-f]+ <[^>]+> 2040 577f 	ei	t4
[0-9a-f]+ <[^>]+> 2060 577f 	ei	t5
[0-9a-f]+ <[^>]+> 23c0 577f 	ei	fp
[0-9a-f]+ <[^>]+> 23e0 577f 	ei	ra
[0-9a-f]+ <[^>]+> 2000 f37f 	eret
[0-9a-f]+ <[^>]+> 8043 f385 	ext	t4,t5,0x5,0xf
[0-9a-f]+ <[^>]+> 8043 f7c0 	ext	t4,t5,0x0,0x20
[0-9a-f]+ <[^>]+> 8043 f01f 	ext	t4,t5,0x1f,0x1
[0-9a-f]+ <[^>]+> 83fe f01f 	ext	ra,fp,0x1f,0x1
[0-9a-f]+ <[^>]+> 8043 e4c5 	ins	t4,t5,0x5,0xf
[0-9a-f]+ <[^>]+> 8043 e7c0 	ins	t4,t5,0x0,0x20
[0-9a-f]+ <[^>]+> 8043 e7df 	ins	t4,t5,0x1f,0x1
[0-9a-f]+ <[^>]+> 83fe e7df 	ins	ra,fp,0x1f,0x1
[0-9a-f]+ <[^>]+> d800      	jrc	zero
[0-9a-f]+ <[^>]+> d840      	jrc	t4
[0-9a-f]+ <[^>]+> d860      	jrc	t5
[0-9a-f]+ <[^>]+> d880      	jrc	a0
[0-9a-f]+ <[^>]+> d8a0      	jrc	a1
[0-9a-f]+ <[^>]+> d8c0      	jrc	a2
[0-9a-f]+ <[^>]+> d8e0      	jrc	a3
[0-9a-f]+ <[^>]+> d900      	jrc	a4
[0-9a-f]+ <[^>]+> dbc0      	jrc	fp
[0-9a-f]+ <[^>]+> dbe0      	jrc	ra
[0-9a-f]+ <[^>]+> 4800 0000 	jrc	zero
[0-9a-f]+ <[^>]+> 4802 0000 	jrc	t4
[0-9a-f]+ <[^>]+> 4803 0000 	jrc	t5
[0-9a-f]+ <[^>]+> 4804 0000 	jrc	a0
[0-9a-f]+ <[^>]+> 4805 0000 	jrc	a1
[0-9a-f]+ <[^>]+> 4806 0000 	jrc	a2
[0-9a-f]+ <[^>]+> 4807 0000 	jrc	a3
[0-9a-f]+ <[^>]+> 4808 0000 	jrc	a4
[0-9a-f]+ <[^>]+> 481e 0000 	jrc	fp
[0-9a-f]+ <[^>]+> 481f 0000 	jrc	ra
[0-9a-f]+ <[^>]+> d800      	jrc	zero
[0-9a-f]+ <[^>]+> d840      	jrc	t4
[0-9a-f]+ <[^>]+> d860      	jrc	t5
[0-9a-f]+ <[^>]+> d880      	jrc	a0
[0-9a-f]+ <[^>]+> d8a0      	jrc	a1
[0-9a-f]+ <[^>]+> d8c0      	jrc	a2
[0-9a-f]+ <[^>]+> d8e0      	jrc	a3
[0-9a-f]+ <[^>]+> d900      	jrc	a4
[0-9a-f]+ <[^>]+> dbc0      	jrc	fp
[0-9a-f]+ <[^>]+> dbe0      	jrc	ra
[0-9a-f]+ <[^>]+> 4800 1000 	jrc\.hb	zero
[0-9a-f]+ <[^>]+> 4802 1000 	jrc\.hb	t4
[0-9a-f]+ <[^>]+> 4803 1000 	jrc\.hb	t5
[0-9a-f]+ <[^>]+> 4804 1000 	jrc\.hb	a0
[0-9a-f]+ <[^>]+> 4805 1000 	jrc\.hb	a1
[0-9a-f]+ <[^>]+> 4806 1000 	jrc\.hb	a2
[0-9a-f]+ <[^>]+> 4807 1000 	jrc\.hb	a3
[0-9a-f]+ <[^>]+> 4808 1000 	jrc\.hb	a4
[0-9a-f]+ <[^>]+> 481e 1000 	jrc\.hb	fp
[0-9a-f]+ <[^>]+> 481f 1000 	jrc\.hb	ra
[0-9a-f]+ <[^>]+> d800      	jrc	zero
[0-9a-f]+ <[^>]+> d840      	jrc	t4
[0-9a-f]+ <[^>]+> d860      	jrc	t5
[0-9a-f]+ <[^>]+> d880      	jrc	a0
[0-9a-f]+ <[^>]+> d8a0      	jrc	a1
[0-9a-f]+ <[^>]+> d8c0      	jrc	a2
[0-9a-f]+ <[^>]+> d8e0      	jrc	a3
[0-9a-f]+ <[^>]+> d900      	jrc	a4
[0-9a-f]+ <[^>]+> dbc0      	jrc	fp
[0-9a-f]+ <[^>]+> dbe0      	jrc	ra
[0-9a-f]+ <[^>]+> d810      	jalrc	zero
[0-9a-f]+ <[^>]+> d850      	jalrc	t4
[0-9a-f]+ <[^>]+> d870      	jalrc	t5
[0-9a-f]+ <[^>]+> d890      	jalrc	a0
[0-9a-f]+ <[^>]+> d8b0      	jalrc	a1
[0-9a-f]+ <[^>]+> d8d0      	jalrc	a2
[0-9a-f]+ <[^>]+> d8f0      	jalrc	a3
[0-9a-f]+ <[^>]+> d910      	jalrc	a4
[0-9a-f]+ <[^>]+> dbd0      	jalrc	fp
[0-9a-f]+ <[^>]+> 4be0 0000 	jalrc	zero
[0-9a-f]+ <[^>]+> 4be2 0000 	jalrc	t4
[0-9a-f]+ <[^>]+> 4be3 0000 	jalrc	t5
[0-9a-f]+ <[^>]+> 4be4 0000 	jalrc	a0
[0-9a-f]+ <[^>]+> 4be5 0000 	jalrc	a1
[0-9a-f]+ <[^>]+> 4be6 0000 	jalrc	a2
[0-9a-f]+ <[^>]+> 4be7 0000 	jalrc	a3
[0-9a-f]+ <[^>]+> 4be8 0000 	jalrc	a4
[0-9a-f]+ <[^>]+> 4bfe 0000 	jalrc	fp
[0-9a-f]+ <[^>]+> d810      	jalrc	zero
[0-9a-f]+ <[^>]+> d850      	jalrc	t4
[0-9a-f]+ <[^>]+> d870      	jalrc	t5
[0-9a-f]+ <[^>]+> d890      	jalrc	a0
[0-9a-f]+ <[^>]+> d8b0      	jalrc	a1
[0-9a-f]+ <[^>]+> d8d0      	jalrc	a2
[0-9a-f]+ <[^>]+> d8f0      	jalrc	a3
[0-9a-f]+ <[^>]+> d910      	jalrc	a4
[0-9a-f]+ <[^>]+> dbd0      	jalrc	fp
[0-9a-f]+ <[^>]+> 4bdf 0000 	jalrc	fp,ra
[0-9a-f]+ <[^>]+> 4840 0000 	jalrc	t4,zero
[0-9a-f]+ <[^>]+> 4862 0000 	jalrc	t5,t4
[0-9a-f]+ <[^>]+> 4843 0000 	jalrc	t4,t5
[0-9a-f]+ <[^>]+> 4844 0000 	jalrc	t4,a0
[0-9a-f]+ <[^>]+> 4845 0000 	jalrc	t4,a1
[0-9a-f]+ <[^>]+> 4846 0000 	jalrc	t4,a2
[0-9a-f]+ <[^>]+> 4847 0000 	jalrc	t4,a3
[0-9a-f]+ <[^>]+> 4848 0000 	jalrc	t4,a4
[0-9a-f]+ <[^>]+> 485e 0000 	jalrc	t4,fp
[0-9a-f]+ <[^>]+> 485f 0000 	jalrc	t4,ra
[0-9a-f]+ <[^>]+> 4be0 1000 	jalrc\.hb	zero
[0-9a-f]+ <[^>]+> 4be2 1000 	jalrc\.hb	t4
[0-9a-f]+ <[^>]+> 4be3 1000 	jalrc\.hb	t5
[0-9a-f]+ <[^>]+> 4be4 1000 	jalrc\.hb	a0
[0-9a-f]+ <[^>]+> 4be5 1000 	jalrc\.hb	a1
[0-9a-f]+ <[^>]+> 4be6 1000 	jalrc\.hb	a2
[0-9a-f]+ <[^>]+> 4be7 1000 	jalrc\.hb	a3
[0-9a-f]+ <[^>]+> 4be8 1000 	jalrc\.hb	a4
[0-9a-f]+ <[^>]+> 4bfe 1000 	jalrc\.hb	fp
[0-9a-f]+ <[^>]+> 4be0 1000 	jalrc\.hb	zero
[0-9a-f]+ <[^>]+> 4be2 1000 	jalrc\.hb	t4
[0-9a-f]+ <[^>]+> 4be3 1000 	jalrc\.hb	t5
[0-9a-f]+ <[^>]+> 4be4 1000 	jalrc\.hb	a0
[0-9a-f]+ <[^>]+> 4be5 1000 	jalrc\.hb	a1
[0-9a-f]+ <[^>]+> 4be6 1000 	jalrc\.hb	a2
[0-9a-f]+ <[^>]+> 4be7 1000 	jalrc\.hb	a3
[0-9a-f]+ <[^>]+> 4be8 1000 	jalrc\.hb	a4
[0-9a-f]+ <[^>]+> 4bfe 1000 	jalrc\.hb	fp
[0-9a-f]+ <[^>]+> 4bdf 1000 	jalrc\.hb	fp,ra
[0-9a-f]+ <[^>]+> 4840 1000 	jalrc\.hb	t4,zero
[0-9a-f]+ <[^>]+> 4862 1000 	jalrc\.hb	t5,t4
[0-9a-f]+ <[^>]+> 4843 1000 	jalrc\.hb	t4,t5
[0-9a-f]+ <[^>]+> 4844 1000 	jalrc\.hb	t4,a0
[0-9a-f]+ <[^>]+> 4845 1000 	jalrc\.hb	t4,a1
[0-9a-f]+ <[^>]+> 4846 1000 	jalrc\.hb	t4,a2
[0-9a-f]+ <[^>]+> 4847 1000 	jalrc\.hb	t4,a3
[0-9a-f]+ <[^>]+> 4848 1000 	jalrc\.hb	t4,a4
[0-9a-f]+ <[^>]+> 485e 1000 	jalrc\.hb	t4,fp
[0-9a-f]+ <[^>]+> 485f 1000 	jalrc\.hb	t4,ra
[0-9a-f]+ <[^>]+> 4843 0000 	jalrc	t4,t5
[0-9a-f]+ <[^>]+> 4bdf 0000 	jalrc	fp,ra
[0-9a-f]+ <[^>]+> d870      	jalrc	t5
[0-9a-f]+ <[^>]+> dbf0      	jalrc	ra
[0-9a-f]+ <[^>]+> 2a00 0000 	balc	[0-9a-f]+ <test>
			[0-9a-f]+: R_NANOMIPS_PC25_S1	test
[0-9a-f]+ <[^>]+> 2a00 0000 	balc	[0-9a-f]+ <test2>
			[0-9a-f]+: R_NANOMIPS_PC25_S1	test2
[0-9a-f]+ <[^>]+> 6040 0000 0000 	li	t4,0x0
			[0-9a-f]+: R_NANOMIPS_I32	test
[0-9a-f]+ <[^>]+> 8460 0000 	lb	t5,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 0004 	lb	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 0000 	lb	t5,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 0004 	lb	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 0060 7fff 	li	t5,32767
[0-9a-f]+ <[^>]+> 8463 0000 	lb	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8463 0000 	lb	t5,0\(t5\)
[0-9a-f]+ <[^>]+> 0060 ffff 	li	t5,65535
[0-9a-f]+ <[^>]+> 8463 0000 	lb	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8463 0000 	lb	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8463 0000 	lb	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8463 0001 	lb	t5,1\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8463 0001 	lb	t5,1\(t5\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	t5,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 8463 0000 	lb	t5,0\(t5\)
[0-9a-f]+ <[^>]+> a460 80ff 	lb	t5,-1\(zero\)
[0-9a-f]+ <[^>]+> e074 5244 	lui	t5,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 8463 0678 	lb	t5,1656\(t5\)
[0-9a-f]+ <[^>]+> 5dc0      	lb	s3,0\(a0\)
[0-9a-f]+ <[^>]+> 5dc0      	lb	s3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 0004 	lb	t5,4\(a0\)
[0-9a-f]+ <[^>]+> 0064 7fff 	addiu	t5,a0,32767
[0-9a-f]+ <[^>]+> 8463 0000 	lb	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 0000 	lb	t5,0\(t5\)
[0-9a-f]+ <[^>]+> 0064 ffff 	addiu	t5,a0,65535
[0-9a-f]+ <[^>]+> 8463 0000 	lb	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 0000 	lb	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 0000 	lb	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 0001 	lb	t5,1\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 0001 	lb	t5,1\(t5\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	t5,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 0000 	lb	t5,0\(t5\)
[0-9a-f]+ <[^>]+> a464 80ff 	lb	t5,-1\(a0\)
[0-9a-f]+ <[^>]+> e074 5244 	lui	t5,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 0678 	lb	t5,1656\(t5\)
[0-9a-f]+ <[^>]+> a443 90ff 	lbu	t4,-1\(t5\)
[0-9a-f]+ <[^>]+> 5d38      	lbu	s2,0\(s3\)
[0-9a-f]+ <[^>]+> 5d38      	lbu	s2,0\(s3\)
[0-9a-f]+ <[^>]+> 5d39      	lbu	s2,1\(s3\)
[0-9a-f]+ <[^>]+> 5d3a      	lbu	s2,2\(s3\)
[0-9a-f]+ <[^>]+> 5d3b      	lbu	s2,3\(s3\)
[0-9a-f]+ <[^>]+> 8443 2004 	lbu	t4,4\(t5\)
[0-9a-f]+ <[^>]+> 8443 2005 	lbu	t4,5\(t5\)
[0-9a-f]+ <[^>]+> 8443 2006 	lbu	t4,6\(t5\)
[0-9a-f]+ <[^>]+> 8443 2007 	lbu	t4,7\(t5\)
[0-9a-f]+ <[^>]+> 8443 2008 	lbu	t4,8\(t5\)
[0-9a-f]+ <[^>]+> 8443 2009 	lbu	t4,9\(t5\)
[0-9a-f]+ <[^>]+> 8443 200a 	lbu	t4,10\(t5\)
[0-9a-f]+ <[^>]+> 8443 200b 	lbu	t4,11\(t5\)
[0-9a-f]+ <[^>]+> 8443 200c 	lbu	t4,12\(t5\)
[0-9a-f]+ <[^>]+> 8443 200d 	lbu	t4,13\(t5\)
[0-9a-f]+ <[^>]+> 8443 200e 	lbu	t4,14\(t5\)
[0-9a-f]+ <[^>]+> 8442 200e 	lbu	t4,14\(t4\)
[0-9a-f]+ <[^>]+> 8444 200e 	lbu	t4,14\(a0\)
[0-9a-f]+ <[^>]+> 8445 200e 	lbu	t4,14\(a1\)
[0-9a-f]+ <[^>]+> 8446 200e 	lbu	t4,14\(a2\)
[0-9a-f]+ <[^>]+> 8447 200e 	lbu	t4,14\(a3\)
[0-9a-f]+ <[^>]+> 8450 200e 	lbu	t4,14\(s0\)
[0-9a-f]+ <[^>]+> 8451 200e 	lbu	t4,14\(s1\)
[0-9a-f]+ <[^>]+> 8471 200e 	lbu	t5,14\(s1\)
[0-9a-f]+ <[^>]+> 8491 200e 	lbu	a0,14\(s1\)
[0-9a-f]+ <[^>]+> 84b1 200e 	lbu	a1,14\(s1\)
[0-9a-f]+ <[^>]+> 84d1 200e 	lbu	a2,14\(s1\)
[0-9a-f]+ <[^>]+> 84f1 200e 	lbu	a3,14\(s1\)
[0-9a-f]+ <[^>]+> 8611 200e 	lbu	s0,14\(s1\)
[0-9a-f]+ <[^>]+> 8631 200e 	lbu	s1,14\(s1\)
[0-9a-f]+ <[^>]+> 8460 2000 	lbu	t5,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 2004 	lbu	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 2000 	lbu	t5,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 2004 	lbu	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 0060 7fff 	li	t5,32767
[0-9a-f]+ <[^>]+> 8463 2000 	lbu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8463 2000 	lbu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> 0060 ffff 	li	t5,65535
[0-9a-f]+ <[^>]+> 8463 2000 	lbu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8463 2000 	lbu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8463 2000 	lbu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8463 2001 	lbu	t5,1\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8463 2001 	lbu	t5,1\(t5\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	t5,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 8463 2000 	lbu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> a460 90ff 	lbu	t5,-1\(zero\)
[0-9a-f]+ <[^>]+> e074 5244 	lui	t5,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 8463 2678 	lbu	t5,1656\(t5\)
[0-9a-f]+ <[^>]+> 5dc8      	lbu	s3,0\(a0\)
[0-9a-f]+ <[^>]+> 5dc8      	lbu	s3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 2004 	lbu	t5,4\(a0\)
[0-9a-f]+ <[^>]+> 0064 7fff 	addiu	t5,a0,32767
[0-9a-f]+ <[^>]+> 8463 2000 	lbu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 2000 	lbu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> 0064 ffff 	addiu	t5,a0,65535
[0-9a-f]+ <[^>]+> 8463 2000 	lbu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 2000 	lbu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 2000 	lbu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 2001 	lbu	t5,1\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 2001 	lbu	t5,1\(t5\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	t5,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 2000 	lbu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> a464 90ff 	lbu	t5,-1\(a0\)
[0-9a-f]+ <[^>]+> e074 5244 	lui	t5,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 2678 	lbu	t5,1656\(t5\)
[0-9a-f]+ <[^>]+> 8460 4000 	lh	t5,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 4004 	lh	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 4000 	lh	t5,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 4004 	lh	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 0060 7fff 	li	t5,32767
[0-9a-f]+ <[^>]+> 8463 4000 	lh	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8463 4000 	lh	t5,0\(t5\)
[0-9a-f]+ <[^>]+> 0060 ffff 	li	t5,65535
[0-9a-f]+ <[^>]+> 8463 4000 	lh	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8463 4000 	lh	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8463 4000 	lh	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8463 4001 	lh	t5,1\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8463 4001 	lh	t5,1\(t5\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	t5,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 8463 4000 	lh	t5,0\(t5\)
[0-9a-f]+ <[^>]+> a460 a0ff 	lh	t5,-1\(zero\)
[0-9a-f]+ <[^>]+> e074 5244 	lui	t5,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 8463 4678 	lh	t5,1656\(t5\)
[0-9a-f]+ <[^>]+> 7dc0      	lh	s3,0\(a0\)
[0-9a-f]+ <[^>]+> 7dc0      	lh	s3,0\(a0\)
[0-9a-f]+ <[^>]+> 7dc4      	lh	s3,4\(a0\)
[0-9a-f]+ <[^>]+> 0064 7fff 	addiu	t5,a0,32767
[0-9a-f]+ <[^>]+> 8463 4000 	lh	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 4000 	lh	t5,0\(t5\)
[0-9a-f]+ <[^>]+> 0064 ffff 	addiu	t5,a0,65535
[0-9a-f]+ <[^>]+> 8463 4000 	lh	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 4000 	lh	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 4000 	lh	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 4001 	lh	t5,1\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 4001 	lh	t5,1\(t5\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	t5,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 4000 	lh	t5,0\(t5\)
[0-9a-f]+ <[^>]+> a464 a0ff 	lh	t5,-1\(a0\)
[0-9a-f]+ <[^>]+> e074 5244 	lui	t5,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 4678 	lh	t5,1656\(t5\)
[0-9a-f]+ <[^>]+> 7d38      	lhu	s2,0\(s3\)
[0-9a-f]+ <[^>]+> 7d38      	lhu	s2,0\(s3\)
[0-9a-f]+ <[^>]+> 7d3a      	lhu	s2,2\(s3\)
[0-9a-f]+ <[^>]+> 7d3c      	lhu	s2,4\(s3\)
[0-9a-f]+ <[^>]+> 7d3e      	lhu	s2,6\(s3\)
[0-9a-f]+ <[^>]+> 8443 6008 	lhu	t4,8\(t5\)
[0-9a-f]+ <[^>]+> 8443 600a 	lhu	t4,10\(t5\)
[0-9a-f]+ <[^>]+> 8443 600c 	lhu	t4,12\(t5\)
[0-9a-f]+ <[^>]+> 8443 600e 	lhu	t4,14\(t5\)
[0-9a-f]+ <[^>]+> 8443 6010 	lhu	t4,16\(t5\)
[0-9a-f]+ <[^>]+> 8443 6012 	lhu	t4,18\(t5\)
[0-9a-f]+ <[^>]+> 8443 6014 	lhu	t4,20\(t5\)
[0-9a-f]+ <[^>]+> 8443 6016 	lhu	t4,22\(t5\)
[0-9a-f]+ <[^>]+> 8443 6018 	lhu	t4,24\(t5\)
[0-9a-f]+ <[^>]+> 8443 601a 	lhu	t4,26\(t5\)
[0-9a-f]+ <[^>]+> 8443 601c 	lhu	t4,28\(t5\)
[0-9a-f]+ <[^>]+> 8443 601e 	lhu	t4,30\(t5\)
[0-9a-f]+ <[^>]+> 8444 601e 	lhu	t4,30\(a0\)
[0-9a-f]+ <[^>]+> 8445 601e 	lhu	t4,30\(a1\)
[0-9a-f]+ <[^>]+> 8446 601e 	lhu	t4,30\(a2\)
[0-9a-f]+ <[^>]+> 8447 601e 	lhu	t4,30\(a3\)
[0-9a-f]+ <[^>]+> 8442 601e 	lhu	t4,30\(t4\)
[0-9a-f]+ <[^>]+> 8450 601e 	lhu	t4,30\(s0\)
[0-9a-f]+ <[^>]+> 8451 601e 	lhu	t4,30\(s1\)
[0-9a-f]+ <[^>]+> 8471 601e 	lhu	t5,30\(s1\)
[0-9a-f]+ <[^>]+> 8491 601e 	lhu	a0,30\(s1\)
[0-9a-f]+ <[^>]+> 84b1 601e 	lhu	a1,30\(s1\)
[0-9a-f]+ <[^>]+> 84d1 601e 	lhu	a2,30\(s1\)
[0-9a-f]+ <[^>]+> 84f1 601e 	lhu	a3,30\(s1\)
[0-9a-f]+ <[^>]+> 8611 601e 	lhu	s0,30\(s1\)
[0-9a-f]+ <[^>]+> 8631 601e 	lhu	s1,30\(s1\)
[0-9a-f]+ <[^>]+> 8460 6000 	lhu	t5,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 6004 	lhu	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 6000 	lhu	t5,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 6004 	lhu	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 0060 7fff 	li	t5,32767
[0-9a-f]+ <[^>]+> 8463 6000 	lhu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8463 6000 	lhu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> 0060 ffff 	li	t5,65535
[0-9a-f]+ <[^>]+> 8463 6000 	lhu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8463 6000 	lhu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8463 6000 	lhu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8463 6001 	lhu	t5,1\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8463 6001 	lhu	t5,1\(t5\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	t5,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 8463 6000 	lhu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> a460 b0ff 	lhu	t5,-1\(zero\)
[0-9a-f]+ <[^>]+> e074 5244 	lui	t5,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 8463 6678 	lhu	t5,1656\(t5\)
[0-9a-f]+ <[^>]+> 7dc8      	lhu	s3,0\(a0\)
[0-9a-f]+ <[^>]+> 7dc8      	lhu	s3,0\(a0\)
[0-9a-f]+ <[^>]+> 7dcc      	lhu	s3,4\(a0\)
[0-9a-f]+ <[^>]+> 0064 7fff 	addiu	t5,a0,32767
[0-9a-f]+ <[^>]+> 8463 6000 	lhu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 6000 	lhu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> 0064 ffff 	addiu	t5,a0,65535
[0-9a-f]+ <[^>]+> 8463 6000 	lhu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 6000 	lhu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 6000 	lhu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 6001 	lhu	t5,1\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 6001 	lhu	t5,1\(t5\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	t5,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 6000 	lhu	t5,0\(t5\)
[0-9a-f]+ <[^>]+> a464 b0ff 	lhu	t5,-1\(a0\)
[0-9a-f]+ <[^>]+> e074 5244 	lui	t5,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 6678 	lhu	t5,1656\(t5\)
[0-9a-f]+ <[^>]+> a460 5100 	ll	t5,0\(zero\)
[0-9a-f]+ <[^>]+> a460 5100 	ll	t5,0\(zero\)
[0-9a-f]+ <[^>]+> a460 5104 	ll	t5,4\(zero\)
[0-9a-f]+ <[^>]+> a460 5104 	ll	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 0060 7fff 	li	t5,32767
[0-9a-f]+ <[^>]+> a463 5100 	ll	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> a463 5100 	ll	t5,0\(t5\)
[0-9a-f]+ <[^>]+> 0060 ffff 	li	t5,65535
[0-9a-f]+ <[^>]+> a463 5100 	ll	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> a463 5100 	ll	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> a463 5100 	ll	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> a463 5104 	ll	t5,4\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> a463 5104 	ll	t5,4\(t5\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	t5,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> a463 5100 	ll	t5,0\(t5\)
[0-9a-f]+ <[^>]+> 8060 8001 	li	t5,-1
[0-9a-f]+ <[^>]+> a463 5100 	ll	t5,0\(t5\)
[0-9a-f]+ <[^>]+> 6060 5678 1234 	li	t5,0x12345678
[0-9a-f]+ <[^>]+> a463 5100 	ll	t5,0\(t5\)
[0-9a-f]+ <[^>]+> a464 5100 	ll	t5,0\(a0\)
[0-9a-f]+ <[^>]+> a464 5100 	ll	t5,0\(a0\)
[0-9a-f]+ <[^>]+> a464 5104 	ll	t5,4\(a0\)
[0-9a-f]+ <[^>]+> 0064 7fff 	addiu	t5,a0,32767
[0-9a-f]+ <[^>]+> a463 5100 	ll	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> a463 5100 	ll	t5,0\(t5\)
[0-9a-f]+ <[^>]+> 0064 ffff 	addiu	t5,a0,65535
[0-9a-f]+ <[^>]+> a463 5100 	ll	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> a463 5100 	ll	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> a463 5100 	ll	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> a463 5104 	ll	t5,4\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> a463 5104 	ll	t5,4\(t5\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	t5,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> a463 5100 	ll	t5,0\(t5\)
[0-9a-f]+ <[^>]+> 8064 8001 	addiu	t5,a0,-1
[0-9a-f]+ <[^>]+> a463 5100 	ll	t5,0\(t5\)
[0-9a-f]+ <[^>]+> 6060 5678 1234 	li	t5,0x12345678
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> a463 5100 	ll	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e060 0000 	lui	t5,0x0
[0-9a-f]+ <[^>]+> e07f 0ffc 	lui	t5,%hi\(0x7fff0000\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 1540      	lw	s2,0\(a0\)
[0-9a-f]+ <[^>]+> 1540      	lw	s2,0\(a0\)
[0-9a-f]+ <[^>]+> 1541      	lw	s2,4\(a0\)
[0-9a-f]+ <[^>]+> 1542      	lw	s2,8\(a0\)
[0-9a-f]+ <[^>]+> 1543      	lw	s2,12\(a0\)
[0-9a-f]+ <[^>]+> 1544      	lw	s2,16\(a0\)
[0-9a-f]+ <[^>]+> 1545      	lw	s2,20\(a0\)
[0-9a-f]+ <[^>]+> 1546      	lw	s2,24\(a0\)
[0-9a-f]+ <[^>]+> 1547      	lw	s2,28\(a0\)
[0-9a-f]+ <[^>]+> 1548      	lw	s2,32\(a0\)
[0-9a-f]+ <[^>]+> 1549      	lw	s2,36\(a0\)
[0-9a-f]+ <[^>]+> 154a      	lw	s2,40\(a0\)
[0-9a-f]+ <[^>]+> 154b      	lw	s2,44\(a0\)
[0-9a-f]+ <[^>]+> 154c      	lw	s2,48\(a0\)
[0-9a-f]+ <[^>]+> 154d      	lw	s2,52\(a0\)
[0-9a-f]+ <[^>]+> 154e      	lw	s2,56\(a0\)
[0-9a-f]+ <[^>]+> 154f      	lw	s2,60\(a0\)
[0-9a-f]+ <[^>]+> 155f      	lw	s2,60\(a1\)
[0-9a-f]+ <[^>]+> 156f      	lw	s2,60\(a2\)
[0-9a-f]+ <[^>]+> 157f      	lw	s2,60\(a3\)
[0-9a-f]+ <[^>]+> 152f      	lw	s2,60\(s2\)
[0-9a-f]+ <[^>]+> 153f      	lw	s2,60\(s3\)
[0-9a-f]+ <[^>]+> 150f      	lw	s2,60\(s0\)
[0-9a-f]+ <[^>]+> 151f      	lw	s2,60\(s1\)
[0-9a-f]+ <[^>]+> 159f      	lw	s3,60\(s1\)
[0-9a-f]+ <[^>]+> 161f      	lw	a0,60\(s1\)
[0-9a-f]+ <[^>]+> 169f      	lw	a1,60\(s1\)
[0-9a-f]+ <[^>]+> 171f      	lw	a2,60\(s1\)
[0-9a-f]+ <[^>]+> 179f      	lw	a3,60\(s1\)
[0-9a-f]+ <[^>]+> 141f      	lw	s0,60\(s1\)
[0-9a-f]+ <[^>]+> 149f      	lw	s1,60\(s1\)
[0-9a-f]+ <[^>]+> 3480      	lw	a0,0\(sp\)
[0-9a-f]+ <[^>]+> 3480      	lw	a0,0\(sp\)
[0-9a-f]+ <[^>]+> 3481      	lw	a0,4\(sp\)
[0-9a-f]+ <[^>]+> 3482      	lw	a0,8\(sp\)
[0-9a-f]+ <[^>]+> 3483      	lw	a0,12\(sp\)
[0-9a-f]+ <[^>]+> 3484      	lw	a0,16\(sp\)
[0-9a-f]+ <[^>]+> 3485      	lw	a0,20\(sp\)
[0-9a-f]+ <[^>]+> 349f      	lw	a0,124\(sp\)
[0-9a-f]+ <[^>]+> 345f      	lw	t4,124\(sp\)
[0-9a-f]+ <[^>]+> 345f      	lw	t4,124\(sp\)
[0-9a-f]+ <[^>]+> 347f      	lw	t5,124\(sp\)
[0-9a-f]+ <[^>]+> 349f      	lw	a0,124\(sp\)
[0-9a-f]+ <[^>]+> 34bf      	lw	a1,124\(sp\)
[0-9a-f]+ <[^>]+> 34df      	lw	a2,124\(sp\)
[0-9a-f]+ <[^>]+> 34ff      	lw	a3,124\(sp\)
[0-9a-f]+ <[^>]+> 351f      	lw	a4,124\(sp\)
[0-9a-f]+ <[^>]+> 353f      	lw	a5,124\(sp\)
[0-9a-f]+ <[^>]+> 355f      	lw	a6,124\(sp\)
[0-9a-f]+ <[^>]+> 37df      	lw	fp,124\(sp\)
[0-9a-f]+ <[^>]+> 37ff      	lw	ra,124\(sp\)
[0-9a-f]+ <[^>]+> 849d 81f8 	lw	a0,504\(sp\)
[0-9a-f]+ <[^>]+> 849d 81fc 	lw	a0,508\(sp\)
[0-9a-f]+ <[^>]+> 861d 81fc 	lw	s0,508\(sp\)
[0-9a-f]+ <[^>]+> 863d 81fc 	lw	s1,508\(sp\)
[0-9a-f]+ <[^>]+> 865d 81fc 	lw	s2,508\(sp\)
[0-9a-f]+ <[^>]+> 867d 81fc 	lw	s3,508\(sp\)
[0-9a-f]+ <[^>]+> 869d 81fc 	lw	s4,508\(sp\)
[0-9a-f]+ <[^>]+> 86bd 81fc 	lw	s5,508\(sp\)
[0-9a-f]+ <[^>]+> 87fd 81fc 	lw	ra,508\(sp\)
[0-9a-f]+ <[^>]+> 8460 8000 	lw	t5,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 8004 	lw	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 8000 	lw	t5,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 8000 	lw	t5,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 8000 	lw	t5,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 8004 	lw	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 0060 7fff 	li	t5,32767
[0-9a-f]+ <[^>]+> 8463 8000 	lw	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8463 8000 	lw	t5,0\(t5\)
[0-9a-f]+ <[^>]+> 0060 ffff 	li	t5,65535
[0-9a-f]+ <[^>]+> 8463 8000 	lw	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8463 8000 	lw	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8463 8000 	lw	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8463 8001 	lw	t5,1\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8463 8001 	lw	t5,1\(t5\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	t5,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 8463 8000 	lw	t5,0\(t5\)
[0-9a-f]+ <[^>]+> a460 c0ff 	lw	t5,-1\(zero\)
[0-9a-f]+ <[^>]+> e074 5244 	lui	t5,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 8463 8678 	lw	t5,1656\(t5\)
[0-9a-f]+ <[^>]+> 15c0      	lw	s3,0\(a0\)
[0-9a-f]+ <[^>]+> 15c0      	lw	s3,0\(a0\)
[0-9a-f]+ <[^>]+> 15c1      	lw	s3,4\(a0\)
[0-9a-f]+ <[^>]+> 0064 7fff 	addiu	t5,a0,32767
[0-9a-f]+ <[^>]+> 8463 8000 	lw	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 8000 	lw	t5,0\(t5\)
[0-9a-f]+ <[^>]+> 0064 ffff 	addiu	t5,a0,65535
[0-9a-f]+ <[^>]+> 8463 8000 	lw	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 8000 	lw	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 8000 	lw	t5,0\(t5\)
[0-9a-f]+ <[^>]+> e07f 0ffd 	lui	t5,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 8001 	lw	t5,1\(t5\)
[0-9a-f]+ <[^>]+> e07f 8ffd 	lui	t5,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 8001 	lw	t5,1\(t5\)
[0-9a-f]+ <[^>]+> e060 0e01 	lui	t5,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 8000 	lw	t5,0\(t5\)
[0-9a-f]+ <[^>]+> a464 c0ff 	lw	t5,-1\(a0\)
[0-9a-f]+ <[^>]+> e074 5244 	lui	t5,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 2083 1950 	addu	t5,t5,a0
[0-9a-f]+ <[^>]+> 8463 8678 	lw	t5,1656\(t5\)
[0-9a-f]+ <[^>]+> 52c7      	lwxs	s3,a0\(a1\)
[0-9a-f]+ <[^>]+> 2040 0030 	mfc0	t4,c0_index
[0-9a-f]+ <[^>]+> 2041 0030 	mfc0	t4,c0_random
[0-9a-f]+ <[^>]+> 2042 0030 	mfc0	t4,c0_entrylo0
[0-9a-f]+ <[^>]+> 2043 0030 	mfc0	t4,c0_entrylo1
[0-9a-f]+ <[^>]+> 2044 0030 	mfc0	t4,c0_context
[0-9a-f]+ <[^>]+> 2045 0030 	mfc0	t4,c0_pagemask
[0-9a-f]+ <[^>]+> 2046 0030 	mfc0	t4,c0_wired
[0-9a-f]+ <[^>]+> 2047 0030 	mfc0	t4,c0_hwrena
[0-9a-f]+ <[^>]+> 2048 0030 	mfc0	t4,c0_badvaddr
[0-9a-f]+ <[^>]+> 2049 0030 	mfc0	t4,c0_count
[0-9a-f]+ <[^>]+> 204a 0030 	mfc0	t4,c0_entryhi
[0-9a-f]+ <[^>]+> 204b 0030 	mfc0	t4,c0_compare
[0-9a-f]+ <[^>]+> 204c 0030 	mfc0	t4,c0_status
[0-9a-f]+ <[^>]+> 204d 0030 	mfc0	t4,c0_cause
[0-9a-f]+ <[^>]+> 204e 0030 	mfc0	t4,c0_epc
[0-9a-f]+ <[^>]+> 204f 0030 	mfc0	t4,c0_prid
[0-9a-f]+ <[^>]+> 2050 0030 	mfc0	t4,c0_config
[0-9a-f]+ <[^>]+> 2051 0030 	mfc0	t4,c0_lladdr
[0-9a-f]+ <[^>]+> 2052 0030 	mfc0	t4,c0_watchlo
[0-9a-f]+ <[^>]+> 2053 0030 	mfc0	t4,c0_watchhi
[0-9a-f]+ <[^>]+> 2054 0030 	mfc0	t4,c0_xcontext
[0-9a-f]+ <[^>]+> 2055 0030 	mfc0	t4,\$21
[0-9a-f]+ <[^>]+> 2056 0030 	mfc0	t4,\$22
[0-9a-f]+ <[^>]+> 2057 0030 	mfc0	t4,c0_debug
[0-9a-f]+ <[^>]+> 2058 0030 	mfc0	t4,c0_depc
[0-9a-f]+ <[^>]+> 2059 0030 	mfc0	t4,c0_perfcnt
[0-9a-f]+ <[^>]+> 205a 0030 	mfc0	t4,c0_errctl
[0-9a-f]+ <[^>]+> 205b 0030 	mfc0	t4,c0_cacheerr
[0-9a-f]+ <[^>]+> 205c 0030 	mfc0	t4,c0_taglo
[0-9a-f]+ <[^>]+> 205d 0030 	mfc0	t4,c0_taghi
[0-9a-f]+ <[^>]+> 205e 0030 	mfc0	t4,c0_errorepc
[0-9a-f]+ <[^>]+> 205f 0030 	mfc0	t4,c0_desave
[0-9a-f]+ <[^>]+> 2040 0030 	mfc0	t4,c0_index
[0-9a-f]+ <[^>]+> 2040 0830 	mfc0	t4,c0_mvpcontrol
[0-9a-f]+ <[^>]+> 2040 1030 	mfc0	t4,c0_mvpconf0
[0-9a-f]+ <[^>]+> 2040 1830 	mfc0	t4,c0_mvpconf1
[0-9a-f]+ <[^>]+> 2040 2030 	mfc0	t4,\$0,4
[0-9a-f]+ <[^>]+> 2040 2830 	mfc0	t4,\$0,5
[0-9a-f]+ <[^>]+> 2040 3030 	mfc0	t4,\$0,6
[0-9a-f]+ <[^>]+> 2040 3830 	mfc0	t4,\$0,7
[0-9a-f]+ <[^>]+> 2041 0030 	mfc0	t4,c0_random
[0-9a-f]+ <[^>]+> 2041 0830 	mfc0	t4,c0_vpecontrol
[0-9a-f]+ <[^>]+> 2041 1030 	mfc0	t4,c0_vpeconf0
[0-9a-f]+ <[^>]+> 2041 1830 	mfc0	t4,c0_vpeconf1
[0-9a-f]+ <[^>]+> 2041 2030 	mfc0	t4,c0_yqmask
[0-9a-f]+ <[^>]+> 2041 2830 	mfc0	t4,c0_vpeschedule
[0-9a-f]+ <[^>]+> 2041 3030 	mfc0	t4,c0_vpeschefback
[0-9a-f]+ <[^>]+> 2041 3830 	mfc0	t4,\$1,7
[0-9a-f]+ <[^>]+> 2042 0030 	mfc0	t4,c0_entrylo0
[0-9a-f]+ <[^>]+> 2042 0830 	mfc0	t4,c0_tcstatus
[0-9a-f]+ <[^>]+> 2042 1030 	mfc0	t4,c0_tcbind
[0-9a-f]+ <[^>]+> 2042 1830 	mfc0	t4,c0_tcrestart
[0-9a-f]+ <[^>]+> 2042 2030 	mfc0	t4,c0_tchalt
[0-9a-f]+ <[^>]+> 2042 2830 	mfc0	t4,c0_tccontext
[0-9a-f]+ <[^>]+> 2042 3030 	mfc0	t4,c0_tcschedule
[0-9a-f]+ <[^>]+> 2042 3830 	mfc0	t4,c0_tcschefback
[0-9a-f]+ <[^>]+> 2062 1610 	movn	t4,t4,t5
[0-9a-f]+ <[^>]+> 2062 1610 	movn	t4,t4,t5
[0-9a-f]+ <[^>]+> 2083 1610 	movn	t4,t5,a0
[0-9a-f]+ <[^>]+> 2062 1210 	movz	t4,t4,t5
[0-9a-f]+ <[^>]+> 2062 1210 	movz	t4,t4,t5
[0-9a-f]+ <[^>]+> 2083 1210 	movz	t4,t5,a0
[0-9a-f]+ <[^>]+> 2040 0070 	mtc0	t4,c0_index
[0-9a-f]+ <[^>]+> 2041 0070 	mtc0	t4,c0_random
[0-9a-f]+ <[^>]+> 2042 0070 	mtc0	t4,c0_entrylo0
[0-9a-f]+ <[^>]+> 2043 0070 	mtc0	t4,c0_entrylo1
[0-9a-f]+ <[^>]+> 2044 0070 	mtc0	t4,c0_context
[0-9a-f]+ <[^>]+> 2045 0070 	mtc0	t4,c0_pagemask
[0-9a-f]+ <[^>]+> 2046 0070 	mtc0	t4,c0_wired
[0-9a-f]+ <[^>]+> 2047 0070 	mtc0	t4,c0_hwrena
[0-9a-f]+ <[^>]+> 2048 0070 	mtc0	t4,c0_badvaddr
[0-9a-f]+ <[^>]+> 2049 0070 	mtc0	t4,c0_count
[0-9a-f]+ <[^>]+> 204a 0070 	mtc0	t4,c0_entryhi
[0-9a-f]+ <[^>]+> 204b 0070 	mtc0	t4,c0_compare
[0-9a-f]+ <[^>]+> 204c 0070 	mtc0	t4,c0_status
[0-9a-f]+ <[^>]+> 204d 0070 	mtc0	t4,c0_cause
[0-9a-f]+ <[^>]+> 204e 0070 	mtc0	t4,c0_epc
[0-9a-f]+ <[^>]+> 204f 0070 	mtc0	t4,c0_prid
[0-9a-f]+ <[^>]+> 2050 0070 	mtc0	t4,c0_config
[0-9a-f]+ <[^>]+> 2051 0070 	mtc0	t4,c0_lladdr
[0-9a-f]+ <[^>]+> 2052 0070 	mtc0	t4,c0_watchlo
[0-9a-f]+ <[^>]+> 2053 0070 	mtc0	t4,c0_watchhi
[0-9a-f]+ <[^>]+> 2054 0070 	mtc0	t4,c0_xcontext
[0-9a-f]+ <[^>]+> 2055 0070 	mtc0	t4,\$21
[0-9a-f]+ <[^>]+> 2056 0070 	mtc0	t4,\$22
[0-9a-f]+ <[^>]+> 2057 0070 	mtc0	t4,c0_debug
[0-9a-f]+ <[^>]+> 2058 0070 	mtc0	t4,c0_depc
[0-9a-f]+ <[^>]+> 2059 0070 	mtc0	t4,c0_perfcnt
[0-9a-f]+ <[^>]+> 205a 0070 	mtc0	t4,c0_errctl
[0-9a-f]+ <[^>]+> 205b 0070 	mtc0	t4,c0_cacheerr
[0-9a-f]+ <[^>]+> 205c 0070 	mtc0	t4,c0_taglo
[0-9a-f]+ <[^>]+> 205d 0070 	mtc0	t4,c0_taghi
[0-9a-f]+ <[^>]+> 205e 0070 	mtc0	t4,c0_errorepc
[0-9a-f]+ <[^>]+> 205f 0070 	mtc0	t4,c0_desave
[0-9a-f]+ <[^>]+> 2040 0070 	mtc0	t4,c0_index
[0-9a-f]+ <[^>]+> 2040 0870 	mtc0	t4,c0_mvpcontrol
[0-9a-f]+ <[^>]+> 2040 1070 	mtc0	t4,c0_mvpconf0
[0-9a-f]+ <[^>]+> 2040 1870 	mtc0	t4,c0_mvpconf1
[0-9a-f]+ <[^>]+> 2040 2070 	mtc0	t4,\$0,4
[0-9a-f]+ <[^>]+> 2040 2870 	mtc0	t4,\$0,5
[0-9a-f]+ <[^>]+> 2040 3070 	mtc0	t4,\$0,6
[0-9a-f]+ <[^>]+> 2040 3870 	mtc0	t4,\$0,7
[0-9a-f]+ <[^>]+> 2041 0070 	mtc0	t4,c0_random
[0-9a-f]+ <[^>]+> 2041 0870 	mtc0	t4,c0_vpecontrol
[0-9a-f]+ <[^>]+> 2041 1070 	mtc0	t4,c0_vpeconf0
[0-9a-f]+ <[^>]+> 2041 1870 	mtc0	t4,c0_vpeconf1
[0-9a-f]+ <[^>]+> 2041 2070 	mtc0	t4,c0_yqmask
[0-9a-f]+ <[^>]+> 2041 2870 	mtc0	t4,c0_vpeschedule
[0-9a-f]+ <[^>]+> 2041 3070 	mtc0	t4,c0_vpeschefback
[0-9a-f]+ <[^>]+> 2041 3870 	mtc0	t4,\$1,7
[0-9a-f]+ <[^>]+> 2042 0070 	mtc0	t4,c0_entrylo0
[0-9a-f]+ <[^>]+> 2042 0870 	mtc0	t4,c0_tcstatus
[0-9a-f]+ <[^>]+> 2042 1070 	mtc0	t4,c0_tcbind
[0-9a-f]+ <[^>]+> 2042 1870 	mtc0	t4,c0_tcrestart
[0-9a-f]+ <[^>]+> 2042 2070 	mtc0	t4,c0_tchalt
[0-9a-f]+ <[^>]+> 2042 2870 	mtc0	t4,c0_tccontext
[0-9a-f]+ <[^>]+> 2042 3070 	mtc0	t4,c0_tcschedule
[0-9a-f]+ <[^>]+> 2042 3870 	mtc0	t4,c0_tcschefback
[0-9a-f]+ <[^>]+> 2083 1018 	mul	t4,t5,a0
[0-9a-f]+ <[^>]+> 23fe e818 	mul	sp,fp,ra
[0-9a-f]+ <[^>]+> 2082 1018 	mul	t4,t4,a0
[0-9a-f]+ <[^>]+> 2082 1018 	mul	t4,t4,a0
[0-9a-f]+ <[^>]+> 0020 0000 	li	at,0
[0-9a-f]+ <[^>]+> 2022 1018 	mul	t4,t4,at
[0-9a-f]+ <[^>]+> 0020 0001 	li	at,1
[0-9a-f]+ <[^>]+> 2022 1018 	mul	t4,t4,at
[0-9a-f]+ <[^>]+> 0020 7fff 	li	at,32767
[0-9a-f]+ <[^>]+> 2022 1018 	mul	t4,t4,at
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2022 1018 	mul	t4,t4,at
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> 2022 1018 	mul	t4,t4,at
[0-9a-f]+ <[^>]+> 2060 1190 	neg	t4,t5
[0-9a-f]+ <[^>]+> 2040 1190 	neg	t4,t4
[0-9a-f]+ <[^>]+> 2040 1190 	neg	t4,t4
[0-9a-f]+ <[^>]+> 2060 11d0 	negu	t4,t5
[0-9a-f]+ <[^>]+> 2040 11d0 	negu	t4,t4
[0-9a-f]+ <[^>]+> 2040 11d0 	negu	t4,t4
[0-9a-f]+ <[^>]+> 2060 11d0 	negu	t4,t5
[0-9a-f]+ <[^>]+> 2040 11d0 	negu	t4,t4
[0-9a-f]+ <[^>]+> 2040 11d0 	negu	t4,t4
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
[0-9a-f]+ <[^>]+> 2007 12d0 	not	t4,a3
[0-9a-f]+ <[^>]+> 20e0 12d0 	nor	t4,zero,a3
[0-9a-f]+ <[^>]+> 2083 12d0 	nor	t4,t5,a0
[0-9a-f]+ <[^>]+> 23fe ead0 	nor	sp,fp,ra
[0-9a-f]+ <[^>]+> 2082 12d0 	nor	t4,t4,a0
[0-9a-f]+ <[^>]+> 2082 12d0 	nor	t4,t4,a0
[0-9a-f]+ <[^>]+> 0020 8000 	li	at,32768
[0-9a-f]+ <[^>]+> 2023 12d0 	nor	t4,t5,at
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> 2023 12d0 	nor	t4,t5,at
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> 2023 12d0 	nor	t4,t5,at
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2023 12d0 	nor	t4,t5,at
[0-9a-f]+ <[^>]+> 6020 7fff ffff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2023 12d0 	nor	t4,t5,at
[0-9a-f]+ <[^>]+> 2016 1290 	move	t4,s6
[0-9a-f]+ <[^>]+> 2002 b290 	move	s6,t4
[0-9a-f]+ <[^>]+> 22c0 1290 	or	t4,zero,s6
[0-9a-f]+ <[^>]+> 2040 b290 	or	s6,zero,t4
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
[0-9a-f]+ <[^>]+> 2083 1290 	or	t4,t5,a0
[0-9a-f]+ <[^>]+> 23fe ea90 	or	sp,fp,ra
[0-9a-f]+ <[^>]+> 2082 1290 	or	t4,t4,a0
[0-9a-f]+ <[^>]+> 2082 1290 	or	t4,t4,a0
[0-9a-f]+ <[^>]+> 0020 8000 	li	at,32768
[0-9a-f]+ <[^>]+> 2023 1290 	or	t4,t5,at
[0-9a-f]+ <[^>]+> 8043 0fff 	ori	t4,t5,4095
[0-9a-f]+ <[^>]+> 0020 1000 	li	at,4096
[0-9a-f]+ <[^>]+> 2023 1290 	or	t4,t5,at
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2023 1290 	or	t4,t5,at
[0-9a-f]+ <[^>]+> 6020 7fff ffff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2023 1290 	or	t4,t5,at
[0-9a-f]+ <[^>]+> 8064 0000 	ori	t5,a0,0
[0-9a-f]+ <[^>]+> 8064 0fff 	ori	t5,a0,4095
[0-9a-f]+ <[^>]+> 2040 01c0 	rdhwr	t4,hwr_cpunum
[0-9a-f]+ <[^>]+> 2041 01c0 	rdhwr	t4,hwr_synci_step
[0-9a-f]+ <[^>]+> 2042 01c0 	rdhwr	t4,hwr_cc
[0-9a-f]+ <[^>]+> 2043 01c0 	rdhwr	t4,hwr_ccres
[0-9a-f]+ <[^>]+> 2044 01c0 	rdhwr	t4,\$4
[0-9a-f]+ <[^>]+> 2045 01c0 	rdhwr	t4,\$5
[0-9a-f]+ <[^>]+> 2046 01c0 	rdhwr	t4,\$6
[0-9a-f]+ <[^>]+> 2047 01c0 	rdhwr	t4,\$7
[0-9a-f]+ <[^>]+> 2048 01c0 	rdhwr	t4,\$8
[0-9a-f]+ <[^>]+> 2049 01c0 	rdhwr	t4,\$9
[0-9a-f]+ <[^>]+> 204a 01c0 	rdhwr	t4,\$10
[0-9a-f]+ <[^>]+> 2043 e17f 	rdpgpr	t4,t5
[0-9a-f]+ <[^>]+> 2042 e17f 	rdpgpr	t4,t4
[0-9a-f]+ <[^>]+> 2062 0158 	mod	zero,t4,t5
[0-9a-f]+ <[^>]+> 23fe 0158 	mod	zero,fp,ra
[0-9a-f]+ <[^>]+> 2060 0158 	mod	zero,zero,t5
[0-9a-f]+ <[^>]+> 23e0 0158 	mod	zero,zero,ra
[0-9a-f]+ <[^>]+> 2003 1158 	mod	t4,t5,zero
[0-9a-f]+ <[^>]+> 2083 1158 	mod	t4,t5,a0
[0-9a-f]+ <[^>]+> 1017      	break	0x7
[0-9a-f]+ <[^>]+> 1060      	move	t5,zero
[0-9a-f]+ <[^>]+> 1060      	move	t5,zero
[0-9a-f]+ <[^>]+> 0020 0002 	li	at,2
[0-9a-f]+ <[^>]+> 2024 1958 	mod	t5,a0,at
[0-9a-f]+ <[^>]+> 2080 11d0 	negu	t4,a0
[0-9a-f]+ <[^>]+> 2043 10d0 	rotrv	t4,t5,t4
[0-9a-f]+ <[^>]+> 2080 09d0 	negu	at,a0
[0-9a-f]+ <[^>]+> 2022 10d0 	rotrv	t4,t4,at
[0-9a-f]+ <[^>]+> 2060 11d0 	negu	t4,t5
[0-9a-f]+ <[^>]+> 2043 10d0 	rotrv	t4,t5,t4
[0-9a-f]+ <[^>]+> 2040 11d0 	negu	t4,t4
[0-9a-f]+ <[^>]+> 2043 10d0 	rotrv	t4,t5,t4
[0-9a-f]+ <[^>]+> 8043 c0c0 	rotr	t4,t5,0x0
[0-9a-f]+ <[^>]+> 8043 c0df 	rotr	t4,t5,0x1f
[0-9a-f]+ <[^>]+> 8043 c0c1 	rotr	t4,t5,0x1
[0-9a-f]+ <[^>]+> 8042 c0c1 	rotr	t4,t4,0x1
[0-9a-f]+ <[^>]+> 8042 c0c1 	rotr	t4,t4,0x1
[0-9a-f]+ <[^>]+> 8043 c0c0 	rotr	t4,t5,0x0
[0-9a-f]+ <[^>]+> 8043 c0c1 	rotr	t4,t5,0x1
[0-9a-f]+ <[^>]+> 8043 c0df 	rotr	t4,t5,0x1f
[0-9a-f]+ <[^>]+> 8042 c0df 	rotr	t4,t4,0x1f
[0-9a-f]+ <[^>]+> 8042 c0df 	rotr	t4,t4,0x1f
[0-9a-f]+ <[^>]+> 2083 10d0 	rotrv	t4,t5,a0
[0-9a-f]+ <[^>]+> 2082 10d0 	rotrv	t4,t4,a0
[0-9a-f]+ <[^>]+> 2083 10d0 	rotrv	t4,t5,a0
[0-9a-f]+ <[^>]+> 2082 10d0 	rotrv	t4,t4,a0
[0-9a-f]+ <[^>]+> 2083 10d0 	rotrv	t4,t5,a0
[0-9a-f]+ <[^>]+> 2082 10d0 	rotrv	t4,t4,a0
[0-9a-f]+ <[^>]+> 2083 10d0 	rotrv	t4,t5,a0
[0-9a-f]+ <[^>]+> 2082 10d0 	rotrv	t4,t4,a0
[0-9a-f]+ <[^>]+> 5c34      	sb	zero,0\(s3\)
[0-9a-f]+ <[^>]+> 5c34      	sb	zero,0\(s3\)
[0-9a-f]+ <[^>]+> 5c35      	sb	zero,1\(s3\)
[0-9a-f]+ <[^>]+> 5c36      	sb	zero,2\(s3\)
[0-9a-f]+ <[^>]+> 5c37      	sb	zero,3\(s3\)
[0-9a-f]+ <[^>]+> 8403 1004 	sb	zero,4\(t5\)
[0-9a-f]+ <[^>]+> 8403 1005 	sb	zero,5\(t5\)
[0-9a-f]+ <[^>]+> 8403 1006 	sb	zero,6\(t5\)
[0-9a-f]+ <[^>]+> 8403 1007 	sb	zero,7\(t5\)
[0-9a-f]+ <[^>]+> 8403 1008 	sb	zero,8\(t5\)
[0-9a-f]+ <[^>]+> 8403 1009 	sb	zero,9\(t5\)
[0-9a-f]+ <[^>]+> 8403 100a 	sb	zero,10\(t5\)
[0-9a-f]+ <[^>]+> 8403 100b 	sb	zero,11\(t5\)
[0-9a-f]+ <[^>]+> 8403 100c 	sb	zero,12\(t5\)
[0-9a-f]+ <[^>]+> 8403 100d 	sb	zero,13\(t5\)
[0-9a-f]+ <[^>]+> 8403 100e 	sb	zero,14\(t5\)
[0-9a-f]+ <[^>]+> 8403 100f 	sb	zero,15\(t5\)
[0-9a-f]+ <[^>]+> 8443 100f 	sb	t4,15\(t5\)
[0-9a-f]+ <[^>]+> 8463 100f 	sb	t5,15\(t5\)
[0-9a-f]+ <[^>]+> 8483 100f 	sb	a0,15\(t5\)
[0-9a-f]+ <[^>]+> 84a3 100f 	sb	a1,15\(t5\)
[0-9a-f]+ <[^>]+> 84c3 100f 	sb	a2,15\(t5\)
[0-9a-f]+ <[^>]+> 84e3 100f 	sb	a3,15\(t5\)
[0-9a-f]+ <[^>]+> 8623 100f 	sb	s1,15\(t5\)
[0-9a-f]+ <[^>]+> 8624 100f 	sb	s1,15\(a0\)
[0-9a-f]+ <[^>]+> 8625 100f 	sb	s1,15\(a1\)
[0-9a-f]+ <[^>]+> 8626 100f 	sb	s1,15\(a2\)
[0-9a-f]+ <[^>]+> 8627 100f 	sb	s1,15\(a3\)
[0-9a-f]+ <[^>]+> 8622 100f 	sb	s1,15\(t4\)
[0-9a-f]+ <[^>]+> 8630 100f 	sb	s1,15\(s0\)
[0-9a-f]+ <[^>]+> 8631 100f 	sb	s1,15\(s1\)
[0-9a-f]+ <[^>]+> 8460 1004 	sb	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 1004 	sb	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 1fff 	sb	t5,4095\(zero\)
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> 8461 1000 	sb	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8461 1000 	sb	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8461 1000 	sb	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8461 1001 	sb	t5,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8461 1001 	sb	t5,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 8461 1000 	sb	t5,0\(at\)
[0-9a-f]+ <[^>]+> a460 88ff 	sb	t5,-1\(zero\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 8461 1678 	sb	t5,1656\(at\)
[0-9a-f]+ <[^>]+> 8464 1000 	sb	t5,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 1000 	sb	t5,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 1fff 	sb	t5,4095\(a0\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> 8461 1000 	sb	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 1000 	sb	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 1000 	sb	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 1001 	sb	t5,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 1001 	sb	t5,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 1000 	sb	t5,0\(at\)
[0-9a-f]+ <[^>]+> a464 88ff 	sb	t5,-1\(a0\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 1678 	sb	t5,1656\(at\)
[0-9a-f]+ <[^>]+> a460 5904 	sc	t5,4\(zero\)
[0-9a-f]+ <[^>]+> a460 5904 	sc	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 0020 07ff 	li	at,2047
[0-9a-f]+ <[^>]+> a461 5900 	sc	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8020 8800 	li	at,-2048
[0-9a-f]+ <[^>]+> a461 5900 	sc	t5,0\(at\)
[0-9a-f]+ <[^>]+> 0020 7fff 	li	at,32767
[0-9a-f]+ <[^>]+> a461 5900 	sc	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> a461 5900 	sc	t5,0\(at\)
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> a461 5900 	sc	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> a461 5900 	sc	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> a461 5900 	sc	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> a461 5904 	sc	t5,4\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> a461 5904 	sc	t5,4\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> a461 5900 	sc	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8020 8001 	li	at,-1
[0-9a-f]+ <[^>]+> a461 5900 	sc	t5,0\(at\)
[0-9a-f]+ <[^>]+> 6020 5678 1234 	li	at,0x12345678
[0-9a-f]+ <[^>]+> a461 5900 	sc	t5,0\(at\)
[0-9a-f]+ <[^>]+> a464 5900 	sc	t5,0\(a0\)
[0-9a-f]+ <[^>]+> a464 5900 	sc	t5,0\(a0\)
[0-9a-f]+ <[^>]+> 0024 07ff 	addiu	at,a0,2047
[0-9a-f]+ <[^>]+> a461 5900 	sc	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8024 8800 	addiu	at,a0,-2048
[0-9a-f]+ <[^>]+> a461 5900 	sc	t5,0\(at\)
[0-9a-f]+ <[^>]+> 0024 7fff 	addiu	at,a0,32767
[0-9a-f]+ <[^>]+> a461 5900 	sc	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 5900 	sc	t5,0\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> a461 5900 	sc	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 5900 	sc	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 5900 	sc	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 5904 	sc	t5,4\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 5904 	sc	t5,4\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 5900 	sc	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8024 8001 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> a461 5900 	sc	t5,0\(at\)
[0-9a-f]+ <[^>]+> 6020 5678 1234 	li	at,0x12345678
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 5900 	sc	t5,0\(at\)
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
[0-9a-f]+ <[^>]+> 2043 0008 	seb	t4,t5
[0-9a-f]+ <[^>]+> 2042 0008 	seb	t4,t4
[0-9a-f]+ <[^>]+> 2042 0008 	seb	t4,t4
[0-9a-f]+ <[^>]+> 2043 0048 	seh	t4,t5
[0-9a-f]+ <[^>]+> 2042 0048 	seh	t4,t4
[0-9a-f]+ <[^>]+> 2042 0048 	seh	t4,t4
[0-9a-f]+ <[^>]+> 2083 1310 	xor	t4,t5,a0
[0-9a-f]+ <[^>]+> 8042 5001 	sltiu	t4,t4,1
[0-9a-f]+ <[^>]+> 8043 5001 	sltiu	t4,t5,1
[0-9a-f]+ <[^>]+> 8044 5001 	sltiu	t4,a0,1
[0-9a-f]+ <[^>]+> 8043 5001 	sltiu	t4,t5,1
[0-9a-f]+ <[^>]+> 8043 6001 	seqi	t4,t5,1
[0-9a-f]+ <[^>]+> 0043 0001 	addiu	t4,t5,1
[0-9a-f]+ <[^>]+> 8042 5001 	sltiu	t4,t4,1
[0-9a-f]+ <[^>]+> 0043 8001 	addiu	t4,t5,32769
[0-9a-f]+ <[^>]+> 8042 5001 	sltiu	t4,t4,1
[0-9a-f]+ <[^>]+> 2083 1350 	slt	t4,t5,a0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 2082 1350 	slt	t4,t4,a0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 2082 1350 	slt	t4,t4,a0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 8043 4000 	slti	t4,t5,0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2023 1350 	slt	t4,t5,at
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 8043 4000 	slti	t4,t5,0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 0020 7fff 	li	at,32767
[0-9a-f]+ <[^>]+> 2023 1350 	slt	t4,t5,at
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> 2023 1350 	slt	t4,t5,at
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> 2023 1350 	slt	t4,t5,at
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 6020 7fff ffff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2023 1350 	slt	t4,t5,at
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 2083 1390 	sltu	t4,t5,a0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 2082 1390 	sltu	t4,t4,a0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 2082 1390 	sltu	t4,t4,a0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 8043 5000 	sltiu	t4,t5,0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2023 1390 	sltu	t4,t5,at
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 8043 5000 	sltiu	t4,t5,0
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 0020 7fff 	li	at,32767
[0-9a-f]+ <[^>]+> 2023 1390 	sltu	t4,t5,at
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> 2023 1390 	sltu	t4,t5,at
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> 2023 1390 	sltu	t4,t5,at
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 6020 7fff ffff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2023 1390 	sltu	t4,t5,at
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 2064 1350 	slt	t4,a0,t5
[0-9a-f]+ <[^>]+> 2044 1350 	slt	t4,a0,t4
[0-9a-f]+ <[^>]+> 2044 1350 	slt	t4,a0,t4
[0-9a-f]+ <[^>]+> 0020 0000 	li	at,0
[0-9a-f]+ <[^>]+> 2061 1350 	slt	t4,at,t5
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2061 1350 	slt	t4,at,t5
[0-9a-f]+ <[^>]+> 0020 0000 	li	at,0
[0-9a-f]+ <[^>]+> 2061 1350 	slt	t4,at,t5
[0-9a-f]+ <[^>]+> 0020 7fff 	li	at,32767
[0-9a-f]+ <[^>]+> 2061 1350 	slt	t4,at,t5
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> 2061 1350 	slt	t4,at,t5
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> 2061 1350 	slt	t4,at,t5
[0-9a-f]+ <[^>]+> 6020 7fff ffff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2061 1350 	slt	t4,at,t5
[0-9a-f]+ <[^>]+> 2064 1390 	sltu	t4,a0,t5
[0-9a-f]+ <[^>]+> 2044 1390 	sltu	t4,a0,t4
[0-9a-f]+ <[^>]+> 2044 1390 	sltu	t4,a0,t4
[0-9a-f]+ <[^>]+> 0020 0000 	li	at,0
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	t4,at,t5
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	t4,at,t5
[0-9a-f]+ <[^>]+> 0020 0000 	li	at,0
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	t4,at,t5
[0-9a-f]+ <[^>]+> 0020 7fff 	li	at,32767
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	t4,at,t5
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	t4,at,t5
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	t4,at,t5
[0-9a-f]+ <[^>]+> 6020 7fff ffff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	t4,at,t5
[0-9a-f]+ <[^>]+> 7d31      	sh	s2,0\(s3\)
[0-9a-f]+ <[^>]+> 7d31      	sh	s2,0\(s3\)
[0-9a-f]+ <[^>]+> 7d33      	sh	s2,2\(s3\)
[0-9a-f]+ <[^>]+> 7d35      	sh	s2,4\(s3\)
[0-9a-f]+ <[^>]+> 7d37      	sh	s2,6\(s3\)
[0-9a-f]+ <[^>]+> 8443 5008 	sh	t4,8\(t5\)
[0-9a-f]+ <[^>]+> 8443 500a 	sh	t4,10\(t5\)
[0-9a-f]+ <[^>]+> 8443 500c 	sh	t4,12\(t5\)
[0-9a-f]+ <[^>]+> 8443 500e 	sh	t4,14\(t5\)
[0-9a-f]+ <[^>]+> 8443 5010 	sh	t4,16\(t5\)
[0-9a-f]+ <[^>]+> 8443 5012 	sh	t4,18\(t5\)
[0-9a-f]+ <[^>]+> 8443 5014 	sh	t4,20\(t5\)
[0-9a-f]+ <[^>]+> 8443 5016 	sh	t4,22\(t5\)
[0-9a-f]+ <[^>]+> 8443 5018 	sh	t4,24\(t5\)
[0-9a-f]+ <[^>]+> 8443 501a 	sh	t4,26\(t5\)
[0-9a-f]+ <[^>]+> 8443 501c 	sh	t4,28\(t5\)
[0-9a-f]+ <[^>]+> 8443 501e 	sh	t4,30\(t5\)
[0-9a-f]+ <[^>]+> 8444 501e 	sh	t4,30\(a0\)
[0-9a-f]+ <[^>]+> 8445 501e 	sh	t4,30\(a1\)
[0-9a-f]+ <[^>]+> 8446 501e 	sh	t4,30\(a2\)
[0-9a-f]+ <[^>]+> 8447 501e 	sh	t4,30\(a3\)
[0-9a-f]+ <[^>]+> 8442 501e 	sh	t4,30\(t4\)
[0-9a-f]+ <[^>]+> 8450 501e 	sh	t4,30\(s0\)
[0-9a-f]+ <[^>]+> 8451 501e 	sh	t4,30\(s1\)
[0-9a-f]+ <[^>]+> 8471 501e 	sh	t5,30\(s1\)
[0-9a-f]+ <[^>]+> 8491 501e 	sh	a0,30\(s1\)
[0-9a-f]+ <[^>]+> 84b1 501e 	sh	a1,30\(s1\)
[0-9a-f]+ <[^>]+> 84d1 501e 	sh	a2,30\(s1\)
[0-9a-f]+ <[^>]+> 84f1 501e 	sh	a3,30\(s1\)
[0-9a-f]+ <[^>]+> 8631 501e 	sh	s1,30\(s1\)
[0-9a-f]+ <[^>]+> 8411 501e 	sh	zero,30\(s1\)
[0-9a-f]+ <[^>]+> 8460 5004 	sh	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 5004 	sh	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 5fff 	sh	t5,4095\(zero\)
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> 8461 5000 	sh	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8461 5000 	sh	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8461 5000 	sh	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8461 5001 	sh	t5,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8461 5001 	sh	t5,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 8461 5000 	sh	t5,0\(at\)
[0-9a-f]+ <[^>]+> a460 a8ff 	sh	t5,-1\(zero\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 8461 5678 	sh	t5,1656\(at\)
[0-9a-f]+ <[^>]+> 8464 5000 	sh	t5,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 5000 	sh	t5,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 5fff 	sh	t5,4095\(a0\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> 8461 5000 	sh	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5000 	sh	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5000 	sh	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5001 	sh	t5,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5001 	sh	t5,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5000 	sh	t5,0\(at\)
[0-9a-f]+ <[^>]+> a464 a8ff 	sh	t5,-1\(a0\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5678 	sh	t5,1656\(at\)
[0-9a-f]+ <[^>]+> 2064 1350 	slt	t4,a0,t5
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 2044 1350 	slt	t4,a0,t4
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 2044 1350 	slt	t4,a0,t4
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 0020 0000 	li	at,0
[0-9a-f]+ <[^>]+> 2061 1350 	slt	t4,at,t5
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2061 1350 	slt	t4,at,t5
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 0020 0000 	li	at,0
[0-9a-f]+ <[^>]+> 2061 1350 	slt	t4,at,t5
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 0020 7fff 	li	at,32767
[0-9a-f]+ <[^>]+> 2061 1350 	slt	t4,at,t5
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> 2061 1350 	slt	t4,at,t5
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> 2061 1350 	slt	t4,at,t5
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 6020 7fff ffff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2061 1350 	slt	t4,at,t5
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 2064 1390 	sltu	t4,a0,t5
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 2044 1390 	sltu	t4,a0,t4
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 2044 1390 	sltu	t4,a0,t4
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 0020 0000 	li	at,0
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	t4,at,t5
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	t4,at,t5
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 0020 0000 	li	at,0
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	t4,at,t5
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 0020 7fff 	li	at,32767
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	t4,at,t5
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	t4,at,t5
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	t4,at,t5
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
[0-9a-f]+ <[^>]+> 6020 7fff ffff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2061 1390 	sltu	t4,at,t5
[0-9a-f]+ <[^>]+> 8042 1001 	xori	t4,t4,1
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
[0-9a-f]+ <[^>]+> 2083 1010 	sllv	t4,t5,a0
[0-9a-f]+ <[^>]+> 2082 1010 	sllv	t4,t4,a0
[0-9a-f]+ <[^>]+> 2082 1010 	sllv	t4,t4,a0
[0-9a-f]+ <[^>]+> 2082 1010 	sllv	t4,t4,a0
[0-9a-f]+ <[^>]+> 8044 c000 	sll	t4,a0,0x0
[0-9a-f]+ <[^>]+> 8044 c001 	sll	t4,a0,0x1
[0-9a-f]+ <[^>]+> 8044 c01f 	sll	t4,a0,0x1f
[0-9a-f]+ <[^>]+> 8042 c01f 	sll	t4,t4,0x1f
[0-9a-f]+ <[^>]+> 8042 c01f 	sll	t4,t4,0x1f
[0-9a-f]+ <[^>]+> 2083 1350 	slt	t4,t5,a0
[0-9a-f]+ <[^>]+> 2082 1350 	slt	t4,t4,a0
[0-9a-f]+ <[^>]+> 2082 1350 	slt	t4,t4,a0
[0-9a-f]+ <[^>]+> 8043 4000 	slti	t4,t5,0
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2023 1350 	slt	t4,t5,at
[0-9a-f]+ <[^>]+> 8043 4000 	slti	t4,t5,0
[0-9a-f]+ <[^>]+> 0020 7fff 	li	at,32767
[0-9a-f]+ <[^>]+> 2023 1350 	slt	t4,t5,at
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> 2023 1350 	slt	t4,t5,at
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> 2023 1350 	slt	t4,t5,at
[0-9a-f]+ <[^>]+> 6020 7fff ffff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2023 1350 	slt	t4,t5,at
[0-9a-f]+ <[^>]+> 8064 4000 	slti	t5,a0,0
[0-9a-f]+ <[^>]+> 8064 4fff 	slti	t5,a0,4095
[0-9a-f]+ <[^>]+> 8064 5000 	sltiu	t5,a0,0
[0-9a-f]+ <[^>]+> 8064 5fff 	sltiu	t5,a0,4095
[0-9a-f]+ <[^>]+> 2083 1390 	sltu	t4,t5,a0
[0-9a-f]+ <[^>]+> 2082 1390 	sltu	t4,t4,a0
[0-9a-f]+ <[^>]+> 2082 1390 	sltu	t4,t4,a0
[0-9a-f]+ <[^>]+> 8043 5000 	sltiu	t4,t5,0
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2023 1390 	sltu	t4,t5,at
[0-9a-f]+ <[^>]+> 8043 5000 	sltiu	t4,t5,0
[0-9a-f]+ <[^>]+> 0020 7fff 	li	at,32767
[0-9a-f]+ <[^>]+> 2023 1390 	sltu	t4,t5,at
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> 2023 1390 	sltu	t4,t5,at
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> 2023 1390 	sltu	t4,t5,at
[0-9a-f]+ <[^>]+> 6020 7fff ffff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2023 1390 	sltu	t4,t5,at
[0-9a-f]+ <[^>]+> 2083 1310 	xor	t4,t5,a0
[0-9a-f]+ <[^>]+> 2040 1390 	sltu	t4,zero,t4
[0-9a-f]+ <[^>]+> 2080 1390 	sltu	t4,zero,a0
[0-9a-f]+ <[^>]+> 2060 1390 	sltu	t4,zero,t5
[0-9a-f]+ <[^>]+> 2060 1390 	sltu	t4,zero,t5
[0-9a-f]+ <[^>]+> 8043 1001 	xori	t4,t5,1
[0-9a-f]+ <[^>]+> 2040 1390 	sltu	t4,zero,t4
[0-9a-f]+ <[^>]+> 0043 0001 	addiu	t4,t5,1
[0-9a-f]+ <[^>]+> 2040 1390 	sltu	t4,zero,t4
[0-9a-f]+ <[^>]+> 0043 8001 	addiu	t4,t5,32769
[0-9a-f]+ <[^>]+> 2040 1390 	sltu	t4,zero,t4
[0-9a-f]+ <[^>]+> 2083 1090 	srav	t4,t5,a0
[0-9a-f]+ <[^>]+> 2082 1090 	srav	t4,t4,a0
[0-9a-f]+ <[^>]+> 2082 1090 	srav	t4,t4,a0
[0-9a-f]+ <[^>]+> 2082 1090 	srav	t4,t4,a0
[0-9a-f]+ <[^>]+> 8044 c080 	sra	t4,a0,0x0
[0-9a-f]+ <[^>]+> 8044 c081 	sra	t4,a0,0x1
[0-9a-f]+ <[^>]+> 8044 c09f 	sra	t4,a0,0x1f
[0-9a-f]+ <[^>]+> 8042 c09f 	sra	t4,t4,0x1f
[0-9a-f]+ <[^>]+> 8042 c09f 	sra	t4,t4,0x1f
[0-9a-f]+ <[^>]+> 2083 1050 	srlv	t4,t5,a0
[0-9a-f]+ <[^>]+> 2082 1050 	srlv	t4,t4,a0
[0-9a-f]+ <[^>]+> 2082 1050 	srlv	t4,t4,a0
[0-9a-f]+ <[^>]+> 2082 1050 	srlv	t4,t4,a0
[0-9a-f]+ <[^>]+> 8044 c040 	srl	t4,a0,0x0
[0-9a-f]+ <[^>]+> 3149      	srl	s2,a0,1
[0-9a-f]+ <[^>]+> 8044 c05f 	srl	t4,a0,0x1f
[0-9a-f]+ <[^>]+> 8042 c05f 	srl	t4,t4,0x1f
[0-9a-f]+ <[^>]+> 8042 c05f 	srl	t4,t4,0x1f
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
[0-9a-f]+ <[^>]+> 2083 1190 	sub	t4,t5,a0
[0-9a-f]+ <[^>]+> 23fe e990 	sub	sp,fp,ra
[0-9a-f]+ <[^>]+> 2082 1190 	sub	t4,t4,a0
[0-9a-f]+ <[^>]+> 2082 1190 	sub	t4,t4,a0
[0-9a-f]+ <[^>]+> 0020 0000 	li	at,0
[0-9a-f]+ <[^>]+> 2022 1190 	sub	t4,t4,at
[0-9a-f]+ <[^>]+> 0020 0001 	li	at,1
[0-9a-f]+ <[^>]+> 2022 1190 	sub	t4,t4,at
[0-9a-f]+ <[^>]+> 0020 7fff 	li	at,32767
[0-9a-f]+ <[^>]+> 2022 1190 	sub	t4,t4,at
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2022 1190 	sub	t4,t4,at
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> 2022 1190 	sub	t4,t4,at
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
[0-9a-f]+ <[^>]+> 2083 11d0 	subu	t4,t5,a0
[0-9a-f]+ <[^>]+> 23fe e9d0 	subu	sp,fp,ra
[0-9a-f]+ <[^>]+> 2082 11d0 	subu	t4,t4,a0
[0-9a-f]+ <[^>]+> 2082 11d0 	subu	t4,t4,a0
[0-9a-f]+ <[^>]+> 0042 0000 	addiu	t4,t4,0
[0-9a-f]+ <[^>]+> 8042 8001 	addiu	t4,t4,-1
[0-9a-f]+ <[^>]+> 6041 8001 ffff 	addiu	t4,t4,-32767
[0-9a-f]+ <[^>]+> 0042 8000 	addiu	t4,t4,32768
[0-9a-f]+ <[^>]+> 6041 0001 ffff 	addiu	t4,t4,-65535
[0-9a-f]+ <[^>]+> 9540      	sw	s2,0\(a0\)
[0-9a-f]+ <[^>]+> 9540      	sw	s2,0\(a0\)
[0-9a-f]+ <[^>]+> 9541      	sw	s2,4\(a0\)
[0-9a-f]+ <[^>]+> 9542      	sw	s2,8\(a0\)
[0-9a-f]+ <[^>]+> 9543      	sw	s2,12\(a0\)
[0-9a-f]+ <[^>]+> 9544      	sw	s2,16\(a0\)
[0-9a-f]+ <[^>]+> 9545      	sw	s2,20\(a0\)
[0-9a-f]+ <[^>]+> 9546      	sw	s2,24\(a0\)
[0-9a-f]+ <[^>]+> 9547      	sw	s2,28\(a0\)
[0-9a-f]+ <[^>]+> 9548      	sw	s2,32\(a0\)
[0-9a-f]+ <[^>]+> 9549      	sw	s2,36\(a0\)
[0-9a-f]+ <[^>]+> 954a      	sw	s2,40\(a0\)
[0-9a-f]+ <[^>]+> 954b      	sw	s2,44\(a0\)
[0-9a-f]+ <[^>]+> 954c      	sw	s2,48\(a0\)
[0-9a-f]+ <[^>]+> 954d      	sw	s2,52\(a0\)
[0-9a-f]+ <[^>]+> 954e      	sw	s2,56\(a0\)
[0-9a-f]+ <[^>]+> 954f      	sw	s2,60\(a0\)
[0-9a-f]+ <[^>]+> 955f      	sw	s2,60\(a1\)
[0-9a-f]+ <[^>]+> 956f      	sw	s2,60\(a2\)
[0-9a-f]+ <[^>]+> 957f      	sw	s2,60\(a3\)
[0-9a-f]+ <[^>]+> 950f      	sw	s2,60\(s0\)
[0-9a-f]+ <[^>]+> 951f      	sw	s2,60\(s1\)
[0-9a-f]+ <[^>]+> 952f      	sw	s2,60\(s2\)
[0-9a-f]+ <[^>]+> 953f      	sw	s2,60\(s3\)
[0-9a-f]+ <[^>]+> 95bf      	sw	s3,60\(s3\)
[0-9a-f]+ <[^>]+> 963f      	sw	a0,60\(s3\)
[0-9a-f]+ <[^>]+> 96bf      	sw	a1,60\(s3\)
[0-9a-f]+ <[^>]+> 973f      	sw	a2,60\(s3\)
[0-9a-f]+ <[^>]+> 97bf      	sw	a3,60\(s3\)
[0-9a-f]+ <[^>]+> 94bf      	sw	s1,60\(s3\)
[0-9a-f]+ <[^>]+> 943f      	sw	zero,60\(s3\)
[0-9a-f]+ <[^>]+> b400      	sw	zero,0\(sp\)
[0-9a-f]+ <[^>]+> b400      	sw	zero,0\(sp\)
[0-9a-f]+ <[^>]+> b401      	sw	zero,4\(sp\)
[0-9a-f]+ <[^>]+> b402      	sw	zero,8\(sp\)
[0-9a-f]+ <[^>]+> b403      	sw	zero,12\(sp\)
[0-9a-f]+ <[^>]+> b404      	sw	zero,16\(sp\)
[0-9a-f]+ <[^>]+> b405      	sw	zero,20\(sp\)
[0-9a-f]+ <[^>]+> b41e      	sw	zero,120\(sp\)
[0-9a-f]+ <[^>]+> b41f      	sw	zero,124\(sp\)
[0-9a-f]+ <[^>]+> b45f      	sw	t4,124\(sp\)
[0-9a-f]+ <[^>]+> b63f      	sw	s1,124\(sp\)
[0-9a-f]+ <[^>]+> b47f      	sw	t5,124\(sp\)
[0-9a-f]+ <[^>]+> b49f      	sw	a0,124\(sp\)
[0-9a-f]+ <[^>]+> b4bf      	sw	a1,124\(sp\)
[0-9a-f]+ <[^>]+> b4df      	sw	a2,124\(sp\)
[0-9a-f]+ <[^>]+> b4ff      	sw	a3,124\(sp\)
[0-9a-f]+ <[^>]+> b7ff      	sw	ra,124\(sp\)
[0-9a-f]+ <[^>]+> 8460 9004 	sw	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 9004 	sw	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 9fff 	sw	t5,4095\(zero\)
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8461 9001 	sw	t5,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8461 9001 	sw	t5,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> a460 c8ff 	sw	t5,-1\(zero\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 8461 9678 	sw	t5,1656\(at\)
[0-9a-f]+ <[^>]+> 8464 9000 	sw	t5,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 9000 	sw	t5,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 9fff 	sw	t5,4095\(a0\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9001 	sw	t5,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9001 	sw	t5,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> a464 c8ff 	sw	t5,-1\(a0\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9678 	sw	t5,1656\(at\)
[0-9a-f]+ <[^>]+> 8000 c006 	sync
[0-9a-f]+ <[^>]+> 8000 c006 	sync
[0-9a-f]+ <[^>]+> 8001 c006 	sync	0x1
[0-9a-f]+ <[^>]+> 8002 c006 	sync	0x2
[0-9a-f]+ <[^>]+> 8003 c006 	sync	0x3
[0-9a-f]+ <[^>]+> 8004 c006 	sync	0x4
[0-9a-f]+ <[^>]+> 801e c006 	sync	0x1e
[0-9a-f]+ <[^>]+> 801f c006 	sync	0x1f
[0-9a-f]+ <[^>]+> 87e0 3000 	synci	0\(zero\)
[0-9a-f]+ <[^>]+> 87e0 3000 	synci	0\(zero\)
[0-9a-f]+ <[^>]+> 87e0 3000 	synci	0\(zero\)
[0-9a-f]+ <[^>]+> 87e0 37ff 	synci	2047\(zero\)
[0-9a-f]+ <[^>]+> 87e0 3800 	synci	2048\(zero\)
[0-9a-f]+ <[^>]+> 87e2 3000 	synci	0\(t4\)
[0-9a-f]+ <[^>]+> 87e3 3000 	synci	0\(t5\)
[0-9a-f]+ <[^>]+> 87e3 30ff 	synci	255\(t5\)
[0-9a-f]+ <[^>]+> a7e3 9800 	synci	-256\(t5\)
[0-9a-f]+ <[^>]+> 87e3 3800 	synci	2048\(t5\)
[0-9a-f]+ <[^>]+> 1008      	syscall
[0-9a-f]+ <[^>]+> 1008      	syscall
[0-9a-f]+ <[^>]+> 1009      	syscall	1
[0-9a-f]+ <[^>]+> 100a      	syscall	2
[0-9a-f]+ <[^>]+> 0008 00ff 	syscall	0xff
[0-9a-f]+ <[^>]+> 8460 4004 	lh	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 4004 	lh	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 4000 	lh	t5,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 4000 	lh	t5,0\(a0\)
[0-9a-f]+ <[^>]+> 0024 7ffb 	addiu	at,a0,32763
[0-9a-f]+ <[^>]+> 8461 4000 	lh	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 4000 	lh	t5,0\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> 8461 4000 	lh	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 4000 	lh	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 4000 	lh	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 4001 	lh	t5,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 4001 	lh	t5,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 4000 	lh	t5,0\(at\)
[0-9a-f]+ <[^>]+> a464 a0ff 	lh	t5,-1\(a0\)
[0-9a-f]+ <[^>]+> 8460 6004 	lhu	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 6004 	lhu	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 6000 	lhu	t5,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 6000 	lhu	t5,0\(a0\)
[0-9a-f]+ <[^>]+> 0024 7ffb 	addiu	at,a0,32763
[0-9a-f]+ <[^>]+> 8461 6000 	lhu	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 6000 	lhu	t5,0\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> 8461 6000 	lhu	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 6000 	lhu	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 6000 	lhu	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 6001 	lhu	t5,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 6001 	lhu	t5,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 6000 	lhu	t5,0\(at\)
[0-9a-f]+ <[^>]+> a464 b0ff 	lhu	t5,-1\(a0\)
[0-9a-f]+ <[^>]+> 8460 8000 	lw	t5,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 8000 	lw	t5,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 8004 	lw	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 8004 	lw	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 87ff 	lw	t5,2047\(zero\)
[0-9a-f]+ <[^>]+> 8020 8800 	li	at,-2048
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8460 8800 	lw	t5,2048\(zero\)
[0-9a-f]+ <[^>]+> 8020 8801 	li	at,-2049
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 0020 7ffb 	li	at,32763
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8461 8001 	lw	t5,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8461 8001 	lw	t5,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> a460 c0ff 	lw	t5,-1\(zero\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 8461 8678 	lw	t5,1656\(at\)
[0-9a-f]+ <[^>]+> 8464 8000 	lw	t5,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 8004 	lw	t5,4\(a0\)
[0-9a-f]+ <[^>]+> 8464 87ff 	lw	t5,2047\(a0\)
[0-9a-f]+ <[^>]+> 8024 8800 	addiu	at,a0,-2048
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8464 8800 	lw	t5,2048\(a0\)
[0-9a-f]+ <[^>]+> 8024 8801 	addiu	at,a0,-2049
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 0024 7ffb 	addiu	at,a0,32763
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 8001 	lw	t5,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 8001 	lw	t5,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> a464 c0ff 	lw	t5,-1\(a0\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 8678 	lw	t5,1656\(at\)
[0-9a-f]+ <[^>]+> 8460 5004 	sh	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 5004 	sh	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 5000 	sh	t5,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 5000 	sh	t5,0\(a0\)
[0-9a-f]+ <[^>]+> 0024 7ffb 	addiu	at,a0,32763
[0-9a-f]+ <[^>]+> 8461 5000 	sh	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5000 	sh	t5,0\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> 8461 5000 	sh	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5000 	sh	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5000 	sh	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5001 	sh	t5,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5001 	sh	t5,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 5000 	sh	t5,0\(at\)
[0-9a-f]+ <[^>]+> a464 a8ff 	sh	t5,-1\(a0\)
[0-9a-f]+ <[^>]+> 8460 9000 	sw	t5,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 9000 	sw	t5,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 9004 	sw	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 9004 	sw	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 97ff 	sw	t5,2047\(zero\)
[0-9a-f]+ <[^>]+> 8020 8800 	li	at,-2048
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8460 9800 	sw	t5,2048\(zero\)
[0-9a-f]+ <[^>]+> 8020 8801 	li	at,-2049
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 0020 7ffb 	li	at,32763
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8461 9001 	sw	t5,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8461 9001 	sw	t5,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> a460 c8ff 	sw	t5,-1\(zero\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 8461 9678 	sw	t5,1656\(at\)
[0-9a-f]+ <[^>]+> 8464 9000 	sw	t5,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 9004 	sw	t5,4\(a0\)
[0-9a-f]+ <[^>]+> 8464 97ff 	sw	t5,2047\(a0\)
[0-9a-f]+ <[^>]+> 8024 8800 	addiu	at,a0,-2048
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8464 9800 	sw	t5,2048\(a0\)
[0-9a-f]+ <[^>]+> 8024 8801 	addiu	at,a0,-2049
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 0024 7ffb 	addiu	at,a0,32763
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9001 	sw	t5,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9001 	sw	t5,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> a464 c8ff 	sw	t5,-1\(a0\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 9678 	sw	t5,1656\(at\)
[0-9a-f]+ <[^>]+> 2000 c37f 	wait
[0-9a-f]+ <[^>]+> 2000 c37f 	wait
[0-9a-f]+ <[^>]+> 2001 c37f 	wait	0x1
[0-9a-f]+ <[^>]+> 20ff c37f 	wait	0xff
[0-9a-f]+ <[^>]+> 2043 f17f 	wrpgpr	t4,t5
[0-9a-f]+ <[^>]+> 2044 f17f 	wrpgpr	t4,a0
[0-9a-f]+ <[^>]+> 2042 f17f 	wrpgpr	t4,t4
[0-9a-f]+ <[^>]+> 2042 f17f 	wrpgpr	t4,t4
[0-9a-f]+ <[^>]+> 8043 d608 	byterevh	t4,t5
[0-9a-f]+ <[^>]+> 8044 d608 	byterevh	t4,a0
[0-9a-f]+ <[^>]+> 8042 d608 	byterevh	t4,t4
[0-9a-f]+ <[^>]+> 8042 d608 	byterevh	t4,t4
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
[0-9a-f]+ <[^>]+> 2083 1310 	xor	t4,t5,a0
[0-9a-f]+ <[^>]+> 23fe eb10 	xor	sp,fp,ra
[0-9a-f]+ <[^>]+> 2082 1310 	xor	t4,t4,a0
[0-9a-f]+ <[^>]+> 2082 1310 	xor	t4,t4,a0
[0-9a-f]+ <[^>]+> 0020 8000 	li	at,32768
[0-9a-f]+ <[^>]+> 2023 1310 	xor	t4,t5,at
[0-9a-f]+ <[^>]+> 8043 1fff 	xori	t4,t5,4095
[0-9a-f]+ <[^>]+> 0020 1000 	li	at,4096
[0-9a-f]+ <[^>]+> 2023 1310 	xor	t4,t5,at
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2023 1310 	xor	t4,t5,at
[0-9a-f]+ <[^>]+> 6020 7fff ffff 	li	at,0xffff7fff
[0-9a-f]+ <[^>]+> 2023 1310 	xor	t4,t5,at
[0-9a-f]+ <[^>]+> 8064 1000 	xori	t5,a0,0
[0-9a-f]+ <[^>]+> 8063 1fff 	xori	t5,t5,4095
[0-9a-f]+ <[^>]+> 8920 0000 	beqzc	a5,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8949 0000 	beqc	a5,a6,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8920 0000 	beqzc	a5,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> c920 0800 	beqic	a5,1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC11_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 880a 8000 	bgezc	a6,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 880a 8000 	bgezc	a6,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8940 8000 	blezc	a6,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 896a 8000 	bgec	a6,a7,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 880a 8000 	bgezc	a6,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a940 8000 	bgtzc	a6,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> c948 1000 	bgeic	a6,2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC11_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC25_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8802 c000 	bgeuc	t4,zero,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8840 c000 	bgeuc	zero,t4,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8862 c000 	bgeuc	t4,t5,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC25_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a840 0000 	bnezc	t4,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> c84c 1000 	bgeiuc	t4,2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC11_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8802 8000 	bgezc	t4,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a840 8000 	bgtzc	t4,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a802 8000 	bltzc	t4,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 212a 0b50 	slt	at,a6,a5
[0-9a-f]+ <[^>]+> a820 0000 	bnezc	at,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 9008      	nop
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8809 8000 	bgezc	a5,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a920 8000 	bgtzc	a5,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> c928 1000 	bgeic	a5,2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC11_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 6020 0001 8000 	li	at,0x80000001
[0-9a-f]+ <[^>]+> 2029 0b50 	slt	at,a5,at
[0-9a-f]+ <[^>]+> 8820 0000 	beqzc	at,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a920 0000 	bnezc	a5,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 9008      	nop
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 212a 0b90 	sltu	at,a6,a5
[0-9a-f]+ <[^>]+> a820 0000 	bnezc	at,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 9008      	nop
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 9008      	nop
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 9008      	nop
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a920 0000 	bnezc	a5,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> c92c 1000 	bgeiuc	a5,2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC11_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a920 8000 	bgtzc	a5,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8920 8000 	blezc	a5,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 880a 8000 	bgezc	a6,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 212a 0b50 	slt	at,a6,a5
[0-9a-f]+ <[^>]+> 8820 0000 	beqzc	at,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC25_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a809 8000 	bltzc	a5,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8920 8000 	blezc	a5,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> c938 1000 	bltic	a5,2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC11_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8920 0000 	beqzc	a5,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC25_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 212a 0b90 	sltu	at,a6,a5
[0-9a-f]+ <[^>]+> 8820 0000 	beqzc	at,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC25_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC25_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8920 0000 	beqzc	a5,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> c93c 1000 	bltiuc	a5,2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC11_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8920 8000 	blezc	a5,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a809 8000 	bltzc	a5,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a940 8000 	bgtzc	a6,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a949 8000 	bltc	a5,a6,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a809 8000 	bltzc	a5,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8920 8000 	blezc	a5,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> c938 1000 	bltic	a5,2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC11_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a809 c000 	bltuc	a5,zero,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a940 c000 	bltuc	zero,a6,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a949 c000 	bltuc	a5,a6,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 9008      	nop
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8920 0000 	beqzc	a5,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> c93c 1000 	bltiuc	a5,2,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC11_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a809 8000 	bltzc	a5,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a920 0000 	bnezc	a5,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a949 0000 	bnec	a5,a6,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> a920 0000 	bnezc	a5,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC14_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> c930 0800 	bneic	a5,1,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PC11_S1	test
[0-9a-f]+ <[^>]+> b2c6      	addu	s3,a0,a1
[0-9a-f]+ <[^>]+> 8460 9004 	sw	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8480 9008 	sw	a0,8\(zero\)
[0-9a-f]+ <[^>]+> 8460 9004 	sw	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8480 9008 	sw	a0,8\(zero\)
[0-9a-f]+ <[^>]+> 0020 7fff 	li	at,32767
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8461 9001 	sw	t5,1\(at\)
[0-9a-f]+ <[^>]+> 8481 9005 	sw	a0,5\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8461 9001 	sw	t5,1\(at\)
[0-9a-f]+ <[^>]+> 8481 9005 	sw	a0,5\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> 8020 8001 	li	at,-1
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 8461 9678 	sw	t5,1656\(at\)
[0-9a-f]+ <[^>]+> 8481 967c 	sw	a0,1660\(at\)
[0-9a-f]+ <[^>]+> 8464 9000 	sw	t5,0\(a0\)
[0-9a-f]+ <[^>]+> 8484 9004 	sw	a0,4\(a0\)
[0-9a-f]+ <[^>]+> 8464 9000 	sw	t5,0\(a0\)
[0-9a-f]+ <[^>]+> 8484 9004 	sw	a0,4\(a0\)
[0-9a-f]+ <[^>]+> 0024 7fff 	addiu	at,a0,32767
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 9001 	sw	t5,1\(at\)
[0-9a-f]+ <[^>]+> 8481 9005 	sw	a0,5\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 9001 	sw	t5,1\(at\)
[0-9a-f]+ <[^>]+> 8481 9005 	sw	a0,5\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> 8024 8001 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> 8461 9000 	sw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 9004 	sw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 9678 	sw	t5,1656\(at\)
[0-9a-f]+ <[^>]+> 8481 967c 	sw	a0,1660\(at\)
[0-9a-f]+ <[^>]+> 8460 8004 	lw	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8480 8008 	lw	a0,8\(zero\)
[0-9a-f]+ <[^>]+> 8460 8004 	lw	t5,4\(zero\)
[0-9a-f]+ <[^>]+> 8480 8008 	lw	a0,8\(zero\)
[0-9a-f]+ <[^>]+> 0020 7fff 	li	at,32767
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> 0020 ffff 	li	at,65535
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 8461 8001 	lw	t5,1\(at\)
[0-9a-f]+ <[^>]+> 8481 8005 	lw	a0,5\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8461 8001 	lw	t5,1\(at\)
[0-9a-f]+ <[^>]+> 8481 8005 	lw	a0,5\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> 8020 8001 	li	at,-1
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 8461 8678 	lw	t5,1656\(at\)
[0-9a-f]+ <[^>]+> 8481 867c 	lw	a0,1660\(at\)
[0-9a-f]+ <[^>]+> 8464 8000 	lw	t5,0\(a0\)
[0-9a-f]+ <[^>]+> 8484 8004 	lw	a0,4\(a0\)
[0-9a-f]+ <[^>]+> 8464 8000 	lw	t5,0\(a0\)
[0-9a-f]+ <[^>]+> 8484 8004 	lw	a0,4\(a0\)
[0-9a-f]+ <[^>]+> 0024 7fff 	addiu	at,a0,32767
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 8001 	lw	t5,1\(at\)
[0-9a-f]+ <[^>]+> 8481 8005 	lw	a0,5\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 8001 	lw	t5,1\(at\)
[0-9a-f]+ <[^>]+> 8481 8005 	lw	a0,5\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> 8024 8001 	addiu	at,a0,-1
[0-9a-f]+ <[^>]+> 8461 8000 	lw	t5,0\(at\)
[0-9a-f]+ <[^>]+> 8481 8004 	lw	a0,4\(at\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 2024 0950 	addu	at,a0,at
[0-9a-f]+ <[^>]+> 8461 8678 	lw	t5,1656\(at\)
[0-9a-f]+ <[^>]+> 8481 867c 	lw	a0,1660\(at\)
[0-9a-f]+ <[^>]+> 1d00      	restore\.jrc	0
[0-9a-f]+ <[^>]+> 8000 300b 	restore\.jrc	8
[0-9a-f]+ <[^>]+> 1d10      	restore\.jrc	16
[0-9a-f]+ <[^>]+> 8000 301b 	restore\.jrc	24
[0-9a-f]+ <[^>]+> 1d20      	restore\.jrc	32
[0-9a-f]+ <[^>]+> 8000 302b 	restore\.jrc	40
[0-9a-f]+ <[^>]+> 03bd 0004 	addiu	sp,sp,4
[0-9a-f]+ <[^>]+> dbe0      	jrc	ra
[0-9a-f]+ <[^>]+> 03bd 000c 	addiu	sp,sp,12
[0-9a-f]+ <[^>]+> dbe0      	jrc	ra
[0-9a-f]+ <[^>]+> 03bd 0014 	addiu	sp,sp,20
[0-9a-f]+ <[^>]+> dbe0      	jrc	ra
[0-9a-f]+ <[^>]+> 03bd 001c 	addiu	sp,sp,28
[0-9a-f]+ <[^>]+> dbe0      	jrc	ra
[0-9a-f]+ <[^>]+> 03bd 0024 	addiu	sp,sp,36
[0-9a-f]+ <[^>]+> dbe0      	jrc	ra
[0-9a-f]+ <[^>]+> 8000 307b 	restore\.jrc	120
[0-9a-f]+ <[^>]+> 03bd 007c 	addiu	sp,sp,124
[0-9a-f]+ <[^>]+> dbe0      	jrc	ra
[0-9a-f]+ <[^>]+> a460 6100 	ldc2	\$3,0\(zero\)
[0-9a-f]+ <[^>]+> a460 6100 	ldc2	\$3,0\(zero\)
[0-9a-f]+ <[^>]+> a460 6104 	ldc2	\$3,4\(zero\)
[0-9a-f]+ <[^>]+> a460 6104 	ldc2	\$3,4\(zero\)
[0-9a-f]+ <[^>]+> a464 6100 	ldc2	\$3,0\(a0\)
[0-9a-f]+ <[^>]+> a464 6100 	ldc2	\$3,0\(a0\)
[0-9a-f]+ <[^>]+> 0024 7fff 	addiu	at,a0,32767
[0-9a-f]+ <[^>]+> a461 6100 	ldc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 6100 	ldc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> a461 6100 	ldc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 6100 	ldc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 6100 	ldc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 6101 	ldc2	\$3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 6101 	ldc2	\$3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 6100 	ldc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> a464 e1ff 	ldc2	\$3,-1\(a0\)
[0-9a-f]+ <[^>]+> 6020 5678 1234 	li	at,0x12345678
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 6100 	ldc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> a460 4100 	lwc2	\$3,0\(zero\)
[0-9a-f]+ <[^>]+> a460 4100 	lwc2	\$3,0\(zero\)
[0-9a-f]+ <[^>]+> a460 4104 	lwc2	\$3,4\(zero\)
[0-9a-f]+ <[^>]+> a460 4104 	lwc2	\$3,4\(zero\)
[0-9a-f]+ <[^>]+> a464 4100 	lwc2	\$3,0\(a0\)
[0-9a-f]+ <[^>]+> a464 4100 	lwc2	\$3,0\(a0\)
[0-9a-f]+ <[^>]+> 0024 7fff 	addiu	at,a0,32767
[0-9a-f]+ <[^>]+> a461 4100 	lwc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 4100 	lwc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> a461 4100 	lwc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 4100 	lwc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 4100 	lwc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 4101 	lwc2	\$3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 4101 	lwc2	\$3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 4100 	lwc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> a464 c1ff 	lwc2	\$3,-1\(a0\)
[0-9a-f]+ <[^>]+> 6020 5678 1234 	li	at,0x12345678
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 4100 	lwc2	\$3,0\(at\)
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
[0-9a-f]+ <[^>]+> a460 6900 	sdc2	\$3,0\(zero\)
[0-9a-f]+ <[^>]+> a460 6900 	sdc2	\$3,0\(zero\)
[0-9a-f]+ <[^>]+> a460 6904 	sdc2	\$3,4\(zero\)
[0-9a-f]+ <[^>]+> a460 6904 	sdc2	\$3,4\(zero\)
[0-9a-f]+ <[^>]+> a464 6900 	sdc2	\$3,0\(a0\)
[0-9a-f]+ <[^>]+> a464 6900 	sdc2	\$3,0\(a0\)
[0-9a-f]+ <[^>]+> 0024 7fff 	addiu	at,a0,32767
[0-9a-f]+ <[^>]+> a461 6900 	sdc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 6900 	sdc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> a461 6900 	sdc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 6900 	sdc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 6900 	sdc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 6901 	sdc2	\$3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 6901 	sdc2	\$3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 6900 	sdc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> a464 e9ff 	sdc2	\$3,-1\(a0\)
[0-9a-f]+ <[^>]+> 6020 5678 1234 	li	at,0x12345678
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 6900 	sdc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> a460 4900 	swc2	\$3,0\(zero\)
[0-9a-f]+ <[^>]+> a460 4900 	swc2	\$3,0\(zero\)
[0-9a-f]+ <[^>]+> a460 4904 	swc2	\$3,4\(zero\)
[0-9a-f]+ <[^>]+> a460 4904 	swc2	\$3,4\(zero\)
[0-9a-f]+ <[^>]+> a464 4900 	swc2	\$3,0\(a0\)
[0-9a-f]+ <[^>]+> a464 4900 	swc2	\$3,0\(a0\)
[0-9a-f]+ <[^>]+> 0024 7fff 	addiu	at,a0,32767
[0-9a-f]+ <[^>]+> a461 4900 	swc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 4900 	swc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> a461 4900 	swc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 4900 	swc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 4900 	swc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 4901 	swc2	\$3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 4901 	swc2	\$3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 4900 	swc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> a464 c9ff 	swc2	\$3,-1\(a0\)
[0-9a-f]+ <[^>]+> 6020 5678 1234 	li	at,0x12345678
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> a461 4900 	swc2	\$3,0\(at\)
[0-9a-f]+ <[^>]+> 0023 0000 	addiu	at,t5,0
			[0-9a-f]+: R_NANOMIPS_LO12	test
[0-9a-f]+ <[^>]+> a401 3900 	cache	0x0,0\(at\)
[0-9a-f]+ <[^>]+> 0043 0000 	addiu	t4,t5,0
			[0-9a-f]+: R_NANOMIPS_LO12	test
[0-9a-f]+ <[^>]+> a442 5100 	ll	t4,0\(t4\)
[0-9a-f]+ <[^>]+> 0023 0000 	addiu	at,t5,0
			[0-9a-f]+: R_NANOMIPS_LO12	test
[0-9a-f]+ <[^>]+> a441 5900 	sc	t4,0\(at\)
[0-9a-f]+ <[^>]+> 0023 0000 	addiu	at,t5,0
			[0-9a-f]+: R_NANOMIPS_LO12	test
[0-9a-f]+ <[^>]+> a601 4100 	lwc2	\$16,0\(at\)
[0-9a-f]+ <[^>]+> 0023 0000 	addiu	at,t5,0
			[0-9a-f]+: R_NANOMIPS_LO12	test
[0-9a-f]+ <[^>]+> a601 4900 	swc2	\$16,0\(at\)
[0-9a-f]+ <[^>]+> 0018 03ff 	sdbbp	0x3ff
[0-9a-f]+ <[^>]+> 23ff c37f 	wait	0x3ff
[0-9a-f]+ <[^>]+> 0008 03ff 	syscall	0x3ff
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
[0-9a-f]+ <[^>]+> 0024 7fff 	addiu	at,a0,32767
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e001 	ldc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e001 	ldc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> a464 f0ff 	ldc1	\$f3,-1\(a0\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e678 	ldc1	\$f3,1656\(at\)
[0-9a-f]+ <[^>]+> 8460 e000 	ldc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 e000 	ldc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 e004 	ldc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 e004 	ldc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 e000 	ldc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 e000 	ldc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 0024 7fff 	addiu	at,a0,32767
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e001 	ldc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e001 	ldc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> a464 f0ff 	ldc1	\$f3,-1\(a0\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e678 	ldc1	\$f3,1656\(at\)
[0-9a-f]+ <[^>]+> 8460 e000 	ldc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 e000 	ldc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 e004 	ldc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 e004 	ldc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 e000 	ldc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 e000 	ldc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 0024 7fff 	addiu	at,a0,32767
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 e000 	ldc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 2000 0707 	ldc1x	\$f0,zero\(zero\)
[0-9a-f]+ <[^>]+> 2040 0707 	ldc1x	\$f0,zero\(t4\)
[0-9a-f]+ <[^>]+> 23e0 0707 	ldc1x	\$f0,zero\(ra\)
[0-9a-f]+ <[^>]+> 23e2 0707 	ldc1x	\$f0,t4\(ra\)
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
[0-9a-f]+ <[^>]+> 0024 7fff 	addiu	at,a0,32767
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a001 	lwc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a001 	lwc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> a464 d0ff 	lwc1	\$f3,-1\(a0\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a678 	lwc1	\$f3,1656\(at\)
[0-9a-f]+ <[^>]+> 8460 a000 	lwc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 a000 	lwc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 a004 	lwc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 a004 	lwc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 a000 	lwc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 a000 	lwc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 0024 7fff 	addiu	at,a0,32767
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a001 	lwc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a001 	lwc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> a464 d0ff 	lwc1	\$f3,-1\(a0\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a678 	lwc1	\$f3,1656\(at\)
[0-9a-f]+ <[^>]+> 8460 a000 	lwc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 a000 	lwc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 a004 	lwc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 a004 	lwc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 a000 	lwc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 a000 	lwc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 0024 7fff 	addiu	at,a0,32767
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a001 	lwc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a001 	lwc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a000 	lwc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> a464 d0ff 	lwc1	\$f3,-1\(a0\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 a678 	lwc1	\$f3,1656\(at\)
[0-9a-f]+ <[^>]+> 2000 0507 	lwc1x	\$f0,zero\(zero\)
[0-9a-f]+ <[^>]+> 2040 0507 	lwc1x	\$f0,zero\(t4\)
[0-9a-f]+ <[^>]+> 23e0 0507 	lwc1x	\$f0,zero\(ra\)
[0-9a-f]+ <[^>]+> 23e2 0507 	lwc1x	\$f0,t4\(ra\)
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
[0-9a-f]+ <[^>]+> 0024 7fff 	addiu	at,a0,32767
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f001 	sdc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f001 	sdc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> a464 f8ff 	sdc1	\$f3,-1\(a0\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f678 	sdc1	\$f3,1656\(at\)
[0-9a-f]+ <[^>]+> 8460 f000 	sdc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 f000 	sdc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 f004 	sdc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 f004 	sdc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 f000 	sdc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 f000 	sdc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 0024 7fff 	addiu	at,a0,32767
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f001 	sdc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f001 	sdc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> a464 f8ff 	sdc1	\$f3,-1\(a0\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f678 	sdc1	\$f3,1656\(at\)
[0-9a-f]+ <[^>]+> 8460 f000 	sdc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 f000 	sdc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 f004 	sdc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 f004 	sdc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 f000 	sdc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 f000 	sdc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 0024 7fff 	addiu	at,a0,32767
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 f000 	sdc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 2000 0787 	sdc1x	\$f0,zero\(zero\)
[0-9a-f]+ <[^>]+> 2040 0787 	sdc1x	\$f0,zero\(t4\)
[0-9a-f]+ <[^>]+> 23e0 0787 	sdc1x	\$f0,zero\(ra\)
[0-9a-f]+ <[^>]+> 23e2 0787 	sdc1x	\$f0,t4\(ra\)
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
[0-9a-f]+ <[^>]+> 0024 7fff 	addiu	at,a0,32767
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b001 	swc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b001 	swc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> a464 d8ff 	swc1	\$f3,-1\(a0\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b678 	swc1	\$f3,1656\(at\)
[0-9a-f]+ <[^>]+> 8460 b000 	swc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 b000 	swc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 b004 	swc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 b004 	swc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 b000 	swc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 b000 	swc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 0024 7fff 	addiu	at,a0,32767
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b001 	swc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b001 	swc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> a464 d8ff 	swc1	\$f3,-1\(a0\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b678 	swc1	\$f3,1656\(at\)
[0-9a-f]+ <[^>]+> 8460 b000 	swc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 b000 	swc1	\$f3,0\(zero\)
[0-9a-f]+ <[^>]+> 8460 b004 	swc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8460 b004 	swc1	\$f3,4\(zero\)
[0-9a-f]+ <[^>]+> 8464 b000 	swc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 8464 b000 	swc1	\$f3,0\(a0\)
[0-9a-f]+ <[^>]+> 0024 7fff 	addiu	at,a0,32767
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> 0024 ffff 	addiu	at,a0,65535
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> e03f 0ffd 	lui	at,%hi\(0xffff0000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b001 	swc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b001 	swc1	\$f3,1\(at\)
[0-9a-f]+ <[^>]+> e020 0e01 	lui	at,%hi\(0xf0000000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b000 	swc1	\$f3,0\(at\)
[0-9a-f]+ <[^>]+> a464 d8ff 	swc1	\$f3,-1\(a0\)
[0-9a-f]+ <[^>]+> e034 5244 	lui	at,%hi\(0x12345000\)
[0-9a-f]+ <[^>]+> 2081 0950 	addu	at,at,a0
[0-9a-f]+ <[^>]+> 8461 b678 	swc1	\$f3,1656\(at\)
[0-9a-f]+ <[^>]+> 2000 0587 	swc1x	\$f0,zero\(zero\)
[0-9a-f]+ <[^>]+> 2040 0587 	swc1x	\$f0,zero\(t4\)
[0-9a-f]+ <[^>]+> 23e0 0587 	swc1x	\$f0,zero\(ra\)
[0-9a-f]+ <[^>]+> 23e2 0587 	swc1x	\$f0,t4\(ra\)
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
			[0-9a-f]+: R_NANOMIPS_PC10_S1	test_delay_slot
[0-9a-f]+ <[^>]+> d850      	jalrc	t4
[0-9a-f]+ <[^>]+> 4be2 0000 	jalrc	t4
[0-9a-f]+ <[^>]+> d840      	jrc	t4
[0-9a-f]+ <[^>]+> 4802 0000 	jrc	t4
[0-9a-f]+ <[^>]+> 4be2 1000 	jalrc\.hb	t4
[0-9a-f]+ <[^>]+> 4802 1000 	jrc\.hb	t4
[0-9a-f]+ <[^>]+> 557f      	lw	s2,508\(gp\)
[0-9a-f]+ <[^>]+> 55ff      	lw	s3,508\(gp\)
[0-9a-f]+ <[^>]+> 567f      	lw	a0,508\(gp\)
[0-9a-f]+ <[^>]+> 56ff      	lw	a1,508\(gp\)
[0-9a-f]+ <[^>]+> 577f      	lw	a2,508\(gp\)
[0-9a-f]+ <[^>]+> 57ff      	lw	a3,508\(gp\)
[0-9a-f]+ <[^>]+> 547f      	lw	s0,508\(gp\)
[0-9a-f]+ <[^>]+> 54ff      	lw	s1,508\(gp\)
[0-9a-f]+ <[^>]+> 54fe      	lw	s1,504\(gp\)
[0-9a-f]+ <[^>]+> 54fd      	lw	s1,500\(gp\)
[0-9a-f]+ <[^>]+> 5480      	lw	s1,0\(gp\)
[0-9a-f]+ <[^>]+> 5481      	lw	s1,4\(gp\)
[0-9a-f]+ <[^>]+> 54be      	lw	s1,248\(gp\)
[0-9a-f]+ <[^>]+> 54bf      	lw	s1,252\(gp\)
[0-9a-f]+ <[^>]+> 54c0      	lw	s1,256\(gp\)
[0-9a-f]+ <[^>]+> 823c 8104 	addiu	s1,gp,-260
[0-9a-f]+ <[^>]+> 8631 8000 	lw	s1,0\(s1\)
[0-9a-f]+ <[^>]+> 863c 8001 	lw	s1,1\(gp\)
[0-9a-f]+ <[^>]+> 863c 8002 	lw	s1,2\(gp\)
[0-9a-f]+ <[^>]+> 863c 8003 	lw	s1,3\(gp\)
[0-9a-f]+ <[^>]+> a63c c0ff 	lw	s1,-1\(gp\)
[0-9a-f]+ <[^>]+> a63c c0fe 	lw	s1,-2\(gp\)
[0-9a-f]+ <[^>]+> a63c c0fd 	lw	s1,-3\(gp\)
[0-9a-f]+ <[^>]+> 863b 8000 	lw	s1,0\(k1\)
[0-9a-f]+ <[^>]+> bd63      	movep	a1,a2,zero,zero
[0-9a-f]+ <[^>]+> bc6b      	movep	a2,a3,zero,zero
[0-9a-f]+ <[^>]+> bc63      	movep	a0,a1,zero,zero
[0-9a-f]+ <[^>]+> bd63      	movep	a1,a2,zero,zero
[0-9a-f]+ <[^>]+> bc6b      	movep	a2,a3,zero,zero
[0-9a-f]+ <[^>]+> bc79      	movep	a2,a3,s1,zero
[0-9a-f]+ <[^>]+> bc69      	movep	a2,a3,a5,zero
[0-9a-f]+ <[^>]+> bc6a      	movep	a2,a3,a6,zero
[0-9a-f]+ <[^>]+> bc78      	movep	a2,a3,s0,zero
[0-9a-f]+ <[^>]+> bc7a      	movep	a2,a3,s2,zero
[0-9a-f]+ <[^>]+> bc7b      	movep	a2,a3,s3,zero
[0-9a-f]+ <[^>]+> bc7c      	movep	a2,a3,s4,zero
[0-9a-f]+ <[^>]+> be3c      	movep	a2,a3,s4,s1
[0-9a-f]+ <[^>]+> bc3c      	movep	a2,a3,s4,a5
[0-9a-f]+ <[^>]+> bc5c      	movep	a2,a3,s4,a6
[0-9a-f]+ <[^>]+> be1c      	movep	a2,a3,s4,s0
[0-9a-f]+ <[^>]+> be5c      	movep	a2,a3,s4,s2
[0-9a-f]+ <[^>]+> be7c      	movep	a2,a3,s4,s3
[0-9a-f]+ <[^>]+> be9c      	movep	a2,a3,s4,s4
[0-9a-f]+ <[^>]+> 4478 0000 	lwc1	\$f3,0\(gp\)
[0-9a-f]+ <[^>]+> 4478 0000 	lwc1	\$f3,0\(gp\)
[0-9a-f]+ <[^>]+> 4478 0004 	lwc1	\$f3,4\(gp\)
[0-9a-f]+ <[^>]+> 4478 4000 	lwc1	\$f3,16384\(gp\)
[0-9a-f]+ <[^>]+> 447b fffc 	lwc1	\$f3,262140\(gp\)
[0-9a-f]+ <[^>]+> 4478 0001 	swc1	\$f3,0\(gp\)
[0-9a-f]+ <[^>]+> 4478 0001 	swc1	\$f3,0\(gp\)
[0-9a-f]+ <[^>]+> 4478 0005 	swc1	\$f3,4\(gp\)
[0-9a-f]+ <[^>]+> 4478 4001 	swc1	\$f3,16384\(gp\)
[0-9a-f]+ <[^>]+> 447b fffd 	swc1	\$f3,262140\(gp\)
[0-9a-f]+ <[^>]+> 8042 2fff 	andi	t4,t4,4095
[0-9a-f]+ <[^>]+> 8043 f300 	ext	t4,t5,0x0,0xd
[0-9a-f]+ <[^>]+> 8044 f340 	ext	t4,a0,0x0,0xe
[0-9a-f]+ <[^>]+> 8045 f380 	ext	t4,a1,0x0,0xf
[0-9a-f]+ <[^>]+> 8046 f3c0 	ext	t4,a2,0x0,0x10
[0-9a-f]+ <[^>]+> 8047 f500 	ext	t4,a3,0x0,0x15
[0-9a-f]+ <[^>]+> 8048 f540 	ext	t4,a4,0x0,0x16
[0-9a-f]+ <[^>]+> 8049 f580 	ext	t4,a5,0x0,0x17
[0-9a-f]+ <[^>]+> 8050 f5c0 	ext	t4,s0,0x0,0x18
[0-9a-f]+ <[^>]+> 6040 0000 0000 	li	t4,0x0
			[0-9a-f]+: R_NANOMIPS_I32	test
[0-9a-f]+ <[^>]+> 2000 0390 	dvp
[0-9a-f]+ <[^>]+> 20a0 0390 	dvp	a1
[0-9a-f]+ <[^>]+> 2000 0790 	evp
[0-9a-f]+ <[^>]+> 20c0 0790 	evp	a2
#pass
