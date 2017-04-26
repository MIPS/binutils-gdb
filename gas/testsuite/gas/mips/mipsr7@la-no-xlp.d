#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS R7 la without li[48]
#as:
#source: la.s

# Test the la macro.

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> 0080 0000 	li	a0,0
0+0004 <text_label\+0x4> 0080 0001 	li	a0,1
0+0008 <text_label\+0x8> 0080 8000 	li	a0,32768
0+000c <text_label\+0xc> e09f 8ffd 	lui	a0,0xffff8
0+0010 <text_label\+0x10> e081 0000 	lui	a0,0x10
0+0014 <text_label\+0x14> e081 a000 	lui	a0,0x1a
0+0018 <text_label\+0x18> 8084 05a5 	ori	a0,a0,1445
0+001c <text_label\+0x1c> 0085 0000 	addiu	a0,a1,0
0+0020 <text_label\+0x20> 0085 0001 	addiu	a0,a1,1
0+0024 <text_label\+0x24> 0080 8000 	li	a0,32768
0+0028 <text_label\+0x28> 20a4 2150 	addu	a0,a0,a1
0+002c <text_label\+0x2c> e09f 8ffd 	lui	a0,0xffff8
0+0030 <text_label\+0x30> 20a4 2150 	addu	a0,a0,a1
0+0034 <text_label\+0x34> e081 0000 	lui	a0,0x10
0+0038 <text_label\+0x38> 20a4 2150 	addu	a0,a0,a1
0+003c <text_label\+0x3c> e081 a000 	lui	a0,0x1a
0+0040 <text_label\+0x40> 8084 05a5 	ori	a0,a0,1445
0+0044 <text_label\+0x44> 20a4 2150 	addu	a0,a0,a1
0+0048 <text_label\+0x48> e080 0000 	lui	a0,0x0
			48: R_MICROMIPS_HI20	\.data
0+004c <text_label\+0x4c> 0084 0000 	addiu	a0,a0,0
			4c: R_MICROMIPS_LO12	\.data
0+0050 <text_label\+0x50> e080 0000 	lui	a0,0x0
			50: R_MICROMIPS_HI20	big_external_data_label
0+0054 <text_label\+0x54> 0084 0000 	addiu	a0,a0,0
			54: R_MICROMIPS_LO12	big_external_data_label
0+0058 <text_label\+0x58> 4080 0000 	addiu	a0,gp,0
			58: R_MICROMIPS_GPREL19_S2	small_external_data_label
0+005c <text_label\+0x5c> e080 0000 	lui	a0,0x0
			5c: R_MICROMIPS_HI20	big_external_common
0+0060 <text_label\+0x60> 0084 0000 	addiu	a0,a0,0
			60: R_MICROMIPS_LO12	big_external_common
0+0064 <text_label\+0x64> 4080 0000 	addiu	a0,gp,0
			64: R_MICROMIPS_GPREL19_S2	small_external_common
0+0068 <text_label\+0x68> e080 0000 	lui	a0,0x0
			68: R_MICROMIPS_HI20	\.bss
0+006c <text_label\+0x6c> 0084 0000 	addiu	a0,a0,0
			6c: R_MICROMIPS_LO12	\.bss
0+0070 <text_label\+0x70> 4080 0000 	addiu	a0,gp,0
			70: R_MICROMIPS_GPREL19_S2	\.sbss
0+0074 <text_label\+0x74> e080 0000 	lui	a0,0x0
			74: R_MICROMIPS_HI20	\.data\+0x1
0+0078 <text_label\+0x78> 0084 0000 	addiu	a0,a0,0
			78: R_MICROMIPS_LO12	\.data\+0x1
0+007c <text_label\+0x7c> e080 0000 	lui	a0,0x0
			7c: R_MICROMIPS_HI20	big_external_data_label\+0x1
0+0080 <text_label\+0x80> 0084 0000 	addiu	a0,a0,0
			80: R_MICROMIPS_LO12	big_external_data_label\+0x1
0+0084 <text_label\+0x84> 4080 0000 	addiu	a0,gp,0
			84: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x1
