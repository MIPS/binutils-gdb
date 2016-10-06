#objdump: -dr --prefix-addresses --show-raw-insn
#as: -mmicromips -mips32r7 -32 --defsym r7=1
#name: microMIPS R7 ld
#source: ld.s

# Test the ld macro.

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> e021 a000 	lui	at,0x1a
0+0004 <text_label\+0x4> 2025 0950 	addu	at,a1,at
0+0008 <text_label\+0x8> 8481 85a5 	lw	a0,1445\(at\)
0+000c <text_label\+0xc> 84a1 85a9 	lw	a1,1449\(at\)
0+0010 <text_label\+0x10> 8480 8000 	lw	a0,0\(zero\)
0+0014 <text_label\+0x14> 84a0 8004 	lw	a1,4\(zero\)
0+0018 <text_label\+0x18> 8480 8001 	lw	a0,1\(zero\)
0+001c <text_label\+0x1c> 84a0 8005 	lw	a1,5\(zero\)
0+0020 <text_label\+0x20> 8480 8800 	lw	a0,2048\(zero\)
0+0024 <text_label\+0x24> 84a0 8804 	lw	a1,2052\(zero\)
0+0028 <text_label\+0x28> 8480 8800 	lw	a0,2048\(zero\)
0+002c <text_label\+0x2c> 84a0 8804 	lw	a1,2052\(zero\)
0+0030 <text_label\+0x30> 8480 8000 	lw	a0,0\(zero\)
0+0034 <text_label\+0x34> 84a0 8004 	lw	a1,4\(zero\)
0+0038 <text_label\+0x38> e021 a000 	lui	at,0x1a
0+003c <text_label\+0x3c> 8481 85a5 	lw	a0,1445\(at\)
0+0040 <text_label\+0x40> 84a1 85a9 	lw	a1,1449\(at\)
0+0044 <text_label\+0x44> 8485 8000 	lw	a0,0\(a1\)
0+0048 <text_label\+0x48> 84a5 8004 	lw	a1,4\(a1\)
0+004c <text_label\+0x4c> 8485 8001 	lw	a0,1\(a1\)
0+0050 <text_label\+0x50> 84a5 8005 	lw	a1,5\(a1\)
0+0054 <text_label\+0x54> 8485 8800 	lw	a0,2048\(a1\)
0+0058 <text_label\+0x58> 84a5 8804 	lw	a1,2052\(a1\)
0+005c <text_label\+0x5c> 8485 8800 	lw	a0,2048\(a1\)
0+0060 <text_label\+0x60> 84a5 8804 	lw	a1,2052\(a1\)
0+0064 <text_label\+0x64> 8485 8000 	lw	a0,0\(a1\)
0+0068 <text_label\+0x68> 84a5 8004 	lw	a1,4\(a1\)
0+006c <text_label\+0x6c> e020 0000 	lui	at,0x0
			6c: R_MICROMIPS_HI20	.data
0+0070 <text_label\+0x70> 8481 8000 	lw	a0,0\(at\)
			70: R_MICROMIPS_LO12	.data
0+0074 <text_label\+0x74> 84a1 8000 	lw	a1,0\(at\)
			74: R_MICROMIPS_LO12	.data\+0x4
0+0078 <text_label\+0x78> e020 0000 	lui	at,0x0
			78: R_MICROMIPS_HI20	big_external_data_label
0+007c <text_label\+0x7c> 8481 8000 	lw	a0,0\(at\)
			7c: R_MICROMIPS_LO12	big_external_data_label
0+0080 <text_label\+0x80> 84a1 8000 	lw	a1,0\(at\)
			80: R_MICROMIPS_LO12	big_external_data_label\+0x4
0+0084 <text_label\+0x84> 4080 0002 	lw	a0,0\(gp\)
			84: R_MICROMIPS_GPREL19_S2	small_external_data_label
0+0088 <text_label\+0x88> 40a0 0002 	lw	a1,0\(gp\)
			88: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x4
0+008c <text_label\+0x8c> e020 0000 	lui	at,0x0
			8c: R_MICROMIPS_HI20	big_external_common
0+0090 <text_label\+0x90> 8481 8000 	lw	a0,0\(at\)
			90: R_MICROMIPS_LO12	big_external_common
0+0094 <text_label\+0x94> 84a1 8000 	lw	a1,0\(at\)
			94: R_MICROMIPS_LO12	big_external_common\+0x4
0+0098 <text_label\+0x98> 4080 0002 	lw	a0,0\(gp\)
			98: R_MICROMIPS_GPREL19_S2	small_external_common
0+009c <text_label\+0x9c> 40a0 0002 	lw	a1,0\(gp\)
			9c: R_MICROMIPS_GPREL19_S2	small_external_common\+0x4
0+00a0 <text_label\+0xa0> e020 0000 	lui	at,0x0
			a0: R_MICROMIPS_HI20	\.bss)
0+00a4 <text_label\+0xa4> 8481 8000 	lw	a0,0\(at\)
			a4: R_MICROMIPS_LO12	\.bss)
0+00a8 <text_label\+0xa8> 84a1 8000 	lw	a1,0\(at\)
			a8: R_MICROMIPS_LO12	\.bss)\+0x4
0+00ac <text_label\+0xac> 4080 0002 	lw	a0,0\(gp\)
			ac: R_MICROMIPS_GPREL19_S2	\.sbss)
0+00b0 <text_label\+0xb0> 40a0 0002 	lw	a1,0\(gp\)
			b0: R_MICROMIPS_GPREL19_S2	\.sbss)\+0x4
