#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS la using li[48]
#as:
#source: la.s

# Test the la macro.

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> 0080 0000 	li	a0,0
0+0004 <text_label\+0x4> 0080 0001 	li	a0,1
0+0008 <text_label\+0x8> e080 8000 	lui	a0,0x8
0+000c <text_label\+0xc> e09f 8ffd 	lui	a0,0xffff8
0+0010 <text_label\+0x10> e081 0000 	lui	a0,0x10
0+0014 <text_label\+0x14> 6080 0001 a5a5 	li	a0,0x1a5a5
0+001a <text_label\+0x1a> 0085 0000 	addiu	a0,a1,0
0+001e <text_label\+0x1e> 0085 0001 	addiu	a0,a1,1
0+0022 <text_label\+0x22> e080 8000 	lui	a0,0x8
0+0026 <text_label\+0x26> 20a4 2150 	addu	a0,a0,a1
0+002a <text_label\+0x2a> e09f 8ffd 	lui	a0,0xffff8
0+002e <text_label\+0x2e> 20a4 2150 	addu	a0,a0,a1
0+0032 <text_label\+0x32> e081 0000 	lui	a0,0x10
0+0036 <text_label\+0x36> 20a4 2150 	addu	a0,a0,a1
0+003a <text_label\+0x3a> 6080 0001 a5a5 	li	a0,0x1a5a5
0+0040 <text_label\+0x40> 20a4 2150 	addu	a0,a0,a1
0+0044 <text_label\+0x44> 6080 0000 0000 	li	a0,0x0
			46: R_NANOMIPS_32	\.data
0+004a <text_label\+0x4a> 6080 0000 0000 	li	a0,0x0
			4c: R_NANOMIPS_32	big_external_data_label
0+0050 <text_label\+0x50> 4080 0000 	addiu	a0,gp,0
			50: R_NANOMIPS_GPREL19_S2	small_external_data_label
0+0054 <text_label\+0x54> 6080 0000 0000 	li	a0,0x0
			56: R_NANOMIPS_32	big_external_common
0+005a <text_label\+0x5a> 4080 0000 	addiu	a0,gp,0
			5a: R_NANOMIPS_GPREL19_S2	small_external_common
0+005e <text_label\+0x5e> 6080 0000 0000 	li	a0,0x0
			60: R_NANOMIPS_32	\.bss
0+0064 <text_label\+0x64> 4080 0000 	addiu	a0,gp,0
			64: R_NANOMIPS_GPREL19_S2	\.sbss
0+0068 <text_label\+0x68> 6080 0000 0000 	li	a0,0x0
			6a: R_NANOMIPS_32	\.data\+0x1
0+006e <text_label\+0x6e> 6080 0000 0000 	li	a0,0x0
			70: R_NANOMIPS_32	big_external_data_label\+0x1
0+0074 <text_label\+0x74> 4080 0000 	addiu	a0,gp,0
			74: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1
0+0078 <text_label\+0x78> 6080 0000 0000 	li	a0,0x0
			7a: R_NANOMIPS_32	big_external_common\+0x1
0+007e <text_label\+0x7e> 4080 0000 	addiu	a0,gp,0
			7e: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1
0+0082 <text_label\+0x82> 6080 0000 0000 	li	a0,0x0
			84: R_NANOMIPS_32	\.bss\+0x1
0+0088 <text_label\+0x88> 4080 0000 	addiu	a0,gp,0
			88: R_NANOMIPS_GPREL19_S2	\.sbss\+0x1
0+008c <text_label\+0x8c> 6080 0000 0000 	li	a0,0x0
			8e: R_NANOMIPS_32	\.data\+0x8000
0+0092 <text_label\+0x92> 6080 0000 0000 	li	a0,0x0
			94: R_NANOMIPS_32	big_external_data_label\+0x8000
0+0098 <text_label\+0x98> 4080 0000 	addiu	a0,gp,0
			98: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x8000
0+009c <text_label\+0x9c> 6080 0000 0000 	li	a0,0x0
			9e: R_NANOMIPS_32	big_external_common\+0x8000
0+00a2 <text_label\+0xa2> 4080 0000 	addiu	a0,gp,0
			a2: R_NANOMIPS_GPREL19_S2	small_external_common\+0x8000
0+00a6 <text_label\+0xa6> 6080 0000 0000 	li	a0,0x0
			a8: R_NANOMIPS_32	\.bss\+0x8000
0+00ac <text_label\+0xac> 4080 0000 	addiu	a0,gp,0
			ac: R_NANOMIPS_GPREL19_S2	\.sbss\+0x8000
0+00b0 <text_label\+0xb0> 6080 0000 0000 	li	a0,0x0
			b2: R_NANOMIPS_32	\.data-0x8000