0+0088 <text_label\+0x88> e080 0000 	lui	a0,0x0
			88: R_MICROMIPS_HI20	big_external_common\+0x1
0+008c <text_label\+0x8c> 0084 0000 	addiu	a0,a0,0
			8c: R_MICROMIPS_LO12	big_external_common\+0x1
0+0090 <text_label\+0x90> 4080 0000 	addiu	a0,gp,0
			90: R_MICROMIPS_GPREL19_S2	small_external_common\+0x1
0+0094 <text_label\+0x94> e080 0000 	lui	a0,0x0
			94: R_MICROMIPS_HI20	\.bss\+0x1
0+0098 <text_label\+0x98> 0084 0000 	addiu	a0,a0,0
			98: R_MICROMIPS_LO12	\.bss\+0x1
0+009c <text_label\+0x9c> 4080 0000 	addiu	a0,gp,0
			9c: R_MICROMIPS_GPREL19_S2	\.sbss\+0x1
0+00a0 <text_label\+0xa0> e080 0000 	lui	a0,0x0
			a0: R_MICROMIPS_HI20	\.data\+0x8000
0+00a4 <text_label\+0xa4> 0084 0000 	addiu	a0,a0,0
			a4: R_MICROMIPS_LO12	\.data\+0x8000
0+00a8 <text_label\+0xa8> e080 0000 	lui	a0,0x0
			a8: R_MICROMIPS_HI20	big_external_data_label\+0x8000
0+00ac <text_label\+0xac> 0084 0000 	addiu	a0,a0,0
			ac: R_MICROMIPS_LO12	big_external_data_label\+0x8000
0+00b0 <text_label\+0xb0> 4080 0000 	addiu	a0,gp,0
			b0: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x8000
0+00b4 <text_label\+0xb4> e080 0000 	lui	a0,0x0
			b4: R_MICROMIPS_HI20	big_external_common\+0x8000
0+00b8 <text_label\+0xb8> 0084 0000 	addiu	a0,a0,0
			b8: R_MICROMIPS_LO12	big_external_common\+0x8000
0+00bc <text_label\+0xbc> 4080 0000 	addiu	a0,gp,0
			bc: R_MICROMIPS_GPREL19_S2	small_external_common\+0x8000
0+00c0 <text_label\+0xc0> e080 0000 	lui	a0,0x0
			c0: R_MICROMIPS_HI20	\.bss\+0x8000
0+00c4 <text_label\+0xc4> 0084 0000 	addiu	a0,a0,0
			c4: R_MICROMIPS_LO12	\.bss\+0x8000
0+00c8 <text_label\+0xc8> 4080 0000 	addiu	a0,gp,0
			c8: R_MICROMIPS_GPREL19_S2	\.sbss\+0x8000
0+00cc <text_label\+0xcc> e080 0000 	lui	a0,0x0
			cc: R_MICROMIPS_HI20	\.data-0x8000
0+00d0 <text_label\+0xd0> 0084 0000 	addiu	a0,a0,0
			d0: R_MICROMIPS_LO12	\.data-0x8000
0+00d4 <text_label\+0xd4> e080 0000 	lui	a0,0x0
			d4: R_MICROMIPS_HI20	big_external_data_label-0x8000
0+00d8 <text_label\+0xd8> 0084 0000 	addiu	a0,a0,0
			d8: R_MICROMIPS_LO12	big_external_data_label-0x8000
0+00dc <text_label\+0xdc> e080 0000 	lui	a0,0x0
			dc: R_MICROMIPS_HI20	small_external_data_label-0x8000
0+00e0 <text_label\+0xe0> 0084 0000 	addiu	a0,a0,0
			e0: R_MICROMIPS_LO12	small_external_data_label-0x8000
0+00e4 <text_label\+0xe4> e080 0000 	lui	a0,0x0
			e4: R_MICROMIPS_HI20	big_external_common-0x8000
0+00e8 <text_label\+0xe8> 0084 0000 	addiu	a0,a0,0
			e8: R_MICROMIPS_LO12	big_external_common-0x8000
0+00ec <text_label\+0xec> e080 0000 	lui	a0,0x0
			ec: R_MICROMIPS_HI20	small_external_common-0x8000
