#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS la-svr4pic
#as: -32 -mips32r7 -mmicromips -KPIC --defsym KPIC=1
#source: la.s

# Test the la macro with -KPIC.

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> 0080 0000 	li	a0,0
0+0004 <text_label\+0x4> 0080 0001 	li	a0,1
0+0008 <text_label\+0x8> e080 8000 	lui	a0,0x8
0+000c <text_label\+0xc> e09f 8ffd 	lui	a0,0xffff8
0+0010 <text_label\+0x10> e081 0000 	lui	a0,0x10
0+0014 <text_label\+0x14> e081 a000 	lui	a0,0x1a
0+0018 <text_label\+0x18> 8084 05a5 	ori	a0,a0,1445
0+001c <text_label\+0x1c> 0085 0000 	addiu	a0,a1,0
0+0020 <text_label\+0x20> 0085 0001 	addiu	a0,a1,1
0+0024 <text_label\+0x24> e080 8000 	lui	a0,0x8
0+0028 <text_label\+0x28> 20a4 2150 	addu	a0,a0,a1
0+002c <text_label\+0x2c> e09f 8ffd 	lui	a0,0xffff8
0+0030 <text_label\+0x30> 20a4 2150 	addu	a0,a0,a1
0+0034 <text_label\+0x34> e081 0000 	lui	a0,0x10
0+0038 <text_label\+0x38> 20a4 2150 	addu	a0,a0,a1
0+003c <text_label\+0x3c> e081 a000 	lui	a0,0x1a
0+0040 <text_label\+0x40> 8084 05a5 	ori	a0,a0,1445
0+0044 <text_label\+0x44> 20a4 2150 	addu	a0,a0,a1
0+0048 <text_label\+0x48> 849c 8000 	lw	a0,0\(gp\)
			48: R_MICROMIPS_GOT_DISP	.data
0+004c <text_label\+0x4c> 849c 8000 	lw	a0,0\(gp\)
			4c: R_MICROMIPS_GOT_DISP	big_external_data_label
0+0050 <text_label\+0x50> 849c 8000 	lw	a0,0\(gp\)
			50: R_MICROMIPS_GOT_DISP	small_external_data_label
0+0054 <text_label\+0x54> 849c 8000 	lw	a0,0\(gp\)
			54: R_MICROMIPS_GOT_DISP	big_external_common
0+0058 <text_label\+0x58> 849c 8000 	lw	a0,0\(gp\)
			58: R_MICROMIPS_GOT_DISP	small_external_common
0+005c <text_label\+0x5c> 849c 8000 	lw	a0,0\(gp\)
			5c: R_MICROMIPS_GOT_DISP	\.bss
0+0060 <text_label\+0x60> 849c 8000 	lw	a0,0\(gp\)
			60: R_MICROMIPS_GOT_DISP	\.bss\+0x3e8
0+0064 <text_label\+0x64> 849c 8000 	lw	a0,0\(gp\)
			64: R_MICROMIPS_GOT_DISP	.data\+0x1
0+0068 <text_label\+0x68> 849c 8000 	lw	a0,0\(gp\)
			68: R_MICROMIPS_GOT_DISP	big_external_data_label
0+006c <text_label\+0x6c> 0084 0001 	addiu	a0,a0,1
0+0070 <text_label\+0x70> 849c 8000 	lw	a0,0\(gp\)
			70: R_MICROMIPS_GOT_DISP	small_external_data_label
0+0074 <text_label\+0x74> 0084 0001 	addiu	a0,a0,1
0+0078 <text_label\+0x78> 849c 8000 	lw	a0,0\(gp\)
			78: R_MICROMIPS_GOT_DISP	big_external_common
0+007c <text_label\+0x7c> 0084 0001 	addiu	a0,a0,1
0+0080 <text_label\+0x80> 849c 8000 	lw	a0,0\(gp\)
			80: R_MICROMIPS_GOT_DISP	small_external_common
