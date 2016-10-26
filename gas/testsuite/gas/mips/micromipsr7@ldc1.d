#objdump: -dr --prefix-addresses --show-raw-insn
#as: -32 --defsym tldc1=1
#name: microMIPS R7 ldc1
#source: ld.s

# Test the ldc1 macro.

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> 8480 e000 	ldc1	\$f4,0\(zero\)
0+0004 <text_label\+0x4> 8480 e001 	ldc1	\$f4,1\(zero\)
0+0008 <text_label\+0x8> 8480 e800 	ldc1	\$f4,2048\(zero\)
0+000c <text_label\+0xc> 0020 9800 	li	at,-2048
0+0010 <text_label\+0x10> 8481 e000 	ldc1	\$f4,0\(at\)
0+0014 <text_label\+0x14> 0020 1000 	li	at,4096
0+0018 <text_label\+0x18> 8481 e000 	ldc1	\$f4,0\(at\)
0+001c <text_label\+0x1c> e021 a000 	lui	at,0x1a
0+0020 <text_label\+0x20> 8481 e5a5 	ldc1	\$f4,1445\(at\)
0+0024 <text_label\+0x24> 8485 e000 	ldc1	\$f4,0\(a1\)
0+0028 <text_label\+0x28> 8485 e001 	ldc1	\$f4,1\(a1\)
0+002c <text_label\+0x2c> 8485 e800 	ldc1	\$f4,2048\(a1\)
0+0030 <text_label\+0x30> 0025 9800 	addiu	at,a1,-2048
0+0034 <text_label\+0x34> 8481 e000 	ldc1	\$f4,0\(at\)
0+0038 <text_label\+0x38> 0025 1000 	addiu	at,a1,4096
0+003c <text_label\+0x3c> 8481 e000 	ldc1	\$f4,0\(at\)
0+0040 <text_label\+0x40> e021 a000 	lui	at,0x1a
0+0044 <text_label\+0x44> 20a1 0950 	addu	at,at,a1
0+0048 <text_label\+0x48> 8481 e5a5 	ldc1	\$f4,1445\(at\)
0+004c <text_label\+0x4c> e020 0000 	lui	at,0x0
			4c: R_MICROMIPS_HI20	\.data
0+0050 <text_label\+0x50> 8481 e000 	ldc1	\$f4,0\(at\)
			50: R_MICROMIPS_LO12	\.data
0+0054 <text_label\+0x54> e020 0000 	lui	at,0x0
			54: R_MICROMIPS_HI20	big_external_data_label
0+0058 <text_label\+0x58> 8481 e000 	ldc1	\$f4,0\(at\)
			58: R_MICROMIPS_LO12	big_external_data_label
0+005c <text_label\+0x5c> 448c 0002 	ldc1	\$f4,0\(gp\)
			5c: R_MICROMIPS_GPREL16_S2	small_external_data_label
0+0060 <text_label\+0x60> e020 0000 	lui	at,0x0
			60: R_MICROMIPS_HI20	big_external_common
0+0064 <text_label\+0x64> 8481 e000 	ldc1	\$f4,0\(at\)
			64: R_MICROMIPS_LO12	big_external_common
0+0068 <text_label\+0x68> 448c 0002 	ldc1	\$f4,0\(gp\)
			68: R_MICROMIPS_GPREL16_S2	small_external_common
0+006c <text_label\+0x6c> e020 0000 	lui	at,0x0
			6c: R_MICROMIPS_HI20	\.bss
0+0070 <text_label\+0x70> 8481 e000 	ldc1	\$f4,0\(at\)
			70: R_MICROMIPS_LO12	\.bss
0+0074 <text_label\+0x74> 448c 0002 	ldc1	\$f4,0\(gp\)
			74: R_MICROMIPS_GPREL16_S2	\.sbss
0+0078 <text_label\+0x78> e020 0000 	lui	at,0x0
			78: R_MICROMIPS_HI20	\.data\+0x1
