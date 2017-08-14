#objdump: -dr --prefix-addresses --show-raw-insn
#as: -p32 --defsym tsw=1
#name: nanoMIPS sw
#source: ld.s

# Test the sw macro.

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> 8480 8000 	lw	a0,0\(zero\)
0+0004 <text_label\+0x4> 84a0 8004 	lw	a1,4\(zero\)
0+0008 <text_label\+0x8> 8480 8001 	lw	a0,1\(zero\)
0+000c <text_label\+0xc> 84a0 8005 	lw	a1,5\(zero\)
0+0010 <text_label\+0x10> e020 0001 	lui	at,%hi\(0x80000000\)
0+0014 <text_label\+0x14> 8481 8000 	lw	a0,0\(at\)
0+0018 <text_label\+0x18> 84a1 8004 	lw	a1,4\(at\)
0+001c <text_label\+0x1c> e020 0000 	lui	at,0x0
0+0020 <text_label\+0x20> 8481 8000 	lw	a0,0\(at\)
0+0024 <text_label\+0x24> 84a1 8004 	lw	a1,4\(at\)
0+0028 <text_label\+0x28> e020 0001 	lui	at,%hi\(0x80000000\)
0+002c <text_label\+0x2c> 8481 8000 	lw	a0,0\(at\)
0+0030 <text_label\+0x30> 84a1 8004 	lw	a1,4\(at\)
0+0034 <text_label\+0x34> e020 0002 	auipc	at,00000034 <text_label\+0x34>
0+0038 <text_label\+0x38> 8481 85a5 	lw	a0,1445\(at\)
0+003c <text_label\+0x3c> 84a1 85a9 	lw	a1,1449\(at\)
0+0040 <text_label\+0x40> 8485 8000 	lw	a0,0\(a1\)
0+0044 <text_label\+0x44> 84a5 8004 	lw	a1,4\(a1\)
0+0048 <text_label\+0x48> 8485 8001 	lw	a0,1\(a1\)
0+004c <text_label\+0x4c> 84a5 8005 	lw	a1,5\(a1\)
0+0050 <text_label\+0x50> e020 0001 	lui	at,%hi\(0x80000000\)
0+0054 <text_label\+0x54> 2025 0950 	addu	at,a1,at
0+0058 <text_label\+0x58> 8481 8000 	lw	a0,0\(at\)
0+005c <text_label\+0x5c> 84a1 8004 	lw	a1,4\(at\)
0+0060 <text_label\+0x60> e020 0000 	lui	at,0x0
0+0064 <text_label\+0x64> 2025 0950 	addu	at,a1,at
0+0068 <text_label\+0x68> 8481 8000 	lw	a0,0\(at\)
0+006c <text_label\+0x6c> 84a1 8004 	lw	a1,4\(at\)
0+0070 <text_label\+0x70> e020 0001 	lui	at,%hi\(0x80000000\)
0+0074 <text_label\+0x74> 2025 0950 	addu	at,a1,at
0+0078 <text_label\+0x78> 8481 8000 	lw	a0,0\(at\)
0+007c <text_label\+0x7c> 84a1 8004 	lw	a1,4\(at\)
0+0080 <text_label\+0x80> e020 0002 	auipc	at,00000080 <text_label\+0x80>
0+0084 <text_label\+0x84> 2025 0950 	addu	at,a1,at
0+0088 <text_label\+0x88> 8481 85a5 	lw	a0,1445\(at\)
0+008c <text_label\+0x8c> 84a1 85a9 	lw	a1,1449\(at\)
0+0090 <text_label\+0x90> e020 0000 	lui	at,0x0
			90: R_NANOMIPS_HI20	.data
0+0094 <text_label\+0x94> 8481 8000 	lw	a0,0\(at\)
			94: R_NANOMIPS_LO12	.data
0+0098 <text_label\+0x98> 84a1 8000 	lw	a1,0\(at\)
			98: R_NANOMIPS_LO12	.data\+0x4
0+009c <text_label\+0x9c> e020 0000 	lui	at,0x0
			9c: R_NANOMIPS_HI20	big_external_data_label
0+00a0 <text_label\+0xa0> 8481 8000 	lw	a0,0\(at\)
			a0: R_NANOMIPS_LO12	big_external_data_label
0+00a4 <text_label\+0xa4> 84a1 8000 	lw	a1,0\(at\)
			a4: R_NANOMIPS_LO12	big_external_data_label\+0x4
0+00a8 <text_label\+0xa8> 4080 0002 	lw	a0,0\(gp\)
			a8: R_NANOMIPS_GPREL19_S2	small_external_data_label