0+00b4 <text_label\+0xb4> e020 0000 	lui	at,0x0
			b4: R_MICROMIPS_HI20	.data\+0x1
0+00b8 <text_label\+0xb8> 8481 8000 	lw	a0,0\(at\)
			b8: R_MICROMIPS_LO12	.data\+0x1
0+00bc <text_label\+0xbc> 84a1 8000 	lw	a1,0\(at\)
			bc: R_MICROMIPS_LO12	.data\+0x5
0+00c0 <text_label\+0xc0> e020 0000 	lui	at,0x0
			c0: R_MICROMIPS_HI20	big_external_data_label\+0x1
0+00c4 <text_label\+0xc4> 8481 8000 	lw	a0,0\(at\)
			c4: R_MICROMIPS_LO12	big_external_data_label\+0x1
0+00c8 <text_label\+0xc8> 84a1 8000 	lw	a1,0\(at\)
			c8: R_MICROMIPS_LO12	big_external_data_label\+0x5
0+00cc <text_label\+0xcc> 4080 0002 	lw	a0,0\(gp\)
			cc: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x1
0+00d0 <text_label\+0xd0> 40a0 0002 	lw	a1,0\(gp\)
			d0: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x5
0+00d4 <text_label\+0xd4> e020 0000 	lui	at,0x0
			d4: R_MICROMIPS_HI20	big_external_common\+0x1
0+00d8 <text_label\+0xd8> 8481 8000 	lw	a0,0\(at\)
			d8: R_MICROMIPS_LO12	big_external_common\+0x1
0+00dc <text_label\+0xdc> 84a1 8000 	lw	a1,0\(at\)
			dc: R_MICROMIPS_LO12	big_external_common\+0x5
0+00e0 <text_label\+0xe0> 4080 0002 	lw	a0,0\(gp\)
			e0: R_MICROMIPS_GPREL19_S2	small_external_common\+0x1
0+00e4 <text_label\+0xe4> 40a0 0002 	lw	a1,0\(gp\)
			e4: R_MICROMIPS_GPREL19_S2	small_external_common\+0x5
0+00e8 <text_label\+0xe8> e020 0000 	lui	at,0x0
			e8: R_MICROMIPS_HI20	\.bss)\+0x1
0+00ec <text_label\+0xec> 8481 8000 	lw	a0,0\(at\)
			ec: R_MICROMIPS_LO12	\.bss)\+0x1
0+00f0 <text_label\+0xf0> 84a1 8000 	lw	a1,0\(at\)
			f0: R_MICROMIPS_LO12	\.bss)\+0x5
0+00f4 <text_label\+0xf4> 4080 0002 	lw	a0,0\(gp\)
			f4: R_MICROMIPS_GPREL19_S2	\.sbss)\+0x1
0+00f8 <text_label\+0xf8> 40a0 0002 	lw	a1,0\(gp\)
			f8: R_MICROMIPS_GPREL19_S2	\.sbss)\+0x5
0+00fc <text_label\+0xfc> e020 0000 	lui	at,0x0
			fc: R_MICROMIPS_HI20	.data\+0x800
0+0100 <text_label\+0x100> 8481 8000 	lw	a0,0\(at\)
			100: R_MICROMIPS_LO12	.data\+0x800
0+0104 <text_label\+0x104> 84a1 8000 	lw	a1,0\(at\)
			104: R_MICROMIPS_LO12	.data\+0x804
0+0108 <text_label\+0x108> e020 0000 	lui	at,0x0
			108: R_MICROMIPS_HI20	big_external_data_label\+0x800
0+010c <text_label\+0x10c> 8481 8000 	lw	a0,0\(at\)
			10c: R_MICROMIPS_LO12	big_external_data_label\+0x800
0+0110 <text_label\+0x110> 84a1 8000 	lw	a1,0\(at\)
			110: R_MICROMIPS_LO12	big_external_data_label\+0x804
0+0114 <text_label\+0x114> 4080 0002 	lw	a0,0\(gp\)
			114: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x800
0+0118 <text_label\+0x118> 40a0 0002 	lw	a1,0\(gp\)
			118: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x804
0+011c <text_label\+0x11c> e020 0000 	lui	at,0x0
			11c: R_MICROMIPS_HI20	big_external_common\+0x800
0+0120 <text_label\+0x120> 8481 8000 	lw	a0,0\(at\)
			120: R_MICROMIPS_LO12	big_external_common\+0x800
0+0124 <text_label\+0x124> 84a1 8000 	lw	a1,0\(at\)
			124: R_MICROMIPS_LO12	big_external_common\+0x804
0+0128 <text_label\+0x128> 4080 0002 	lw	a0,0\(gp\)
			128: R_MICROMIPS_GPREL19_S2	small_external_common\+0x800
0+012c <text_label\+0x12c> 40a0 0002 	lw	a1,0\(gp\)
			12c: R_MICROMIPS_GPREL19_S2	small_external_common\+0x804
0+0130 <text_label\+0x130> e020 0000 	lui	at,0x0
			130: R_MICROMIPS_HI20	\.bss)\+0x800
0+0134 <text_label\+0x134> 8481 8000 	lw	a0,0\(at\)
			134: R_MICROMIPS_LO12	\.bss)\+0x800
0+0138 <text_label\+0x138> 84a1 8000 	lw	a1,0\(at\)
			138: R_MICROMIPS_LO12	\.bss)\+0x804
0+013c <text_label\+0x13c> 4080 0002 	lw	a0,0\(gp\)
			13c: R_MICROMIPS_GPREL19_S2	\.sbss)\+0x800