0+0084 <text_label\+0x84> 0084 0001 	addiu	a0,a0,1
0+0088 <text_label\+0x88> 849c 8000 	lw	a0,0\(gp\)
			88: R_MICROMIPS_GOT_DISP	\.bss\+0x1
0+008c <text_label\+0x8c> 849c 8000 	lw	a0,0\(gp\)
			8c: R_MICROMIPS_GOT_DISP	\.bss\+0x3e9
0+0090 <text_label\+0x90> 849c 8000 	lw	a0,0\(gp\)
			90: R_MICROMIPS_GOT_DISP	.data\+0x8000
0+0094 <text_label\+0x94> 849c 8000 	lw	a0,0\(gp\)
			94: R_MICROMIPS_GOT_DISP	big_external_data_label
0+0098 <text_label\+0x98> e020 8000 	lui	at,0x8
0+009c <text_label\+0x9c> 2024 2150 	addu	a0,a0,at
0+00a0 <text_label\+0xa0> 849c 8000 	lw	a0,0\(gp\)
			a0: R_MICROMIPS_GOT_DISP	small_external_data_label
0+00a4 <text_label\+0xa4> e020 8000 	lui	at,0x8
0+00a8 <text_label\+0xa8> 2024 2150 	addu	a0,a0,at
0+00ac <text_label\+0xac> 849c 8000 	lw	a0,0\(gp\)
			ac: R_MICROMIPS_GOT_DISP	big_external_common
0+00b0 <text_label\+0xb0> e020 8000 	lui	at,0x8
0+00b4 <text_label\+0xb4> 2024 2150 	addu	a0,a0,at
0+00b8 <text_label\+0xb8> 849c 8000 	lw	a0,0\(gp\)
			b8: R_MICROMIPS_GOT_DISP	small_external_common
0+00bc <text_label\+0xbc> e020 8000 	lui	at,0x8
0+00c0 <text_label\+0xc0> 2024 2150 	addu	a0,a0,at
0+00c4 <text_label\+0xc4> 849c 8000 	lw	a0,0\(gp\)
			c4: R_MICROMIPS_GOT_DISP	\.bss\+0x8000
0+00c8 <text_label\+0xc8> 849c 8000 	lw	a0,0\(gp\)
			c8: R_MICROMIPS_GOT_DISP	\.bss\+0x83e8
0+00cc <text_label\+0xcc> 849c 8000 	lw	a0,0\(gp\)
			cc: R_MICROMIPS_GOT_DISP	.data-0x8000
0+00d0 <text_label\+0xd0> 849c 8000 	lw	a0,0\(gp\)
			d0: R_MICROMIPS_GOT_DISP	big_external_data_label
0+00d4 <text_label\+0xd4> e03f 8ffd 	lui	at,0xffff8
0+00d8 <text_label\+0xd8> 2024 2150 	addu	a0,a0,at
0+00dc <text_label\+0xdc> 849c 8000 	lw	a0,0\(gp\)
			dc: R_MICROMIPS_GOT_DISP	small_external_data_label
0+00e0 <text_label\+0xe0> e03f 8ffd 	lui	at,0xffff8
0+00e4 <text_label\+0xe4> 2024 2150 	addu	a0,a0,at
0+00e8 <text_label\+0xe8> 849c 8000 	lw	a0,0\(gp\)
			e8: R_MICROMIPS_GOT_DISP	big_external_common
0+00ec <text_label\+0xec> e03f 8ffd 	lui	at,0xffff8
0+00f0 <text_label\+0xf0> 2024 2150 	addu	a0,a0,at
0+00f4 <text_label\+0xf4> 849c 8000 	lw	a0,0\(gp\)
			f4: R_MICROMIPS_GOT_DISP	small_external_common
0+00f8 <text_label\+0xf8> e03f 8ffd 	lui	at,0xffff8
0+00fc <text_label\+0xfc> 2024 2150 	addu	a0,a0,at
0+0100 <text_label\+0x100> 849c 8000 	lw	a0,0\(gp\)
			100: R_MICROMIPS_GOT_DISP	\.bss-0x8000