0+00b6 <text_label\+0xb6> 6080 0000 0000 	li	a0,0x0
			b8: R_NANOMIPS_32	big_external_data_label-0x8000
0+00bc <text_label\+0xbc> 6080 0000 0000 	li	a0,0x0
			be: R_NANOMIPS_32	small_external_data_label-0x8000
0+00c2 <text_label\+0xc2> 6080 0000 0000 	li	a0,0x0
			c4: R_NANOMIPS_32	big_external_common-0x8000
0+00c8 <text_label\+0xc8> 6080 0000 0000 	li	a0,0x0
			ca: R_NANOMIPS_32	small_external_common-0x8000
0+00ce <text_label\+0xce> 6080 0000 0000 	li	a0,0x0
			d0: R_NANOMIPS_32	\.bss-0x8000
0+00d4 <text_label\+0xd4> 6080 0000 0000 	li	a0,0x0
			d6: R_NANOMIPS_32	\.sbss-0x8000
0+00da <text_label\+0xda> 6080 0000 0000 	li	a0,0x0
			dc: R_NANOMIPS_32	\.data\+0x10000
0+00e0 <text_label\+0xe0> 6080 0000 0000 	li	a0,0x0
			e2: R_NANOMIPS_32	big_external_data_label\+0x10000
0+00e6 <text_label\+0xe6> 4080 0000 	addiu	a0,gp,0
			e6: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x10000
0+00ea <text_label\+0xea> 6080 0000 0000 	li	a0,0x0
			ec: R_NANOMIPS_32	big_external_common\+0x10000
0+00f0 <text_label\+0xf0> 4080 0000 	addiu	a0,gp,0
			f0: R_NANOMIPS_GPREL19_S2	small_external_common\+0x10000
0+00f4 <text_label\+0xf4> 6080 0000 0000 	li	a0,0x0
			f6: R_NANOMIPS_32	\.bss\+0x10000
0+00fa <text_label\+0xfa> 4080 0000 	addiu	a0,gp,0
			fa: R_NANOMIPS_GPREL19_S2	\.sbss\+0x10000
0+00fe <text_label\+0xfe> 6080 0000 0000 	li	a0,0x0
			100: R_NANOMIPS_32	\.data\+0x1a5a5
0+0104 <text_label\+0x104> 6080 0000 0000 	li	a0,0x0
			106: R_NANOMIPS_32	big_external_data_label\+0x1a5a5
0+010a <text_label\+0x10a> 4080 0000 	addiu	a0,gp,0
			10a: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1a5a5
0+010e <text_label\+0x10e> 6080 0000 0000 	li	a0,0x0
			110: R_NANOMIPS_32	big_external_common\+0x1a5a5
0+0114 <text_label\+0x114> 4080 0000 	addiu	a0,gp,0
			114: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1a5a5
0+0118 <text_label\+0x118> 6080 0000 0000 	li	a0,0x0
			11a: R_NANOMIPS_32	\.bss\+0x1a5a5
0+011e <text_label\+0x11e> 4080 0000 	addiu	a0,gp,0
			11e: R_NANOMIPS_GPREL19_S2	\.sbss\+0x1a5a5
0+0122 <text_label\+0x122> 6080 0000 0000 	li	a0,0x0
			124: R_NANOMIPS_32	\.data
0+0128 <text_label\+0x128> 20a4 2150 	addu	a0,a0,a1
0+012c <text_label\+0x12c> 6080 0000 0000 	li	a0,0x0
			12e: R_NANOMIPS_32	big_external_data_label
0+0132 <text_label\+0x132> 20a4 2150 	addu	a0,a0,a1
0+0136 <text_label\+0x136> 4080 0000 	addiu	a0,gp,0
			136: R_NANOMIPS_GPREL19_S2	small_external_data_label
0+013a <text_label\+0x13a> 20a4 2150 	addu	a0,a0,a1
0+013e <text_label\+0x13e> 6080 0000 0000 	li	a0,0x0
			140: R_NANOMIPS_32	big_external_common
0+0144 <text_label\+0x144> 20a4 2150 	addu	a0,a0,a1
0+0148 <text_label\+0x148> 4080 0000 	addiu	a0,gp,0
			148: R_NANOMIPS_GPREL19_S2	small_external_common
0+014c <text_label\+0x14c> 20a4 2150 	addu	a0,a0,a1
0+0150 <text_label\+0x150> 6080 0000 0000 	li	a0,0x0
			152: R_NANOMIPS_32	\.bss
0+0156 <text_label\+0x156> 20a4 2150 	addu	a0,a0,a1
0+015a <text_label\+0x15a> 4080 0000 	addiu	a0,gp,0
			15a: R_NANOMIPS_GPREL19_S2	\.sbss
