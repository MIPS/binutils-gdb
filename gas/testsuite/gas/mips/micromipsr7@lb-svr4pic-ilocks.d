#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS lb-svr4pic-ilocks
#source: lb-pic.s
#as: -32 -KPIC

# Test the lb macro with -KPIC \(microMIPS\).

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> 8480 0000 	lb	a0,0\(zero\)
0+0004 <text_label\+0x4> 8480 0001 	lb	a0,1\(zero\)
0+0008 <text_label\+0x8> e080 8000 	lui	a0,0x8
0+000c <text_label\+0xc> 8484 0000 	lb	a0,0\(a0\)
0+0010 <text_label\+0x10> e09f 8ffd 	lui	a0,0xffff8
0+0014 <text_label\+0x14> 8484 0000 	lb	a0,0\(a0\)
0+0018 <text_label\+0x18> e081 0000 	lui	a0,0x10
0+001c <text_label\+0x1c> 8484 0000 	lb	a0,0\(a0\)
0+0020 <text_label\+0x20> e081 a000 	lui	a0,0x1a
0+0024 <text_label\+0x24> 8484 05a5 	lb	a0,1445\(a0\)
0+0028 <text_label\+0x28> 1650      	lb	a0,0\(a1\)
0+002a <text_label\+0x2a> 1651      	lb	a0,1\(a1\)
0+002c <text_label\+0x2c> e080 8000 	lui	a0,0x8
0+0030 <text_label\+0x30> 20a4 2150 	addu	a0,a0,a1
0+0034 <text_label\+0x34> 8484 0000 	lb	a0,0\(a0\)
0+0038 <text_label\+0x38> e09f 8ffd 	lui	a0,0xffff8
0+003c <text_label\+0x3c> 20a4 2150 	addu	a0,a0,a1
0+0040 <text_label\+0x40> 8484 0000 	lb	a0,0\(a0\)
0+0044 <text_label\+0x44> e081 0000 	lui	a0,0x10
0+0048 <text_label\+0x48> 20a4 2150 	addu	a0,a0,a1
0+004c <text_label\+0x4c> 8484 0000 	lb	a0,0\(a0\)
0+0050 <text_label\+0x50> e081 a000 	lui	a0,0x1a
0+0054 <text_label\+0x54> 20a4 2150 	addu	a0,a0,a1
0+0058 <text_label\+0x58> 8484 05a5 	lb	a0,1445\(a0\)
0+005c <text_label\+0x5c> 849c 8000 	lw	a0,0\(gp\)
			5c: R_MICROMIPS_GOT_PAGE	.data
0+0060 <text_label\+0x60> 8484 0000 	lb	a0,0\(a0\)
			60: R_MICROMIPS_GOT_OFST	.data
0+0064 <text_label\+0x64> 849c 8000 	lw	a0,0\(gp\)
			64: R_MICROMIPS_GOT_PAGE	big_external_data_label
0+0068 <text_label\+0x68> 8484 0000 	lb	a0,0\(a0\)
			68: R_MICROMIPS_GOT_OFST	big_external_data_label
0+006c <text_label\+0x6c> 849c 8000 	lw	a0,0\(gp\)
			6c: R_MICROMIPS_GOT_PAGE	small_external_data_label
0+0070 <text_label\+0x70> 8484 0000 	lb	a0,0\(a0\)
			70: R_MICROMIPS_GOT_OFST	small_external_data_label
0+0074 <text_label\+0x74> 849c 8000 	lw	a0,0\(gp\)
			74: R_MICROMIPS_GOT_PAGE	big_external_common
0+0078 <text_label\+0x78> 8484 0000 	lb	a0,0\(a0\)
			78: R_MICROMIPS_GOT_OFST	big_external_common
0+007c <text_label\+0x7c> 849c 8000 	lw	a0,0\(gp\)
			7c: R_MICROMIPS_GOT_PAGE	small_external_common
0+0080 <text_label\+0x80> 8484 0000 	lb	a0,0\(a0\)
			80: R_MICROMIPS_GOT_OFST	small_external_common
0+0084 <text_label\+0x84> 849c 8000 	lw	a0,0\(gp\)
			84: R_MICROMIPS_GOT_PAGE	\.bss)
0+0088 <text_label\+0x88> 8484 0000 	lb	a0,0\(a0\)
			88: R_MICROMIPS_GOT_OFST	\.bss)
0+008c <text_label\+0x8c> 849c 8000 	lw	a0,0\(gp\)
			8c: R_MICROMIPS_GOT_PAGE	\.bss)\+0x3e8
