#objdump: -dr --prefix-addresses --show-raw-insn
#as: -mmicromips -mips32r7 -32 --defsym tl_d=1
#name: microMIPS R7 l.d
#source: ld.s

# Test the l.d macro.

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> 8480 e000 	ldc1	\$f4,0\(zero\)
0+0004 <text_label\+0x4> 8480 e001 	ldc1	\$f4,1\(zero\)
0+0008 <text_label\+0x8> e020 8000 	lui	at,0x8
0+000c <text_label\+0xc> 8481 e000 	ldc1	\$f4,0\(at\)
0+0010 <text_label\+0x10> e03f 8ffd 	lui	at,0xffff8
0+0014 <text_label\+0x14> 8481 e000 	ldc1	\$f4,0\(at\)
0+0018 <text_label\+0x18> e021 0000 	lui	at,0x10
0+001c <text_label\+0x1c> 8481 e000 	ldc1	\$f4,0\(at\)
0+0020 <text_label\+0x20> e021 a000 	lui	at,0x1a
0+0024 <text_label\+0x24> 8481 e5a5 	ldc1	\$f4,1445\(at\)
0+0028 <text_label\+0x28> 8485 e000 	ldc1	\$f4,0\(a1\)
0+002c <text_label\+0x2c> 8485 e001 	ldc1	\$f4,1\(a1\)
0+0030 <text_label\+0x30> e020 8000 	lui	at,0x8
0+0034 <text_label\+0x34> 20a1 0950 	addu	at,at,a1
0+0038 <text_label\+0x38> 8481 e000 	ldc1	\$f4,0\(at\)
0+003c <text_label\+0x3c> e03f 8ffd 	lui	at,0xffff8
0+0040 <text_label\+0x40> 20a1 0950 	addu	at,at,a1
0+0044 <text_label\+0x44> 8481 e000 	ldc1	\$f4,0\(at\)
0+0048 <text_label\+0x48> e021 0000 	lui	at,0x10
0+004c <text_label\+0x4c> 20a1 0950 	addu	at,at,a1
0+0050 <text_label\+0x50> 8481 e000 	ldc1	\$f4,0\(at\)
0+0054 <text_label\+0x54> e021 a000 	lui	at,0x1a
0+0058 <text_label\+0x58> 20a1 0950 	addu	at,at,a1
0+005c <text_label\+0x5c> 8481 e5a5 	ldc1	\$f4,1445\(at\)
0+0060 <text_label\+0x60> e020 0000 	lui	at,0x0
			60: R_MICROMIPS_HI20	.data
0+0064 <text_label\+0x64> 8481 e000 	ldc1	\$f4,0\(at\)
			64: R_MICROMIPS_LO12	.data
0+0068 <text_label\+0x68> e020 0000 	lui	at,0x0
			68: R_MICROMIPS_HI20	big_external_data_label
0+006c <text_label\+0x6c> 8481 e000 	ldc1	\$f4,0\(at\)
			6c: R_MICROMIPS_LO12	big_external_data_label
0+0070 <text_label\+0x70> 448c 0002 	ldc1	\$f4,0\(gp\)
			70: R_MICROMIPS_GPREL16_S2	small_external_data_label
0+0074 <text_label\+0x74> e020 0000 	lui	at,0x0
			74: R_MICROMIPS_HI20	big_external_common
0+0078 <text_label\+0x78> 8481 e000 	ldc1	\$f4,0\(at\)
			78: R_MICROMIPS_LO12	big_external_common
0+007c <text_label\+0x7c> 448c 0002 	ldc1	\$f4,0\(gp\)
			7c: R_MICROMIPS_GPREL16_S2	small_external_common
0+0080 <text_label\+0x80> e020 0000 	lui	at,0x0
			80: R_MICROMIPS_HI20	.bss
0+0084 <text_label\+0x84> 8481 e000 	ldc1	\$f4,0\(at\)
			84: R_MICROMIPS_LO12	.bss
