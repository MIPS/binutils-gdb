#objdump: -dr --show-raw-insn
#name: nanoMIPS 16-bit branch relaxation inhibited by insn32
#as: -minsn32 --defsym insn32=
#source: nanomips-relax.s

# Check nanoMIPS 16-bit branch relaxations inhibited by insn32

.*: +file format .*nanomips.*

Disassembly of section \.text:

[0-9a-f]+ <[^>]+>:
       0:	88a4 0000 	beqc	a0,a1,24 <[^>]+>
			0: R_NANOMIPS_PC14_S1	test1
	...

[0-9a-f]+ <[^>]+>:
      24:	2800 0000 	bc	428 <[^>]+>
			24: R_NANOMIPS_PC25_S1	test2
	...

[0-9a-f]+ <[^>]+>:
     428:	2800 0000 	bc	24 <[^>]+>
			428: R_NANOMIPS_PC25_S1	test1
     42c:	a885 0000 	bnec	a1,a0,450 <[^>]+>
			42c: R_NANOMIPS_PC14_S1	test3
	...

[0-9a-f]+ <[^>]+>:
     450:	88a4 0000 	beqc	a0,a1,428 <[^>]+>
			450: R_NANOMIPS_PC14_S1	test2
	...

[0-9a-f]+ <[^>]+>:
     474:	2a00 0000 	balc	878 <[^>]+>
			474: R_NANOMIPS_PC25_S1	test5
	...

[0-9a-f]+ <[^>]+>:
     878:	88a4 0000 	beqc	a0,a1,898 <[^>]+>
			878: R_NANOMIPS_PC14_S1	test6
	...

[0-9a-f]+ <[^>]+>:
     898:	2800 0000 	bc	c98 <[^>]+>
			898: R_NANOMIPS_PC25_S1	test7

[0-9a-f]+ <[^>]+>:
	...

[0-9a-f]+ <[^>]+>:
     c98:	2800 0000 	bc	89c <[^>]+>
			c98: R_NANOMIPS_PC25_S1	test6a
     c9c:	a885 0000 	bnec	a1,a0,cbc <[^>]+>
			c9c: R_NANOMIPS_PC14_S1	test8
	...

[0-9a-f]+ <[^>]+>:
	...

[0-9a-f]+ <[^>]+>:
    10ba:	2a00 0000 	balc	cbc <[^>]+>
			10ba: R_NANOMIPS_PC25_S1	test8
    10be:	88f1 0000 	beqc	s1,a3,10c2 <[^>]+>
			10be: R_NANOMIPS_PC14_S1	\$L1

[0-9a-f]+ <[^>]+>:
    10c2:	88f1 0000 	beqc	s1,a3,10ca <\$L2>
			10c2: R_NANOMIPS_PC14_S1	\$L2
    10c6:	83dd 8ff0 	addiu	fp,sp,-4080

000010ca <\$L2>:
    10ca:	8000 c000 	nop
	\.\.\.