0+00ac <text_label\+0xac> 40a0 0002 	lw	a1,0\(gp\)
			ac: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x4
0+00b0 <text_label\+0xb0> e020 0000 	lui	at,0x0
			b0: R_NANOMIPS_HI20	big_external_common
0+00b4 <text_label\+0xb4> 8481 8000 	lw	a0,0\(at\)
			b4: R_NANOMIPS_LO12	big_external_common
0+00b8 <text_label\+0xb8> 84a1 8000 	lw	a1,0\(at\)
			b8: R_NANOMIPS_LO12	big_external_common\+0x4
0+00bc <text_label\+0xbc> 4080 0002 	lw	a0,0\(gp\)
			bc: R_NANOMIPS_GPREL19_S2	small_external_common
0+00c0 <text_label\+0xc0> 40a0 0002 	lw	a1,0\(gp\)
			c0: R_NANOMIPS_GPREL19_S2	small_external_common\+0x4
0+00c4 <text_label\+0xc4> e020 0000 	lui	at,0x0
			c4: R_NANOMIPS_HI20	.bss
0+00c8 <text_label\+0xc8> 8481 8000 	lw	a0,0\(at\)
			c8: R_NANOMIPS_LO12	.bss
0+00cc <text_label\+0xcc> 84a1 8000 	lw	a1,0\(at\)
			cc: R_NANOMIPS_LO12	.bss\+0x4
0+00d0 <text_label\+0xd0> 4080 0002 	lw	a0,0\(gp\)
			d0: R_NANOMIPS_GPREL19_S2	.sbss
0+00d4 <text_label\+0xd4> 40a0 0002 	lw	a1,0\(gp\)
			d4: R_NANOMIPS_GPREL19_S2	.sbss\+0x4
0+00d8 <text_label\+0xd8> e020 0000 	lui	at,0x0
			d8: R_NANOMIPS_HI20	.data\+0x1
0+00dc <text_label\+0xdc> 8481 8000 	lw	a0,0\(at\)
			dc: R_NANOMIPS_LO12	.data\+0x1
0+00e0 <text_label\+0xe0> 84a1 8000 	lw	a1,0\(at\)
			e0: R_NANOMIPS_LO12	.data\+0x5
0+00e4 <text_label\+0xe4> e020 0000 	lui	at,0x0
			e4: R_NANOMIPS_HI20	big_external_data_label\+0x1
0+00e8 <text_label\+0xe8> 8481 8000 	lw	a0,0\(at\)
			e8: R_NANOMIPS_LO12	big_external_data_label\+0x1
0+00ec <text_label\+0xec> 84a1 8000 	lw	a1,0\(at\)
			ec: R_NANOMIPS_LO12	big_external_data_label\+0x5
0+00f0 <text_label\+0xf0> 4080 0002 	lw	a0,0\(gp\)
			f0: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1
0+00f4 <text_label\+0xf4> 40a0 0002 	lw	a1,0\(gp\)
			f4: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x5
0+00f8 <text_label\+0xf8> e020 0000 	lui	at,0x0
			f8: R_NANOMIPS_HI20	big_external_common\+0x1
0+00fc <text_label\+0xfc> 8481 8000 	lw	a0,0\(at\)
			fc: R_NANOMIPS_LO12	big_external_common\+0x1
0+0100 <text_label\+0x100> 84a1 8000 	lw	a1,0\(at\)
			100: R_NANOMIPS_LO12	big_external_common\+0x5
0+0104 <text_label\+0x104> 4080 0002 	lw	a0,0\(gp\)
			104: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1
0+0108 <text_label\+0x108> 40a0 0002 	lw	a1,0\(gp\)
			108: R_NANOMIPS_GPREL19_S2	small_external_common\+0x5
0+010c <text_label\+0x10c> e020 0000 	lui	at,0x0
			10c: R_NANOMIPS_HI20	.bss\+0x1
0+0110 <text_label\+0x110> 8481 8000 	lw	a0,0\(at\)
			110: R_NANOMIPS_LO12	.bss\+0x1
0+0114 <text_label\+0x114> 84a1 8000 	lw	a1,0\(at\)
			114: R_NANOMIPS_LO12	.bss\+0x5
0+0118 <text_label\+0x118> 4080 0002 	lw	a0,0\(gp\)
			118: R_NANOMIPS_GPREL19_S2	.sbss\+0x1
0+011c <text_label\+0x11c> 40a0 0002 	lw	a1,0\(gp\)
			11c: R_NANOMIPS_GPREL19_S2	.sbss\+0x5