0+015e <text_label\+0x15e> 20a4 2150 	addu	a0,a0,a1
0+0162 <text_label\+0x162> 6080 0000 0000 	li	a0,0x0
			164: R_NANOMIPS_32	\.data\+0x1
0+0168 <text_label\+0x168> 20a4 2150 	addu	a0,a0,a1
0+016c <text_label\+0x16c> 6080 0000 0000 	li	a0,0x0
			16e: R_NANOMIPS_32	big_external_data_label\+0x1
0+0172 <text_label\+0x172> 20a4 2150 	addu	a0,a0,a1
0+0176 <text_label\+0x176> 4080 0000 	addiu	a0,gp,0
			176: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1
0+017a <text_label\+0x17a> 20a4 2150 	addu	a0,a0,a1
0+017e <text_label\+0x17e> 6080 0000 0000 	li	a0,0x0
			180: R_NANOMIPS_32	big_external_common\+0x1
0+0184 <text_label\+0x184> 20a4 2150 	addu	a0,a0,a1
0+0188 <text_label\+0x188> 4080 0000 	addiu	a0,gp,0
			188: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1
0+018c <text_label\+0x18c> 20a4 2150 	addu	a0,a0,a1
0+0190 <text_label\+0x190> 6080 0000 0000 	li	a0,0x0
			192: R_NANOMIPS_32	\.bss\+0x1
0+0196 <text_label\+0x196> 20a4 2150 	addu	a0,a0,a1
0+019a <text_label\+0x19a> 4080 0000 	addiu	a0,gp,0
			19a: R_NANOMIPS_GPREL19_S2	\.sbss\+0x1
0+019e <text_label\+0x19e> 20a4 2150 	addu	a0,a0,a1
0+01a2 <text_label\+0x1a2> 6080 0000 0000 	li	a0,0x0
			1a4: R_NANOMIPS_32	\.data\+0x8000
0+01a8 <text_label\+0x1a8> 20a4 2150 	addu	a0,a0,a1
0+01ac <text_label\+0x1ac> 6080 0000 0000 	li	a0,0x0
			1ae: R_NANOMIPS_32	big_external_data_label\+0x8000
0+01b2 <text_label\+0x1b2> 20a4 2150 	addu	a0,a0,a1
0+01b6 <text_label\+0x1b6> 4080 0000 	addiu	a0,gp,0
			1b6: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x8000
0+01ba <text_label\+0x1ba> 20a4 2150 	addu	a0,a0,a1
0+01be <text_label\+0x1be> 6080 0000 0000 	li	a0,0x0
			1c0: R_NANOMIPS_32	big_external_common\+0x8000
0+01c4 <text_label\+0x1c4> 20a4 2150 	addu	a0,a0,a1
0+01c8 <text_label\+0x1c8> 4080 0000 	addiu	a0,gp,0
			1c8: R_NANOMIPS_GPREL19_S2	small_external_common\+0x8000
0+01cc <text_label\+0x1cc> 20a4 2150 	addu	a0,a0,a1
0+01d0 <text_label\+0x1d0> 6080 0000 0000 	li	a0,0x0
			1d2: R_NANOMIPS_32	\.bss\+0x8000
0+01d6 <text_label\+0x1d6> 20a4 2150 	addu	a0,a0,a1
0+01da <text_label\+0x1da> 4080 0000 	addiu	a0,gp,0
			1da: R_NANOMIPS_GPREL19_S2	\.sbss\+0x8000
0+01de <text_label\+0x1de> 20a4 2150 	addu	a0,a0,a1
0+01e2 <text_label\+0x1e2> 6080 0000 0000 	li	a0,0x0
			1e4: R_NANOMIPS_32	\.data-0x8000
0+01e8 <text_label\+0x1e8> 20a4 2150 	addu	a0,a0,a1
0+01ec <text_label\+0x1ec> 6080 0000 0000 	li	a0,0x0
			1ee: R_NANOMIPS_32	big_external_data_label-0x8000
0+01f2 <text_label\+0x1f2> 20a4 2150 	addu	a0,a0,a1
0+01f6 <text_label\+0x1f6> 6080 0000 0000 	li	a0,0x0
			1f8: R_NANOMIPS_32	small_external_data_label-0x8000
0+01fc <text_label\+0x1fc> 20a4 2150 	addu	a0,a0,a1
0+0200 <text_label\+0x200> 6080 0000 0000 	li	a0,0x0
			202: R_NANOMIPS_32	big_external_common-0x8000
0+0206 <text_label\+0x206> 20a4 2150 	addu	a0,a0,a1
0+020a <text_label\+0x20a> 6080 0000 0000 	li	a0,0x0
			20c: R_NANOMIPS_32	small_external_common-0x8000