0+0090 <text_label\+0x90> 8484 0000 	lb	a0,0\(a0\)
			90: R_MICROMIPS_GOT_OFST	\.bss)\+0x3e8
0+0094 <text_label\+0x94> 849c 8000 	lw	a0,0\(gp\)
			94: R_MICROMIPS_GOT_PAGE	.data\+0x1
0+0098 <text_label\+0x98> 8484 0000 	lb	a0,0\(a0\)
			98: R_MICROMIPS_GOT_OFST	.data\+0x1
0+009c <text_label\+0x9c> 849c 8000 	lw	a0,0\(gp\)
			9c: R_MICROMIPS_GOT_PAGE	big_external_data_label\+0x1
0+00a0 <text_label\+0xa0> 8484 0000 	lb	a0,0\(a0\)
			a0: R_MICROMIPS_GOT_OFST	big_external_data_label\+0x1
0+00a4 <text_label\+0xa4> 849c 8000 	lw	a0,0\(gp\)
			a4: R_MICROMIPS_GOT_PAGE	small_external_data_label\+0x1
0+00a8 <text_label\+0xa8> 8484 0000 	lb	a0,0\(a0\)
			a8: R_MICROMIPS_GOT_OFST	small_external_data_label\+0x1
0+00ac <text_label\+0xac> 849c 8000 	lw	a0,0\(gp\)
			ac: R_MICROMIPS_GOT_PAGE	big_external_common\+0x1
0+00b0 <text_label\+0xb0> 8484 0000 	lb	a0,0\(a0\)
			b0: R_MICROMIPS_GOT_OFST	big_external_common\+0x1
0+00b4 <text_label\+0xb4> 849c 8000 	lw	a0,0\(gp\)
			b4: R_MICROMIPS_GOT_PAGE	small_external_common\+0x1
0+00b8 <text_label\+0xb8> 8484 0000 	lb	a0,0\(a0\)
			b8: R_MICROMIPS_GOT_OFST	small_external_common\+0x1
0+00bc <text_label\+0xbc> 849c 8000 	lw	a0,0\(gp\)
			bc: R_MICROMIPS_GOT_PAGE	\.bss)\+0x1
0+00c0 <text_label\+0xc0> 8484 0000 	lb	a0,0\(a0\)
			c0: R_MICROMIPS_GOT_OFST	\.bss)\+0x1
0+00c4 <text_label\+0xc4> 849c 8000 	lw	a0,0\(gp\)
			c4: R_MICROMIPS_GOT_PAGE	\.bss)\+0x3e9
0+00c8 <text_label\+0xc8> 8484 0000 	lb	a0,0\(a0\)
			c8: R_MICROMIPS_GOT_OFST	\.bss)\+0x3e9
0+00cc <text_label\+0xcc> 849c 8000 	lw	a0,0\(gp\)
			cc: R_MICROMIPS_GOT_PAGE	.data
0+00d0 <text_label\+0xd0> 20a4 2150 	addu	a0,a0,a1
0+00d4 <text_label\+0xd4> 8484 0000 	lb	a0,0\(a0\)
			d4: R_MICROMIPS_GOT_OFST	.data
0+00d8 <text_label\+0xd8> 849c 8000 	lw	a0,0\(gp\)
			d8: R_MICROMIPS_GOT_PAGE	big_external_data_label
0+00dc <text_label\+0xdc> 20a4 2150 	addu	a0,a0,a1
0+00e0 <text_label\+0xe0> 8484 0000 	lb	a0,0\(a0\)
			e0: R_MICROMIPS_GOT_OFST	big_external_data_label
0+00e4 <text_label\+0xe4> 849c 8000 	lw	a0,0\(gp\)
			e4: R_MICROMIPS_GOT_PAGE	small_external_data_label
0+00e8 <text_label\+0xe8> 20a4 2150 	addu	a0,a0,a1
0+00ec <text_label\+0xec> 8484 0000 	lb	a0,0\(a0\)
			ec: R_MICROMIPS_GOT_OFST	small_external_data_label
0+00f0 <text_label\+0xf0> 849c 8000 	lw	a0,0\(gp\)
			f0: R_MICROMIPS_GOT_PAGE	big_external_common
0+00f4 <text_label\+0xf4> 20a4 2150 	addu	a0,a0,a1
0+00f8 <text_label\+0xf8> 8484 0000 	lb	a0,0\(a0\)
			f8: R_MICROMIPS_GOT_OFST	big_external_common