0+0120 <text_label\+0x120> e020 0000 	lui	at,0x0
			120: R_NANOMIPS_HI20	.data\+0x8000
0+0124 <text_label\+0x124> 8481 8000 	lw	a0,0\(at\)
			124: R_NANOMIPS_LO12	.data\+0x8000
0+0128 <text_label\+0x128> 84a1 8000 	lw	a1,0\(at\)
			128: R_NANOMIPS_LO12	.data\+0x8004
0+012c <text_label\+0x12c> e020 0000 	lui	at,0x0
			12c: R_NANOMIPS_HI20	big_external_data_label\+0x8000
0+0130 <text_label\+0x130> 8481 8000 	lw	a0,0\(at\)
			130: R_NANOMIPS_LO12	big_external_data_label\+0x8000
0+0134 <text_label\+0x134> 84a1 8000 	lw	a1,0\(at\)
			134: R_NANOMIPS_LO12	big_external_data_label\+0x8004
0+0138 <text_label\+0x138> e020 0000 	lui	at,0x0
			138: R_NANOMIPS_HI20	small_external_data_label\+0x8000
0+013c <text_label\+0x13c> 8481 8000 	lw	a0,0\(at\)
			13c: R_NANOMIPS_LO12	small_external_data_label\+0x8000
0+0140 <text_label\+0x140> 84a1 8000 	lw	a1,0\(at\)
			140: R_NANOMIPS_LO12	small_external_data_label\+0x8004
0+0144 <text_label\+0x144> e020 0000 	lui	at,0x0
			144: R_NANOMIPS_HI20	big_external_common\+0x8000
0+0148 <text_label\+0x148> 8481 8000 	lw	a0,0\(at\)
			148: R_NANOMIPS_LO12	big_external_common\+0x8000
0+014c <text_label\+0x14c> 84a1 8000 	lw	a1,0\(at\)
			14c: R_NANOMIPS_LO12	big_external_common\+0x8004
0+0150 <text_label\+0x150> e020 0000 	lui	at,0x0
			150: R_NANOMIPS_HI20	small_external_common\+0x8000
0+0154 <text_label\+0x154> 8481 8000 	lw	a0,0\(at\)
			154: R_NANOMIPS_LO12	small_external_common\+0x8000
0+0158 <text_label\+0x158> 84a1 8000 	lw	a1,0\(at\)
			158: R_NANOMIPS_LO12	small_external_common\+0x8004
0+015c <text_label\+0x15c> e020 0000 	lui	at,0x0
			15c: R_NANOMIPS_HI20	.bss\+0x8000
0+0160 <text_label\+0x160> 8481 8000 	lw	a0,0\(at\)
			160: R_NANOMIPS_LO12	.bss\+0x8000
0+0164 <text_label\+0x164> 84a1 8000 	lw	a1,0\(at\)
			164: R_NANOMIPS_LO12	.bss\+0x8004
0+0168 <text_label\+0x168> e020 0000 	lui	at,0x0
			168: R_NANOMIPS_HI20	.sbss\+0x8000
0+016c <text_label\+0x16c> 8481 8000 	lw	a0,0\(at\)
			16c: R_NANOMIPS_LO12	.sbss\+0x8000
0+0170 <text_label\+0x170> 84a1 8000 	lw	a1,0\(at\)
			170: R_NANOMIPS_LO12	.sbss\+0x8004
0+0174 <text_label\+0x174> e020 0000 	lui	at,0x0
			174: R_NANOMIPS_HI20	.data-0x8000
0+0178 <text_label\+0x178> 8481 8000 	lw	a0,0\(at\)
			178: R_NANOMIPS_LO12	.data-0x8000
0+017c <text_label\+0x17c> 84a1 8000 	lw	a1,0\(at\)
			17c: R_NANOMIPS_LO12	.data-0x7ffc
0+0180 <text_label\+0x180> e020 0000 	lui	at,0x0
			180: R_NANOMIPS_HI20	big_external_data_label-0x8000
0+0184 <text_label\+0x184> 8481 8000 	lw	a0,0\(at\)
			184: R_NANOMIPS_LO12	big_external_data_label-0x8000
0+0188 <text_label\+0x188> 84a1 8000 	lw	a1,0\(at\)
			188: R_NANOMIPS_LO12	big_external_data_label-0x7ffc
0+018c <text_label\+0x18c> e020 0000 	lui	at,0x0
			18c: R_NANOMIPS_HI20	small_external_data_label-0x8000
0+0190 <text_label\+0x190> 8481 8000 	lw	a0,0\(at\)
			190: R_NANOMIPS_LO12	small_external_data_label-0x8000
