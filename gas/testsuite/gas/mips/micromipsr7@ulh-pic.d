#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS R7 ulh-svr4pic
#as: -32 -KPIC
#source: ulh-pic.s

# Test the unaligned load and store macros with -KPIC for R7.

.*: +file format .*mips.*

Disassembly of section .text:
0+0000 <.text> 843c8000 	0x843c8000
			0: R_MICROMIPS_GOT_PAGE	.data
0+0004 <.text\+0x4> 84814000 	0x84814000
			4: R_MICROMIPS_GOT_OFST	.data
0+0008 <.text\+0x8> 843c8000 	0x843c8000
			8: R_MICROMIPS_GOT_PAGE	big_external_data_label
0+000c <.text\+0xc> 84814000 	0x84814000
			c: R_MICROMIPS_GOT_OFST	big_external_data_label
0+0010 <.text\+0x10> 843c8000 	0x843c8000
			10: R_MICROMIPS_GOT_PAGE	small_external_data_label
0+0014 <.text\+0x14> 84818000 	0x84818000
			14: R_MICROMIPS_GOT_OFST	small_external_data_label
0+0018 <.text\+0x18> 843c8000 	0x843c8000
			18: R_MICROMIPS_GOT_PAGE	big_external_common
0+001c <.text\+0x1c> 84815000 	0x84815000
			1c: R_MICROMIPS_GOT_OFST	big_external_common
0+0020 <.text\+0x20> 843c8000 	0x843c8000
			20: R_MICROMIPS_GOT_PAGE	small_external_common
0+0024 <.text\+0x24> 84819000 	0x84819000
			24: R_MICROMIPS_GOT_OFST	small_external_common
0+0028 <.text\+0x28> 843c8000 	0x843c8000
			28: R_MICROMIPS_GOT_PAGE	\.bss)
0+002c <.text\+0x2c> 84814000 	0x84814000
			2c: R_MICROMIPS_GOT_OFST	\.bss)
0+0030 <.text\+0x30> 843c8000 	0x843c8000
			30: R_MICROMIPS_GOT_PAGE	\.bss)\+0x3e8
0+0034 <.text\+0x34> 84814000 	0x84814000
			34: R_MICROMIPS_GOT_OFST	\.bss)\+0x3e8
0+0038 <.text\+0x38> 843c8000 	0x843c8000
			38: R_MICROMIPS_GOT_PAGE	.data\+0x1
0+003c <.text\+0x3c> 84818000 	0x84818000
			3c: R_MICROMIPS_GOT_OFST	.data\+0x1
0+0040 <.text\+0x40> 843c8000 	0x843c8000
			40: R_MICROMIPS_GOT_PAGE	big_external_data_label\+0x1
0+0044 <.text\+0x44> 84815000 	0x84815000
			44: R_MICROMIPS_GOT_OFST	big_external_data_label\+0x1
0+0048 <.text\+0x48> 843c8000 	0x843c8000
			48: R_MICROMIPS_GOT_PAGE	small_external_data_label\+0x1
0+004c <.text\+0x4c> 84819000 	0x84819000
			4c: R_MICROMIPS_GOT_OFST	small_external_data_label\+0x1
0+0050 <.text\+0x50> 843c8000 	0x843c8000
			50: R_MICROMIPS_GOT_PAGE	big_external_common\+0x1
0+0054 <.text\+0x54> 84814000 	0x84814000
			54: R_MICROMIPS_GOT_OFST	big_external_common\+0x1
0+0058 <.text\+0x58> 843c8000 	0x843c8000
			58: R_MICROMIPS_GOT_PAGE	small_external_common\+0x1
0+005c <.text\+0x5c> 84814000 	0x84814000
			5c: R_MICROMIPS_GOT_OFST	small_external_common\+0x1
0+0060 <.text\+0x60> 843c8000 	0x843c8000
			60: R_MICROMIPS_GOT_PAGE	\.bss)\+0x1
0+0064 <.text\+0x64> 84818000 	0x84818000
			64: R_MICROMIPS_GOT_OFST	\.bss)\+0x1
0+0068 <.text\+0x68> 843c8000 	0x843c8000
			68: R_MICROMIPS_GOT_PAGE	\.bss)\+0x3e9
0+006c <.text\+0x6c> 84815000 	0x84815000
			6c: R_MICROMIPS_GOT_OFST	\.bss)\+0x3e9
0+0070 <.text\+0x70> 90089008 	0x90089008
0+0074 <.text\+0x74> 90089008 	0x90089008