0+00f0 <text_label\+0xf0> 0084 0000 	addiu	a0,a0,0
			f0: R_MICROMIPS_LO12	small_external_common-0x8000
0+00f4 <text_label\+0xf4> e080 0000 	lui	a0,0x0
			f4: R_MICROMIPS_HI20	\.bss-0x8000
0+00f8 <text_label\+0xf8> 0084 0000 	addiu	a0,a0,0
			f8: R_MICROMIPS_LO12	\.bss-0x8000
0+00fc <text_label\+0xfc> e080 0000 	lui	a0,0x0
			fc: R_MICROMIPS_HI20	\.sbss-0x8000
0+0100 <text_label\+0x100> 0084 0000 	addiu	a0,a0,0
			100: R_MICROMIPS_LO12	\.sbss-0x8000
0+0104 <text_label\+0x104> e080 0000 	lui	a0,0x0
			104: R_MICROMIPS_HI20	\.data\+0x10000
0+0108 <text_label\+0x108> 0084 0000 	addiu	a0,a0,0
			108: R_MICROMIPS_LO12	\.data\+0x10000
0+010c <text_label\+0x10c> e080 0000 	lui	a0,0x0
			10c: R_MICROMIPS_HI20	big_external_data_label\+0x10000
0+0110 <text_label\+0x110> 0084 0000 	addiu	a0,a0,0
			110: R_MICROMIPS_LO12	big_external_data_label\+0x10000
0+0114 <text_label\+0x114> 4080 0000 	addiu	a0,gp,0
			114: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x10000
0+0118 <text_label\+0x118> e080 0000 	lui	a0,0x0
			118: R_MICROMIPS_HI20	big_external_common\+0x10000
0+011c <text_label\+0x11c> 0084 0000 	addiu	a0,a0,0
			11c: R_MICROMIPS_LO12	big_external_common\+0x10000
0+0120 <text_label\+0x120> 4080 0000 	addiu	a0,gp,0
			120: R_MICROMIPS_GPREL19_S2	small_external_common\+0x10000
0+0124 <text_label\+0x124> e080 0000 	lui	a0,0x0
			124: R_MICROMIPS_HI20	\.bss\+0x10000
0+0128 <text_label\+0x128> 0084 0000 	addiu	a0,a0,0
			128: R_MICROMIPS_LO12	\.bss\+0x10000
0+012c <text_label\+0x12c> 4080 0000 	addiu	a0,gp,0
			12c: R_MICROMIPS_GPREL19_S2	\.sbss\+0x10000
0+0130 <text_label\+0x130> e080 0000 	lui	a0,0x0
			130: R_MICROMIPS_HI20	\.data\+0x1a5a5
0+0134 <text_label\+0x134> 0084 0000 	addiu	a0,a0,0
			134: R_MICROMIPS_LO12	\.data\+0x1a5a5
0+0138 <text_label\+0x138> e080 0000 	lui	a0,0x0
			138: R_MICROMIPS_HI20	big_external_data_label\+0x1a5a5
0+013c <text_label\+0x13c> 0084 0000 	addiu	a0,a0,0
			13c: R_MICROMIPS_LO12	big_external_data_label\+0x1a5a5
0+0140 <text_label\+0x140> 4080 0000 	addiu	a0,gp,0
			140: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x1a5a5
0+0144 <text_label\+0x144> e080 0000 	lui	a0,0x0
			144: R_MICROMIPS_HI20	big_external_common\+0x1a5a5
0+0148 <text_label\+0x148> 0084 0000 	addiu	a0,a0,0
			148: R_MICROMIPS_LO12	big_external_common\+0x1a5a5
0+014c <text_label\+0x14c> 4080 0000 	addiu	a0,gp,0
			14c: R_MICROMIPS_GPREL19_S2	small_external_common\+0x1a5a5
0+0150 <text_label\+0x150> e080 0000 	lui	a0,0x0
			150: R_MICROMIPS_HI20	\.bss\+0x1a5a5
0+0154 <text_label\+0x154> 0084 0000 	addiu	a0,a0,0
			154: R_MICROMIPS_LO12	\.bss\+0x1a5a5