0+0104 <text_label\+0x104> 849c 8000 	lw	a0,0\(gp\)
			104: R_MICROMIPS_GOT_DISP	\.bss-0x7c18
0+0108 <text_label\+0x108> 849c 8000 	lw	a0,0\(gp\)
			108: R_MICROMIPS_GOT_DISP	.data\+0x10000
0+010c <text_label\+0x10c> 849c 8000 	lw	a0,0\(gp\)
			10c: R_MICROMIPS_GOT_DISP	big_external_data_label
0+0110 <text_label\+0x110> e021 0000 	lui	at,0x10
0+0114 <text_label\+0x114> 2024 2150 	addu	a0,a0,at
0+0118 <text_label\+0x118> 849c 8000 	lw	a0,0\(gp\)
			118: R_MICROMIPS_GOT_DISP	small_external_data_label
0+011c <text_label\+0x11c> e021 0000 	lui	at,0x10
0+0120 <text_label\+0x120> 2024 2150 	addu	a0,a0,at
0+0124 <text_label\+0x124> 849c 8000 	lw	a0,0\(gp\)
			124: R_MICROMIPS_GOT_DISP	big_external_common
0+0128 <text_label\+0x128> e021 0000 	lui	at,0x10
0+012c <text_label\+0x12c> 2024 2150 	addu	a0,a0,at
0+0130 <text_label\+0x130> 849c 8000 	lw	a0,0\(gp\)
			130: R_MICROMIPS_GOT_DISP	small_external_common
0+0134 <text_label\+0x134> e021 0000 	lui	at,0x10
0+0138 <text_label\+0x138> 2024 2150 	addu	a0,a0,at
0+013c <text_label\+0x13c> 849c 8000 	lw	a0,0\(gp\)
			13c: R_MICROMIPS_GOT_DISP	\.bss\+0x10000
0+0140 <text_label\+0x140> 849c 8000 	lw	a0,0\(gp\)
			140: R_MICROMIPS_GOT_DISP	\.bss\+0x103e8
0+0144 <text_label\+0x144> 849c 8000 	lw	a0,0\(gp\)
			144: R_MICROMIPS_GOT_DISP	.data\+0x1a5a5
0+0148 <text_label\+0x148> 849c 8000 	lw	a0,0\(gp\)
			148: R_MICROMIPS_GOT_DISP	big_external_data_label
0+014c <text_label\+0x14c> e021 a000 	lui	at,0x1a
0+0150 <text_label\+0x150> 8021 05a5 	ori	at,at,1445
0+0154 <text_label\+0x154> 2024 2150 	addu	a0,a0,at
0+0158 <text_label\+0x158> 849c 8000 	lw	a0,0\(gp\)
			158: R_MICROMIPS_GOT_DISP	small_external_data_label
0+015c <text_label\+0x15c> e021 a000 	lui	at,0x1a
0+0160 <text_label\+0x160> 8021 05a5 	ori	at,at,1445
0+0164 <text_label\+0x164> 2024 2150 	addu	a0,a0,at
0+0168 <text_label\+0x168> 849c 8000 	lw	a0,0\(gp\)
			168: R_MICROMIPS_GOT_DISP	big_external_common
0+016c <text_label\+0x16c> e021 a000 	lui	at,0x1a
0+0170 <text_label\+0x170> 8021 05a5 	ori	at,at,1445
0+0174 <text_label\+0x174> 2024 2150 	addu	a0,a0,at
0+0178 <text_label\+0x178> 849c 8000 	lw	a0,0\(gp\)
			178: R_MICROMIPS_GOT_DISP	small_external_common
0+017c <text_label\+0x17c> e021 a000 	lui	at,0x1a
0+0180 <text_label\+0x180> 8021 05a5 	ori	at,at,1445
0+0184 <text_label\+0x184> 2024 2150 	addu	a0,a0,at
0+0188 <text_label\+0x188> 849c 8000 	lw	a0,0\(gp\)
			188: R_MICROMIPS_GOT_DISP	\.bss\+0x1a5a5