0+007c <text_label\+0x7c> 8481 e000 	ldc1	\$f4,0\(at\)
			7c: R_MICROMIPS_LO12	\.data\+0x1
0+0080 <text_label\+0x80> e020 0000 	lui	at,0x0
			80: R_MICROMIPS_HI20	big_external_data_label\+0x1
0+0084 <text_label\+0x84> 8481 e000 	ldc1	\$f4,0\(at\)
			84: R_MICROMIPS_LO12	big_external_data_label\+0x1
0+0088 <text_label\+0x88> 448c 0002 	ldc1	\$f4,0\(gp\)
			88: R_MICROMIPS_GPREL16_S2	small_external_data_label\+0x1
0+008c <text_label\+0x8c> e020 0000 	lui	at,0x0
			8c: R_MICROMIPS_HI20	big_external_common\+0x1
0+0090 <text_label\+0x90> 8481 e000 	ldc1	\$f4,0\(at\)
			90: R_MICROMIPS_LO12	big_external_common\+0x1
0+0094 <text_label\+0x94> 448c 0002 	ldc1	\$f4,0\(gp\)
			94: R_MICROMIPS_GPREL16_S2	small_external_common\+0x1
0+0098 <text_label\+0x98> e020 0000 	lui	at,0x0
			98: R_MICROMIPS_HI20	\.bss\+0x1
0+009c <text_label\+0x9c> 8481 e000 	ldc1	\$f4,0\(at\)
			9c: R_MICROMIPS_LO12	\.bss\+0x1
0+00a0 <text_label\+0xa0> 448c 0002 	ldc1	\$f4,0\(gp\)
			a0: R_MICROMIPS_GPREL16_S2	\.sbss\+0x1
0+00a4 <text_label\+0xa4> e020 0000 	lui	at,0x0
			a4: R_MICROMIPS_HI20	\.data\+0x800
0+00a8 <text_label\+0xa8> 8481 e000 	ldc1	\$f4,0\(at\)
			a8: R_MICROMIPS_LO12	\.data\+0x800
0+00ac <text_label\+0xac> e020 0000 	lui	at,0x0
			ac: R_MICROMIPS_HI20	big_external_data_label\+0x800
0+00b0 <text_label\+0xb0> 8481 e000 	ldc1	\$f4,0\(at\)
			b0: R_MICROMIPS_LO12	big_external_data_label\+0x800
0+00b4 <text_label\+0xb4> 448c 0002 	ldc1	\$f4,0\(gp\)
			b4: R_MICROMIPS_GPREL16_S2	small_external_data_label\+0x800
0+00b8 <text_label\+0xb8> e020 0000 	lui	at,0x0
			b8: R_MICROMIPS_HI20	big_external_common\+0x800
0+00bc <text_label\+0xbc> 8481 e000 	ldc1	\$f4,0\(at\)
			bc: R_MICROMIPS_LO12	big_external_common\+0x800
0+00c0 <text_label\+0xc0> 448c 0002 	ldc1	\$f4,0\(gp\)
			c0: R_MICROMIPS_GPREL16_S2	small_external_common\+0x800
0+00c4 <text_label\+0xc4> e020 0000 	lui	at,0x0
			c4: R_MICROMIPS_HI20	\.bss\+0x800
0+00c8 <text_label\+0xc8> 8481 e000 	ldc1	\$f4,0\(at\)
			c8: R_MICROMIPS_LO12	\.bss\+0x800
0+00cc <text_label\+0xcc> 448c 0002 	ldc1	\$f4,0\(gp\)
			cc: R_MICROMIPS_GPREL16_S2	\.sbss\+0x800
0+00d0 <text_label\+0xd0> e020 0000 	lui	at,0x0
			d0: R_MICROMIPS_HI20	\.data-0x800
0+00d4 <text_label\+0xd4> 8481 e000 	ldc1	\$f4,0\(at\)
			d4: R_MICROMIPS_LO12	\.data-0x800