0+0194 <text_label\+0x194> 84a1 8000 	lw	a1,0\(at\)
			194: R_NANOMIPS_LO12	small_external_data_label-0x7ffc
0+0198 <text_label\+0x198> e020 0000 	lui	at,0x0
			198: R_NANOMIPS_HI20	big_external_common-0x8000
0+019c <text_label\+0x19c> 8481 8000 	lw	a0,0\(at\)
			19c: R_NANOMIPS_LO12	big_external_common-0x8000
0+01a0 <text_label\+0x1a0> 84a1 8000 	lw	a1,0\(at\)
			1a0: R_NANOMIPS_LO12	big_external_common-0x7ffc
0+01a4 <text_label\+0x1a4> e020 0000 	lui	at,0x0
			1a4: R_NANOMIPS_HI20	small_external_common-0x8000
0+01a8 <text_label\+0x1a8> 8481 8000 	lw	a0,0\(at\)
			1a8: R_NANOMIPS_LO12	small_external_common-0x8000
0+01ac <text_label\+0x1ac> 84a1 8000 	lw	a1,0\(at\)
			1ac: R_NANOMIPS_LO12	small_external_common-0x7ffc
0+01b0 <text_label\+0x1b0> e020 0000 	lui	at,0x0
			1b0: R_NANOMIPS_HI20	.bss-0x8000
0+01b4 <text_label\+0x1b4> 8481 8000 	lw	a0,0\(at\)
			1b4: R_NANOMIPS_LO12	.bss-0x8000
0+01b8 <text_label\+0x1b8> 84a1 8000 	lw	a1,0\(at\)
			1b8: R_NANOMIPS_LO12	.bss-0x7ffc
0+01bc <text_label\+0x1bc> e020 0000 	lui	at,0x0
			1bc: R_NANOMIPS_HI20	.sbss-0x8000
0+01c0 <text_label\+0x1c0> 8481 8000 	lw	a0,0\(at\)
			1c0: R_NANOMIPS_LO12	.sbss-0x8000
0+01c4 <text_label\+0x1c4> 84a1 8000 	lw	a1,0\(at\)
			1c4: R_NANOMIPS_LO12	.sbss-0x7ffc
0+01c8 <text_label\+0x1c8> e020 0000 	lui	at,0x0
			1c8: R_NANOMIPS_HI20	.data\+0x10000
0+01cc <text_label\+0x1cc> 8481 8000 	lw	a0,0\(at\)
			1cc: R_NANOMIPS_LO12	.data\+0x10000
0+01d0 <text_label\+0x1d0> 84a1 8000 	lw	a1,0\(at\)
			1d0: R_NANOMIPS_LO12	.data\+0x10004
0+01d4 <text_label\+0x1d4> e020 0000 	lui	at,0x0
			1d4: R_NANOMIPS_HI20	big_external_data_label\+0x10000
0+01d8 <text_label\+0x1d8> 8481 8000 	lw	a0,0\(at\)
			1d8: R_NANOMIPS_LO12	big_external_data_label\+0x10000
0+01dc <text_label\+0x1dc> 84a1 8000 	lw	a1,0\(at\)
			1dc: R_NANOMIPS_LO12	big_external_data_label\+0x10004
0+01e0 <text_label\+0x1e0> e020 0000 	lui	at,0x0
			1e0: R_NANOMIPS_HI20	small_external_data_label\+0x10000
0+01e4 <text_label\+0x1e4> 8481 8000 	lw	a0,0\(at\)
			1e4: R_NANOMIPS_LO12	small_external_data_label\+0x10000
0+01e8 <text_label\+0x1e8> 84a1 8000 	lw	a1,0\(at\)
			1e8: R_NANOMIPS_LO12	small_external_data_label\+0x10004
0+01ec <text_label\+0x1ec> e020 0000 	lui	at,0x0
			1ec: R_NANOMIPS_HI20	big_external_common\+0x10000
0+01f0 <text_label\+0x1f0> 8481 8000 	lw	a0,0\(at\)
			1f0: R_NANOMIPS_LO12	big_external_common\+0x10000
0+01f4 <text_label\+0x1f4> 84a1 8000 	lw	a1,0\(at\)
			1f4: R_NANOMIPS_LO12	big_external_common\+0x10004
0+01f8 <text_label\+0x1f8> e020 0000 	lui	at,0x0
			1f8: R_NANOMIPS_HI20	small_external_common\+0x10000
0+01fc <text_label\+0x1fc> 8481 8000 	lw	a0,0\(at\)
			1fc: R_NANOMIPS_LO12	small_external_common\+0x10000