0+018c <text_label\+0x18c> 849c 8000 	lw	a0,0\(gp\)
			18c: R_MICROMIPS_GOT_DISP	\.bss\+0x1a98d
0+0190 <text_label\+0x190> 849c 8000 	lw	a0,0\(gp\)
			190: R_MICROMIPS_GOT_DISP	.data
0+0194 <text_label\+0x194> 20a4 2150 	addu	a0,a0,a1
0+0198 <text_label\+0x198> 849c 8000 	lw	a0,0\(gp\)
			198: R_MICROMIPS_GOT_DISP	big_external_data_label
0+019c <text_label\+0x19c> 20a4 2150 	addu	a0,a0,a1
0+01a0 <text_label\+0x1a0> 849c 8000 	lw	a0,0\(gp\)
			1a0: R_MICROMIPS_GOT_DISP	small_external_data_label
0+01a4 <text_label\+0x1a4> 20a4 2150 	addu	a0,a0,a1
0+01a8 <text_label\+0x1a8> 849c 8000 	lw	a0,0\(gp\)
			1a8: R_MICROMIPS_GOT_DISP	big_external_common
0+01ac <text_label\+0x1ac> 20a4 2150 	addu	a0,a0,a1
0+01b0 <text_label\+0x1b0> 849c 8000 	lw	a0,0\(gp\)
			1b0: R_MICROMIPS_GOT_DISP	small_external_common
0+01b4 <text_label\+0x1b4> 20a4 2150 	addu	a0,a0,a1
0+01b8 <text_label\+0x1b8> 849c 8000 	lw	a0,0\(gp\)
			1b8: R_MICROMIPS_GOT_DISP	\.bss
0+01bc <text_label\+0x1bc> 20a4 2150 	addu	a0,a0,a1
0+01c0 <text_label\+0x1c0> 849c 8000 	lw	a0,0\(gp\)
			1c0: R_MICROMIPS_GOT_DISP	\.bss\+0x3e8
0+01c4 <text_label\+0x1c4> 20a4 2150 	addu	a0,a0,a1
0+01c8 <text_label\+0x1c8> 849c 8000 	lw	a0,0\(gp\)
			1c8: R_MICROMIPS_GOT_DISP	.data\+0x1
0+01cc <text_label\+0x1cc> 20a4 2150 	addu	a0,a0,a1
0+01d0 <text_label\+0x1d0> 849c 8000 	lw	a0,0\(gp\)
			1d0: R_MICROMIPS_GOT_DISP	big_external_data_label
0+01d4 <text_label\+0x1d4> 0084 0001 	addiu	a0,a0,1
0+01d8 <text_label\+0x1d8> 20a4 2150 	addu	a0,a0,a1
0+01dc <text_label\+0x1dc> 849c 8000 	lw	a0,0\(gp\)
			1dc: R_MICROMIPS_GOT_DISP	small_external_data_label
0+01e0 <text_label\+0x1e0> 0084 0001 	addiu	a0,a0,1
0+01e4 <text_label\+0x1e4> 20a4 2150 	addu	a0,a0,a1
0+01e8 <text_label\+0x1e8> 849c 8000 	lw	a0,0\(gp\)
			1e8: R_MICROMIPS_GOT_DISP	big_external_common
0+01ec <text_label\+0x1ec> 0084 0001 	addiu	a0,a0,1
0+01f0 <text_label\+0x1f0> 20a4 2150 	addu	a0,a0,a1
0+01f4 <text_label\+0x1f4> 849c 8000 	lw	a0,0\(gp\)
			1f4: R_MICROMIPS_GOT_DISP	small_external_common
0+01f8 <text_label\+0x1f8> 0084 0001 	addiu	a0,a0,1
0+01fc <text_label\+0x1fc> 20a4 2150 	addu	a0,a0,a1
0+0200 <text_label\+0x200> 849c 8000 	lw	a0,0\(gp\)
			200: R_MICROMIPS_GOT_DISP	\.bss\+0x1