0+00d8 <text_label\+0xd8> e020 0000 	lui	at,0x0
			d8: R_MICROMIPS_HI20	big_external_data_label-0x800
0+00dc <text_label\+0xdc> 8481 e000 	ldc1	\$f4,0\(at\)
			dc: R_MICROMIPS_LO12	big_external_data_label-0x800
0+00e0 <text_label\+0xe0> e020 0000 	lui	at,0x0
			e0: R_MICROMIPS_HI20	small_external_data_label-0x800
0+00e4 <text_label\+0xe4> 8481 e000 	ldc1	\$f4,0\(at\)
			e4: R_MICROMIPS_LO12	small_external_data_label-0x800
0+00e8 <text_label\+0xe8> e020 0000 	lui	at,0x0
			e8: R_MICROMIPS_HI20	big_external_common-0x800
0+00ec <text_label\+0xec> 8481 e000 	ldc1	\$f4,0\(at\)
			ec: R_MICROMIPS_LO12	big_external_common-0x800
0+00f0 <text_label\+0xf0> e020 0000 	lui	at,0x0
			f0: R_MICROMIPS_HI20	small_external_common-0x800
0+00f4 <text_label\+0xf4> 8481 e000 	ldc1	\$f4,0\(at\)
			f4: R_MICROMIPS_LO12	small_external_common-0x800
0+00f8 <text_label\+0xf8> e020 0000 	lui	at,0x0
			f8: R_MICROMIPS_HI20	\.bss-0x800
0+00fc <text_label\+0xfc> 8481 e000 	ldc1	\$f4,0\(at\)
			fc: R_MICROMIPS_LO12	\.bss-0x800
0+0100 <text_label\+0x100> e020 0000 	lui	at,0x0
			100: R_MICROMIPS_HI20	\.sbss-0x800
0+0104 <text_label\+0x104> 8481 e000 	ldc1	\$f4,0\(at\)
			104: R_MICROMIPS_LO12	\.sbss-0x800
0+0108 <text_label\+0x108> e020 0000 	lui	at,0x0
			108: R_MICROMIPS_HI20	\.data\+0x1000
0+010c <text_label\+0x10c> 8481 e000 	ldc1	\$f4,0\(at\)
			10c: R_MICROMIPS_LO12	\.data\+0x1000
0+0110 <text_label\+0x110> e020 0000 	lui	at,0x0
			110: R_MICROMIPS_HI20	big_external_data_label\+0x1000
0+0114 <text_label\+0x114> 8481 e000 	ldc1	\$f4,0\(at\)
			114: R_MICROMIPS_LO12	big_external_data_label\+0x1000
0+0118 <text_label\+0x118> 448c 0002 	ldc1	\$f4,0\(gp\)
			118: R_MICROMIPS_GPREL16_S2	small_external_data_label\+0x1000
0+011c <text_label\+0x11c> e020 0000 	lui	at,0x0
			11c: R_MICROMIPS_HI20	big_external_common\+0x1000
0+0120 <text_label\+0x120> 8481 e000 	ldc1	\$f4,0\(at\)
			120: R_MICROMIPS_LO12	big_external_common\+0x1000
0+0124 <text_label\+0x124> 448c 0002 	ldc1	\$f4,0\(gp\)
			124: R_MICROMIPS_GPREL16_S2	small_external_common\+0x1000
0+0128 <text_label\+0x128> e020 0000 	lui	at,0x0
			128: R_MICROMIPS_HI20	\.bss\+0x1000
0+012c <text_label\+0x12c> 8481 e000 	ldc1	\$f4,0\(at\)
			12c: R_MICROMIPS_LO12	\.bss\+0x1000
0+0130 <text_label\+0x130> 448c 0002 	ldc1	\$f4,0\(gp\)
			130: R_MICROMIPS_GPREL16_S2	\.sbss\+0x1000