0+0158 <text_label\+0x158> 4080 0000 	addiu	a0,gp,0
			158: R_MICROMIPS_GPREL19_S2	\.sbss\+0x1a5a5
0+015c <text_label\+0x15c> e080 0000 	lui	a0,0x0
			15c: R_MICROMIPS_HI20	\.data
0+0160 <text_label\+0x160> 0084 0000 	addiu	a0,a0,0
			160: R_MICROMIPS_LO12	\.data
0+0164 <text_label\+0x164> 20a4 2150 	addu	a0,a0,a1
0+0168 <text_label\+0x168> e080 0000 	lui	a0,0x0
			168: R_MICROMIPS_HI20	big_external_data_label
0+016c <text_label\+0x16c> 0084 0000 	addiu	a0,a0,0
			16c: R_MICROMIPS_LO12	big_external_data_label
0+0170 <text_label\+0x170> 20a4 2150 	addu	a0,a0,a1
0+0174 <text_label\+0x174> 4080 0000 	addiu	a0,gp,0
			174: R_MICROMIPS_GPREL19_S2	small_external_data_label
0+0178 <text_label\+0x178> 20a4 2150 	addu	a0,a0,a1
0+017c <text_label\+0x17c> e080 0000 	lui	a0,0x0
			17c: R_MICROMIPS_HI20	big_external_common
0+0180 <text_label\+0x180> 0084 0000 	addiu	a0,a0,0
			180: R_MICROMIPS_LO12	big_external_common
0+0184 <text_label\+0x184> 20a4 2150 	addu	a0,a0,a1
0+0188 <text_label\+0x188> 4080 0000 	addiu	a0,gp,0
			188: R_MICROMIPS_GPREL19_S2	small_external_common
0+018c <text_label\+0x18c> 20a4 2150 	addu	a0,a0,a1
0+0190 <text_label\+0x190> e080 0000 	lui	a0,0x0
			190: R_MICROMIPS_HI20	\.bss
0+0194 <text_label\+0x194> 0084 0000 	addiu	a0,a0,0
			194: R_MICROMIPS_LO12	\.bss
0+0198 <text_label\+0x198> 20a4 2150 	addu	a0,a0,a1
0+019c <text_label\+0x19c> 4080 0000 	addiu	a0,gp,0
			19c: R_MICROMIPS_GPREL19_S2	\.sbss
0+01a0 <text_label\+0x1a0> 20a4 2150 	addu	a0,a0,a1
0+01a4 <text_label\+0x1a4> e080 0000 	lui	a0,0x0
			1a4: R_MICROMIPS_HI20	\.data\+0x1
0+01a8 <text_label\+0x1a8> 0084 0000 	addiu	a0,a0,0
			1a8: R_MICROMIPS_LO12	\.data\+0x1
0+01ac <text_label\+0x1ac> 20a4 2150 	addu	a0,a0,a1
0+01b0 <text_label\+0x1b0> e080 0000 	lui	a0,0x0
			1b0: R_MICROMIPS_HI20	big_external_data_label\+0x1
0+01b4 <text_label\+0x1b4> 0084 0000 	addiu	a0,a0,0
			1b4: R_MICROMIPS_LO12	big_external_data_label\+0x1
0+01b8 <text_label\+0x1b8> 20a4 2150 	addu	a0,a0,a1
0+01bc <text_label\+0x1bc> 4080 0000 	addiu	a0,gp,0
			1bc: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x1
0+01c0 <text_label\+0x1c0> 20a4 2150 	addu	a0,a0,a1
0+01c4 <text_label\+0x1c4> e080 0000 	lui	a0,0x0
			1c4: R_MICROMIPS_HI20	big_external_common\+0x1
0+01c8 <text_label\+0x1c8> 0084 0000 	addiu	a0,a0,0
			1c8: R_MICROMIPS_LO12	big_external_common\+0x1
0+01cc <text_label\+0x1cc> 20a4 2150 	addu	a0,a0,a1
0+01d0 <text_label\+0x1d0> 4080 0000 	addiu	a0,gp,0
			1d0: R_MICROMIPS_GPREL19_S2	small_external_common\+0x1
