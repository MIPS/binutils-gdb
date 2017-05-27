#objdump: -dr --show-raw-insn
#name: nanoMIPS 16-bit branch relaxation

# Check nanoMIPS 16-bit branch relaxations

.*: +file format .*mips.*

Disassembly of section .text:

00000000 <test>:
       0:	88a4 0000 	beqc	a0,a1,24 <test1>
			0: R_NANOMIPS_PC14_S1	test1-0x4
	\.\.\.

00000024 <test1>:
      24:	2800 0000 	bc	428 <test2>
			24: R_NANOMIPS_PC25_S1	test2-0x4
	\.\.\.

00000428 <test2>:
     428:	2800 0000 	bc	24 <test1>
			428: R_NANOMIPS_PC25_S1	test1-0x4
     42c:	a885 0000 	bnec	a1,a0,450 <test3>
			42c: R_NANOMIPS_PC14_S1	test3-0x4
	\.\.\.

00000450 <test3>:
     450:	88a4 0000 	beqc	a0,a1,428 <test2>
			450: R_NANOMIPS_PC14_S1	test2-0x4
	\.\.\.

00000474 <test4>:
     474:	2a00 0000 	balc	878 <test5>
			474: R_NANOMIPS_PC25_S1	test5-0x4
	\.\.\.

00000878 <test5>:
     878:	dacf      	beqc	a0,a1,898 <test6>
			878: R_NANOMIPS_PC4_S1	test6-0x2
	\.\.\.

00000898 <test6>:
     898:	1800      	bc	c96 <test7>
			898: R_NANOMIPS_PC10_S1	test7-0x2
	\.\.\.

00000c96 <test7>:
     c96:	1800      	bc	898 <test6>
			c96: R_NANOMIPS_PC10_S1	test6-0x2
     c98:	da5f      	bnec	a1,a0,cb8 <test8>
			c98: R_NANOMIPS_PC4_S1	test8-0x2
	\.\.\.

00000cb8 <test8>:
	\.\.\.

000010b6 <test9>:
    10b6:	3800      	balc	cb8 <test8>
			10b6: R_NANOMIPS_PC10_S1	test8-0x2
    10b8:	db9f      	beqc	s1,a3,10ba <\$L1>
			10b8: R_NANOMIPS_PC4_S1	\$L1-0x2

000010ba <\$L1>:
    10ba:	9008      	nop
    10bc:	8000 c000 	nop