0+0134 <text_label\+0x134> e020 0000 	lui	at,0x0
			134: R_MICROMIPS_HI20	\.data\+0x1a5a5
0+0138 <text_label\+0x138> 8481 e000 	ldc1	\$f4,0\(at\)
			138: R_MICROMIPS_LO12	\.data\+0x1a5a5
0+013c <text_label\+0x13c> e020 0000 	lui	at,0x0
			13c: R_MICROMIPS_HI20	big_external_data_label\+0x1a5a5
0+0140 <text_label\+0x140> 8481 e000 	ldc1	\$f4,0\(at\)
			140: R_MICROMIPS_LO12	big_external_data_label\+0x1a5a5
0+0144 <text_label\+0x144> 448c 0002 	ldc1	\$f4,0\(gp\)
			144: R_MICROMIPS_GPREL16_S2	small_external_data_label\+0x1a5a5
0+0148 <text_label\+0x148> e020 0000 	lui	at,0x0
			148: R_MICROMIPS_HI20	big_external_common\+0x1a5a5
0+014c <text_label\+0x14c> 8481 e000 	ldc1	\$f4,0\(at\)
			14c: R_MICROMIPS_LO12	big_external_common\+0x1a5a5
0+0150 <text_label\+0x150> 448c 0002 	ldc1	\$f4,0\(gp\)
			150: R_MICROMIPS_GPREL16_S2	small_external_common\+0x1a5a5
0+0154 <text_label\+0x154> e020 0000 	lui	at,0x0
			154: R_MICROMIPS_HI20	\.bss\+0x1a5a5
0+0158 <text_label\+0x158> 8481 e000 	ldc1	\$f4,0\(at\)
			158: R_MICROMIPS_LO12	\.bss\+0x1a5a5
0+015c <text_label\+0x15c> 448c 0002 	ldc1	\$f4,0\(gp\)
			15c: R_MICROMIPS_GPREL16_S2	\.sbss\+0x1a5a5
0+0160 <text_label\+0x160> e020 0000 	lui	at,0x0
			160: R_MICROMIPS_HI20	\.data
0+0164 <text_label\+0x164> 20a1 0950 	addu	at,at,a1
0+0168 <text_label\+0x168> 8481 e000 	ldc1	\$f4,0\(at\)
			168: R_MICROMIPS_LO12	\.data
0+016c <text_label\+0x16c> e020 0000 	lui	at,0x0
			16c: R_MICROMIPS_HI20	big_external_data_label
0+0170 <text_label\+0x170> 20a1 0950 	addu	at,at,a1
0+0174 <text_label\+0x174> 8481 e000 	ldc1	\$f4,0\(at\)
			174: R_MICROMIPS_LO12	big_external_data_label
0+0178 <text_label\+0x178> e020 0000 	lui	at,0x0
			178: R_MICROMIPS_HI20	small_external_data_label
0+017c <text_label\+0x17c> 20a1 0950 	addu	at,at,a1
0+0180 <text_label\+0x180> 8481 e000 	ldc1	\$f4,0\(at\)
			180: R_MICROMIPS_LO12	small_external_data_label
0+0184 <text_label\+0x184> e020 0000 	lui	at,0x0
			184: R_MICROMIPS_HI20	big_external_common
0+0188 <text_label\+0x188> 20a1 0950 	addu	at,at,a1
0+018c <text_label\+0x18c> 8481 e000 	ldc1	\$f4,0\(at\)
			18c: R_MICROMIPS_LO12	big_external_common
0+0190 <text_label\+0x190> e020 0000 	lui	at,0x0
			190: R_MICROMIPS_HI20	small_external_common
0+0194 <text_label\+0x194> 20a1 0950 	addu	at,at,a1
0+0198 <text_label\+0x198> 8481 e000 	ldc1	\$f4,0\(at\)
			198: R_MICROMIPS_LO12	small_external_common