0+0140 <text_label\+0x140> 40a0 0002 	lw	a1,0\(gp\)
			140: R_MICROMIPS_GPREL19_S2	\.sbss)\+0x804
0+0144 <text_label\+0x144> e020 0000 	lui	at,0x0
			144: R_MICROMIPS_HI20	.data-0x800
0+0148 <text_label\+0x148> 8481 8000 	lw	a0,0\(at\)
			148: R_MICROMIPS_LO12	.data-0x800
0+014c <text_label\+0x14c> 84a1 8000 	lw	a1,0\(at\)
			14c: R_MICROMIPS_LO12	.data-0x7fc
0+0150 <text_label\+0x150> e020 0000 	lui	at,0x0
			150: R_MICROMIPS_HI20	big_external_data_label-0x800
0+0154 <text_label\+0x154> 8481 8000 	lw	a0,0\(at\)
			154: R_MICROMIPS_LO12	big_external_data_label-0x800
0+0158 <text_label\+0x158> 84a1 8000 	lw	a1,0\(at\)
			158: R_MICROMIPS_LO12	big_external_data_label-0x7fc
0+015c <text_label\+0x15c> e020 0000 	lui	at,0x0
			15c: R_MICROMIPS_HI20	small_external_data_label-0x800
0+0160 <text_label\+0x160> 8481 8000 	lw	a0,0\(at\)
			160: R_MICROMIPS_LO12	small_external_data_label-0x800
0+0164 <text_label\+0x164> 84a1 8000 	lw	a1,0\(at\)
			164: R_MICROMIPS_LO12	small_external_data_label-0x7fc
0+0168 <text_label\+0x168> e020 0000 	lui	at,0x0
			168: R_MICROMIPS_HI20	big_external_common-0x800
0+016c <text_label\+0x16c> 8481 8000 	lw	a0,0\(at\)
			16c: R_MICROMIPS_LO12	big_external_common-0x800
0+0170 <text_label\+0x170> 84a1 8000 	lw	a1,0\(at\)
			170: R_MICROMIPS_LO12	big_external_common-0x7fc
0+0174 <text_label\+0x174> e020 0000 	lui	at,0x0
			174: R_MICROMIPS_HI20	small_external_common-0x800
0+0178 <text_label\+0x178> 8481 8000 	lw	a0,0\(at\)
			178: R_MICROMIPS_LO12	small_external_common-0x800
0+017c <text_label\+0x17c> 84a1 8000 	lw	a1,0\(at\)
			17c: R_MICROMIPS_LO12	small_external_common-0x7fc
0+0180 <text_label\+0x180> e020 0000 	lui	at,0x0
			180: R_MICROMIPS_HI20	\.bss)-0x800
0+0184 <text_label\+0x184> 8481 8000 	lw	a0,0\(at\)
			184: R_MICROMIPS_LO12	\.bss)-0x800
0+0188 <text_label\+0x188> 84a1 8000 	lw	a1,0\(at\)
			188: R_MICROMIPS_LO12	\.bss)-0x7fc
0+018c <text_label\+0x18c> e020 0000 	lui	at,0x0
			18c: R_MICROMIPS_HI20	\.sbss)-0x800
0+0190 <text_label\+0x190> 8481 8000 	lw	a0,0\(at\)
			190: R_MICROMIPS_LO12	\.sbss)-0x800
0+0194 <text_label\+0x194> 84a1 8000 	lw	a1,0\(at\)
			194: R_MICROMIPS_LO12	\.sbss)-0x7fc
0+0198 <text_label\+0x198> e020 0000 	lui	at,0x0
			198: R_MICROMIPS_HI20	.data\+0x1000
0+019c <text_label\+0x19c> 8481 8000 	lw	a0,0\(at\)
			19c: R_MICROMIPS_LO12	.data\+0x1000
0+01a0 <text_label\+0x1a0> 84a1 8000 	lw	a1,0\(at\)
			1a0: R_MICROMIPS_LO12	.data\+0x1004
0+01a4 <text_label\+0x1a4> e020 0000 	lui	at,0x0
			1a4: R_MICROMIPS_HI20	big_external_data_label\+0x1000
0+01a8 <text_label\+0x1a8> 8481 8000 	lw	a0,0\(at\)
			1a8: R_MICROMIPS_LO12	big_external_data_label\+0x1000
0+01ac <text_label\+0x1ac> 84a1 8000 	lw	a1,0\(at\)
			1ac: R_MICROMIPS_LO12	big_external_data_label\+0x1004
0+01b0 <text_label\+0x1b0> 4080 0002 	lw	a0,0\(gp\)
			1b0: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x1000
0+01b4 <text_label\+0x1b4> 40a0 0002 	lw	a1,0\(gp\)
			1b4: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x1004
0+01b8 <text_label\+0x1b8> e020 0000 	lui	at,0x0
			1b8: R_MICROMIPS_HI20	big_external_common\+0x1000
0+01bc <text_label\+0x1bc> 8481 8000 	lw	a0,0\(at\)
			1bc: R_MICROMIPS_LO12	big_external_common\+0x1000
0+01c0 <text_label\+0x1c0> 84a1 8000 	lw	a1,0\(at\)
			1c0: R_MICROMIPS_LO12	big_external_common\+0x1004
0+01c4 <text_label\+0x1c4> 4080 0002 	lw	a0,0\(gp\)
			1c4: R_MICROMIPS_GPREL19_S2	small_external_common\+0x1000
0+01c8 <text_label\+0x1c8> 40a0 0002 	lw	a1,0\(gp\)
			1c8: R_MICROMIPS_GPREL19_S2	small_external_common\+0x1004
