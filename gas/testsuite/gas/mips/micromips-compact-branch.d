#objdump: -dr --no-show-raw-insn
#name: microMIPS compact branch selection
#as: -O3 -relax-branch
#source: micromips-compact-branch.s
#stderr: micromips-compact-branch.l

.*: +file format .*mips.*


Disassembly of section \.text:

0+0 <test>:
       0:	addu	v0,v1,a0
       2:	beqzc	v0,2 <test\+0x2>
			2: R_MICROMIPS_PC16_S1	test2
       6:	addu	v0,v1,a0
       8:	bnezc	v0,8 <test\+0x8>
			8: R_MICROMIPS_PC16_S1	test2
       c:	bc	c <test\+0xc>
			c: R_MICROMIPS_PC16_S1	test2
      10:	addu	v0,v1,a0
      12:	beqz	v0,12 <test\+0x12>
			12: R_MICROMIPS_PC7_S1	test1
      14:	nop
      16:	addu	v0,v1,a0
      18:	bnez	v0,18 <test\+0x18>
			18: R_MICROMIPS_PC7_S1	test1
      1a:	nop
      1c:	b	1c <test\+0x1c>
			1c: R_MICROMIPS_PC10_S1	test1
      1e:	nop
	\.\.\.

0+2a <test1>:
      2a:	beqz	a1,2a <test1>
			2a: R_MICROMIPS_PC16_S1	test2
      2e:	addu	v0,v1,a0
      30:	beqz	a1,30 <test1\+0x6>
			30: R_MICROMIPS_PC7_S1	\.L0
      32:	nop
      34:	j	0 <test>
			34: R_MICROMIPS_26_S1	test3

0+38 <\.L0>:
      38:	addu	v0,v1,a0
      3a:	b	3a <\.L0\+0x2>
			3a: R_MICROMIPS_PC16_S1	test2
      3e:	addu	v0,v1,a0
	\.\.\.

0+440 <test2>:
	\.\.\.

0+10440 <test3>:
	\.\.\.
