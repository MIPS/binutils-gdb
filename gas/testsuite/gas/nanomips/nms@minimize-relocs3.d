#objdump: -dr
#name: Minimize relocs in mutually recursive dependency spiral
#as: -mminimize-relocs
#source: minimize-relocs3.s

# Check reloc minimization in mutual dependency spiral

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <test>:
   0:	381e      	balc	20 <test\+0x20>
   2:	181a      	bc	1e <test\+0x1e>
   4:	3816      	balc	1c <test\+0x1c>
   6:	9a12      	beqzc	a0,1a <test\+0x1a>
   8:	88a4 000c 	beqc	a0,a1,18 <test\+0x18>
   c:	c890 2004 	bneic	a0,4,14 <test\+0x14>
  10:	88a4 3ff9 	beqc	a0,a1,c <test\+0xc>
  14:	c890 27f1 	bneic	a0,4,8 <test\+0x8>
  18:	9a6d      	beqzc	a0,6 <test\+0x6>
  1a:	3be9      	balc	4 <test\+0x4>
  1c:	1be5      	bc	2 <test\+0x2>
  1e:	1be1      	bc	0 <test>
  20:	9008      	nop
#pass