0+0088 <text_label\+0x88> 448c 0002 	ldc1	\$f4,0\(gp\)
			88: R_MICROMIPS_GPREL16_S2	.sbss
0+008c <text_label\+0x8c> e020 0000 	lui	at,0x0
			8c: R_MICROMIPS_HI20	.data\+0x1
0+0090 <text_label\+0x90> 8481 e000 	ldc1	\$f4,0\(at\)
			90: R_MICROMIPS_LO12	.data\+0x1
0+0094 <text_label\+0x94> e020 0000 	lui	at,0x0
			94: R_MICROMIPS_HI20	big_external_data_label\+0x1
0+0098 <text_label\+0x98> 8481 e000 	ldc1	\$f4,0\(at\)
			98: R_MICROMIPS_LO12	big_external_data_label\+0x1
0+009c <text_label\+0x9c> 448c 0002 	ldc1	\$f4,0\(gp\)
			9c: R_MICROMIPS_GPREL16_S2	small_external_data_label\+0x1
0+00a0 <text_label\+0xa0> e020 0000 	lui	at,0x0
			a0: R_MICROMIPS_HI20	big_external_common\+0x1
0+00a4 <text_label\+0xa4> 8481 e000 	ldc1	\$f4,0\(at\)
			a4: R_MICROMIPS_LO12	big_external_common\+0x1
0+00a8 <text_label\+0xa8> 448c 0002 	ldc1	\$f4,0\(gp\)
			a8: R_MICROMIPS_GPREL16_S2	small_external_common\+0x1
0+00ac <text_label\+0xac> e020 0000 	lui	at,0x0
			ac: R_MICROMIPS_HI20	.bss\+0x1
0+00b0 <text_label\+0xb0> 8481 e000 	ldc1	\$f4,0\(at\)
			b0: R_MICROMIPS_LO12	.bss\+0x1
0+00b4 <text_label\+0xb4> 448c 0002 	ldc1	\$f4,0\(gp\)
			b4: R_MICROMIPS_GPREL16_S2	.sbss\+0x1
0+00b8 <text_label\+0xb8> e020 0000 	lui	at,0x0
			b8: R_MICROMIPS_HI20	.data\+0x8000
0+00bc <text_label\+0xbc> 8481 e000 	ldc1	\$f4,0\(at\)
			bc: R_MICROMIPS_LO12	.data\+0x8000
0+00c0 <text_label\+0xc0> e020 0000 	lui	at,0x0
			c0: R_MICROMIPS_HI20	big_external_data_label\+0x8000
0+00c4 <text_label\+0xc4> 8481 e000 	ldc1	\$f4,0\(at\)
			c4: R_MICROMIPS_LO12	big_external_data_label\+0x8000
0+00c8 <text_label\+0xc8> e020 0000 	lui	at,0x0
			c8: R_MICROMIPS_HI20	small_external_data_label\+0x8000
0+00cc <text_label\+0xcc> 8481 e000 	ldc1	\$f4,0\(at\)
			cc: R_MICROMIPS_LO12	small_external_data_label\+0x8000
0+00d0 <text_label\+0xd0> e020 0000 	lui	at,0x0
			d0: R_MICROMIPS_HI20	big_external_common\+0x8000
0+00d4 <text_label\+0xd4> 8481 e000 	ldc1	\$f4,0\(at\)
			d4: R_MICROMIPS_LO12	big_external_common\+0x8000
0+00d8 <text_label\+0xd8> e020 0000 	lui	at,0x0
			d8: R_MICROMIPS_HI20	small_external_common\+0x8000
0+00dc <text_label\+0xdc> 8481 e000 	ldc1	\$f4,0\(at\)
			dc: R_MICROMIPS_LO12	small_external_common\+0x8000
0+00e0 <text_label\+0xe0> e020 0000 	lui	at,0x0
			e0: R_MICROMIPS_HI20	.bss\+0x8000
0+00e4 <text_label\+0xe4> 8481 e000 	ldc1	\$f4,0\(at\)
			e4: R_MICROMIPS_LO12	.bss\+0x8000
