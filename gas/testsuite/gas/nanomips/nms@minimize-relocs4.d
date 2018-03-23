#objdump: -dr
#name: Minimize relocs special cases
#as: -mminimize-relocs
#source: minimize-relocs4.s

# Check reloc minimization special cases

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <test>:
   0:	88a4 0004 	beqc	a0,a1,8 <test\+0x8>
   4:	88a4 0000 	beqc	a0,a1,2a <\$L2>
			4: R_NANOMIPS_PC14_S1	\$L2
   8:	0085 0000 	addiu	a0,a1,0
			8: R_NANOMIPS_GPREL_LO12	test
   c:	4080 0000 	addiu	a0,gp,0
			c: R_NANOMIPS_GPREL19_S2	test
	\.\.\.

0000002a <\$L2>:
  2a:	88a4 0004 	beqc	a0,a1,32 <\$L2\+0x8>
  2e:	88a4 0000 	beqc	a0,a1,52 <\$L4>
			2e: R_NANOMIPS_PC14_S1	\$L4
  32:	448c 0000 	addiu	a0,gp,0
			32: R_NANOMIPS_GPREL18	test
	\.\.\.

00000052 <\$L4>:
  52:	88a4 0004 	beqc	a0,a1,5a <\$L4\+0x8>
  56:	88a4 0000 	beqc	a0,a1,7a <\$L6>
			56: R_NANOMIPS_PC14_S1	\$L6
  5a:	4080 0002 	lw	a0,0\(gp\)
			5a: R_NANOMIPS_GPREL19_S2	test
	\.\.\.

0000007a <\$L6>:
  7a:	9008      	nop
	\.\.\.
  88:	9008      	nop
  8a:	88a4 0004 	beqc	a0,a1,92 <\$L6\+0x18>
  8e:	88a4 0000 	beqc	a0,a1,ae <\$L8>
			8e: R_NANOMIPS_PC14_S1	\$L8
  92:	4080 0002 	lw	a0,0\(gp\)
			92: R_NANOMIPS_GPREL19_S2	test
  96:	9008      	nop
			96: R_NANOMIPS_ALIGN	__reloc_align__1
  98:	8000 c000 	nop
  9c:	8000 c000 	nop
	\.\.\.

000000ae <\$L8>:
  ae:	9008      	nop
  b0:	9008      	nop
  b2:	88a4 0004 	beqc	a0,a1,ba <\$L8\+0xc>
  b6:	88a4 0000 	beqc	a0,a1,da <\$L10>
			b6: R_NANOMIPS_PC14_S1	\$L10
  ba:	4080 0002 	lw	a0,0\(gp\)
			ba: R_NANOMIPS_GPREL19_S2	test
  be:	9008      	nop
			be: R_NANOMIPS_ALIGN	__reloc_align__2
	\.\.\.

000000da <\$L10>:
  da:	9008      	nop
  dc:	8000 c000 	nop