0+0200 <text_label\+0x200> 84a1 8000 	lw	a1,0\(at\)
			200: R_NANOMIPS_LO12	small_external_common\+0x10004
0+0204 <text_label\+0x204> e020 0000 	lui	at,0x0
			204: R_NANOMIPS_HI20	.bss\+0x10000
0+0208 <text_label\+0x208> 8481 8000 	lw	a0,0\(at\)
			208: R_NANOMIPS_LO12	.bss\+0x10000
0+020c <text_label\+0x20c> 84a1 8000 	lw	a1,0\(at\)
			20c: R_NANOMIPS_LO12	.bss\+0x10004
0+0210 <text_label\+0x210> e020 0000 	lui	at,0x0
			210: R_NANOMIPS_HI20	.sbss\+0x10000
0+0214 <text_label\+0x214> 8481 8000 	lw	a0,0\(at\)
			214: R_NANOMIPS_LO12	.sbss\+0x10000
0+0218 <text_label\+0x218> 84a1 8000 	lw	a1,0\(at\)
			218: R_NANOMIPS_LO12	.sbss\+0x10004
0+021c <text_label\+0x21c> e020 0000 	lui	at,0x0
			21c: R_NANOMIPS_HI20	.data\+0x1a5a5
0+0220 <text_label\+0x220> 8481 8000 	lw	a0,0\(at\)
			220: R_NANOMIPS_LO12	.data\+0x1a5a5
0+0224 <text_label\+0x224> 84a1 8000 	lw	a1,0\(at\)
			224: R_NANOMIPS_LO12	.data\+0x1a5a9
0+0228 <text_label\+0x228> e020 0000 	lui	at,0x0
			228: R_NANOMIPS_HI20	big_external_data_label\+0x1a5a5
0+022c <text_label\+0x22c> 8481 8000 	lw	a0,0\(at\)
			22c: R_NANOMIPS_LO12	big_external_data_label\+0x1a5a5
0+0230 <text_label\+0x230> 84a1 8000 	lw	a1,0\(at\)
			230: R_NANOMIPS_LO12	big_external_data_label\+0x1a5a9
0+0234 <text_label\+0x234> e020 0000 	lui	at,0x0
			234: R_NANOMIPS_HI20	small_external_data_label\+0x1a5a5
0+0238 <text_label\+0x238> 8481 8000 	lw	a0,0\(at\)
			238: R_NANOMIPS_LO12	small_external_data_label\+0x1a5a5
0+023c <text_label\+0x23c> 84a1 8000 	lw	a1,0\(at\)
			23c: R_NANOMIPS_LO12	small_external_data_label\+0x1a5a9
0+0240 <text_label\+0x240> e020 0000 	lui	at,0x0
			240: R_NANOMIPS_HI20	big_external_common\+0x1a5a5
0+0244 <text_label\+0x244> 8481 8000 	lw	a0,0\(at\)
			244: R_NANOMIPS_LO12	big_external_common\+0x1a5a5
0+0248 <text_label\+0x248> 84a1 8000 	lw	a1,0\(at\)
			248: R_NANOMIPS_LO12	big_external_common\+0x1a5a9
0+024c <text_label\+0x24c> e020 0000 	lui	at,0x0
			24c: R_NANOMIPS_HI20	small_external_common\+0x1a5a5
0+0250 <text_label\+0x250> 8481 8000 	lw	a0,0\(at\)
			250: R_NANOMIPS_LO12	small_external_common\+0x1a5a5
0+0254 <text_label\+0x254> 84a1 8000 	lw	a1,0\(at\)
			254: R_NANOMIPS_LO12	small_external_common\+0x1a5a9
0+0258 <text_label\+0x258> e020 0000 	lui	at,0x0
			258: R_NANOMIPS_HI20	.bss\+0x1a5a5
0+025c <text_label\+0x25c> 8481 8000 	lw	a0,0\(at\)
			25c: R_NANOMIPS_LO12	.bss\+0x1a5a5
0+0260 <text_label\+0x260> 84a1 8000 	lw	a1,0\(at\)
			260: R_NANOMIPS_LO12	.bss\+0x1a5a9
0+0264 <text_label\+0x264> e020 0000 	lui	at,0x0
			264: R_NANOMIPS_HI20	.sbss\+0x1a5a5
0+0268 <text_label\+0x268> 8481 8000 	lw	a0,0\(at\)
			268: R_NANOMIPS_LO12	.sbss\+0x1a5a5
0+026c <text_label\+0x26c> 84a1 8000 	lw	a1,0\(at\)
			26c: R_NANOMIPS_LO12	.sbss\+0x1a5a9
	\.\.\.
#pass