0+01d4 <text_label\+0x1d4> 20a4 2150 	addu	a0,a0,a1
0+01d8 <text_label\+0x1d8> e080 0000 	lui	a0,0x0
			1d8: R_MICROMIPS_HI20	\.bss\+0x1
0+01dc <text_label\+0x1dc> 0084 0000 	addiu	a0,a0,0
			1dc: R_MICROMIPS_LO12	\.bss\+0x1
0+01e0 <text_label\+0x1e0> 20a4 2150 	addu	a0,a0,a1
0+01e4 <text_label\+0x1e4> 4080 0000 	addiu	a0,gp,0
			1e4: R_MICROMIPS_GPREL19_S2	\.sbss\+0x1
0+01e8 <text_label\+0x1e8> 20a4 2150 	addu	a0,a0,a1
0+01ec <text_label\+0x1ec> e080 0000 	lui	a0,0x0
			1ec: R_MICROMIPS_HI20	\.data\+0x8000
0+01f0 <text_label\+0x1f0> 0084 0000 	addiu	a0,a0,0
			1f0: R_MICROMIPS_LO12	\.data\+0x8000
0+01f4 <text_label\+0x1f4> 20a4 2150 	addu	a0,a0,a1
0+01f8 <text_label\+0x1f8> e080 0000 	lui	a0,0x0
			1f8: R_MICROMIPS_HI20	big_external_data_label\+0x8000
0+01fc <text_label\+0x1fc> 0084 0000 	addiu	a0,a0,0
			1fc: R_MICROMIPS_LO12	big_external_data_label\+0x8000
0+0200 <text_label\+0x200> 20a4 2150 	addu	a0,a0,a1
0+0204 <text_label\+0x204> 4080 0000 	addiu	a0,gp,0
			204: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x8000
0+0208 <text_label\+0x208> 20a4 2150 	addu	a0,a0,a1
0+020c <text_label\+0x20c> e080 0000 	lui	a0,0x0
			20c: R_MICROMIPS_HI20	big_external_common\+0x8000
0+0210 <text_label\+0x210> 0084 0000 	addiu	a0,a0,0
			210: R_MICROMIPS_LO12	big_external_common\+0x8000
0+0214 <text_label\+0x214> 20a4 2150 	addu	a0,a0,a1
0+0218 <text_label\+0x218> 4080 0000 	addiu	a0,gp,0
			218: R_MICROMIPS_GPREL19_S2	small_external_common\+0x8000
0+021c <text_label\+0x21c> 20a4 2150 	addu	a0,a0,a1
0+0220 <text_label\+0x220> e080 0000 	lui	a0,0x0
			220: R_MICROMIPS_HI20	\.bss\+0x8000
0+0224 <text_label\+0x224> 0084 0000 	addiu	a0,a0,0
			224: R_MICROMIPS_LO12	\.bss\+0x8000
0+0228 <text_label\+0x228> 20a4 2150 	addu	a0,a0,a1
0+022c <text_label\+0x22c> 4080 0000 	addiu	a0,gp,0
			22c: R_MICROMIPS_GPREL19_S2	\.sbss\+0x8000
0+0230 <text_label\+0x230> 20a4 2150 	addu	a0,a0,a1
0+0234 <text_label\+0x234> e080 0000 	lui	a0,0x0
			234: R_MICROMIPS_HI20	\.data-0x8000
0+0238 <text_label\+0x238> 0084 0000 	addiu	a0,a0,0
			238: R_MICROMIPS_LO12	\.data-0x8000
0+023c <text_label\+0x23c> 20a4 2150 	addu	a0,a0,a1
0+0240 <text_label\+0x240> e080 0000 	lui	a0,0x0
			240: R_MICROMIPS_HI20	big_external_data_label-0x8000
0+0244 <text_label\+0x244> 0084 0000 	addiu	a0,a0,0
			244: R_MICROMIPS_LO12	big_external_data_label-0x8000