0+00e8 <text_label\+0xe8> e020 0000 	lui	at,0x0
			e8: R_MICROMIPS_HI20	.sbss\+0x8000
0+00ec <text_label\+0xec> 8481 e000 	ldc1	\$f4,0\(at\)
			ec: R_MICROMIPS_LO12	.sbss\+0x8000
0+00f0 <text_label\+0xf0> e020 0000 	lui	at,0x0
			f0: R_MICROMIPS_HI20	.data-0x8000
0+00f4 <text_label\+0xf4> 8481 e000 	ldc1	\$f4,0\(at\)
			f4: R_MICROMIPS_LO12	.data-0x8000
0+00f8 <text_label\+0xf8> e020 0000 	lui	at,0x0
			f8: R_MICROMIPS_HI20	big_external_data_label-0x8000
0+00fc <text_label\+0xfc> 8481 e000 	ldc1	\$f4,0\(at\)
			fc: R_MICROMIPS_LO12	big_external_data_label-0x8000
0+0100 <text_label\+0x100> e020 0000 	lui	at,0x0
			100: R_MICROMIPS_HI20	small_external_data_label-0x8000
0+0104 <text_label\+0x104> 8481 e000 	ldc1	\$f4,0\(at\)
			104: R_MICROMIPS_LO12	small_external_data_label-0x8000
0+0108 <text_label\+0x108> e020 0000 	lui	at,0x0
			108: R_MICROMIPS_HI20	big_external_common-0x8000
0+010c <text_label\+0x10c> 8481 e000 	ldc1	\$f4,0\(at\)
			10c: R_MICROMIPS_LO12	big_external_common-0x8000
0+0110 <text_label\+0x110> e020 0000 	lui	at,0x0
			110: R_MICROMIPS_HI20	small_external_common-0x8000
0+0114 <text_label\+0x114> 8481 e000 	ldc1	\$f4,0\(at\)
			114: R_MICROMIPS_LO12	small_external_common-0x8000
0+0118 <text_label\+0x118> e020 0000 	lui	at,0x0
			118: R_MICROMIPS_HI20	.bss-0x8000
0+011c <text_label\+0x11c> 8481 e000 	ldc1	\$f4,0\(at\)
			11c: R_MICROMIPS_LO12	.bss-0x8000
0+0120 <text_label\+0x120> e020 0000 	lui	at,0x0
			120: R_MICROMIPS_HI20	.sbss-0x8000
0+0124 <text_label\+0x124> 8481 e000 	ldc1	\$f4,0\(at\)
			124: R_MICROMIPS_LO12	.sbss-0x8000
0+0128 <text_label\+0x128> e020 0000 	lui	at,0x0
			128: R_MICROMIPS_HI20	.data\+0x10000
0+012c <text_label\+0x12c> 8481 e000 	ldc1	\$f4,0\(at\)
			12c: R_MICROMIPS_LO12	.data\+0x10000
0+0130 <text_label\+0x130> e020 0000 	lui	at,0x0
			130: R_MICROMIPS_HI20	big_external_data_label\+0x10000
0+0134 <text_label\+0x134> 8481 e000 	ldc1	\$f4,0\(at\)
			134: R_MICROMIPS_LO12	big_external_data_label\+0x10000
0+0138 <text_label\+0x138> e020 0000 	lui	at,0x0
			138: R_MICROMIPS_HI20	small_external_data_label\+0x10000
0+013c <text_label\+0x13c> 8481 e000 	ldc1	\$f4,0\(at\)
			13c: R_MICROMIPS_LO12	small_external_data_label\+0x10000
0+0140 <text_label\+0x140> e020 0000 	lui	at,0x0
			140: R_MICROMIPS_HI20	big_external_common\+0x10000
0+0144 <text_label\+0x144> 8481 e000 	ldc1	\$f4,0\(at\)
			144: R_MICROMIPS_LO12	big_external_common\+0x10000