0+0204 <text_label\+0x204> 20a4 2150 	addu	a0,a0,a1
0+0208 <text_label\+0x208> 849c 8000 	lw	a0,0\(gp\)
			208: R_MICROMIPS_GOT_DISP	\.bss\+0x3e9
0+020c <text_label\+0x20c> 20a4 2150 	addu	a0,a0,a1
0+0210 <text_label\+0x210> 849c 8000 	lw	a0,0\(gp\)
			210: R_MICROMIPS_GOT_DISP	.data\+0x8000
0+0214 <text_label\+0x214> 20a4 2150 	addu	a0,a0,a1
0+0218 <text_label\+0x218> 849c 8000 	lw	a0,0\(gp\)
			218: R_MICROMIPS_GOT_DISP	big_external_data_label
0+021c <text_label\+0x21c> e020 8000 	lui	at,0x8
0+0220 <text_label\+0x220> 2024 2150 	addu	a0,a0,at
0+0224 <text_label\+0x224> 20a4 2150 	addu	a0,a0,a1
0+0228 <text_label\+0x228> 849c 8000 	lw	a0,0\(gp\)
			228: R_MICROMIPS_GOT_DISP	small_external_data_label
0+022c <text_label\+0x22c> e020 8000 	lui	at,0x8
0+0230 <text_label\+0x230> 2024 2150 	addu	a0,a0,at
0+0234 <text_label\+0x234> 20a4 2150 	addu	a0,a0,a1
0+0238 <text_label\+0x238> 849c 8000 	lw	a0,0\(gp\)
			238: R_MICROMIPS_GOT_DISP	big_external_common
0+023c <text_label\+0x23c> e020 8000 	lui	at,0x8
0+0240 <text_label\+0x240> 2024 2150 	addu	a0,a0,at
0+0244 <text_label\+0x244> 20a4 2150 	addu	a0,a0,a1
0+0248 <text_label\+0x248> 849c 8000 	lw	a0,0\(gp\)
			248: R_MICROMIPS_GOT_DISP	small_external_common
0+024c <text_label\+0x24c> e020 8000 	lui	at,0x8
0+0250 <text_label\+0x250> 2024 2150 	addu	a0,a0,at
0+0254 <text_label\+0x254> 20a4 2150 	addu	a0,a0,a1
0+0258 <text_label\+0x258> 849c 8000 	lw	a0,0\(gp\)
			258: R_MICROMIPS_GOT_DISP	\.bss\+0x8000
0+025c <text_label\+0x25c> 20a4 2150 	addu	a0,a0,a1
0+0260 <text_label\+0x260> 849c 8000 	lw	a0,0\(gp\)
			260: R_MICROMIPS_GOT_DISP	\.bss\+0x83e8
0+0264 <text_label\+0x264> 20a4 2150 	addu	a0,a0,a1
0+0268 <text_label\+0x268> 849c 8000 	lw	a0,0\(gp\)
			268: R_MICROMIPS_GOT_DISP	.data-0x8000
0+026c <text_label\+0x26c> 20a4 2150 	addu	a0,a0,a1
0+0270 <text_label\+0x270> 849c 8000 	lw	a0,0\(gp\)
			270: R_MICROMIPS_GOT_DISP	big_external_data_label
0+0274 <text_label\+0x274> e03f 8ffd 	lui	at,0xffff8
0+0278 <text_label\+0x278> 2024 2150 	addu	a0,a0,at
0+027c <text_label\+0x27c> 20a4 2150 	addu	a0,a0,a1
0+0280 <text_label\+0x280> 849c 8000 	lw	a0,0\(gp\)
			280: R_MICROMIPS_GOT_DISP	small_external_data_label