0+0248 <text_label\+0x248> 20a4 2150 	addu	a0,a0,a1
0+024c <text_label\+0x24c> e080 0000 	lui	a0,0x0
			24c: R_MICROMIPS_HI20	small_external_data_label-0x8000
0+0250 <text_label\+0x250> 0084 0000 	addiu	a0,a0,0
			250: R_MICROMIPS_LO12	small_external_data_label-0x8000
0+0254 <text_label\+0x254> 20a4 2150 	addu	a0,a0,a1
0+0258 <text_label\+0x258> e080 0000 	lui	a0,0x0
			258: R_MICROMIPS_HI20	big_external_common-0x8000
0+025c <text_label\+0x25c> 0084 0000 	addiu	a0,a0,0
			25c: R_MICROMIPS_LO12	big_external_common-0x8000
0+0260 <text_label\+0x260> 20a4 2150 	addu	a0,a0,a1
0+0264 <text_label\+0x264> e080 0000 	lui	a0,0x0
			264: R_MICROMIPS_HI20	small_external_common-0x8000
0+0268 <text_label\+0x268> 0084 0000 	addiu	a0,a0,0
			268: R_MICROMIPS_LO12	small_external_common-0x8000
0+026c <text_label\+0x26c> 20a4 2150 	addu	a0,a0,a1
0+0270 <text_label\+0x270> e080 0000 	lui	a0,0x0
			270: R_MICROMIPS_HI20	\.bss-0x8000
0+0274 <text_label\+0x274> 0084 0000 	addiu	a0,a0,0
			274: R_MICROMIPS_LO12	\.bss-0x8000
0+0278 <text_label\+0x278> 20a4 2150 	addu	a0,a0,a1
0+027c <text_label\+0x27c> e080 0000 	lui	a0,0x0
			27c: R_MICROMIPS_HI20	\.sbss-0x8000
0+0280 <text_label\+0x280> 0084 0000 	addiu	a0,a0,0
			280: R_MICROMIPS_LO12	\.sbss-0x8000
0+0284 <text_label\+0x284> 20a4 2150 	addu	a0,a0,a1
0+0288 <text_label\+0x288> e080 0000 	lui	a0,0x0
			288: R_MICROMIPS_HI20	\.data\+0x10000
0+028c <text_label\+0x28c> 0084 0000 	addiu	a0,a0,0
			28c: R_MICROMIPS_LO12	\.data\+0x10000
0+0290 <text_label\+0x290> 20a4 2150 	addu	a0,a0,a1
0+0294 <text_label\+0x294> e080 0000 	lui	a0,0x0
			294: R_MICROMIPS_HI20	big_external_data_label\+0x10000
0+0298 <text_label\+0x298> 0084 0000 	addiu	a0,a0,0
			298: R_MICROMIPS_LO12	big_external_data_label\+0x10000
0+029c <text_label\+0x29c> 20a4 2150 	addu	a0,a0,a1
0+02a0 <text_label\+0x2a0> 4080 0000 	addiu	a0,gp,0
			2a0: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x10000
0+02a4 <text_label\+0x2a4> 20a4 2150 	addu	a0,a0,a1
0+02a8 <text_label\+0x2a8> e080 0000 	lui	a0,0x0
			2a8: R_MICROMIPS_HI20	big_external_common\+0x10000
0+02ac <text_label\+0x2ac> 0084 0000 	addiu	a0,a0,0
			2ac: R_MICROMIPS_LO12	big_external_common\+0x10000
0+02b0 <text_label\+0x2b0> 20a4 2150 	addu	a0,a0,a1
0+02b4 <text_label\+0x2b4> 4080 0000 	addiu	a0,gp,0
			2b4: R_MICROMIPS_GPREL19_S2	small_external_common\+0x10000
0+02b8 <text_label\+0x2b8> 20a4 2150 	addu	a0,a0,a1
0+02bc <text_label\+0x2bc> e080 0000 	lui	a0,0x0
			2bc: R_MICROMIPS_HI20	\.bss\+0x10000
0+02c0 <text_label\+0x2c0> 0084 0000 	addiu	a0,a0,0
			2c0: R_MICROMIPS_LO12	\.bss\+0x10000
