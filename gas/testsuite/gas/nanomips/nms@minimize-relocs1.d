#objdump: -dr
#name: Minimize relocs in nested dependency loops
#as: -mminimize-relocs
#source: minimize-relocs1.s

# Check reloc minimization in nested loops

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <test>:
   0:	1800      	bc	12 <\$L2>
			0: R_NANOMIPS_PC10_S1	\$L2
   2:	3800      	balc	12 <\$L2>
			2: R_NANOMIPS_PC10_S1	\$L2
   4:	9a00      	beqzc	a0,12 <\$L2>
			4: R_NANOMIPS_PC7_S1	\$L2
   6:	88a4 0000 	beqc	a0,a1,12 <\$L2>
			6: R_NANOMIPS_PC14_S1	\$L2
   a:	c890 2000 	bneic	a0,4,12 <\$L2>
			a: R_NANOMIPS_PC11_S1	\$L2

0000000e <\$L1>:
   e:	4080 0002 	lw	a0,0\(gp\)
			e: R_NANOMIPS_GPREL19_S2	test

00000012 <\$L2>:
  12:	88a4 0000 	beqc	a0,a1,e <\$L1>
			12: R_NANOMIPS_PC14_S1	\$L1
  16:	c890 2000 	bneic	a0,4,e <\$L1>
			16: R_NANOMIPS_PC11_S1	\$L1
  1a:	9a00      	beqzc	a0,e <\$L1>
			1a: R_NANOMIPS_PC7_S1	\$L1
  1c:	3800      	balc	e <\$L1>
			1c: R_NANOMIPS_PC10_S1	\$L1
  1e:	1800      	bc	e <\$L1>
			1e: R_NANOMIPS_PC10_S1	\$L1
  20:	2800 000e 	bc	32 <\$L2\+0x20>
  24:	2a00 000a 	balc	32 <\$L2\+0x20>
  28:	8880 0006 	beqzc	a0,32 <\$L2\+0x20>
  2c:	88a4 0002 	beqc	a0,a1,32 <\$L2\+0x20>
  30:	3800      	balc	0 <test>
			30: R_NANOMIPS_PC10_S1	test
  32:	29ff fffb 	bc	30 <\$L2\+0x1e>
  36:	2bff fff7 	balc	30 <\$L2\+0x1e>
  3a:	8880 3ff3 	beqzc	a0,30 <\$L2\+0x1e>
  3e:	88a4 3fef 	beqc	a0,a1,30 <\$L2\+0x1e>
  42:	1800      	bc	5a <\$L6>
			42: R_NANOMIPS_PC10_S1	\$L6
  44:	3800      	balc	5a <\$L6>
			44: R_NANOMIPS_PC10_S1	\$L6
  46:	9a00      	beqzc	a0,5a <\$L6>
			46: R_NANOMIPS_PC7_S1	\$L6
  48:	c890 2000 	bneic	a0,4,5a <\$L6>
			48: R_NANOMIPS_PC11_S1	\$L6
  4c:	88a4 0000 	beqc	a0,a1,5a <\$L6>
			4c: R_NANOMIPS_PC14_S1	\$L6

00000050 <\$L5>:
  50:	4080 0002 	lw	a0,0\(gp\)
			50: R_NANOMIPS_GPREL19_S2	test
  54:	0480 0000 	lapc	a0,0 <test1>
			54: R_NANOMIPS_PC21_S1	test1
			54: R_NANOMIPS_NORELAX	\*ABS\*
  58:	9008      	nop
			58: R_NANOMIPS_RELAX	\*ABS\*

0000005a <\$L6>:
  5a:	1800      	bc	50 <\$L5>
			5a: R_NANOMIPS_PC10_S1	\$L5
  5c:	3800      	balc	50 <\$L5>
			5c: R_NANOMIPS_PC10_S1	\$L5
  5e:	9a00      	beqzc	a0,50 <\$L5>
			5e: R_NANOMIPS_PC7_S1	\$L5
  60:	c890 2000 	bneic	a0,4,50 <\$L5>
			60: R_NANOMIPS_PC11_S1	\$L5
  64:	88a4 0000 	beqc	a0,a1,50 <\$L5>
			64: R_NANOMIPS_PC14_S1	\$L5
  68:	180e      	bc	78 <\$L6\+0x1e>
  6a:	380c      	balc	78 <\$L6\+0x1e>
  6c:	9a0a      	beqzc	a0,78 <\$L6\+0x1e>
  6e:	c890 2006 	bneic	a0,4,78 <\$L6\+0x1e>
  72:	88a4 0002 	beqc	a0,a1,78 <\$L6\+0x1e>
  76:	3800      	balc	0 <test_ext>
			76: R_NANOMIPS_PC10_S1	test_ext
			76: R_NANOMIPS_INSN16	\*ABS\*
  78:	1bfd      	bc	76 <\$L6\+0x1c>
  7a:	3bfb      	balc	76 <\$L6\+0x1c>
  7c:	9a79      	beqzc	a0,76 <\$L6\+0x1c>
  7e:	c890 27f5 	bneic	a0,4,76 <\$L6\+0x1c>
  82:	88a4 3ff1 	beqc	a0,a1,76 <\$L6\+0x1c>
  86:	1814      	bc	9c <\$L6\+0x42>
  88:	3812      	balc	9c <\$L6\+0x42>
  8a:	9a10      	beqzc	a0,9c <\$L6\+0x42>
  8c:	c890 200c 	bneic	a0,4,9c <\$L6\+0x42>
  90:	88a4 0008 	beqc	a0,a1,9c <\$L6\+0x42>
  94:	9008      	nop
			94: R_NANOMIPS_NORELAX	\*ABS\*
  96:	2a00 0000 	balc	0 <test_ext>
			96: R_NANOMIPS_PC25_S1	test_ext
  9a:	9008      	nop
			9a: R_NANOMIPS_RELAX	\*ABS\*
  9c:	1bf7      	bc	94 <\$L6\+0x3a>
  9e:	3bf5      	balc	94 <\$L6\+0x3a>
  a0:	9a73      	beqzc	a0,94 <\$L6\+0x3a>
  a2:	c890 27ef 	bneic	a0,4,94 <\$L6\+0x3a>
  a6:	88a4 3feb 	beqc	a0,a1,94 <\$L6\+0x3a>
  aa:	1800      	bc	bc <\$L12>
			aa: R_NANOMIPS_PC10_S1	\$L12
  ac:	3800      	balc	bc <\$L12>
			ac: R_NANOMIPS_PC10_S1	\$L12
  ae:	9a00      	beqzc	a0,bc <\$L12>
			ae: R_NANOMIPS_PC7_S1	\$L12
  b0:	88a4 0000 	beqc	a0,a1,bc <\$L12>
			b0: R_NANOMIPS_PC14_S1	\$L12
  b4:	c890 2000 	bneic	a0,4,bc <\$L12>
			b4: R_NANOMIPS_PC11_S1	\$L12