0+0284 <text_label\+0x284> e03f 8ffd 	lui	at,0xffff8
0+0288 <text_label\+0x288> 2024 2150 	addu	a0,a0,at
0+028c <text_label\+0x28c> 20a4 2150 	addu	a0,a0,a1
0+0290 <text_label\+0x290> 849c 8000 	lw	a0,0\(gp\)
			290: R_MICROMIPS_GOT_DISP	big_external_common
0+0294 <text_label\+0x294> e03f 8ffd 	lui	at,0xffff8
0+0298 <text_label\+0x298> 2024 2150 	addu	a0,a0,at
0+029c <text_label\+0x29c> 20a4 2150 	addu	a0,a0,a1
0+02a0 <text_label\+0x2a0> 849c 8000 	lw	a0,0\(gp\)
			2a0: R_MICROMIPS_GOT_DISP	small_external_common
0+02a4 <text_label\+0x2a4> e03f 8ffd 	lui	at,0xffff8
0+02a8 <text_label\+0x2a8> 2024 2150 	addu	a0,a0,at
0+02ac <text_label\+0x2ac> 20a4 2150 	addu	a0,a0,a1
0+02b0 <text_label\+0x2b0> 849c 8000 	lw	a0,0\(gp\)
			2b0: R_MICROMIPS_GOT_DISP	\.bss-0x8000
0+02b4 <text_label\+0x2b4> 20a4 2150 	addu	a0,a0,a1
0+02b8 <text_label\+0x2b8> 849c 8000 	lw	a0,0\(gp\)
			2b8: R_MICROMIPS_GOT_DISP	\.bss-0x7c18
0+02bc <text_label\+0x2bc> 20a4 2150 	addu	a0,a0,a1
0+02c0 <text_label\+0x2c0> 849c 8000 	lw	a0,0\(gp\)
			2c0: R_MICROMIPS_GOT_DISP	.data\+0x10000
0+02c4 <text_label\+0x2c4> 20a4 2150 	addu	a0,a0,a1
0+02c8 <text_label\+0x2c8> 849c 8000 	lw	a0,0\(gp\)
			2c8: R_MICROMIPS_GOT_DISP	big_external_data_label
0+02cc <text_label\+0x2cc> e021 0000 	lui	at,0x10
0+02d0 <text_label\+0x2d0> 2024 2150 	addu	a0,a0,at
0+02d4 <text_label\+0x2d4> 20a4 2150 	addu	a0,a0,a1
0+02d8 <text_label\+0x2d8> 849c 8000 	lw	a0,0\(gp\)
			2d8: R_MICROMIPS_GOT_DISP	small_external_data_label
0+02dc <text_label\+0x2dc> e021 0000 	lui	at,0x10
0+02e0 <text_label\+0x2e0> 2024 2150 	addu	a0,a0,at
0+02e4 <text_label\+0x2e4> 20a4 2150 	addu	a0,a0,a1
0+02e8 <text_label\+0x2e8> 849c 8000 	lw	a0,0\(gp\)
			2e8: R_MICROMIPS_GOT_DISP	big_external_common
0+02ec <text_label\+0x2ec> e021 0000 	lui	at,0x10
0+02f0 <text_label\+0x2f0> 2024 2150 	addu	a0,a0,at
0+02f4 <text_label\+0x2f4> 20a4 2150 	addu	a0,a0,a1
0+02f8 <text_label\+0x2f8> 849c 8000 	lw	a0,0\(gp\)
			2f8: R_MICROMIPS_GOT_DISP	small_external_common
0+02fc <text_label\+0x2fc> e021 0000 	lui	at,0x10
0+0300 <text_label\+0x300> 2024 2150 	addu	a0,a0,at
0+0304 <text_label\+0x304> 20a4 2150 	addu	a0,a0,a1
0+0308 <text_label\+0x308> 849c 8000 	lw	a0,0\(gp\)
			308: R_MICROMIPS_GOT_DISP	\.bss\+0x10000
0+030c <text_label\+0x30c> 20a4 2150 	addu	a0,a0,a1
0+0310 <text_label\+0x310> 849c 8000 	lw	a0,0\(gp\)
			310: R_MICROMIPS_GOT_DISP	\.bss\+0x103e8