0+019c <text_label\+0x19c> e020 0000 	lui	at,0x0
			19c: R_MICROMIPS_HI20	\.bss
0+01a0 <text_label\+0x1a0> 20a1 0950 	addu	at,at,a1
0+01a4 <text_label\+0x1a4> 8481 e000 	ldc1	\$f4,0\(at\)
			1a4: R_MICROMIPS_LO12	\.bss
0+01a8 <text_label\+0x1a8> e020 0000 	lui	at,0x0
			1a8: R_MICROMIPS_HI20	\.sbss
0+01ac <text_label\+0x1ac> 20a1 0950 	addu	at,at,a1
0+01b0 <text_label\+0x1b0> 8481 e000 	ldc1	\$f4,0\(at\)
			1b0: R_MICROMIPS_LO12	\.sbss
0+01b4 <text_label\+0x1b4> e020 0000 	lui	at,0x0
			1b4: R_MICROMIPS_HI20	\.data\+0x1
0+01b8 <text_label\+0x1b8> 20a1 0950 	addu	at,at,a1
0+01bc <text_label\+0x1bc> 8481 e000 	ldc1	\$f4,0\(at\)
			1bc: R_MICROMIPS_LO12	\.data\+0x1
0+01c0 <text_label\+0x1c0> e020 0000 	lui	at,0x0
			1c0: R_MICROMIPS_HI20	big_external_data_label\+0x1
0+01c4 <text_label\+0x1c4> 20a1 0950 	addu	at,at,a1
0+01c8 <text_label\+0x1c8> 8481 e000 	ldc1	\$f4,0\(at\)
			1c8: R_MICROMIPS_LO12	big_external_data_label\+0x1
0+01cc <text_label\+0x1cc> e020 0000 	lui	at,0x0
			1cc: R_MICROMIPS_HI20	small_external_data_label\+0x1
0+01d0 <text_label\+0x1d0> 20a1 0950 	addu	at,at,a1
0+01d4 <text_label\+0x1d4> 8481 e000 	ldc1	\$f4,0\(at\)
			1d4: R_MICROMIPS_LO12	small_external_data_label\+0x1
0+01d8 <text_label\+0x1d8> e020 0000 	lui	at,0x0
			1d8: R_MICROMIPS_HI20	big_external_common\+0x1
0+01dc <text_label\+0x1dc> 20a1 0950 	addu	at,at,a1
0+01e0 <text_label\+0x1e0> 8481 e000 	ldc1	\$f4,0\(at\)
			1e0: R_MICROMIPS_LO12	big_external_common\+0x1
0+01e4 <text_label\+0x1e4> e020 0000 	lui	at,0x0
			1e4: R_MICROMIPS_HI20	small_external_common\+0x1
0+01e8 <text_label\+0x1e8> 20a1 0950 	addu	at,at,a1
0+01ec <text_label\+0x1ec> 8481 e000 	ldc1	\$f4,0\(at\)
			1ec: R_MICROMIPS_LO12	small_external_common\+0x1
0+01f0 <text_label\+0x1f0> e020 0000 	lui	at,0x0
			1f0: R_MICROMIPS_HI20	\.bss\+0x1
0+01f4 <text_label\+0x1f4> 20a1 0950 	addu	at,at,a1
0+01f8 <text_label\+0x1f8> 8481 e000 	ldc1	\$f4,0\(at\)
			1f8: R_MICROMIPS_LO12	\.bss\+0x1
0+01fc <text_label\+0x1fc> e020 0000 	lui	at,0x0
			1fc: R_MICROMIPS_HI20	\.sbss\+0x1
0+0200 <text_label\+0x200> 20a1 0950 	addu	at,at,a1
0+0204 <text_label\+0x204> 8481 e000 	ldc1	\$f4,0\(at\)
			204: R_MICROMIPS_LO12	\.sbss\+0x1
0+0208 <text_label\+0x208> e020 0000 	lui	at,0x0
			208: R_MICROMIPS_HI20	\.data\+0x800
