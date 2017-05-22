#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPSR7 CTC instructions
#as: -mmicromips -mips32r7
#source: ur7-ctc.s

# Check MIPSR7 convert-to-compact branch instructions

.*: +file format .*mips.*

Disassembly of section .text:
[0-9a-f]+ <[^>]*> 1800      	bc	[0-9a-f]+ <[^>]+>
			0: R_MICROMIPS_PC10_S1	.L11-0x2
[0-9a-f]+ <[^>]*> 1800      	bc	[0-9a-f]+ <[^>]+>
			2: R_MICROMIPS_PC10_S1	.L11-0x2
[0-9a-f]+ <[^>]*> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			4: R_MICROMIPS_PC25_S1	.L11-0x4
[0-9a-f]+ <[^>]*> 3800      	balc	[0-9a-f]+ <[^>]+>
			8: R_MICROMIPS_PC10_S1	.L11-0x2
[0-9a-f]+ <[^>]*> 8a40 0000 	beqzc	s2,[0-9a-f]+ <[^>]+>
			a: R_MICROMIPS_PC14_S1	.L11-0x4
[0-9a-f]+ <[^>]*> 8a40 0000 	beqzc	s2,[0-9a-f]+ <[^>]+>
			e: R_MICROMIPS_PC14_S1	.L11-0x4
[0-9a-f]+ <[^>]*> 9900      	beqzc	s2,[0-9a-f]+ <[^>]+>
			12: R_MICROMIPS_PC7_S1	.L11-0x2
[0-9a-f]+ <[^>]*> da3f      	beqc	s3,a0,[0-9a-f]+ <[^>]+>
			14: R_MICROMIPS_PC4_S1	ext-0x2
[0-9a-f]+ <[^>]*> da3f      	beqc	s3,a0,[0-9a-f]+ <[^>]+>
			16: R_MICROMIPS_PC4_S1	ext-0x2
[0-9a-f]+ <[^>]*> 8a60 0000 	beqzc	s3,[0-9a-f]+ <[^>]+>
			18: R_MICROMIPS_PC14_S1	ext-0x4
[0-9a-f]+ <[^>]*> 8a60 0000 	beqzc	s3,[0-9a-f]+ <[^>]+>
			1c: R_MICROMIPS_PC14_S1	ext-0x4
[0-9a-f]+ <[^>]*> 8a72 0000 	beqc	s2,s3,[0-9a-f]+ <[^>]+>
			20: R_MICROMIPS_PC14_S1	ext-0x4
[0-9a-f]+ <[^>]*> 8a72 0000 	beqc	s2,s3,[0-9a-f]+ <[^>]+>
			24: R_MICROMIPS_PC14_S1	ext-0x4
[0-9a-f]+ <[^>]*> 9980      	beqzc	s3,[0-9a-f]+ <[^>]+>
			28: R_MICROMIPS_PC7_S1	ext-0x2
[0-9a-f]+ <[^>]*> 8a60 0000 	beqzc	s3,[0-9a-f]+ <[^>]+>
			2a: R_MICROMIPS_PC14_S1	ext-0x4
[0-9a-f]+ <[^>]*> b900      	bnezc	s2,[0-9a-f]+ <[^>]+>
			2e: R_MICROMIPS_PC7_S1	.L11-0x2
[0-9a-f]+ <[^>]*> aa40 0000 	bnezc	s2,[0-9a-f]+ <[^>]+>
			30: R_MICROMIPS_PC14_S1	.L11-0x4
[0-9a-f]+ <[^>]*> b900      	bnezc	s2,[0-9a-f]+ <[^>]+>
			34: R_MICROMIPS_PC7_S1	.L11-0x2
[0-9a-f]+ <[^>]*> d9cf      	bnec	a0,s3,[0-9a-f]+ <[^>]+>
			36: R_MICROMIPS_PC4_S1	ext-0x2
[0-9a-f]+ <[^>]*> d9cf      	bnec	a0,s3,[0-9a-f]+ <[^>]+>
			38: R_MICROMIPS_PC4_S1	ext-0x2
[0-9a-f]+ <[^>]*> aa60 0000 	bnezc	s3,[0-9a-f]+ <[^>]+>
			3a: R_MICROMIPS_PC14_S1	ext-0x4
[0-9a-f]+ <[^>]*> aa60 0000 	bnezc	s3,[0-9a-f]+ <[^>]+>
			3e: R_MICROMIPS_PC14_S1	ext-0x4
[0-9a-f]+ <[^>]*> aa53 0000 	bnec	s3,s2,[0-9a-f]+ <[^>]+>
			42: R_MICROMIPS_PC14_S1	ext-0x4
[0-9a-f]+ <[^>]*> aa53 0000 	bnec	s3,s2,[0-9a-f]+ <[^>]+>
			46: R_MICROMIPS_PC14_S1	ext-0x4
[0-9a-f]+ <[^>]*> b980      	bnezc	s3,[0-9a-f]+ <[^>]+>
			4a: R_MICROMIPS_PC7_S1	ext-0x2
[0-9a-f]+ <[^>]*> aa60 0000 	bnezc	s3,[0-9a-f]+ <[^>]+>
			4c: R_MICROMIPS_PC14_S1	ext-0x4
[0-9a-f]+ <[^>]*> 8812 8000 	bgezc	s2,[0-9a-f]+ <[^>]+>
			50: R_MICROMIPS_PC14_S1	ext-0x4
[0-9a-f]+ <[^>]*> a812 8000 	bltzc	s2,[0-9a-f]+ <[^>]+>
			54: R_MICROMIPS_PC14_S1	ext-0x4
[0-9a-f]+ <[^>]*> d880      	jrc	a0
[0-9a-f]+ <[^>]*> d840      	jrc	v0
[0-9a-f]+ <[^>]*> 4802 0000 	jrc	v0
[0-9a-f]+ <[^>]*> 2800 0000 	bc	[0-9a-f]+ <[^>]+>
			60: R_MICROMIPS_PC25_S1	.L11-0x4
[0-9a-f]+ <[^>]*> 2800 0000 	bc	[0-9a-f]+ <[^>]*>
			64: R_MICROMIPS_PC25_S1	\*ABS\*\+0xfc
[0-9a-f]+ <[^>]*> 2a00 0000 	balc	[0-9a-f]+ <[^>]+>
			68: R_MICROMIPS_PC25_S1	.L11-0x4
[0-9a-f]+ <[^>]*> 4804 0000 	jrc	a0
[0-9a-f]+ <[^>]*> 4804 0000 	jrc	a0
[0-9a-f]+ <[^>]*> d890      	jalrc	a0
[0-9a-f]+ <[^>]*> 4be4 0000 	jalrc	a0
[0-9a-f]+ <[^>]*> 4885 0000 	jalrc	a0,a1
[0-9a-f]+ <[^>]*> 4885 0000 	jalrc	a0,a1
[0-9a-f]+ <[^>]*> d850      	jalrc	v0
[0-9a-f]+ <[^>]*> d850      	jalrc	v0
[0-9a-f]+ <[^>]*> d850      	jalrc	v0
[0-9a-f]+ <[^>]*> 4804 1000 	jrc.hb	a0
[0-9a-f]+ <[^>]*> 4be4 1000 	jalrc.hb	a0
[0-9a-f]+ <[^>]*> 4885 1000 	jalrc.hb	a0,a1
[0-9a-f]+ <[^>]*> 1d20      	restore.jrc	32
[0-9a-f]+ <[^>]*> 9008      	nop
	...
