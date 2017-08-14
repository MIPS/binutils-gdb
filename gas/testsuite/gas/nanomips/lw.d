#objdump: -dr --prefix-addresses --show-raw-insn
#as: -p32 --defsym tlw=1
#name: nanoMIPS lw
#source: ld.s

# Test the lw macro.

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> e081 a000 	lui	a0,%hi\(0x1a000\)
0+0004 <text_label\+0x4> 20a4 2150 	addu	a0,a0,a1
0+0008 <text_label\+0x8> 8484 85a5 	lw	a0,1445\(a0\)
0+000c <text_label\+0xc> 8480 8000 	lw	a0,0\(zero\)
0+0010 <text_label\+0x10> 8480 8001 	lw	a0,1\(zero\)
0+0014 <text_label\+0x14> 8480 8800 	lw	a0,2048\(zero\)
0+0018 <text_label\+0x18> 0080 9800 	addiu	a0,zero,-2048
0+001c <text_label\+0x1c> 8484 8000 	lw	a0,0\(a0\)
0+0020 <text_label\+0x20> 0080 1000 	addiu	a0,zero,4096
0+0024 <text_label\+0x24> 8484 8000 	lw	a0,0\(a0\)
0+0028 <text_label\+0x28> e081 a000 	lui	a0,%hi\(0x1a000\)
0+002c <text_label\+0x2c> 8484 85a5 	lw	a0,1445\(a0\)
0+0030 <text_label\+0x30> 7650      	lw	a0,0\(a1\)
0+0032 <text_label\+0x32> 8485 8001 	lw	a0,1\(a1\)
0+0036 <text_label\+0x36> 8485 8800 	lw	a0,2048\(a1\)
0+003a <text_label\+0x3a> 0085 9800 	addiu	a0,a1,-2048
0+003e <text_label\+0x3e> 8484 8000 	lw	a0,0\(a0\)
0+0042 <text_label\+0x42> 0085 1000 	addiu	a0,a1,4096
0+0046 <text_label\+0x46> 8484 8000 	lw	a0,0\(a0\)
0+004a <text_label\+0x4a> e080 0000 	lui	a0,0x0
			4a: R_NANOMIPS_HI20	.data
0+004e <text_label\+0x4e> 8484 8000 	lw	a0,0\(a0\)
			4e: R_NANOMIPS_LO12	.data
0+0052 <text_label\+0x52> e080 0000 	lui	a0,0x0
			52: R_NANOMIPS_HI20	big_external_data_label
0+0056 <text_label\+0x56> 8484 8000 	lw	a0,0\(a0\)
			56: R_NANOMIPS_LO12	big_external_data_label
0+005a <text_label\+0x5a> 4080 0002 	lw	a0,0\(gp\)
			5a: R_NANOMIPS_GPREL19_S2	small_external_data_label
0+005e <text_label\+0x5e> e080 0000 	lui	a0,0x0
			5e: R_NANOMIPS_HI20	big_external_common
0+0062 <text_label\+0x62> 8484 8000 	lw	a0,0\(a0\)
			62: R_NANOMIPS_LO12	big_external_common
0+0066 <text_label\+0x66> 4080 0002 	lw	a0,0\(gp\)
			66: R_NANOMIPS_GPREL19_S2	small_external_common
0+006a <text_label\+0x6a> e080 0000 	lui	a0,0x0
			6a: R_NANOMIPS_HI20	.bss
0+006e <text_label\+0x6e> 8484 8000 	lw	a0,0\(a0\)
			6e: R_NANOMIPS_LO12	.bss
0+0072 <text_label\+0x72> 4080 0002 	lw	a0,0\(gp\)
			72: R_NANOMIPS_GPREL19_S2	.sbss
0+0076 <text_label\+0x76> e080 0000 	lui	a0,0x0
			76: R_NANOMIPS_HI20	.data\+0x1
0+007a <text_label\+0x7a> 8484 8000 	lw	a0,0\(a0\)
			7a: R_NANOMIPS_LO12	.data\+0x1
0+007e <text_label\+0x7e> e080 0000 	lui	a0,0x0
			7e: R_NANOMIPS_HI20	big_external_data_label\+0x1
0+0082 <text_label\+0x82> 8484 8000 	lw	a0,0\(a0\)
			82: R_NANOMIPS_LO12	big_external_data_label\+0x1