0+020c <text_label\+0x20c> 20a1 0950 	addu	at,at,a1
0+0210 <text_label\+0x210> 8481 e000 	ldc1	\$f4,0\(at\)
			210: R_MICROMIPS_LO12	\.data\+0x800
0+0214 <text_label\+0x214> e020 0000 	lui	at,0x0
			214: R_MICROMIPS_HI20	big_external_data_label\+0x800
0+0218 <text_label\+0x218> 20a1 0950 	addu	at,at,a1
0+021c <text_label\+0x21c> 8481 e000 	ldc1	\$f4,0\(at\)
			21c: R_MICROMIPS_LO12	big_external_data_label\+0x800
0+0220 <text_label\+0x220> e020 0000 	lui	at,0x0
			220: R_MICROMIPS_HI20	small_external_data_label\+0x800
0+0224 <text_label\+0x224> 20a1 0950 	addu	at,at,a1
0+0228 <text_label\+0x228> 8481 e000 	ldc1	\$f4,0\(at\)
			228: R_MICROMIPS_LO12	small_external_data_label\+0x800
0+022c <text_label\+0x22c> e020 0000 	lui	at,0x0
			22c: R_MICROMIPS_HI20	big_external_common\+0x800
0+0230 <text_label\+0x230> 20a1 0950 	addu	at,at,a1
0+0234 <text_label\+0x234> 8481 e000 	ldc1	\$f4,0\(at\)
			234: R_MICROMIPS_LO12	big_external_common\+0x800
0+0238 <text_label\+0x238> e020 0000 	lui	at,0x0
			238: R_MICROMIPS_HI20	small_external_common\+0x800
0+023c <text_label\+0x23c> 20a1 0950 	addu	at,at,a1
0+0240 <text_label\+0x240> 8481 e000 	ldc1	\$f4,0\(at\)
			240: R_MICROMIPS_LO12	small_external_common\+0x800
0+0244 <text_label\+0x244> e020 0000 	lui	at,0x0
			244: R_MICROMIPS_HI20	\.bss\+0x800
0+0248 <text_label\+0x248> 20a1 0950 	addu	at,at,a1
0+024c <text_label\+0x24c> 8481 e000 	ldc1	\$f4,0\(at\)
			24c: R_MICROMIPS_LO12	\.bss\+0x800
0+0250 <text_label\+0x250> e020 0000 	lui	at,0x0
			250: R_MICROMIPS_HI20	\.sbss\+0x800
0+0254 <text_label\+0x254> 20a1 0950 	addu	at,at,a1
0+0258 <text_label\+0x258> 8481 e000 	ldc1	\$f4,0\(at\)
			258: R_MICROMIPS_LO12	\.sbss\+0x800
0+025c <text_label\+0x25c> e020 0000 	lui	at,0x0
			25c: R_MICROMIPS_HI20	\.data-0x800
0+0260 <text_label\+0x260> 20a1 0950 	addu	at,at,a1
0+0264 <text_label\+0x264> 8481 e000 	ldc1	\$f4,0\(at\)
			264: R_MICROMIPS_LO12	\.data-0x800
0+0268 <text_label\+0x268> e020 0000 	lui	at,0x0
			268: R_MICROMIPS_HI20	big_external_data_label-0x800
0+026c <text_label\+0x26c> 20a1 0950 	addu	at,at,a1
0+0270 <text_label\+0x270> 8481 e000 	ldc1	\$f4,0\(at\)
			270: R_MICROMIPS_LO12	big_external_data_label-0x800
0+0274 <text_label\+0x274> e020 0000 	lui	at,0x0
			274: R_MICROMIPS_HI20	small_external_data_label-0x800
0+0278 <text_label\+0x278> 20a1 0950 	addu	at,at,a1
0+027c <text_label\+0x27c> 8481 e000 	ldc1	\$f4,0\(at\)
			27c: R_MICROMIPS_LO12	small_external_data_label-0x800
