#as: -32
#objdump: -dr --prefix-addresses --show-raw-insn
#name: LA with relocation operators
#source: la-reloc.s

.*file format.*

Disassembly of section \.text:
0+0000 <func> e080 0000 	lui	\$4,0x0
			0: R_MICROMIPS_HI20	foo
0+0004 <func\+0x4> 0084 0000 	addiu	\$4,\$4,0
			4: R_MICROMIPS_LO12	foo
0+0008 <func\+0x8> e080 0000 	lui	\$4,0x0
			8: R_MICROMIPS_HI20	foo
0+000c <func\+0xc> 0084 0000 	addiu	\$4,\$4,0
			c: R_MICROMIPS_LO12	foo
0+0010 <func\+0x10> e094 8244 	lui	\$4,0x12348
0+0014 <func\+0x14> 8084 0765 	ori	\$4,\$4,1893
0+0018 <func\+0x18> e094 8244 	lui	\$4,0x12348
0+001c <func\+0x1c> 8084 0765 	ori	\$4,\$4,1893
0+0020 <func\+0x20> e080 0000 	lui	\$4,0x0
			20: R_MICROMIPS_HI20	foo
0+0024 <func\+0x24> 0084 0000 	addiu	\$4,\$4,0
			24: R_MICROMIPS_LO12	foo
0+0028 <func\+0x28> 20a4 2150 	addu	\$4,\$4,\$5
0+002c <func\+0x2c> e080 0000 	lui	\$4,0x0
			2c: R_MICROMIPS_HI20	foo
0+0030 <func\+0x30> 0084 0000 	addiu	\$4,\$4,0
			30: R_MICROMIPS_LO12	foo
0+0034 <func\+0x34> 20a4 2150 	addu	\$4,\$4,\$5
0+0038 <func\+0x38> e094 8244 	lui	\$4,0x12348
0+003c <func\+0x3c> 8084 0765 	ori	\$4,\$4,1893
0+0040 <func\+0x40> 20a4 2150 	addu	\$4,\$4,\$5
0+0044 <func\+0x44> e094 8244 	lui	\$4,0x12348
0+0048 <func\+0x48> 8084 0765 	ori	\$4,\$4,1893
0+004c <func\+0x4c> 20a4 2150 	addu	\$4,\$4,\$5
0+0050 <func\+0x50> e080 0000 	lui	\$4,0x0
			50: R_MICROMIPS_HI20	foo\+0x12348765
0+0054 <func\+0x54> 0084 0000 	addiu	\$4,\$4,0
			54: R_MICROMIPS_LO12	foo\+0x12348765
0+0058 <func\+0x58> 20a4 2150 	addu	\$4,\$4,\$5
0+005c <func\+0x5c> e080 0000 	lui	\$4,0x0
			5c: R_MICROMIPS_HI20	foo\+0x12348765
0+0060 <func\+0x60> 0084 0000 	addiu	\$4,\$4,0
			60: R_MICROMIPS_LO12	foo\+0x12348765
0+0064 <func\+0x64> 20a4 2150 	addu	\$4,\$4,\$5
