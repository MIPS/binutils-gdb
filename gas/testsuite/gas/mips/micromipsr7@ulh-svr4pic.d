#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS R7 ulh-svr4pic
#as: -32 -KPIC
#source: ulh-pic.s

# Test the unaligned load and store macros with -KPIC for R7.

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> 843c 8000 	lw	at,0\(gp\)
			0: R_MICROMIPS_GOT_PAGE	.data
0+0004 <text_label\+0x4> 8481 4000 	lh	a0,0\(at\)
			4: R_MICROMIPS_GOT_OFST	.data
0+0008 <text_label\+0x8> 843c 8000 	lw	at,0\(gp\)
			8: R_MICROMIPS_GOT_PAGE	big_external_data_label
0+000c <text_label\+0xc> 8481 4000 	lh	a0,0\(at\)
			c: R_MICROMIPS_GOT_OFST	big_external_data_label
0+0010 <text_label\+0x10> 843c 8000 	lw	at,0\(gp\)
			10: R_MICROMIPS_GOT_PAGE	small_external_data_label
0+0014 <text_label\+0x14> 8481 8000 	lw	a0,0\(at\)
			14: R_MICROMIPS_GOT_OFST	small_external_data_label
0+0018 <text_label\+0x18> 843c 8000 	lw	at,0\(gp\)
			18: R_MICROMIPS_GOT_PAGE	big_external_common
0+001c <text_label\+0x1c> 8481 5000 	sh	a0,0\(at\)
			1c: R_MICROMIPS_GOT_OFST	big_external_common
0+0020 <text_label\+0x20> 843c 8000 	lw	at,0\(gp\)
			20: R_MICROMIPS_GOT_PAGE	small_external_common
0+0024 <text_label\+0x24> 8481 9000 	sw	a0,0\(at\)
			24: R_MICROMIPS_GOT_OFST	small_external_common
0+0028 <text_label\+0x28> 843c 8000 	lw	at,0\(gp\)
			28: R_MICROMIPS_GOT_PAGE	\.bss)
0+002c <text_label\+0x2c> 8481 4000 	lh	a0,0\(at\)
			2c: R_MICROMIPS_GOT_OFST	\.bss)
0+0030 <text_label\+0x30> 843c 8000 	lw	at,0\(gp\)
			30: R_MICROMIPS_GOT_PAGE	\.bss)\+0x3e8
0+0034 <text_label\+0x34> 8481 4000 	lh	a0,0\(at\)
			34: R_MICROMIPS_GOT_OFST	\.bss)\+0x3e8
0+0038 <text_label\+0x38> 843c 8000 	lw	at,0\(gp\)
			38: R_MICROMIPS_GOT_PAGE	.data\+0x1
0+003c <text_label\+0x3c> 8481 8000 	lw	a0,0\(at\)
			3c: R_MICROMIPS_GOT_OFST	.data\+0x1
0+0040 <text_label\+0x40> 843c 8000 	lw	at,0\(gp\)
			40: R_MICROMIPS_GOT_PAGE	big_external_data_label\+0x1
0+0044 <text_label\+0x44> 8481 5000 	sh	a0,0\(at\)
			44: R_MICROMIPS_GOT_OFST	big_external_data_label\+0x1
0+0048 <text_label\+0x48> 843c 8000 	lw	at,0\(gp\)
			48: R_MICROMIPS_GOT_PAGE	small_external_data_label\+0x1
0+004c <text_label\+0x4c> 8481 9000 	sw	a0,0\(at\)
			4c: R_MICROMIPS_GOT_OFST	small_external_data_label\+0x1
0+0050 <text_label\+0x50> 843c 8000 	lw	at,0\(gp\)
			50: R_MICROMIPS_GOT_PAGE	big_external_common\+0x1
0+0054 <text_label\+0x54> 8481 4000 	lh	a0,0\(at\)
			54: R_MICROMIPS_GOT_OFST	big_external_common\+0x1
0+0058 <text_label\+0x58> 843c 8000 	lw	at,0\(gp\)
			58: R_MICROMIPS_GOT_PAGE	small_external_common\+0x1
0+005c <text_label\+0x5c> 8481 4000 	lh	a0,0\(at\)
			5c: R_MICROMIPS_GOT_OFST	small_external_common\+0x1
0+0060 <text_label\+0x60> 843c 8000 	lw	at,0\(gp\)
			60: R_MICROMIPS_GOT_PAGE	\.bss)\+0x1
0+0064 <text_label\+0x64> 8481 8000 	lw	a0,0\(at\)
			64: R_MICROMIPS_GOT_OFST	\.bss)\+0x1
0+0068 <text_label\+0x68> 843c 8000 	lw	at,0\(gp\)
			68: R_MICROMIPS_GOT_PAGE	\.bss)\+0x3e9
0+006c <text_label\+0x6c> 8481 5000 	sh	a0,0\(at\)
			6c: R_MICROMIPS_GOT_OFST	\.bss)\+0x3e9
0+0070 <text_label\+0x70> 9008      	nop
0+0072 <text_label\+0x72> 9008      	nop
0+0074 <text_label\+0x74> 9008      	nop
0+0076 <text_label\+0x76> 9008      	nop
