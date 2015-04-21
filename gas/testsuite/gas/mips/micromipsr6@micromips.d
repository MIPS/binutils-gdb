#objdump: -dr --show-raw-insn
#name: microMIPS for MIPS32r6
#as: -32 -mfp64 -EB
#stderr: micromips-warn.l
#source: micromips.s

.*: +file format .*mips.*

Disassembly of section .text:

[ 0-9a-f]+ <test>:
[ 0-9a-f]+:	6000 2000 	pref	0x0,0\(zero\)
[ 0-9a-f]+:	6000 20ff 	pref	0x0,255\(zero\)
[ 0-9a-f]+:	6000 2100 	pref	0x0,-256\(zero\)
[ 0-9a-f]+:	3020 0100 	li	at,256
[ 0-9a-f]+:	6001 2000 	pref	0x0,0\(at\)
[ 0-9a-f]+:	3020 feff 	li	at,-257
[ 0-9a-f]+:	6001 2000 	pref	0x0,0\(at\)
[ 0-9a-f]+:	6000 2000 	pref	0x0,0\(zero\)
[ 0-9a-f]+:	6000 2000 	pref	0x0,0\(zero\)
[ 0-9a-f]+:	6020 2000 	pref	0x1,0\(zero\)
[ 0-9a-f]+:	6040 2000 	pref	0x2,0\(zero\)
[ 0-9a-f]+:	6060 2000 	pref	0x3,0\(zero\)
[ 0-9a-f]+:	6080 2000 	pref	0x4,0\(zero\)
[ 0-9a-f]+:	60a0 2000 	pref	0x5,0\(zero\)
[ 0-9a-f]+:	60c0 2000 	pref	0x6,0\(zero\)
[ 0-9a-f]+:	60e0 2000 	pref	0x7,0\(zero\)
[ 0-9a-f]+:	60e0 207f 	pref	0x7,127\(zero\)
[ 0-9a-f]+:	60e0 2180 	pref	0x7,-128\(zero\)
[ 0-9a-f]+:	63e0 20ff 	pref	0x1f,255\(zero\)
[ 0-9a-f]+:	63e0 2100 	pref	0x1f,-256\(zero\)
[ 0-9a-f]+:	3020 0100 	li	at,256
[ 0-9a-f]+:	63e1 2000 	pref	0x1f,0\(at\)
[ 0-9a-f]+:	3020 feff 	li	at,-257
[ 0-9a-f]+:	63e1 2000 	pref	0x1f,0\(at\)
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	6061 2000 	pref	0x3,0\(at\)
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	6061 2000 	pref	0x3,0\(at\)
[ 0-9a-f]+:	63e2 20ff 	pref	0x1f,255\(v0\)
[ 0-9a-f]+:	63e2 2100 	pref	0x1f,-256\(v0\)
[ 0-9a-f]+:	3022 0100 	addiu	at,v0,256
[ 0-9a-f]+:	63e1 2000 	pref	0x1f,0\(at\)
[ 0-9a-f]+:	3022 feff 	addiu	at,v0,-257
[ 0-9a-f]+:	63e1 2000 	pref	0x1f,0\(at\)
[ 0-9a-f]+:	3022 7fff 	addiu	at,v0,32767
[ 0-9a-f]+:	6061 2000 	pref	0x3,0\(at\)
[ 0-9a-f]+:	3022 8000 	addiu	at,v0,-32768
[ 0-9a-f]+:	6061 2000 	pref	0x3,0\(at\)
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	0000 0000 	nop
[ 0-9a-f]+:	0000 0800 	ssnop
[ 0-9a-f]+:	0000 1800 	ehb
[ 0-9a-f]+:	0000 2800 	pause
[ 0-9a-f]+:	ed7f      	li	v0,-1
[ 0-9a-f]+:	edff      	li	v1,-1
[ 0-9a-f]+:	ee7f      	li	a0,-1
[ 0-9a-f]+:	eeff      	li	a1,-1
[ 0-9a-f]+:	ef7f      	li	a2,-1
[ 0-9a-f]+:	efff      	li	a3,-1
[ 0-9a-f]+:	ec7f      	li	s0,-1
[ 0-9a-f]+:	ecff      	li	s1,-1
[ 0-9a-f]+:	ec80      	li	s1,0
[ 0-9a-f]+:	ecfd      	li	s1,125
[ 0-9a-f]+:	ecfe      	li	s1,126
[ 0-9a-f]+:	3220 007f 	li	s1,127
[ 0-9a-f]+:	3040 0000 	li	v0,0
[ 0-9a-f]+:	3040 0001 	li	v0,1
[ 0-9a-f]+:	3040 7fff 	li	v0,32767
[ 0-9a-f]+:	3040 8000 	li	v0,-32768
[ 0-9a-f]+:	5040 ffff 	li	v0,0xffff
[ 0-9a-f]+:	1040 0001 	lui	v0,0x1
[ 0-9a-f]+:	3040 8000 	li	v0,-32768
[ 0-9a-f]+:	3040 8001 	li	v0,-32767
[ 0-9a-f]+:	3040 ffff 	li	v0,-1
[ 0-9a-f]+:	1040 1234 	lui	v0,0x1234
[ 0-9a-f]+:	5042 5678 	ori	v0,v0,0x5678
[ 0-9a-f]+:	0c16      	move	zero,s6
[ 0-9a-f]+:	0c56      	move	v0,s6
[ 0-9a-f]+:	0c76      	move	v1,s6
[ 0-9a-f]+:	0c96      	move	a0,s6
[ 0-9a-f]+:	0cb6      	move	a1,s6
[ 0-9a-f]+:	0cd6      	move	a2,s6
[ 0-9a-f]+:	0cf6      	move	a3,s6
[ 0-9a-f]+:	0d16      	move	t0,s6
[ 0-9a-f]+:	0d36      	move	t1,s6
[ 0-9a-f]+:	0d56      	move	t2,s6
[ 0-9a-f]+:	0fd6      	move	s8,s6
[ 0-9a-f]+:	0ff6      	move	ra,s6
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	0c02      	move	zero,v0
[ 0-9a-f]+:	0c03      	move	zero,v1
[ 0-9a-f]+:	0c04      	move	zero,a0
[ 0-9a-f]+:	0c05      	move	zero,a1
[ 0-9a-f]+:	0c06      	move	zero,a2
[ 0-9a-f]+:	0c07      	move	zero,a3
[ 0-9a-f]+:	0c08      	move	zero,t0
[ 0-9a-f]+:	0c09      	move	zero,t1
[ 0-9a-f]+:	0c0a      	move	zero,t2
[ 0-9a-f]+:	0c1e      	move	zero,s8
[ 0-9a-f]+:	0c1f      	move	zero,ra
[ 0-9a-f]+:	0ec2      	move	s6,v0
[ 0-9a-f]+:	0c56      	move	v0,s6
[ 0-9a-f]+:	0ec2      	move	s6,v0
[ 0-9a-f]+:	0016 1290 	move	v0,s6
[ 0-9a-f]+:	0002 b290 	move	s6,v0
[ 0-9a-f]+:	cfff      	bc	[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	test
[ 0-9a-f]+:	cfff      	bc	[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	test
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	97ff fffe 	bc	[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	test
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	cfff      	bc	[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	.L11
[ 0-9a-f]+:	cfff      	bc	[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	.L11
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	97ff fffe 	bc	[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	.L11

[ 0-9a-f]+ <.L11>:
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	cfff      	bc	[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	.L11
[ 0-9a-f]+:	cfff      	bc	[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC10_S1	.L11
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	97ff fffe 	bc	[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	.L11
[ 0-9a-f]+:	0c43      	move	v0,v1
[ 0-9a-f]+:	f463 fffe 	bgezc	v1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L0
[ 0-9a-f]+:	0060 1190 	neg	v0,v1

[ 0-9a-f]+ <.L0>:
[ 0-9a-f]+:	0c44      	move	v0,a0
[ 0-9a-f]+:	f484 fffe 	bgezc	a0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L1
[ 0-9a-f]+:	0080 1190 	neg	v0,a0

[ 0-9a-f]+ <.L1>:
[ 0-9a-f]+:	f442 fffe 	bgezc	v0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L2
[ 0-9a-f]+:	0040 1190 	neg	v0,v0

[ 0-9a-f]+ <.L2>:
[ 0-9a-f]+:	f442 fffe 	bgezc	v0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L3
[ 0-9a-f]+:	0040 1190 	neg	v0,v0

[ 0-9a-f]+ <.L3>:
[ 0-9a-f]+:	0083 1110 	add	v0,v1,a0
[ 0-9a-f]+:	03fe e910 	add	sp,s8,ra
[ 0-9a-f]+:	0082 1110 	add	v0,v0,a0
[ 0-9a-f]+:	0082 1110 	add	v0,v0,a0
[ 0-9a-f]+:	4c10      	addiu	zero,zero,-8
[ 0-9a-f]+:	4c50      	addiu	v0,v0,-8
[ 0-9a-f]+:	4c70      	addiu	v1,v1,-8
[ 0-9a-f]+:	4c90      	addiu	a0,a0,-8
[ 0-9a-f]+:	4cb0      	addiu	a1,a1,-8
[ 0-9a-f]+:	4cd0      	addiu	a2,a2,-8
[ 0-9a-f]+:	4cf0      	addiu	a3,a3,-8
[ 0-9a-f]+:	4d10      	addiu	t0,t0,-8
[ 0-9a-f]+:	4d30      	addiu	t1,t1,-8
[ 0-9a-f]+:	4d50      	addiu	t2,t2,-8
[ 0-9a-f]+:	4fd0      	addiu	s8,s8,-8
[ 0-9a-f]+:	4ff0      	addiu	ra,ra,-8
[ 0-9a-f]+:	4ff2      	addiu	ra,ra,-7
[ 0-9a-f]+:	4fe0      	addiu	ra,ra,0
[ 0-9a-f]+:	4fe2      	addiu	ra,ra,1
[ 0-9a-f]+:	4fec      	addiu	ra,ra,6
[ 0-9a-f]+:	4fee      	addiu	ra,ra,7
[ 0-9a-f]+:	33ff 0008 	addiu	ra,ra,8
[ 0-9a-f]+:	4ffd      	addiu	sp,sp,-1032
[ 0-9a-f]+:	4fff      	addiu	sp,sp,-1028
[ 0-9a-f]+:	4e01      	addiu	sp,sp,-1024
[ 0-9a-f]+:	4dff      	addiu	sp,sp,1020
[ 0-9a-f]+:	4c01      	addiu	sp,sp,1024
[ 0-9a-f]+:	4c03      	addiu	sp,sp,1028
[ 0-9a-f]+:	4c03      	addiu	sp,sp,1028
[ 0-9a-f]+:	33bd 0408 	addiu	sp,sp,1032
[ 0-9a-f]+:	6d2e      	addiu	v0,v0,-1
[ 0-9a-f]+:	6d3e      	addiu	v0,v1,-1
[ 0-9a-f]+:	6d4e      	addiu	v0,a0,-1
[ 0-9a-f]+:	6d5e      	addiu	v0,a1,-1
[ 0-9a-f]+:	6d6e      	addiu	v0,a2,-1
[ 0-9a-f]+:	6d7e      	addiu	v0,a3,-1
[ 0-9a-f]+:	6d0e      	addiu	v0,s0,-1
[ 0-9a-f]+:	6d1e      	addiu	v0,s1,-1
[ 0-9a-f]+:	6d10      	addiu	v0,s1,1
[ 0-9a-f]+:	6d12      	addiu	v0,s1,4
[ 0-9a-f]+:	6d14      	addiu	v0,s1,8
[ 0-9a-f]+:	6d16      	addiu	v0,s1,12
[ 0-9a-f]+:	6d18      	addiu	v0,s1,16
[ 0-9a-f]+:	6d1a      	addiu	v0,s1,20
[ 0-9a-f]+:	6d1c      	addiu	v0,s1,24
[ 0-9a-f]+:	6d9c      	addiu	v1,s1,24
[ 0-9a-f]+:	6e1c      	addiu	a0,s1,24
[ 0-9a-f]+:	6e9c      	addiu	a1,s1,24
[ 0-9a-f]+:	6f1c      	addiu	a2,s1,24
[ 0-9a-f]+:	6f9c      	addiu	a3,s1,24
[ 0-9a-f]+:	6c1c      	addiu	s0,s1,24
[ 0-9a-f]+:	6c9c      	addiu	s1,s1,24
[ 0-9a-f]+:	0c5d      	move	v0,sp
[ 0-9a-f]+:	6d03      	addiu	v0,sp,4
[ 0-9a-f]+:	6d7d      	addiu	v0,sp,248
[ 0-9a-f]+:	6d7f      	addiu	v0,sp,252
[ 0-9a-f]+:	305d 0100 	addiu	v0,sp,256
[ 0-9a-f]+:	6d7f      	addiu	v0,sp,252
[ 0-9a-f]+:	6dff      	addiu	v1,sp,252
[ 0-9a-f]+:	6e7f      	addiu	a0,sp,252
[ 0-9a-f]+:	6eff      	addiu	a1,sp,252
[ 0-9a-f]+:	6f7f      	addiu	a2,sp,252
[ 0-9a-f]+:	6fff      	addiu	a3,sp,252
[ 0-9a-f]+:	6c7f      	addiu	s0,sp,252
[ 0-9a-f]+:	6cff      	addiu	s1,sp,252
[ 0-9a-f]+:	3064 8000 	addiu	v1,a0,-32768
[ 0-9a-f]+:	0c64      	move	v1,a0
[ 0-9a-f]+:	3064 7fff 	addiu	v1,a0,32767
[ 0-9a-f]+:	3064 ffff 	addiu	v1,a0,-1
[ 0-9a-f]+:	3063 ffff 	addiu	v1,v1,-1
[ 0-9a-f]+:	3063 ffff 	addiu	v1,v1,-1
[ 0-9a-f]+:	0c56      	move	v0,s6
[ 0-9a-f]+:	0ec2      	move	s6,v0
[ 0-9a-f]+:	0c56      	move	v0,s6
[ 0-9a-f]+:	0ec2      	move	s6,v0
[ 0-9a-f]+:	05a4      	addu	v0,v1,v0
[ 0-9a-f]+:	05b4      	addu	v0,v1,v1
[ 0-9a-f]+:	05c4      	addu	v0,v1,a0
[ 0-9a-f]+:	05d4      	addu	v0,v1,a1
[ 0-9a-f]+:	05e4      	addu	v0,v1,a2
[ 0-9a-f]+:	05f4      	addu	v0,v1,a3
[ 0-9a-f]+:	0584      	addu	v0,v1,s0
[ 0-9a-f]+:	0594      	addu	v0,v1,s1
[ 0-9a-f]+:	0514      	addu	v0,v0,s1
[ 0-9a-f]+:	0594      	addu	v0,v1,s1
[ 0-9a-f]+:	0614      	addu	v0,a0,s1
[ 0-9a-f]+:	0694      	addu	v0,a1,s1
[ 0-9a-f]+:	0714      	addu	v0,a2,s1
[ 0-9a-f]+:	0794      	addu	v0,a3,s1
[ 0-9a-f]+:	0414      	addu	v0,s0,s1
[ 0-9a-f]+:	0494      	addu	v0,s1,s1
[ 0-9a-f]+:	0514      	addu	v0,v0,s1
[ 0-9a-f]+:	0516      	addu	v1,v0,s1
[ 0-9a-f]+:	0518      	addu	a0,v0,s1
[ 0-9a-f]+:	051a      	addu	a1,v0,s1
[ 0-9a-f]+:	051c      	addu	a2,v0,s1
[ 0-9a-f]+:	051e      	addu	a3,v0,s1
[ 0-9a-f]+:	0510      	addu	s0,v0,s1
[ 0-9a-f]+:	0512      	addu	s1,v0,s1
[ 0-9a-f]+:	07ae      	addu	a3,a3,v0
[ 0-9a-f]+:	07ae      	addu	a3,a3,v0
[ 0-9a-f]+:	057e      	addu	a3,v0,a3
[ 0-9a-f]+:	03fe e950 	addu	sp,s8,ra
[ 0-9a-f]+:	3042 0000 	addiu	v0,v0,0
[ 0-9a-f]+:	3042 0001 	addiu	v0,v0,1
[ 0-9a-f]+:	3042 7fff 	addiu	v0,v0,32767
[ 0-9a-f]+:	3042 8000 	addiu	v0,v0,-32768
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	0022 1150 	addu	v0,v0,at
[ 0-9a-f]+:	4521      	and	v0,v0,v0
[ 0-9a-f]+:	4531      	and	v0,v0,v1
[ 0-9a-f]+:	4541      	and	v0,v0,a0
[ 0-9a-f]+:	4551      	and	v0,v0,a1
[ 0-9a-f]+:	4561      	and	v0,v0,a2
[ 0-9a-f]+:	4571      	and	v0,v0,a3
[ 0-9a-f]+:	4501      	and	v0,v0,s0
[ 0-9a-f]+:	4511      	and	v0,v0,s1
[ 0-9a-f]+:	45a1      	and	v1,v1,v0
[ 0-9a-f]+:	4621      	and	a0,a0,v0
[ 0-9a-f]+:	46a1      	and	a1,a1,v0
[ 0-9a-f]+:	4721      	and	a2,a2,v0
[ 0-9a-f]+:	47a1      	and	a3,a3,v0
[ 0-9a-f]+:	4421      	and	s0,s0,v0
[ 0-9a-f]+:	44a1      	and	s1,s1,v0
[ 0-9a-f]+:	4531      	and	v0,v0,v1
[ 0-9a-f]+:	4531      	and	v0,v0,v1
[ 0-9a-f]+:	4531      	and	v0,v0,v1
[ 0-9a-f]+:	4531      	and	v0,v0,v1
[ 0-9a-f]+:	0062 1250 	and	v0,v0,v1
[ 0-9a-f]+:	2d21      	andi	v0,v0,0x1
[ 0-9a-f]+:	2d22      	andi	v0,v0,0x2
[ 0-9a-f]+:	2d23      	andi	v0,v0,0x3
[ 0-9a-f]+:	2d24      	andi	v0,v0,0x4
[ 0-9a-f]+:	2d25      	andi	v0,v0,0x7
[ 0-9a-f]+:	2d26      	andi	v0,v0,0x8
[ 0-9a-f]+:	2d27      	andi	v0,v0,0xf
[ 0-9a-f]+:	2d28      	andi	v0,v0,0x10
[ 0-9a-f]+:	2d29      	andi	v0,v0,0x1f
[ 0-9a-f]+:	2d2a      	andi	v0,v0,0x20
[ 0-9a-f]+:	2d2b      	andi	v0,v0,0x3f
[ 0-9a-f]+:	2d2c      	andi	v0,v0,0x40
[ 0-9a-f]+:	2d20      	andi	v0,v0,0x80
[ 0-9a-f]+:	2d2d      	andi	v0,v0,0xff
[ 0-9a-f]+:	2d2e      	andi	v0,v0,0x8000
[ 0-9a-f]+:	2d2f      	andi	v0,v0,0xffff
[ 0-9a-f]+:	2d3f      	andi	v0,v1,0xffff
[ 0-9a-f]+:	2d4f      	andi	v0,a0,0xffff
[ 0-9a-f]+:	2d5f      	andi	v0,a1,0xffff
[ 0-9a-f]+:	2d6f      	andi	v0,a2,0xffff
[ 0-9a-f]+:	2d7f      	andi	v0,a3,0xffff
[ 0-9a-f]+:	2d0f      	andi	v0,s0,0xffff
[ 0-9a-f]+:	2d1f      	andi	v0,s1,0xffff
[ 0-9a-f]+:	2d9f      	andi	v1,s1,0xffff
[ 0-9a-f]+:	2e1f      	andi	a0,s1,0xffff
[ 0-9a-f]+:	2e9f      	andi	a1,s1,0xffff
[ 0-9a-f]+:	2f1f      	andi	a2,s1,0xffff
[ 0-9a-f]+:	2f9f      	andi	a3,s1,0xffff
[ 0-9a-f]+:	2c1f      	andi	s0,s1,0xffff
[ 0-9a-f]+:	2c9f      	andi	s1,s1,0xffff
[ 0-9a-f]+:	2fff      	andi	a3,a3,0xffff
[ 0-9a-f]+:	2fff      	andi	a3,a3,0xffff
[ 0-9a-f]+:	2fff      	andi	a3,a3,0xffff
[ 0-9a-f]+:	d0e7 ffff 	andi	a3,a3,0xffff
[ 0-9a-f]+:	0083 1250 	and	v0,v1,a0
[ 0-9a-f]+:	0082 1250 	and	v0,v0,a0
[ 0-9a-f]+:	0082 1250 	and	v0,v0,a0
[ 0-9a-f]+:	d043 0000 	andi	v0,v1,0x0
[ 0-9a-f]+:	d043 ffff 	andi	v0,v1,0xffff
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0023 1250 	and	v0,v1,at
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	5021 0001 	ori	at,at,0x1
[ 0-9a-f]+:	0023 1250 	and	v0,v1,at

[ 0-9a-f]+ <test2>:
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8d7f      	beqzc	v0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8dff      	beqzc	v1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8e7f      	beqzc	a0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8eff      	beqzc	a1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8f7f      	beqzc	a2,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8fff      	beqzc	a3,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8c7f      	beqzc	s0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8cff      	beqzc	s1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8d7f      	beqzc	v0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8dff      	beqzc	v1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8e7f      	beqzc	a0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8eff      	beqzc	a1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8f7f      	beqzc	a2,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8fff      	beqzc	a3,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8c7f      	beqzc	s0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8cff      	beqzc	s1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8d7f      	beqzc	v0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8dff      	beqzc	v1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8e7f      	beqzc	a0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8eff      	beqzc	a1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8f7f      	beqzc	a2,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8fff      	beqzc	a3,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8c7f      	beqzc	s0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8cff      	beqzc	s1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	8c7f      	beqzc	s0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	821f fffe 	beqzc	s0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	8cff      	beqzc	s1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	823f fffe 	beqzc	s1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	test2
[ 0-9a-f]+:	8cff      	beqzc	s1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	821f fffe 	beqzc	s0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	test2
[ 0-9a-f]+:	3020 000a 	li	at,10
[ 0-9a-f]+:	7601 fffe 	beqc	at,s0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	test2
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	7601 fffe 	beqc	at,s0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	test2
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	7601 fffe 	beqc	at,s0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	ad7f      	bnezc	v0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	adff      	bnezc	v1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	ae7f      	bnezc	a0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	aeff      	bnezc	a1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	af7f      	bnezc	a2,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	afff      	bnezc	a3,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	ac7f      	bnezc	s0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	acff      	bnezc	s1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	ad7f      	bnezc	v0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	adff      	bnezc	v1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	ae7f      	bnezc	a0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	aeff      	bnezc	a1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	af7f      	bnezc	a2,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	afff      	bnezc	a3,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	ac7f      	bnezc	s0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	acff      	bnezc	s1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	ad7f      	bnezc	v0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	adff      	bnezc	v1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	ae7f      	bnezc	a0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	aeff      	bnezc	a1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	af7f      	bnezc	a2,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	afff      	bnezc	a3,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	ac7f      	bnezc	s0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	acff      	bnezc	s1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	ac7f      	bnezc	s0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC7_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	a21f fffe 	bnezc	s0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	test3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	a23f fffe 	bnezc	s1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	test2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	a23f fffe 	bnezc	s1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	test2

[ 0-9a-f]+ <test3>:
[ 0-9a-f]+:	a23f fffe 	bnezc	s1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC21_S1	test2
[ 0-9a-f]+:	441b      	break
[ 0-9a-f]+:	441b      	break
[ 0-9a-f]+:	445b      	break	0x1
[ 0-9a-f]+:	449b      	break	0x2
[ 0-9a-f]+:	44db      	break	0x3
[ 0-9a-f]+:	451b      	break	0x4
[ 0-9a-f]+:	455b      	break	0x5
[ 0-9a-f]+:	459b      	break	0x6
[ 0-9a-f]+:	45db      	break	0x7
[ 0-9a-f]+:	461b      	break	0x8
[ 0-9a-f]+:	465b      	break	0x9
[ 0-9a-f]+:	469b      	break	0xa
[ 0-9a-f]+:	46db      	break	0xb
[ 0-9a-f]+:	471b      	break	0xc
[ 0-9a-f]+:	475b      	break	0xd
[ 0-9a-f]+:	479b      	break	0xe
[ 0-9a-f]+:	47db      	break	0xf
[ 0-9a-f]+:	003f 0007 	break	0x3f
[ 0-9a-f]+:	0040 0007 	break	0x40
[ 0-9a-f]+:	03ff 0007 	break	0x3ff
[ 0-9a-f]+:	03ff ffc7 	break	0x3ff,0x3ff
[ 0-9a-f]+:	0000 0007 	break
[ 0-9a-f]+:	0000 0007 	break
[ 0-9a-f]+:	0001 0007 	break	0x1
[ 0-9a-f]+:	0002 0007 	break	0x2
[ 0-9a-f]+:	000f 0007 	break	0xf
[ 0-9a-f]+:	003f 0007 	break	0x3f
[ 0-9a-f]+:	0040 0007 	break	0x40
[ 0-9a-f]+:	03ff 0007 	break	0x3ff
[ 0-9a-f]+:	03ff ffc7 	break	0x3ff,0x3ff
[ 0-9a-f]+:	2000 6000 	cache	0x0,0\(zero\)
[ 0-9a-f]+:	2000 6100 	cache	0x0,-256\(zero\)
[ 0-9a-f]+:	2000 60ff 	cache	0x0,255\(zero\)
[ 0-9a-f]+:	3020 feff 	li	at,-257
[ 0-9a-f]+:	2001 6000 	cache	0x0,0\(at\)
[ 0-9a-f]+:	3020 0100 	li	at,256
[ 0-9a-f]+:	2001 6000 	cache	0x0,0\(at\)
[ 0-9a-f]+:	2002 6000 	cache	0x0,0\(v0\)
[ 0-9a-f]+:	2002 6100 	cache	0x0,-256\(v0\)
[ 0-9a-f]+:	2002 60ff 	cache	0x0,255\(v0\)
[ 0-9a-f]+:	3022 feff 	addiu	at,v0,-257
[ 0-9a-f]+:	2001 6000 	cache	0x0,0\(at\)
[ 0-9a-f]+:	3022 0100 	addiu	at,v0,256
[ 0-9a-f]+:	2001 6000 	cache	0x0,0\(at\)
[ 0-9a-f]+:	2000 6000 	cache	0x0,0\(zero\)
[ 0-9a-f]+:	2000 6000 	cache	0x0,0\(zero\)
[ 0-9a-f]+:	2020 6000 	cache	0x1,0\(zero\)
[ 0-9a-f]+:	2040 6000 	cache	0x2,0\(zero\)
[ 0-9a-f]+:	2060 6000 	cache	0x3,0\(zero\)
[ 0-9a-f]+:	2080 6000 	cache	0x4,0\(zero\)
[ 0-9a-f]+:	20a0 6000 	cache	0x5,0\(zero\)
[ 0-9a-f]+:	20c0 6000 	cache	0x6,0\(zero\)
[ 0-9a-f]+:	23e0 6000 	cache	0x1f,0\(zero\)
[ 0-9a-f]+:	23e0 60ff 	cache	0x1f,255\(zero\)
[ 0-9a-f]+:	23e0 6100 	cache	0x1f,-256\(zero\)
[ 0-9a-f]+:	2000 60ff 	cache	0x0,255\(zero\)
[ 0-9a-f]+:	2000 6100 	cache	0x0,-256\(zero\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0061 0950 	addu	at,at,v1
[ 0-9a-f]+:	23e1 6000 	cache	0x1f,0\(at\)
[ 0-9a-f]+:	3023 0100 	addiu	at,v1,256
[ 0-9a-f]+:	23e1 6000 	cache	0x1f,0\(at\)
[ 0-9a-f]+:	3023 feff 	addiu	at,v1,-257
[ 0-9a-f]+:	23e1 6000 	cache	0x1f,0\(at\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0061 0950 	addu	at,at,v1
[ 0-9a-f]+:	23e1 6001 	cache	0x1f,1\(at\)
[ 0-9a-f]+:	23e3 61ff 	cache	0x1f,-1\(v1\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0061 0950 	addu	at,at,v1
[ 0-9a-f]+:	23e1 6000 	cache	0x1f,0\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0061 0950 	addu	at,at,v1
[ 0-9a-f]+:	23e1 6001 	cache	0x1f,1\(at\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0061 0950 	addu	at,at,v1
[ 0-9a-f]+:	23e1 61ff 	cache	0x1f,-1\(at\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	23e1 6000 	cache	0x1f,0\(at\)
[ 0-9a-f]+:	3020 0100 	li	at,256
[ 0-9a-f]+:	23e1 6000 	cache	0x1f,0\(at\)
[ 0-9a-f]+:	3020 feff 	li	at,-257
[ 0-9a-f]+:	23e1 6000 	cache	0x1f,0\(at\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	23e1 6001 	cache	0x1f,1\(at\)
[ 0-9a-f]+:	23e0 61ff 	cache	0x1f,-1\(zero\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	23e1 6000 	cache	0x1f,0\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	23e1 6001 	cache	0x1f,1\(at\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	23e1 61ff 	cache	0x1f,-1\(at\)
[ 0-9a-f]+:	0043 4b3c 	clo	v0,v1
[ 0-9a-f]+:	0062 4b3c 	clo	v1,v0
[ 0-9a-f]+:	0043 5b3c 	clz	v0,v1
[ 0-9a-f]+:	0062 5b3c 	clz	v1,v0
[ 0-9a-f]+:	0000 e37c 	deret
[ 0-9a-f]+:	0000 477c 	di
[ 0-9a-f]+:	0000 477c 	di
[ 0-9a-f]+:	0002 477c 	di	v0
[ 0-9a-f]+:	0003 477c 	di	v1
[ 0-9a-f]+:	001e 477c 	di	s8
[ 0-9a-f]+:	001f 477c 	di	ra
[ 0-9a-f]+:	0062 0118 	div	zero,v0,v1
[ 0-9a-f]+:	03fe 0118 	div	zero,s8,ra
[ 0-9a-f]+:	0060 0118 	div	zero,zero,v1
[ 0-9a-f]+:	03e0 0118 	div	zero,zero,ra
[ 0-9a-f]+:	0003 1118 	div	v0,v1,zero
[ 0-9a-f]+:	0083 1118 	div	v0,v1,a0
[ 0-9a-f]+:	0062 0198 	divu	zero,v0,v1
[ 0-9a-f]+:	03fe 0198 	divu	zero,s8,ra
[ 0-9a-f]+:	0060 0198 	divu	zero,zero,v1
[ 0-9a-f]+:	03e0 0198 	divu	zero,zero,ra
[ 0-9a-f]+:	0003 1198 	divu	v0,v1,zero
[ 0-9a-f]+:	0083 1198 	divu	v0,v1,a0
[ 0-9a-f]+:	0000 577c 	ei
[ 0-9a-f]+:	0000 577c 	ei
[ 0-9a-f]+:	0002 577c 	ei	v0
[ 0-9a-f]+:	0003 577c 	ei	v1
[ 0-9a-f]+:	001e 577c 	ei	s8
[ 0-9a-f]+:	001f 577c 	ei	ra
[ 0-9a-f]+:	0000 f37c 	eret
[ 0-9a-f]+:	0043 716c 	ext	v0,v1,0x5,0xf
[ 0-9a-f]+:	0043 f82c 	ext	v0,v1,0x0,0x20
[ 0-9a-f]+:	0043 07ec 	ext	v0,v1,0x1f,0x1
[ 0-9a-f]+:	03fe 07ec 	ext	ra,s8,0x1f,0x1
[ 0-9a-f]+:	0043 994c 	ins	v0,v1,0x5,0xf
[ 0-9a-f]+:	0043 f80c 	ins	v0,v1,0x0,0x20
[ 0-9a-f]+:	0043 ffcc 	ins	v0,v1,0x1f,0x1
[ 0-9a-f]+:	03fe ffcc 	ins	ra,s8,0x1f,0x1
[ 0-9a-f]+:	4403      	jrc	zero
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	4443      	jrc	v0
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	4463      	jrc	v1
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	4483      	jrc	a0
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	44a3      	jrc	a1
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	44c3      	jrc	a2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	44e3      	jrc	a3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	4503      	jrc	t0
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	47c3      	jrc	s8
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	47e3      	jrc	ra
[ 0-9a-f]+:	8000 0000 	jrc	zero
[ 0-9a-f]+:	8002 0000 	jrc	v0
[ 0-9a-f]+:	8003 0000 	jrc	v1
[ 0-9a-f]+:	8004 0000 	jrc	a0
[ 0-9a-f]+:	8005 0000 	jrc	a1
[ 0-9a-f]+:	8006 0000 	jrc	a2
[ 0-9a-f]+:	8007 0000 	jrc	a3
[ 0-9a-f]+:	8008 0000 	jrc	t0
[ 0-9a-f]+:	801e 0000 	jrc	s8
[ 0-9a-f]+:	801f 0000 	jrc	ra
[ 0-9a-f]+:	4403      	jrc	zero
[ 0-9a-f]+:	4443      	jrc	v0
[ 0-9a-f]+:	4463      	jrc	v1
[ 0-9a-f]+:	4483      	jrc	a0
[ 0-9a-f]+:	44a3      	jrc	a1
[ 0-9a-f]+:	44c3      	jrc	a2
[ 0-9a-f]+:	44e3      	jrc	a3
[ 0-9a-f]+:	4503      	jrc	t0
[ 0-9a-f]+:	47c3      	jrc	s8
[ 0-9a-f]+:	47e3      	jrc	ra
[ 0-9a-f]+:	0000 1f3c 	jrc.hb	zero
[ 0-9a-f]+:	0002 1f3c 	jrc.hb	v0
[ 0-9a-f]+:	0003 1f3c 	jrc.hb	v1
[ 0-9a-f]+:	0004 1f3c 	jrc.hb	a0
[ 0-9a-f]+:	0005 1f3c 	jrc.hb	a1
[ 0-9a-f]+:	0006 1f3c 	jrc.hb	a2
[ 0-9a-f]+:	0007 1f3c 	jrc.hb	a3
[ 0-9a-f]+:	0008 1f3c 	jrc.hb	t0
[ 0-9a-f]+:	001e 1f3c 	jrc.hb	s8
[ 0-9a-f]+:	001f 1f3c 	jrc.hb	ra
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	4403      	jrc	zero
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	4443      	jrc	v0
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	4463      	jrc	v1
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	4483      	jrc	a0
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	44a3      	jrc	a1
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	44c3      	jrc	a2
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	44e3      	jrc	a3
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	4503      	jrc	t0
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	47c3      	jrc	s8
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	47e3      	jrc	ra
[ 0-9a-f]+:	440b      	jalrc	zero
[ 0-9a-f]+:	444b      	jalrc	v0
[ 0-9a-f]+:	446b      	jalrc	v1
[ 0-9a-f]+:	448b      	jalrc	a0
[ 0-9a-f]+:	44ab      	jalrc	a1
[ 0-9a-f]+:	44cb      	jalrc	a2
[ 0-9a-f]+:	44eb      	jalrc	a3
[ 0-9a-f]+:	450b      	jalrc	t0
[ 0-9a-f]+:	47cb      	jalrc	s8
[ 0-9a-f]+:	03e0 0f3c 	jalrc	zero
[ 0-9a-f]+:	03e2 0f3c 	jalrc	v0
[ 0-9a-f]+:	03e3 0f3c 	jalrc	v1
[ 0-9a-f]+:	03e4 0f3c 	jalrc	a0
[ 0-9a-f]+:	03e5 0f3c 	jalrc	a1
[ 0-9a-f]+:	03e6 0f3c 	jalrc	a2
[ 0-9a-f]+:	03e7 0f3c 	jalrc	a3
[ 0-9a-f]+:	03e8 0f3c 	jalrc	t0
[ 0-9a-f]+:	03fe 0f3c 	jalrc	s8
[ 0-9a-f]+:	440b      	jalrc	zero
[ 0-9a-f]+:	444b      	jalrc	v0
[ 0-9a-f]+:	446b      	jalrc	v1
[ 0-9a-f]+:	448b      	jalrc	a0
[ 0-9a-f]+:	44ab      	jalrc	a1
[ 0-9a-f]+:	44cb      	jalrc	a2
[ 0-9a-f]+:	44eb      	jalrc	a3
[ 0-9a-f]+:	450b      	jalrc	t0
[ 0-9a-f]+:	47cb      	jalrc	s8
[ 0-9a-f]+:	03df 0f3c 	jalrc	s8,ra
[ 0-9a-f]+:	0040 0f3c 	jalrc	v0,zero
[ 0-9a-f]+:	0062 0f3c 	jalrc	v1,v0
[ 0-9a-f]+:	0043 0f3c 	jalrc	v0,v1
[ 0-9a-f]+:	0044 0f3c 	jalrc	v0,a0
[ 0-9a-f]+:	0045 0f3c 	jalrc	v0,a1
[ 0-9a-f]+:	0046 0f3c 	jalrc	v0,a2
[ 0-9a-f]+:	0047 0f3c 	jalrc	v0,a3
[ 0-9a-f]+:	0048 0f3c 	jalrc	v0,t0
[ 0-9a-f]+:	005e 0f3c 	jalrc	v0,s8
[ 0-9a-f]+:	005f 0f3c 	jalrc	v0,ra
[ 0-9a-f]+:	03e0 1f3c 	jalrc.hb	zero
[ 0-9a-f]+:	03e2 1f3c 	jalrc.hb	v0
[ 0-9a-f]+:	03e3 1f3c 	jalrc.hb	v1
[ 0-9a-f]+:	03e4 1f3c 	jalrc.hb	a0
[ 0-9a-f]+:	03e5 1f3c 	jalrc.hb	a1
[ 0-9a-f]+:	03e6 1f3c 	jalrc.hb	a2
[ 0-9a-f]+:	03e7 1f3c 	jalrc.hb	a3
[ 0-9a-f]+:	03e8 1f3c 	jalrc.hb	t0
[ 0-9a-f]+:	03fe 1f3c 	jalrc.hb	s8
[ 0-9a-f]+:	03e0 1f3c 	jalrc.hb	zero
[ 0-9a-f]+:	03e2 1f3c 	jalrc.hb	v0
[ 0-9a-f]+:	03e3 1f3c 	jalrc.hb	v1
[ 0-9a-f]+:	03e4 1f3c 	jalrc.hb	a0
[ 0-9a-f]+:	03e5 1f3c 	jalrc.hb	a1
[ 0-9a-f]+:	03e6 1f3c 	jalrc.hb	a2
[ 0-9a-f]+:	03e7 1f3c 	jalrc.hb	a3
[ 0-9a-f]+:	03e8 1f3c 	jalrc.hb	t0
[ 0-9a-f]+:	03fe 1f3c 	jalrc.hb	s8
[ 0-9a-f]+:	03df 1f3c 	jalrc.hb	s8,ra
[ 0-9a-f]+:	0040 1f3c 	jalrc.hb	v0,zero
[ 0-9a-f]+:	0062 1f3c 	jalrc.hb	v1,v0
[ 0-9a-f]+:	0043 1f3c 	jalrc.hb	v0,v1
[ 0-9a-f]+:	0044 1f3c 	jalrc.hb	v0,a0
[ 0-9a-f]+:	0045 1f3c 	jalrc.hb	v0,a1
[ 0-9a-f]+:	0046 1f3c 	jalrc.hb	v0,a2
[ 0-9a-f]+:	0047 1f3c 	jalrc.hb	v0,a3
[ 0-9a-f]+:	0048 1f3c 	jalrc.hb	v0,t0
[ 0-9a-f]+:	005e 1f3c 	jalrc.hb	v0,s8
[ 0-9a-f]+:	005f 1f3c 	jalrc.hb	v0,ra
[ 0-9a-f]+:	0043 0f3c 	jalrc	v0,v1
[ 0-9a-f]+:	03df 0f3c 	jalrc	s8,ra
[ 0-9a-f]+:	446b      	jalrc	v1
[ 0-9a-f]+:	47eb      	jalrc	ra
[ 0-9a-f]+:	b7ff fffe 	balc	[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	test
[ 0-9a-f]+:	b7ff fffe 	balc	[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	test2
[ 0-9a-f]+:	1040 0000 	lui	v0,0x0
[	]*[0-9a-f]+: R_MICROMIPS_HI16	test
[ 0-9a-f]+:	3042 0000 	addiu	v0,v0,0
[	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	1040 0000 	lui	v0,0x0
[	]*[0-9a-f]+: R_MICROMIPS_HI16	test
[ 0-9a-f]+:	3042 0000 	addiu	v0,v0,0
[	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	1c60 0000 	lb	v1,0\(zero\)
[ 0-9a-f]+:	1c60 0004 	lb	v1,4\(zero\)
[ 0-9a-f]+:	1c60 0000 	lb	v1,0\(zero\)
[ 0-9a-f]+:	1c60 0004 	lb	v1,4\(zero\)
[ 0-9a-f]+:	1c60 7fff 	lb	v1,32767\(zero\)
[ 0-9a-f]+:	1c60 8000 	lb	v1,-32768\(zero\)
[ 0-9a-f]+:	1060 0001 	lui	v1,0x1
[ 0-9a-f]+:	1c63 ffff 	lb	v1,-1\(v1\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	1c63 0000 	lb	v1,0\(v1\)
[ 0-9a-f]+:	1c60 8000 	lb	v1,-32768\(zero\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	1c63 0001 	lb	v1,1\(v1\)
[ 0-9a-f]+:	1c60 8001 	lb	v1,-32767\(zero\)
[ 0-9a-f]+:	1060 f000 	lui	v1,0xf000
[ 0-9a-f]+:	1c63 0000 	lb	v1,0\(v1\)
[ 0-9a-f]+:	1c60 ffff 	lb	v1,-1\(zero\)
[ 0-9a-f]+:	1060 1234 	lui	v1,0x1234
[ 0-9a-f]+:	1c63 5678 	lb	v1,22136\(v1\)
[ 0-9a-f]+:	1c64 0000 	lb	v1,0\(a0\)
[ 0-9a-f]+:	1c64 0000 	lb	v1,0\(a0\)
[ 0-9a-f]+:	1c64 0004 	lb	v1,4\(a0\)
[ 0-9a-f]+:	1c64 7fff 	lb	v1,32767\(a0\)
[ 0-9a-f]+:	1c64 8000 	lb	v1,-32768\(a0\)
[ 0-9a-f]+:	1060 0001 	lui	v1,0x1
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	1c63 ffff 	lb	v1,-1\(v1\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	1c63 0000 	lb	v1,0\(v1\)
[ 0-9a-f]+:	1c64 8000 	lb	v1,-32768\(a0\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	1c63 0001 	lb	v1,1\(v1\)
[ 0-9a-f]+:	1c64 8001 	lb	v1,-32767\(a0\)
[ 0-9a-f]+:	1060 f000 	lui	v1,0xf000
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	1c63 0000 	lb	v1,0\(v1\)
[ 0-9a-f]+:	1c64 ffff 	lb	v1,-1\(a0\)
[ 0-9a-f]+:	1060 1234 	lui	v1,0x1234
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	1c63 5678 	lb	v1,22136\(v1\)
[ 0-9a-f]+:	093f      	lbu	v0,-1\(v1\)
[ 0-9a-f]+:	0930      	lbu	v0,0\(v1\)
[ 0-9a-f]+:	0930      	lbu	v0,0\(v1\)
[ 0-9a-f]+:	0931      	lbu	v0,1\(v1\)
[ 0-9a-f]+:	0932      	lbu	v0,2\(v1\)
[ 0-9a-f]+:	0933      	lbu	v0,3\(v1\)
[ 0-9a-f]+:	0934      	lbu	v0,4\(v1\)
[ 0-9a-f]+:	0935      	lbu	v0,5\(v1\)
[ 0-9a-f]+:	0936      	lbu	v0,6\(v1\)
[ 0-9a-f]+:	0937      	lbu	v0,7\(v1\)
[ 0-9a-f]+:	0938      	lbu	v0,8\(v1\)
[ 0-9a-f]+:	0939      	lbu	v0,9\(v1\)
[ 0-9a-f]+:	093a      	lbu	v0,10\(v1\)
[ 0-9a-f]+:	093b      	lbu	v0,11\(v1\)
[ 0-9a-f]+:	093c      	lbu	v0,12\(v1\)
[ 0-9a-f]+:	093d      	lbu	v0,13\(v1\)
[ 0-9a-f]+:	093e      	lbu	v0,14\(v1\)
[ 0-9a-f]+:	092e      	lbu	v0,14\(v0\)
[ 0-9a-f]+:	094e      	lbu	v0,14\(a0\)
[ 0-9a-f]+:	095e      	lbu	v0,14\(a1\)
[ 0-9a-f]+:	096e      	lbu	v0,14\(a2\)
[ 0-9a-f]+:	097e      	lbu	v0,14\(a3\)
[ 0-9a-f]+:	090e      	lbu	v0,14\(s0\)
[ 0-9a-f]+:	091e      	lbu	v0,14\(s1\)
[ 0-9a-f]+:	099e      	lbu	v1,14\(s1\)
[ 0-9a-f]+:	0a1e      	lbu	a0,14\(s1\)
[ 0-9a-f]+:	0a9e      	lbu	a1,14\(s1\)
[ 0-9a-f]+:	0b1e      	lbu	a2,14\(s1\)
[ 0-9a-f]+:	0b9e      	lbu	a3,14\(s1\)
[ 0-9a-f]+:	081e      	lbu	s0,14\(s1\)
[ 0-9a-f]+:	089e      	lbu	s1,14\(s1\)
[ 0-9a-f]+:	1460 0000 	lbu	v1,0\(zero\)
[ 0-9a-f]+:	1460 0004 	lbu	v1,4\(zero\)
[ 0-9a-f]+:	1460 0000 	lbu	v1,0\(zero\)
[ 0-9a-f]+:	1460 0004 	lbu	v1,4\(zero\)
[ 0-9a-f]+:	1460 7fff 	lbu	v1,32767\(zero\)
[ 0-9a-f]+:	1460 8000 	lbu	v1,-32768\(zero\)
[ 0-9a-f]+:	1060 0001 	lui	v1,0x1
[ 0-9a-f]+:	1463 ffff 	lbu	v1,-1\(v1\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	1463 0000 	lbu	v1,0\(v1\)
[ 0-9a-f]+:	1460 8000 	lbu	v1,-32768\(zero\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	1463 0001 	lbu	v1,1\(v1\)
[ 0-9a-f]+:	1460 8001 	lbu	v1,-32767\(zero\)
[ 0-9a-f]+:	1060 f000 	lui	v1,0xf000
[ 0-9a-f]+:	1463 0000 	lbu	v1,0\(v1\)
[ 0-9a-f]+:	1460 ffff 	lbu	v1,-1\(zero\)
[ 0-9a-f]+:	1060 1234 	lui	v1,0x1234
[ 0-9a-f]+:	1463 5678 	lbu	v1,22136\(v1\)
[ 0-9a-f]+:	09c0      	lbu	v1,0\(a0\)
[ 0-9a-f]+:	09c0      	lbu	v1,0\(a0\)
[ 0-9a-f]+:	09c4      	lbu	v1,4\(a0\)
[ 0-9a-f]+:	1464 7fff 	lbu	v1,32767\(a0\)
[ 0-9a-f]+:	1464 8000 	lbu	v1,-32768\(a0\)
[ 0-9a-f]+:	1060 0001 	lui	v1,0x1
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	1463 ffff 	lbu	v1,-1\(v1\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	1463 0000 	lbu	v1,0\(v1\)
[ 0-9a-f]+:	1464 8000 	lbu	v1,-32768\(a0\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	1463 0001 	lbu	v1,1\(v1\)
[ 0-9a-f]+:	1464 8001 	lbu	v1,-32767\(a0\)
[ 0-9a-f]+:	1060 f000 	lui	v1,0xf000
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	1463 0000 	lbu	v1,0\(v1\)
[ 0-9a-f]+:	1464 ffff 	lbu	v1,-1\(a0\)
[ 0-9a-f]+:	1060 1234 	lui	v1,0x1234
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	1463 5678 	lbu	v1,22136\(v1\)
[ 0-9a-f]+:	3c60 0000 	lh	v1,0\(zero\)
[ 0-9a-f]+:	3c60 0004 	lh	v1,4\(zero\)
[ 0-9a-f]+:	3c60 0000 	lh	v1,0\(zero\)
[ 0-9a-f]+:	3c60 0004 	lh	v1,4\(zero\)
[ 0-9a-f]+:	3c60 7fff 	lh	v1,32767\(zero\)
[ 0-9a-f]+:	3c60 8000 	lh	v1,-32768\(zero\)
[ 0-9a-f]+:	1060 0001 	lui	v1,0x1
[ 0-9a-f]+:	3c63 ffff 	lh	v1,-1\(v1\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	3c63 0000 	lh	v1,0\(v1\)
[ 0-9a-f]+:	3c60 8000 	lh	v1,-32768\(zero\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	3c63 0001 	lh	v1,1\(v1\)
[ 0-9a-f]+:	3c60 8001 	lh	v1,-32767\(zero\)
[ 0-9a-f]+:	1060 f000 	lui	v1,0xf000
[ 0-9a-f]+:	3c63 0000 	lh	v1,0\(v1\)
[ 0-9a-f]+:	3c60 ffff 	lh	v1,-1\(zero\)
[ 0-9a-f]+:	1060 1234 	lui	v1,0x1234
[ 0-9a-f]+:	3c63 5678 	lh	v1,22136\(v1\)
[ 0-9a-f]+:	3c64 0000 	lh	v1,0\(a0\)
[ 0-9a-f]+:	3c64 0000 	lh	v1,0\(a0\)
[ 0-9a-f]+:	3c64 0004 	lh	v1,4\(a0\)
[ 0-9a-f]+:	3c64 7fff 	lh	v1,32767\(a0\)
[ 0-9a-f]+:	3c64 8000 	lh	v1,-32768\(a0\)
[ 0-9a-f]+:	1060 0001 	lui	v1,0x1
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	3c63 ffff 	lh	v1,-1\(v1\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	3c63 0000 	lh	v1,0\(v1\)
[ 0-9a-f]+:	3c64 8000 	lh	v1,-32768\(a0\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	3c63 0001 	lh	v1,1\(v1\)
[ 0-9a-f]+:	3c64 8001 	lh	v1,-32767\(a0\)
[ 0-9a-f]+:	1060 f000 	lui	v1,0xf000
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	3c63 0000 	lh	v1,0\(v1\)
[ 0-9a-f]+:	3c64 ffff 	lh	v1,-1\(a0\)
[ 0-9a-f]+:	1060 1234 	lui	v1,0x1234
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	3c63 5678 	lh	v1,22136\(v1\)
[ 0-9a-f]+:	2930      	lhu	v0,0\(v1\)
[ 0-9a-f]+:	2930      	lhu	v0,0\(v1\)
[ 0-9a-f]+:	2931      	lhu	v0,2\(v1\)
[ 0-9a-f]+:	2932      	lhu	v0,4\(v1\)
[ 0-9a-f]+:	2933      	lhu	v0,6\(v1\)
[ 0-9a-f]+:	2934      	lhu	v0,8\(v1\)
[ 0-9a-f]+:	2935      	lhu	v0,10\(v1\)
[ 0-9a-f]+:	2936      	lhu	v0,12\(v1\)
[ 0-9a-f]+:	2937      	lhu	v0,14\(v1\)
[ 0-9a-f]+:	2938      	lhu	v0,16\(v1\)
[ 0-9a-f]+:	2939      	lhu	v0,18\(v1\)
[ 0-9a-f]+:	293a      	lhu	v0,20\(v1\)
[ 0-9a-f]+:	293b      	lhu	v0,22\(v1\)
[ 0-9a-f]+:	293c      	lhu	v0,24\(v1\)
[ 0-9a-f]+:	293d      	lhu	v0,26\(v1\)
[ 0-9a-f]+:	293e      	lhu	v0,28\(v1\)
[ 0-9a-f]+:	293f      	lhu	v0,30\(v1\)
[ 0-9a-f]+:	294f      	lhu	v0,30\(a0\)
[ 0-9a-f]+:	295f      	lhu	v0,30\(a1\)
[ 0-9a-f]+:	296f      	lhu	v0,30\(a2\)
[ 0-9a-f]+:	297f      	lhu	v0,30\(a3\)
[ 0-9a-f]+:	292f      	lhu	v0,30\(v0\)
[ 0-9a-f]+:	290f      	lhu	v0,30\(s0\)
[ 0-9a-f]+:	291f      	lhu	v0,30\(s1\)
[ 0-9a-f]+:	299f      	lhu	v1,30\(s1\)
[ 0-9a-f]+:	2a1f      	lhu	a0,30\(s1\)
[ 0-9a-f]+:	2a9f      	lhu	a1,30\(s1\)
[ 0-9a-f]+:	2b1f      	lhu	a2,30\(s1\)
[ 0-9a-f]+:	2b9f      	lhu	a3,30\(s1\)
[ 0-9a-f]+:	281f      	lhu	s0,30\(s1\)
[ 0-9a-f]+:	289f      	lhu	s1,30\(s1\)
[ 0-9a-f]+:	3460 0000 	lhu	v1,0\(zero\)
[ 0-9a-f]+:	3460 0004 	lhu	v1,4\(zero\)
[ 0-9a-f]+:	3460 0000 	lhu	v1,0\(zero\)
[ 0-9a-f]+:	3460 0004 	lhu	v1,4\(zero\)
[ 0-9a-f]+:	3460 7fff 	lhu	v1,32767\(zero\)
[ 0-9a-f]+:	3460 8000 	lhu	v1,-32768\(zero\)
[ 0-9a-f]+:	1060 0001 	lui	v1,0x1
[ 0-9a-f]+:	3463 ffff 	lhu	v1,-1\(v1\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	3463 0000 	lhu	v1,0\(v1\)
[ 0-9a-f]+:	3460 8000 	lhu	v1,-32768\(zero\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	3463 0001 	lhu	v1,1\(v1\)
[ 0-9a-f]+:	3460 8001 	lhu	v1,-32767\(zero\)
[ 0-9a-f]+:	1060 f000 	lui	v1,0xf000
[ 0-9a-f]+:	3463 0000 	lhu	v1,0\(v1\)
[ 0-9a-f]+:	3460 ffff 	lhu	v1,-1\(zero\)
[ 0-9a-f]+:	1060 1234 	lui	v1,0x1234
[ 0-9a-f]+:	3463 5678 	lhu	v1,22136\(v1\)
[ 0-9a-f]+:	29c0      	lhu	v1,0\(a0\)
[ 0-9a-f]+:	29c0      	lhu	v1,0\(a0\)
[ 0-9a-f]+:	29c2      	lhu	v1,4\(a0\)
[ 0-9a-f]+:	3464 7fff 	lhu	v1,32767\(a0\)
[ 0-9a-f]+:	3464 8000 	lhu	v1,-32768\(a0\)
[ 0-9a-f]+:	1060 0001 	lui	v1,0x1
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	3463 ffff 	lhu	v1,-1\(v1\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	3463 0000 	lhu	v1,0\(v1\)
[ 0-9a-f]+:	3464 8000 	lhu	v1,-32768\(a0\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	3463 0001 	lhu	v1,1\(v1\)
[ 0-9a-f]+:	3464 8001 	lhu	v1,-32767\(a0\)
[ 0-9a-f]+:	1060 f000 	lui	v1,0xf000
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	3463 0000 	lhu	v1,0\(v1\)
[ 0-9a-f]+:	3464 ffff 	lhu	v1,-1\(a0\)
[ 0-9a-f]+:	1060 1234 	lui	v1,0x1234
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	3463 5678 	lhu	v1,22136\(v1\)
[ 0-9a-f]+:	6060 3000 	ll	v1,0\(zero\)
[ 0-9a-f]+:	6060 3000 	ll	v1,0\(zero\)
[ 0-9a-f]+:	6060 3004 	ll	v1,4\(zero\)
[ 0-9a-f]+:	6060 3004 	ll	v1,4\(zero\)
[ 0-9a-f]+:	3060 7fff 	li	v1,32767
[ 0-9a-f]+:	6063 3000 	ll	v1,0\(v1\)
[ 0-9a-f]+:	3060 8000 	li	v1,-32768
[ 0-9a-f]+:	6063 3000 	ll	v1,0\(v1\)
[ 0-9a-f]+:	1060 0001 	lui	v1,0x1
[ 0-9a-f]+:	6063 31ff 	ll	v1,-1\(v1\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	6063 3000 	ll	v1,0\(v1\)
[ 0-9a-f]+:	3060 8000 	li	v1,-32768
[ 0-9a-f]+:	6063 3000 	ll	v1,0\(v1\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	6063 3001 	ll	v1,1\(v1\)
[ 0-9a-f]+:	3060 8001 	li	v1,-32767
[ 0-9a-f]+:	6063 3000 	ll	v1,0\(v1\)
[ 0-9a-f]+:	1060 f000 	lui	v1,0xf000
[ 0-9a-f]+:	6063 3000 	ll	v1,0\(v1\)
[ 0-9a-f]+:	6060 31ff 	ll	v1,-1\(zero\)
[ 0-9a-f]+:	1060 1234 	lui	v1,0x1234
[ 0-9a-f]+:	5063 5600 	ori	v1,v1,0x5600
[ 0-9a-f]+:	6063 3078 	ll	v1,120\(v1\)
[ 0-9a-f]+:	6064 3000 	ll	v1,0\(a0\)
[ 0-9a-f]+:	6064 3000 	ll	v1,0\(a0\)
[ 0-9a-f]+:	6064 3004 	ll	v1,4\(a0\)
[ 0-9a-f]+:	3064 7fff 	addiu	v1,a0,32767
[ 0-9a-f]+:	6063 3000 	ll	v1,0\(v1\)
[ 0-9a-f]+:	3064 8000 	addiu	v1,a0,-32768
[ 0-9a-f]+:	6063 3000 	ll	v1,0\(v1\)
[ 0-9a-f]+:	1060 0001 	lui	v1,0x1
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	6063 31ff 	ll	v1,-1\(v1\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	6063 3000 	ll	v1,0\(v1\)
[ 0-9a-f]+:	3064 8000 	addiu	v1,a0,-32768
[ 0-9a-f]+:	6063 3000 	ll	v1,0\(v1\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	6063 3001 	ll	v1,1\(v1\)
[ 0-9a-f]+:	3064 8001 	addiu	v1,a0,-32767
[ 0-9a-f]+:	6063 3000 	ll	v1,0\(v1\)
[ 0-9a-f]+:	1060 f000 	lui	v1,0xf000
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	6063 3000 	ll	v1,0\(v1\)
[ 0-9a-f]+:	6064 31ff 	ll	v1,-1\(a0\)
[ 0-9a-f]+:	1060 1234 	lui	v1,0x1234
[ 0-9a-f]+:	5063 5600 	ori	v1,v1,0x5600
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	6063 3078 	ll	v1,120\(v1\)
[ 0-9a-f]+:	1060 0000 	lui	v1,0x0
[ 0-9a-f]+:	1060 7fff 	lui	v1,0x7fff
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	6940      	lw	v0,0\(a0\)
[ 0-9a-f]+:	6940      	lw	v0,0\(a0\)
[ 0-9a-f]+:	6941      	lw	v0,4\(a0\)
[ 0-9a-f]+:	6942      	lw	v0,8\(a0\)
[ 0-9a-f]+:	6943      	lw	v0,12\(a0\)
[ 0-9a-f]+:	6944      	lw	v0,16\(a0\)
[ 0-9a-f]+:	6945      	lw	v0,20\(a0\)
[ 0-9a-f]+:	6946      	lw	v0,24\(a0\)
[ 0-9a-f]+:	6947      	lw	v0,28\(a0\)
[ 0-9a-f]+:	6948      	lw	v0,32\(a0\)
[ 0-9a-f]+:	6949      	lw	v0,36\(a0\)
[ 0-9a-f]+:	694a      	lw	v0,40\(a0\)
[ 0-9a-f]+:	694b      	lw	v0,44\(a0\)
[ 0-9a-f]+:	694c      	lw	v0,48\(a0\)
[ 0-9a-f]+:	694d      	lw	v0,52\(a0\)
[ 0-9a-f]+:	694e      	lw	v0,56\(a0\)
[ 0-9a-f]+:	694f      	lw	v0,60\(a0\)
[ 0-9a-f]+:	695f      	lw	v0,60\(a1\)
[ 0-9a-f]+:	696f      	lw	v0,60\(a2\)
[ 0-9a-f]+:	697f      	lw	v0,60\(a3\)
[ 0-9a-f]+:	692f      	lw	v0,60\(v0\)
[ 0-9a-f]+:	693f      	lw	v0,60\(v1\)
[ 0-9a-f]+:	690f      	lw	v0,60\(s0\)
[ 0-9a-f]+:	691f      	lw	v0,60\(s1\)
[ 0-9a-f]+:	699f      	lw	v1,60\(s1\)
[ 0-9a-f]+:	6a1f      	lw	a0,60\(s1\)
[ 0-9a-f]+:	6a9f      	lw	a1,60\(s1\)
[ 0-9a-f]+:	6b1f      	lw	a2,60\(s1\)
[ 0-9a-f]+:	6b9f      	lw	a3,60\(s1\)
[ 0-9a-f]+:	681f      	lw	s0,60\(s1\)
[ 0-9a-f]+:	689f      	lw	s1,60\(s1\)
[ 0-9a-f]+:	4880      	lw	a0,0\(sp\)
[ 0-9a-f]+:	4880      	lw	a0,0\(sp\)
[ 0-9a-f]+:	4881      	lw	a0,4\(sp\)
[ 0-9a-f]+:	4882      	lw	a0,8\(sp\)
[ 0-9a-f]+:	4883      	lw	a0,12\(sp\)
[ 0-9a-f]+:	4884      	lw	a0,16\(sp\)
[ 0-9a-f]+:	4885      	lw	a0,20\(sp\)
[ 0-9a-f]+:	489f      	lw	a0,124\(sp\)
[ 0-9a-f]+:	485f      	lw	v0,124\(sp\)
[ 0-9a-f]+:	485f      	lw	v0,124\(sp\)
[ 0-9a-f]+:	487f      	lw	v1,124\(sp\)
[ 0-9a-f]+:	489f      	lw	a0,124\(sp\)
[ 0-9a-f]+:	48bf      	lw	a1,124\(sp\)
[ 0-9a-f]+:	48df      	lw	a2,124\(sp\)
[ 0-9a-f]+:	48ff      	lw	a3,124\(sp\)
[ 0-9a-f]+:	491f      	lw	t0,124\(sp\)
[ 0-9a-f]+:	493f      	lw	t1,124\(sp\)
[ 0-9a-f]+:	495f      	lw	t2,124\(sp\)
[ 0-9a-f]+:	4bdf      	lw	s8,124\(sp\)
[ 0-9a-f]+:	4bff      	lw	ra,124\(sp\)
[ 0-9a-f]+:	fc9d 01f8 	lw	a0,504\(sp\)
[ 0-9a-f]+:	fc9d 01fc 	lw	a0,508\(sp\)
[ 0-9a-f]+:	fe1d 01fc 	lw	s0,508\(sp\)
[ 0-9a-f]+:	fe3d 01fc 	lw	s1,508\(sp\)
[ 0-9a-f]+:	fe5d 01fc 	lw	s2,508\(sp\)
[ 0-9a-f]+:	fe7d 01fc 	lw	s3,508\(sp\)
[ 0-9a-f]+:	fe9d 01fc 	lw	s4,508\(sp\)
[ 0-9a-f]+:	febd 01fc 	lw	s5,508\(sp\)
[ 0-9a-f]+:	fffd 01fc 	lw	ra,508\(sp\)
[ 0-9a-f]+:	fc60 0000 	lw	v1,0\(zero\)
[ 0-9a-f]+:	fc60 0004 	lw	v1,4\(zero\)
[ 0-9a-f]+:	fc60 0000 	lw	v1,0\(zero\)
[ 0-9a-f]+:	fc60 0000 	lw	v1,0\(zero\)
[ 0-9a-f]+:	fc60 0000 	lw	v1,0\(zero\)
[ 0-9a-f]+:	fc60 0004 	lw	v1,4\(zero\)
[ 0-9a-f]+:	fc60 7fff 	lw	v1,32767\(zero\)
[ 0-9a-f]+:	fc60 8000 	lw	v1,-32768\(zero\)
[ 0-9a-f]+:	1060 0001 	lui	v1,0x1
[ 0-9a-f]+:	fc63 ffff 	lw	v1,-1\(v1\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	fc63 0000 	lw	v1,0\(v1\)
[ 0-9a-f]+:	fc60 8000 	lw	v1,-32768\(zero\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	fc63 0001 	lw	v1,1\(v1\)
[ 0-9a-f]+:	fc60 8001 	lw	v1,-32767\(zero\)
[ 0-9a-f]+:	1060 f000 	lui	v1,0xf000
[ 0-9a-f]+:	fc63 0000 	lw	v1,0\(v1\)
[ 0-9a-f]+:	fc60 ffff 	lw	v1,-1\(zero\)
[ 0-9a-f]+:	1060 1234 	lui	v1,0x1234
[ 0-9a-f]+:	fc63 5678 	lw	v1,22136\(v1\)
[ 0-9a-f]+:	69c0      	lw	v1,0\(a0\)
[ 0-9a-f]+:	69c0      	lw	v1,0\(a0\)
[ 0-9a-f]+:	69c1      	lw	v1,4\(a0\)
[ 0-9a-f]+:	fc64 7fff 	lw	v1,32767\(a0\)
[ 0-9a-f]+:	fc64 8000 	lw	v1,-32768\(a0\)
[ 0-9a-f]+:	1060 0001 	lui	v1,0x1
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	fc63 ffff 	lw	v1,-1\(v1\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	fc63 0000 	lw	v1,0\(v1\)
[ 0-9a-f]+:	fc64 8000 	lw	v1,-32768\(a0\)
[ 0-9a-f]+:	1060 ffff 	lui	v1,0xffff
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	fc63 0001 	lw	v1,1\(v1\)
[ 0-9a-f]+:	fc64 8001 	lw	v1,-32767\(a0\)
[ 0-9a-f]+:	1060 f000 	lui	v1,0xf000
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	fc63 0000 	lw	v1,0\(v1\)
[ 0-9a-f]+:	fc64 ffff 	lw	v1,-1\(a0\)
[ 0-9a-f]+:	1060 1234 	lui	v1,0x1234
[ 0-9a-f]+:	0083 1950 	addu	v1,v1,a0
[ 0-9a-f]+:	fc63 5678 	lw	v1,22136\(v1\)
[ 0-9a-f]+:	44c2      	lwm	s0,ra,48\(sp\)
[ 0-9a-f]+:	45c2      	lwm	s0-s1,ra,48\(sp\)
[ 0-9a-f]+:	45c2      	lwm	s0-s1,ra,48\(sp\)
[ 0-9a-f]+:	46c2      	lwm	s0-s2,ra,48\(sp\)
[ 0-9a-f]+:	46c2      	lwm	s0-s2,ra,48\(sp\)
[ 0-9a-f]+:	47c2      	lwm	s0-s3,ra,48\(sp\)
[ 0-9a-f]+:	47c2      	lwm	s0-s3,ra,48\(sp\)
[ 0-9a-f]+:	4402      	lwm	s0,ra,0\(sp\)
[ 0-9a-f]+:	4402      	lwm	s0,ra,0\(sp\)
[ 0-9a-f]+:	4412      	lwm	s0,ra,4\(sp\)
[ 0-9a-f]+:	4422      	lwm	s0,ra,8\(sp\)
[ 0-9a-f]+:	4432      	lwm	s0,ra,12\(sp\)
[ 0-9a-f]+:	4442      	lwm	s0,ra,16\(sp\)
[ 0-9a-f]+:	4452      	lwm	s0,ra,20\(sp\)
[ 0-9a-f]+:	4462      	lwm	s0,ra,24\(sp\)
[ 0-9a-f]+:	4472      	lwm	s0,ra,28\(sp\)
[ 0-9a-f]+:	4482      	lwm	s0,ra,32\(sp\)
[ 0-9a-f]+:	4492      	lwm	s0,ra,36\(sp\)
[ 0-9a-f]+:	44a2      	lwm	s0,ra,40\(sp\)
[ 0-9a-f]+:	44b2      	lwm	s0,ra,44\(sp\)
[ 0-9a-f]+:	44c2      	lwm	s0,ra,48\(sp\)
[ 0-9a-f]+:	44d2      	lwm	s0,ra,52\(sp\)
[ 0-9a-f]+:	44e2      	lwm	s0,ra,56\(sp\)
[ 0-9a-f]+:	44f2      	lwm	s0,ra,60\(sp\)
[ 0-9a-f]+:	2020 5000 	lwm	s0,0\(zero\)
[ 0-9a-f]+:	2020 5004 	lwm	s0,4\(zero\)
[ 0-9a-f]+:	2025 5000 	lwm	s0,0\(a1\)
[ 0-9a-f]+:	2025 57ff 	lwm	s0,2047\(a1\)
[ 0-9a-f]+:	2045 57ff 	lwm	s0-s1,2047\(a1\)
[ 0-9a-f]+:	2065 57ff 	lwm	s0-s2,2047\(a1\)
[ 0-9a-f]+:	2085 57ff 	lwm	s0-s3,2047\(a1\)
[ 0-9a-f]+:	20a5 57ff 	lwm	s0-s4,2047\(a1\)
[ 0-9a-f]+:	20c5 57ff 	lwm	s0-s5,2047\(a1\)
[ 0-9a-f]+:	20e5 57ff 	lwm	s0-s6,2047\(a1\)
[ 0-9a-f]+:	2105 57ff 	lwm	s0-s7,2047\(a1\)
[ 0-9a-f]+:	2125 57ff 	lwm	s0-s7,s8,2047\(a1\)
[ 0-9a-f]+:	2205 57ff 	lwm	ra,2047\(a1\)
[ 0-9a-f]+:	2225 5000 	lwm	s0,ra,0\(a1\)
[ 0-9a-f]+:	2245 5000 	lwm	s0-s1,ra,0\(a1\)
[ 0-9a-f]+:	2265 5000 	lwm	s0-s2,ra,0\(a1\)
[ 0-9a-f]+:	2285 5000 	lwm	s0-s3,ra,0\(a1\)
[ 0-9a-f]+:	22a5 5000 	lwm	s0-s4,ra,0\(a1\)
[ 0-9a-f]+:	22c5 5000 	lwm	s0-s5,ra,0\(a1\)
[ 0-9a-f]+:	22e5 5000 	lwm	s0-s6,ra,0\(a1\)
[ 0-9a-f]+:	2305 5000 	lwm	s0-s7,ra,0\(a1\)
[ 0-9a-f]+:	2325 5000 	lwm	s0-s7,s8,ra,0\(a1\)
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	2021 5000 	lwm	s0,0\(at\)
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	2021 5000 	lwm	s0,0\(at\)
[ 0-9a-f]+:	2020 5000 	lwm	s0,0\(zero\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	2021 5fff 	lwm	s0,-1\(at\)
[ 0-9a-f]+:	303d 8000 	addiu	at,sp,-32768
[ 0-9a-f]+:	2021 5000 	lwm	s0,0\(at\)
[ 0-9a-f]+:	303d 7fff 	addiu	at,sp,32767
[ 0-9a-f]+:	2021 5000 	lwm	s0,0\(at\)
[ 0-9a-f]+:	203d 5000 	lwm	s0,0\(sp\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	03a1 0950 	addu	at,at,sp
[ 0-9a-f]+:	2021 5fff 	lwm	s0,-1\(at\)
[ 0-9a-f]+:	2040 1000 	lwp	v0,0\(zero\)
[ 0-9a-f]+:	2040 1004 	lwp	v0,4\(zero\)
[ 0-9a-f]+:	205d 1000 	lwp	v0,0\(sp\)
[ 0-9a-f]+:	205d 1000 	lwp	v0,0\(sp\)
[ 0-9a-f]+:	2043 1800 	lwp	v0,-2048\(v1\)
[ 0-9a-f]+:	2043 17ff 	lwp	v0,2047\(v1\)
[ 0-9a-f]+:	3023 8000 	addiu	at,v1,-32768
[ 0-9a-f]+:	2041 1000 	lwp	v0,0\(at\)
[ 0-9a-f]+:	3023 7fff 	addiu	at,v1,32767
[ 0-9a-f]+:	2041 1000 	lwp	v0,0\(at\)
[ 0-9a-f]+:	2043 1000 	lwp	v0,0\(v1\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0061 0950 	addu	at,at,v1
[ 0-9a-f]+:	2041 1fff 	lwp	v0,-1\(at\)
[ 0-9a-f]+:	3060 8000 	li	v1,-32768
[ 0-9a-f]+:	2043 1000 	lwp	v0,0\(v1\)
[ 0-9a-f]+:	3060 7fff 	li	v1,32767
[ 0-9a-f]+:	2043 1000 	lwp	v0,0\(v1\)
[ 0-9a-f]+:	1060 0001 	lui	v1,0x1
[ 0-9a-f]+:	2043 1fff 	lwp	v0,-1\(v1\)
[ 0-9a-f]+:	0085 1900 	lwxs	v1,a0\(a1\)
[ 0-9a-f]+:	0040 00fc 	mfc0	v0,c0_index
[ 0-9a-f]+:	0041 00fc 	mfc0	v0,c0_random
[ 0-9a-f]+:	0042 00fc 	mfc0	v0,c0_entrylo0
[ 0-9a-f]+:	0043 00fc 	mfc0	v0,c0_entrylo1
[ 0-9a-f]+:	0044 00fc 	mfc0	v0,c0_context
[ 0-9a-f]+:	0045 00fc 	mfc0	v0,c0_pagemask
[ 0-9a-f]+:	0046 00fc 	mfc0	v0,c0_wired
[ 0-9a-f]+:	0047 00fc 	mfc0	v0,c0_hwrena
[ 0-9a-f]+:	0048 00fc 	mfc0	v0,c0_badvaddr
[ 0-9a-f]+:	0049 00fc 	mfc0	v0,c0_count
[ 0-9a-f]+:	004a 00fc 	mfc0	v0,c0_entryhi
[ 0-9a-f]+:	004b 00fc 	mfc0	v0,c0_compare
[ 0-9a-f]+:	004c 00fc 	mfc0	v0,c0_status
[ 0-9a-f]+:	004d 00fc 	mfc0	v0,c0_cause
[ 0-9a-f]+:	004e 00fc 	mfc0	v0,c0_epc
[ 0-9a-f]+:	004f 00fc 	mfc0	v0,c0_prid
[ 0-9a-f]+:	0050 00fc 	mfc0	v0,c0_config
[ 0-9a-f]+:	0051 00fc 	mfc0	v0,c0_lladdr
[ 0-9a-f]+:	0052 00fc 	mfc0	v0,c0_watchlo
[ 0-9a-f]+:	0053 00fc 	mfc0	v0,c0_watchhi
[ 0-9a-f]+:	0054 00fc 	mfc0	v0,c0_xcontext
[ 0-9a-f]+:	0055 00fc 	mfc0	v0,\$21
[ 0-9a-f]+:	0056 00fc 	mfc0	v0,\$22
[ 0-9a-f]+:	0057 00fc 	mfc0	v0,c0_debug
[ 0-9a-f]+:	0058 00fc 	mfc0	v0,c0_depc
[ 0-9a-f]+:	0059 00fc 	mfc0	v0,c0_perfcnt
[ 0-9a-f]+:	005a 00fc 	mfc0	v0,c0_errctl
[ 0-9a-f]+:	005b 00fc 	mfc0	v0,c0_cacheerr
[ 0-9a-f]+:	005c 00fc 	mfc0	v0,c0_taglo
[ 0-9a-f]+:	005d 00fc 	mfc0	v0,c0_taghi
[ 0-9a-f]+:	005e 00fc 	mfc0	v0,c0_errorepc
[ 0-9a-f]+:	005f 00fc 	mfc0	v0,c0_desave
[ 0-9a-f]+:	0040 00fc 	mfc0	v0,c0_index
[ 0-9a-f]+:	0040 08fc 	mfc0	v0,c0_mvpcontrol
[ 0-9a-f]+:	0040 10fc 	mfc0	v0,c0_mvpconf0
[ 0-9a-f]+:	0040 18fc 	mfc0	v0,c0_mvpconf1
[ 0-9a-f]+:	0040 20fc 	mfc0	v0,\$0,4
[ 0-9a-f]+:	0040 28fc 	mfc0	v0,\$0,5
[ 0-9a-f]+:	0040 30fc 	mfc0	v0,\$0,6
[ 0-9a-f]+:	0040 38fc 	mfc0	v0,\$0,7
[ 0-9a-f]+:	0041 00fc 	mfc0	v0,c0_random
[ 0-9a-f]+:	0041 08fc 	mfc0	v0,c0_vpecontrol
[ 0-9a-f]+:	0041 10fc 	mfc0	v0,c0_vpeconf0
[ 0-9a-f]+:	0041 18fc 	mfc0	v0,c0_vpeconf1
[ 0-9a-f]+:	0041 20fc 	mfc0	v0,c0_yqmask
[ 0-9a-f]+:	0041 28fc 	mfc0	v0,c0_vpeschedule
[ 0-9a-f]+:	0041 30fc 	mfc0	v0,c0_vpeschefback
[ 0-9a-f]+:	0041 38fc 	mfc0	v0,\$1,7
[ 0-9a-f]+:	0042 00fc 	mfc0	v0,c0_entrylo0
[ 0-9a-f]+:	0042 08fc 	mfc0	v0,c0_tcstatus
[ 0-9a-f]+:	0042 10fc 	mfc0	v0,c0_tcbind
[ 0-9a-f]+:	0042 18fc 	mfc0	v0,c0_tcrestart
[ 0-9a-f]+:	0042 20fc 	mfc0	v0,c0_tchalt
[ 0-9a-f]+:	0042 28fc 	mfc0	v0,c0_tccontext
[ 0-9a-f]+:	0042 30fc 	mfc0	v0,c0_tcschedule
[ 0-9a-f]+:	0042 38fc 	mfc0	v0,c0_tcschefback
[ 0-9a-f]+:	0040 02fc 	mtc0	v0,c0_index
[ 0-9a-f]+:	0041 02fc 	mtc0	v0,c0_random
[ 0-9a-f]+:	0042 02fc 	mtc0	v0,c0_entrylo0
[ 0-9a-f]+:	0043 02fc 	mtc0	v0,c0_entrylo1
[ 0-9a-f]+:	0044 02fc 	mtc0	v0,c0_context
[ 0-9a-f]+:	0045 02fc 	mtc0	v0,c0_pagemask
[ 0-9a-f]+:	0046 02fc 	mtc0	v0,c0_wired
[ 0-9a-f]+:	0047 02fc 	mtc0	v0,c0_hwrena
[ 0-9a-f]+:	0048 02fc 	mtc0	v0,c0_badvaddr
[ 0-9a-f]+:	0049 02fc 	mtc0	v0,c0_count
[ 0-9a-f]+:	004a 02fc 	mtc0	v0,c0_entryhi
[ 0-9a-f]+:	004b 02fc 	mtc0	v0,c0_compare
[ 0-9a-f]+:	004c 02fc 	mtc0	v0,c0_status
[ 0-9a-f]+:	004d 02fc 	mtc0	v0,c0_cause
[ 0-9a-f]+:	004e 02fc 	mtc0	v0,c0_epc
[ 0-9a-f]+:	004f 02fc 	mtc0	v0,c0_prid
[ 0-9a-f]+:	0050 02fc 	mtc0	v0,c0_config
[ 0-9a-f]+:	0051 02fc 	mtc0	v0,c0_lladdr
[ 0-9a-f]+:	0052 02fc 	mtc0	v0,c0_watchlo
[ 0-9a-f]+:	0053 02fc 	mtc0	v0,c0_watchhi
[ 0-9a-f]+:	0054 02fc 	mtc0	v0,c0_xcontext
[ 0-9a-f]+:	0055 02fc 	mtc0	v0,\$21
[ 0-9a-f]+:	0056 02fc 	mtc0	v0,\$22
[ 0-9a-f]+:	0057 02fc 	mtc0	v0,c0_debug
[ 0-9a-f]+:	0058 02fc 	mtc0	v0,c0_depc
[ 0-9a-f]+:	0059 02fc 	mtc0	v0,c0_perfcnt
[ 0-9a-f]+:	005a 02fc 	mtc0	v0,c0_errctl
[ 0-9a-f]+:	005b 02fc 	mtc0	v0,c0_cacheerr
[ 0-9a-f]+:	005c 02fc 	mtc0	v0,c0_taglo
[ 0-9a-f]+:	005d 02fc 	mtc0	v0,c0_taghi
[ 0-9a-f]+:	005e 02fc 	mtc0	v0,c0_errorepc
[ 0-9a-f]+:	005f 02fc 	mtc0	v0,c0_desave
[ 0-9a-f]+:	0040 02fc 	mtc0	v0,c0_index
[ 0-9a-f]+:	0040 0afc 	mtc0	v0,c0_mvpcontrol
[ 0-9a-f]+:	0040 12fc 	mtc0	v0,c0_mvpconf0
[ 0-9a-f]+:	0040 1afc 	mtc0	v0,c0_mvpconf1
[ 0-9a-f]+:	0040 22fc 	mtc0	v0,\$0,4
[ 0-9a-f]+:	0040 2afc 	mtc0	v0,\$0,5
[ 0-9a-f]+:	0040 32fc 	mtc0	v0,\$0,6
[ 0-9a-f]+:	0040 3afc 	mtc0	v0,\$0,7
[ 0-9a-f]+:	0041 02fc 	mtc0	v0,c0_random
[ 0-9a-f]+:	0041 0afc 	mtc0	v0,c0_vpecontrol
[ 0-9a-f]+:	0041 12fc 	mtc0	v0,c0_vpeconf0
[ 0-9a-f]+:	0041 1afc 	mtc0	v0,c0_vpeconf1
[ 0-9a-f]+:	0041 22fc 	mtc0	v0,c0_yqmask
[ 0-9a-f]+:	0041 2afc 	mtc0	v0,c0_vpeschedule
[ 0-9a-f]+:	0041 32fc 	mtc0	v0,c0_vpeschefback
[ 0-9a-f]+:	0041 3afc 	mtc0	v0,\$1,7
[ 0-9a-f]+:	0042 02fc 	mtc0	v0,c0_entrylo0
[ 0-9a-f]+:	0042 0afc 	mtc0	v0,c0_tcstatus
[ 0-9a-f]+:	0042 12fc 	mtc0	v0,c0_tcbind
[ 0-9a-f]+:	0042 1afc 	mtc0	v0,c0_tcrestart
[ 0-9a-f]+:	0042 22fc 	mtc0	v0,c0_tchalt
[ 0-9a-f]+:	0042 2afc 	mtc0	v0,c0_tccontext
[ 0-9a-f]+:	0042 32fc 	mtc0	v0,c0_tcschedule
[ 0-9a-f]+:	0042 3afc 	mtc0	v0,c0_tcschefback
[ 0-9a-f]+:	0083 1018 	mul	v0,v1,a0
[ 0-9a-f]+:	03fe e818 	mul	sp,s8,ra
[ 0-9a-f]+:	0082 1018 	mul	v0,v0,a0
[ 0-9a-f]+:	0082 1018 	mul	v0,v0,a0
[ 0-9a-f]+:	0060 1190 	neg	v0,v1
[ 0-9a-f]+:	0040 1190 	neg	v0,v0
[ 0-9a-f]+:	0040 1190 	neg	v0,v0
[ 0-9a-f]+:	0060 11d0 	negu	v0,v1
[ 0-9a-f]+:	0040 11d0 	negu	v0,v0
[ 0-9a-f]+:	0040 11d0 	negu	v0,v0
[ 0-9a-f]+:	0060 11d0 	negu	v0,v1
[ 0-9a-f]+:	0040 11d0 	negu	v0,v0
[ 0-9a-f]+:	0040 11d0 	negu	v0,v0
[ 0-9a-f]+:	4520      	not	v0,v0
[ 0-9a-f]+:	4520      	not	v0,v0
[ 0-9a-f]+:	4530      	not	v0,v1
[ 0-9a-f]+:	4540      	not	v0,a0
[ 0-9a-f]+:	4550      	not	v0,a1
[ 0-9a-f]+:	4560      	not	v0,a2
[ 0-9a-f]+:	4570      	not	v0,a3
[ 0-9a-f]+:	4500      	not	v0,s0
[ 0-9a-f]+:	4510      	not	v0,s1
[ 0-9a-f]+:	4590      	not	v1,s1
[ 0-9a-f]+:	4610      	not	a0,s1
[ 0-9a-f]+:	4690      	not	a1,s1
[ 0-9a-f]+:	4710      	not	a2,s1
[ 0-9a-f]+:	4790      	not	a3,s1
[ 0-9a-f]+:	4410      	not	s0,s1
[ 0-9a-f]+:	4490      	not	s1,s1
[ 0-9a-f]+:	4570      	not	v0,a3
[ 0-9a-f]+:	4570      	not	v0,a3
[ 0-9a-f]+:	0083 12d0 	nor	v0,v1,a0
[ 0-9a-f]+:	03fe ead0 	nor	sp,s8,ra
[ 0-9a-f]+:	0082 12d0 	nor	v0,v0,a0
[ 0-9a-f]+:	0082 12d0 	nor	v0,v0,a0
[ 0-9a-f]+:	5043 8000 	ori	v0,v1,0x8000
[ 0-9a-f]+:	0002 12d0 	not	v0,v0
[ 0-9a-f]+:	5043 ffff 	ori	v0,v1,0xffff
[ 0-9a-f]+:	0002 12d0 	not	v0,v0
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0023 12d0 	nor	v0,v1,at
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	0023 12d0 	nor	v0,v1,at
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	5021 7fff 	ori	at,at,0x7fff
[ 0-9a-f]+:	0023 12d0 	nor	v0,v1,at
[ 0-9a-f]+:	0c56      	move	v0,s6
[ 0-9a-f]+:	0ec2      	move	s6,v0
[ 0-9a-f]+:	0c56      	move	v0,s6
[ 0-9a-f]+:	0ec2      	move	s6,v0
[ 0-9a-f]+:	4529      	or	v0,v0,v0
[ 0-9a-f]+:	4539      	or	v0,v0,v1
[ 0-9a-f]+:	4549      	or	v0,v0,a0
[ 0-9a-f]+:	4559      	or	v0,v0,a1
[ 0-9a-f]+:	4569      	or	v0,v0,a2
[ 0-9a-f]+:	4579      	or	v0,v0,a3
[ 0-9a-f]+:	4509      	or	v0,v0,s0
[ 0-9a-f]+:	4519      	or	v0,v0,s1
[ 0-9a-f]+:	45a9      	or	v1,v1,v0
[ 0-9a-f]+:	4629      	or	a0,a0,v0
[ 0-9a-f]+:	46a9      	or	a1,a1,v0
[ 0-9a-f]+:	4729      	or	a2,a2,v0
[ 0-9a-f]+:	47a9      	or	a3,a3,v0
[ 0-9a-f]+:	4429      	or	s0,s0,v0
[ 0-9a-f]+:	44a9      	or	s1,s1,v0
[ 0-9a-f]+:	4529      	or	v0,v0,v0
[ 0-9a-f]+:	4539      	or	v0,v0,v1
[ 0-9a-f]+:	4539      	or	v0,v0,v1
[ 0-9a-f]+:	0083 1290 	or	v0,v1,a0
[ 0-9a-f]+:	03fe ea90 	or	sp,s8,ra
[ 0-9a-f]+:	0082 1290 	or	v0,v0,a0
[ 0-9a-f]+:	0082 1290 	or	v0,v0,a0
[ 0-9a-f]+:	5043 8000 	ori	v0,v1,0x8000
[ 0-9a-f]+:	5043 ffff 	ori	v0,v1,0xffff
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0023 1290 	or	v0,v1,at
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	0023 1290 	or	v0,v1,at
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	5021 7fff 	ori	at,at,0x7fff
[ 0-9a-f]+:	0023 1290 	or	v0,v1,at
[ 0-9a-f]+:	0c64      	move	v1,a0
[ 0-9a-f]+:	5064 7fff 	ori	v1,a0,0x7fff
[ 0-9a-f]+:	5064 ffff 	ori	v1,a0,0xffff
[ 0-9a-f]+:	5063 ffff 	ori	v1,v1,0xffff
[ 0-9a-f]+:	5063 ffff 	ori	v1,v1,0xffff
[ 0-9a-f]+:	0040 01c0 	rdhwr	v0,hwr_cpunum
[ 0-9a-f]+:	0041 01c0 	rdhwr	v0,hwr_synci_step
[ 0-9a-f]+:	0042 01c0 	rdhwr	v0,hwr_cc
[ 0-9a-f]+:	0043 01c0 	rdhwr	v0,hwr_ccres
[ 0-9a-f]+:	0044 01c0 	rdhwr	v0,\$4
[ 0-9a-f]+:	0045 01c0 	rdhwr	v0,\$5
[ 0-9a-f]+:	0046 01c0 	rdhwr	v0,\$6
[ 0-9a-f]+:	0047 01c0 	rdhwr	v0,\$7
[ 0-9a-f]+:	0048 01c0 	rdhwr	v0,\$8
[ 0-9a-f]+:	0049 01c0 	rdhwr	v0,\$9
[ 0-9a-f]+:	004a 01c0 	rdhwr	v0,\$10
[ 0-9a-f]+:	0043 e17c 	rdpgpr	v0,v1
[ 0-9a-f]+:	0042 e17c 	rdpgpr	v0,v0
[ 0-9a-f]+:	0042 e17c 	rdpgpr	v0,v0
[ 0-9a-f]+:	0080 11d0 	negu	v0,a0
[ 0-9a-f]+:	0062 10d0 	rorv	v0,v1,v0
[ 0-9a-f]+:	0080 09d0 	negu	at,a0
[ 0-9a-f]+:	0041 10d0 	rorv	v0,v0,at
[ 0-9a-f]+:	0060 11d0 	negu	v0,v1
[ 0-9a-f]+:	0062 10d0 	rorv	v0,v1,v0
[ 0-9a-f]+:	0040 11d0 	negu	v0,v0
[ 0-9a-f]+:	0062 10d0 	rorv	v0,v1,v0
[ 0-9a-f]+:	0043 00c0 	ror	v0,v1,0x0
[ 0-9a-f]+:	0043 f8c0 	ror	v0,v1,0x1f
[ 0-9a-f]+:	0043 08c0 	ror	v0,v1,0x1
[ 0-9a-f]+:	0042 08c0 	ror	v0,v0,0x1
[ 0-9a-f]+:	0042 08c0 	ror	v0,v0,0x1
[ 0-9a-f]+:	0043 00c0 	ror	v0,v1,0x0
[ 0-9a-f]+:	0043 08c0 	ror	v0,v1,0x1
[ 0-9a-f]+:	0043 f8c0 	ror	v0,v1,0x1f
[ 0-9a-f]+:	0042 f8c0 	ror	v0,v0,0x1f
[ 0-9a-f]+:	0042 f8c0 	ror	v0,v0,0x1f
[ 0-9a-f]+:	0064 10d0 	rorv	v0,v1,a0
[ 0-9a-f]+:	0044 10d0 	rorv	v0,v0,a0
[ 0-9a-f]+:	0064 10d0 	rorv	v0,v1,a0
[ 0-9a-f]+:	0044 10d0 	rorv	v0,v0,a0
[ 0-9a-f]+:	0064 10d0 	rorv	v0,v1,a0
[ 0-9a-f]+:	0044 10d0 	rorv	v0,v0,a0
[ 0-9a-f]+:	0064 10d0 	rorv	v0,v1,a0
[ 0-9a-f]+:	0044 10d0 	rorv	v0,v0,a0
[ 0-9a-f]+:	8830      	sb	zero,0\(v1\)
[ 0-9a-f]+:	8830      	sb	zero,0\(v1\)
[ 0-9a-f]+:	8831      	sb	zero,1\(v1\)
[ 0-9a-f]+:	8832      	sb	zero,2\(v1\)
[ 0-9a-f]+:	8833      	sb	zero,3\(v1\)
[ 0-9a-f]+:	8834      	sb	zero,4\(v1\)
[ 0-9a-f]+:	8835      	sb	zero,5\(v1\)
[ 0-9a-f]+:	8836      	sb	zero,6\(v1\)
[ 0-9a-f]+:	8837      	sb	zero,7\(v1\)
[ 0-9a-f]+:	8838      	sb	zero,8\(v1\)
[ 0-9a-f]+:	8839      	sb	zero,9\(v1\)
[ 0-9a-f]+:	883a      	sb	zero,10\(v1\)
[ 0-9a-f]+:	883b      	sb	zero,11\(v1\)
[ 0-9a-f]+:	883c      	sb	zero,12\(v1\)
[ 0-9a-f]+:	883d      	sb	zero,13\(v1\)
[ 0-9a-f]+:	883e      	sb	zero,14\(v1\)
[ 0-9a-f]+:	883f      	sb	zero,15\(v1\)
[ 0-9a-f]+:	893f      	sb	v0,15\(v1\)
[ 0-9a-f]+:	89bf      	sb	v1,15\(v1\)
[ 0-9a-f]+:	8a3f      	sb	a0,15\(v1\)
[ 0-9a-f]+:	8abf      	sb	a1,15\(v1\)
[ 0-9a-f]+:	8b3f      	sb	a2,15\(v1\)
[ 0-9a-f]+:	8bbf      	sb	a3,15\(v1\)
[ 0-9a-f]+:	88bf      	sb	s1,15\(v1\)
[ 0-9a-f]+:	88cf      	sb	s1,15\(a0\)
[ 0-9a-f]+:	88df      	sb	s1,15\(a1\)
[ 0-9a-f]+:	88ef      	sb	s1,15\(a2\)
[ 0-9a-f]+:	88ff      	sb	s1,15\(a3\)
[ 0-9a-f]+:	88af      	sb	s1,15\(v0\)
[ 0-9a-f]+:	888f      	sb	s1,15\(s0\)
[ 0-9a-f]+:	889f      	sb	s1,15\(s1\)
[ 0-9a-f]+:	1860 0004 	sb	v1,4\(zero\)
[ 0-9a-f]+:	1860 0004 	sb	v1,4\(zero\)
[ 0-9a-f]+:	1860 7fff 	sb	v1,32767\(zero\)
[ 0-9a-f]+:	1860 8000 	sb	v1,-32768\(zero\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	1861 ffff 	sb	v1,-1\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	1861 0000 	sb	v1,0\(at\)
[ 0-9a-f]+:	1860 8000 	sb	v1,-32768\(zero\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	1861 0001 	sb	v1,1\(at\)
[ 0-9a-f]+:	1860 8001 	sb	v1,-32767\(zero\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	1861 0000 	sb	v1,0\(at\)
[ 0-9a-f]+:	1860 ffff 	sb	v1,-1\(zero\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	1861 5678 	sb	v1,22136\(at\)
[ 0-9a-f]+:	1864 0000 	sb	v1,0\(a0\)
[ 0-9a-f]+:	1864 0000 	sb	v1,0\(a0\)
[ 0-9a-f]+:	1864 7fff 	sb	v1,32767\(a0\)
[ 0-9a-f]+:	1864 8000 	sb	v1,-32768\(a0\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	1861 ffff 	sb	v1,-1\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	1861 0000 	sb	v1,0\(at\)
[ 0-9a-f]+:	1864 8000 	sb	v1,-32768\(a0\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	1861 0001 	sb	v1,1\(at\)
[ 0-9a-f]+:	1864 8001 	sb	v1,-32767\(a0\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	1861 0000 	sb	v1,0\(at\)
[ 0-9a-f]+:	1864 ffff 	sb	v1,-1\(a0\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	1861 5678 	sb	v1,22136\(at\)
[ 0-9a-f]+:	6060 b004 	sc	v1,4\(zero\)
[ 0-9a-f]+:	6060 b004 	sc	v1,4\(zero\)
[ 0-9a-f]+:	6060 b0ff 	sc	v1,255\(zero\)
[ 0-9a-f]+:	6060 b100 	sc	v1,-256\(zero\)
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	6061 b000 	sc	v1,0\(at\)
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	6061 b000 	sc	v1,0\(at\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	6061 b1ff 	sc	v1,-1\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	6061 b000 	sc	v1,0\(at\)
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	6061 b000 	sc	v1,0\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	6061 b001 	sc	v1,1\(at\)
[ 0-9a-f]+:	3020 8001 	li	at,-32767
[ 0-9a-f]+:	6061 b000 	sc	v1,0\(at\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	6061 b000 	sc	v1,0\(at\)
[ 0-9a-f]+:	6060 b1ff 	sc	v1,-1\(zero\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5600 	ori	at,at,0x5600
[ 0-9a-f]+:	6061 b078 	sc	v1,120\(at\)
[ 0-9a-f]+:	6064 b000 	sc	v1,0\(a0\)
[ 0-9a-f]+:	6064 b000 	sc	v1,0\(a0\)
[ 0-9a-f]+:	6064 b0ff 	sc	v1,255\(a0\)
[ 0-9a-f]+:	6064 b100 	sc	v1,-256\(a0\)
[ 0-9a-f]+:	3024 7fff 	addiu	at,a0,32767
[ 0-9a-f]+:	6061 b000 	sc	v1,0\(at\)
[ 0-9a-f]+:	3024 8000 	addiu	at,a0,-32768
[ 0-9a-f]+:	6061 b000 	sc	v1,0\(at\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	6061 b1ff 	sc	v1,-1\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	6061 b000 	sc	v1,0\(at\)
[ 0-9a-f]+:	3024 8000 	addiu	at,a0,-32768
[ 0-9a-f]+:	6061 b000 	sc	v1,0\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	6061 b001 	sc	v1,1\(at\)
[ 0-9a-f]+:	3024 8001 	addiu	at,a0,-32767
[ 0-9a-f]+:	6061 b000 	sc	v1,0\(at\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	6061 b000 	sc	v1,0\(at\)
[ 0-9a-f]+:	6064 b1ff 	sc	v1,-1\(a0\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5600 	ori	at,at,0x5600
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	6061 b078 	sc	v1,120\(at\)
[ 0-9a-f]+:	443b      	sdbbp
[ 0-9a-f]+:	443b      	sdbbp
[ 0-9a-f]+:	447b      	sdbbp	0x1
[ 0-9a-f]+:	44bb      	sdbbp	0x2
[ 0-9a-f]+:	44fb      	sdbbp	0x3
[ 0-9a-f]+:	453b      	sdbbp	0x4
[ 0-9a-f]+:	457b      	sdbbp	0x5
[ 0-9a-f]+:	45bb      	sdbbp	0x6
[ 0-9a-f]+:	45fb      	sdbbp	0x7
[ 0-9a-f]+:	463b      	sdbbp	0x8
[ 0-9a-f]+:	467b      	sdbbp	0x9
[ 0-9a-f]+:	46bb      	sdbbp	0xa
[ 0-9a-f]+:	46fb      	sdbbp	0xb
[ 0-9a-f]+:	473b      	sdbbp	0xc
[ 0-9a-f]+:	477b      	sdbbp	0xd
[ 0-9a-f]+:	47bb      	sdbbp	0xe
[ 0-9a-f]+:	47fb      	sdbbp	0xf
[ 0-9a-f]+:	0000 db7c 	sdbbp
[ 0-9a-f]+:	0000 db7c 	sdbbp
[ 0-9a-f]+:	0001 db7c 	sdbbp	0x1
[ 0-9a-f]+:	0002 db7c 	sdbbp	0x2
[ 0-9a-f]+:	00ff db7c 	sdbbp	0xff
[ 0-9a-f]+:	0043 2b3c 	seb	v0,v1
[ 0-9a-f]+:	0042 2b3c 	seb	v0,v0
[ 0-9a-f]+:	0042 2b3c 	seb	v0,v0
[ 0-9a-f]+:	0043 3b3c 	seh	v0,v1
[ 0-9a-f]+:	0042 3b3c 	seh	v0,v0
[ 0-9a-f]+:	0042 3b3c 	seh	v0,v0
[ 0-9a-f]+:	0083 1310 	xor	v0,v1,a0
[ 0-9a-f]+:	b042 0001 	sltiu	v0,v0,1
[ 0-9a-f]+:	b043 0001 	sltiu	v0,v1,1
[ 0-9a-f]+:	b044 0001 	sltiu	v0,a0,1
[ 0-9a-f]+:	b043 0001 	sltiu	v0,v1,1
[ 0-9a-f]+:	7043 0001 	xori	v0,v1,0x1
[ 0-9a-f]+:	b042 0001 	sltiu	v0,v0,1
[ 0-9a-f]+:	3043 0001 	addiu	v0,v1,1
[ 0-9a-f]+:	b042 0001 	sltiu	v0,v0,1
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	5021 7fff 	ori	at,at,0x7fff
[ 0-9a-f]+:	0023 1310 	xor	v0,v1,at
[ 0-9a-f]+:	b042 0001 	sltiu	v0,v0,1
[ 0-9a-f]+:	0083 1350 	slt	v0,v1,a0
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	0082 1350 	slt	v0,v0,a0
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	0082 1350 	slt	v0,v0,a0
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	9043 0000 	slti	v0,v1,0
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	9043 8000 	slti	v0,v1,-32768
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	9043 0000 	slti	v0,v1,0
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	9043 7fff 	slti	v0,v1,32767
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	0023 1350 	slt	v0,v1,at
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0023 1350 	slt	v0,v1,at
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	5021 7fff 	ori	at,at,0x7fff
[ 0-9a-f]+:	0023 1350 	slt	v0,v1,at
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	0083 1390 	sltu	v0,v1,a0
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	0082 1390 	sltu	v0,v0,a0
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	0082 1390 	sltu	v0,v0,a0
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	b043 0000 	sltiu	v0,v1,0
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	b043 8000 	sltiu	v0,v1,-32768
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	b043 0000 	sltiu	v0,v1,0
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	b043 7fff 	sltiu	v0,v1,32767
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	0023 1390 	sltu	v0,v1,at
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0023 1390 	sltu	v0,v1,at
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	5021 7fff 	ori	at,at,0x7fff
[ 0-9a-f]+:	0023 1390 	sltu	v0,v1,at
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	0064 1350 	slt	v0,a0,v1
[ 0-9a-f]+:	0044 1350 	slt	v0,a0,v0
[ 0-9a-f]+:	0044 1350 	slt	v0,a0,v0
[ 0-9a-f]+:	3020 0000 	li	at,0
[ 0-9a-f]+:	0061 1350 	slt	v0,at,v1
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	0061 1350 	slt	v0,at,v1
[ 0-9a-f]+:	3020 0000 	li	at,0
[ 0-9a-f]+:	0061 1350 	slt	v0,at,v1
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	0061 1350 	slt	v0,at,v1
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	0061 1350 	slt	v0,at,v1
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0061 1350 	slt	v0,at,v1
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	5021 7fff 	ori	at,at,0x7fff
[ 0-9a-f]+:	0061 1350 	slt	v0,at,v1
[ 0-9a-f]+:	0064 1390 	sltu	v0,a0,v1
[ 0-9a-f]+:	0044 1390 	sltu	v0,a0,v0
[ 0-9a-f]+:	0044 1390 	sltu	v0,a0,v0
[ 0-9a-f]+:	3020 0000 	li	at,0
[ 0-9a-f]+:	0061 1390 	sltu	v0,at,v1
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	0061 1390 	sltu	v0,at,v1
[ 0-9a-f]+:	3020 0000 	li	at,0
[ 0-9a-f]+:	0061 1390 	sltu	v0,at,v1
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	0061 1390 	sltu	v0,at,v1
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	0061 1390 	sltu	v0,at,v1
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0061 1390 	sltu	v0,at,v1
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	5021 7fff 	ori	at,at,0x7fff
[ 0-9a-f]+:	0061 1390 	sltu	v0,at,v1
[ 0-9a-f]+:	a930      	sh	v0,0\(v1\)
[ 0-9a-f]+:	a930      	sh	v0,0\(v1\)
[ 0-9a-f]+:	a931      	sh	v0,2\(v1\)
[ 0-9a-f]+:	a932      	sh	v0,4\(v1\)
[ 0-9a-f]+:	a933      	sh	v0,6\(v1\)
[ 0-9a-f]+:	a934      	sh	v0,8\(v1\)
[ 0-9a-f]+:	a935      	sh	v0,10\(v1\)
[ 0-9a-f]+:	a936      	sh	v0,12\(v1\)
[ 0-9a-f]+:	a937      	sh	v0,14\(v1\)
[ 0-9a-f]+:	a938      	sh	v0,16\(v1\)
[ 0-9a-f]+:	a939      	sh	v0,18\(v1\)
[ 0-9a-f]+:	a93a      	sh	v0,20\(v1\)
[ 0-9a-f]+:	a93b      	sh	v0,22\(v1\)
[ 0-9a-f]+:	a93c      	sh	v0,24\(v1\)
[ 0-9a-f]+:	a93d      	sh	v0,26\(v1\)
[ 0-9a-f]+:	a93e      	sh	v0,28\(v1\)
[ 0-9a-f]+:	a93f      	sh	v0,30\(v1\)
[ 0-9a-f]+:	a94f      	sh	v0,30\(a0\)
[ 0-9a-f]+:	a95f      	sh	v0,30\(a1\)
[ 0-9a-f]+:	a96f      	sh	v0,30\(a2\)
[ 0-9a-f]+:	a97f      	sh	v0,30\(a3\)
[ 0-9a-f]+:	a92f      	sh	v0,30\(v0\)
[ 0-9a-f]+:	a90f      	sh	v0,30\(s0\)
[ 0-9a-f]+:	a91f      	sh	v0,30\(s1\)
[ 0-9a-f]+:	a99f      	sh	v1,30\(s1\)
[ 0-9a-f]+:	aa1f      	sh	a0,30\(s1\)
[ 0-9a-f]+:	aa9f      	sh	a1,30\(s1\)
[ 0-9a-f]+:	ab1f      	sh	a2,30\(s1\)
[ 0-9a-f]+:	ab9f      	sh	a3,30\(s1\)
[ 0-9a-f]+:	a89f      	sh	s1,30\(s1\)
[ 0-9a-f]+:	a81f      	sh	zero,30\(s1\)
[ 0-9a-f]+:	3860 0004 	sh	v1,4\(zero\)
[ 0-9a-f]+:	3860 0004 	sh	v1,4\(zero\)
[ 0-9a-f]+:	3860 7fff 	sh	v1,32767\(zero\)
[ 0-9a-f]+:	3860 8000 	sh	v1,-32768\(zero\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	3861 ffff 	sh	v1,-1\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	3861 0000 	sh	v1,0\(at\)
[ 0-9a-f]+:	3860 8000 	sh	v1,-32768\(zero\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	3861 0001 	sh	v1,1\(at\)
[ 0-9a-f]+:	3860 8001 	sh	v1,-32767\(zero\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	3861 0000 	sh	v1,0\(at\)
[ 0-9a-f]+:	3860 ffff 	sh	v1,-1\(zero\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	3861 5678 	sh	v1,22136\(at\)
[ 0-9a-f]+:	3864 0000 	sh	v1,0\(a0\)
[ 0-9a-f]+:	3864 0000 	sh	v1,0\(a0\)
[ 0-9a-f]+:	3864 7fff 	sh	v1,32767\(a0\)
[ 0-9a-f]+:	3864 8000 	sh	v1,-32768\(a0\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	3861 ffff 	sh	v1,-1\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	3861 0000 	sh	v1,0\(at\)
[ 0-9a-f]+:	3864 8000 	sh	v1,-32768\(a0\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	3861 0001 	sh	v1,1\(at\)
[ 0-9a-f]+:	3864 8001 	sh	v1,-32767\(a0\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	3861 0000 	sh	v1,0\(at\)
[ 0-9a-f]+:	3864 ffff 	sh	v1,-1\(a0\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	3861 5678 	sh	v1,22136\(at\)
[ 0-9a-f]+:	0064 1350 	slt	v0,a0,v1
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	0044 1350 	slt	v0,a0,v0
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	0044 1350 	slt	v0,a0,v0
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	3020 0000 	li	at,0
[ 0-9a-f]+:	0061 1350 	slt	v0,at,v1
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	0061 1350 	slt	v0,at,v1
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	3020 0000 	li	at,0
[ 0-9a-f]+:	0061 1350 	slt	v0,at,v1
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	0061 1350 	slt	v0,at,v1
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	0061 1350 	slt	v0,at,v1
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0061 1350 	slt	v0,at,v1
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	5021 7fff 	ori	at,at,0x7fff
[ 0-9a-f]+:	0061 1350 	slt	v0,at,v1
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	0064 1390 	sltu	v0,a0,v1
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	0044 1390 	sltu	v0,a0,v0
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	0044 1390 	sltu	v0,a0,v0
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	3020 0000 	li	at,0
[ 0-9a-f]+:	0061 1390 	sltu	v0,at,v1
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	0061 1390 	sltu	v0,at,v1
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	3020 0000 	li	at,0
[ 0-9a-f]+:	0061 1390 	sltu	v0,at,v1
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	0061 1390 	sltu	v0,at,v1
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	0061 1390 	sltu	v0,at,v1
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0061 1390 	sltu	v0,at,v1
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	5021 7fff 	ori	at,at,0x7fff
[ 0-9a-f]+:	0061 1390 	sltu	v0,at,v1
[ 0-9a-f]+:	7042 0001 	xori	v0,v0,0x1
[ 0-9a-f]+:	2522      	sll	v0,v0,1
[ 0-9a-f]+:	2524      	sll	v0,v0,2
[ 0-9a-f]+:	2526      	sll	v0,v0,3
[ 0-9a-f]+:	2528      	sll	v0,v0,4
[ 0-9a-f]+:	252a      	sll	v0,v0,5
[ 0-9a-f]+:	252c      	sll	v0,v0,6
[ 0-9a-f]+:	252e      	sll	v0,v0,7
[ 0-9a-f]+:	2520      	sll	v0,v0,8
[ 0-9a-f]+:	2530      	sll	v0,v1,8
[ 0-9a-f]+:	2540      	sll	v0,a0,8
[ 0-9a-f]+:	2550      	sll	v0,a1,8
[ 0-9a-f]+:	2560      	sll	v0,a2,8
[ 0-9a-f]+:	2570      	sll	v0,a3,8
[ 0-9a-f]+:	2500      	sll	v0,s0,8
[ 0-9a-f]+:	2510      	sll	v0,s1,8
[ 0-9a-f]+:	25a0      	sll	v1,v0,8
[ 0-9a-f]+:	2620      	sll	a0,v0,8
[ 0-9a-f]+:	26a0      	sll	a1,v0,8
[ 0-9a-f]+:	2720      	sll	a2,v0,8
[ 0-9a-f]+:	27a0      	sll	a3,v0,8
[ 0-9a-f]+:	2420      	sll	s0,v0,8
[ 0-9a-f]+:	24a0      	sll	s1,v0,8
[ 0-9a-f]+:	2522      	sll	v0,v0,1
[ 0-9a-f]+:	25b2      	sll	v1,v1,1
[ 0-9a-f]+:	0064 1010 	sllv	v0,v1,a0
[ 0-9a-f]+:	0044 1010 	sllv	v0,v0,a0
[ 0-9a-f]+:	0044 1010 	sllv	v0,v0,a0
[ 0-9a-f]+:	0044 1010 	sllv	v0,v0,a0
[ 0-9a-f]+:	0044 0000 	sll	v0,a0,0x0
[ 0-9a-f]+:	0044 0800 	sll	v0,a0,0x1
[ 0-9a-f]+:	0044 f800 	sll	v0,a0,0x1f
[ 0-9a-f]+:	0042 f800 	sll	v0,v0,0x1f
[ 0-9a-f]+:	0042 f800 	sll	v0,v0,0x1f
[ 0-9a-f]+:	0083 1350 	slt	v0,v1,a0
[ 0-9a-f]+:	0082 1350 	slt	v0,v0,a0
[ 0-9a-f]+:	0082 1350 	slt	v0,v0,a0
[ 0-9a-f]+:	9043 0000 	slti	v0,v1,0
[ 0-9a-f]+:	9043 8000 	slti	v0,v1,-32768
[ 0-9a-f]+:	9043 0000 	slti	v0,v1,0
[ 0-9a-f]+:	9043 7fff 	slti	v0,v1,32767
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	0023 1350 	slt	v0,v1,at
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0023 1350 	slt	v0,v1,at
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	5021 7fff 	ori	at,at,0x7fff
[ 0-9a-f]+:	0023 1350 	slt	v0,v1,at
[ 0-9a-f]+:	9064 8000 	slti	v1,a0,-32768
[ 0-9a-f]+:	9064 0000 	slti	v1,a0,0
[ 0-9a-f]+:	9064 7fff 	slti	v1,a0,32767
[ 0-9a-f]+:	9064 ffff 	slti	v1,a0,-1
[ 0-9a-f]+:	9063 ffff 	slti	v1,v1,-1
[ 0-9a-f]+:	9063 ffff 	slti	v1,v1,-1
[ 0-9a-f]+:	b064 8000 	sltiu	v1,a0,-32768
[ 0-9a-f]+:	b064 0000 	sltiu	v1,a0,0
[ 0-9a-f]+:	b064 7fff 	sltiu	v1,a0,32767
[ 0-9a-f]+:	b064 ffff 	sltiu	v1,a0,-1
[ 0-9a-f]+:	b063 ffff 	sltiu	v1,v1,-1
[ 0-9a-f]+:	b063 ffff 	sltiu	v1,v1,-1
[ 0-9a-f]+:	0083 1390 	sltu	v0,v1,a0
[ 0-9a-f]+:	0082 1390 	sltu	v0,v0,a0
[ 0-9a-f]+:	0082 1390 	sltu	v0,v0,a0
[ 0-9a-f]+:	b043 0000 	sltiu	v0,v1,0
[ 0-9a-f]+:	b043 8000 	sltiu	v0,v1,-32768
[ 0-9a-f]+:	b043 0000 	sltiu	v0,v1,0
[ 0-9a-f]+:	b043 7fff 	sltiu	v0,v1,32767
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	0023 1390 	sltu	v0,v1,at
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0023 1390 	sltu	v0,v1,at
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	5021 7fff 	ori	at,at,0x7fff
[ 0-9a-f]+:	0023 1390 	sltu	v0,v1,at
[ 0-9a-f]+:	0083 1310 	xor	v0,v1,a0
[ 0-9a-f]+:	0040 1390 	sltu	v0,zero,v0
[ 0-9a-f]+:	0080 1390 	sltu	v0,zero,a0
[ 0-9a-f]+:	0060 1390 	sltu	v0,zero,v1
[ 0-9a-f]+:	0060 1390 	sltu	v0,zero,v1
[ 0-9a-f]+:	7043 0001 	xori	v0,v1,0x1
[ 0-9a-f]+:	0040 1390 	sltu	v0,zero,v0
[ 0-9a-f]+:	3043 0001 	addiu	v0,v1,1
[ 0-9a-f]+:	0040 1390 	sltu	v0,zero,v0
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	5021 7fff 	ori	at,at,0x7fff
[ 0-9a-f]+:	0023 1310 	xor	v0,v1,at
[ 0-9a-f]+:	0040 1390 	sltu	v0,zero,v0
[ 0-9a-f]+:	0064 1090 	srav	v0,v1,a0
[ 0-9a-f]+:	0044 1090 	srav	v0,v0,a0
[ 0-9a-f]+:	0044 1090 	srav	v0,v0,a0
[ 0-9a-f]+:	0044 1090 	srav	v0,v0,a0
[ 0-9a-f]+:	0044 0080 	sra	v0,a0,0x0
[ 0-9a-f]+:	0044 0880 	sra	v0,a0,0x1
[ 0-9a-f]+:	0044 f880 	sra	v0,a0,0x1f
[ 0-9a-f]+:	0042 f880 	sra	v0,v0,0x1f
[ 0-9a-f]+:	0042 f880 	sra	v0,v0,0x1f
[ 0-9a-f]+:	0064 1050 	srlv	v0,v1,a0
[ 0-9a-f]+:	0044 1050 	srlv	v0,v0,a0
[ 0-9a-f]+:	0044 1050 	srlv	v0,v0,a0
[ 0-9a-f]+:	0044 1050 	srlv	v0,v0,a0
[ 0-9a-f]+:	0044 0040 	srl	v0,a0,0x0
[ 0-9a-f]+:	2543      	srl	v0,a0,1
[ 0-9a-f]+:	0044 f840 	srl	v0,a0,0x1f
[ 0-9a-f]+:	0042 f840 	srl	v0,v0,0x1f
[ 0-9a-f]+:	0042 f840 	srl	v0,v0,0x1f
[ 0-9a-f]+:	2523      	srl	v0,v0,1
[ 0-9a-f]+:	2525      	srl	v0,v0,2
[ 0-9a-f]+:	2527      	srl	v0,v0,3
[ 0-9a-f]+:	2529      	srl	v0,v0,4
[ 0-9a-f]+:	252b      	srl	v0,v0,5
[ 0-9a-f]+:	252d      	srl	v0,v0,6
[ 0-9a-f]+:	252f      	srl	v0,v0,7
[ 0-9a-f]+:	2521      	srl	v0,v0,8
[ 0-9a-f]+:	2531      	srl	v0,v1,8
[ 0-9a-f]+:	2541      	srl	v0,a0,8
[ 0-9a-f]+:	2551      	srl	v0,a1,8
[ 0-9a-f]+:	2561      	srl	v0,a2,8
[ 0-9a-f]+:	2571      	srl	v0,a3,8
[ 0-9a-f]+:	2501      	srl	v0,s0,8
[ 0-9a-f]+:	2511      	srl	v0,s1,8
[ 0-9a-f]+:	2521      	srl	v0,v0,8
[ 0-9a-f]+:	25a1      	srl	v1,v0,8
[ 0-9a-f]+:	2621      	srl	a0,v0,8
[ 0-9a-f]+:	26a1      	srl	a1,v0,8
[ 0-9a-f]+:	2721      	srl	a2,v0,8
[ 0-9a-f]+:	27a1      	srl	a3,v0,8
[ 0-9a-f]+:	2421      	srl	s0,v0,8
[ 0-9a-f]+:	24a1      	srl	s1,v0,8
[ 0-9a-f]+:	25b3      	srl	v1,v1,1
[ 0-9a-f]+:	25b3      	srl	v1,v1,1
[ 0-9a-f]+:	0083 1190 	sub	v0,v1,a0
[ 0-9a-f]+:	03fe e990 	sub	sp,s8,ra
[ 0-9a-f]+:	0082 1190 	sub	v0,v0,a0
[ 0-9a-f]+:	0082 1190 	sub	v0,v0,a0
[ 0-9a-f]+:	05a5      	subu	v0,v1,v0
[ 0-9a-f]+:	05b5      	subu	v0,v1,v1
[ 0-9a-f]+:	05c5      	subu	v0,v1,a0
[ 0-9a-f]+:	05d5      	subu	v0,v1,a1
[ 0-9a-f]+:	05e5      	subu	v0,v1,a2
[ 0-9a-f]+:	05f5      	subu	v0,v1,a3
[ 0-9a-f]+:	0585      	subu	v0,v1,s0
[ 0-9a-f]+:	0595      	subu	v0,v1,s1
[ 0-9a-f]+:	0515      	subu	v0,v0,s1
[ 0-9a-f]+:	0615      	subu	v0,a0,s1
[ 0-9a-f]+:	0695      	subu	v0,a1,s1
[ 0-9a-f]+:	0715      	subu	v0,a2,s1
[ 0-9a-f]+:	0795      	subu	v0,a3,s1
[ 0-9a-f]+:	0415      	subu	v0,s0,s1
[ 0-9a-f]+:	0495      	subu	v0,s1,s1
[ 0-9a-f]+:	0515      	subu	v0,v0,s1
[ 0-9a-f]+:	0517      	subu	v1,v0,s1
[ 0-9a-f]+:	0519      	subu	a0,v0,s1
[ 0-9a-f]+:	051b      	subu	a1,v0,s1
[ 0-9a-f]+:	051d      	subu	a2,v0,s1
[ 0-9a-f]+:	051f      	subu	a3,v0,s1
[ 0-9a-f]+:	0511      	subu	s0,v0,s1
[ 0-9a-f]+:	0513      	subu	s1,v0,s1
[ 0-9a-f]+:	07af      	subu	a3,a3,v0
[ 0-9a-f]+:	07af      	subu	a3,a3,v0
[ 0-9a-f]+:	0083 11d0 	subu	v0,v1,a0
[ 0-9a-f]+:	03fe e9d0 	subu	sp,s8,ra
[ 0-9a-f]+:	0082 11d0 	subu	v0,v0,a0
[ 0-9a-f]+:	0082 11d0 	subu	v0,v0,a0
[ 0-9a-f]+:	3042 0000 	addiu	v0,v0,0
[ 0-9a-f]+:	3042 ffff 	addiu	v0,v0,-1
[ 0-9a-f]+:	3042 8001 	addiu	v0,v0,-32767
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	0022 11d0 	subu	v0,v0,at
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	0022 11d0 	subu	v0,v0,at
[ 0-9a-f]+:	e940      	sw	v0,0\(a0\)
[ 0-9a-f]+:	e940      	sw	v0,0\(a0\)
[ 0-9a-f]+:	e941      	sw	v0,4\(a0\)
[ 0-9a-f]+:	e942      	sw	v0,8\(a0\)
[ 0-9a-f]+:	e943      	sw	v0,12\(a0\)
[ 0-9a-f]+:	e944      	sw	v0,16\(a0\)
[ 0-9a-f]+:	e945      	sw	v0,20\(a0\)
[ 0-9a-f]+:	e946      	sw	v0,24\(a0\)
[ 0-9a-f]+:	e947      	sw	v0,28\(a0\)
[ 0-9a-f]+:	e948      	sw	v0,32\(a0\)
[ 0-9a-f]+:	e949      	sw	v0,36\(a0\)
[ 0-9a-f]+:	e94a      	sw	v0,40\(a0\)
[ 0-9a-f]+:	e94b      	sw	v0,44\(a0\)
[ 0-9a-f]+:	e94c      	sw	v0,48\(a0\)
[ 0-9a-f]+:	e94d      	sw	v0,52\(a0\)
[ 0-9a-f]+:	e94e      	sw	v0,56\(a0\)
[ 0-9a-f]+:	e94f      	sw	v0,60\(a0\)
[ 0-9a-f]+:	e95f      	sw	v0,60\(a1\)
[ 0-9a-f]+:	e96f      	sw	v0,60\(a2\)
[ 0-9a-f]+:	e97f      	sw	v0,60\(a3\)
[ 0-9a-f]+:	e90f      	sw	v0,60\(s0\)
[ 0-9a-f]+:	e91f      	sw	v0,60\(s1\)
[ 0-9a-f]+:	e92f      	sw	v0,60\(v0\)
[ 0-9a-f]+:	e93f      	sw	v0,60\(v1\)
[ 0-9a-f]+:	e9bf      	sw	v1,60\(v1\)
[ 0-9a-f]+:	ea3f      	sw	a0,60\(v1\)
[ 0-9a-f]+:	eabf      	sw	a1,60\(v1\)
[ 0-9a-f]+:	eb3f      	sw	a2,60\(v1\)
[ 0-9a-f]+:	ebbf      	sw	a3,60\(v1\)
[ 0-9a-f]+:	e8bf      	sw	s1,60\(v1\)
[ 0-9a-f]+:	e83f      	sw	zero,60\(v1\)
[ 0-9a-f]+:	c800      	sw	zero,0\(sp\)
[ 0-9a-f]+:	c800      	sw	zero,0\(sp\)
[ 0-9a-f]+:	c801      	sw	zero,4\(sp\)
[ 0-9a-f]+:	c802      	sw	zero,8\(sp\)
[ 0-9a-f]+:	c803      	sw	zero,12\(sp\)
[ 0-9a-f]+:	c804      	sw	zero,16\(sp\)
[ 0-9a-f]+:	c805      	sw	zero,20\(sp\)
[ 0-9a-f]+:	c81e      	sw	zero,120\(sp\)
[ 0-9a-f]+:	c81f      	sw	zero,124\(sp\)
[ 0-9a-f]+:	c85f      	sw	v0,124\(sp\)
[ 0-9a-f]+:	ca3f      	sw	s1,124\(sp\)
[ 0-9a-f]+:	c87f      	sw	v1,124\(sp\)
[ 0-9a-f]+:	c89f      	sw	a0,124\(sp\)
[ 0-9a-f]+:	c8bf      	sw	a1,124\(sp\)
[ 0-9a-f]+:	c8df      	sw	a2,124\(sp\)
[ 0-9a-f]+:	c8ff      	sw	a3,124\(sp\)
[ 0-9a-f]+:	cbff      	sw	ra,124\(sp\)
[ 0-9a-f]+:	f860 0004 	sw	v1,4\(zero\)
[ 0-9a-f]+:	f860 0004 	sw	v1,4\(zero\)
[ 0-9a-f]+:	f860 7fff 	sw	v1,32767\(zero\)
[ 0-9a-f]+:	f860 8000 	sw	v1,-32768\(zero\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	f861 ffff 	sw	v1,-1\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	f861 0000 	sw	v1,0\(at\)
[ 0-9a-f]+:	f860 8000 	sw	v1,-32768\(zero\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	f861 0001 	sw	v1,1\(at\)
[ 0-9a-f]+:	f860 8001 	sw	v1,-32767\(zero\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	f861 0000 	sw	v1,0\(at\)
[ 0-9a-f]+:	f860 ffff 	sw	v1,-1\(zero\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	f861 5678 	sw	v1,22136\(at\)
[ 0-9a-f]+:	f864 0000 	sw	v1,0\(a0\)
[ 0-9a-f]+:	f864 0000 	sw	v1,0\(a0\)
[ 0-9a-f]+:	f864 7fff 	sw	v1,32767\(a0\)
[ 0-9a-f]+:	f864 8000 	sw	v1,-32768\(a0\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	f861 ffff 	sw	v1,-1\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	f861 0000 	sw	v1,0\(at\)
[ 0-9a-f]+:	f864 8000 	sw	v1,-32768\(a0\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	f861 0001 	sw	v1,1\(at\)
[ 0-9a-f]+:	f864 8001 	sw	v1,-32767\(a0\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	f861 0000 	sw	v1,0\(at\)
[ 0-9a-f]+:	f864 ffff 	sw	v1,-1\(a0\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	f861 5678 	sw	v1,22136\(at\)
[ 0-9a-f]+:	44ca      	swm	s0,ra,48\(sp\)
[ 0-9a-f]+:	45ca      	swm	s0-s1,ra,48\(sp\)
[ 0-9a-f]+:	45ca      	swm	s0-s1,ra,48\(sp\)
[ 0-9a-f]+:	46ca      	swm	s0-s2,ra,48\(sp\)
[ 0-9a-f]+:	46ca      	swm	s0-s2,ra,48\(sp\)
[ 0-9a-f]+:	47ca      	swm	s0-s3,ra,48\(sp\)
[ 0-9a-f]+:	47ca      	swm	s0-s3,ra,48\(sp\)
[ 0-9a-f]+:	440a      	swm	s0,ra,0\(sp\)
[ 0-9a-f]+:	440a      	swm	s0,ra,0\(sp\)
[ 0-9a-f]+:	441a      	swm	s0,ra,4\(sp\)
[ 0-9a-f]+:	442a      	swm	s0,ra,8\(sp\)
[ 0-9a-f]+:	443a      	swm	s0,ra,12\(sp\)
[ 0-9a-f]+:	444a      	swm	s0,ra,16\(sp\)
[ 0-9a-f]+:	445a      	swm	s0,ra,20\(sp\)
[ 0-9a-f]+:	446a      	swm	s0,ra,24\(sp\)
[ 0-9a-f]+:	447a      	swm	s0,ra,28\(sp\)
[ 0-9a-f]+:	448a      	swm	s0,ra,32\(sp\)
[ 0-9a-f]+:	449a      	swm	s0,ra,36\(sp\)
[ 0-9a-f]+:	44aa      	swm	s0,ra,40\(sp\)
[ 0-9a-f]+:	44ba      	swm	s0,ra,44\(sp\)
[ 0-9a-f]+:	44ca      	swm	s0,ra,48\(sp\)
[ 0-9a-f]+:	44da      	swm	s0,ra,52\(sp\)
[ 0-9a-f]+:	44ea      	swm	s0,ra,56\(sp\)
[ 0-9a-f]+:	44fa      	swm	s0,ra,60\(sp\)
[ 0-9a-f]+:	2020 d000 	swm	s0,0\(zero\)
[ 0-9a-f]+:	2020 d004 	swm	s0,4\(zero\)
[ 0-9a-f]+:	2020 d7ff 	swm	s0,2047\(zero\)
[ 0-9a-f]+:	2020 d800 	swm	s0,-2048\(zero\)
[ 0-9a-f]+:	3020 0800 	li	at,2048
[ 0-9a-f]+:	2021 d000 	swm	s0,0\(at\)
[ 0-9a-f]+:	3020 f7ff 	li	at,-2049
[ 0-9a-f]+:	2021 d000 	swm	s0,0\(at\)
[ 0-9a-f]+:	2025 d000 	swm	s0,0\(a1\)
[ 0-9a-f]+:	2025 d7ff 	swm	s0,2047\(a1\)
[ 0-9a-f]+:	2025 d800 	swm	s0,-2048\(a1\)
[ 0-9a-f]+:	3025 0800 	addiu	at,a1,2048
[ 0-9a-f]+:	2021 d000 	swm	s0,0\(at\)
[ 0-9a-f]+:	3025 f7ff 	addiu	at,a1,-2049
[ 0-9a-f]+:	2021 d000 	swm	s0,0\(at\)
[ 0-9a-f]+:	2045 d7ff 	swm	s0-s1,2047\(a1\)
[ 0-9a-f]+:	2065 d7ff 	swm	s0-s2,2047\(a1\)
[ 0-9a-f]+:	2085 d7ff 	swm	s0-s3,2047\(a1\)
[ 0-9a-f]+:	20a5 d7ff 	swm	s0-s4,2047\(a1\)
[ 0-9a-f]+:	20c5 d7ff 	swm	s0-s5,2047\(a1\)
[ 0-9a-f]+:	20e5 d7ff 	swm	s0-s6,2047\(a1\)
[ 0-9a-f]+:	2105 d7ff 	swm	s0-s7,2047\(a1\)
[ 0-9a-f]+:	2125 d7ff 	swm	s0-s7,s8,2047\(a1\)
[ 0-9a-f]+:	2205 d7ff 	swm	ra,2047\(a1\)
[ 0-9a-f]+:	2225 d000 	swm	s0,ra,0\(a1\)
[ 0-9a-f]+:	2245 d000 	swm	s0-s1,ra,0\(a1\)
[ 0-9a-f]+:	2265 d000 	swm	s0-s2,ra,0\(a1\)
[ 0-9a-f]+:	2285 d000 	swm	s0-s3,ra,0\(a1\)
[ 0-9a-f]+:	22a5 d000 	swm	s0-s4,ra,0\(a1\)
[ 0-9a-f]+:	22c5 d000 	swm	s0-s5,ra,0\(a1\)
[ 0-9a-f]+:	22e5 d000 	swm	s0-s6,ra,0\(a1\)
[ 0-9a-f]+:	2305 d000 	swm	s0-s7,ra,0\(a1\)
[ 0-9a-f]+:	2325 d000 	swm	s0-s7,s8,ra,0\(a1\)
[ 0-9a-f]+:	303d 8000 	addiu	at,sp,-32768
[ 0-9a-f]+:	2021 d000 	swm	s0,0\(at\)
[ 0-9a-f]+:	303d 7fff 	addiu	at,sp,32767
[ 0-9a-f]+:	2021 d000 	swm	s0,0\(at\)
[ 0-9a-f]+:	203d d000 	swm	s0,0\(sp\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	03a1 0950 	addu	at,at,sp
[ 0-9a-f]+:	2021 dfff 	swm	s0,-1\(at\)
[ 0-9a-f]+:	2040 9000 	swp	v0,0\(zero\)
[ 0-9a-f]+:	2040 9004 	swp	v0,4\(zero\)
[ 0-9a-f]+:	2040 97ff 	swp	v0,2047\(zero\)
[ 0-9a-f]+:	2040 9800 	swp	v0,-2048\(zero\)
[ 0-9a-f]+:	3020 0800 	li	at,2048
[ 0-9a-f]+:	2041 9000 	swp	v0,0\(at\)
[ 0-9a-f]+:	3020 f7ff 	li	at,-2049
[ 0-9a-f]+:	2041 9000 	swp	v0,0\(at\)
[ 0-9a-f]+:	205d 9000 	swp	v0,0\(sp\)
[ 0-9a-f]+:	205d 9000 	swp	v0,0\(sp\)
[ 0-9a-f]+:	2043 97ff 	swp	v0,2047\(v1\)
[ 0-9a-f]+:	2043 9800 	swp	v0,-2048\(v1\)
[ 0-9a-f]+:	3023 0800 	addiu	at,v1,2048
[ 0-9a-f]+:	2041 9000 	swp	v0,0\(at\)
[ 0-9a-f]+:	3023 f7ff 	addiu	at,v1,-2049
[ 0-9a-f]+:	2041 9000 	swp	v0,0\(at\)
[ 0-9a-f]+:	3023 7fff 	addiu	at,v1,32767
[ 0-9a-f]+:	2041 9000 	swp	v0,0\(at\)
[ 0-9a-f]+:	3023 8000 	addiu	at,v1,-32768
[ 0-9a-f]+:	2041 9000 	swp	v0,0\(at\)
[ 0-9a-f]+:	2043 9000 	swp	v0,0\(v1\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0061 0950 	addu	at,at,v1
[ 0-9a-f]+:	2041 9fff 	swp	v0,-1\(at\)
[ 0-9a-f]+:	0000 6b7c 	sync
[ 0-9a-f]+:	0000 6b7c 	sync
[ 0-9a-f]+:	0001 6b7c 	sync	0x1
[ 0-9a-f]+:	0002 6b7c 	sync	0x2
[ 0-9a-f]+:	0003 6b7c 	sync	0x3
[ 0-9a-f]+:	0004 6b7c 	sync_wmb
[ 0-9a-f]+:	001e 6b7c 	sync	0x1e
[ 0-9a-f]+:	001f 6b7c 	sync	0x1f
[ 0-9a-f]+:	4180 0000 	synci	0\(zero\)
[ 0-9a-f]+:	4180 0000 	synci	0\(zero\)
[ 0-9a-f]+:	4180 0000 	synci	0\(zero\)
[ 0-9a-f]+:	4180 07ff 	synci	2047\(zero\)
[ 0-9a-f]+:	4180 f800 	synci	-2048\(zero\)
[ 0-9a-f]+:	4180 0800 	synci	2048\(zero\)
[ 0-9a-f]+:	4180 f7ff 	synci	-2049\(zero\)
[ 0-9a-f]+:	4180 7fff 	synci	32767\(zero\)
[ 0-9a-f]+:	4180 8000 	synci	-32768\(zero\)
[ 0-9a-f]+:	4182 0000 	synci	0\(v0\)
[ 0-9a-f]+:	4183 0000 	synci	0\(v1\)
[ 0-9a-f]+:	4183 07ff 	synci	2047\(v1\)
[ 0-9a-f]+:	4183 f800 	synci	-2048\(v1\)
[ 0-9a-f]+:	4183 0800 	synci	2048\(v1\)
[ 0-9a-f]+:	4183 f7ff 	synci	-2049\(v1\)
[ 0-9a-f]+:	4183 7fff 	synci	32767\(v1\)
[ 0-9a-f]+:	4183 8000 	synci	-32768\(v1\)
[ 0-9a-f]+:	0000 8b7c 	syscall
[ 0-9a-f]+:	0000 8b7c 	syscall
[ 0-9a-f]+:	0001 8b7c 	syscall	0x1
[ 0-9a-f]+:	0002 8b7c 	syscall	0x2
[ 0-9a-f]+:	00ff 8b7c 	syscall	0xff
[ 0-9a-f]+:	0062 003c 	teq	v0,v1
[ 0-9a-f]+:	0043 003c 	teq	v1,v0
[ 0-9a-f]+:	0062 003c 	teq	v0,v1
[ 0-9a-f]+:	0062 103c 	teq	v0,v1,0x1
[ 0-9a-f]+:	0062 f03c 	teq	v0,v1,0xf
[ 0-9a-f]+:	3020 0000 	li	at,0
[ 0-9a-f]+:	0022 003c 	teq	v0,at
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	0022 003c 	teq	v0,at
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	0022 003c 	teq	v0,at
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	0022 003c 	teq	v0,at
[ 0-9a-f]+:	0062 023c 	tge	v0,v1
[ 0-9a-f]+:	0043 023c 	tge	v1,v0
[ 0-9a-f]+:	0062 023c 	tge	v0,v1
[ 0-9a-f]+:	0062 123c 	tge	v0,v1,0x1
[ 0-9a-f]+:	0062 f23c 	tge	v0,v1,0xf
[ 0-9a-f]+:	3020 0000 	li	at,0
[ 0-9a-f]+:	0022 023c 	tge	v0,at
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	0022 023c 	tge	v0,at
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	0022 023c 	tge	v0,at
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	0022 023c 	tge	v0,at
[ 0-9a-f]+:	0062 043c 	tgeu	v0,v1
[ 0-9a-f]+:	0043 043c 	tgeu	v1,v0
[ 0-9a-f]+:	0062 043c 	tgeu	v0,v1
[ 0-9a-f]+:	0062 143c 	tgeu	v0,v1,0x1
[ 0-9a-f]+:	0062 f43c 	tgeu	v0,v1,0xf
[ 0-9a-f]+:	3020 0000 	li	at,0
[ 0-9a-f]+:	0022 043c 	tgeu	v0,at
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	0022 043c 	tgeu	v0,at
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	0022 043c 	tgeu	v0,at
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	0022 043c 	tgeu	v0,at
[ 0-9a-f]+:	0000 037c 	tlbp
[ 0-9a-f]+:	0000 137c 	tlbr
[ 0-9a-f]+:	0000 237c 	tlbwi
[ 0-9a-f]+:	0000 337c 	tlbwr
[ 0-9a-f]+:	0062 083c 	tlt	v0,v1
[ 0-9a-f]+:	0043 083c 	tlt	v1,v0
[ 0-9a-f]+:	0062 083c 	tlt	v0,v1
[ 0-9a-f]+:	0062 183c 	tlt	v0,v1,0x1
[ 0-9a-f]+:	0062 f83c 	tlt	v0,v1,0xf
[ 0-9a-f]+:	3020 0000 	li	at,0
[ 0-9a-f]+:	0022 083c 	tlt	v0,at
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	0022 083c 	tlt	v0,at
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	0022 083c 	tlt	v0,at
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	0022 083c 	tlt	v0,at
[ 0-9a-f]+:	0062 0a3c 	tltu	v0,v1
[ 0-9a-f]+:	0043 0a3c 	tltu	v1,v0
[ 0-9a-f]+:	0062 0a3c 	tltu	v0,v1
[ 0-9a-f]+:	0062 1a3c 	tltu	v0,v1,0x1
[ 0-9a-f]+:	0062 fa3c 	tltu	v0,v1,0xf
[ 0-9a-f]+:	3020 0000 	li	at,0
[ 0-9a-f]+:	0022 0a3c 	tltu	v0,at
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	0022 0a3c 	tltu	v0,at
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	0022 0a3c 	tltu	v0,at
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	0022 0a3c 	tltu	v0,at
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0022 0a3c 	tltu	v0,at
[ 0-9a-f]+:	3020 ffff 	li	at,-1
[ 0-9a-f]+:	0022 0a3c 	tltu	v0,at
[ 0-9a-f]+:	0062 0c3c 	tne	v0,v1
[ 0-9a-f]+:	0043 0c3c 	tne	v1,v0
[ 0-9a-f]+:	0062 0c3c 	tne	v0,v1
[ 0-9a-f]+:	0062 1c3c 	tne	v0,v1,0x1
[ 0-9a-f]+:	0062 fc3c 	tne	v0,v1,0xf
[ 0-9a-f]+:	3020 0000 	li	at,0
[ 0-9a-f]+:	0022 0c3c 	tne	v0,at
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	0022 0c3c 	tne	v0,at
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	0022 0c3c 	tne	v0,at
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	0022 0c3c 	tne	v0,at
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0022 0c3c 	tne	v0,at
[ 0-9a-f]+:	3020 ffff 	li	at,-1
[ 0-9a-f]+:	0022 0c3c 	tne	v0,at
[ 0-9a-f]+:	0000 937c 	wait
[ 0-9a-f]+:	0000 937c 	wait
[ 0-9a-f]+:	0001 937c 	wait	0x1
[ 0-9a-f]+:	00ff 937c 	wait	0xff
[ 0-9a-f]+:	0043 f17c 	wrpgpr	v0,v1
[ 0-9a-f]+:	0044 f17c 	wrpgpr	v0,a0
[ 0-9a-f]+:	0042 f17c 	wrpgpr	v0,v0
[ 0-9a-f]+:	0042 f17c 	wrpgpr	v0,v0
[ 0-9a-f]+:	0043 7b3c 	wsbh	v0,v1
[ 0-9a-f]+:	0044 7b3c 	wsbh	v0,a0
[ 0-9a-f]+:	0042 7b3c 	wsbh	v0,v0
[ 0-9a-f]+:	0042 7b3c 	wsbh	v0,v0
[ 0-9a-f]+:	4528      	xor	v0,v0,v0
[ 0-9a-f]+:	4538      	xor	v0,v0,v1
[ 0-9a-f]+:	4548      	xor	v0,v0,a0
[ 0-9a-f]+:	4558      	xor	v0,v0,a1
[ 0-9a-f]+:	4568      	xor	v0,v0,a2
[ 0-9a-f]+:	4578      	xor	v0,v0,a3
[ 0-9a-f]+:	4508      	xor	v0,v0,s0
[ 0-9a-f]+:	4518      	xor	v0,v0,s1
[ 0-9a-f]+:	4598      	xor	v1,v1,s1
[ 0-9a-f]+:	4618      	xor	a0,a0,s1
[ 0-9a-f]+:	4698      	xor	a1,a1,s1
[ 0-9a-f]+:	4718      	xor	a2,a2,s1
[ 0-9a-f]+:	4798      	xor	a3,a3,s1
[ 0-9a-f]+:	4418      	xor	s0,s0,s1
[ 0-9a-f]+:	4498      	xor	s1,s1,s1
[ 0-9a-f]+:	4538      	xor	v0,v0,v1
[ 0-9a-f]+:	4538      	xor	v0,v0,v1
[ 0-9a-f]+:	4538      	xor	v0,v0,v1
[ 0-9a-f]+:	0083 1310 	xor	v0,v1,a0
[ 0-9a-f]+:	03fe eb10 	xor	sp,s8,ra
[ 0-9a-f]+:	0082 1310 	xor	v0,v0,a0
[ 0-9a-f]+:	0082 1310 	xor	v0,v0,a0
[ 0-9a-f]+:	7043 8000 	xori	v0,v1,0x8000
[ 0-9a-f]+:	7043 ffff 	xori	v0,v1,0xffff
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0023 1310 	xor	v0,v1,at
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	0023 1310 	xor	v0,v1,at
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	5021 7fff 	ori	at,at,0x7fff
[ 0-9a-f]+:	0023 1310 	xor	v0,v1,at
[ 0-9a-f]+:	7064 0000 	xori	v1,a0,0x0
[ 0-9a-f]+:	7064 7fff 	xori	v1,a0,0x7fff
[ 0-9a-f]+:	7064 ffff 	xori	v1,a0,0xffff
[ 0-9a-f]+:	7063 ffff 	xori	v1,v1,0xffff
[ 0-9a-f]+:	7063 ffff 	xori	v1,v1,0xffff
[ 0-9a-f]+:	6d01      	addiu	v0,sp,0
[ 0-9a-f]+:	6d03      	addiu	v0,sp,4
[ 0-9a-f]+:	6d05      	addiu	v0,sp,8
[ 0-9a-f]+:	6d07      	addiu	v0,sp,12
[ 0-9a-f]+:	6d09      	addiu	v0,sp,16
[ 0-9a-f]+:	6d7f      	addiu	v0,sp,252
[ 0-9a-f]+:	6dff      	addiu	v1,sp,252
[ 0-9a-f]+:	6e7f      	addiu	a0,sp,252
[ 0-9a-f]+:	6eff      	addiu	a1,sp,252
[ 0-9a-f]+:	6f7f      	addiu	a2,sp,252
[ 0-9a-f]+:	6fff      	addiu	a3,sp,252
[ 0-9a-f]+:	6c7f      	addiu	s0,sp,252
[ 0-9a-f]+:	6cff      	addiu	s1,sp,252
[ 0-9a-f]+:	6d2e      	addiu	v0,v0,-1
[ 0-9a-f]+:	6d3e      	addiu	v0,v1,-1
[ 0-9a-f]+:	6d4e      	addiu	v0,a0,-1
[ 0-9a-f]+:	6d5e      	addiu	v0,a1,-1
[ 0-9a-f]+:	6d6e      	addiu	v0,a2,-1
[ 0-9a-f]+:	6d7e      	addiu	v0,a3,-1
[ 0-9a-f]+:	6d0e      	addiu	v0,s0,-1
[ 0-9a-f]+:	6d1e      	addiu	v0,s1,-1
[ 0-9a-f]+:	6d9e      	addiu	v1,s1,-1
[ 0-9a-f]+:	6e1e      	addiu	a0,s1,-1
[ 0-9a-f]+:	6e9e      	addiu	a1,s1,-1
[ 0-9a-f]+:	6f1e      	addiu	a2,s1,-1
[ 0-9a-f]+:	6f9e      	addiu	a3,s1,-1
[ 0-9a-f]+:	6c1e      	addiu	s0,s1,-1
[ 0-9a-f]+:	6c9e      	addiu	s1,s1,-1
[ 0-9a-f]+:	6c90      	addiu	s1,s1,1
[ 0-9a-f]+:	6c92      	addiu	s1,s1,4
[ 0-9a-f]+:	6c94      	addiu	s1,s1,8
[ 0-9a-f]+:	6c96      	addiu	s1,s1,12
[ 0-9a-f]+:	6c98      	addiu	s1,s1,16
[ 0-9a-f]+:	6c9a      	addiu	s1,s1,20
[ 0-9a-f]+:	6c9c      	addiu	s1,s1,24
[ 0-9a-f]+:	4c05      	addiu	sp,sp,8
[ 0-9a-f]+:	4c07      	addiu	sp,sp,12
[ 0-9a-f]+:	4dfd      	addiu	sp,sp,1016
[ 0-9a-f]+:	4dff      	addiu	sp,sp,1020
[ 0-9a-f]+:	4c01      	addiu	sp,sp,1024
[ 0-9a-f]+:	4c03      	addiu	sp,sp,1028
[ 0-9a-f]+:	4ffb      	addiu	sp,sp,-12
[ 0-9a-f]+:	4ff9      	addiu	sp,sp,-16
[ 0-9a-f]+:	4e03      	addiu	sp,sp,-1020
[ 0-9a-f]+:	4e01      	addiu	sp,sp,-1024
[ 0-9a-f]+:	4fff      	addiu	sp,sp,-1028
[ 0-9a-f]+:	4ffd      	addiu	sp,sp,-1032
[ 0-9a-f]+:	4c00      	addiu	zero,zero,0
[ 0-9a-f]+:	4c40      	addiu	v0,v0,0
[ 0-9a-f]+:	4c60      	addiu	v1,v1,0
[ 0-9a-f]+:	4fc0      	addiu	s8,s8,0
[ 0-9a-f]+:	4fe0      	addiu	ra,ra,0
[ 0-9a-f]+:	4fe2      	addiu	ra,ra,1
[ 0-9a-f]+:	4fe4      	addiu	ra,ra,2
[ 0-9a-f]+:	4fe6      	addiu	ra,ra,3
[ 0-9a-f]+:	4fee      	addiu	ra,ra,7
[ 0-9a-f]+:	4ff4      	addiu	ra,ra,-6
[ 0-9a-f]+:	4ff2      	addiu	ra,ra,-7
[ 0-9a-f]+:	4ff0      	addiu	ra,ra,-8
[ 0-9a-f]+:	f860 0004 	sw	v1,4\(zero\)
[ 0-9a-f]+:	f880 0008 	sw	a0,8\(zero\)
[ 0-9a-f]+:	f860 0004 	sw	v1,4\(zero\)
[ 0-9a-f]+:	f880 0008 	sw	a0,8\(zero\)
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	f861 0000 	sw	v1,0\(at\)
[ 0-9a-f]+:	f881 0004 	sw	a0,4\(at\)
[ 0-9a-f]+:	f860 8000 	sw	v1,-32768\(zero\)
[ 0-9a-f]+:	f880 8004 	sw	a0,-32764\(zero\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	f861 ffff 	sw	v1,-1\(at\)
[ 0-9a-f]+:	f881 0003 	sw	a0,3\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	f861 0000 	sw	v1,0\(at\)
[ 0-9a-f]+:	f881 0004 	sw	a0,4\(at\)
[ 0-9a-f]+:	f860 8000 	sw	v1,-32768\(zero\)
[ 0-9a-f]+:	f880 8004 	sw	a0,-32764\(zero\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	f861 0001 	sw	v1,1\(at\)
[ 0-9a-f]+:	f881 0005 	sw	a0,5\(at\)
[ 0-9a-f]+:	f860 8001 	sw	v1,-32767\(zero\)
[ 0-9a-f]+:	f880 8005 	sw	a0,-32763\(zero\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	f861 0000 	sw	v1,0\(at\)
[ 0-9a-f]+:	f881 0004 	sw	a0,4\(at\)
[ 0-9a-f]+:	f860 ffff 	sw	v1,-1\(zero\)
[ 0-9a-f]+:	f880 0003 	sw	a0,3\(zero\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	f861 5678 	sw	v1,22136\(at\)
[ 0-9a-f]+:	f881 567c 	sw	a0,22140\(at\)
[ 0-9a-f]+:	f864 0000 	sw	v1,0\(a0\)
[ 0-9a-f]+:	f884 0004 	sw	a0,4\(a0\)
[ 0-9a-f]+:	f864 0000 	sw	v1,0\(a0\)
[ 0-9a-f]+:	f884 0004 	sw	a0,4\(a0\)
[ 0-9a-f]+:	3024 7fff 	addiu	at,a0,32767
[ 0-9a-f]+:	f861 0000 	sw	v1,0\(at\)
[ 0-9a-f]+:	f881 0004 	sw	a0,4\(at\)
[ 0-9a-f]+:	f864 8000 	sw	v1,-32768\(a0\)
[ 0-9a-f]+:	f884 8004 	sw	a0,-32764\(a0\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0024 0950 	addu	at,a0,at
[ 0-9a-f]+:	f861 ffff 	sw	v1,-1\(at\)
[ 0-9a-f]+:	f881 0003 	sw	a0,3\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0024 0950 	addu	at,a0,at
[ 0-9a-f]+:	f861 0000 	sw	v1,0\(at\)
[ 0-9a-f]+:	f881 0004 	sw	a0,4\(at\)
[ 0-9a-f]+:	f864 8000 	sw	v1,-32768\(a0\)
[ 0-9a-f]+:	f884 8004 	sw	a0,-32764\(a0\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0024 0950 	addu	at,a0,at
[ 0-9a-f]+:	f861 0001 	sw	v1,1\(at\)
[ 0-9a-f]+:	f881 0005 	sw	a0,5\(at\)
[ 0-9a-f]+:	f864 8001 	sw	v1,-32767\(a0\)
[ 0-9a-f]+:	f884 8005 	sw	a0,-32763\(a0\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	0024 0950 	addu	at,a0,at
[ 0-9a-f]+:	f861 0000 	sw	v1,0\(at\)
[ 0-9a-f]+:	f881 0004 	sw	a0,4\(at\)
[ 0-9a-f]+:	f864 ffff 	sw	v1,-1\(a0\)
[ 0-9a-f]+:	f884 0003 	sw	a0,3\(a0\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	0024 0950 	addu	at,a0,at
[ 0-9a-f]+:	f861 5678 	sw	v1,22136\(at\)
[ 0-9a-f]+:	f881 567c 	sw	a0,22140\(at\)
[ 0-9a-f]+:	fc60 0004 	lw	v1,4\(zero\)
[ 0-9a-f]+:	fc80 0008 	lw	a0,8\(zero\)
[ 0-9a-f]+:	fc60 0004 	lw	v1,4\(zero\)
[ 0-9a-f]+:	fc80 0008 	lw	a0,8\(zero\)
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	fc61 0000 	lw	v1,0\(at\)
[ 0-9a-f]+:	fc81 0004 	lw	a0,4\(at\)
[ 0-9a-f]+:	fc60 8000 	lw	v1,-32768\(zero\)
[ 0-9a-f]+:	fc80 8004 	lw	a0,-32764\(zero\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	fc61 ffff 	lw	v1,-1\(at\)
[ 0-9a-f]+:	fc81 0003 	lw	a0,3\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	fc61 0000 	lw	v1,0\(at\)
[ 0-9a-f]+:	fc81 0004 	lw	a0,4\(at\)
[ 0-9a-f]+:	fc60 8000 	lw	v1,-32768\(zero\)
[ 0-9a-f]+:	fc80 8004 	lw	a0,-32764\(zero\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	fc61 0001 	lw	v1,1\(at\)
[ 0-9a-f]+:	fc81 0005 	lw	a0,5\(at\)
[ 0-9a-f]+:	fc60 8001 	lw	v1,-32767\(zero\)
[ 0-9a-f]+:	fc80 8005 	lw	a0,-32763\(zero\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	fc61 0000 	lw	v1,0\(at\)
[ 0-9a-f]+:	fc81 0004 	lw	a0,4\(at\)
[ 0-9a-f]+:	fc60 ffff 	lw	v1,-1\(zero\)
[ 0-9a-f]+:	fc80 0003 	lw	a0,3\(zero\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	fc61 5678 	lw	v1,22136\(at\)
[ 0-9a-f]+:	fc81 567c 	lw	a0,22140\(at\)
[ 0-9a-f]+:	fc64 0000 	lw	v1,0\(a0\)
[ 0-9a-f]+:	fc84 0004 	lw	a0,4\(a0\)
[ 0-9a-f]+:	fc64 0000 	lw	v1,0\(a0\)
[ 0-9a-f]+:	fc84 0004 	lw	a0,4\(a0\)
[ 0-9a-f]+:	3024 7fff 	addiu	at,a0,32767
[ 0-9a-f]+:	fc61 0000 	lw	v1,0\(at\)
[ 0-9a-f]+:	fc81 0004 	lw	a0,4\(at\)
[ 0-9a-f]+:	fc64 8000 	lw	v1,-32768\(a0\)
[ 0-9a-f]+:	fc84 8004 	lw	a0,-32764\(a0\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0024 0950 	addu	at,a0,at
[ 0-9a-f]+:	fc61 ffff 	lw	v1,-1\(at\)
[ 0-9a-f]+:	fc81 0003 	lw	a0,3\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0024 0950 	addu	at,a0,at
[ 0-9a-f]+:	fc61 0000 	lw	v1,0\(at\)
[ 0-9a-f]+:	fc81 0004 	lw	a0,4\(at\)
[ 0-9a-f]+:	fc64 8000 	lw	v1,-32768\(a0\)
[ 0-9a-f]+:	fc84 8004 	lw	a0,-32764\(a0\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0024 0950 	addu	at,a0,at
[ 0-9a-f]+:	fc61 0001 	lw	v1,1\(at\)
[ 0-9a-f]+:	fc81 0005 	lw	a0,5\(at\)
[ 0-9a-f]+:	fc64 8001 	lw	v1,-32767\(a0\)
[ 0-9a-f]+:	fc84 8005 	lw	a0,-32763\(a0\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	0024 0950 	addu	at,a0,at
[ 0-9a-f]+:	fc61 0000 	lw	v1,0\(at\)
[ 0-9a-f]+:	fc81 0004 	lw	a0,4\(at\)
[ 0-9a-f]+:	fc64 ffff 	lw	v1,-1\(a0\)
[ 0-9a-f]+:	fc84 0003 	lw	a0,3\(a0\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	0024 0950 	addu	at,a0,at
[ 0-9a-f]+:	fc61 5678 	lw	v1,22136\(at\)
[ 0-9a-f]+:	fc81 567c 	lw	a0,22140\(at\)
[ 0-9a-f]+:	4413      	jrcaddiusp	0
[ 0-9a-f]+:	4433      	jrcaddiusp	4
[ 0-9a-f]+:	4453      	jrcaddiusp	8
[ 0-9a-f]+:	4473      	jrcaddiusp	12
[ 0-9a-f]+:	4493      	jrcaddiusp	16
[ 0-9a-f]+:	44b3      	jrcaddiusp	20
[ 0-9a-f]+:	44d3      	jrcaddiusp	24
[ 0-9a-f]+:	44f3      	jrcaddiusp	28
[ 0-9a-f]+:	4513      	jrcaddiusp	32
[ 0-9a-f]+:	4533      	jrcaddiusp	36
[ 0-9a-f]+:	4553      	jrcaddiusp	40
[ 0-9a-f]+:	47d3      	jrcaddiusp	120
[ 0-9a-f]+:	47f3      	jrcaddiusp	124
[ 0-9a-f]+:	2060 2000 	ldc2	\$3,0\(zero\)
[ 0-9a-f]+:	2060 2000 	ldc2	\$3,0\(zero\)
[ 0-9a-f]+:	2060 2004 	ldc2	\$3,4\(zero\)
[ 0-9a-f]+:	2060 2004 	ldc2	\$3,4\(zero\)
[ 0-9a-f]+:	2064 2000 	ldc2	\$3,0\(a0\)
[ 0-9a-f]+:	2064 2000 	ldc2	\$3,0\(a0\)
[ 0-9a-f]+:	3024 7fff 	addiu	at,a0,32767
[ 0-9a-f]+:	2061 2000 	ldc2	\$3,0\(at\)
[ 0-9a-f]+:	3024 8000 	addiu	at,a0,-32768
[ 0-9a-f]+:	2061 2000 	ldc2	\$3,0\(at\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	2061 27ff 	ldc2	\$3,-1\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	2061 2000 	ldc2	\$3,0\(at\)
[ 0-9a-f]+:	3024 8000 	addiu	at,a0,-32768
[ 0-9a-f]+:	2061 2000 	ldc2	\$3,0\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	2061 2001 	ldc2	\$3,1\(at\)
[ 0-9a-f]+:	3024 8001 	addiu	at,a0,-32767
[ 0-9a-f]+:	2061 2000 	ldc2	\$3,0\(at\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	2061 2000 	ldc2	\$3,0\(at\)
[ 0-9a-f]+:	2064 27ff 	ldc2	\$3,-1\(a0\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5800 	ori	at,at,0x5800
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	2061 2678 	ldc2	\$3,-392\(at\)
[ 0-9a-f]+:	2060 0000 	lwc2	\$3,0\(zero\)
[ 0-9a-f]+:	2060 0000 	lwc2	\$3,0\(zero\)
[ 0-9a-f]+:	2060 0004 	lwc2	\$3,4\(zero\)
[ 0-9a-f]+:	2060 0004 	lwc2	\$3,4\(zero\)
[ 0-9a-f]+:	2064 0000 	lwc2	\$3,0\(a0\)
[ 0-9a-f]+:	2064 0000 	lwc2	\$3,0\(a0\)
[ 0-9a-f]+:	3024 7fff 	addiu	at,a0,32767
[ 0-9a-f]+:	2061 0000 	lwc2	\$3,0\(at\)
[ 0-9a-f]+:	3024 8000 	addiu	at,a0,-32768
[ 0-9a-f]+:	2061 0000 	lwc2	\$3,0\(at\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	2061 07ff 	lwc2	\$3,-1\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	2061 0000 	lwc2	\$3,0\(at\)
[ 0-9a-f]+:	3024 8000 	addiu	at,a0,-32768
[ 0-9a-f]+:	2061 0000 	lwc2	\$3,0\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	2061 0001 	lwc2	\$3,1\(at\)
[ 0-9a-f]+:	3024 8001 	addiu	at,a0,-32767
[ 0-9a-f]+:	2061 0000 	lwc2	\$3,0\(at\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	2061 0000 	lwc2	\$3,0\(at\)
[ 0-9a-f]+:	2064 07ff 	lwc2	\$3,-1\(a0\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5800 	ori	at,at,0x5800
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	2061 0678 	lwc2	\$3,-392\(at\)
[ 0-9a-f]+:	00a0 4d3c 	mfc2	a1,\$0
[ 0-9a-f]+:	00a1 4d3c 	mfc2	a1,\$1
[ 0-9a-f]+:	00a2 4d3c 	mfc2	a1,\$2
[ 0-9a-f]+:	00a3 4d3c 	mfc2	a1,\$3
[ 0-9a-f]+:	00a4 4d3c 	mfc2	a1,\$4
[ 0-9a-f]+:	00a5 4d3c 	mfc2	a1,\$5
[ 0-9a-f]+:	00a6 4d3c 	mfc2	a1,\$6
[ 0-9a-f]+:	00a7 4d3c 	mfc2	a1,\$7
[ 0-9a-f]+:	00a8 4d3c 	mfc2	a1,\$8
[ 0-9a-f]+:	00a9 4d3c 	mfc2	a1,\$9
[ 0-9a-f]+:	00aa 4d3c 	mfc2	a1,\$10
[ 0-9a-f]+:	00ab 4d3c 	mfc2	a1,\$11
[ 0-9a-f]+:	00ac 4d3c 	mfc2	a1,\$12
[ 0-9a-f]+:	00ad 4d3c 	mfc2	a1,\$13
[ 0-9a-f]+:	00ae 4d3c 	mfc2	a1,\$14
[ 0-9a-f]+:	00af 4d3c 	mfc2	a1,\$15
[ 0-9a-f]+:	00b0 4d3c 	mfc2	a1,\$16
[ 0-9a-f]+:	00b1 4d3c 	mfc2	a1,\$17
[ 0-9a-f]+:	00b2 4d3c 	mfc2	a1,\$18
[ 0-9a-f]+:	00b3 4d3c 	mfc2	a1,\$19
[ 0-9a-f]+:	00b4 4d3c 	mfc2	a1,\$20
[ 0-9a-f]+:	00b5 4d3c 	mfc2	a1,\$21
[ 0-9a-f]+:	00b6 4d3c 	mfc2	a1,\$22
[ 0-9a-f]+:	00b7 4d3c 	mfc2	a1,\$23
[ 0-9a-f]+:	00b8 4d3c 	mfc2	a1,\$24
[ 0-9a-f]+:	00b9 4d3c 	mfc2	a1,\$25
[ 0-9a-f]+:	00ba 4d3c 	mfc2	a1,\$26
[ 0-9a-f]+:	00bb 4d3c 	mfc2	a1,\$27
[ 0-9a-f]+:	00bc 4d3c 	mfc2	a1,\$28
[ 0-9a-f]+:	00bd 4d3c 	mfc2	a1,\$29
[ 0-9a-f]+:	00be 4d3c 	mfc2	a1,\$30
[ 0-9a-f]+:	00bf 4d3c 	mfc2	a1,\$31
[ 0-9a-f]+:	00a0 8d3c 	mfhc2	a1,\$0
[ 0-9a-f]+:	00a1 8d3c 	mfhc2	a1,\$1
[ 0-9a-f]+:	00a2 8d3c 	mfhc2	a1,\$2
[ 0-9a-f]+:	00a3 8d3c 	mfhc2	a1,\$3
[ 0-9a-f]+:	00a4 8d3c 	mfhc2	a1,\$4
[ 0-9a-f]+:	00a5 8d3c 	mfhc2	a1,\$5
[ 0-9a-f]+:	00a6 8d3c 	mfhc2	a1,\$6
[ 0-9a-f]+:	00a7 8d3c 	mfhc2	a1,\$7
[ 0-9a-f]+:	00a8 8d3c 	mfhc2	a1,\$8
[ 0-9a-f]+:	00a9 8d3c 	mfhc2	a1,\$9
[ 0-9a-f]+:	00aa 8d3c 	mfhc2	a1,\$10
[ 0-9a-f]+:	00ab 8d3c 	mfhc2	a1,\$11
[ 0-9a-f]+:	00ac 8d3c 	mfhc2	a1,\$12
[ 0-9a-f]+:	00ad 8d3c 	mfhc2	a1,\$13
[ 0-9a-f]+:	00ae 8d3c 	mfhc2	a1,\$14
[ 0-9a-f]+:	00af 8d3c 	mfhc2	a1,\$15
[ 0-9a-f]+:	00b0 8d3c 	mfhc2	a1,\$16
[ 0-9a-f]+:	00b1 8d3c 	mfhc2	a1,\$17
[ 0-9a-f]+:	00b2 8d3c 	mfhc2	a1,\$18
[ 0-9a-f]+:	00b3 8d3c 	mfhc2	a1,\$19
[ 0-9a-f]+:	00b4 8d3c 	mfhc2	a1,\$20
[ 0-9a-f]+:	00b5 8d3c 	mfhc2	a1,\$21
[ 0-9a-f]+:	00b6 8d3c 	mfhc2	a1,\$22
[ 0-9a-f]+:	00b7 8d3c 	mfhc2	a1,\$23
[ 0-9a-f]+:	00b8 8d3c 	mfhc2	a1,\$24
[ 0-9a-f]+:	00b9 8d3c 	mfhc2	a1,\$25
[ 0-9a-f]+:	00ba 8d3c 	mfhc2	a1,\$26
[ 0-9a-f]+:	00bb 8d3c 	mfhc2	a1,\$27
[ 0-9a-f]+:	00bc 8d3c 	mfhc2	a1,\$28
[ 0-9a-f]+:	00bd 8d3c 	mfhc2	a1,\$29
[ 0-9a-f]+:	00be 8d3c 	mfhc2	a1,\$30
[ 0-9a-f]+:	00bf 8d3c 	mfhc2	a1,\$31
[ 0-9a-f]+:	00a0 5d3c 	mtc2	a1,\$0
[ 0-9a-f]+:	00a1 5d3c 	mtc2	a1,\$1
[ 0-9a-f]+:	00a2 5d3c 	mtc2	a1,\$2
[ 0-9a-f]+:	00a3 5d3c 	mtc2	a1,\$3
[ 0-9a-f]+:	00a4 5d3c 	mtc2	a1,\$4
[ 0-9a-f]+:	00a5 5d3c 	mtc2	a1,\$5
[ 0-9a-f]+:	00a6 5d3c 	mtc2	a1,\$6
[ 0-9a-f]+:	00a7 5d3c 	mtc2	a1,\$7
[ 0-9a-f]+:	00a8 5d3c 	mtc2	a1,\$8
[ 0-9a-f]+:	00a9 5d3c 	mtc2	a1,\$9
[ 0-9a-f]+:	00aa 5d3c 	mtc2	a1,\$10
[ 0-9a-f]+:	00ab 5d3c 	mtc2	a1,\$11
[ 0-9a-f]+:	00ac 5d3c 	mtc2	a1,\$12
[ 0-9a-f]+:	00ad 5d3c 	mtc2	a1,\$13
[ 0-9a-f]+:	00ae 5d3c 	mtc2	a1,\$14
[ 0-9a-f]+:	00af 5d3c 	mtc2	a1,\$15
[ 0-9a-f]+:	00b0 5d3c 	mtc2	a1,\$16
[ 0-9a-f]+:	00b1 5d3c 	mtc2	a1,\$17
[ 0-9a-f]+:	00b2 5d3c 	mtc2	a1,\$18
[ 0-9a-f]+:	00b3 5d3c 	mtc2	a1,\$19
[ 0-9a-f]+:	00b4 5d3c 	mtc2	a1,\$20
[ 0-9a-f]+:	00b5 5d3c 	mtc2	a1,\$21
[ 0-9a-f]+:	00b6 5d3c 	mtc2	a1,\$22
[ 0-9a-f]+:	00b7 5d3c 	mtc2	a1,\$23
[ 0-9a-f]+:	00b8 5d3c 	mtc2	a1,\$24
[ 0-9a-f]+:	00b9 5d3c 	mtc2	a1,\$25
[ 0-9a-f]+:	00ba 5d3c 	mtc2	a1,\$26
[ 0-9a-f]+:	00bb 5d3c 	mtc2	a1,\$27
[ 0-9a-f]+:	00bc 5d3c 	mtc2	a1,\$28
[ 0-9a-f]+:	00bd 5d3c 	mtc2	a1,\$29
[ 0-9a-f]+:	00be 5d3c 	mtc2	a1,\$30
[ 0-9a-f]+:	00bf 5d3c 	mtc2	a1,\$31
[ 0-9a-f]+:	00a0 9d3c 	mthc2	a1,\$0
[ 0-9a-f]+:	00a1 9d3c 	mthc2	a1,\$1
[ 0-9a-f]+:	00a2 9d3c 	mthc2	a1,\$2
[ 0-9a-f]+:	00a3 9d3c 	mthc2	a1,\$3
[ 0-9a-f]+:	00a4 9d3c 	mthc2	a1,\$4
[ 0-9a-f]+:	00a5 9d3c 	mthc2	a1,\$5
[ 0-9a-f]+:	00a6 9d3c 	mthc2	a1,\$6
[ 0-9a-f]+:	00a7 9d3c 	mthc2	a1,\$7
[ 0-9a-f]+:	00a8 9d3c 	mthc2	a1,\$8
[ 0-9a-f]+:	00a9 9d3c 	mthc2	a1,\$9
[ 0-9a-f]+:	00aa 9d3c 	mthc2	a1,\$10
[ 0-9a-f]+:	00ab 9d3c 	mthc2	a1,\$11
[ 0-9a-f]+:	00ac 9d3c 	mthc2	a1,\$12
[ 0-9a-f]+:	00ad 9d3c 	mthc2	a1,\$13
[ 0-9a-f]+:	00ae 9d3c 	mthc2	a1,\$14
[ 0-9a-f]+:	00af 9d3c 	mthc2	a1,\$15
[ 0-9a-f]+:	00b0 9d3c 	mthc2	a1,\$16
[ 0-9a-f]+:	00b1 9d3c 	mthc2	a1,\$17
[ 0-9a-f]+:	00b2 9d3c 	mthc2	a1,\$18
[ 0-9a-f]+:	00b3 9d3c 	mthc2	a1,\$19
[ 0-9a-f]+:	00b4 9d3c 	mthc2	a1,\$20
[ 0-9a-f]+:	00b5 9d3c 	mthc2	a1,\$21
[ 0-9a-f]+:	00b6 9d3c 	mthc2	a1,\$22
[ 0-9a-f]+:	00b7 9d3c 	mthc2	a1,\$23
[ 0-9a-f]+:	00b8 9d3c 	mthc2	a1,\$24
[ 0-9a-f]+:	00b9 9d3c 	mthc2	a1,\$25
[ 0-9a-f]+:	00ba 9d3c 	mthc2	a1,\$26
[ 0-9a-f]+:	00bb 9d3c 	mthc2	a1,\$27
[ 0-9a-f]+:	00bc 9d3c 	mthc2	a1,\$28
[ 0-9a-f]+:	00bd 9d3c 	mthc2	a1,\$29
[ 0-9a-f]+:	00be 9d3c 	mthc2	a1,\$30
[ 0-9a-f]+:	00bf 9d3c 	mthc2	a1,\$31
[ 0-9a-f]+:	2060 a000 	sdc2	\$3,0\(zero\)
[ 0-9a-f]+:	2060 a000 	sdc2	\$3,0\(zero\)
[ 0-9a-f]+:	2060 a004 	sdc2	\$3,4\(zero\)
[ 0-9a-f]+:	2060 a004 	sdc2	\$3,4\(zero\)
[ 0-9a-f]+:	2064 a000 	sdc2	\$3,0\(a0\)
[ 0-9a-f]+:	2064 a000 	sdc2	\$3,0\(a0\)
[ 0-9a-f]+:	3024 7fff 	addiu	at,a0,32767
[ 0-9a-f]+:	2061 a000 	sdc2	\$3,0\(at\)
[ 0-9a-f]+:	3024 8000 	addiu	at,a0,-32768
[ 0-9a-f]+:	2061 a000 	sdc2	\$3,0\(at\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	2061 a7ff 	sdc2	\$3,-1\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	2061 a000 	sdc2	\$3,0\(at\)
[ 0-9a-f]+:	3024 8000 	addiu	at,a0,-32768
[ 0-9a-f]+:	2061 a000 	sdc2	\$3,0\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	2061 a001 	sdc2	\$3,1\(at\)
[ 0-9a-f]+:	3024 8001 	addiu	at,a0,-32767
[ 0-9a-f]+:	2061 a000 	sdc2	\$3,0\(at\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	2061 a000 	sdc2	\$3,0\(at\)
[ 0-9a-f]+:	2064 a7ff 	sdc2	\$3,-1\(a0\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5800 	ori	at,at,0x5800
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	2061 a678 	sdc2	\$3,-392\(at\)
[ 0-9a-f]+:	2060 8000 	swc2	\$3,0\(zero\)
[ 0-9a-f]+:	2060 8000 	swc2	\$3,0\(zero\)
[ 0-9a-f]+:	2060 8004 	swc2	\$3,4\(zero\)
[ 0-9a-f]+:	2060 8004 	swc2	\$3,4\(zero\)
[ 0-9a-f]+:	2064 8000 	swc2	\$3,0\(a0\)
[ 0-9a-f]+:	2064 8000 	swc2	\$3,0\(a0\)
[ 0-9a-f]+:	3024 7fff 	addiu	at,a0,32767
[ 0-9a-f]+:	2061 8000 	swc2	\$3,0\(at\)
[ 0-9a-f]+:	3024 8000 	addiu	at,a0,-32768
[ 0-9a-f]+:	2061 8000 	swc2	\$3,0\(at\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	2061 87ff 	swc2	\$3,-1\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	2061 8000 	swc2	\$3,0\(at\)
[ 0-9a-f]+:	3024 8000 	addiu	at,a0,-32768
[ 0-9a-f]+:	2061 8000 	swc2	\$3,0\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	2061 8001 	swc2	\$3,1\(at\)
[ 0-9a-f]+:	3024 8001 	addiu	at,a0,-32767
[ 0-9a-f]+:	2061 8000 	swc2	\$3,0\(at\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	2061 8000 	swc2	\$3,0\(at\)
[ 0-9a-f]+:	2064 87ff 	swc2	\$3,-1\(a0\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5800 	ori	at,at,0x5800
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	2061 8678 	swc2	\$3,-392\(at\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	2001 6000 	cache	0x0,0\(at\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	2041 1000 	lwp	v0,0\(at\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	2041 9000 	swp	v0,0\(at\)
[ 0-9a-f]+:	3043 0000 	addiu	v0,v1,0
[	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	6042 3000 	ll	v0,0\(v0\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	6041 b000 	sc	v0,0\(at\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	2021 5000 	lwm	s0,0\(at\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	2021 d000 	swm	s0,0\(at\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	2201 0000 	lwc2	\$16,0\(at\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	2201 8000 	swc2	\$16,0\(at\)
[ 0-9a-f]+:	03ff db7c 	sdbbp	0x3ff
[ 0-9a-f]+:	03ff 937c 	wait	0x3ff
[ 0-9a-f]+:	03ff 8b7c 	syscall	0x3ff
[ 0-9a-f]+:	03ff fffa 	cop2	0x7fffff

[ 0-9a-f]+ <fp_test>:
[ 0-9a-f]+:	5401 037b 	abs.s	\$f0,\$f1
[ 0-9a-f]+:	57df 037b 	abs.s	\$f30,\$f31
[ 0-9a-f]+:	5442 037b 	abs.s	\$f2,\$f2
[ 0-9a-f]+:	5442 037b 	abs.s	\$f2,\$f2
[ 0-9a-f]+:	5401 237b 	abs.d	\$f0,\$f1
[ 0-9a-f]+:	57df 237b 	abs.d	\$f30,\$f31
[ 0-9a-f]+:	5442 237b 	abs.d	\$f2,\$f2
[ 0-9a-f]+:	5442 237b 	abs.d	\$f2,\$f2
[ 0-9a-f]+:	5441 0030 	add.s	\$f0,\$f1,\$f2
[ 0-9a-f]+:	57fe e830 	add.s	\$f29,\$f30,\$f31
[ 0-9a-f]+:	57dd e830 	add.s	\$f29,\$f29,\$f30
[ 0-9a-f]+:	57dd e830 	add.s	\$f29,\$f29,\$f30
[ 0-9a-f]+:	5441 0130 	add.d	\$f0,\$f1,\$f2
[ 0-9a-f]+:	57fe e930 	add.d	\$f29,\$f30,\$f31
[ 0-9a-f]+:	57dd e930 	add.d	\$f29,\$f29,\$f30
[ 0-9a-f]+:	57dd e930 	add.d	\$f29,\$f29,\$f30
[ 0-9a-f]+:	5401 533b 	ceil.l.d	\$f0,\$f1
[ 0-9a-f]+:	57df 533b 	ceil.l.d	\$f30,\$f31
[ 0-9a-f]+:	5442 533b 	ceil.l.d	\$f2,\$f2
[ 0-9a-f]+:	5401 133b 	ceil.l.s	\$f0,\$f1
[ 0-9a-f]+:	57df 133b 	ceil.l.s	\$f30,\$f31
[ 0-9a-f]+:	5442 133b 	ceil.l.s	\$f2,\$f2
[ 0-9a-f]+:	5401 5b3b 	ceil.w.d	\$f0,\$f1
[ 0-9a-f]+:	57df 5b3b 	ceil.w.d	\$f30,\$f31
[ 0-9a-f]+:	5442 5b3b 	ceil.w.d	\$f2,\$f2
[ 0-9a-f]+:	5401 1b3b 	ceil.w.s	\$f0,\$f1
[ 0-9a-f]+:	57df 1b3b 	ceil.w.s	\$f30,\$f31
[ 0-9a-f]+:	5442 1b3b 	ceil.w.s	\$f2,\$f2
[ 0-9a-f]+:	54a0 103b 	cfc1	a1,c1_fir
[ 0-9a-f]+:	54a1 103b 	cfc1	a1,c1_ufr
[ 0-9a-f]+:	54a2 103b 	cfc1	a1,\$2
[ 0-9a-f]+:	54a3 103b 	cfc1	a1,\$3
[ 0-9a-f]+:	54a4 103b 	cfc1	a1,c1_unfr
[ 0-9a-f]+:	54a5 103b 	cfc1	a1,\$5
[ 0-9a-f]+:	54a6 103b 	cfc1	a1,\$6
[ 0-9a-f]+:	54a7 103b 	cfc1	a1,\$7
[ 0-9a-f]+:	54a8 103b 	cfc1	a1,\$8
[ 0-9a-f]+:	54a9 103b 	cfc1	a1,\$9
[ 0-9a-f]+:	54aa 103b 	cfc1	a1,\$10
[ 0-9a-f]+:	54ab 103b 	cfc1	a1,\$11
[ 0-9a-f]+:	54ac 103b 	cfc1	a1,\$12
[ 0-9a-f]+:	54ad 103b 	cfc1	a1,\$13
[ 0-9a-f]+:	54ae 103b 	cfc1	a1,\$14
[ 0-9a-f]+:	54af 103b 	cfc1	a1,\$15
[ 0-9a-f]+:	54b0 103b 	cfc1	a1,\$16
[ 0-9a-f]+:	54b1 103b 	cfc1	a1,\$17
[ 0-9a-f]+:	54b2 103b 	cfc1	a1,\$18
[ 0-9a-f]+:	54b3 103b 	cfc1	a1,\$19
[ 0-9a-f]+:	54b4 103b 	cfc1	a1,\$20
[ 0-9a-f]+:	54b5 103b 	cfc1	a1,\$21
[ 0-9a-f]+:	54b6 103b 	cfc1	a1,\$22
[ 0-9a-f]+:	54b7 103b 	cfc1	a1,\$23
[ 0-9a-f]+:	54b8 103b 	cfc1	a1,\$24
[ 0-9a-f]+:	54b9 103b 	cfc1	a1,c1_fccr
[ 0-9a-f]+:	54ba 103b 	cfc1	a1,c1_fexr
[ 0-9a-f]+:	54bb 103b 	cfc1	a1,\$27
[ 0-9a-f]+:	54bc 103b 	cfc1	a1,c1_fenr
[ 0-9a-f]+:	54bd 103b 	cfc1	a1,\$29
[ 0-9a-f]+:	54be 103b 	cfc1	a1,\$30
[ 0-9a-f]+:	54bf 103b 	cfc1	a1,c1_fcsr
[ 0-9a-f]+:	54a0 103b 	cfc1	a1,c1_fir
[ 0-9a-f]+:	54a1 103b 	cfc1	a1,c1_ufr
[ 0-9a-f]+:	54a2 103b 	cfc1	a1,\$2
[ 0-9a-f]+:	54a3 103b 	cfc1	a1,\$3
[ 0-9a-f]+:	54a4 103b 	cfc1	a1,c1_unfr
[ 0-9a-f]+:	54a5 103b 	cfc1	a1,\$5
[ 0-9a-f]+:	54a6 103b 	cfc1	a1,\$6
[ 0-9a-f]+:	54a7 103b 	cfc1	a1,\$7
[ 0-9a-f]+:	54a8 103b 	cfc1	a1,\$8
[ 0-9a-f]+:	54a9 103b 	cfc1	a1,\$9
[ 0-9a-f]+:	54aa 103b 	cfc1	a1,\$10
[ 0-9a-f]+:	54ab 103b 	cfc1	a1,\$11
[ 0-9a-f]+:	54ac 103b 	cfc1	a1,\$12
[ 0-9a-f]+:	54ad 103b 	cfc1	a1,\$13
[ 0-9a-f]+:	54ae 103b 	cfc1	a1,\$14
[ 0-9a-f]+:	54af 103b 	cfc1	a1,\$15
[ 0-9a-f]+:	54b0 103b 	cfc1	a1,\$16
[ 0-9a-f]+:	54b1 103b 	cfc1	a1,\$17
[ 0-9a-f]+:	54b2 103b 	cfc1	a1,\$18
[ 0-9a-f]+:	54b3 103b 	cfc1	a1,\$19
[ 0-9a-f]+:	54b4 103b 	cfc1	a1,\$20
[ 0-9a-f]+:	54b5 103b 	cfc1	a1,\$21
[ 0-9a-f]+:	54b6 103b 	cfc1	a1,\$22
[ 0-9a-f]+:	54b7 103b 	cfc1	a1,\$23
[ 0-9a-f]+:	54b8 103b 	cfc1	a1,\$24
[ 0-9a-f]+:	54b9 103b 	cfc1	a1,c1_fccr
[ 0-9a-f]+:	54ba 103b 	cfc1	a1,c1_fexr
[ 0-9a-f]+:	54bb 103b 	cfc1	a1,\$27
[ 0-9a-f]+:	54bc 103b 	cfc1	a1,c1_fenr
[ 0-9a-f]+:	54bd 103b 	cfc1	a1,\$29
[ 0-9a-f]+:	54be 103b 	cfc1	a1,\$30
[ 0-9a-f]+:	54bf 103b 	cfc1	a1,c1_fcsr
[ 0-9a-f]+:	00a0 cd3c 	cfc2	a1,\$0
[ 0-9a-f]+:	00a1 cd3c 	cfc2	a1,\$1
[ 0-9a-f]+:	00a2 cd3c 	cfc2	a1,\$2
[ 0-9a-f]+:	00a3 cd3c 	cfc2	a1,\$3
[ 0-9a-f]+:	00a4 cd3c 	cfc2	a1,\$4
[ 0-9a-f]+:	00a5 cd3c 	cfc2	a1,\$5
[ 0-9a-f]+:	00a6 cd3c 	cfc2	a1,\$6
[ 0-9a-f]+:	00a7 cd3c 	cfc2	a1,\$7
[ 0-9a-f]+:	00a8 cd3c 	cfc2	a1,\$8
[ 0-9a-f]+:	00a9 cd3c 	cfc2	a1,\$9
[ 0-9a-f]+:	00aa cd3c 	cfc2	a1,\$10
[ 0-9a-f]+:	00ab cd3c 	cfc2	a1,\$11
[ 0-9a-f]+:	00ac cd3c 	cfc2	a1,\$12
[ 0-9a-f]+:	00ad cd3c 	cfc2	a1,\$13
[ 0-9a-f]+:	00ae cd3c 	cfc2	a1,\$14
[ 0-9a-f]+:	00af cd3c 	cfc2	a1,\$15
[ 0-9a-f]+:	00b0 cd3c 	cfc2	a1,\$16
[ 0-9a-f]+:	00b1 cd3c 	cfc2	a1,\$17
[ 0-9a-f]+:	00b2 cd3c 	cfc2	a1,\$18
[ 0-9a-f]+:	00b3 cd3c 	cfc2	a1,\$19
[ 0-9a-f]+:	00b4 cd3c 	cfc2	a1,\$20
[ 0-9a-f]+:	00b5 cd3c 	cfc2	a1,\$21
[ 0-9a-f]+:	00b6 cd3c 	cfc2	a1,\$22
[ 0-9a-f]+:	00b7 cd3c 	cfc2	a1,\$23
[ 0-9a-f]+:	00b8 cd3c 	cfc2	a1,\$24
[ 0-9a-f]+:	00b9 cd3c 	cfc2	a1,\$25
[ 0-9a-f]+:	00ba cd3c 	cfc2	a1,\$26
[ 0-9a-f]+:	00bb cd3c 	cfc2	a1,\$27
[ 0-9a-f]+:	00bc cd3c 	cfc2	a1,\$28
[ 0-9a-f]+:	00bd cd3c 	cfc2	a1,\$29
[ 0-9a-f]+:	00be cd3c 	cfc2	a1,\$30
[ 0-9a-f]+:	00bf cd3c 	cfc2	a1,\$31
[ 0-9a-f]+:	54a0 183b 	ctc1	a1,c1_fir
[ 0-9a-f]+:	54a1 183b 	ctc1	a1,c1_ufr
[ 0-9a-f]+:	54a2 183b 	ctc1	a1,\$2
[ 0-9a-f]+:	54a3 183b 	ctc1	a1,\$3
[ 0-9a-f]+:	54a4 183b 	ctc1	a1,c1_unfr
[ 0-9a-f]+:	54a5 183b 	ctc1	a1,\$5
[ 0-9a-f]+:	54a6 183b 	ctc1	a1,\$6
[ 0-9a-f]+:	54a7 183b 	ctc1	a1,\$7
[ 0-9a-f]+:	54a8 183b 	ctc1	a1,\$8
[ 0-9a-f]+:	54a9 183b 	ctc1	a1,\$9
[ 0-9a-f]+:	54aa 183b 	ctc1	a1,\$10
[ 0-9a-f]+:	54ab 183b 	ctc1	a1,\$11
[ 0-9a-f]+:	54ac 183b 	ctc1	a1,\$12
[ 0-9a-f]+:	54ad 183b 	ctc1	a1,\$13
[ 0-9a-f]+:	54ae 183b 	ctc1	a1,\$14
[ 0-9a-f]+:	54af 183b 	ctc1	a1,\$15
[ 0-9a-f]+:	54b0 183b 	ctc1	a1,\$16
[ 0-9a-f]+:	54b1 183b 	ctc1	a1,\$17
[ 0-9a-f]+:	54b2 183b 	ctc1	a1,\$18
[ 0-9a-f]+:	54b3 183b 	ctc1	a1,\$19
[ 0-9a-f]+:	54b4 183b 	ctc1	a1,\$20
[ 0-9a-f]+:	54b5 183b 	ctc1	a1,\$21
[ 0-9a-f]+:	54b6 183b 	ctc1	a1,\$22
[ 0-9a-f]+:	54b7 183b 	ctc1	a1,\$23
[ 0-9a-f]+:	54b8 183b 	ctc1	a1,\$24
[ 0-9a-f]+:	54b9 183b 	ctc1	a1,c1_fccr
[ 0-9a-f]+:	54ba 183b 	ctc1	a1,c1_fexr
[ 0-9a-f]+:	54bb 183b 	ctc1	a1,\$27
[ 0-9a-f]+:	54bc 183b 	ctc1	a1,c1_fenr
[ 0-9a-f]+:	54bd 183b 	ctc1	a1,\$29
[ 0-9a-f]+:	54be 183b 	ctc1	a1,\$30
[ 0-9a-f]+:	54bf 183b 	ctc1	a1,c1_fcsr
[ 0-9a-f]+:	54a0 183b 	ctc1	a1,c1_fir
[ 0-9a-f]+:	54a1 183b 	ctc1	a1,c1_ufr
[ 0-9a-f]+:	54a2 183b 	ctc1	a1,\$2
[ 0-9a-f]+:	54a3 183b 	ctc1	a1,\$3
[ 0-9a-f]+:	54a4 183b 	ctc1	a1,c1_unfr
[ 0-9a-f]+:	54a5 183b 	ctc1	a1,\$5
[ 0-9a-f]+:	54a6 183b 	ctc1	a1,\$6
[ 0-9a-f]+:	54a7 183b 	ctc1	a1,\$7
[ 0-9a-f]+:	54a8 183b 	ctc1	a1,\$8
[ 0-9a-f]+:	54a9 183b 	ctc1	a1,\$9
[ 0-9a-f]+:	54aa 183b 	ctc1	a1,\$10
[ 0-9a-f]+:	54ab 183b 	ctc1	a1,\$11
[ 0-9a-f]+:	54ac 183b 	ctc1	a1,\$12
[ 0-9a-f]+:	54ad 183b 	ctc1	a1,\$13
[ 0-9a-f]+:	54ae 183b 	ctc1	a1,\$14
[ 0-9a-f]+:	54af 183b 	ctc1	a1,\$15
[ 0-9a-f]+:	54b0 183b 	ctc1	a1,\$16
[ 0-9a-f]+:	54b1 183b 	ctc1	a1,\$17
[ 0-9a-f]+:	54b2 183b 	ctc1	a1,\$18
[ 0-9a-f]+:	54b3 183b 	ctc1	a1,\$19
[ 0-9a-f]+:	54b4 183b 	ctc1	a1,\$20
[ 0-9a-f]+:	54b5 183b 	ctc1	a1,\$21
[ 0-9a-f]+:	54b6 183b 	ctc1	a1,\$22
[ 0-9a-f]+:	54b7 183b 	ctc1	a1,\$23
[ 0-9a-f]+:	54b8 183b 	ctc1	a1,\$24
[ 0-9a-f]+:	54b9 183b 	ctc1	a1,c1_fccr
[ 0-9a-f]+:	54ba 183b 	ctc1	a1,c1_fexr
[ 0-9a-f]+:	54bb 183b 	ctc1	a1,\$27
[ 0-9a-f]+:	54bc 183b 	ctc1	a1,c1_fenr
[ 0-9a-f]+:	54bd 183b 	ctc1	a1,\$29
[ 0-9a-f]+:	54be 183b 	ctc1	a1,\$30
[ 0-9a-f]+:	54bf 183b 	ctc1	a1,c1_fcsr
[ 0-9a-f]+:	00a0 dd3c 	ctc2	a1,\$0
[ 0-9a-f]+:	00a1 dd3c 	ctc2	a1,\$1
[ 0-9a-f]+:	00a2 dd3c 	ctc2	a1,\$2
[ 0-9a-f]+:	00a3 dd3c 	ctc2	a1,\$3
[ 0-9a-f]+:	00a4 dd3c 	ctc2	a1,\$4
[ 0-9a-f]+:	00a5 dd3c 	ctc2	a1,\$5
[ 0-9a-f]+:	00a6 dd3c 	ctc2	a1,\$6
[ 0-9a-f]+:	00a7 dd3c 	ctc2	a1,\$7
[ 0-9a-f]+:	00a8 dd3c 	ctc2	a1,\$8
[ 0-9a-f]+:	00a9 dd3c 	ctc2	a1,\$9
[ 0-9a-f]+:	00aa dd3c 	ctc2	a1,\$10
[ 0-9a-f]+:	00ab dd3c 	ctc2	a1,\$11
[ 0-9a-f]+:	00ac dd3c 	ctc2	a1,\$12
[ 0-9a-f]+:	00ad dd3c 	ctc2	a1,\$13
[ 0-9a-f]+:	00ae dd3c 	ctc2	a1,\$14
[ 0-9a-f]+:	00af dd3c 	ctc2	a1,\$15
[ 0-9a-f]+:	00b0 dd3c 	ctc2	a1,\$16
[ 0-9a-f]+:	00b1 dd3c 	ctc2	a1,\$17
[ 0-9a-f]+:	00b2 dd3c 	ctc2	a1,\$18
[ 0-9a-f]+:	00b3 dd3c 	ctc2	a1,\$19
[ 0-9a-f]+:	00b4 dd3c 	ctc2	a1,\$20
[ 0-9a-f]+:	00b5 dd3c 	ctc2	a1,\$21
[ 0-9a-f]+:	00b6 dd3c 	ctc2	a1,\$22
[ 0-9a-f]+:	00b7 dd3c 	ctc2	a1,\$23
[ 0-9a-f]+:	00b8 dd3c 	ctc2	a1,\$24
[ 0-9a-f]+:	00b9 dd3c 	ctc2	a1,\$25
[ 0-9a-f]+:	00ba dd3c 	ctc2	a1,\$26
[ 0-9a-f]+:	00bb dd3c 	ctc2	a1,\$27
[ 0-9a-f]+:	00bc dd3c 	ctc2	a1,\$28
[ 0-9a-f]+:	00bd dd3c 	ctc2	a1,\$29
[ 0-9a-f]+:	00be dd3c 	ctc2	a1,\$30
[ 0-9a-f]+:	00bf dd3c 	ctc2	a1,\$31
[ 0-9a-f]+:	5401 537b 	cvt.d.l	\$f0,\$f1
[ 0-9a-f]+:	57df 537b 	cvt.d.l	\$f30,\$f31
[ 0-9a-f]+:	5442 537b 	cvt.d.l	\$f2,\$f2
[ 0-9a-f]+:	5401 137b 	cvt.d.s	\$f0,\$f1
[ 0-9a-f]+:	57df 137b 	cvt.d.s	\$f30,\$f31
[ 0-9a-f]+:	5442 137b 	cvt.d.s	\$f2,\$f2
[ 0-9a-f]+:	5401 337b 	cvt.d.w	\$f0,\$f1
[ 0-9a-f]+:	57df 337b 	cvt.d.w	\$f30,\$f31
[ 0-9a-f]+:	5442 337b 	cvt.d.w	\$f2,\$f2
[ 0-9a-f]+:	5401 013b 	cvt.l.s	\$f0,\$f1
[ 0-9a-f]+:	57df 013b 	cvt.l.s	\$f30,\$f31
[ 0-9a-f]+:	5442 013b 	cvt.l.s	\$f2,\$f2
[ 0-9a-f]+:	5401 413b 	cvt.l.d	\$f0,\$f1
[ 0-9a-f]+:	57df 413b 	cvt.l.d	\$f30,\$f31
[ 0-9a-f]+:	5442 413b 	cvt.l.d	\$f2,\$f2
[ 0-9a-f]+:	5401 5b7b 	cvt.s.l	\$f0,\$f1
[ 0-9a-f]+:	57df 5b7b 	cvt.s.l	\$f30,\$f31
[ 0-9a-f]+:	5442 5b7b 	cvt.s.l	\$f2,\$f2
[ 0-9a-f]+:	5401 1b7b 	cvt.s.d	\$f0,\$f1
[ 0-9a-f]+:	57df 1b7b 	cvt.s.d	\$f30,\$f31
[ 0-9a-f]+:	5442 1b7b 	cvt.s.d	\$f2,\$f2
[ 0-9a-f]+:	5401 3b7b 	cvt.s.w	\$f0,\$f1
[ 0-9a-f]+:	57df 3b7b 	cvt.s.w	\$f30,\$f31
[ 0-9a-f]+:	5442 3b7b 	cvt.s.w	\$f2,\$f2
[ 0-9a-f]+:	5401 213b 	cvt.s.pl	\$f0,\$f1
[ 0-9a-f]+:	57df 213b 	cvt.s.pl	\$f30,\$f31
[ 0-9a-f]+:	5442 213b 	cvt.s.pl	\$f2,\$f2
[ 0-9a-f]+:	5401 293b 	cvt.s.pu	\$f0,\$f1
[ 0-9a-f]+:	57df 293b 	cvt.s.pu	\$f30,\$f31
[ 0-9a-f]+:	5442 293b 	cvt.s.pu	\$f2,\$f2
[ 0-9a-f]+:	5401 093b 	cvt.w.s	\$f0,\$f1
[ 0-9a-f]+:	57df 093b 	cvt.w.s	\$f30,\$f31
[ 0-9a-f]+:	5442 093b 	cvt.w.s	\$f2,\$f2
[ 0-9a-f]+:	5401 493b 	cvt.w.d	\$f0,\$f1
[ 0-9a-f]+:	57df 493b 	cvt.w.d	\$f30,\$f31
[ 0-9a-f]+:	5442 493b 	cvt.w.d	\$f2,\$f2
[ 0-9a-f]+:	5441 01f0 	div.d	\$f0,\$f1,\$f2
[ 0-9a-f]+:	57fe e9f0 	div.d	\$f29,\$f30,\$f31
[ 0-9a-f]+:	57dd e9f0 	div.d	\$f29,\$f29,\$f30
[ 0-9a-f]+:	57dd e9f0 	div.d	\$f29,\$f29,\$f30
[ 0-9a-f]+:	5441 00f0 	div.s	\$f0,\$f1,\$f2
[ 0-9a-f]+:	57fe e8f0 	div.s	\$f29,\$f30,\$f31
[ 0-9a-f]+:	57dd e8f0 	div.s	\$f29,\$f29,\$f30
[ 0-9a-f]+:	57dd e8f0 	div.s	\$f29,\$f29,\$f30
[ 0-9a-f]+:	5401 433b 	floor.l.d	\$f0,\$f1
[ 0-9a-f]+:	57df 433b 	floor.l.d	\$f30,\$f31
[ 0-9a-f]+:	5442 433b 	floor.l.d	\$f2,\$f2
[ 0-9a-f]+:	5401 033b 	floor.l.s	\$f0,\$f1
[ 0-9a-f]+:	57df 033b 	floor.l.s	\$f30,\$f31
[ 0-9a-f]+:	5442 033b 	floor.l.s	\$f2,\$f2
[ 0-9a-f]+:	5401 4b3b 	floor.w.d	\$f0,\$f1
[ 0-9a-f]+:	57df 4b3b 	floor.w.d	\$f30,\$f31
[ 0-9a-f]+:	5442 4b3b 	floor.w.d	\$f2,\$f2
[ 0-9a-f]+:	5401 0b3b 	floor.w.s	\$f0,\$f1
[ 0-9a-f]+:	57df 0b3b 	floor.w.s	\$f30,\$f31
[ 0-9a-f]+:	5442 0b3b 	floor.w.s	\$f2,\$f2
[ 0-9a-f]+:	bc60 0000 	ldc1	\$f3,0\(zero\)
[ 0-9a-f]+:	bc60 0000 	ldc1	\$f3,0\(zero\)
[ 0-9a-f]+:	bc60 0004 	ldc1	\$f3,4\(zero\)
[ 0-9a-f]+:	bc60 0004 	ldc1	\$f3,4\(zero\)
[ 0-9a-f]+:	bc64 0000 	ldc1	\$f3,0\(a0\)
[ 0-9a-f]+:	bc64 0000 	ldc1	\$f3,0\(a0\)
[ 0-9a-f]+:	bc64 7fff 	ldc1	\$f3,32767\(a0\)
[ 0-9a-f]+:	bc64 8000 	ldc1	\$f3,-32768\(a0\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	bc61 ffff 	ldc1	\$f3,-1\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	bc61 0000 	ldc1	\$f3,0\(at\)
[ 0-9a-f]+:	bc64 8000 	ldc1	\$f3,-32768\(a0\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	bc61 0001 	ldc1	\$f3,1\(at\)
[ 0-9a-f]+:	bc64 8001 	ldc1	\$f3,-32767\(a0\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	bc61 0000 	ldc1	\$f3,0\(at\)
[ 0-9a-f]+:	bc64 ffff 	ldc1	\$f3,-1\(a0\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	bc61 5678 	ldc1	\$f3,22136\(at\)
[ 0-9a-f]+:	bc60 0000 	ldc1	\$f3,0\(zero\)
[ 0-9a-f]+:	bc60 0000 	ldc1	\$f3,0\(zero\)
[ 0-9a-f]+:	bc60 0004 	ldc1	\$f3,4\(zero\)
[ 0-9a-f]+:	bc60 0004 	ldc1	\$f3,4\(zero\)
[ 0-9a-f]+:	bc64 0000 	ldc1	\$f3,0\(a0\)
[ 0-9a-f]+:	bc64 0000 	ldc1	\$f3,0\(a0\)
[ 0-9a-f]+:	bc64 7fff 	ldc1	\$f3,32767\(a0\)
[ 0-9a-f]+:	bc64 8000 	ldc1	\$f3,-32768\(a0\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	bc61 ffff 	ldc1	\$f3,-1\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	bc61 0000 	ldc1	\$f3,0\(at\)
[ 0-9a-f]+:	bc64 8000 	ldc1	\$f3,-32768\(a0\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	bc61 0001 	ldc1	\$f3,1\(at\)
[ 0-9a-f]+:	bc64 8001 	ldc1	\$f3,-32767\(a0\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	bc61 0000 	ldc1	\$f3,0\(at\)
[ 0-9a-f]+:	bc64 ffff 	ldc1	\$f3,-1\(a0\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	bc61 5678 	ldc1	\$f3,22136\(at\)
[ 0-9a-f]+:	bc60 0000 	ldc1	\$f3,0\(zero\)
[ 0-9a-f]+:	bc60 0000 	ldc1	\$f3,0\(zero\)
[ 0-9a-f]+:	bc60 0004 	ldc1	\$f3,4\(zero\)
[ 0-9a-f]+:	bc60 0004 	ldc1	\$f3,4\(zero\)
[ 0-9a-f]+:	bc64 0000 	ldc1	\$f3,0\(a0\)
[ 0-9a-f]+:	bc64 0000 	ldc1	\$f3,0\(a0\)
[ 0-9a-f]+:	bc64 7fff 	ldc1	\$f3,32767\(a0\)
[ 0-9a-f]+:	bc64 8000 	ldc1	\$f3,-32768\(a0\)
[ 0-9a-f]+:	9c60 0000 	lwc1	\$f3,0\(zero\)
[ 0-9a-f]+:	9c60 0000 	lwc1	\$f3,0\(zero\)
[ 0-9a-f]+:	9c60 0004 	lwc1	\$f3,4\(zero\)
[ 0-9a-f]+:	9c60 0004 	lwc1	\$f3,4\(zero\)
[ 0-9a-f]+:	9c64 0000 	lwc1	\$f3,0\(a0\)
[ 0-9a-f]+:	9c64 0000 	lwc1	\$f3,0\(a0\)
[ 0-9a-f]+:	9c64 7fff 	lwc1	\$f3,32767\(a0\)
[ 0-9a-f]+:	9c64 8000 	lwc1	\$f3,-32768\(a0\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9c61 ffff 	lwc1	\$f3,-1\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9c61 0000 	lwc1	\$f3,0\(at\)
[ 0-9a-f]+:	9c64 8000 	lwc1	\$f3,-32768\(a0\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9c61 0001 	lwc1	\$f3,1\(at\)
[ 0-9a-f]+:	9c64 8001 	lwc1	\$f3,-32767\(a0\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9c61 0000 	lwc1	\$f3,0\(at\)
[ 0-9a-f]+:	9c64 ffff 	lwc1	\$f3,-1\(a0\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9c61 5678 	lwc1	\$f3,22136\(at\)
[ 0-9a-f]+:	9c60 0000 	lwc1	\$f3,0\(zero\)
[ 0-9a-f]+:	9c60 0000 	lwc1	\$f3,0\(zero\)
[ 0-9a-f]+:	9c60 0004 	lwc1	\$f3,4\(zero\)
[ 0-9a-f]+:	9c60 0004 	lwc1	\$f3,4\(zero\)
[ 0-9a-f]+:	9c64 0000 	lwc1	\$f3,0\(a0\)
[ 0-9a-f]+:	9c64 0000 	lwc1	\$f3,0\(a0\)
[ 0-9a-f]+:	9c64 7fff 	lwc1	\$f3,32767\(a0\)
[ 0-9a-f]+:	9c64 8000 	lwc1	\$f3,-32768\(a0\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9c61 ffff 	lwc1	\$f3,-1\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9c61 0000 	lwc1	\$f3,0\(at\)
[ 0-9a-f]+:	9c64 8000 	lwc1	\$f3,-32768\(a0\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9c61 0001 	lwc1	\$f3,1\(at\)
[ 0-9a-f]+:	9c64 8001 	lwc1	\$f3,-32767\(a0\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9c61 0000 	lwc1	\$f3,0\(at\)
[ 0-9a-f]+:	9c64 ffff 	lwc1	\$f3,-1\(a0\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9c61 5678 	lwc1	\$f3,22136\(at\)
[ 0-9a-f]+:	9c60 0000 	lwc1	\$f3,0\(zero\)
[ 0-9a-f]+:	9c60 0000 	lwc1	\$f3,0\(zero\)
[ 0-9a-f]+:	9c60 0004 	lwc1	\$f3,4\(zero\)
[ 0-9a-f]+:	9c60 0004 	lwc1	\$f3,4\(zero\)
[ 0-9a-f]+:	9c64 0000 	lwc1	\$f3,0\(a0\)
[ 0-9a-f]+:	9c64 0000 	lwc1	\$f3,0\(a0\)
[ 0-9a-f]+:	9c64 7fff 	lwc1	\$f3,32767\(a0\)
[ 0-9a-f]+:	9c64 8000 	lwc1	\$f3,-32768\(a0\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9c61 ffff 	lwc1	\$f3,-1\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9c61 0000 	lwc1	\$f3,0\(at\)
[ 0-9a-f]+:	9c64 8000 	lwc1	\$f3,-32768\(a0\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9c61 0001 	lwc1	\$f3,1\(at\)
[ 0-9a-f]+:	9c64 8001 	lwc1	\$f3,-32767\(a0\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9c61 0000 	lwc1	\$f3,0\(at\)
[ 0-9a-f]+:	9c64 ffff 	lwc1	\$f3,-1\(a0\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9c61 5678 	lwc1	\$f3,22136\(at\)
[ 0-9a-f]+:	54a0 203b 	mfc1	a1,\$f0
[ 0-9a-f]+:	54a1 203b 	mfc1	a1,\$f1
[ 0-9a-f]+:	54a2 203b 	mfc1	a1,\$f2
[ 0-9a-f]+:	54a3 203b 	mfc1	a1,\$f3
[ 0-9a-f]+:	54a4 203b 	mfc1	a1,\$f4
[ 0-9a-f]+:	54a5 203b 	mfc1	a1,\$f5
[ 0-9a-f]+:	54a6 203b 	mfc1	a1,\$f6
[ 0-9a-f]+:	54a7 203b 	mfc1	a1,\$f7
[ 0-9a-f]+:	54a8 203b 	mfc1	a1,\$f8
[ 0-9a-f]+:	54a9 203b 	mfc1	a1,\$f9
[ 0-9a-f]+:	54aa 203b 	mfc1	a1,\$f10
[ 0-9a-f]+:	54ab 203b 	mfc1	a1,\$f11
[ 0-9a-f]+:	54ac 203b 	mfc1	a1,\$f12
[ 0-9a-f]+:	54ad 203b 	mfc1	a1,\$f13
[ 0-9a-f]+:	54ae 203b 	mfc1	a1,\$f14
[ 0-9a-f]+:	54af 203b 	mfc1	a1,\$f15
[ 0-9a-f]+:	54b0 203b 	mfc1	a1,\$f16
[ 0-9a-f]+:	54b1 203b 	mfc1	a1,\$f17
[ 0-9a-f]+:	54b2 203b 	mfc1	a1,\$f18
[ 0-9a-f]+:	54b3 203b 	mfc1	a1,\$f19
[ 0-9a-f]+:	54b4 203b 	mfc1	a1,\$f20
[ 0-9a-f]+:	54b5 203b 	mfc1	a1,\$f21
[ 0-9a-f]+:	54b6 203b 	mfc1	a1,\$f22
[ 0-9a-f]+:	54b7 203b 	mfc1	a1,\$f23
[ 0-9a-f]+:	54b8 203b 	mfc1	a1,\$f24
[ 0-9a-f]+:	54b9 203b 	mfc1	a1,\$f25
[ 0-9a-f]+:	54ba 203b 	mfc1	a1,\$f26
[ 0-9a-f]+:	54bb 203b 	mfc1	a1,\$f27
[ 0-9a-f]+:	54bc 203b 	mfc1	a1,\$f28
[ 0-9a-f]+:	54bd 203b 	mfc1	a1,\$f29
[ 0-9a-f]+:	54be 203b 	mfc1	a1,\$f30
[ 0-9a-f]+:	54bf 203b 	mfc1	a1,\$f31
[ 0-9a-f]+:	54a0 203b 	mfc1	a1,\$f0
[ 0-9a-f]+:	54a1 203b 	mfc1	a1,\$f1
[ 0-9a-f]+:	54a2 203b 	mfc1	a1,\$f2
[ 0-9a-f]+:	54a3 203b 	mfc1	a1,\$f3
[ 0-9a-f]+:	54a4 203b 	mfc1	a1,\$f4
[ 0-9a-f]+:	54a5 203b 	mfc1	a1,\$f5
[ 0-9a-f]+:	54a6 203b 	mfc1	a1,\$f6
[ 0-9a-f]+:	54a7 203b 	mfc1	a1,\$f7
[ 0-9a-f]+:	54a8 203b 	mfc1	a1,\$f8
[ 0-9a-f]+:	54a9 203b 	mfc1	a1,\$f9
[ 0-9a-f]+:	54aa 203b 	mfc1	a1,\$f10
[ 0-9a-f]+:	54ab 203b 	mfc1	a1,\$f11
[ 0-9a-f]+:	54ac 203b 	mfc1	a1,\$f12
[ 0-9a-f]+:	54ad 203b 	mfc1	a1,\$f13
[ 0-9a-f]+:	54ae 203b 	mfc1	a1,\$f14
[ 0-9a-f]+:	54af 203b 	mfc1	a1,\$f15
[ 0-9a-f]+:	54b0 203b 	mfc1	a1,\$f16
[ 0-9a-f]+:	54b1 203b 	mfc1	a1,\$f17
[ 0-9a-f]+:	54b2 203b 	mfc1	a1,\$f18
[ 0-9a-f]+:	54b3 203b 	mfc1	a1,\$f19
[ 0-9a-f]+:	54b4 203b 	mfc1	a1,\$f20
[ 0-9a-f]+:	54b5 203b 	mfc1	a1,\$f21
[ 0-9a-f]+:	54b6 203b 	mfc1	a1,\$f22
[ 0-9a-f]+:	54b7 203b 	mfc1	a1,\$f23
[ 0-9a-f]+:	54b8 203b 	mfc1	a1,\$f24
[ 0-9a-f]+:	54b9 203b 	mfc1	a1,\$f25
[ 0-9a-f]+:	54ba 203b 	mfc1	a1,\$f26
[ 0-9a-f]+:	54bb 203b 	mfc1	a1,\$f27
[ 0-9a-f]+:	54bc 203b 	mfc1	a1,\$f28
[ 0-9a-f]+:	54bd 203b 	mfc1	a1,\$f29
[ 0-9a-f]+:	54be 203b 	mfc1	a1,\$f30
[ 0-9a-f]+:	54bf 203b 	mfc1	a1,\$f31
[ 0-9a-f]+:	54a0 303b 	mfhc1	a1,\$f0
[ 0-9a-f]+:	54a1 303b 	mfhc1	a1,\$f1
[ 0-9a-f]+:	54a2 303b 	mfhc1	a1,\$f2
[ 0-9a-f]+:	54a3 303b 	mfhc1	a1,\$f3
[ 0-9a-f]+:	54a4 303b 	mfhc1	a1,\$f4
[ 0-9a-f]+:	54a5 303b 	mfhc1	a1,\$f5
[ 0-9a-f]+:	54a6 303b 	mfhc1	a1,\$f6
[ 0-9a-f]+:	54a7 303b 	mfhc1	a1,\$f7
[ 0-9a-f]+:	54a8 303b 	mfhc1	a1,\$f8
[ 0-9a-f]+:	54a9 303b 	mfhc1	a1,\$f9
[ 0-9a-f]+:	54aa 303b 	mfhc1	a1,\$f10
[ 0-9a-f]+:	54ab 303b 	mfhc1	a1,\$f11
[ 0-9a-f]+:	54ac 303b 	mfhc1	a1,\$f12
[ 0-9a-f]+:	54ad 303b 	mfhc1	a1,\$f13
[ 0-9a-f]+:	54ae 303b 	mfhc1	a1,\$f14
[ 0-9a-f]+:	54af 303b 	mfhc1	a1,\$f15
[ 0-9a-f]+:	54b0 303b 	mfhc1	a1,\$f16
[ 0-9a-f]+:	54b1 303b 	mfhc1	a1,\$f17
[ 0-9a-f]+:	54b2 303b 	mfhc1	a1,\$f18
[ 0-9a-f]+:	54b3 303b 	mfhc1	a1,\$f19
[ 0-9a-f]+:	54b4 303b 	mfhc1	a1,\$f20
[ 0-9a-f]+:	54b5 303b 	mfhc1	a1,\$f21
[ 0-9a-f]+:	54b6 303b 	mfhc1	a1,\$f22
[ 0-9a-f]+:	54b7 303b 	mfhc1	a1,\$f23
[ 0-9a-f]+:	54b8 303b 	mfhc1	a1,\$f24
[ 0-9a-f]+:	54b9 303b 	mfhc1	a1,\$f25
[ 0-9a-f]+:	54ba 303b 	mfhc1	a1,\$f26
[ 0-9a-f]+:	54bb 303b 	mfhc1	a1,\$f27
[ 0-9a-f]+:	54bc 303b 	mfhc1	a1,\$f28
[ 0-9a-f]+:	54bd 303b 	mfhc1	a1,\$f29
[ 0-9a-f]+:	54be 303b 	mfhc1	a1,\$f30
[ 0-9a-f]+:	54bf 303b 	mfhc1	a1,\$f31
[ 0-9a-f]+:	54a0 303b 	mfhc1	a1,\$f0
[ 0-9a-f]+:	54a1 303b 	mfhc1	a1,\$f1
[ 0-9a-f]+:	54a2 303b 	mfhc1	a1,\$f2
[ 0-9a-f]+:	54a3 303b 	mfhc1	a1,\$f3
[ 0-9a-f]+:	54a4 303b 	mfhc1	a1,\$f4
[ 0-9a-f]+:	54a5 303b 	mfhc1	a1,\$f5
[ 0-9a-f]+:	54a6 303b 	mfhc1	a1,\$f6
[ 0-9a-f]+:	54a7 303b 	mfhc1	a1,\$f7
[ 0-9a-f]+:	54a8 303b 	mfhc1	a1,\$f8
[ 0-9a-f]+:	54a9 303b 	mfhc1	a1,\$f9
[ 0-9a-f]+:	54aa 303b 	mfhc1	a1,\$f10
[ 0-9a-f]+:	54ab 303b 	mfhc1	a1,\$f11
[ 0-9a-f]+:	54ac 303b 	mfhc1	a1,\$f12
[ 0-9a-f]+:	54ad 303b 	mfhc1	a1,\$f13
[ 0-9a-f]+:	54ae 303b 	mfhc1	a1,\$f14
[ 0-9a-f]+:	54af 303b 	mfhc1	a1,\$f15
[ 0-9a-f]+:	54b0 303b 	mfhc1	a1,\$f16
[ 0-9a-f]+:	54b1 303b 	mfhc1	a1,\$f17
[ 0-9a-f]+:	54b2 303b 	mfhc1	a1,\$f18
[ 0-9a-f]+:	54b3 303b 	mfhc1	a1,\$f19
[ 0-9a-f]+:	54b4 303b 	mfhc1	a1,\$f20
[ 0-9a-f]+:	54b5 303b 	mfhc1	a1,\$f21
[ 0-9a-f]+:	54b6 303b 	mfhc1	a1,\$f22
[ 0-9a-f]+:	54b7 303b 	mfhc1	a1,\$f23
[ 0-9a-f]+:	54b8 303b 	mfhc1	a1,\$f24
[ 0-9a-f]+:	54b9 303b 	mfhc1	a1,\$f25
[ 0-9a-f]+:	54ba 303b 	mfhc1	a1,\$f26
[ 0-9a-f]+:	54bb 303b 	mfhc1	a1,\$f27
[ 0-9a-f]+:	54bc 303b 	mfhc1	a1,\$f28
[ 0-9a-f]+:	54bd 303b 	mfhc1	a1,\$f29
[ 0-9a-f]+:	54be 303b 	mfhc1	a1,\$f30
[ 0-9a-f]+:	54bf 303b 	mfhc1	a1,\$f31
[ 0-9a-f]+:	5401 207b 	mov.d	\$f0,\$f1
[ 0-9a-f]+:	57df 207b 	mov.d	\$f30,\$f31
[ 0-9a-f]+:	5401 007b 	mov.s	\$f0,\$f1
[ 0-9a-f]+:	57df 007b 	mov.s	\$f30,\$f31
[ 0-9a-f]+:	54a0 283b 	mtc1	a1,\$f0
[ 0-9a-f]+:	54a1 283b 	mtc1	a1,\$f1
[ 0-9a-f]+:	54a2 283b 	mtc1	a1,\$f2
[ 0-9a-f]+:	54a3 283b 	mtc1	a1,\$f3
[ 0-9a-f]+:	54a4 283b 	mtc1	a1,\$f4
[ 0-9a-f]+:	54a5 283b 	mtc1	a1,\$f5
[ 0-9a-f]+:	54a6 283b 	mtc1	a1,\$f6
[ 0-9a-f]+:	54a7 283b 	mtc1	a1,\$f7
[ 0-9a-f]+:	54a8 283b 	mtc1	a1,\$f8
[ 0-9a-f]+:	54a9 283b 	mtc1	a1,\$f9
[ 0-9a-f]+:	54aa 283b 	mtc1	a1,\$f10
[ 0-9a-f]+:	54ab 283b 	mtc1	a1,\$f11
[ 0-9a-f]+:	54ac 283b 	mtc1	a1,\$f12
[ 0-9a-f]+:	54ad 283b 	mtc1	a1,\$f13
[ 0-9a-f]+:	54ae 283b 	mtc1	a1,\$f14
[ 0-9a-f]+:	54af 283b 	mtc1	a1,\$f15
[ 0-9a-f]+:	54b0 283b 	mtc1	a1,\$f16
[ 0-9a-f]+:	54b1 283b 	mtc1	a1,\$f17
[ 0-9a-f]+:	54b2 283b 	mtc1	a1,\$f18
[ 0-9a-f]+:	54b3 283b 	mtc1	a1,\$f19
[ 0-9a-f]+:	54b4 283b 	mtc1	a1,\$f20
[ 0-9a-f]+:	54b5 283b 	mtc1	a1,\$f21
[ 0-9a-f]+:	54b6 283b 	mtc1	a1,\$f22
[ 0-9a-f]+:	54b7 283b 	mtc1	a1,\$f23
[ 0-9a-f]+:	54b8 283b 	mtc1	a1,\$f24
[ 0-9a-f]+:	54b9 283b 	mtc1	a1,\$f25
[ 0-9a-f]+:	54ba 283b 	mtc1	a1,\$f26
[ 0-9a-f]+:	54bb 283b 	mtc1	a1,\$f27
[ 0-9a-f]+:	54bc 283b 	mtc1	a1,\$f28
[ 0-9a-f]+:	54bd 283b 	mtc1	a1,\$f29
[ 0-9a-f]+:	54be 283b 	mtc1	a1,\$f30
[ 0-9a-f]+:	54bf 283b 	mtc1	a1,\$f31
[ 0-9a-f]+:	54a0 283b 	mtc1	a1,\$f0
[ 0-9a-f]+:	54a1 283b 	mtc1	a1,\$f1
[ 0-9a-f]+:	54a2 283b 	mtc1	a1,\$f2
[ 0-9a-f]+:	54a3 283b 	mtc1	a1,\$f3
[ 0-9a-f]+:	54a4 283b 	mtc1	a1,\$f4
[ 0-9a-f]+:	54a5 283b 	mtc1	a1,\$f5
[ 0-9a-f]+:	54a6 283b 	mtc1	a1,\$f6
[ 0-9a-f]+:	54a7 283b 	mtc1	a1,\$f7
[ 0-9a-f]+:	54a8 283b 	mtc1	a1,\$f8
[ 0-9a-f]+:	54a9 283b 	mtc1	a1,\$f9
[ 0-9a-f]+:	54aa 283b 	mtc1	a1,\$f10
[ 0-9a-f]+:	54ab 283b 	mtc1	a1,\$f11
[ 0-9a-f]+:	54ac 283b 	mtc1	a1,\$f12
[ 0-9a-f]+:	54ad 283b 	mtc1	a1,\$f13
[ 0-9a-f]+:	54ae 283b 	mtc1	a1,\$f14
[ 0-9a-f]+:	54af 283b 	mtc1	a1,\$f15
[ 0-9a-f]+:	54b0 283b 	mtc1	a1,\$f16
[ 0-9a-f]+:	54b1 283b 	mtc1	a1,\$f17
[ 0-9a-f]+:	54b2 283b 	mtc1	a1,\$f18
[ 0-9a-f]+:	54b3 283b 	mtc1	a1,\$f19
[ 0-9a-f]+:	54b4 283b 	mtc1	a1,\$f20
[ 0-9a-f]+:	54b5 283b 	mtc1	a1,\$f21
[ 0-9a-f]+:	54b6 283b 	mtc1	a1,\$f22
[ 0-9a-f]+:	54b7 283b 	mtc1	a1,\$f23
[ 0-9a-f]+:	54b8 283b 	mtc1	a1,\$f24
[ 0-9a-f]+:	54b9 283b 	mtc1	a1,\$f25
[ 0-9a-f]+:	54ba 283b 	mtc1	a1,\$f26
[ 0-9a-f]+:	54bb 283b 	mtc1	a1,\$f27
[ 0-9a-f]+:	54bc 283b 	mtc1	a1,\$f28
[ 0-9a-f]+:	54bd 283b 	mtc1	a1,\$f29
[ 0-9a-f]+:	54be 283b 	mtc1	a1,\$f30
[ 0-9a-f]+:	54bf 283b 	mtc1	a1,\$f31
[ 0-9a-f]+:	54a0 383b 	mthc1	a1,\$f0
[ 0-9a-f]+:	54a1 383b 	mthc1	a1,\$f1
[ 0-9a-f]+:	54a2 383b 	mthc1	a1,\$f2
[ 0-9a-f]+:	54a3 383b 	mthc1	a1,\$f3
[ 0-9a-f]+:	54a4 383b 	mthc1	a1,\$f4
[ 0-9a-f]+:	54a5 383b 	mthc1	a1,\$f5
[ 0-9a-f]+:	54a6 383b 	mthc1	a1,\$f6
[ 0-9a-f]+:	54a7 383b 	mthc1	a1,\$f7
[ 0-9a-f]+:	54a8 383b 	mthc1	a1,\$f8
[ 0-9a-f]+:	54a9 383b 	mthc1	a1,\$f9
[ 0-9a-f]+:	54aa 383b 	mthc1	a1,\$f10
[ 0-9a-f]+:	54ab 383b 	mthc1	a1,\$f11
[ 0-9a-f]+:	54ac 383b 	mthc1	a1,\$f12
[ 0-9a-f]+:	54ad 383b 	mthc1	a1,\$f13
[ 0-9a-f]+:	54ae 383b 	mthc1	a1,\$f14
[ 0-9a-f]+:	54af 383b 	mthc1	a1,\$f15
[ 0-9a-f]+:	54b0 383b 	mthc1	a1,\$f16
[ 0-9a-f]+:	54b1 383b 	mthc1	a1,\$f17
[ 0-9a-f]+:	54b2 383b 	mthc1	a1,\$f18
[ 0-9a-f]+:	54b3 383b 	mthc1	a1,\$f19
[ 0-9a-f]+:	54b4 383b 	mthc1	a1,\$f20
[ 0-9a-f]+:	54b5 383b 	mthc1	a1,\$f21
[ 0-9a-f]+:	54b6 383b 	mthc1	a1,\$f22
[ 0-9a-f]+:	54b7 383b 	mthc1	a1,\$f23
[ 0-9a-f]+:	54b8 383b 	mthc1	a1,\$f24
[ 0-9a-f]+:	54b9 383b 	mthc1	a1,\$f25
[ 0-9a-f]+:	54ba 383b 	mthc1	a1,\$f26
[ 0-9a-f]+:	54bb 383b 	mthc1	a1,\$f27
[ 0-9a-f]+:	54bc 383b 	mthc1	a1,\$f28
[ 0-9a-f]+:	54bd 383b 	mthc1	a1,\$f29
[ 0-9a-f]+:	54be 383b 	mthc1	a1,\$f30
[ 0-9a-f]+:	54bf 383b 	mthc1	a1,\$f31
[ 0-9a-f]+:	54a0 383b 	mthc1	a1,\$f0
[ 0-9a-f]+:	54a1 383b 	mthc1	a1,\$f1
[ 0-9a-f]+:	54a2 383b 	mthc1	a1,\$f2
[ 0-9a-f]+:	54a3 383b 	mthc1	a1,\$f3
[ 0-9a-f]+:	54a4 383b 	mthc1	a1,\$f4
[ 0-9a-f]+:	54a5 383b 	mthc1	a1,\$f5
[ 0-9a-f]+:	54a6 383b 	mthc1	a1,\$f6
[ 0-9a-f]+:	54a7 383b 	mthc1	a1,\$f7
[ 0-9a-f]+:	54a8 383b 	mthc1	a1,\$f8
[ 0-9a-f]+:	54a9 383b 	mthc1	a1,\$f9
[ 0-9a-f]+:	54aa 383b 	mthc1	a1,\$f10
[ 0-9a-f]+:	54ab 383b 	mthc1	a1,\$f11
[ 0-9a-f]+:	54ac 383b 	mthc1	a1,\$f12
[ 0-9a-f]+:	54ad 383b 	mthc1	a1,\$f13
[ 0-9a-f]+:	54ae 383b 	mthc1	a1,\$f14
[ 0-9a-f]+:	54af 383b 	mthc1	a1,\$f15
[ 0-9a-f]+:	54b0 383b 	mthc1	a1,\$f16
[ 0-9a-f]+:	54b1 383b 	mthc1	a1,\$f17
[ 0-9a-f]+:	54b2 383b 	mthc1	a1,\$f18
[ 0-9a-f]+:	54b3 383b 	mthc1	a1,\$f19
[ 0-9a-f]+:	54b4 383b 	mthc1	a1,\$f20
[ 0-9a-f]+:	54b5 383b 	mthc1	a1,\$f21
[ 0-9a-f]+:	54b6 383b 	mthc1	a1,\$f22
[ 0-9a-f]+:	54b7 383b 	mthc1	a1,\$f23
[ 0-9a-f]+:	54b8 383b 	mthc1	a1,\$f24
[ 0-9a-f]+:	54b9 383b 	mthc1	a1,\$f25
[ 0-9a-f]+:	54ba 383b 	mthc1	a1,\$f26
[ 0-9a-f]+:	54bb 383b 	mthc1	a1,\$f27
[ 0-9a-f]+:	54bc 383b 	mthc1	a1,\$f28
[ 0-9a-f]+:	54bd 383b 	mthc1	a1,\$f29
[ 0-9a-f]+:	54be 383b 	mthc1	a1,\$f30
[ 0-9a-f]+:	54bf 383b 	mthc1	a1,\$f31
[ 0-9a-f]+:	5441 00b0 	mul.s	\$f0,\$f1,\$f2
[ 0-9a-f]+:	57fe e8b0 	mul.s	\$f29,\$f30,\$f31
[ 0-9a-f]+:	57dd e8b0 	mul.s	\$f29,\$f29,\$f30
[ 0-9a-f]+:	57dd e8b0 	mul.s	\$f29,\$f29,\$f30
[ 0-9a-f]+:	5441 01b0 	mul.d	\$f0,\$f1,\$f2
[ 0-9a-f]+:	57fe e9b0 	mul.d	\$f29,\$f30,\$f31
[ 0-9a-f]+:	57dd e9b0 	mul.d	\$f29,\$f29,\$f30
[ 0-9a-f]+:	57dd e9b0 	mul.d	\$f29,\$f29,\$f30
[ 0-9a-f]+:	5401 0b7b 	neg.s	\$f0,\$f1
[ 0-9a-f]+:	57df 0b7b 	neg.s	\$f30,\$f31
[ 0-9a-f]+:	5442 0b7b 	neg.s	\$f2,\$f2
[ 0-9a-f]+:	5442 0b7b 	neg.s	\$f2,\$f2
[ 0-9a-f]+:	5401 2b7b 	neg.d	\$f0,\$f1
[ 0-9a-f]+:	57df 2b7b 	neg.d	\$f30,\$f31
[ 0-9a-f]+:	5442 2b7b 	neg.d	\$f2,\$f2
[ 0-9a-f]+:	5442 2b7b 	neg.d	\$f2,\$f2
[ 0-9a-f]+:	5401 123b 	recip.s	\$f0,\$f1
[ 0-9a-f]+:	57df 123b 	recip.s	\$f30,\$f31
[ 0-9a-f]+:	5442 123b 	recip.s	\$f2,\$f2
[ 0-9a-f]+:	5401 523b 	recip.d	\$f0,\$f1
[ 0-9a-f]+:	57df 523b 	recip.d	\$f30,\$f31
[ 0-9a-f]+:	5442 523b 	recip.d	\$f2,\$f2
[ 0-9a-f]+:	5401 333b 	round.l.s	\$f0,\$f1
[ 0-9a-f]+:	57df 333b 	round.l.s	\$f30,\$f31
[ 0-9a-f]+:	5442 333b 	round.l.s	\$f2,\$f2
[ 0-9a-f]+:	5401 733b 	round.l.d	\$f0,\$f1
[ 0-9a-f]+:	57df 733b 	round.l.d	\$f30,\$f31
[ 0-9a-f]+:	5442 733b 	round.l.d	\$f2,\$f2
[ 0-9a-f]+:	5401 3b3b 	round.w.s	\$f0,\$f1
[ 0-9a-f]+:	57df 3b3b 	round.w.s	\$f30,\$f31
[ 0-9a-f]+:	5442 3b3b 	round.w.s	\$f2,\$f2
[ 0-9a-f]+:	5401 7b3b 	round.w.d	\$f0,\$f1
[ 0-9a-f]+:	57df 7b3b 	round.w.d	\$f30,\$f31
[ 0-9a-f]+:	5442 7b3b 	round.w.d	\$f2,\$f2
[ 0-9a-f]+:	5401 023b 	rsqrt.s	\$f0,\$f1
[ 0-9a-f]+:	57df 023b 	rsqrt.s	\$f30,\$f31
[ 0-9a-f]+:	5442 023b 	rsqrt.s	\$f2,\$f2
[ 0-9a-f]+:	5401 423b 	rsqrt.d	\$f0,\$f1
[ 0-9a-f]+:	57df 423b 	rsqrt.d	\$f30,\$f31
[ 0-9a-f]+:	5442 423b 	rsqrt.d	\$f2,\$f2
[ 0-9a-f]+:	b860 0000 	sdc1	\$f3,0\(zero\)
[ 0-9a-f]+:	b860 0000 	sdc1	\$f3,0\(zero\)
[ 0-9a-f]+:	b860 0004 	sdc1	\$f3,4\(zero\)
[ 0-9a-f]+:	b860 0004 	sdc1	\$f3,4\(zero\)
[ 0-9a-f]+:	b864 0000 	sdc1	\$f3,0\(a0\)
[ 0-9a-f]+:	b864 0000 	sdc1	\$f3,0\(a0\)
[ 0-9a-f]+:	b864 7fff 	sdc1	\$f3,32767\(a0\)
[ 0-9a-f]+:	b864 8000 	sdc1	\$f3,-32768\(a0\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	b861 ffff 	sdc1	\$f3,-1\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	b861 0000 	sdc1	\$f3,0\(at\)
[ 0-9a-f]+:	b864 8000 	sdc1	\$f3,-32768\(a0\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	b861 0001 	sdc1	\$f3,1\(at\)
[ 0-9a-f]+:	b864 8001 	sdc1	\$f3,-32767\(a0\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	b861 0000 	sdc1	\$f3,0\(at\)
[ 0-9a-f]+:	b864 ffff 	sdc1	\$f3,-1\(a0\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	b861 5678 	sdc1	\$f3,22136\(at\)
[ 0-9a-f]+:	b860 0000 	sdc1	\$f3,0\(zero\)
[ 0-9a-f]+:	b860 0000 	sdc1	\$f3,0\(zero\)
[ 0-9a-f]+:	b860 0004 	sdc1	\$f3,4\(zero\)
[ 0-9a-f]+:	b860 0004 	sdc1	\$f3,4\(zero\)
[ 0-9a-f]+:	b864 0000 	sdc1	\$f3,0\(a0\)
[ 0-9a-f]+:	b864 0000 	sdc1	\$f3,0\(a0\)
[ 0-9a-f]+:	b864 7fff 	sdc1	\$f3,32767\(a0\)
[ 0-9a-f]+:	b864 8000 	sdc1	\$f3,-32768\(a0\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	b861 ffff 	sdc1	\$f3,-1\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	b861 0000 	sdc1	\$f3,0\(at\)
[ 0-9a-f]+:	b864 8000 	sdc1	\$f3,-32768\(a0\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	b861 0001 	sdc1	\$f3,1\(at\)
[ 0-9a-f]+:	b864 8001 	sdc1	\$f3,-32767\(a0\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	b861 0000 	sdc1	\$f3,0\(at\)
[ 0-9a-f]+:	b864 ffff 	sdc1	\$f3,-1\(a0\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	b861 5678 	sdc1	\$f3,22136\(at\)
[ 0-9a-f]+:	b860 0000 	sdc1	\$f3,0\(zero\)
[ 0-9a-f]+:	b860 0000 	sdc1	\$f3,0\(zero\)
[ 0-9a-f]+:	b860 0004 	sdc1	\$f3,4\(zero\)
[ 0-9a-f]+:	b860 0004 	sdc1	\$f3,4\(zero\)
[ 0-9a-f]+:	b864 0000 	sdc1	\$f3,0\(a0\)
[ 0-9a-f]+:	b864 0000 	sdc1	\$f3,0\(a0\)
[ 0-9a-f]+:	b864 7fff 	sdc1	\$f3,32767\(a0\)
[ 0-9a-f]+:	b864 8000 	sdc1	\$f3,-32768\(a0\)
[ 0-9a-f]+:	5401 0a3b 	sqrt.s	\$f0,\$f1
[ 0-9a-f]+:	57df 0a3b 	sqrt.s	\$f30,\$f31
[ 0-9a-f]+:	5442 0a3b 	sqrt.s	\$f2,\$f2
[ 0-9a-f]+:	5401 4a3b 	sqrt.d	\$f0,\$f1
[ 0-9a-f]+:	57df 4a3b 	sqrt.d	\$f30,\$f31
[ 0-9a-f]+:	5442 4a3b 	sqrt.d	\$f2,\$f2
[ 0-9a-f]+:	5441 0070 	sub.s	\$f0,\$f1,\$f2
[ 0-9a-f]+:	57fe e870 	sub.s	\$f29,\$f30,\$f31
[ 0-9a-f]+:	57dd e870 	sub.s	\$f29,\$f29,\$f30
[ 0-9a-f]+:	57dd e870 	sub.s	\$f29,\$f29,\$f30
[ 0-9a-f]+:	5441 0170 	sub.d	\$f0,\$f1,\$f2
[ 0-9a-f]+:	57fe e970 	sub.d	\$f29,\$f30,\$f31
[ 0-9a-f]+:	57dd e970 	sub.d	\$f29,\$f29,\$f30
[ 0-9a-f]+:	57dd e970 	sub.d	\$f29,\$f29,\$f30
[ 0-9a-f]+:	9860 0000 	swc1	\$f3,0\(zero\)
[ 0-9a-f]+:	9860 0000 	swc1	\$f3,0\(zero\)
[ 0-9a-f]+:	9860 0004 	swc1	\$f3,4\(zero\)
[ 0-9a-f]+:	9860 0004 	swc1	\$f3,4\(zero\)
[ 0-9a-f]+:	9864 0000 	swc1	\$f3,0\(a0\)
[ 0-9a-f]+:	9864 0000 	swc1	\$f3,0\(a0\)
[ 0-9a-f]+:	9864 7fff 	swc1	\$f3,32767\(a0\)
[ 0-9a-f]+:	9864 8000 	swc1	\$f3,-32768\(a0\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9861 ffff 	swc1	\$f3,-1\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9861 0000 	swc1	\$f3,0\(at\)
[ 0-9a-f]+:	9864 8000 	swc1	\$f3,-32768\(a0\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9861 0001 	swc1	\$f3,1\(at\)
[ 0-9a-f]+:	9864 8001 	swc1	\$f3,-32767\(a0\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9861 0000 	swc1	\$f3,0\(at\)
[ 0-9a-f]+:	9864 ffff 	swc1	\$f3,-1\(a0\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9861 5678 	swc1	\$f3,22136\(at\)
[ 0-9a-f]+:	9860 0000 	swc1	\$f3,0\(zero\)
[ 0-9a-f]+:	9860 0000 	swc1	\$f3,0\(zero\)
[ 0-9a-f]+:	9860 0004 	swc1	\$f3,4\(zero\)
[ 0-9a-f]+:	9860 0004 	swc1	\$f3,4\(zero\)
[ 0-9a-f]+:	9864 0000 	swc1	\$f3,0\(a0\)
[ 0-9a-f]+:	9864 0000 	swc1	\$f3,0\(a0\)
[ 0-9a-f]+:	9864 7fff 	swc1	\$f3,32767\(a0\)
[ 0-9a-f]+:	9864 8000 	swc1	\$f3,-32768\(a0\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9861 ffff 	swc1	\$f3,-1\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9861 0000 	swc1	\$f3,0\(at\)
[ 0-9a-f]+:	9864 8000 	swc1	\$f3,-32768\(a0\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9861 0001 	swc1	\$f3,1\(at\)
[ 0-9a-f]+:	9864 8001 	swc1	\$f3,-32767\(a0\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9861 0000 	swc1	\$f3,0\(at\)
[ 0-9a-f]+:	9864 ffff 	swc1	\$f3,-1\(a0\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9861 5678 	swc1	\$f3,22136\(at\)
[ 0-9a-f]+:	9860 0000 	swc1	\$f3,0\(zero\)
[ 0-9a-f]+:	9860 0000 	swc1	\$f3,0\(zero\)
[ 0-9a-f]+:	9860 0004 	swc1	\$f3,4\(zero\)
[ 0-9a-f]+:	9860 0004 	swc1	\$f3,4\(zero\)
[ 0-9a-f]+:	9864 0000 	swc1	\$f3,0\(a0\)
[ 0-9a-f]+:	9864 0000 	swc1	\$f3,0\(a0\)
[ 0-9a-f]+:	9864 7fff 	swc1	\$f3,32767\(a0\)
[ 0-9a-f]+:	9864 8000 	swc1	\$f3,-32768\(a0\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9861 ffff 	swc1	\$f3,-1\(at\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9861 0000 	swc1	\$f3,0\(at\)
[ 0-9a-f]+:	9864 8000 	swc1	\$f3,-32768\(a0\)
[ 0-9a-f]+:	1020 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9861 0001 	swc1	\$f3,1\(at\)
[ 0-9a-f]+:	9864 8001 	swc1	\$f3,-32767\(a0\)
[ 0-9a-f]+:	1020 f000 	lui	at,0xf000
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9861 0000 	swc1	\$f3,0\(at\)
[ 0-9a-f]+:	9864 ffff 	swc1	\$f3,-1\(a0\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	9861 5678 	swc1	\$f3,22136\(at\)
[ 0-9a-f]+:	5401 233b 	trunc.l.s	\$f0,\$f1
[ 0-9a-f]+:	57df 233b 	trunc.l.s	\$f30,\$f31
[ 0-9a-f]+:	5442 233b 	trunc.l.s	\$f2,\$f2
[ 0-9a-f]+:	5401 633b 	trunc.l.d	\$f0,\$f1
[ 0-9a-f]+:	57df 633b 	trunc.l.d	\$f30,\$f31
[ 0-9a-f]+:	5442 633b 	trunc.l.d	\$f2,\$f2
[ 0-9a-f]+:	5401 2b3b 	trunc.w.s	\$f0,\$f1
[ 0-9a-f]+:	57df 2b3b 	trunc.w.s	\$f30,\$f31
[ 0-9a-f]+:	5442 2b3b 	trunc.w.s	\$f2,\$f2
[ 0-9a-f]+:	5401 6b3b 	trunc.w.d	\$f0,\$f1
[ 0-9a-f]+:	57df 6b3b 	trunc.w.d	\$f30,\$f31
[ 0-9a-f]+:	5442 6b3b 	trunc.w.d	\$f2,\$f2

[ 0-9a-f]+ <test_mips64>:
[ 0-9a-f]+:	0c43      	move	v0,v1
[ 0-9a-f]+:	f463 fffe 	bgezc	v1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L4
[ 0-9a-f]+:	5860 1190 	dneg	v0,v1

[ 0-9a-f]+ <.L4>:
[ 0-9a-f]+:	f442 fffe 	bgezc	v0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L5
[ 0-9a-f]+:	5840 1190 	dneg	v0,v0

[ 0-9a-f]+ <.L5>:
[ 0-9a-f]+:	f442 fffe 	bgezc	v0,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.L6
[ 0-9a-f]+:	5840 1190 	dneg	v0,v0

[ 0-9a-f]+ <.L6>:
[ 0-9a-f]+:	5883 1110 	dadd	v0,v1,a0
[ 0-9a-f]+:	5bfe e910 	dadd	sp,s8,ra
[ 0-9a-f]+:	5862 1110 	dadd	v0,v0,v1
[ 0-9a-f]+:	5862 1110 	dadd	v0,v0,v1
[ 0-9a-f]+:	5c43 0000 	daddiu	v0,v1,0
[ 0-9a-f]+:	5c43 8000 	daddiu	v0,v1,-32768
[ 0-9a-f]+:	5c43 7fff 	daddiu	v0,v1,32767
[ 0-9a-f]+:	5c42 7fff 	daddiu	v0,v0,32767
[ 0-9a-f]+:	5c42 7fff 	daddiu	v0,v0,32767
[ 0-9a-f]+:	5883 1150 	daddu	v0,v1,a0
[ 0-9a-f]+:	5bfe e950 	daddu	sp,s8,ra
[ 0-9a-f]+:	5862 1150 	daddu	v0,v0,v1
[ 0-9a-f]+:	5862 1150 	daddu	v0,v0,v1
[ 0-9a-f]+:	5803 1150 	move	v0,v1
[ 0-9a-f]+:	5c43 0000 	daddiu	v0,v1,0
[ 0-9a-f]+:	5c43 0001 	daddiu	v0,v1,1
[ 0-9a-f]+:	5c43 7fff 	daddiu	v0,v1,32767
[ 0-9a-f]+:	5c43 8000 	daddiu	v0,v1,-32768
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	5823 1150 	daddu	v0,v1,at
[ 0-9a-f]+:	5843 4b3c 	dclo	v0,v1
[ 0-9a-f]+:	5862 4b3c 	dclo	v1,v0
[ 0-9a-f]+:	5843 5b3c 	dclz	v0,v1
[ 0-9a-f]+:	5862 5b3c 	dclz	v1,v0
[ 0-9a-f]+:	5862 0118 	ddiv	zero,v0,v1
[ 0-9a-f]+:	5bfe 0118 	ddiv	zero,s8,ra
[ 0-9a-f]+:	5803 1118 	ddiv	v0,v1,zero
[ 0-9a-f]+:	5883 1118 	ddiv	v0,v1,a0
[ 0-9a-f]+:	5862 0198 	ddivu	zero,v0,v1
[ 0-9a-f]+:	5bfe 0198 	ddivu	zero,s8,ra
[ 0-9a-f]+:	5803 1198 	ddivu	v0,v1,zero
[ 0-9a-f]+:	5883 1198 	ddivu	v0,v1,a0
[ 0-9a-f]+:	5843 07ec 	dext	v0,v1,0x1f,0x1
[ 0-9a-f]+:	5843 f82c 	dext	v0,v1,0x0,0x20
[ 0-9a-f]+:	5843 07e4 	dext	v0,v1,0x1f,0x21
[ 0-9a-f]+:	5843 07e4 	dext	v0,v1,0x1f,0x21
[ 0-9a-f]+:	5843 4854 	dext	v0,v1,0x21,0xa
[ 0-9a-f]+:	5843 4854 	dext	v0,v1,0x21,0xa
[ 0-9a-f]+:	5843 ffcc 	dins	v0,v1,0x1f,0x1
[ 0-9a-f]+:	5843 f80c 	dins	v0,v1,0x0,0x20
[ 0-9a-f]+:	5843 ffc4 	dins	v0,v1,0x1f,0x21
[ 0-9a-f]+:	5843 ffc4 	dins	v0,v1,0x1f,0x21
[ 0-9a-f]+:	5843 5074 	dins	v0,v1,0x21,0xa
[ 0-9a-f]+:	5843 5074 	dins	v0,v1,0x21,0xa
[ 0-9a-f]+:	1040 0000 	lui	v0,0x0
[	]*[0-9a-f]+: R_MICROMIPS_HI16	test
[ 0-9a-f]+:	3042 0000 	addiu	v0,v0,0
[	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	1040 0000 	lui	v0,0x0
[	]*[0-9a-f]+: R_MICROMIPS_HI16	test
[ 0-9a-f]+:	3042 0000 	addiu	v0,v0,0
[	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	3040 8000 	li	v0,-32768
[ 0-9a-f]+:	3040 7fff 	li	v0,32767
[ 0-9a-f]+:	5040 ffff 	li	v0,0xffff
[ 0-9a-f]+:	1040 1234 	lui	v0,0x1234
[ 0-9a-f]+:	5042 5678 	ori	v0,v0,0x5678
[ 0-9a-f]+:	5840 00fc 	dmfc0	v0,c0_index
[ 0-9a-f]+:	5841 00fc 	dmfc0	v0,c0_random
[ 0-9a-f]+:	5842 00fc 	dmfc0	v0,c0_entrylo0
[ 0-9a-f]+:	5843 00fc 	dmfc0	v0,c0_entrylo1
[ 0-9a-f]+:	5844 00fc 	dmfc0	v0,c0_context
[ 0-9a-f]+:	5845 00fc 	dmfc0	v0,c0_pagemask
[ 0-9a-f]+:	5846 00fc 	dmfc0	v0,c0_wired
[ 0-9a-f]+:	5847 00fc 	dmfc0	v0,c0_hwrena
[ 0-9a-f]+:	5848 00fc 	dmfc0	v0,c0_badvaddr
[ 0-9a-f]+:	5849 00fc 	dmfc0	v0,c0_count
[ 0-9a-f]+:	584a 00fc 	dmfc0	v0,c0_entryhi
[ 0-9a-f]+:	584b 00fc 	dmfc0	v0,c0_compare
[ 0-9a-f]+:	584c 00fc 	dmfc0	v0,c0_status
[ 0-9a-f]+:	584d 00fc 	dmfc0	v0,c0_cause
[ 0-9a-f]+:	584e 00fc 	dmfc0	v0,c0_epc
[ 0-9a-f]+:	584f 00fc 	dmfc0	v0,c0_prid
[ 0-9a-f]+:	5850 00fc 	dmfc0	v0,c0_config
[ 0-9a-f]+:	5851 00fc 	dmfc0	v0,c0_lladdr
[ 0-9a-f]+:	5852 00fc 	dmfc0	v0,c0_watchlo
[ 0-9a-f]+:	5853 00fc 	dmfc0	v0,c0_watchhi
[ 0-9a-f]+:	5854 00fc 	dmfc0	v0,c0_xcontext
[ 0-9a-f]+:	5855 00fc 	dmfc0	v0,\$21
[ 0-9a-f]+:	5856 00fc 	dmfc0	v0,\$22
[ 0-9a-f]+:	5857 00fc 	dmfc0	v0,c0_debug
[ 0-9a-f]+:	5858 00fc 	dmfc0	v0,c0_depc
[ 0-9a-f]+:	5859 00fc 	dmfc0	v0,c0_perfcnt
[ 0-9a-f]+:	585a 00fc 	dmfc0	v0,c0_errctl
[ 0-9a-f]+:	585b 00fc 	dmfc0	v0,c0_cacheerr
[ 0-9a-f]+:	585c 00fc 	dmfc0	v0,c0_taglo
[ 0-9a-f]+:	585d 00fc 	dmfc0	v0,c0_taghi
[ 0-9a-f]+:	585e 00fc 	dmfc0	v0,c0_errorepc
[ 0-9a-f]+:	585f 00fc 	dmfc0	v0,c0_desave
[ 0-9a-f]+:	5840 00fc 	dmfc0	v0,c0_index
[ 0-9a-f]+:	5840 08fc 	dmfc0	v0,c0_mvpcontrol
[ 0-9a-f]+:	5840 10fc 	dmfc0	v0,c0_mvpconf0
[ 0-9a-f]+:	5840 18fc 	dmfc0	v0,c0_mvpconf1
[ 0-9a-f]+:	5840 20fc 	dmfc0	v0,\$0,4
[ 0-9a-f]+:	5840 28fc 	dmfc0	v0,\$0,5
[ 0-9a-f]+:	5840 30fc 	dmfc0	v0,\$0,6
[ 0-9a-f]+:	5840 38fc 	dmfc0	v0,\$0,7
[ 0-9a-f]+:	5841 00fc 	dmfc0	v0,c0_random
[ 0-9a-f]+:	5841 08fc 	dmfc0	v0,c0_vpecontrol
[ 0-9a-f]+:	5841 10fc 	dmfc0	v0,c0_vpeconf0
[ 0-9a-f]+:	5841 18fc 	dmfc0	v0,c0_vpeconf1
[ 0-9a-f]+:	5841 20fc 	dmfc0	v0,c0_yqmask
[ 0-9a-f]+:	5841 28fc 	dmfc0	v0,c0_vpeschedule
[ 0-9a-f]+:	5841 30fc 	dmfc0	v0,c0_vpeschefback
[ 0-9a-f]+:	5841 38fc 	dmfc0	v0,\$1,7
[ 0-9a-f]+:	5842 00fc 	dmfc0	v0,c0_entrylo0
[ 0-9a-f]+:	5842 08fc 	dmfc0	v0,c0_tcstatus
[ 0-9a-f]+:	5842 10fc 	dmfc0	v0,c0_tcbind
[ 0-9a-f]+:	5842 18fc 	dmfc0	v0,c0_tcrestart
[ 0-9a-f]+:	5842 20fc 	dmfc0	v0,c0_tchalt
[ 0-9a-f]+:	5842 28fc 	dmfc0	v0,c0_tccontext
[ 0-9a-f]+:	5842 30fc 	dmfc0	v0,c0_tcschedule
[ 0-9a-f]+:	5842 38fc 	dmfc0	v0,c0_tcschefback
[ 0-9a-f]+:	5840 02fc 	dmtc0	v0,c0_index
[ 0-9a-f]+:	5841 02fc 	dmtc0	v0,c0_random
[ 0-9a-f]+:	5842 02fc 	dmtc0	v0,c0_entrylo0
[ 0-9a-f]+:	5843 02fc 	dmtc0	v0,c0_entrylo1
[ 0-9a-f]+:	5844 02fc 	dmtc0	v0,c0_context
[ 0-9a-f]+:	5845 02fc 	dmtc0	v0,c0_pagemask
[ 0-9a-f]+:	5846 02fc 	dmtc0	v0,c0_wired
[ 0-9a-f]+:	5847 02fc 	dmtc0	v0,c0_hwrena
[ 0-9a-f]+:	5848 02fc 	dmtc0	v0,c0_badvaddr
[ 0-9a-f]+:	5849 02fc 	dmtc0	v0,c0_count
[ 0-9a-f]+:	584a 02fc 	dmtc0	v0,c0_entryhi
[ 0-9a-f]+:	584b 02fc 	dmtc0	v0,c0_compare
[ 0-9a-f]+:	584c 02fc 	dmtc0	v0,c0_status
[ 0-9a-f]+:	584d 02fc 	dmtc0	v0,c0_cause
[ 0-9a-f]+:	584e 02fc 	dmtc0	v0,c0_epc
[ 0-9a-f]+:	584f 02fc 	dmtc0	v0,c0_prid
[ 0-9a-f]+:	5850 02fc 	dmtc0	v0,c0_config
[ 0-9a-f]+:	5851 02fc 	dmtc0	v0,c0_lladdr
[ 0-9a-f]+:	5852 02fc 	dmtc0	v0,c0_watchlo
[ 0-9a-f]+:	5853 02fc 	dmtc0	v0,c0_watchhi
[ 0-9a-f]+:	5854 02fc 	dmtc0	v0,c0_xcontext
[ 0-9a-f]+:	5855 02fc 	dmtc0	v0,\$21
[ 0-9a-f]+:	5856 02fc 	dmtc0	v0,\$22
[ 0-9a-f]+:	5857 02fc 	dmtc0	v0,c0_debug
[ 0-9a-f]+:	5858 02fc 	dmtc0	v0,c0_depc
[ 0-9a-f]+:	5859 02fc 	dmtc0	v0,c0_perfcnt
[ 0-9a-f]+:	585a 02fc 	dmtc0	v0,c0_errctl
[ 0-9a-f]+:	585b 02fc 	dmtc0	v0,c0_cacheerr
[ 0-9a-f]+:	585c 02fc 	dmtc0	v0,c0_taglo
[ 0-9a-f]+:	585d 02fc 	dmtc0	v0,c0_taghi
[ 0-9a-f]+:	585e 02fc 	dmtc0	v0,c0_errorepc
[ 0-9a-f]+:	585f 02fc 	dmtc0	v0,c0_desave
[ 0-9a-f]+:	5840 02fc 	dmtc0	v0,c0_index
[ 0-9a-f]+:	5840 0afc 	dmtc0	v0,c0_mvpcontrol
[ 0-9a-f]+:	5840 12fc 	dmtc0	v0,c0_mvpconf0
[ 0-9a-f]+:	5840 1afc 	dmtc0	v0,c0_mvpconf1
[ 0-9a-f]+:	5840 22fc 	dmtc0	v0,\$0,4
[ 0-9a-f]+:	5840 2afc 	dmtc0	v0,\$0,5
[ 0-9a-f]+:	5840 32fc 	dmtc0	v0,\$0,6
[ 0-9a-f]+:	5840 3afc 	dmtc0	v0,\$0,7
[ 0-9a-f]+:	5841 02fc 	dmtc0	v0,c0_random
[ 0-9a-f]+:	5841 0afc 	dmtc0	v0,c0_vpecontrol
[ 0-9a-f]+:	5841 12fc 	dmtc0	v0,c0_vpeconf0
[ 0-9a-f]+:	5841 1afc 	dmtc0	v0,c0_vpeconf1
[ 0-9a-f]+:	5841 22fc 	dmtc0	v0,c0_yqmask
[ 0-9a-f]+:	5841 2afc 	dmtc0	v0,c0_vpeschedule
[ 0-9a-f]+:	5841 32fc 	dmtc0	v0,c0_vpeschefback
[ 0-9a-f]+:	5841 3afc 	dmtc0	v0,\$1,7
[ 0-9a-f]+:	5842 02fc 	dmtc0	v0,c0_entrylo0
[ 0-9a-f]+:	5842 0afc 	dmtc0	v0,c0_tcstatus
[ 0-9a-f]+:	5842 12fc 	dmtc0	v0,c0_tcbind
[ 0-9a-f]+:	5842 1afc 	dmtc0	v0,c0_tcrestart
[ 0-9a-f]+:	5842 22fc 	dmtc0	v0,c0_tchalt
[ 0-9a-f]+:	5842 2afc 	dmtc0	v0,c0_tccontext
[ 0-9a-f]+:	5842 32fc 	dmtc0	v0,c0_tcschedule
[ 0-9a-f]+:	5842 3afc 	dmtc0	v0,c0_tcschefback
[ 0-9a-f]+:	54a0 243b 	dmfc1	a1,\$f0
[ 0-9a-f]+:	54a1 243b 	dmfc1	a1,\$f1
[ 0-9a-f]+:	54a2 243b 	dmfc1	a1,\$f2
[ 0-9a-f]+:	54a3 243b 	dmfc1	a1,\$f3
[ 0-9a-f]+:	54a4 243b 	dmfc1	a1,\$f4
[ 0-9a-f]+:	54a5 243b 	dmfc1	a1,\$f5
[ 0-9a-f]+:	54a6 243b 	dmfc1	a1,\$f6
[ 0-9a-f]+:	54a7 243b 	dmfc1	a1,\$f7
[ 0-9a-f]+:	54a8 243b 	dmfc1	a1,\$f8
[ 0-9a-f]+:	54a9 243b 	dmfc1	a1,\$f9
[ 0-9a-f]+:	54aa 243b 	dmfc1	a1,\$f10
[ 0-9a-f]+:	54ab 243b 	dmfc1	a1,\$f11
[ 0-9a-f]+:	54ac 243b 	dmfc1	a1,\$f12
[ 0-9a-f]+:	54ad 243b 	dmfc1	a1,\$f13
[ 0-9a-f]+:	54ae 243b 	dmfc1	a1,\$f14
[ 0-9a-f]+:	54af 243b 	dmfc1	a1,\$f15
[ 0-9a-f]+:	54b0 243b 	dmfc1	a1,\$f16
[ 0-9a-f]+:	54b1 243b 	dmfc1	a1,\$f17
[ 0-9a-f]+:	54b2 243b 	dmfc1	a1,\$f18
[ 0-9a-f]+:	54b3 243b 	dmfc1	a1,\$f19
[ 0-9a-f]+:	54b4 243b 	dmfc1	a1,\$f20
[ 0-9a-f]+:	54b5 243b 	dmfc1	a1,\$f21
[ 0-9a-f]+:	54b6 243b 	dmfc1	a1,\$f22
[ 0-9a-f]+:	54b7 243b 	dmfc1	a1,\$f23
[ 0-9a-f]+:	54b8 243b 	dmfc1	a1,\$f24
[ 0-9a-f]+:	54b9 243b 	dmfc1	a1,\$f25
[ 0-9a-f]+:	54ba 243b 	dmfc1	a1,\$f26
[ 0-9a-f]+:	54bb 243b 	dmfc1	a1,\$f27
[ 0-9a-f]+:	54bc 243b 	dmfc1	a1,\$f28
[ 0-9a-f]+:	54bd 243b 	dmfc1	a1,\$f29
[ 0-9a-f]+:	54be 243b 	dmfc1	a1,\$f30
[ 0-9a-f]+:	54bf 243b 	dmfc1	a1,\$f31
[ 0-9a-f]+:	54a0 243b 	dmfc1	a1,\$f0
[ 0-9a-f]+:	54a1 243b 	dmfc1	a1,\$f1
[ 0-9a-f]+:	54a2 243b 	dmfc1	a1,\$f2
[ 0-9a-f]+:	54a3 243b 	dmfc1	a1,\$f3
[ 0-9a-f]+:	54a4 243b 	dmfc1	a1,\$f4
[ 0-9a-f]+:	54a5 243b 	dmfc1	a1,\$f5
[ 0-9a-f]+:	54a6 243b 	dmfc1	a1,\$f6
[ 0-9a-f]+:	54a7 243b 	dmfc1	a1,\$f7
[ 0-9a-f]+:	54a8 243b 	dmfc1	a1,\$f8
[ 0-9a-f]+:	54a9 243b 	dmfc1	a1,\$f9
[ 0-9a-f]+:	54aa 243b 	dmfc1	a1,\$f10
[ 0-9a-f]+:	54ab 243b 	dmfc1	a1,\$f11
[ 0-9a-f]+:	54ac 243b 	dmfc1	a1,\$f12
[ 0-9a-f]+:	54ad 243b 	dmfc1	a1,\$f13
[ 0-9a-f]+:	54ae 243b 	dmfc1	a1,\$f14
[ 0-9a-f]+:	54af 243b 	dmfc1	a1,\$f15
[ 0-9a-f]+:	54b0 243b 	dmfc1	a1,\$f16
[ 0-9a-f]+:	54b1 243b 	dmfc1	a1,\$f17
[ 0-9a-f]+:	54b2 243b 	dmfc1	a1,\$f18
[ 0-9a-f]+:	54b3 243b 	dmfc1	a1,\$f19
[ 0-9a-f]+:	54b4 243b 	dmfc1	a1,\$f20
[ 0-9a-f]+:	54b5 243b 	dmfc1	a1,\$f21
[ 0-9a-f]+:	54b6 243b 	dmfc1	a1,\$f22
[ 0-9a-f]+:	54b7 243b 	dmfc1	a1,\$f23
[ 0-9a-f]+:	54b8 243b 	dmfc1	a1,\$f24
[ 0-9a-f]+:	54b9 243b 	dmfc1	a1,\$f25
[ 0-9a-f]+:	54ba 243b 	dmfc1	a1,\$f26
[ 0-9a-f]+:	54bb 243b 	dmfc1	a1,\$f27
[ 0-9a-f]+:	54bc 243b 	dmfc1	a1,\$f28
[ 0-9a-f]+:	54bd 243b 	dmfc1	a1,\$f29
[ 0-9a-f]+:	54be 243b 	dmfc1	a1,\$f30
[ 0-9a-f]+:	54bf 243b 	dmfc1	a1,\$f31
[ 0-9a-f]+:	54a0 2c3b 	dmtc1	a1,c1_fir
[ 0-9a-f]+:	54a1 2c3b 	dmtc1	a1,c1_ufr
[ 0-9a-f]+:	54a2 2c3b 	dmtc1	a1,\$2
[ 0-9a-f]+:	54a3 2c3b 	dmtc1	a1,\$3
[ 0-9a-f]+:	54a4 2c3b 	dmtc1	a1,c1_unfr
[ 0-9a-f]+:	54a5 2c3b 	dmtc1	a1,\$5
[ 0-9a-f]+:	54a6 2c3b 	dmtc1	a1,\$6
[ 0-9a-f]+:	54a7 2c3b 	dmtc1	a1,\$7
[ 0-9a-f]+:	54a8 2c3b 	dmtc1	a1,\$8
[ 0-9a-f]+:	54a9 2c3b 	dmtc1	a1,\$9
[ 0-9a-f]+:	54aa 2c3b 	dmtc1	a1,\$10
[ 0-9a-f]+:	54ab 2c3b 	dmtc1	a1,\$11
[ 0-9a-f]+:	54ac 2c3b 	dmtc1	a1,\$12
[ 0-9a-f]+:	54ad 2c3b 	dmtc1	a1,\$13
[ 0-9a-f]+:	54ae 2c3b 	dmtc1	a1,\$14
[ 0-9a-f]+:	54af 2c3b 	dmtc1	a1,\$15
[ 0-9a-f]+:	54b0 2c3b 	dmtc1	a1,\$16
[ 0-9a-f]+:	54b1 2c3b 	dmtc1	a1,\$17
[ 0-9a-f]+:	54b2 2c3b 	dmtc1	a1,\$18
[ 0-9a-f]+:	54b3 2c3b 	dmtc1	a1,\$19
[ 0-9a-f]+:	54b4 2c3b 	dmtc1	a1,\$20
[ 0-9a-f]+:	54b5 2c3b 	dmtc1	a1,\$21
[ 0-9a-f]+:	54b6 2c3b 	dmtc1	a1,\$22
[ 0-9a-f]+:	54b7 2c3b 	dmtc1	a1,\$23
[ 0-9a-f]+:	54b8 2c3b 	dmtc1	a1,\$24
[ 0-9a-f]+:	54b9 2c3b 	dmtc1	a1,c1_fccr
[ 0-9a-f]+:	54ba 2c3b 	dmtc1	a1,c1_fexr
[ 0-9a-f]+:	54bb 2c3b 	dmtc1	a1,\$27
[ 0-9a-f]+:	54bc 2c3b 	dmtc1	a1,c1_fenr
[ 0-9a-f]+:	54bd 2c3b 	dmtc1	a1,\$29
[ 0-9a-f]+:	54be 2c3b 	dmtc1	a1,\$30
[ 0-9a-f]+:	54bf 2c3b 	dmtc1	a1,c1_fcsr
[ 0-9a-f]+:	54a0 2c3b 	dmtc1	a1,c1_fir
[ 0-9a-f]+:	54a1 2c3b 	dmtc1	a1,c1_ufr
[ 0-9a-f]+:	54a2 2c3b 	dmtc1	a1,\$2
[ 0-9a-f]+:	54a3 2c3b 	dmtc1	a1,\$3
[ 0-9a-f]+:	54a4 2c3b 	dmtc1	a1,c1_unfr
[ 0-9a-f]+:	54a5 2c3b 	dmtc1	a1,\$5
[ 0-9a-f]+:	54a6 2c3b 	dmtc1	a1,\$6
[ 0-9a-f]+:	54a7 2c3b 	dmtc1	a1,\$7
[ 0-9a-f]+:	54a8 2c3b 	dmtc1	a1,\$8
[ 0-9a-f]+:	54a9 2c3b 	dmtc1	a1,\$9
[ 0-9a-f]+:	54aa 2c3b 	dmtc1	a1,\$10
[ 0-9a-f]+:	54ab 2c3b 	dmtc1	a1,\$11
[ 0-9a-f]+:	54ac 2c3b 	dmtc1	a1,\$12
[ 0-9a-f]+:	54ad 2c3b 	dmtc1	a1,\$13
[ 0-9a-f]+:	54ae 2c3b 	dmtc1	a1,\$14
[ 0-9a-f]+:	54af 2c3b 	dmtc1	a1,\$15
[ 0-9a-f]+:	54b0 2c3b 	dmtc1	a1,\$16
[ 0-9a-f]+:	54b1 2c3b 	dmtc1	a1,\$17
[ 0-9a-f]+:	54b2 2c3b 	dmtc1	a1,\$18
[ 0-9a-f]+:	54b3 2c3b 	dmtc1	a1,\$19
[ 0-9a-f]+:	54b4 2c3b 	dmtc1	a1,\$20
[ 0-9a-f]+:	54b5 2c3b 	dmtc1	a1,\$21
[ 0-9a-f]+:	54b6 2c3b 	dmtc1	a1,\$22
[ 0-9a-f]+:	54b7 2c3b 	dmtc1	a1,\$23
[ 0-9a-f]+:	54b8 2c3b 	dmtc1	a1,\$24
[ 0-9a-f]+:	54b9 2c3b 	dmtc1	a1,c1_fccr
[ 0-9a-f]+:	54ba 2c3b 	dmtc1	a1,c1_fexr
[ 0-9a-f]+:	54bb 2c3b 	dmtc1	a1,\$27
[ 0-9a-f]+:	54bc 2c3b 	dmtc1	a1,c1_fenr
[ 0-9a-f]+:	54bd 2c3b 	dmtc1	a1,\$29
[ 0-9a-f]+:	54be 2c3b 	dmtc1	a1,\$30
[ 0-9a-f]+:	54bf 2c3b 	dmtc1	a1,c1_fcsr
[ 0-9a-f]+:	0040 6d3c 	dmfc2	v0,\$0
[ 0-9a-f]+:	0041 6d3c 	dmfc2	v0,\$1
[ 0-9a-f]+:	0042 6d3c 	dmfc2	v0,\$2
[ 0-9a-f]+:	0043 6d3c 	dmfc2	v0,\$3
[ 0-9a-f]+:	0044 6d3c 	dmfc2	v0,\$4
[ 0-9a-f]+:	0045 6d3c 	dmfc2	v0,\$5
[ 0-9a-f]+:	0046 6d3c 	dmfc2	v0,\$6
[ 0-9a-f]+:	0047 6d3c 	dmfc2	v0,\$7
[ 0-9a-f]+:	0048 6d3c 	dmfc2	v0,\$8
[ 0-9a-f]+:	0049 6d3c 	dmfc2	v0,\$9
[ 0-9a-f]+:	004a 6d3c 	dmfc2	v0,\$10
[ 0-9a-f]+:	004b 6d3c 	dmfc2	v0,\$11
[ 0-9a-f]+:	004c 6d3c 	dmfc2	v0,\$12
[ 0-9a-f]+:	004d 6d3c 	dmfc2	v0,\$13
[ 0-9a-f]+:	004e 6d3c 	dmfc2	v0,\$14
[ 0-9a-f]+:	004f 6d3c 	dmfc2	v0,\$15
[ 0-9a-f]+:	0050 6d3c 	dmfc2	v0,\$16
[ 0-9a-f]+:	0051 6d3c 	dmfc2	v0,\$17
[ 0-9a-f]+:	0052 6d3c 	dmfc2	v0,\$18
[ 0-9a-f]+:	0053 6d3c 	dmfc2	v0,\$19
[ 0-9a-f]+:	0054 6d3c 	dmfc2	v0,\$20
[ 0-9a-f]+:	0055 6d3c 	dmfc2	v0,\$21
[ 0-9a-f]+:	0056 6d3c 	dmfc2	v0,\$22
[ 0-9a-f]+:	0057 6d3c 	dmfc2	v0,\$23
[ 0-9a-f]+:	0058 6d3c 	dmfc2	v0,\$24
[ 0-9a-f]+:	0059 6d3c 	dmfc2	v0,\$25
[ 0-9a-f]+:	005a 6d3c 	dmfc2	v0,\$26
[ 0-9a-f]+:	005b 6d3c 	dmfc2	v0,\$27
[ 0-9a-f]+:	005c 6d3c 	dmfc2	v0,\$28
[ 0-9a-f]+:	005d 6d3c 	dmfc2	v0,\$29
[ 0-9a-f]+:	005e 6d3c 	dmfc2	v0,\$30
[ 0-9a-f]+:	005f 6d3c 	dmfc2	v0,\$31
[ 0-9a-f]+:	0040 7d3c 	dmtc2	v0,\$0
[ 0-9a-f]+:	0041 7d3c 	dmtc2	v0,\$1
[ 0-9a-f]+:	0042 7d3c 	dmtc2	v0,\$2
[ 0-9a-f]+:	0043 7d3c 	dmtc2	v0,\$3
[ 0-9a-f]+:	0044 7d3c 	dmtc2	v0,\$4
[ 0-9a-f]+:	0045 7d3c 	dmtc2	v0,\$5
[ 0-9a-f]+:	0046 7d3c 	dmtc2	v0,\$6
[ 0-9a-f]+:	0047 7d3c 	dmtc2	v0,\$7
[ 0-9a-f]+:	0048 7d3c 	dmtc2	v0,\$8
[ 0-9a-f]+:	0049 7d3c 	dmtc2	v0,\$9
[ 0-9a-f]+:	004a 7d3c 	dmtc2	v0,\$10
[ 0-9a-f]+:	004b 7d3c 	dmtc2	v0,\$11
[ 0-9a-f]+:	004c 7d3c 	dmtc2	v0,\$12
[ 0-9a-f]+:	004d 7d3c 	dmtc2	v0,\$13
[ 0-9a-f]+:	004e 7d3c 	dmtc2	v0,\$14
[ 0-9a-f]+:	004f 7d3c 	dmtc2	v0,\$15
[ 0-9a-f]+:	0050 7d3c 	dmtc2	v0,\$16
[ 0-9a-f]+:	0051 7d3c 	dmtc2	v0,\$17
[ 0-9a-f]+:	0052 7d3c 	dmtc2	v0,\$18
[ 0-9a-f]+:	0053 7d3c 	dmtc2	v0,\$19
[ 0-9a-f]+:	0054 7d3c 	dmtc2	v0,\$20
[ 0-9a-f]+:	0055 7d3c 	dmtc2	v0,\$21
[ 0-9a-f]+:	0056 7d3c 	dmtc2	v0,\$22
[ 0-9a-f]+:	0057 7d3c 	dmtc2	v0,\$23
[ 0-9a-f]+:	0058 7d3c 	dmtc2	v0,\$24
[ 0-9a-f]+:	0059 7d3c 	dmtc2	v0,\$25
[ 0-9a-f]+:	005a 7d3c 	dmtc2	v0,\$26
[ 0-9a-f]+:	005b 7d3c 	dmtc2	v0,\$27
[ 0-9a-f]+:	005c 7d3c 	dmtc2	v0,\$28
[ 0-9a-f]+:	005d 7d3c 	dmtc2	v0,\$29
[ 0-9a-f]+:	005e 7d3c 	dmtc2	v0,\$30
[ 0-9a-f]+:	005f 7d3c 	dmtc2	v0,\$31
[ 0-9a-f]+:	5883 1018 	dmul	v0,v1,a0
[ 0-9a-f]+:	5880 11d0 	dnegu	v0,a0
[ 0-9a-f]+:	5862 10d0 	drorv	v0,v1,v0
[ 0-9a-f]+:	5880 09d0 	dnegu	at,a0
[ 0-9a-f]+:	5841 10d0 	drorv	v0,v0,at
[ 0-9a-f]+:	5843 e0c8 	dror32	v0,v1,0x1c
[ 0-9a-f]+:	5864 10d0 	drorv	v0,v1,a0
[ 0-9a-f]+:	5843 20c0 	dror	v0,v1,0x4
[ 0-9a-f]+:	5843 20c8 	dror32	v0,v1,0x4
[ 0-9a-f]+:	5864 10d0 	drorv	v0,v1,a0
[ 0-9a-f]+:	5843 20c8 	dror32	v0,v1,0x4
[ 0-9a-f]+:	5880 11d0 	dnegu	v0,a0
[ 0-9a-f]+:	5862 10d0 	drorv	v0,v1,v0
[ 0-9a-f]+:	5880 09d0 	dnegu	at,a0
[ 0-9a-f]+:	5841 10d0 	drorv	v0,v0,at
[ 0-9a-f]+:	5843 e0c8 	dror32	v0,v1,0x1c
[ 0-9a-f]+:	5864 10d0 	drorv	v0,v1,a0
[ 0-9a-f]+:	5843 20c0 	dror	v0,v1,0x4
[ 0-9a-f]+:	5843 20c8 	dror32	v0,v1,0x4
[ 0-9a-f]+:	5864 10d0 	drorv	v0,v1,a0
[ 0-9a-f]+:	5843 20c8 	dror32	v0,v1,0x4
[ 0-9a-f]+:	5843 7b3c 	dsbh	v0,v1
[ 0-9a-f]+:	5842 7b3c 	dsbh	v0,v0
[ 0-9a-f]+:	5842 7b3c 	dsbh	v0,v0
[ 0-9a-f]+:	5843 fb3c 	dshd	v0,v1
[ 0-9a-f]+:	5842 fb3c 	dshd	v0,v0
[ 0-9a-f]+:	5842 fb3c 	dshd	v0,v0
[ 0-9a-f]+:	5864 1010 	dsllv	v0,v1,a0
[ 0-9a-f]+:	5843 f808 	dsll32	v0,v1,0x1f
[ 0-9a-f]+:	5864 1010 	dsllv	v0,v1,a0
[ 0-9a-f]+:	5843 f808 	dsll32	v0,v1,0x1f
[ 0-9a-f]+:	5843 f800 	dsll	v0,v1,0x1f
[ 0-9a-f]+:	5864 1090 	dsrav	v0,v1,a0
[ 0-9a-f]+:	5843 2088 	dsra32	v0,v1,0x4
[ 0-9a-f]+:	5864 1090 	dsrav	v0,v1,a0
[ 0-9a-f]+:	5843 2088 	dsra32	v0,v1,0x4
[ 0-9a-f]+:	5843 2080 	dsra	v0,v1,0x4
[ 0-9a-f]+:	5864 1050 	dsrlv	v0,v1,a0
[ 0-9a-f]+:	5843 f848 	dsrl32	v0,v1,0x1f
[ 0-9a-f]+:	5864 1050 	dsrlv	v0,v1,a0
[ 0-9a-f]+:	5843 2048 	dsrl32	v0,v1,0x4
[ 0-9a-f]+:	5843 2040 	dsrl	v0,v1,0x4
[ 0-9a-f]+:	5883 1190 	dsub	v0,v1,a0
[ 0-9a-f]+:	5bfe e990 	dsub	sp,s8,ra
[ 0-9a-f]+:	5862 1190 	dsub	v0,v0,v1
[ 0-9a-f]+:	5862 1190 	dsub	v0,v0,v1
[ 0-9a-f]+:	5883 11d0 	dsubu	v0,v1,a0
[ 0-9a-f]+:	5bfe e9d0 	dsubu	sp,s8,ra
[ 0-9a-f]+:	5862 11d0 	dsubu	v0,v0,v1
[ 0-9a-f]+:	5862 11d0 	dsubu	v0,v0,v1
[ 0-9a-f]+:	5c43 edcc 	daddiu	v0,v1,-4660
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5678 	ori	at,at,0x5678
[ 0-9a-f]+:	5823 11d0 	dsubu	v0,v1,at
[ 0-9a-f]+:	dc40 0000 	ld	v0,0\(zero\)
[ 0-9a-f]+:	dc40 0004 	ld	v0,4\(zero\)
[ 0-9a-f]+:	dc40 0000 	ld	v0,0\(zero\)
[ 0-9a-f]+:	dc40 0000 	ld	v0,0\(zero\)
[ 0-9a-f]+:	dc40 0004 	ld	v0,4\(zero\)
[ 0-9a-f]+:	dc43 0004 	ld	v0,4\(v1\)
[ 0-9a-f]+:	dc43 8000 	ld	v0,-32768\(v1\)
[ 0-9a-f]+:	dc43 7fff 	ld	v0,32767\(v1\)
[ 0-9a-f]+:	6040 7000 	lld	v0,0\(zero\)
[ 0-9a-f]+:	6040 7004 	lld	v0,4\(zero\)
[ 0-9a-f]+:	6040 7000 	lld	v0,0\(zero\)
[ 0-9a-f]+:	6040 7000 	lld	v0,0\(zero\)
[ 0-9a-f]+:	6040 7004 	lld	v0,4\(zero\)
[ 0-9a-f]+:	6043 7004 	lld	v0,4\(v1\)
[ 0-9a-f]+:	6043 7100 	lld	v0,-256\(v1\)
[ 0-9a-f]+:	6043 70ff 	lld	v0,255\(v1\)
[ 0-9a-f]+:	3043 8000 	addiu	v0,v1,-32768
[ 0-9a-f]+:	6042 7000 	lld	v0,0\(v0\)
[ 0-9a-f]+:	1040 1234 	lui	v0,0x1234
[ 0-9a-f]+:	5042 5600 	ori	v0,v0,0x5600
[ 0-9a-f]+:	0062 1150 	addu	v0,v0,v1
[ 0-9a-f]+:	6042 7078 	lld	v0,120\(v0\)
[ 0-9a-f]+:	6040 e000 	lwu	v0,0\(zero\)
[ 0-9a-f]+:	6040 e004 	lwu	v0,4\(zero\)
[ 0-9a-f]+:	6040 e000 	lwu	v0,0\(zero\)
[ 0-9a-f]+:	6040 e000 	lwu	v0,0\(zero\)
[ 0-9a-f]+:	6040 e004 	lwu	v0,4\(zero\)
[ 0-9a-f]+:	6043 e004 	lwu	v0,4\(v1\)
[ 0-9a-f]+:	6043 ee00 	lwu	v0,-512\(v1\)
[ 0-9a-f]+:	6043 e1ff 	lwu	v0,511\(v1\)
[ 0-9a-f]+:	3043 8000 	addiu	v0,v1,-32768
[ 0-9a-f]+:	6042 e000 	lwu	v0,0\(v0\)
[ 0-9a-f]+:	1040 1234 	lui	v0,0x1234
[ 0-9a-f]+:	5042 5000 	ori	v0,v0,0x5000
[ 0-9a-f]+:	0062 1150 	addu	v0,v0,v1
[ 0-9a-f]+:	6042 e678 	lwu	v0,1656\(v0\)
[ 0-9a-f]+:	6040 f000 	scd	v0,0\(zero\)
[ 0-9a-f]+:	6040 f004 	scd	v0,4\(zero\)
[ 0-9a-f]+:	6040 f000 	scd	v0,0\(zero\)
[ 0-9a-f]+:	6040 f000 	scd	v0,0\(zero\)
[ 0-9a-f]+:	6040 f004 	scd	v0,4\(zero\)
[ 0-9a-f]+:	6043 f004 	scd	v0,4\(v1\)
[ 0-9a-f]+:	6043 f100 	scd	v0,-256\(v1\)
[ 0-9a-f]+:	6043 f0ff 	scd	v0,255\(v1\)
[ 0-9a-f]+:	3023 8000 	addiu	at,v1,-32768
[ 0-9a-f]+:	6041 f000 	scd	v0,0\(at\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5600 	ori	at,at,0x5600
[ 0-9a-f]+:	0061 0950 	addu	at,at,v1
[ 0-9a-f]+:	6041 f078 	scd	v0,120\(at\)
[ 0-9a-f]+:	d840 0000 	sd	v0,0\(zero\)
[ 0-9a-f]+:	d840 0004 	sd	v0,4\(zero\)
[ 0-9a-f]+:	d840 0000 	sd	v0,0\(zero\)
[ 0-9a-f]+:	d840 0000 	sd	v0,0\(zero\)
[ 0-9a-f]+:	d840 0004 	sd	v0,4\(zero\)
[ 0-9a-f]+:	d843 0004 	sd	v0,4\(v1\)
[ 0-9a-f]+:	d843 8000 	sd	v0,-32768\(v1\)
[ 0-9a-f]+:	d843 7fff 	sd	v0,32767\(v1\)
[ 0-9a-f]+:	2020 7000 	ldm	s0,0\(zero\)
[ 0-9a-f]+:	2020 7004 	ldm	s0,4\(zero\)
[ 0-9a-f]+:	2025 7000 	ldm	s0,0\(a1\)
[ 0-9a-f]+:	2025 77ff 	ldm	s0,2047\(a1\)
[ 0-9a-f]+:	2045 77ff 	ldm	s0-s1,2047\(a1\)
[ 0-9a-f]+:	2065 77ff 	ldm	s0-s2,2047\(a1\)
[ 0-9a-f]+:	2085 77ff 	ldm	s0-s3,2047\(a1\)
[ 0-9a-f]+:	20a5 77ff 	ldm	s0-s4,2047\(a1\)
[ 0-9a-f]+:	20c5 77ff 	ldm	s0-s5,2047\(a1\)
[ 0-9a-f]+:	20e5 77ff 	ldm	s0-s6,2047\(a1\)
[ 0-9a-f]+:	2105 77ff 	ldm	s0-s7,2047\(a1\)
[ 0-9a-f]+:	2125 77ff 	ldm	s0-s7,s8,2047\(a1\)
[ 0-9a-f]+:	2205 77ff 	ldm	ra,2047\(a1\)
[ 0-9a-f]+:	2225 7000 	ldm	s0,ra,0\(a1\)
[ 0-9a-f]+:	2245 7000 	ldm	s0-s1,ra,0\(a1\)
[ 0-9a-f]+:	2265 7000 	ldm	s0-s2,ra,0\(a1\)
[ 0-9a-f]+:	2285 7000 	ldm	s0-s3,ra,0\(a1\)
[ 0-9a-f]+:	22a5 7000 	ldm	s0-s4,ra,0\(a1\)
[ 0-9a-f]+:	22c5 7000 	ldm	s0-s5,ra,0\(a1\)
[ 0-9a-f]+:	22e5 7000 	ldm	s0-s6,ra,0\(a1\)
[ 0-9a-f]+:	2305 7000 	ldm	s0-s7,ra,0\(a1\)
[ 0-9a-f]+:	2325 7000 	ldm	s0-s7,s8,ra,0\(a1\)
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	2021 7000 	ldm	s0,0\(at\)
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	2021 7000 	ldm	s0,0\(at\)
[ 0-9a-f]+:	2020 7000 	ldm	s0,0\(zero\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	2021 7fff 	ldm	s0,-1\(at\)
[ 0-9a-f]+:	303d 8000 	addiu	at,sp,-32768
[ 0-9a-f]+:	2021 7000 	ldm	s0,0\(at\)
[ 0-9a-f]+:	303d 7fff 	addiu	at,sp,32767
[ 0-9a-f]+:	2021 7000 	ldm	s0,0\(at\)
[ 0-9a-f]+:	203d 7000 	ldm	s0,0\(sp\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	03a1 0950 	addu	at,at,sp
[ 0-9a-f]+:	2021 7fff 	ldm	s0,-1\(at\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5000 	ori	at,at,0x5000
[ 0-9a-f]+:	03a1 0950 	addu	at,at,sp
[ 0-9a-f]+:	2021 7678 	ldm	s0,1656\(at\)
[ 0-9a-f]+:	2040 4000 	ldp	v0,0\(zero\)
[ 0-9a-f]+:	2040 4004 	ldp	v0,4\(zero\)
[ 0-9a-f]+:	205d 4000 	ldp	v0,0\(sp\)
[ 0-9a-f]+:	205d 4000 	ldp	v0,0\(sp\)
[ 0-9a-f]+:	2043 4800 	ldp	v0,-2048\(v1\)
[ 0-9a-f]+:	2043 47ff 	ldp	v0,2047\(v1\)
[ 0-9a-f]+:	3023 8000 	addiu	at,v1,-32768
[ 0-9a-f]+:	2041 4000 	ldp	v0,0\(at\)
[ 0-9a-f]+:	3023 7fff 	addiu	at,v1,32767
[ 0-9a-f]+:	2041 4000 	ldp	v0,0\(at\)
[ 0-9a-f]+:	2043 4000 	ldp	v0,0\(v1\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0061 0950 	addu	at,at,v1
[ 0-9a-f]+:	2041 4fff 	ldp	v0,-1\(at\)
[ 0-9a-f]+:	3060 8000 	li	v1,-32768
[ 0-9a-f]+:	2043 4000 	ldp	v0,0\(v1\)
[ 0-9a-f]+:	3060 7fff 	li	v1,32767
[ 0-9a-f]+:	2043 4000 	ldp	v0,0\(v1\)
[ 0-9a-f]+:	1060 0001 	lui	v1,0x1
[ 0-9a-f]+:	2043 4fff 	ldp	v0,-1\(v1\)
[ 0-9a-f]+:	1060 1234 	lui	v1,0x1234
[ 0-9a-f]+:	5063 5000 	ori	v1,v1,0x5000
[ 0-9a-f]+:	2043 4678 	ldp	v0,1656\(v1\)
[ 0-9a-f]+:	2020 f000 	sdm	s0,0\(zero\)
[ 0-9a-f]+:	2020 f004 	sdm	s0,4\(zero\)
[ 0-9a-f]+:	2025 f000 	sdm	s0,0\(a1\)
[ 0-9a-f]+:	2025 f7ff 	sdm	s0,2047\(a1\)
[ 0-9a-f]+:	2045 f7ff 	sdm	s0-s1,2047\(a1\)
[ 0-9a-f]+:	2065 f7ff 	sdm	s0-s2,2047\(a1\)
[ 0-9a-f]+:	2085 f7ff 	sdm	s0-s3,2047\(a1\)
[ 0-9a-f]+:	20a5 f7ff 	sdm	s0-s4,2047\(a1\)
[ 0-9a-f]+:	20c5 f7ff 	sdm	s0-s5,2047\(a1\)
[ 0-9a-f]+:	20e5 f7ff 	sdm	s0-s6,2047\(a1\)
[ 0-9a-f]+:	2105 f7ff 	sdm	s0-s7,2047\(a1\)
[ 0-9a-f]+:	2125 f7ff 	sdm	s0-s7,s8,2047\(a1\)
[ 0-9a-f]+:	2205 f7ff 	sdm	ra,2047\(a1\)
[ 0-9a-f]+:	2225 f000 	sdm	s0,ra,0\(a1\)
[ 0-9a-f]+:	2245 f000 	sdm	s0-s1,ra,0\(a1\)
[ 0-9a-f]+:	2265 f000 	sdm	s0-s2,ra,0\(a1\)
[ 0-9a-f]+:	2285 f000 	sdm	s0-s3,ra,0\(a1\)
[ 0-9a-f]+:	22a5 f000 	sdm	s0-s4,ra,0\(a1\)
[ 0-9a-f]+:	22c5 f000 	sdm	s0-s5,ra,0\(a1\)
[ 0-9a-f]+:	22e5 f000 	sdm	s0-s6,ra,0\(a1\)
[ 0-9a-f]+:	2305 f000 	sdm	s0-s7,ra,0\(a1\)
[ 0-9a-f]+:	2325 f000 	sdm	s0-s7,s8,ra,0\(a1\)
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	2021 f000 	sdm	s0,0\(at\)
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	2021 f000 	sdm	s0,0\(at\)
[ 0-9a-f]+:	2020 f000 	sdm	s0,0\(zero\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	2021 ffff 	sdm	s0,-1\(at\)
[ 0-9a-f]+:	303d 8000 	addiu	at,sp,-32768
[ 0-9a-f]+:	2021 f000 	sdm	s0,0\(at\)
[ 0-9a-f]+:	303d 7fff 	addiu	at,sp,32767
[ 0-9a-f]+:	2021 f000 	sdm	s0,0\(at\)
[ 0-9a-f]+:	203d f000 	sdm	s0,0\(sp\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	03a1 0950 	addu	at,at,sp
[ 0-9a-f]+:	2021 ffff 	sdm	s0,-1\(at\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5000 	ori	at,at,0x5000
[ 0-9a-f]+:	03a1 0950 	addu	at,at,sp
[ 0-9a-f]+:	2021 f678 	sdm	s0,1656\(at\)
[ 0-9a-f]+:	2040 c000 	sdp	v0,0\(zero\)
[ 0-9a-f]+:	2040 c004 	sdp	v0,4\(zero\)
[ 0-9a-f]+:	205d c000 	sdp	v0,0\(sp\)
[ 0-9a-f]+:	205d c000 	sdp	v0,0\(sp\)
[ 0-9a-f]+:	2043 c800 	sdp	v0,-2048\(v1\)
[ 0-9a-f]+:	2043 c7ff 	sdp	v0,2047\(v1\)
[ 0-9a-f]+:	3023 8000 	addiu	at,v1,-32768
[ 0-9a-f]+:	2041 c000 	sdp	v0,0\(at\)
[ 0-9a-f]+:	3023 7fff 	addiu	at,v1,32767
[ 0-9a-f]+:	2041 c000 	sdp	v0,0\(at\)
[ 0-9a-f]+:	2043 c000 	sdp	v0,0\(v1\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	0061 0950 	addu	at,at,v1
[ 0-9a-f]+:	2041 cfff 	sdp	v0,-1\(at\)
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	2041 c000 	sdp	v0,0\(at\)
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	2041 c000 	sdp	v0,0\(at\)
[ 0-9a-f]+:	1020 0001 	lui	at,0x1
[ 0-9a-f]+:	2041 cfff 	sdp	v0,-1\(at\)
[ 0-9a-f]+:	1020 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5000 	ori	at,at,0x5000
[ 0-9a-f]+:	2041 c678 	sdp	v0,1656\(at\)
[ 0-9a-f]+:	3203 0000 	addiu	s0,v1,0
[	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	6210 7000 	lld	s0,0\(s0\)
[ 0-9a-f]+:	3203 0000 	addiu	s0,v1,0
[	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	6210 e000 	lwu	s0,0\(s0\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	6201 f000 	scd	s0,0\(at\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	2021 7000 	ldm	s0,0\(at\)
[ 0-9a-f]+:	3223 0000 	addiu	s1,v1,0
[	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	2211 4000 	ldp	s0,0\(s1\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	2021 f000 	sdm	s0,0\(at\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	2201 c000 	sdp	s0,0\(at\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	2201 2000 	ldc2	\$16,0\(at\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	2201 a000 	sdc2	\$16,0\(at\)

[ 0-9a-f]+ <test_delay_slot>:
[ 0-9a-f]+:	b7ff fffe 	balc	[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	test_delay_slot
[ 0-9a-f]+:	c063 fffe 	bgezalc	v1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	test_delay_slot
[ 0-9a-f]+:	e063 fffe 	bltzalc	v1,[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	test_delay_slot
[ 0-9a-f]+:	b7ff fffe 	balc	[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	test_delay_slot
[ 0-9a-f]+:	444b      	jalrc	v0
[ 0-9a-f]+:	03e2 0f3c 	jalrc	v0
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	4443      	jrc	v0
[ 0-9a-f]+:	8002 0000 	jrc	v0
[ 0-9a-f]+:	03e2 1f3c 	jalrc.hb	v0
[ 0-9a-f]+:	0002 1f3c 	jrc.hb	v0
[ 0-9a-f]+:	b7ff fffe 	balc	[0-9a-f]+ <.*>
[	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	test_delay_slot
[ 0-9a-f]+:	444b      	jalrc	v0
[ 0-9a-f]+:	03e2 0f3c 	jalrc	v0

[ 0-9a-f]+ <test_spec102>:
[ 0-9a-f]+:	6540      	lw	v0,-256\(gp\)
[ 0-9a-f]+:	65c0      	lw	v1,-256\(gp\)
[ 0-9a-f]+:	6640      	lw	a0,-256\(gp\)
[ 0-9a-f]+:	66c0      	lw	a1,-256\(gp\)
[ 0-9a-f]+:	6740      	lw	a2,-256\(gp\)
[ 0-9a-f]+:	67c0      	lw	a3,-256\(gp\)
[ 0-9a-f]+:	6440      	lw	s0,-256\(gp\)
[ 0-9a-f]+:	64c0      	lw	s1,-256\(gp\)
[ 0-9a-f]+:	64c1      	lw	s1,-252\(gp\)
[ 0-9a-f]+:	64ff      	lw	s1,-4\(gp\)
[ 0-9a-f]+:	6480      	lw	s1,0\(gp\)
[ 0-9a-f]+:	6481      	lw	s1,4\(gp\)
[ 0-9a-f]+:	64be      	lw	s1,248\(gp\)
[ 0-9a-f]+:	64bf      	lw	s1,252\(gp\)
[ 0-9a-f]+:	fe3c 0100 	lw	s1,256\(gp\)
[ 0-9a-f]+:	fe3c fefc 	lw	s1,-260\(gp\)
[ 0-9a-f]+:	fe3c 0001 	lw	s1,1\(gp\)
[ 0-9a-f]+:	fe3c 0002 	lw	s1,2\(gp\)
[ 0-9a-f]+:	fe3c 0003 	lw	s1,3\(gp\)
[ 0-9a-f]+:	fe3c ffff 	lw	s1,-1\(gp\)
[ 0-9a-f]+:	fe3c fffe 	lw	s1,-2\(gp\)
[ 0-9a-f]+:	fe3c fffd 	lw	s1,-3\(gp\)
[ 0-9a-f]+:	fe3b 0000 	lw	s1,0\(k1\)
[ 0-9a-f]+:	7840 0000 	lapc	v0,[0-9a-f]+ <.*>
[ 0-9a-f]+:	7860 0000 	lapc	v1,[0-9a-f]+ <.*>
[ 0-9a-f]+:	7880 0000 	lapc	a0,[0-9a-f]+ <.*>
[ 0-9a-f]+:	78a0 0000 	lapc	a1,[0-9a-f]+ <.*>
[ 0-9a-f]+:	78c0 0000 	lapc	a2,[0-9a-f]+ <.*>
[ 0-9a-f]+:	78e0 0000 	lapc	a3,[0-9a-f]+ <.*>
[ 0-9a-f]+:	7a00 0000 	lapc	s0,[0-9a-f]+ <.*>
[ 0-9a-f]+:	7a20 0000 	lapc	s1,[0-9a-f]+ <.*>
[ 0-9a-f]+:	7a23 ffff 	lapc	s1,[0-9a-f]+ <.*>
[ 0-9a-f]+:	7a24 0000 	lapc	s1,[0-9a-f]+ <.*>
[ 0-9a-f]+:	7840 0000 	lapc	v0,[0-9a-f]+ <.*>
[ 0-9a-f]+:	7860 0000 	lapc	v1,[0-9a-f]+ <.*>
[ 0-9a-f]+:	7880 0000 	lapc	a0,[0-9a-f]+ <.*>
[ 0-9a-f]+:	78a0 0000 	lapc	a1,[0-9a-f]+ <.*>
[ 0-9a-f]+:	78c0 0000 	lapc	a2,[0-9a-f]+ <.*>
[ 0-9a-f]+:	78e0 0000 	lapc	a3,[0-9a-f]+ <.*>
[ 0-9a-f]+:	7a00 0000 	lapc	s0,[0-9a-f]+ <.*>
[ 0-9a-f]+:	7a20 0000 	lapc	s1,[0-9a-f]+ <.*>
[ 0-9a-f]+:	7a23 ffff 	lapc	s1,[0-9a-f]+ <.*>
[ 0-9a-f]+:	7a24 0000 	lapc	s1,[0-9a-f]+ <.*>

[ 0-9a-f]+ <test_spec107>:
[ 0-9a-f]+:	4404      	movep	a1,a2,zero,zero
[ 0-9a-f]+:	4484      	movep	a1,a3,zero,zero
[ 0-9a-f]+:	4504      	movep	a2,a3,zero,zero
[ 0-9a-f]+:	4584      	movep	a0,s5,zero,zero
[ 0-9a-f]+:	4604      	movep	a0,s6,zero,zero
[ 0-9a-f]+:	4684      	movep	a0,a1,zero,zero
[ 0-9a-f]+:	4704      	movep	a0,a2,zero,zero
[ 0-9a-f]+:	4784      	movep	a0,a3,zero,zero
[ 0-9a-f]+:	4785      	movep	a0,a3,s1,zero
[ 0-9a-f]+:	4786      	movep	a0,a3,v0,zero
[ 0-9a-f]+:	4787      	movep	a0,a3,v1,zero
[ 0-9a-f]+:	478c      	movep	a0,a3,s0,zero
[ 0-9a-f]+:	478d      	movep	a0,a3,s2,zero
[ 0-9a-f]+:	478e      	movep	a0,a3,s3,zero
[ 0-9a-f]+:	478f      	movep	a0,a3,s4,zero
[ 0-9a-f]+:	479f      	movep	a0,a3,s4,s1
[ 0-9a-f]+:	47af      	movep	a0,a3,s4,v0
[ 0-9a-f]+:	47bf      	movep	a0,a3,s4,v1
[ 0-9a-f]+:	47cf      	movep	a0,a3,s4,s0
[ 0-9a-f]+:	47df      	movep	a0,a3,s4,s2
[ 0-9a-f]+:	47ef      	movep	a0,a3,s4,s3
[ 0-9a-f]+:	47ff      	movep	a0,a3,s4,s4
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	0000 0000 	nop