0+0148 <text_label\+0x148> e020 0000 	lui	at,0x0
			148: R_MICROMIPS_HI20	small_external_common\+0x10000
0+014c <text_label\+0x14c> 8481 e000 	ldc1	\$f4,0\(at\)
			14c: R_MICROMIPS_LO12	small_external_common\+0x10000
0+0150 <text_label\+0x150> e020 0000 	lui	at,0x0
			150: R_MICROMIPS_HI20	.bss\+0x10000
0+0154 <text_label\+0x154> 8481 e000 	ldc1	\$f4,0\(at\)
			154: R_MICROMIPS_LO12	.bss\+0x10000
0+0158 <text_label\+0x158> e020 0000 	lui	at,0x0
			158: R_MICROMIPS_HI20	.sbss\+0x10000
0+015c <text_label\+0x15c> 8481 e000 	ldc1	\$f4,0\(at\)
			15c: R_MICROMIPS_LO12	.sbss\+0x10000
0+0160 <text_label\+0x160> e020 0000 	lui	at,0x0
			160: R_MICROMIPS_HI20	.data\+0x1a5a5
0+0164 <text_label\+0x164> 8481 e000 	ldc1	\$f4,0\(at\)
			164: R_MICROMIPS_LO12	.data\+0x1a5a5
0+0168 <text_label\+0x168> e020 0000 	lui	at,0x0
			168: R_MICROMIPS_HI20	big_external_data_label\+0x1a5a5
0+016c <text_label\+0x16c> 8481 e000 	ldc1	\$f4,0\(at\)
			16c: R_MICROMIPS_LO12	big_external_data_label\+0x1a5a5
0+0170 <text_label\+0x170> e020 0000 	lui	at,0x0
			170: R_MICROMIPS_HI20	small_external_data_label\+0x1a5a5
0+0174 <text_label\+0x174> 8481 e000 	ldc1	\$f4,0\(at\)
			174: R_MICROMIPS_LO12	small_external_data_label\+0x1a5a5
0+0178 <text_label\+0x178> e020 0000 	lui	at,0x0
			178: R_MICROMIPS_HI20	big_external_common\+0x1a5a5
0+017c <text_label\+0x17c> 8481 e000 	ldc1	\$f4,0\(at\)
			17c: R_MICROMIPS_LO12	big_external_common\+0x1a5a5
0+0180 <text_label\+0x180> e020 0000 	lui	at,0x0
			180: R_MICROMIPS_HI20	small_external_common\+0x1a5a5
0+0184 <text_label\+0x184> 8481 e000 	ldc1	\$f4,0\(at\)
			184: R_MICROMIPS_LO12	small_external_common\+0x1a5a5
0+0188 <text_label\+0x188> e020 0000 	lui	at,0x0
			188: R_MICROMIPS_HI20	.bss\+0x1a5a5
0+018c <text_label\+0x18c> 8481 e000 	ldc1	\$f4,0\(at\)
			18c: R_MICROMIPS_LO12	.bss\+0x1a5a5
0+0190 <text_label\+0x190> e020 0000 	lui	at,0x0
			190: R_MICROMIPS_HI20	.sbss\+0x1a5a5
0+0194 <text_label\+0x194> 8481 e000 	ldc1	\$f4,0\(at\)
			194: R_MICROMIPS_LO12	.sbss\+0x1a5a5
0+0198 <text_label\+0x198> e020 0000 	lui	at,0x0
			198: R_MICROMIPS_HI20	.data
0+019c <text_label\+0x19c> 20a1 0950 	addu	at,at,a1
0+01a0 <text_label\+0x1a0> 8481 e000 	ldc1	\$f4,0\(at\)
			1a0: R_MICROMIPS_LO12	.data
0+01a4 <text_label\+0x1a4> e020 0000 	lui	at,0x0
			1a4: R_MICROMIPS_HI20	big_external_data_label
0+01a8 <text_label\+0x1a8> 20a1 0950 	addu	at,at,a1
0+01ac <text_label\+0x1ac> 8481 e000 	ldc1	\$f4,0\(at\)
			1ac: R_MICROMIPS_LO12	big_external_data_label
