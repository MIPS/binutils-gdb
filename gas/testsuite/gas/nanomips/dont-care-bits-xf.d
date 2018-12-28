#objdump: -dr --show-raw-insn
#name: Encodings with don't care bits set to all 1s
#source: dont-care-bits.s
#as: -mset-dcbits=0xfff

# Check user-specified patterns for don't care bits

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <test>:
   0:	209f 0390 	dvp	a0
   4:	20c5 2510 	add	a0,a1,a2
   8:	4be4 8fff 	balrsc	ra,a0
   c:	c8a6 c000 	bbeqzc	a1,24,10 <test\+0x10>
  10:	2085 ebe8 	crc32w	a0,a1
  14:	23ff e37f 	deret
  18:	801f ce03 	ehb
  1c:	23ff 077f 	tlbinv
  20:	801f ce03 	ehb
  24:	23fe f37f 	eret
  28:	23e4 1f7f 	ginvi	a0
  2c:	23a4 0f7f 	ginvt	a0,1
  30:	a486 d12d 	llwp	a0,a1,\(a2\)
  34:	20c5 23cf 	lsa	a0,a1,a2,1
  38:	8000 ce05 	pause
  3c:	2085 fc08 	seb	a0,a1
  40:	2080 15ff 	repl.qb	a0,0x0
  44:	23e0 7c1d 	shilo	\$ac1,-32
  48:	2085 7f35 	shra_r.ph	a0,a1,7
#pass