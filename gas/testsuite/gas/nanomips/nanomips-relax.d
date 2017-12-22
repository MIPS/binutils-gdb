#objdump: -dr --show-raw-insn
#name: nanoMIPS 16-bit branch relaxation

# Check nanoMIPS 16-bit branch relaxations

.*: +file format .*mips.*

Disassembly of section .text:

00000000 <test>:
       0:	88a4 0000 	beqc	a0,a1,24 <test1>
			0: R_NANOMIPS_PC14_S1	test1
	\.\.\.

00000024 <test1>:
      24:	2800 0000 	bc	428 <test2>
			24: R_NANOMIPS_PC25_S1	test2
	\.\.\.

00000428 <test2>:
     428:	2800 0000 	bc	24 <test1>
			428: R_NANOMIPS_PC25_S1	test1
     42c:	a885 0000 	bnec	a1,a0,450 <test3>
			42c: R_NANOMIPS_PC14_S1	test3
	\.\.\.

00000450 <test3>:
     450:	88a4 0000 	beqc	a0,a1,428 <test2>
			450: R_NANOMIPS_PC14_S1	test2
	\.\.\.

00000474 <test4>:
     474:	2a00 0000 	balc	878 <test5>
			474: R_NANOMIPS_PC25_S1	test5
	\.\.\.

00000878 <test5>:
     878:	dacf      	beqc	a0,a1,896 <test6>
			878: R_NANOMIPS_PC4_S1	test6
	\.\.\.

00000896 <test6>:
     896:	1800      	bc	c94 <test7>
			896: R_NANOMIPS_PC10_S1	test7
00000898 <test6a>:
	\.\.\.

00000c94 <test7>:
     c94:	1800      	bc	898 <test6a>
			c94: R_NANOMIPS_PC10_S1	test6a
     c96:	da5f      	bnec	a1,a0,cb4 <test8>
			c96: R_NANOMIPS_PC4_S1	test8
	\.\.\.

00000cb4 <test8>:
	\.\.\.

000010b2 <test9>:
    10b2:	3800      	balc	cb4 <test8>
			10b2: R_NANOMIPS_PC10_S1	test8
    10b4:	88f1 0000 	beqc	s1,a3,10b8 <\$L1>
			10b4: R_NANOMIPS_PC14_S1	\$L1

000010b8 <\$L1>:
    10b8:	db9f      	beqc	s1,a3,10be <\$L2>
			10b8: R_NANOMIPS_PC4_S1	\$L2
    10ba:	83dd 8ff0 	addiu	fp,sp,-4080

000010be <\$L2>:
    10be:	9008      	nop