0+01cc <text_label\+0x1cc> e020 0000 	lui	at,0x0
			1cc: R_MICROMIPS_HI20	\.bss)\+0x1000
0+01d0 <text_label\+0x1d0> 8481 8000 	lw	a0,0\(at\)
			1d0: R_MICROMIPS_LO12	\.bss)\+0x1000
0+01d4 <text_label\+0x1d4> 84a1 8000 	lw	a1,0\(at\)
			1d4: R_MICROMIPS_LO12	\.bss)\+0x1004
0+01d8 <text_label\+0x1d8> 4080 0002 	lw	a0,0\(gp\)
			1d8: R_MICROMIPS_GPREL19_S2	\.sbss)\+0x1000
0+01dc <text_label\+0x1dc> 40a0 0002 	lw	a1,0\(gp\)
			1dc: R_MICROMIPS_GPREL19_S2	\.sbss)\+0x1004
0+01e0 <text_label\+0x1e0> e020 0000 	lui	at,0x0
			1e0: R_MICROMIPS_HI20	.data\+0x1a5a5
0+01e4 <text_label\+0x1e4> 8481 8000 	lw	a0,0\(at\)
			1e4: R_MICROMIPS_LO12	.data\+0x1a5a5
0+01e8 <text_label\+0x1e8> 84a1 8000 	lw	a1,0\(at\)
			1e8: R_MICROMIPS_LO12	.data\+0x1a5a9
0+01ec <text_label\+0x1ec> e020 0000 	lui	at,0x0
			1ec: R_MICROMIPS_HI20	big_external_data_label\+0x1a5a5
0+01f0 <text_label\+0x1f0> 8481 8000 	lw	a0,0\(at\)
			1f0: R_MICROMIPS_LO12	big_external_data_label\+0x1a5a5
0+01f4 <text_label\+0x1f4> 84a1 8000 	lw	a1,0\(at\)
			1f4: R_MICROMIPS_LO12	big_external_data_label\+0x1a5a9
0+01f8 <text_label\+0x1f8> 4080 0002 	lw	a0,0\(gp\)
			1f8: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x1a5a5
0+01fc <text_label\+0x1fc> 40a0 0002 	lw	a1,0\(gp\)
			1fc: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x1a5a9
0+0200 <text_label\+0x200> e020 0000 	lui	at,0x0
			200: R_MICROMIPS_HI20	big_external_common\+0x1a5a5
0+0204 <text_label\+0x204> 8481 8000 	lw	a0,0\(at\)
			204: R_MICROMIPS_LO12	big_external_common\+0x1a5a5
0+0208 <text_label\+0x208> 84a1 8000 	lw	a1,0\(at\)
			208: R_MICROMIPS_LO12	big_external_common\+0x1a5a9
0+020c <text_label\+0x20c> 4080 0002 	lw	a0,0\(gp\)
			20c: R_MICROMIPS_GPREL19_S2	small_external_common\+0x1a5a5
0+0210 <text_label\+0x210> 40a0 0002 	lw	a1,0\(gp\)
			210: R_MICROMIPS_GPREL19_S2	small_external_common\+0x1a5a9
0+0214 <text_label\+0x214> e020 0000 	lui	at,0x0
			214: R_MICROMIPS_HI20	\.bss)\+0x1a5a5
0+0218 <text_label\+0x218> 8481 8000 	lw	a0,0\(at\)
			218: R_MICROMIPS_LO12	\.bss)\+0x1a5a5
0+021c <text_label\+0x21c> 84a1 8000 	lw	a1,0\(at\)
			21c: R_MICROMIPS_LO12	\.bss)\+0x1a5a9
0+0220 <text_label\+0x220> 4080 0002 	lw	a0,0\(gp\)
			220: R_MICROMIPS_GPREL19_S2	\.sbss)\+0x1a5a5
0+0224 <text_label\+0x224> 40a0 0002 	lw	a1,0\(gp\)
			224: R_MICROMIPS_GPREL19_S2	\.sbss)\+0x1a5a9
0+0228 <text_label\+0x228> e020 0000 	lui	at,0x0
			228: R_MICROMIPS_HI20	.data
0+022c <text_label\+0x22c> 2025 0950 	addu	at,a1,at
0+0230 <text_label\+0x230> 8481 8000 	lw	a0,0\(at\)
			230: R_MICROMIPS_LO12	.data
0+0234 <text_label\+0x234> 84a1 8000 	lw	a1,0\(at\)
			234: R_MICROMIPS_LO12	.data\+0x4
0+0238 <text_label\+0x238> e020 0000 	lui	at,0x0
			238: R_MICROMIPS_HI20	big_external_data_label
0+023c <text_label\+0x23c> 2025 0950 	addu	at,a1,at
0+0240 <text_label\+0x240> 8481 8000 	lw	a0,0\(at\)
			240: R_MICROMIPS_LO12	big_external_data_label
0+0244 <text_label\+0x244> 84a1 8000 	lw	a1,0\(at\)
			244: R_MICROMIPS_LO12	big_external_data_label\+0x4
0+0248 <text_label\+0x248> e020 0000 	lui	at,0x0
			248: R_MICROMIPS_HI20	small_external_data_label
0+024c <text_label\+0x24c> 2025 0950 	addu	at,a1,at
0+0250 <text_label\+0x250> 8481 8000 	lw	a0,0\(at\)
			250: R_MICROMIPS_LO12	small_external_data_label
0+0254 <text_label\+0x254> 84a1 8000 	lw	a1,0\(at\)
			254: R_MICROMIPS_LO12	small_external_data_label\+0x4