000000b8 <\$L11>:
  b8:	2800 0000 	bc	[0-9a-f]+ <test_weak>
			b8: R_NANOMIPS_PC25_S1	test_weak

000000bc <\$L12>:
  bc:	88a4 0000 	beqc	a0,a1,b8 <\$L11>
			bc: R_NANOMIPS_PC14_S1	\$L11
  c0:	c890 2000 	bneic	a0,4,b8 <\$L11>
			c0: R_NANOMIPS_PC11_S1	\$L11
  c4:	9a00      	beqzc	a0,b8 <\$L11>
			c4: R_NANOMIPS_PC7_S1	\$L11
  c6:	3800      	balc	b8 <\$L11>
			c6: R_NANOMIPS_PC10_S1	\$L11
  c8:	1800      	bc	b8 <\$L11>
			c8: R_NANOMIPS_PC10_S1	\$L11
  ca:	1800      	bc	dc <\$L14>
			ca: R_NANOMIPS_PC10_S1	\$L14
  cc:	3800      	balc	dc <\$L14>
			cc: R_NANOMIPS_PC10_S1	\$L14
  ce:	9a00      	beqzc	a0,dc <\$L14>
			ce: R_NANOMIPS_PC7_S1	\$L14
  d0:	88a4 0000 	beqc	a0,a1,dc <\$L14>
			d0: R_NANOMIPS_PC14_S1	\$L14
  d4:	c890 2000 	bneic	a0,4,dc <\$L14>
			d4: R_NANOMIPS_PC11_S1	\$L14

000000d8 <\$L13>:
  d8:	2800 0000 	bc	0 <test_other_sect>
			d8: R_NANOMIPS_PC25_S1	test_other_sect

000000dc <\$L14>:
  dc:	88a4 0000 	beqc	a0,a1,d8 <\$L13>
			dc: R_NANOMIPS_PC14_S1	\$L13
  e0:	c890 2000 	bneic	a0,4,d8 <\$L13>
			e0: R_NANOMIPS_PC11_S1	\$L13
  e4:	9a00      	beqzc	a0,d8 <\$L13>
			e4: R_NANOMIPS_PC7_S1	\$L13
  e6:	3800      	balc	d8 <\$L13>
			e6: R_NANOMIPS_PC10_S1	\$L13
  e8:	1800      	bc	d8 <\$L13>
			e8: R_NANOMIPS_PC10_S1	\$L13
  ea:	1800      	bc	fa <\$L16>
			ea: R_NANOMIPS_PC10_S1	\$L16
  ec:	3800      	balc	fa <\$L16>
			ec: R_NANOMIPS_PC10_S1	\$L16
  ee:	9a00      	beqzc	a0,fa <\$L16>
			ee: R_NANOMIPS_PC7_S1	\$L16
  f0:	88a4 0000 	beqc	a0,a1,fa <\$L16>
			f0: R_NANOMIPS_PC14_S1	\$L16
  f4:	c890 2000 	bneic	a0,4,fa <\$L16>
			f4: R_NANOMIPS_PC11_S1	\$L16

000000f8 <\$L15>:
  f8:	d8f0      	jalrc	a3
			f8: R_NANOMIPS_JALR32	foo

000000fa <\$L16>:
  fa:	88a4 0000 	beqc	a0,a1,f8 <\$L15>
			fa: R_NANOMIPS_PC14_S1	\$L15
  fe:	c890 2000 	bneic	a0,4,f8 <\$L15>
			fe: R_NANOMIPS_PC11_S1	\$L15
 102:	9a00      	beqzc	a0,f8 <\$L15>
			102: R_NANOMIPS_PC7_S1	\$L15
 104:	3800      	balc	f8 <\$L15>
			104: R_NANOMIPS_PC10_S1	\$L15
 106:	1800      	bc	f8 <\$L15>
			106: R_NANOMIPS_PC10_S1	\$L15

00000108 <test_weak>:
 108:	dbe0      	jrc	ra
 10a:	9008      	nop
#...
Disassembly of section \.text\.other:

00000000 <test_other_sect>:
   0:	dbe0      	jrc	ra
			0: R_NANOMIPS_ALIGN	__reloc_align__1
#pass