0+02c4 <text_label\+0x2c4> 20a4 2150 	addu	a0,a0,a1
0+02c8 <text_label\+0x2c8> 4080 0000 	addiu	a0,gp,0
			2c8: R_MICROMIPS_GPREL19_S2	\.sbss\+0x10000
0+02cc <text_label\+0x2cc> 20a4 2150 	addu	a0,a0,a1
0+02d0 <text_label\+0x2d0> e080 0000 	lui	a0,0x0
			2d0: R_MICROMIPS_HI20	\.data\+0x1a5a5
0+02d4 <text_label\+0x2d4> 0084 0000 	addiu	a0,a0,0
			2d4: R_MICROMIPS_LO12	\.data\+0x1a5a5
0+02d8 <text_label\+0x2d8> 20a4 2150 	addu	a0,a0,a1
0+02dc <text_label\+0x2dc> e080 0000 	lui	a0,0x0
			2dc: R_MICROMIPS_HI20	big_external_data_label\+0x1a5a5
0+02e0 <text_label\+0x2e0> 0084 0000 	addiu	a0,a0,0
			2e0: R_MICROMIPS_LO12	big_external_data_label\+0x1a5a5
0+02e4 <text_label\+0x2e4> 20a4 2150 	addu	a0,a0,a1
0+02e8 <text_label\+0x2e8> 4080 0000 	addiu	a0,gp,0
			2e8: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x1a5a5
0+02ec <text_label\+0x2ec> 20a4 2150 	addu	a0,a0,a1
0+02f0 <text_label\+0x2f0> e080 0000 	lui	a0,0x0
			2f0: R_MICROMIPS_HI20	big_external_common\+0x1a5a5
0+02f4 <text_label\+0x2f4> 0084 0000 	addiu	a0,a0,0
			2f4: R_MICROMIPS_LO12	big_external_common\+0x1a5a5
0+02f8 <text_label\+0x2f8> 20a4 2150 	addu	a0,a0,a1
0+02fc <text_label\+0x2fc> 4080 0000 	addiu	a0,gp,0
			2fc: R_MICROMIPS_GPREL19_S2	small_external_common\+0x1a5a5
0+0300 <text_label\+0x300> 20a4 2150 	addu	a0,a0,a1
0+0304 <text_label\+0x304> e080 0000 	lui	a0,0x0
			304: R_MICROMIPS_HI20	\.bss\+0x1a5a5
0+0308 <text_label\+0x308> 0084 0000 	addiu	a0,a0,0
			308: R_MICROMIPS_LO12	\.bss\+0x1a5a5
0+030c <text_label\+0x30c> 20a4 2150 	addu	a0,a0,a1
0+0310 <text_label\+0x310> 4080 0000 	addiu	a0,gp,0
			310: R_MICROMIPS_GPREL19_S2	\.sbss\+0x1a5a5
0+0314 <text_label\+0x314> 20a4 2150 	addu	a0,a0,a1
0+0318 <text_label\+0x318> 0085 0000 	addiu	a0,a1,0
0+031c <text_label\+0x31c> e092 3000 	lui	a0,0x123
0+0320 <text_label\+0x320> 8084 0456 	ori	a0,a0,1110
0+0324 <text_label\+0x324> e092 3000 	lui	a0,0x123
0+0328 <text_label\+0x328> 8084 0456 	ori	a0,a0,1110
0+032c <text_label\+0x32c> 20a4 2150 	addu	a0,a0,a1
0+0330 <text_label\+0x330> e080 0000 	lui	a0,0x0
			330: R_MICROMIPS_HI20	big_external_data_label
0+0334 <text_label\+0x334> 0084 0000 	addiu	a0,a0,0
			334: R_MICROMIPS_LO12	big_external_data_label
0+0338 <text_label\+0x338> e080 0000 	lui	a0,0x0
			338: R_MICROMIPS_HI20	big_external_data_label
0+033c <text_label\+0x33c> 0084 0000 	addiu	a0,a0,0
			33c: R_MICROMIPS_LO12	big_external_data_label
0+0340 <text_label\+0x340> 20a4 2150 	addu	a0,a0,a1
	\.\.\.