0+01b0 <text_label\+0x1b0> 2385 0950 	addu	at,a1,gp
0+01b4 <text_label\+0x1b4> 8481 e000 	ldc1	\$f4,0\(at\)
			1b4: R_MICROMIPS_LO12	small_external_data_label
0+01b8 <text_label\+0x1b8> e020 0000 	lui	at,0x0
			1b8: R_MICROMIPS_HI20	big_external_common
0+01bc <text_label\+0x1bc> 20a1 0950 	addu	at,at,a1
0+01c0 <text_label\+0x1c0> 8481 e000 	ldc1	\$f4,0\(at\)
			1c0: R_MICROMIPS_LO12	big_external_common
0+01c4 <text_label\+0x1c4> 2385 0950 	addu	at,a1,gp
0+01c8 <text_label\+0x1c8> 8481 e000 	ldc1	\$f4,0\(at\)
			1c8: R_MICROMIPS_LO12	small_external_common
0+01cc <text_label\+0x1cc> e020 0000 	lui	at,0x0
			1cc: R_MICROMIPS_HI20	.bss
0+01d0 <text_label\+0x1d0> 20a1 0950 	addu	at,at,a1
0+01d4 <text_label\+0x1d4> 8481 e000 	ldc1	\$f4,0\(at\)
			1d4: R_MICROMIPS_LO12	.bss
0+01d8 <text_label\+0x1d8> 2385 0950 	addu	at,a1,gp
0+01dc <text_label\+0x1dc> 8481 e000 	ldc1	\$f4,0\(at\)
			1dc: R_MICROMIPS_LO12	.sbss
0+01e0 <text_label\+0x1e0> e020 0000 	lui	at,0x0
			1e0: R_MICROMIPS_HI20	.data\+0x1
0+01e4 <text_label\+0x1e4> 20a1 0950 	addu	at,at,a1
0+01e8 <text_label\+0x1e8> 8481 e000 	ldc1	\$f4,0\(at\)
			1e8: R_MICROMIPS_LO12	.data\+0x1
0+01ec <text_label\+0x1ec> e020 0000 	lui	at,0x0
			1ec: R_MICROMIPS_HI20	big_external_data_label\+0x1
0+01f0 <text_label\+0x1f0> 20a1 0950 	addu	at,at,a1
0+01f4 <text_label\+0x1f4> 8481 e000 	ldc1	\$f4,0\(at\)
			1f4: R_MICROMIPS_LO12	big_external_data_label\+0x1
0+01f8 <text_label\+0x1f8> 2385 0950 	addu	at,a1,gp
0+01fc <text_label\+0x1fc> 8481 e000 	ldc1	\$f4,0\(at\)
			1fc: R_MICROMIPS_LO12	small_external_data_label\+0x1
0+0200 <text_label\+0x200> e020 0000 	lui	at,0x0
			200: R_MICROMIPS_HI20	big_external_common\+0x1
0+0204 <text_label\+0x204> 20a1 0950 	addu	at,at,a1
0+0208 <text_label\+0x208> 8481 e000 	ldc1	\$f4,0\(at\)
			208: R_MICROMIPS_LO12	big_external_common\+0x1
0+020c <text_label\+0x20c> 2385 0950 	addu	at,a1,gp
0+0210 <text_label\+0x210> 8481 e000 	ldc1	\$f4,0\(at\)
			210: R_MICROMIPS_LO12	small_external_common\+0x1
0+0214 <text_label\+0x214> e020 0000 	lui	at,0x0
			214: R_MICROMIPS_HI20	.bss\+0x1
0+0218 <text_label\+0x218> 20a1 0950 	addu	at,at,a1
0+021c <text_label\+0x21c> 8481 e000 	ldc1	\$f4,0\(at\)
			21c: R_MICROMIPS_LO12	.bss\+0x1
