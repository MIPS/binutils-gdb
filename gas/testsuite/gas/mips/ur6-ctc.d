#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS microMIPS pre-R6 to R6 mapping
#as: -32

# Check mapping of microMIPS pre-R6 to R6 translation

.*.o:     file format elf32-trad.*mips


Disassembly of section .text:
0+0000 <[^>]*> cfff      	bc	00000000 <[^>]*>
[	]*0: R_MICROMIPS_PC10_S1	.L11
0+0002 <[^>]*> cfff      	bc	00000002 <[^>]*>
[	]*2: R_MICROMIPS_PC10_S1	.L11
0+0004 <[^>]*> 97ff fffe 	bc	00000004 <[^>]*>
[	]*4: R_MICROMIPS_PC26_S1	.L11
0+0008 <[^>]*> b7ff fffe 	balc	00000008 <[^>]*>
[	]*8: R_MICROMIPS_PC26_S1	.L11
0+000c <[^>]*> a05f fffe 	beqzc	v0,0000000c <[^>]*>
[	]*c: R_MICROMIPS_PC21_S1	.L11
0+0010 <[^>]*> a05f fffe 	beqzc	v0,00000010 <[^>]*>
[	]*10: R_MICROMIPS_PC21_S1	.L11
0+0014 <[^>]*> 8d7f      	beqzc	v0,00000014 <[^>]*>
[	]*14: R_MICROMIPS_PC7_S1	.L11
0+0016 <[^>]*> 8dff      	beqzc	v1,00000016 <[^>]*>
[	]*16: R_MICROMIPS_PC7_S1	ext
0+0018 <[^>]*> 8dff      	beqzc	v1,00000018 <[^>]*>
[	]*18: R_MICROMIPS_PC7_S1	ext
0+001a <[^>]*> a07f fffe 	beqzc	v1,0000001a <[^>]*>
[	]*1a: R_MICROMIPS_PC21_S1	ext
0+001e <[^>]*> a07f fffe 	beqzc	v1,0000001e <[^>]*>
[	]*1e: R_MICROMIPS_PC21_S1	ext
0+0022 <[^>]*> 7462 fffe 	beqc	v0,v1,00000022 <[^>]*>
[	]*22: R_MICROMIPS_PC16_S1	ext
0+0026 <[^>]*> 7462 fffe 	beqc	v0,v1,00000026 <[^>]*>
[	]*26: R_MICROMIPS_PC16_S1	ext
0+002a <[^>]*> 8dff      	beqzc	v1,0000002a <[^>]*>
[	]*2a: R_MICROMIPS_PC7_S1	ext
0+002c <[^>]*> a07f fffe 	beqzc	v1,0000002c <[^>]*>
[	]*2c: R_MICROMIPS_PC21_S1	ext
0+0030 <[^>]*> a45f fffe 	bnezc	v0,00000030 <[^>]*>
[	]*30: R_MICROMIPS_PC21_S1	.L11
0+0034 <[^>]*> a45f fffe 	bnezc	v0,00000034 <[^>]*>
[	]*34: R_MICROMIPS_PC21_S1	.L11
0+0038 <[^>]*> ad7f      	bnezc	v0,00000038 <[^>]*>
[	]*38: R_MICROMIPS_PC7_S1	.L11
0+003a <[^>]*> adff      	bnezc	v1,0000003a <[^>]*>
[	]*3a: R_MICROMIPS_PC7_S1	ext
0+003c <[^>]*> adff      	bnezc	v1,0000003c <[^>]*>
[	]*3c: R_MICROMIPS_PC7_S1	ext
0+003e <[^>]*> a47f fffe 	bnezc	v1,0000003e <[^>]*>
[	]*3e: R_MICROMIPS_PC21_S1	ext
0+0042 <[^>]*> 7c62 fffe 	bnec	v0,v1,00000042 <[^>]*>
[	]*42: R_MICROMIPS_PC16_S1	ext
0+0046 <[^>]*> 7c62 fffe 	bnec	v0,v1,00000046 <[^>]*>
[	]*46: R_MICROMIPS_PC16_S1	ext
0+004a <[^>]*> adff      	bnezc	v1,0000004a <[^>]*>
[	]*4a: R_MICROMIPS_PC7_S1	ext
0+004c <[^>]*> a47f fffe 	bnezc	v1,0000004c <[^>]*>
[	]*4c: R_MICROMIPS_PC21_S1	ext
0+0050 <[^>]*> e442 fffe 	bgezc	v0,00000050 <[^>]*>
[	]*50: R_MICROMIPS_PC16_S1	ext
0+0054 <[^>]*> c442 fffe 	bltzc	v0,00000054 <[^>]*>
[	]*54: R_MICROMIPS_PC16_S1	ext
0+0058 <[^>]*> e042 fffe 	bltzalc	v0,00000058 <[^>]*>
[	]*58: R_MICROMIPS_PC16_S1	ext
0+005c <[^>]*> 4483      	jrc	a0
0+005e <[^>]*> 4443      	jrc	v0
0+0060 <[^>]*> a002 0000 	jic	v0,0
0+0064 <[^>]*> 97ff fffe 	bc	00000064 <[^>]*>
[	]*64: R_MICROMIPS_PC26_S1	.L11
0+0068 <[^>]*> 97ff fffe 	bc	00000068 <[^>]*>
[	]*68: R_MICROMIPS_PC26_S1	.L11
0+006c <[^>]*> b7ff fffe 	balc	0000006c <[^>]*>
[	]*6c: R_MICROMIPS_PC26_S1	.L11
0+0070 <[^>]*> a004 0000 	jic	a0,0
0+0074 <[^>]*> a004 0000 	jic	a0,0
0+0078 <[^>]*> 448b      	jalrc	a0
0+007a <[^>]*> 03e4 0f3c 	jalrc	a0
0+007e <[^>]*> 0085 0f3c 	jalrc	a0,a1
0+0082 <[^>]*> 0085 0f3c 	jalrc	a0,a1
0+0086 <[^>]*> 444b      	jalrc	v0
0+0088 <[^>]*> 444b      	jalrc	v0
0+008a <[^>]*> 444b      	jalrc	v0
0+008c <[^>]*> 0004 1f3c 	jrc.hb	a0
0+0090 <[^>]*> 03e4 1f3c 	jalrc.hb	a0
0+0094 <[^>]*> 0085 1f3c 	jalrc.hb	a0,a1
0+0098 <[^>]*> 4513      	jrcaddiusp	32
0+009a <[^>]*> cfff      	bc	0000009a <[^>]*>
[	]*9a: R_MICROMIPS_PC10_S1	.L11
0+009c <[^>]*> 0c00      	nop
0+009e <[^>]*> cfff      	bc	0000009e <[^>]*>
[	]*9e: R_MICROMIPS_PC10_S1	.L11
0+00a0 <[^>]*> 0c00      	nop
0+00a2 <[^>]*> 97ff fffe 	bc	000000a2 <[^>]*>
[	]*a2: R_MICROMIPS_PC26_S1	.L11
0+00a6 <[^>]*> 0c00      	nop
0+00a8 <[^>]*> b7ff fffe 	balc	000000a8 <[^>]*>
[	]*a8: R_MICROMIPS_PC26_S1	.L11
0+00ac <[^>]*> 0c00      	nop
0+00ae <[^>]*> a05f fffe 	beqzc	v0,000000ae <[^>]*>
[	]*ae: R_MICROMIPS_PC21_S1	.L11
0+00b2 <[^>]*> 0c00      	nop
0+00b4 <[^>]*> a05f fffe 	beqzc	v0,000000b4 <[^>]*>
[	]*b4: R_MICROMIPS_PC21_S1	.L11
0+00b8 <[^>]*> 0c00      	nop
0+00ba <[^>]*> 8d7f      	beqzc	v0,000000ba <[^>]*>
[	]*ba: R_MICROMIPS_PC7_S1	.L11
0+00bc <[^>]*> 0c00      	nop
0+00be <[^>]*> 8dff      	beqzc	v1,000000be <[^>]*>
[	]*be: R_MICROMIPS_PC7_S1	ext
0+00c0 <[^>]*> 0c00      	nop
0+00c2 <[^>]*> 8dff      	beqzc	v1,000000c2 <[^>]*>
[	]*c2: R_MICROMIPS_PC7_S1	ext
0+00c4 <[^>]*> 0c00      	nop
0+00c6 <[^>]*> a07f fffe 	beqzc	v1,000000c6 <[^>]*>
[	]*c6: R_MICROMIPS_PC21_S1	ext
0+00ca <[^>]*> 0c00      	nop
0+00cc <[^>]*> a07f fffe 	beqzc	v1,000000cc <[^>]*>
[	]*cc: R_MICROMIPS_PC21_S1	ext
0+00d0 <[^>]*> 0c00      	nop
0+00d2 <[^>]*> 7462 fffe 	beqc	v0,v1,000000d2 <[^>]*>
[	]*d2: R_MICROMIPS_PC16_S1	ext
0+00d6 <[^>]*> 0c00      	nop
0+00d8 <[^>]*> 7462 fffe 	beqc	v0,v1,000000d8 <[^>]*>
[	]*d8: R_MICROMIPS_PC16_S1	ext
0+00dc <[^>]*> 0c00      	nop
0+00de <[^>]*> 8dff      	beqzc	v1,000000de <[^>]*>
[	]*de: R_MICROMIPS_PC7_S1	ext
0+00e0 <[^>]*> 0c00      	nop
0+00e2 <[^>]*> a07f fffe 	beqzc	v1,000000e2 <[^>]*>
[	]*e2: R_MICROMIPS_PC21_S1	ext
0+00e6 <[^>]*> 0c00      	nop
0+00e8 <[^>]*> a45f fffe 	bnezc	v0,000000e8 <[^>]*>
[	]*e8: R_MICROMIPS_PC21_S1	.L11
0+00ec <[^>]*> 0c00      	nop
0+00ee <[^>]*> a45f fffe 	bnezc	v0,000000ee <[^>]*>
[	]*ee: R_MICROMIPS_PC21_S1	.L11
0+00f2 <[^>]*> 0c00      	nop
0+00f4 <[^>]*> ad7f      	bnezc	v0,000000f4 <[^>]*>
[	]*f4: R_MICROMIPS_PC7_S1	.L11
0+00f6 <[^>]*> 0c00      	nop
0+00f8 <[^>]*> adff      	bnezc	v1,000000f8 <[^>]*>
[	]*f8: R_MICROMIPS_PC7_S1	ext
0+00fa <[^>]*> 0c00      	nop
0+00fc <[^>]*> adff      	bnezc	v1,000000fc <[^>]*>
[	]*fc: R_MICROMIPS_PC7_S1	ext
0+00fe <[^>]*> 0c00      	nop
0+0100 <[^>]*> a47f fffe 	bnezc	v1,00000100 <[^>]*>
[	]*100: R_MICROMIPS_PC21_S1	ext
0+0104 <[^>]*> 0c00      	nop
0+0106 <[^>]*> 7c62 fffe 	bnec	v0,v1,00000106 <[^>]*>
[	]*106: R_MICROMIPS_PC16_S1	ext
0+010a <[^>]*> 0c00      	nop
0+010c <[^>]*> 7c62 fffe 	bnec	v0,v1,0000010c <[^>]*>
[	]*10c: R_MICROMIPS_PC16_S1	ext
0+0110 <[^>]*> 0c00      	nop
0+0112 <[^>]*> adff      	bnezc	v1,00000112 <[^>]*>
[	]*112: R_MICROMIPS_PC7_S1	ext
0+0114 <[^>]*> 0c00      	nop
0+0116 <[^>]*> a47f fffe 	bnezc	v1,00000116 <[^>]*>
[	]*116: R_MICROMIPS_PC21_S1	ext
0+011a <[^>]*> 0c00      	nop
0+011c <[^>]*> e442 fffe 	bgezc	v0,0000011c <[^>]*>
[	]*11c: R_MICROMIPS_PC16_S1	ext
0+0120 <[^>]*> 0c00      	nop
0+0122 <[^>]*> c442 fffe 	bltzc	v0,00000122 <[^>]*>
[	]*122: R_MICROMIPS_PC16_S1	ext
0+0126 <[^>]*> 0c00      	nop
0+0128 <[^>]*> e042 fffe 	bltzalc	v0,00000128 <[^>]*>
[	]*128: R_MICROMIPS_PC16_S1	ext
0+012c <[^>]*> 0c00      	nop
0+012e <[^>]*> 4483      	jrc	a0
0+0130 <[^>]*> 0c00      	nop
0+0132 <[^>]*> 4443      	jrc	v0
0+0134 <[^>]*> 0c00      	nop
0+0136 <[^>]*> a002 0000 	jic	v0,0
0+013a <[^>]*> 0c00      	nop
0+013c <[^>]*> 97ff fffe 	bc	0000013c <[^>]*>
[	]*13c: R_MICROMIPS_PC26_S1	.L11
0+0140 <[^>]*> 0c00      	nop
0+0142 <[^>]*> 97ff fffe 	bc	00000142 <[^>]*>
[	]*142: R_MICROMIPS_PC26_S1	.L11
0+0146 <[^>]*> 0c00      	nop
0+0148 <[^>]*> b7ff fffe 	balc	00000148 <[^>]*>
[	]*148: R_MICROMIPS_PC26_S1	.L11
0+014c <[^>]*> 0c00      	nop
0+014e <[^>]*> a004 0000 	jic	a0,0
0+0152 <[^>]*> 0c00      	nop
0+0154 <[^>]*> a004 0000 	jic	a0,0
0+0158 <[^>]*> 0c00      	nop
0+015a <[^>]*> 448b      	jalrc	a0
0+015c <[^>]*> 0c00      	nop
0+015e <[^>]*> 03e4 0f3c 	jalrc	a0
0+0162 <[^>]*> 0c00      	nop
0+0164 <[^>]*> 0085 0f3c 	jalrc	a0,a1
0+0168 <[^>]*> 0c00      	nop
0+016a <[^>]*> 0085 0f3c 	jalrc	a0,a1
0+016e <[^>]*> 0c00      	nop
0+0170 <[^>]*> 444b      	jalrc	v0
0+0172 <[^>]*> 0c00      	nop
0+0174 <[^>]*> 444b      	jalrc	v0
0+0176 <[^>]*> 0c00      	nop
0+0178 <[^>]*> 444b      	jalrc	v0
0+017a <[^>]*> 0c00      	nop
0+017c <[^>]*> 0004 1f3c 	jrc.hb	a0
0+0180 <[^>]*> 0c00      	nop
0+0182 <[^>]*> 03e4 1f3c 	jalrc.hb	a0
0+0186 <[^>]*> 0c00      	nop
0+0188 <[^>]*> 0085 1f3c 	jalrc.hb	a0,a1
0+018c <[^>]*> 0c00      	nop
0+018e <[^>]*> 4513      	jrcaddiusp	32
0+0190 <[^>]*> ed0f      	li	v0,15
0+0192 <[^>]*> 0c00      	nop
