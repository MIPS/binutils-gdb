#objdump: -dr
#name: Minimize relocs in cascaded dependency chains
#as: -mminimize-relocs
#source: minimize-relocs2.s

# Check reloc minimization on cascaded chains

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <test>:
   0:	1802      	bc	4 <test\+0x4>
   2:	3802      	balc	6 <test\+0x6>
   4:	9a04      	beqzc	a0,a <test\+0xa>
   6:	88a4 0004 	beqc	a0,a1,e <\$L4>
   a:	c890 2000 	bneic	a0,4,12 <\$L5>
			a: R_NANOMIPS_PC11_S1	\$L5

0000000e <\$L4>:
   e:	2a00 0000 	balc	0 <test1>
			e: R_NANOMIPS_PC25_S1	test1

00000012 <\$L5>:
  12:	1800      	bc	e <\$L4>
			12: R_NANOMIPS_PC10_S1	\$L4
  14:	3bfd      	balc	12 <\$L5>
  16:	9a7d      	beqzc	a0,14 <\$L5\+0x2>
  18:	88a4 3ffb 	beqc	a0,a1,16 <\$L5\+0x4>
  1c:	c890 27f9 	bneic	a0,4,18 <\$L5\+0x6>
  20:	1802      	bc	24 <\$L5\+0x12>
  22:	3802      	balc	26 <\$L5\+0x14>
  24:	9a04      	beqzc	a0,2a <\$L5\+0x18>
  26:	88a4 0004 	beqc	a0,a1,2e <\$L5\+0x1c>
  2a:	c890 2002 	bneic	a0,4,30 <\$L5\+0x1e>
  2e:	3802      	balc	32 <\$L5\+0x20>
  30:	1bfd      	bc	2e <\$L5\+0x1c>
  32:	3bfd      	balc	30 <\$L5\+0x1e>
  34:	9a7d      	beqzc	a0,32 <\$L5\+0x20>
  36:	88a4 3ffb 	beqc	a0,a1,34 <\$L5\+0x22>
  3a:	c890 27f9 	bneic	a0,4,36 <\$L5\+0x24>
  3e:	1802      	bc	42 <\$L5\+0x30>
  40:	3802      	balc	44 <\$L5\+0x32>
  42:	9a04      	beqzc	a0,48 <\$L5\+0x36>
  44:	88a4 0004 	beqc	a0,a1,4c <\$L5\+0x3a>
  48:	c890 2004 	bneic	a0,4,50 <\$L5\+0x3e>
  4c:	2a00 0000 	balc	0 <test1>
			4c: R_NANOMIPS_PC25_S1	test1
			4c: R_NANOMIPS_INSN32	\*ABS\*
  50:	1bfb      	bc	4c <\$L5\+0x3a>
  52:	3bfd      	balc	50 <\$L5\+0x3e>
  54:	9a7d      	beqzc	a0,52 <\$L5\+0x40>
  56:	88a4 3ffb 	beqc	a0,a1,54 <\$L5\+0x42>
  5a:	c890 27f9 	bneic	a0,4,56 <\$L5\+0x44>
  5e:	1802      	bc	62 <\$L5\+0x50>
  60:	3802      	balc	64 <\$L5\+0x52>
  62:	9a04      	beqzc	a0,68 <\$L5\+0x56>
  64:	88a4 0004 	beqc	a0,a1,6c <\$L5\+0x5a>
  68:	c890 2004 	bneic	a0,4,70 <\$L5\+0x5e>
  6c:	2a00 0000 	balc	0 <test1>
			6c: R_NANOMIPS_PC25_S1	test1
			6c: R_NANOMIPS_FIXED	\*ABS\*
  70:	1bfb      	bc	6c <\$L5\+0x5a>
  72:	3bfd      	balc	70 <\$L5\+0x5e>
  74:	9a7d      	beqzc	a0,72 <\$L5\+0x60>
  76:	88a4 3ffb 	beqc	a0,a1,74 <\$L5\+0x62>
  7a:	c890 27f9 	bneic	a0,4,76 <\$L5\+0x64>
  7e:	1802      	bc	82 <\$L5\+0x70>
  80:	3802      	balc	84 <\$L5\+0x72>
  82:	9a04      	beqzc	a0,88 <\$L5\+0x76>
  84:	88a4 0004 	beqc	a0,a1,8c <\$L5\+0x7a>
  88:	c890 2006 	bneic	a0,4,92 <\$L5\+0x80>
  8c:	2a00 0000 	balc	0 <test1>
			8c: R_NANOMIPS_PC25_S1	test1
			8c: R_NANOMIPS_NORELAX	\*ABS\*
  90:	9008      	nop
			90: R_NANOMIPS_RELAX	\*ABS\*
  92:	1bf9      	bc	8c <\$L5\+0x7a>
  94:	3bfd      	balc	92 <\$L5\+0x80>
  96:	9a7d      	beqzc	a0,94 <\$L5\+0x82>
  98:	88a4 3ffb 	beqc	a0,a1,96 <\$L5\+0x84>
  9c:	c890 27f9 	bneic	a0,4,98 <\$L5\+0x86>
#pass