0+0258 <text_label\+0x258> e020 0000 	lui	at,0x0
			258: R_MICROMIPS_HI20	big_external_common
0+025c <text_label\+0x25c> 2025 0950 	addu	at,a1,at
0+0260 <text_label\+0x260> 8481 8000 	lw	a0,0\(at\)
			260: R_MICROMIPS_LO12	big_external_common
0+0264 <text_label\+0x264> 84a1 8000 	lw	a1,0\(at\)
			264: R_MICROMIPS_LO12	big_external_common\+0x4
0+0268 <text_label\+0x268> e020 0000 	lui	at,0x0
			268: R_MICROMIPS_HI20	small_external_common
0+026c <text_label\+0x26c> 2025 0950 	addu	at,a1,at
0+0270 <text_label\+0x270> 8481 8000 	lw	a0,0\(at\)
			270: R_MICROMIPS_LO12	small_external_common
0+0274 <text_label\+0x274> 84a1 8000 	lw	a1,0\(at\)
			274: R_MICROMIPS_LO12	small_external_common\+0x4
0+0278 <text_label\+0x278> e020 0000 	lui	at,0x0
			278: R_MICROMIPS_HI20	\.bss)
0+027c <text_label\+0x27c> 2025 0950 	addu	at,a1,at
0+0280 <text_label\+0x280> 8481 8000 	lw	a0,0\(at\)
			280: R_MICROMIPS_LO12	\.bss)
0+0284 <text_label\+0x284> 84a1 8000 	lw	a1,0\(at\)
			284: R_MICROMIPS_LO12	\.bss)\+0x4
0+0288 <text_label\+0x288> e020 0000 	lui	at,0x0
			288: R_MICROMIPS_HI20	\.sbss)
0+028c <text_label\+0x28c> 2025 0950 	addu	at,a1,at
0+0290 <text_label\+0x290> 8481 8000 	lw	a0,0\(at\)
			290: R_MICROMIPS_LO12	\.sbss)
0+0294 <text_label\+0x294> 84a1 8000 	lw	a1,0\(at\)
			294: R_MICROMIPS_LO12	\.sbss)\+0x4
0+0298 <text_label\+0x298> e020 0000 	lui	at,0x0
			298: R_MICROMIPS_HI20	.data\+0x1
0+029c <text_label\+0x29c> 2025 0950 	addu	at,a1,at
0+02a0 <text_label\+0x2a0> 8481 8000 	lw	a0,0\(at\)
			2a0: R_MICROMIPS_LO12	.data\+0x1
0+02a4 <text_label\+0x2a4> 84a1 8000 	lw	a1,0\(at\)
			2a4: R_MICROMIPS_LO12	.data\+0x5
0+02a8 <text_label\+0x2a8> e020 0000 	lui	at,0x0
			2a8: R_MICROMIPS_HI20	big_external_data_label\+0x1
0+02ac <text_label\+0x2ac> 2025 0950 	addu	at,a1,at
0+02b0 <text_label\+0x2b0> 8481 8000 	lw	a0,0\(at\)
			2b0: R_MICROMIPS_LO12	big_external_data_label\+0x1
0+02b4 <text_label\+0x2b4> 84a1 8000 	lw	a1,0\(at\)
			2b4: R_MICROMIPS_LO12	big_external_data_label\+0x5
0+02b8 <text_label\+0x2b8> e020 0000 	lui	at,0x0
			2b8: R_MICROMIPS_HI20	small_external_data_label\+0x1
0+02bc <text_label\+0x2bc> 2025 0950 	addu	at,a1,at
0+02c0 <text_label\+0x2c0> 8481 8000 	lw	a0,0\(at\)
			2c0: R_MICROMIPS_LO12	small_external_data_label\+0x1
0+02c4 <text_label\+0x2c4> 84a1 8000 	lw	a1,0\(at\)
			2c4: R_MICROMIPS_LO12	small_external_data_label\+0x5
0+02c8 <text_label\+0x2c8> e020 0000 	lui	at,0x0
			2c8: R_MICROMIPS_HI20	big_external_common\+0x1
0+02cc <text_label\+0x2cc> 2025 0950 	addu	at,a1,at
0+02d0 <text_label\+0x2d0> 8481 8000 	lw	a0,0\(at\)
			2d0: R_MICROMIPS_LO12	big_external_common\+0x1
0+02d4 <text_label\+0x2d4> 84a1 8000 	lw	a1,0\(at\)
			2d4: R_MICROMIPS_LO12	big_external_common\+0x5
0+02d8 <text_label\+0x2d8> e020 0000 	lui	at,0x0
			2d8: R_MICROMIPS_HI20	small_external_common\+0x1
0+02dc <text_label\+0x2dc> 2025 0950 	addu	at,a1,at
0+02e0 <text_label\+0x2e0> 8481 8000 	lw	a0,0\(at\)
			2e0: R_MICROMIPS_LO12	small_external_common\+0x1
0+02e4 <text_label\+0x2e4> 84a1 8000 	lw	a1,0\(at\)
			2e4: R_MICROMIPS_LO12	small_external_common\+0x5
0+02e8 <text_label\+0x2e8> e020 0000 	lui	at,0x0
			2e8: R_MICROMIPS_HI20	\.bss)\+0x1
0+02ec <text_label\+0x2ec> 2025 0950 	addu	at,a1,at
0+02f0 <text_label\+0x2f0> 8481 8000 	lw	a0,0\(at\)
			2f0: R_MICROMIPS_LO12	\.bss)\+0x1
0+02f4 <text_label\+0x2f4> 84a1 8000 	lw	a1,0\(at\)
			2f4: R_MICROMIPS_LO12	\.bss)\+0x5