0+0314 <text_label\+0x314> 20a4 2150 	addu	a0,a0,a1
0+0318 <text_label\+0x318> 849c 8000 	lw	a0,0\(gp\)
			318: R_MICROMIPS_GOT_DISP	.data\+0x1a5a5
0+031c <text_label\+0x31c> 20a4 2150 	addu	a0,a0,a1
0+0320 <text_label\+0x320> 849c 8000 	lw	a0,0\(gp\)
			320: R_MICROMIPS_GOT_DISP	big_external_data_label
0+0324 <text_label\+0x324> e021 a000 	lui	at,0x1a
0+0328 <text_label\+0x328> 8021 05a5 	ori	at,at,1445
0+032c <text_label\+0x32c> 2024 2150 	addu	a0,a0,at
0+0330 <text_label\+0x330> 20a4 2150 	addu	a0,a0,a1
0+0334 <text_label\+0x334> 849c 8000 	lw	a0,0\(gp\)
			334: R_MICROMIPS_GOT_DISP	small_external_data_label
0+0338 <text_label\+0x338> e021 a000 	lui	at,0x1a
0+033c <text_label\+0x33c> 8021 05a5 	ori	at,at,1445
0+0340 <text_label\+0x340> 2024 2150 	addu	a0,a0,at
0+0344 <text_label\+0x344> 20a4 2150 	addu	a0,a0,a1
0+0348 <text_label\+0x348> 849c 8000 	lw	a0,0\(gp\)
			348: R_MICROMIPS_GOT_DISP	big_external_common
0+034c <text_label\+0x34c> e021 a000 	lui	at,0x1a
0+0350 <text_label\+0x350> 8021 05a5 	ori	at,at,1445
0+0354 <text_label\+0x354> 2024 2150 	addu	a0,a0,at
0+0358 <text_label\+0x358> 20a4 2150 	addu	a0,a0,a1
0+035c <text_label\+0x35c> 849c 8000 	lw	a0,0\(gp\)
			35c: R_MICROMIPS_GOT_DISP	small_external_common
0+0360 <text_label\+0x360> e021 a000 	lui	at,0x1a
0+0364 <text_label\+0x364> 8021 05a5 	ori	at,at,1445
0+0368 <text_label\+0x368> 2024 2150 	addu	a0,a0,at
0+036c <text_label\+0x36c> 20a4 2150 	addu	a0,a0,a1
0+0370 <text_label\+0x370> 849c 8000 	lw	a0,0\(gp\)
			370: R_MICROMIPS_GOT_DISP	\.bss\+0x1a5a5
0+0374 <text_label\+0x374> 20a4 2150 	addu	a0,a0,a1
0+0378 <text_label\+0x378> 849c 8000 	lw	a0,0\(gp\)
			378: R_MICROMIPS_GOT_DISP	\.bss\+0x1a98d
0+037c <text_label\+0x37c> 20a4 2150 	addu	a0,a0,a1
0+0380 <text_label\+0x380> 0085 0000 	addiu	a0,a1,0
0+0384 <text_label\+0x384> e092 3000 	lui	a0,0x123
0+0388 <text_label\+0x388> 8084 0456 	ori	a0,a0,1110
0+038c <text_label\+0x38c> e092 3000 	lui	a0,0x123
0+0390 <text_label\+0x390> 8084 0456 	ori	a0,a0,1110
0+0394 <text_label\+0x394> 20a4 2150 	addu	a0,a0,a1
0+0398 <text_label\+0x398> 849c 8000 	lw	a0,0\(gp\)
			398: R_MICROMIPS_GOT_DISP	big_external_data_label
0+039c <text_label\+0x39c> 849c 8000 	lw	a0,0\(gp\)
			39c: R_MICROMIPS_GOT_DISP	big_external_data_label
0+03a0 <text_label\+0x3a0> 20a4 2150 	addu	a0,a0,a1
	\.\.\.
