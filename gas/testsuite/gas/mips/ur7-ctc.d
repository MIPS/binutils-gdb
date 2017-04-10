#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPSR7 CTC instructions
#as: -mips32r7
#source: ur7-ctc.s

# Check MIPSR7 convert-to-compact branch instructions

.*: +file format .*mips.*

Disassembly of section .text:
0+0000 <[^>]*> 1800      	bc	000000a8 <.L11\+0x2>
			0: R_NANOMIPS_PC10_S1	.L11-0x2
0+0002 <[^>]*> 1800      	bc	000000aa <.L11\+0x4>
			2: R_NANOMIPS_PC10_S1	.L11-0x2
0+0004 <[^>]*> 2800 0000 	bc	000000ae <.L11\+0x8>
			4: R_NANOMIPS_PC25_S1	.L11-0x4
0+0008 <[^>]*> 3800      	balc	000000b0 <.L11\+0xa>
			8: R_NANOMIPS_PC10_S1	.L11-0x2
0+000a <[^>]*> ea40 0000 	beqzc	s2,000000b4 <.L11\+0xe>
			a: R_NANOMIPS_PC20_S1	.L11-0x4
0+000e <[^>]*> ea40 0000 	beqzc	s2,000000b8 <.L11\+0x12>
			e: R_NANOMIPS_PC20_S1	.L11-0x4
0+0012 <[^>]*> 9900      	beqzc	s2,000000ba <.L11\+0x14>
			12: R_NANOMIPS_PC7_S1	.L11-0x2
0+0014 <[^>]*> da3f      	beqc	s3,a0,00000012 <ext\+0x12>
			14: R_NANOMIPS_PC4_S1	ext-0x2
0+0016 <[^>]*> da3f      	beqc	s3,a0,00000014 <ext\+0x14>
			16: R_NANOMIPS_PC4_S1	ext-0x2
0+0018 <[^>]*> ea60 0000 	beqzc	s3,0000001c <ext\+0x1c>
			18: R_NANOMIPS_PC20_S1	ext-0x4
0+001c <[^>]*> ea60 0000 	beqzc	s3,00000020 <ext\+0x20>
			1c: R_NANOMIPS_PC20_S1	ext-0x4
0+0020 <[^>]*> 8a72 0000 	beqc	s2,s3,00000024 <ext\+0x24>
			20: R_NANOMIPS_PC14_S1	ext-0x4
0+0024 <[^>]*> 8a72 0000 	beqc	s2,s3,00000028 <ext\+0x28>
			24: R_NANOMIPS_PC14_S1	ext-0x4
0+0028 <[^>]*> 9980      	beqzc	s3,0000002a <ext\+0x2a>
			28: R_NANOMIPS_PC7_S1	ext-0x2
0+002a <[^>]*> ea60 0000 	beqzc	s3,0000002e <ext\+0x2e>
			2a: R_NANOMIPS_PC20_S1	ext-0x4
0+002e <[^>]*> b900      	bnezc	s2,000000d6 <.L11\+0x30>
			2e: R_NANOMIPS_PC7_S1	.L11-0x2
0+0030 <[^>]*> ea50 0000 	bnezc	s2,000000da <.L11\+0x34>
			30: R_NANOMIPS_PC20_S1	.L11-0x4
0+0034 <[^>]*> b900      	bnezc	s2,000000dc <.L11\+0x36>
			34: R_NANOMIPS_PC7_S1	.L11-0x2
0+0036 <[^>]*> d9cf      	bnec	a0,s3,00000034 <ext\+0x34>
			36: R_NANOMIPS_PC4_S1	ext-0x2
0+0038 <[^>]*> d9cf      	bnec	a0,s3,00000036 <ext\+0x36>
			38: R_NANOMIPS_PC4_S1	ext-0x2
0+003a <[^>]*> ea70 0000 	bnezc	s3,0000003e <ext\+0x3e>
			3a: R_NANOMIPS_PC20_S1	ext-0x4
0+003e <[^>]*> ea70 0000 	bnezc	s3,00000042 <ext\+0x42>
			3e: R_NANOMIPS_PC20_S1	ext-0x4
0+0042 <[^>]*> aa53 0000 	bnec	s3,s2,00000046 <ext\+0x46>
			42: R_NANOMIPS_PC14_S1	ext-0x4
0+0046 <[^>]*> aa53 0000 	bnec	s3,s2,0000004a <ext\+0x4a>
			46: R_NANOMIPS_PC14_S1	ext-0x4
0+004a <[^>]*> b980      	bnezc	s3,0000004c <ext\+0x4c>
			4a: R_NANOMIPS_PC7_S1	ext-0x2
0+004c <[^>]*> ea70 0000 	bnezc	s3,00000050 <ext\+0x50>
			4c: R_NANOMIPS_PC20_S1	ext-0x4
0+0050 <[^>]*> 8812 8000 	bgezc	s2,00000054 <ext\+0x54>
			50: R_NANOMIPS_PC14_S1	ext-0x4
0+0054 <[^>]*> a812 8000 	bltzc	s2,00000058 <ext\+0x58>
			54: R_NANOMIPS_PC14_S1	ext-0x4
0+0058 <[^>]*> 8812 8000 	bgezc	s2,000000bc <.L11\+0x16>
			58: R_NANOMIPS_PC14_S1	.L0-0x4
0+005c <[^>]*> 2a00 0000 	balc	00000060 <ext\+0x60>
			5c: R_NANOMIPS_PC25_S1	ext-0x4
0+0060 <[^>]*> a812 8000 	bltzc	s2,000000cc <.L11\+0x26>
			60: R_NANOMIPS_PC14_S1	.L1-0x4
0+0064 <[^>]*> 2a00 0000 	balc	00000068 <ext\+0x68>
			64: R_NANOMIPS_PC25_S1	ext-0x4
0+0068 <[^>]*> d880      	jrc	a0
0+006a <[^>]*> d840      	jrc	v0
0+006c <[^>]*> 4802 0000 	jrc	v0
0+0070 <[^>]*> 2800 0000 	bc	0000011a <.L11\+0x74>
			70: R_NANOMIPS_PC25_S1	.L11-0x4
0+0074 <[^>]*> 2800 0080 	bc	000000f8 <.L11\+0x52>
			74: R_NANOMIPS_PC25_S1	\*ABS\*\+0xfc
0+0078 <[^>]*> 2a00 0000 	balc	00000122 <.L11\+0x7c>
			78: R_NANOMIPS_PC25_S1	.L11-0x4
0+007c <[^>]*> 4804 0000 	jrc	a0
0+0080 <[^>]*> 4804 0000 	jrc	a0
0+0084 <[^>]*> d890      	jalrc	a0
0+0086 <[^>]*> 4be4 0000 	jalrc	a0
0+008a <[^>]*> 4885 0000 	jalrc	a0,a1
0+008e <[^>]*> 4885 0000 	jalrc	a0,a1
0+0092 <[^>]*> d850      	jalrc	v0
0+0094 <[^>]*> d850      	jalrc	v0
0+0096 <[^>]*> d850      	jalrc	v0
0+0098 <[^>]*> 4804 1000 	jrc.hb	a0
0+009c <[^>]*> 4be4 1000 	jalrc.hb	a0
0+00a0 <[^>]*> 4885 1000 	jalrc.hb	a0,a1
0+00a4 <[^>]*> 1fa8      	restore.jrc	32
0+00a6 <[^>]*> 9008      	nop
	...