0+0220 <text_label\+0x220> 2385 0950 	addu	at,a1,gp
0+0224 <text_label\+0x224> 8481 e000 	ldc1	\$f4,0\(at\)
			224: R_MICROMIPS_LO12	.sbss\+0x1
0+0228 <text_label\+0x228> e020 0000 	lui	at,0x0
			228: R_MICROMIPS_HI20	.data\+0x8000
0+022c <text_label\+0x22c> 20a1 0950 	addu	at,at,a1
0+0230 <text_label\+0x230> 8481 e000 	ldc1	\$f4,0\(at\)
			230: R_MICROMIPS_LO12	.data\+0x8000
0+0234 <text_label\+0x234> e020 0000 	lui	at,0x0
			234: R_MICROMIPS_HI20	big_external_data_label\+0x8000
0+0238 <text_label\+0x238> 20a1 0950 	addu	at,at,a1
0+023c <text_label\+0x23c> 8481 e000 	ldc1	\$f4,0\(at\)
			23c: R_MICROMIPS_LO12	big_external_data_label\+0x8000
0+0240 <text_label\+0x240> e020 0000 	lui	at,0x0
			240: R_MICROMIPS_HI20	small_external_data_label\+0x8000
0+0244 <text_label\+0x244> 20a1 0950 	addu	at,at,a1
0+0248 <text_label\+0x248> 8481 e000 	ldc1	\$f4,0\(at\)
			248: R_MICROMIPS_LO12	small_external_data_label\+0x8000
0+024c <text_label\+0x24c> e020 0000 	lui	at,0x0
			24c: R_MICROMIPS_HI20	big_external_common\+0x8000
0+0250 <text_label\+0x250> 20a1 0950 	addu	at,at,a1
0+0254 <text_label\+0x254> 8481 e000 	ldc1	\$f4,0\(at\)
			254: R_MICROMIPS_LO12	big_external_common\+0x8000
0+0258 <text_label\+0x258> e020 0000 	lui	at,0x0
			258: R_MICROMIPS_HI20	small_external_common\+0x8000
0+025c <text_label\+0x25c> 20a1 0950 	addu	at,at,a1
0+0260 <text_label\+0x260> 8481 e000 	ldc1	\$f4,0\(at\)
			260: R_MICROMIPS_LO12	small_external_common\+0x8000
0+0264 <text_label\+0x264> e020 0000 	lui	at,0x0
			264: R_MICROMIPS_HI20	.bss\+0x8000
0+0268 <text_label\+0x268> 20a1 0950 	addu	at,at,a1
0+026c <text_label\+0x26c> 8481 e000 	ldc1	\$f4,0\(at\)
			26c: R_MICROMIPS_LO12	.bss\+0x8000
0+0270 <text_label\+0x270> e020 0000 	lui	at,0x0
			270: R_MICROMIPS_HI20	.sbss\+0x8000
0+0274 <text_label\+0x274> 20a1 0950 	addu	at,at,a1
0+0278 <text_label\+0x278> 8481 e000 	ldc1	\$f4,0\(at\)
			278: R_MICROMIPS_LO12	.sbss\+0x8000
0+027c <text_label\+0x27c> e020 0000 	lui	at,0x0
			27c: R_MICROMIPS_HI20	.data-0x8000
0+0280 <text_label\+0x280> 20a1 0950 	addu	at,at,a1
0+0284 <text_label\+0x284> 8481 e000 	ldc1	\$f4,0\(at\)
			284: R_MICROMIPS_LO12	.data-0x8000
0+0288 <text_label\+0x288> e020 0000 	lui	at,0x0
			288: R_MICROMIPS_HI20	big_external_data_label-0x8000
0+028c <text_label\+0x28c> 20a1 0950 	addu	at,at,a1
0+0290 <text_label\+0x290> 8481 e000 	ldc1	\$f4,0\(at\)
			290: R_MICROMIPS_LO12	big_external_data_label-0x8000
0+0294 <text_label\+0x294> e020 0000 	lui	at,0x0
			294: R_MICROMIPS_HI20	small_external_data_label-0x8000