0+0086 <text_label\+0x86> 4080 0002 	lw	a0,0\(gp\)
			86: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1
0+008a <text_label\+0x8a> e080 0000 	lui	a0,0x0
			8a: R_NANOMIPS_HI20	big_external_common\+0x1
0+008e <text_label\+0x8e> 8484 8000 	lw	a0,0\(a0\)
			8e: R_NANOMIPS_LO12	big_external_common\+0x1
0+0092 <text_label\+0x92> 4080 0002 	lw	a0,0\(gp\)
			92: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1
0+0096 <text_label\+0x96> e080 0000 	lui	a0,0x0
			96: R_NANOMIPS_HI20	.bss\+0x1
0+009a <text_label\+0x9a> 8484 8000 	lw	a0,0\(a0\)
			9a: R_NANOMIPS_LO12	.bss\+0x1
0+009e <text_label\+0x9e> 4080 0002 	lw	a0,0\(gp\)
			9e: R_NANOMIPS_GPREL19_S2	.sbss\+0x1
0+00a2 <text_label\+0xa2> e080 0000 	lui	a0,0x0
			a2: R_NANOMIPS_HI20	.data\+0x800
0+00a6 <text_label\+0xa6> 8484 8000 	lw	a0,0\(a0\)
			a6: R_NANOMIPS_LO12	.data\+0x800
0+00aa <text_label\+0xaa> e080 0000 	lui	a0,0x0
			aa: R_NANOMIPS_HI20	big_external_data_label\+0x800
0+00ae <text_label\+0xae> 8484 8000 	lw	a0,0\(a0\)
			ae: R_NANOMIPS_LO12	big_external_data_label\+0x800
0+00b2 <text_label\+0xb2> 4080 0002 	lw	a0,0\(gp\)
			b2: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x800
0+00b6 <text_label\+0xb6> e080 0000 	lui	a0,0x0
			b6: R_NANOMIPS_HI20	big_external_common\+0x800
0+00ba <text_label\+0xba> 8484 8000 	lw	a0,0\(a0\)
			ba: R_NANOMIPS_LO12	big_external_common\+0x800
0+00be <text_label\+0xbe> 4080 0002 	lw	a0,0\(gp\)
			be: R_NANOMIPS_GPREL19_S2	small_external_common\+0x800
0+00c2 <text_label\+0xc2> e080 0000 	lui	a0,0x0
			c2: R_NANOMIPS_HI20	.bss\+0x800
0+00c6 <text_label\+0xc6> 8484 8000 	lw	a0,0\(a0\)
			c6: R_NANOMIPS_LO12	.bss\+0x800
0+00ca <text_label\+0xca> 4080 0002 	lw	a0,0\(gp\)
			ca: R_NANOMIPS_GPREL19_S2	.sbss\+0x800
0+00ce <text_label\+0xce> e080 0000 	lui	a0,0x0
			ce: R_NANOMIPS_HI20	.data-0x800
0+00d2 <text_label\+0xd2> 8484 8000 	lw	a0,0\(a0\)
			d2: R_NANOMIPS_LO12	.data-0x800
0+00d6 <text_label\+0xd6> e080 0000 	lui	a0,0x0
			d6: R_NANOMIPS_HI20	big_external_data_label-0x800
0+00da <text_label\+0xda> 8484 8000 	lw	a0,0\(a0\)
			da: R_NANOMIPS_LO12	big_external_data_label-0x800
0+00de <text_label\+0xde> e080 0000 	lui	a0,0x0
			de: R_NANOMIPS_HI20	small_external_data_label-0x800
0+00e2 <text_label\+0xe2> 8484 8000 	lw	a0,0\(a0\)
			e2: R_NANOMIPS_LO12	small_external_data_label-0x800
0+00e6 <text_label\+0xe6> e080 0000 	lui	a0,0x0
			e6: R_NANOMIPS_HI20	big_external_common-0x800
0+00ea <text_label\+0xea> 8484 8000 	lw	a0,0\(a0\)
			ea: R_NANOMIPS_LO12	big_external_common-0x800
0+00ee <text_label\+0xee> e080 0000 	lui	a0,0x0
			ee: R_NANOMIPS_HI20	small_external_common-0x800