0+02f8 <text_label\+0x2f8> e020 0000 	lui	at,0x0
			2f8: R_MICROMIPS_HI20	\.sbss)\+0x1
0+02fc <text_label\+0x2fc> 2025 0950 	addu	at,a1,at
0+0300 <text_label\+0x300> 8481 8000 	lw	a0,0\(at\)
			300: R_MICROMIPS_LO12	\.sbss)\+0x1
0+0304 <text_label\+0x304> 84a1 8000 	lw	a1,0\(at\)
			304: R_MICROMIPS_LO12	\.sbss)\+0x5
0+0308 <text_label\+0x308> e020 0000 	lui	at,0x0
			308: R_MICROMIPS_HI20	.data\+0x800
0+030c <text_label\+0x30c> 2025 0950 	addu	at,a1,at
0+0310 <text_label\+0x310> 8481 8000 	lw	a0,0\(at\)
			310: R_MICROMIPS_LO12	.data\+0x800
0+0314 <text_label\+0x314> 84a1 8000 	lw	a1,0\(at\)
			314: R_MICROMIPS_LO12	.data\+0x804
0+0318 <text_label\+0x318> e020 0000 	lui	at,0x0
			318: R_MICROMIPS_HI20	big_external_data_label\+0x800
0+031c <text_label\+0x31c> 2025 0950 	addu	at,a1,at
0+0320 <text_label\+0x320> 8481 8000 	lw	a0,0\(at\)
			320: R_MICROMIPS_LO12	big_external_data_label\+0x800
0+0324 <text_label\+0x324> 84a1 8000 	lw	a1,0\(at\)
			324: R_MICROMIPS_LO12	big_external_data_label\+0x804
0+0328 <text_label\+0x328> e020 0000 	lui	at,0x0
			328: R_MICROMIPS_HI20	small_external_data_label\+0x800
0+032c <text_label\+0x32c> 2025 0950 	addu	at,a1,at
0+0330 <text_label\+0x330> 8481 8000 	lw	a0,0\(at\)
			330: R_MICROMIPS_LO12	small_external_data_label\+0x800
0+0334 <text_label\+0x334> 84a1 8000 	lw	a1,0\(at\)
			334: R_MICROMIPS_LO12	small_external_data_label\+0x804
0+0338 <text_label\+0x338> e020 0000 	lui	at,0x0
			338: R_MICROMIPS_HI20	big_external_common\+0x800
0+033c <text_label\+0x33c> 2025 0950 	addu	at,a1,at
0+0340 <text_label\+0x340> 8481 8000 	lw	a0,0\(at\)
			340: R_MICROMIPS_LO12	big_external_common\+0x800
0+0344 <text_label\+0x344> 84a1 8000 	lw	a1,0\(at\)
			344: R_MICROMIPS_LO12	big_external_common\+0x804
0+0348 <text_label\+0x348> e020 0000 	lui	at,0x0
			348: R_MICROMIPS_HI20	small_external_common\+0x800
0+034c <text_label\+0x34c> 2025 0950 	addu	at,a1,at
0+0350 <text_label\+0x350> 8481 8000 	lw	a0,0\(at\)
			350: R_MICROMIPS_LO12	small_external_common\+0x800
0+0354 <text_label\+0x354> 84a1 8000 	lw	a1,0\(at\)
			354: R_MICROMIPS_LO12	small_external_common\+0x804
0+0358 <text_label\+0x358> e020 0000 	lui	at,0x0
			358: R_MICROMIPS_HI20	\.bss)\+0x800
0+035c <text_label\+0x35c> 2025 0950 	addu	at,a1,at
0+0360 <text_label\+0x360> 8481 8000 	lw	a0,0\(at\)
			360: R_MICROMIPS_LO12	\.bss)\+0x800
0+0364 <text_label\+0x364> 84a1 8000 	lw	a1,0\(at\)
			364: R_MICROMIPS_LO12	\.bss)\+0x804
0+0368 <text_label\+0x368> e020 0000 	lui	at,0x0
			368: R_MICROMIPS_HI20	\.sbss)\+0x800
0+036c <text_label\+0x36c> 2025 0950 	addu	at,a1,at
0+0370 <text_label\+0x370> 8481 8000 	lw	a0,0\(at\)
			370: R_MICROMIPS_LO12	\.sbss)\+0x800
0+0374 <text_label\+0x374> 84a1 8000 	lw	a1,0\(at\)
			374: R_MICROMIPS_LO12	\.sbss)\+0x804
0+0378 <text_label\+0x378> e020 0000 	lui	at,0x0
			378: R_MICROMIPS_HI20	.data-0x800
0+037c <text_label\+0x37c> 2025 0950 	addu	at,a1,at
0+0380 <text_label\+0x380> 8481 8000 	lw	a0,0\(at\)
			380: R_MICROMIPS_LO12	.data-0x800
0+0384 <text_label\+0x384> 84a1 8000 	lw	a1,0\(at\)
			384: R_MICROMIPS_LO12	.data-0x7fc
0+0388 <text_label\+0x388> e020 0000 	lui	at,0x0
			388: R_MICROMIPS_HI20	big_external_data_label-0x800
0+038c <text_label\+0x38c> 2025 0950 	addu	at,a1,at
0+0390 <text_label\+0x390> 8481 8000 	lw	a0,0\(at\)
			390: R_MICROMIPS_LO12	big_external_data_label-0x800
0+0394 <text_label\+0x394> 84a1 8000 	lw	a1,0\(at\)
			394: R_MICROMIPS_LO12	big_external_data_label-0x7fc
