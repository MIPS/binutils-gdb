#objdump: -dr
#name: Minimize relocs in mutually recursive dependency spiral
#as: -mminimize-relocs

# Check reloc minimization in mutual dependency spiral

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <test>:
   0:	381c      	balc	1e <test\+0x1e>
   2:	1818      	bc	1c <test\+0x1c>
   4:	3814      	balc	1a <test\+0x1a>
   6:	9a10      	beqzc	a0,18 <test\+0x18>
   8:	dac6      	beqc	a0,a1,16 <test\+0x16>
   a:	c890 2004 	bneic	a0,4,12 <test\+0x12>
   e:	88a4 3ff9 	beqc	a0,a1,a <test\+0xa>
  12:	c890 27f3 	bneic	a0,4,8 <test\+0x8>
  16:	9a6f      	beqzc	a0,6 <test\+0x6>
  18:	3beb      	balc	4 <test\+0x4>
  1a:	1be7      	bc	2 <test\+0x2>
  1c:	1be3      	bc	0 <test>
  1e:	9008      	nop
#pass