0+0298 <text_label\+0x298> 20a1 0950 	addu	at,at,a1
0+029c <text_label\+0x29c> 8481 e000 	ldc1	\$f4,0\(at\)
			29c: R_MICROMIPS_LO12	small_external_data_label-0x8000
0+02a0 <text_label\+0x2a0> e020 0000 	lui	at,0x0
			2a0: R_MICROMIPS_HI20	big_external_common-0x8000
0+02a4 <text_label\+0x2a4> 20a1 0950 	addu	at,at,a1
0+02a8 <text_label\+0x2a8> 8481 e000 	ldc1	\$f4,0\(at\)
			2a8: R_MICROMIPS_LO12	big_external_common-0x8000
0+02ac <text_label\+0x2ac> e020 0000 	lui	at,0x0
			2ac: R_MICROMIPS_HI20	small_external_common-0x8000
0+02b0 <text_label\+0x2b0> 20a1 0950 	addu	at,at,a1
0+02b4 <text_label\+0x2b4> 8481 e000 	ldc1	\$f4,0\(at\)
			2b4: R_MICROMIPS_LO12	small_external_common-0x8000
0+02b8 <text_label\+0x2b8> e020 0000 	lui	at,0x0
			2b8: R_MICROMIPS_HI20	.bss-0x8000
0+02bc <text_label\+0x2bc> 20a1 0950 	addu	at,at,a1
0+02c0 <text_label\+0x2c0> 8481 e000 	ldc1	\$f4,0\(at\)
			2c0: R_MICROMIPS_LO12	.bss-0x8000
0+02c4 <text_label\+0x2c4> e020 0000 	lui	at,0x0
			2c4: R_MICROMIPS_HI20	.sbss-0x8000
0+02c8 <text_label\+0x2c8> 20a1 0950 	addu	at,at,a1
0+02cc <text_label\+0x2cc> 8481 e000 	ldc1	\$f4,0\(at\)
			2cc: R_MICROMIPS_LO12	.sbss-0x8000
0+02d0 <text_label\+0x2d0> e020 0000 	lui	at,0x0
			2d0: R_MICROMIPS_HI20	.data\+0x10000
0+02d4 <text_label\+0x2d4> 20a1 0950 	addu	at,at,a1
0+02d8 <text_label\+0x2d8> 8481 e000 	ldc1	\$f4,0\(at\)
			2d8: R_MICROMIPS_LO12	.data\+0x10000
0+02dc <text_label\+0x2dc> e020 0000 	lui	at,0x0
			2dc: R_MICROMIPS_HI20	big_external_data_label\+0x10000
0+02e0 <text_label\+0x2e0> 20a1 0950 	addu	at,at,a1
0+02e4 <text_label\+0x2e4> 8481 e000 	ldc1	\$f4,0\(at\)
			2e4: R_MICROMIPS_LO12	big_external_data_label\+0x10000
0+02e8 <text_label\+0x2e8> e020 0000 	lui	at,0x0
			2e8: R_MICROMIPS_HI20	small_external_data_label\+0x10000
0+02ec <text_label\+0x2ec> 20a1 0950 	addu	at,at,a1
0+02f0 <text_label\+0x2f0> 8481 e000 	ldc1	\$f4,0\(at\)
			2f0: R_MICROMIPS_LO12	small_external_data_label\+0x10000
0+02f4 <text_label\+0x2f4> e020 0000 	lui	at,0x0
			2f4: R_MICROMIPS_HI20	big_external_common\+0x10000
0+02f8 <text_label\+0x2f8> 20a1 0950 	addu	at,at,a1
0+02fc <text_label\+0x2fc> 8481 e000 	ldc1	\$f4,0\(at\)
			2fc: R_MICROMIPS_LO12	big_external_common\+0x10000
0+0300 <text_label\+0x300> e020 0000 	lui	at,0x0
			300: R_MICROMIPS_HI20	small_external_common\+0x10000
