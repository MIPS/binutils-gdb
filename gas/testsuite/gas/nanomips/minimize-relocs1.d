#objdump: -dr
#name: Minimize relocs in nested dependency loops
#as: -mminimize-relocs

# Check reloc minimization in nested loops

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <test>:
   0:	1800      	bc	10 <\$L2>
			0: R_NANOMIPS_PC10_S1	\$L2
   2:	3800      	balc	10 <\$L2>
			2: R_NANOMIPS_PC10_S1	\$L2
   4:	9a00      	beqzc	a0,10 <\$L2>
			4: R_NANOMIPS_PC7_S1	\$L2
   6:	dacf      	beqc	a0,a1,10 <\$L2>
			6: R_NANOMIPS_PC4_S1	\$L2
   8:	c890 2000 	bneic	a0,4,10 <\$L2>
			8: R_NANOMIPS_PC11_S1	\$L2

0000000c <\$L1>:
   c:	4080 0002 	lw	a0,0\(gp\)
			c: R_NANOMIPS_GPREL19_S2	test

00000010 <\$L2>:
  10:	88a4 0000 	beqc	a0,a1,c <\$L1>
			10: R_NANOMIPS_PC14_S1	\$L1
  14:	c890 2000 	bneic	a0,4,c <\$L1>
			14: R_NANOMIPS_PC11_S1	\$L1
  18:	9a00      	beqzc	a0,c <\$L1>
			18: R_NANOMIPS_PC7_S1	\$L1
  1a:	3800      	balc	c <\$L1>
			1a: R_NANOMIPS_PC10_S1	\$L1
  1c:	1800      	bc	c <\$L1>
			1c: R_NANOMIPS_PC10_S1	\$L1
  1e:	2800 000e 	bc	30 <\$L2\+0x20>
  22:	2a00 000a 	balc	30 <\$L2\+0x20>
  26:	8880 0006 	beqzc	a0,30 <\$L2\+0x20>
  2a:	88a4 0002 	beqc	a0,a1,30 <\$L2\+0x20>
  2e:	3800      	balc	0 <test>
			2e: R_NANOMIPS_PC10_S1	test
  30:	29ff fffb 	bc	2e <\$L2\+0x1e>
  34:	2bff fff7 	balc	2e <\$L2\+0x1e>
  38:	8880 3ff3 	beqzc	a0,2e <\$L2\+0x1e>
  3c:	88a4 3fef 	beqc	a0,a1,2e <\$L2\+0x1e>
  40:	1800      	bc	56 <\$L6>
			40: R_NANOMIPS_PC10_S1	\$L6
  42:	3800      	balc	56 <\$L6>
			42: R_NANOMIPS_PC10_S1	\$L6
  44:	9a00      	beqzc	a0,56 <\$L6>
			44: R_NANOMIPS_PC7_S1	\$L6
  46:	c890 2000 	bneic	a0,4,56 <\$L6>
			46: R_NANOMIPS_PC11_S1	\$L6
  4a:	dacf      	beqc	a0,a1,56 <\$L6>
			4a: R_NANOMIPS_PC4_S1	\$L6

0000004c <\$L5>:
  4c:	4080 0002 	lw	a0,0\(gp\)
			4c: R_NANOMIPS_GPREL19_S2	test
  50:	0480 0000 	lapc	a0,0 <test1>
			50: R_NANOMIPS_PC21_S1	test1
			50: R_NANOMIPS_NORELAX	\*ABS\*
  54:	9008      	nop
			54: R_NANOMIPS_RELAX	\*ABS\*

00000056 <\$L6>:
  56:	1800      	bc	4c <\$L5>
			56: R_NANOMIPS_PC10_S1	\$L5
  58:	3800      	balc	4c <\$L5>
			58: R_NANOMIPS_PC10_S1	\$L5
  5a:	9a00      	beqzc	a0,4c <\$L5>
			5a: R_NANOMIPS_PC7_S1	\$L5
  5c:	c890 2000 	bneic	a0,4,4c <\$L5>
			5c: R_NANOMIPS_PC11_S1	\$L5
  60:	88a4 0000 	beqc	a0,a1,4c <\$L5>
			60: R_NANOMIPS_PC14_S1	\$L5
  64:	180c      	bc	72 <\$L6\+0x1c>
  66:	380a      	balc	72 <\$L6\+0x1c>
  68:	9a08      	beqzc	a0,72 <\$L6\+0x1c>
  6a:	c890 2004 	bneic	a0,4,72 <\$L6\+0x1c>
  6e:	dac1      	beqc	a0,a1,72 <\$L6\+0x1c>
  70:	3800      	balc	0 <test_ext>
			70: R_NANOMIPS_PC10_S1	test_ext
			70: R_NANOMIPS_INSN16	\*ABS\*
  72:	1bfd      	bc	70 <\$L6\+0x1a>
  74:	3bfb      	balc	70 <\$L6\+0x1a>
  76:	9a79      	beqzc	a0,70 <\$L6\+0x1a>
  78:	c890 27f5 	bneic	a0,4,70 <\$L6\+0x1a>
  7c:	88a4 3ff1 	beqc	a0,a1,70 <\$L6\+0x1a>
  80:	1812      	bc	94 <\$L6\+0x3e>
  82:	3810      	balc	94 <\$L6\+0x3e>
  84:	9a0e      	beqzc	a0,94 <\$L6\+0x3e>
  86:	c890 200a 	bneic	a0,4,94 <\$L6\+0x3e>
  8a:	dac4      	beqc	a0,a1,94 <\$L6\+0x3e>
  8c:	9008      	nop
			8c: R_NANOMIPS_NORELAX	\*ABS\*
  8e:	2a00 0000 	balc	0 <test_ext>
			8e: R_NANOMIPS_PC25_S1	test_ext
  92:	9008      	nop
			92: R_NANOMIPS_RELAX	\*ABS\*
  94:	1bf7      	bc	8c <\$L6\+0x36>
  96:	3bf5      	balc	8c <\$L6\+0x36>
  98:	9a73      	beqzc	a0,8c <\$L6\+0x36>
  9a:	c890 27ef 	bneic	a0,4,8c <\$L6\+0x36>
  9e:	88a4 3feb 	beqc	a0,a1,8c <\$L6\+0x36>
  a2:	1800      	bc	b2 <\$L12>
			a2: R_NANOMIPS_PC10_S1	\$L12
  a4:	3800      	balc	b2 <\$L12>
			a4: R_NANOMIPS_PC10_S1	\$L12
  a6:	9a00      	beqzc	a0,b2 <\$L12>
			a6: R_NANOMIPS_PC7_S1	\$L12
  a8:	dacf      	beqc	a0,a1,b2 <\$L12>
			a8: R_NANOMIPS_PC4_S1	\$L12
  aa:	c890 2000 	bneic	a0,4,b2 <\$L12>
			aa: R_NANOMIPS_PC11_S1	\$L12