0+0210 <text_label\+0x210> 20a4 2150 	addu	a0,a0,a1
0+0214 <text_label\+0x214> 6080 0000 0000 	li	a0,0x0
			216: R_NANOMIPS_32	\.bss-0x8000
0+021a <text_label\+0x21a> 20a4 2150 	addu	a0,a0,a1
0+021e <text_label\+0x21e> 6080 0000 0000 	li	a0,0x0
			220: R_NANOMIPS_32	\.sbss-0x8000
0+0224 <text_label\+0x224> 20a4 2150 	addu	a0,a0,a1
0+0228 <text_label\+0x228> 6080 0000 0000 	li	a0,0x0
			22a: R_NANOMIPS_32	\.data\+0x10000
0+022e <text_label\+0x22e> 20a4 2150 	addu	a0,a0,a1
0+0232 <text_label\+0x232> 6080 0000 0000 	li	a0,0x0
			234: R_NANOMIPS_32	big_external_data_label\+0x10000
0+0238 <text_label\+0x238> 20a4 2150 	addu	a0,a0,a1
0+023c <text_label\+0x23c> 4080 0000 	addiu	a0,gp,0
			23c: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x10000
0+0240 <text_label\+0x240> 20a4 2150 	addu	a0,a0,a1
0+0244 <text_label\+0x244> 6080 0000 0000 	li	a0,0x0
			246: R_NANOMIPS_32	big_external_common\+0x10000
0+024a <text_label\+0x24a> 20a4 2150 	addu	a0,a0,a1
0+024e <text_label\+0x24e> 4080 0000 	addiu	a0,gp,0
			24e: R_NANOMIPS_GPREL19_S2	small_external_common\+0x10000
0+0252 <text_label\+0x252> 20a4 2150 	addu	a0,a0,a1
0+0256 <text_label\+0x256> 6080 0000 0000 	li	a0,0x0
			258: R_NANOMIPS_32	\.bss\+0x10000
0+025c <text_label\+0x25c> 20a4 2150 	addu	a0,a0,a1
0+0260 <text_label\+0x260> 4080 0000 	addiu	a0,gp,0
			260: R_NANOMIPS_GPREL19_S2	\.sbss\+0x10000
0+0264 <text_label\+0x264> 20a4 2150 	addu	a0,a0,a1
0+0268 <text_label\+0x268> 6080 0000 0000 	li	a0,0x0
			26a: R_NANOMIPS_32	\.data\+0x1a5a5
0+026e <text_label\+0x26e> 20a4 2150 	addu	a0,a0,a1
0+0272 <text_label\+0x272> 6080 0000 0000 	li	a0,0x0
			274: R_NANOMIPS_32	big_external_data_label\+0x1a5a5
0+0278 <text_label\+0x278> 20a4 2150 	addu	a0,a0,a1
0+027c <text_label\+0x27c> 4080 0000 	addiu	a0,gp,0
			27c: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1a5a5
0+0280 <text_label\+0x280> 20a4 2150 	addu	a0,a0,a1
0+0284 <text_label\+0x284> 6080 0000 0000 	li	a0,0x0
			286: R_NANOMIPS_32	big_external_common\+0x1a5a5
0+028a <text_label\+0x28a> 20a4 2150 	addu	a0,a0,a1
0+028e <text_label\+0x28e> 4080 0000 	addiu	a0,gp,0
			28e: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1a5a5
0+0292 <text_label\+0x292> 20a4 2150 	addu	a0,a0,a1
0+0296 <text_label\+0x296> 6080 0000 0000 	li	a0,0x0
			298: R_NANOMIPS_32	\.bss\+0x1a5a5
0+029c <text_label\+0x29c> 20a4 2150 	addu	a0,a0,a1
0+02a0 <text_label\+0x2a0> 4080 0000 	addiu	a0,gp,0
			2a0: R_NANOMIPS_GPREL19_S2	\.sbss\+0x1a5a5
0+02a4 <text_label\+0x2a4> 20a4 2150 	addu	a0,a0,a1
0+02a8 <text_label\+0x2a8> 0085 0000 	addiu	a0,a1,0
0+02ac <text_label\+0x2ac> 6080 0012 3456 	li	a0,0x123456
0+02b2 <text_label\+0x2b2> 6080 0012 3456 	li	a0,0x123456
0+02b8 <text_label\+0x2b8> 20a4 2150 	addu	a0,a0,a1
0+02bc <text_label\+0x2bc> 6080 0000 0000 	li	a0,0x0
			2be: R_NANOMIPS_32	big_external_data_label
0+02c2 <text_label\+0x2c2> 6080 0000 0000 	li	a0,0x0
			2c4: R_NANOMIPS_32	big_external_data_label
0+02c8 <text_label\+0x2c8> 20a4 2150 	addu	a0,a0,a1
	\.\.\.