0+0280 <text_label\+0x280> e020 0000 	lui	at,0x0
			280: R_MICROMIPS_HI20	big_external_common-0x800
0+0284 <text_label\+0x284> 20a1 0950 	addu	at,at,a1
0+0288 <text_label\+0x288> 8481 e000 	ldc1	\$f4,0\(at\)
			288: R_MICROMIPS_LO12	big_external_common-0x800
0+028c <text_label\+0x28c> e020 0000 	lui	at,0x0
			28c: R_MICROMIPS_HI20	small_external_common-0x800
0+0290 <text_label\+0x290> 20a1 0950 	addu	at,at,a1
0+0294 <text_label\+0x294> 8481 e000 	ldc1	\$f4,0\(at\)
			294: R_MICROMIPS_LO12	small_external_common-0x800
0+0298 <text_label\+0x298> e020 0000 	lui	at,0x0
			298: R_MICROMIPS_HI20	\.bss-0x800
0+029c <text_label\+0x29c> 20a1 0950 	addu	at,at,a1
0+02a0 <text_label\+0x2a0> 8481 e000 	ldc1	\$f4,0\(at\)
			2a0: R_MICROMIPS_LO12	\.bss-0x800
0+02a4 <text_label\+0x2a4> e020 0000 	lui	at,0x0
			2a4: R_MICROMIPS_HI20	\.sbss-0x800
0+02a8 <text_label\+0x2a8> 20a1 0950 	addu	at,at,a1
0+02ac <text_label\+0x2ac> 8481 e000 	ldc1	\$f4,0\(at\)
			2ac: R_MICROMIPS_LO12	\.sbss-0x800
0+02b0 <text_label\+0x2b0> e020 0000 	lui	at,0x0
			2b0: R_MICROMIPS_HI20	\.data\+0x1000
0+02b4 <text_label\+0x2b4> 20a1 0950 	addu	at,at,a1
0+02b8 <text_label\+0x2b8> 8481 e000 	ldc1	\$f4,0\(at\)
			2b8: R_MICROMIPS_LO12	\.data\+0x1000
0+02bc <text_label\+0x2bc> e020 0000 	lui	at,0x0
			2bc: R_MICROMIPS_HI20	big_external_data_label\+0x1000
0+02c0 <text_label\+0x2c0> 20a1 0950 	addu	at,at,a1
0+02c4 <text_label\+0x2c4> 8481 e000 	ldc1	\$f4,0\(at\)
			2c4: R_MICROMIPS_LO12	big_external_data_label\+0x1000
0+02c8 <text_label\+0x2c8> e020 0000 	lui	at,0x0
			2c8: R_MICROMIPS_HI20	small_external_data_label\+0x1000
0+02cc <text_label\+0x2cc> 20a1 0950 	addu	at,at,a1
0+02d0 <text_label\+0x2d0> 8481 e000 	ldc1	\$f4,0\(at\)
			2d0: R_MICROMIPS_LO12	small_external_data_label\+0x1000
0+02d4 <text_label\+0x2d4> e020 0000 	lui	at,0x0
			2d4: R_MICROMIPS_HI20	big_external_common\+0x1000
0+02d8 <text_label\+0x2d8> 20a1 0950 	addu	at,at,a1
0+02dc <text_label\+0x2dc> 8481 e000 	ldc1	\$f4,0\(at\)
			2dc: R_MICROMIPS_LO12	big_external_common\+0x1000
0+02e0 <text_label\+0x2e0> e020 0000 	lui	at,0x0
			2e0: R_MICROMIPS_HI20	small_external_common\+0x1000
0+02e4 <text_label\+0x2e4> 20a1 0950 	addu	at,at,a1
0+02e8 <text_label\+0x2e8> 8481 e000 	ldc1	\$f4,0\(at\)
			2e8: R_MICROMIPS_LO12	small_external_common\+0x1000