0+0304 <text_label\+0x304> 20a1 0950 	addu	at,at,a1
0+0308 <text_label\+0x308> 8481 e000 	ldc1	\$f4,0\(at\)
			308: R_MICROMIPS_LO12	small_external_common\+0x10000
0+030c <text_label\+0x30c> e020 0000 	lui	at,0x0
			30c: R_MICROMIPS_HI20	.bss\+0x10000
0+0310 <text_label\+0x310> 20a1 0950 	addu	at,at,a1
0+0314 <text_label\+0x314> 8481 e000 	ldc1	\$f4,0\(at\)
			314: R_MICROMIPS_LO12	.bss\+0x10000
0+0318 <text_label\+0x318> e020 0000 	lui	at,0x0
			318: R_MICROMIPS_HI20	.sbss\+0x10000
0+031c <text_label\+0x31c> 20a1 0950 	addu	at,at,a1
0+0320 <text_label\+0x320> 8481 e000 	ldc1	\$f4,0\(at\)
			320: R_MICROMIPS_LO12	.sbss\+0x10000
0+0324 <text_label\+0x324> e020 0000 	lui	at,0x0
			324: R_MICROMIPS_HI20	.data\+0x1a5a5
0+0328 <text_label\+0x328> 20a1 0950 	addu	at,at,a1
0+032c <text_label\+0x32c> 8481 e000 	ldc1	\$f4,0\(at\)
			32c: R_MICROMIPS_LO12	.data\+0x1a5a5
0+0330 <text_label\+0x330> e020 0000 	lui	at,0x0
			330: R_MICROMIPS_HI20	big_external_data_label\+0x1a5a5
0+0334 <text_label\+0x334> 20a1 0950 	addu	at,at,a1
0+0338 <text_label\+0x338> 8481 e000 	ldc1	\$f4,0\(at\)
			338: R_MICROMIPS_LO12	big_external_data_label\+0x1a5a5
0+033c <text_label\+0x33c> e020 0000 	lui	at,0x0
			33c: R_MICROMIPS_HI20	small_external_data_label\+0x1a5a5
0+0340 <text_label\+0x340> 20a1 0950 	addu	at,at,a1
0+0344 <text_label\+0x344> 8481 e000 	ldc1	\$f4,0\(at\)
			344: R_MICROMIPS_LO12	small_external_data_label\+0x1a5a5
0+0348 <text_label\+0x348> e020 0000 	lui	at,0x0
			348: R_MICROMIPS_HI20	big_external_common\+0x1a5a5
0+034c <text_label\+0x34c> 20a1 0950 	addu	at,at,a1
0+0350 <text_label\+0x350> 8481 e000 	ldc1	\$f4,0\(at\)
			350: R_MICROMIPS_LO12	big_external_common\+0x1a5a5
0+0354 <text_label\+0x354> e020 0000 	lui	at,0x0
			354: R_MICROMIPS_HI20	small_external_common\+0x1a5a5
0+0358 <text_label\+0x358> 20a1 0950 	addu	at,at,a1
0+035c <text_label\+0x35c> 8481 e000 	ldc1	\$f4,0\(at\)
			35c: R_MICROMIPS_LO12	small_external_common\+0x1a5a5
0+0360 <text_label\+0x360> e020 0000 	lui	at,0x0
			360: R_MICROMIPS_HI20	.bss\+0x1a5a5
0+0364 <text_label\+0x364> 20a1 0950 	addu	at,at,a1
0+0368 <text_label\+0x368> 8481 e000 	ldc1	\$f4,0\(at\)
			368: R_MICROMIPS_LO12	.bss\+0x1a5a5
0+036c <text_label\+0x36c> e020 0000 	lui	at,0x0
			36c: R_MICROMIPS_HI20	.sbss\+0x1a5a5
0+0370 <text_label\+0x370> 20a1 0950 	addu	at,at,a1
0+0374 <text_label\+0x374> 8481 e000 	ldc1	\$f4,0\(at\)
			374: R_MICROMIPS_LO12	.sbss\+0x1a5a5
	...
#pass