000000ae <\$L11>:
  ae:	2800 0000 	bc	[0-9a-f]+ <test_weak>
			ae: R_NANOMIPS_PC25_S1	test_weak

000000b2 <\$L12>:
  b2:	88a4 0000 	beqc	a0,a1,ae <\$L11>
			b2: R_NANOMIPS_PC14_S1	\$L11
  b6:	c890 2000 	bneic	a0,4,ae <\$L11>
			b6: R_NANOMIPS_PC11_S1	\$L11
  ba:	9a00      	beqzc	a0,ae <\$L11>
			ba: R_NANOMIPS_PC7_S1	\$L11
  bc:	3800      	balc	ae <\$L11>
			bc: R_NANOMIPS_PC10_S1	\$L11
  be:	1800      	bc	ae <\$L11>
			be: R_NANOMIPS_PC10_S1	\$L11
  c0:	1800      	bc	d0 <\$L14>
			c0: R_NANOMIPS_PC10_S1	\$L14
  c2:	3800      	balc	d0 <\$L14>
			c2: R_NANOMIPS_PC10_S1	\$L14
  c4:	9a00      	beqzc	a0,d0 <\$L14>
			c4: R_NANOMIPS_PC7_S1	\$L14
  c6:	dacf      	beqc	a0,a1,d0 <\$L14>
			c6: R_NANOMIPS_PC4_S1	\$L14
  c8:	c890 2000 	bneic	a0,4,d0 <\$L14>
			c8: R_NANOMIPS_PC11_S1	\$L14

000000cc <\$L13>:
  cc:	2800 0000 	bc	0 <test_other_sect>
			cc: R_NANOMIPS_PC25_S1	test_other_sect

000000d0 <\$L14>:
  d0:	88a4 0000 	beqc	a0,a1,cc <\$L13>
			d0: R_NANOMIPS_PC14_S1	\$L13
  d4:	c890 2000 	bneic	a0,4,cc <\$L13>
			d4: R_NANOMIPS_PC11_S1	\$L13
  d8:	9a00      	beqzc	a0,cc <\$L13>
			d8: R_NANOMIPS_PC7_S1	\$L13
  da:	3800      	balc	cc <\$L13>
			da: R_NANOMIPS_PC10_S1	\$L13
  dc:	1800      	bc	cc <\$L13>
			dc: R_NANOMIPS_PC10_S1	\$L13
  de:	1800      	bc	ec <\$L16>
			de: R_NANOMIPS_PC10_S1	\$L16
  e0:	3800      	balc	ec <\$L16>
			e0: R_NANOMIPS_PC10_S1	\$L16
  e2:	9a00      	beqzc	a0,ec <\$L16>
			e2: R_NANOMIPS_PC7_S1	\$L16
  e4:	dacf      	beqc	a0,a1,ec <\$L16>
			e4: R_NANOMIPS_PC4_S1	\$L16
  e6:	c890 2000 	bneic	a0,4,ec <\$L16>
			e6: R_NANOMIPS_PC11_S1	\$L16

000000ea <\$L15>:
  ea:	d8f0      	jalrc	a3
			ea: R_NANOMIPS_JALR32	foo

000000ec <\$L16>:
  ec:	88a4 0000 	beqc	a0,a1,ea <\$L15>
			ec: R_NANOMIPS_PC14_S1	\$L15
  f0:	c890 2000 	bneic	a0,4,ea <\$L15>
			f0: R_NANOMIPS_PC11_S1	\$L15
  f4:	9a00      	beqzc	a0,ea <\$L15>
			f4: R_NANOMIPS_PC7_S1	\$L15
  f6:	3800      	balc	ea <\$L15>
			f6: R_NANOMIPS_PC10_S1	\$L15
  f8:	1800      	bc	ea <\$L15>
			f8: R_NANOMIPS_PC10_S1	\$L15

000000fa <test_weak>:
  fa:	dbe0      	jrc	ra
#...
Disassembly of section \.text\.other:

00000000 <test_other_sect>:
   0:	dbe0      	jrc	ra
#pass