0+00f2 <text_label\+0xf2> 8484 8000 	lw	a0,0\(a0\)
			f2: R_NANOMIPS_LO12	small_external_common-0x800
0+00f6 <text_label\+0xf6> e080 0000 	lui	a0,0x0
			f6: R_NANOMIPS_HI20	.bss-0x800
0+00fa <text_label\+0xfa> 8484 8000 	lw	a0,0\(a0\)
			fa: R_NANOMIPS_LO12	.bss-0x800
0+00fe <text_label\+0xfe> e080 0000 	lui	a0,0x0
			fe: R_NANOMIPS_HI20	.sbss-0x800
0+0102 <text_label\+0x102> 8484 8000 	lw	a0,0\(a0\)
			102: R_NANOMIPS_LO12	.sbss-0x800
0+0106 <text_label\+0x106> e080 0000 	lui	a0,0x0
			106: R_NANOMIPS_HI20	.data\+0x1000
0+010a <text_label\+0x10a> 8484 8000 	lw	a0,0\(a0\)
			10a: R_NANOMIPS_LO12	.data\+0x1000
0+010e <text_label\+0x10e> e080 0000 	lui	a0,0x0
			10e: R_NANOMIPS_HI20	big_external_data_label\+0x1000
0+0112 <text_label\+0x112> 8484 8000 	lw	a0,0\(a0\)
			112: R_NANOMIPS_LO12	big_external_data_label\+0x1000
0+0116 <text_label\+0x116> 4080 0002 	lw	a0,0\(gp\)
			116: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1000
0+011a <text_label\+0x11a> e080 0000 	lui	a0,0x0
			11a: R_NANOMIPS_HI20	big_external_common\+0x1000
0+011e <text_label\+0x11e> 8484 8000 	lw	a0,0\(a0\)
			11e: R_NANOMIPS_LO12	big_external_common\+0x1000
0+0122 <text_label\+0x122> 4080 0002 	lw	a0,0\(gp\)
			122: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1000
0+0126 <text_label\+0x126> e080 0000 	lui	a0,0x0
			126: R_NANOMIPS_HI20	.bss\+0x1000
0+012a <text_label\+0x12a> 8484 8000 	lw	a0,0\(a0\)
			12a: R_NANOMIPS_LO12	.bss\+0x1000
0+012e <text_label\+0x12e> 4080 0002 	lw	a0,0\(gp\)
			12e: R_NANOMIPS_GPREL19_S2	.sbss\+0x1000
0+0132 <text_label\+0x132> e080 0000 	lui	a0,0x0
			132: R_NANOMIPS_HI20	.data\+0x1a5a5
0+0136 <text_label\+0x136> 8484 8000 	lw	a0,0\(a0\)
			136: R_NANOMIPS_LO12	.data\+0x1a5a5
0+013a <text_label\+0x13a> e080 0000 	lui	a0,0x0
			13a: R_NANOMIPS_HI20	big_external_data_label\+0x1a5a5
0+013e <text_label\+0x13e> 8484 8000 	lw	a0,0\(a0\)
			13e: R_NANOMIPS_LO12	big_external_data_label\+0x1a5a5
0+0142 <text_label\+0x142> 4080 0002 	lw	a0,0\(gp\)
			142: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1a5a5
0+0146 <text_label\+0x146> e080 0000 	lui	a0,0x0
			146: R_NANOMIPS_HI20	big_external_common\+0x1a5a5
0+014a <text_label\+0x14a> 8484 8000 	lw	a0,0\(a0\)
			14a: R_NANOMIPS_LO12	big_external_common\+0x1a5a5
0+014e <text_label\+0x14e> 4080 0002 	lw	a0,0\(gp\)
			14e: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1a5a5
0+0152 <text_label\+0x152> e080 0000 	lui	a0,0x0
			152: R_NANOMIPS_HI20	.bss\+0x1a5a5
0+0156 <text_label\+0x156> 8484 8000 	lw	a0,0\(a0\)
			156: R_NANOMIPS_LO12	.bss\+0x1a5a5
0+015a <text_label\+0x15a> 4080 0002 	lw	a0,0\(gp\)
			15a: R_NANOMIPS_GPREL19_S2	.sbss\+0x1a5a5
	...
#pass