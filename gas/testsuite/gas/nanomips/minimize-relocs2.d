#objdump: -dr
#name: Minimize relocs in cascaded dependency chains
#as: -mminimize-relocs

# Check reloc minimization on cascaded chains

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <test>:
   0:	1802      	bc	4 <test\+0x4>
   2:	3802      	balc	6 <test\+0x6>
   4:	9a02      	beqzc	a0,8 <test\+0x8>
   6:	dac2      	beqc	a0,a1,c <\$L4>
   8:	c890 2000 	bneic	a0,4,10 <\$L5>
			8: R_NANOMIPS_PC11_S1	\$L5

0000000c <\$L4>:
   c:	2a00 0000 	balc	0 <test1>
			c: R_NANOMIPS_PC25_S1	test1

00000010 <\$L5>:
  10:	1800      	bc	c <\$L4>
			10: R_NANOMIPS_PC10_S1	\$L4
  12:	3bfd      	balc	10 <\$L5>
  14:	9a7d      	beqzc	a0,12 <\$L5\+0x2>
  16:	88a4 3ffb 	beqc	a0,a1,14 <\$L5\+0x4>
  1a:	c890 27f9 	bneic	a0,4,16 <\$L5\+0x6>
  1e:	1802      	bc	22 <\$L5\+0x12>
  20:	3802      	balc	24 <\$L5\+0x14>
  22:	9a02      	beqzc	a0,26 <\$L5\+0x16>
  24:	dac2      	beqc	a0,a1,2a <\$L5\+0x1a>
  26:	c890 2002 	bneic	a0,4,2c <\$L5\+0x1c>
  2a:	3802      	balc	2e <\$L5\+0x1e>
  2c:	1bfd      	bc	2a <\$L5\+0x1a>
  2e:	3bfd      	balc	2c <\$L5\+0x1c>
  30:	9a7d      	beqzc	a0,2e <\$L5\+0x1e>
  32:	88a4 3ffb 	beqc	a0,a1,30 <\$L5\+0x20>
  36:	c890 27f9 	bneic	a0,4,32 <\$L5\+0x22>
  3a:	1802      	bc	3e <\$L5\+0x2e>
  3c:	3802      	balc	40 <\$L5\+0x30>
  3e:	9a02      	beqzc	a0,42 <\$L5\+0x32>
  40:	dac2      	beqc	a0,a1,46 <\$L5\+0x36>
  42:	c890 2004 	bneic	a0,4,4a <\$L5\+0x3a>
  46:	2a00 0000 	balc	0 <test1>
			46: R_NANOMIPS_PC25_S1	test1
			46: R_NANOMIPS_INSN32	\*ABS\*
  4a:	1bfb      	bc	46 <\$L5\+0x36>
  4c:	3bfd      	balc	4a <\$L5\+0x3a>
  4e:	9a7d      	beqzc	a0,4c <\$L5\+0x3c>
  50:	88a4 3ffb 	beqc	a0,a1,4e <\$L5\+0x3e>
  54:	c890 27f9 	bneic	a0,4,50 <\$L5\+0x40>
  58:	1802      	bc	5c <\$L5\+0x4c>
  5a:	3802      	balc	5e <\$L5\+0x4e>
  5c:	9a02      	beqzc	a0,60 <\$L5\+0x50>
  5e:	dac2      	beqc	a0,a1,64 <\$L5\+0x54>
  60:	c890 2004 	bneic	a0,4,68 <\$L5\+0x58>
  64:	2a00 0000 	balc	0 <test1>
			64: R_NANOMIPS_PC25_S1	test1
			64: R_NANOMIPS_FIXED	\*ABS\*
  68:	1bfb      	bc	64 <\$L5\+0x54>
  6a:	3bfd      	balc	68 <\$L5\+0x58>
  6c:	9a7d      	beqzc	a0,6a <\$L5\+0x5a>
  6e:	88a4 3ffb 	beqc	a0,a1,6c <\$L5\+0x5c>
  72:	c890 27f9 	bneic	a0,4,6e <\$L5\+0x5e>
  76:	1802      	bc	7a <\$L5\+0x6a>
  78:	3802      	balc	7c <\$L5\+0x6c>
  7a:	9a02      	beqzc	a0,7e <\$L5\+0x6e>
  7c:	dac2      	beqc	a0,a1,82 <\$L5\+0x72>
  7e:	c890 2006 	bneic	a0,4,88 <\$L5\+0x78>
  82:	2a00 0000 	balc	0 <test1>
			82: R_NANOMIPS_PC25_S1	test1
			82: R_NANOMIPS_NORELAX	\*ABS\*
  86:	9008      	nop
			86: R_NANOMIPS_RELAX	\*ABS\*
  88:	1bf9      	bc	82 <\$L5\+0x72>
  8a:	3bfd      	balc	88 <\$L5\+0x78>
  8c:	9a7d      	beqzc	a0,8a <\$L5\+0x7a>
  8e:	88a4 3ffb 	beqc	a0,a1,8c <\$L5\+0x7c>
  92:	c890 27f9 	bneic	a0,4,8e <\$L5\+0x7e>
  96:	9008      	nop
#pass