0+00fc <text_label\+0xfc> 849c 8000 	lw	a0,0\(gp\)
			fc: R_MICROMIPS_GOT_PAGE	small_external_common
0+0100 <text_label\+0x100> 20a4 2150 	addu	a0,a0,a1
0+0104 <text_label\+0x104> 8484 0000 	lb	a0,0\(a0\)
			104: R_MICROMIPS_GOT_OFST	small_external_common
0+0108 <text_label\+0x108> 849c 8000 	lw	a0,0\(gp\)
			108: R_MICROMIPS_GOT_PAGE	\.bss)
0+010c <text_label\+0x10c> 20a4 2150 	addu	a0,a0,a1
0+0110 <text_label\+0x110> 8484 0000 	lb	a0,0\(a0\)
			110: R_MICROMIPS_GOT_OFST	\.bss)
0+0114 <text_label\+0x114> 849c 8000 	lw	a0,0\(gp\)
			114: R_MICROMIPS_GOT_PAGE	\.bss)\+0x3e8
0+0118 <text_label\+0x118> 20a4 2150 	addu	a0,a0,a1
0+011c <text_label\+0x11c> 8484 0000 	lb	a0,0\(a0\)
			11c: R_MICROMIPS_GOT_OFST	\.bss)\+0x3e8
0+0120 <text_label\+0x120> 849c 8000 	lw	a0,0\(gp\)
			120: R_MICROMIPS_GOT_PAGE	.data\+0x1
0+0124 <text_label\+0x124> 20a4 2150 	addu	a0,a0,a1
0+0128 <text_label\+0x128> 8484 0000 	lb	a0,0\(a0\)
			128: R_MICROMIPS_GOT_OFST	.data\+0x1
0+012c <text_label\+0x12c> 849c 8000 	lw	a0,0\(gp\)
			12c: R_MICROMIPS_GOT_PAGE	big_external_data_label\+0x1
0+0130 <text_label\+0x130> 20a4 2150 	addu	a0,a0,a1
0+0134 <text_label\+0x134> 8484 0000 	lb	a0,0\(a0\)
			134: R_MICROMIPS_GOT_OFST	big_external_data_label\+0x1
0+0138 <text_label\+0x138> 849c 8000 	lw	a0,0\(gp\)
			138: R_MICROMIPS_GOT_PAGE	small_external_data_label\+0x1
0+013c <text_label\+0x13c> 20a4 2150 	addu	a0,a0,a1
0+0140 <text_label\+0x140> 8484 0000 	lb	a0,0\(a0\)
			140: R_MICROMIPS_GOT_OFST	small_external_data_label\+0x1
0+0144 <text_label\+0x144> 849c 8000 	lw	a0,0\(gp\)
			144: R_MICROMIPS_GOT_PAGE	big_external_common\+0x1
0+0148 <text_label\+0x148> 20a4 2150 	addu	a0,a0,a1
0+014c <text_label\+0x14c> 8484 0000 	lb	a0,0\(a0\)
			14c: R_MICROMIPS_GOT_OFST	big_external_common\+0x1
0+0150 <text_label\+0x150> 849c 8000 	lw	a0,0\(gp\)
			150: R_MICROMIPS_GOT_PAGE	small_external_common\+0x1
0+0154 <text_label\+0x154> 20a4 2150 	addu	a0,a0,a1
0+0158 <text_label\+0x158> 8484 0000 	lb	a0,0\(a0\)
			158: R_MICROMIPS_GOT_OFST	small_external_common\+0x1
0+015c <text_label\+0x15c> 849c 8000 	lw	a0,0\(gp\)
			15c: R_MICROMIPS_GOT_PAGE	\.bss)\+0x1
0+0160 <text_label\+0x160> 20a4 2150 	addu	a0,a0,a1
0+0164 <text_label\+0x164> 8484 0000 	lb	a0,0\(a0\)
			164: R_MICROMIPS_GOT_OFST	\.bss)\+0x1
0+0168 <text_label\+0x168> 849c 8000 	lw	a0,0\(gp\)
			168: R_MICROMIPS_GOT_PAGE	\.bss)\+0x3e9
0+016c <text_label\+0x16c> 20a4 2150 	addu	a0,a0,a1
0+0170 <text_label\+0x170> 8484 0000 	lb	a0,0\(a0\)
			170: R_MICROMIPS_GOT_OFST	\.bss)\+0x3e9
0+0174 <text_label\+0x174> 9008      	nop
0+0176 <text_label\+0x176> 9008      	nop