0+0398 <text_label\+0x398> e020 0000 	lui	at,0x0
			398: R_MICROMIPS_HI20	small_external_data_label-0x800
0+039c <text_label\+0x39c> 2025 0950 	addu	at,a1,at
0+03a0 <text_label\+0x3a0> 8481 8000 	lw	a0,0\(at\)
			3a0: R_MICROMIPS_LO12	small_external_data_label-0x800
0+03a4 <text_label\+0x3a4> 84a1 8000 	lw	a1,0\(at\)
			3a4: R_MICROMIPS_LO12	small_external_data_label-0x7fc
0+03a8 <text_label\+0x3a8> e020 0000 	lui	at,0x0
			3a8: R_MICROMIPS_HI20	big_external_common-0x800
0+03ac <text_label\+0x3ac> 2025 0950 	addu	at,a1,at
0+03b0 <text_label\+0x3b0> 8481 8000 	lw	a0,0\(at\)
			3b0: R_MICROMIPS_LO12	big_external_common-0x800
0+03b4 <text_label\+0x3b4> 84a1 8000 	lw	a1,0\(at\)
			3b4: R_MICROMIPS_LO12	big_external_common-0x7fc
0+03b8 <text_label\+0x3b8> e020 0000 	lui	at,0x0
			3b8: R_MICROMIPS_HI20	small_external_common-0x800
0+03bc <text_label\+0x3bc> 2025 0950 	addu	at,a1,at
0+03c0 <text_label\+0x3c0> 8481 8000 	lw	a0,0\(at\)
			3c0: R_MICROMIPS_LO12	small_external_common-0x800
0+03c4 <text_label\+0x3c4> 84a1 8000 	lw	a1,0\(at\)
			3c4: R_MICROMIPS_LO12	small_external_common-0x7fc
0+03c8 <text_label\+0x3c8> e020 0000 	lui	at,0x0
			3c8: R_MICROMIPS_HI20	\.bss)-0x800
0+03cc <text_label\+0x3cc> 2025 0950 	addu	at,a1,at
0+03d0 <text_label\+0x3d0> 8481 8000 	lw	a0,0\(at\)
			3d0: R_MICROMIPS_LO12	\.bss)-0x800
0+03d4 <text_label\+0x3d4> 84a1 8000 	lw	a1,0\(at\)
			3d4: R_MICROMIPS_LO12	\.bss)-0x7fc
0+03d8 <text_label\+0x3d8> e020 0000 	lui	at,0x0
			3d8: R_MICROMIPS_HI20	\.sbss)-0x800
0+03dc <text_label\+0x3dc> 2025 0950 	addu	at,a1,at
0+03e0 <text_label\+0x3e0> 8481 8000 	lw	a0,0\(at\)
			3e0: R_MICROMIPS_LO12	\.sbss)-0x800
0+03e4 <text_label\+0x3e4> 84a1 8000 	lw	a1,0\(at\)
			3e4: R_MICROMIPS_LO12	\.sbss)-0x7fc
0+03e8 <text_label\+0x3e8> e020 0000 	lui	at,0x0
			3e8: R_MICROMIPS_HI20	.data\+0x1000
0+03ec <text_label\+0x3ec> 2025 0950 	addu	at,a1,at
0+03f0 <text_label\+0x3f0> 8481 8000 	lw	a0,0\(at\)
			3f0: R_MICROMIPS_LO12	.data\+0x1000
0+03f4 <text_label\+0x3f4> 84a1 8000 	lw	a1,0\(at\)
			3f4: R_MICROMIPS_LO12	.data\+0x1004
0+03f8 <text_label\+0x3f8> e020 0000 	lui	at,0x0
			3f8: R_MICROMIPS_HI20	big_external_data_label\+0x1000
0+03fc <text_label\+0x3fc> 2025 0950 	addu	at,a1,at
0+0400 <text_label\+0x400> 8481 8000 	lw	a0,0\(at\)
			400: R_MICROMIPS_LO12	big_external_data_label\+0x1000
0+0404 <text_label\+0x404> 84a1 8000 	lw	a1,0\(at\)
			404: R_MICROMIPS_LO12	big_external_data_label\+0x1004
0+0408 <text_label\+0x408> e020 0000 	lui	at,0x0
			408: R_MICROMIPS_HI20	small_external_data_label\+0x1000
0+040c <text_label\+0x40c> 2025 0950 	addu	at,a1,at
0+0410 <text_label\+0x410> 8481 8000 	lw	a0,0\(at\)
			410: R_MICROMIPS_LO12	small_external_data_label\+0x1000
0+0414 <text_label\+0x414> 84a1 8000 	lw	a1,0\(at\)
			414: R_MICROMIPS_LO12	small_external_data_label\+0x1004
0+0418 <text_label\+0x418> e020 0000 	lui	at,0x0
			418: R_MICROMIPS_HI20	big_external_common\+0x1000
0+041c <text_label\+0x41c> 2025 0950 	addu	at,a1,at
0+0420 <text_label\+0x420> 8481 8000 	lw	a0,0\(at\)
			420: R_MICROMIPS_LO12	big_external_common\+0x1000
0+0424 <text_label\+0x424> 84a1 8000 	lw	a1,0\(at\)
			424: R_MICROMIPS_LO12	big_external_common\+0x1004
0+0428 <text_label\+0x428> e020 0000 	lui	at,0x0
			428: R_MICROMIPS_HI20	small_external_common\+0x1000
0+042c <text_label\+0x42c> 2025 0950 	addu	at,a1,at
0+0430 <text_label\+0x430> 8481 8000 	lw	a0,0\(at\)
			430: R_MICROMIPS_LO12	small_external_common\+0x1000