0+02ec <text_label\+0x2ec> e020 0000 	lui	at,0x0
			2ec: R_MICROMIPS_HI20	\.bss\+0x1000
0+02f0 <text_label\+0x2f0> 20a1 0950 	addu	at,at,a1
0+02f4 <text_label\+0x2f4> 8481 e000 	ldc1	\$f4,0\(at\)
			2f4: R_MICROMIPS_LO12	\.bss\+0x1000
0+02f8 <text_label\+0x2f8> e020 0000 	lui	at,0x0
			2f8: R_MICROMIPS_HI20	\.sbss\+0x1000
0+02fc <text_label\+0x2fc> 20a1 0950 	addu	at,at,a1
0+0300 <text_label\+0x300> 8481 e000 	ldc1	\$f4,0\(at\)
			300: R_MICROMIPS_LO12	\.sbss\+0x1000
0+0304 <text_label\+0x304> e020 0000 	lui	at,0x0
			304: R_MICROMIPS_HI20	\.data\+0x1a5a5
0+0308 <text_label\+0x308> 20a1 0950 	addu	at,at,a1
0+030c <text_label\+0x30c> 8481 e000 	ldc1	\$f4,0\(at\)
			30c: R_MICROMIPS_LO12	\.data\+0x1a5a5
0+0310 <text_label\+0x310> e020 0000 	lui	at,0x0
			310: R_MICROMIPS_HI20	big_external_data_label\+0x1a5a5
0+0314 <text_label\+0x314> 20a1 0950 	addu	at,at,a1
0+0318 <text_label\+0x318> 8481 e000 	ldc1	\$f4,0\(at\)
			318: R_MICROMIPS_LO12	big_external_data_label\+0x1a5a5
0+031c <text_label\+0x31c> e020 0000 	lui	at,0x0
			31c: R_MICROMIPS_HI20	small_external_data_label\+0x1a5a5
0+0320 <text_label\+0x320> 20a1 0950 	addu	at,at,a1
0+0324 <text_label\+0x324> 8481 e000 	ldc1	\$f4,0\(at\)
			324: R_MICROMIPS_LO12	small_external_data_label\+0x1a5a5
0+0328 <text_label\+0x328> e020 0000 	lui	at,0x0
			328: R_MICROMIPS_HI20	big_external_common\+0x1a5a5
0+032c <text_label\+0x32c> 20a1 0950 	addu	at,at,a1
0+0330 <text_label\+0x330> 8481 e000 	ldc1	\$f4,0\(at\)
			330: R_MICROMIPS_LO12	big_external_common\+0x1a5a5
0+0334 <text_label\+0x334> e020 0000 	lui	at,0x0
			334: R_MICROMIPS_HI20	small_external_common\+0x1a5a5
0+0338 <text_label\+0x338> 20a1 0950 	addu	at,at,a1
0+033c <text_label\+0x33c> 8481 e000 	ldc1	\$f4,0\(at\)
			33c: R_MICROMIPS_LO12	small_external_common\+0x1a5a5
0+0340 <text_label\+0x340> e020 0000 	lui	at,0x0
			340: R_MICROMIPS_HI20	\.bss\+0x1a5a5
0+0344 <text_label\+0x344> 20a1 0950 	addu	at,at,a1
0+0348 <text_label\+0x348> 8481 e000 	ldc1	\$f4,0\(at\)
			348: R_MICROMIPS_LO12	\.bss\+0x1a5a5
0+034c <text_label\+0x34c> e020 0000 	lui	at,0x0
			34c: R_MICROMIPS_HI20	\.sbss\+0x1a5a5
0+0350 <text_label\+0x350> 20a1 0950 	addu	at,at,a1
0+0354 <text_label\+0x354> 8481 e000 	ldc1	\$f4,0\(at\)
			354: R_MICROMIPS_LO12	\.sbss\+0x1a5a5
	\.\.\.
#pass