0+0434 <text_label\+0x434> 84a1 8000 	lw	a1,0\(at\)
			434: R_MICROMIPS_LO12	small_external_common\+0x1004
0+0438 <text_label\+0x438> e020 0000 	lui	at,0x0
			438: R_MICROMIPS_HI20	\.bss)\+0x1000
0+043c <text_label\+0x43c> 2025 0950 	addu	at,a1,at
0+0440 <text_label\+0x440> 8481 8000 	lw	a0,0\(at\)
			440: R_MICROMIPS_LO12	\.bss)\+0x1000
0+0444 <text_label\+0x444> 84a1 8000 	lw	a1,0\(at\)
			444: R_MICROMIPS_LO12	\.bss)\+0x1004
0+0448 <text_label\+0x448> e020 0000 	lui	at,0x0
			448: R_MICROMIPS_HI20	\.sbss)\+0x1000
0+044c <text_label\+0x44c> 2025 0950 	addu	at,a1,at
0+0450 <text_label\+0x450> 8481 8000 	lw	a0,0\(at\)
			450: R_MICROMIPS_LO12	\.sbss)\+0x1000
0+0454 <text_label\+0x454> 84a1 8000 	lw	a1,0\(at\)
			454: R_MICROMIPS_LO12	\.sbss)\+0x1004
0+0458 <text_label\+0x458> e020 0000 	lui	at,0x0
			458: R_MICROMIPS_HI20	.data\+0x1a5a5
0+045c <text_label\+0x45c> 2025 0950 	addu	at,a1,at
0+0460 <text_label\+0x460> 8481 8000 	lw	a0,0\(at\)
			460: R_MICROMIPS_LO12	.data\+0x1a5a5
0+0464 <text_label\+0x464> 84a1 8000 	lw	a1,0\(at\)
			464: R_MICROMIPS_LO12	.data\+0x1a5a9
0+0468 <text_label\+0x468> e020 0000 	lui	at,0x0
			468: R_MICROMIPS_HI20	big_external_data_label\+0x1a5a5
0+046c <text_label\+0x46c> 2025 0950 	addu	at,a1,at
0+0470 <text_label\+0x470> 8481 8000 	lw	a0,0\(at\)
			470: R_MICROMIPS_LO12	big_external_data_label\+0x1a5a5
0+0474 <text_label\+0x474> 84a1 8000 	lw	a1,0\(at\)
			474: R_MICROMIPS_LO12	big_external_data_label\+0x1a5a9
0+0478 <text_label\+0x478> e020 0000 	lui	at,0x0
			478: R_MICROMIPS_HI20	small_external_data_label\+0x1a5a5
0+047c <text_label\+0x47c> 2025 0950 	addu	at,a1,at
0+0480 <text_label\+0x480> 8481 8000 	lw	a0,0\(at\)
			480: R_MICROMIPS_LO12	small_external_data_label\+0x1a5a5
0+0484 <text_label\+0x484> 84a1 8000 	lw	a1,0\(at\)
			484: R_MICROMIPS_LO12	small_external_data_label\+0x1a5a9
0+0488 <text_label\+0x488> e020 0000 	lui	at,0x0
			488: R_MICROMIPS_HI20	big_external_common\+0x1a5a5
0+048c <text_label\+0x48c> 2025 0950 	addu	at,a1,at
0+0490 <text_label\+0x490> 8481 8000 	lw	a0,0\(at\)
			490: R_MICROMIPS_LO12	big_external_common\+0x1a5a5
0+0494 <text_label\+0x494> 84a1 8000 	lw	a1,0\(at\)
			494: R_MICROMIPS_LO12	big_external_common\+0x1a5a9
0+0498 <text_label\+0x498> e020 0000 	lui	at,0x0
			498: R_MICROMIPS_HI20	small_external_common\+0x1a5a5
0+049c <text_label\+0x49c> 2025 0950 	addu	at,a1,at
0+04a0 <text_label\+0x4a0> 8481 8000 	lw	a0,0\(at\)
			4a0: R_MICROMIPS_LO12	small_external_common\+0x1a5a5
0+04a4 <text_label\+0x4a4> 84a1 8000 	lw	a1,0\(at\)
			4a4: R_MICROMIPS_LO12	small_external_common\+0x1a5a9
0+04a8 <text_label\+0x4a8> e020 0000 	lui	at,0x0
			4a8: R_MICROMIPS_HI20	\.bss)\+0x1a5a5
0+04ac <text_label\+0x4ac> 2025 0950 	addu	at,a1,at
0+04b0 <text_label\+0x4b0> 8481 8000 	lw	a0,0\(at\)
			4b0: R_MICROMIPS_LO12	\.bss)\+0x1a5a5
0+04b4 <text_label\+0x4b4> 84a1 8000 	lw	a1,0\(at\)
			4b4: R_MICROMIPS_LO12	\.bss)\+0x1a5a9
0+04b8 <text_label\+0x4b8> e020 0000 	lui	at,0x0
			4b8: R_MICROMIPS_HI20	\.sbss)\+0x1a5a5
0+04bc <text_label\+0x4bc> 2025 0950 	addu	at,a1,at
0+04c0 <text_label\+0x4c0> 8481 8000 	lw	a0,0\(at\)
			4c0: R_MICROMIPS_LO12	\.sbss)\+0x1a5a5
0+04c4 <text_label\+0x4c4> 84a1 8000 	lw	a1,0\(at\)
			4c4: R_MICROMIPS_LO12	\.sbss)\+0x1a5a9
	...
#pass
