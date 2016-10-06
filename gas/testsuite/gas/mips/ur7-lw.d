#objdump: -dr --prefix-addresses --show-raw-insn
#as: -mmicromips -mips32r7 -32 --defsym tlw=1 --defsym r7=1
#name: microMIPS R7 lw
#source: ld.s

# Test the lw macro.

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <text_label> e081 a000 	lui	a0,0x1a
0+0004 <text_label\+0x4> 20a4 2150 	addu	a0,a0,a1
0+0008 <text_label\+0x8> 8484 85a5 	lw	a0,1445\(a0\)
0+000c <text_label\+0xc> 8480 8000 	lw	a0,0\(zero\)
0+0010 <text_label\+0x10> 8480 8001 	lw	a0,1\(zero\)
0+0014 <text_label\+0x14> 8480 8800 	lw	a0,2048\(zero\)
0+0018 <text_label\+0x18> 0080 9800 	addiu	a0,zero,-2048
0+001c <text_label\+0x1c> 8484 8000 	lw	a0,0\(a0\)
0+0020 <text_label\+0x20> 0080 1000 	addiu	a0,zero,4096
0+0024 <text_label\+0x24> 8484 8000 	lw	a0,0\(a0\)
0+0028 <text_label\+0x28> e081 a000 	lui	a0,0x1a
0+002c <text_label\+0x2c> 8484 85a5 	lw	a0,1445\(a0\)
0+0030 <text_label\+0x30> 7650      	lw	a0,0\(a1\)
0+0032 <text_label\+0x32> 8485 8001 	lw	a0,1\(a1\)
0+0036 <text_label\+0x36> 8485 8800 	lw	a0,2048\(a1\)
0+003a <text_label\+0x3a> 0085 9800 	addiu	a0,a1,-2048
0+003e <text_label\+0x3e> 8484 8000 	lw	a0,0\(a0\)
0+0042 <text_label\+0x42> 0085 1000 	addiu	a0,a1,4096
0+0046 <text_label\+0x46> 8484 8000 	lw	a0,0\(a0\)
0+004a <text_label\+0x4a> e080 0000 	lui	a0,0x0
			4a: R_MICROMIPS_HI20	.data
0+004e <text_label\+0x4e> 8484 8000 	lw	a0,0\(a0\)
			4e: R_MICROMIPS_LO12	.data
0+0052 <text_label\+0x52> e080 0000 	lui	a0,0x0
			52: R_MICROMIPS_HI20	big_external_data_label
0+0056 <text_label\+0x56> 8484 8000 	lw	a0,0\(a0\)
			56: R_MICROMIPS_LO12	big_external_data_label
0+005a <text_label\+0x5a> 4080 0002 	lw	a0,0\(gp\)
			5a: R_MICROMIPS_GPREL19_S2	small_external_data_label
0+005e <text_label\+0x5e> e080 0000 	lui	a0,0x0
			5e: R_MICROMIPS_HI20	big_external_common
0+0062 <text_label\+0x62> 8484 8000 	lw	a0,0\(a0\)
			62: R_MICROMIPS_LO12	big_external_common
0+0066 <text_label\+0x66> 4080 0002 	lw	a0,0\(gp\)
			66: R_MICROMIPS_GPREL19_S2	small_external_common
0+006a <text_label\+0x6a> e080 0000 	lui	a0,0x0
			6a: R_MICROMIPS_HI20	.bss
0+006e <text_label\+0x6e> 8484 8000 	lw	a0,0\(a0\)
			6e: R_MICROMIPS_LO12	.bss
0+0072 <text_label\+0x72> 4080 0002 	lw	a0,0\(gp\)
			72: R_MICROMIPS_GPREL19_S2	.sbss
0+0076 <text_label\+0x76> e080 0000 	lui	a0,0x0
			76: R_MICROMIPS_HI20	.data\+0x1
0+007a <text_label\+0x7a> 8484 8000 	lw	a0,0\(a0\)
			7a: R_MICROMIPS_LO12	.data\+0x1
0+007e <text_label\+0x7e> e080 0000 	lui	a0,0x0
			7e: R_MICROMIPS_HI20	big_external_data_label\+0x1
0+0082 <text_label\+0x82> 8484 8000 	lw	a0,0\(a0\)
			82: R_MICROMIPS_LO12	big_external_data_label\+0x1
0+0086 <text_label\+0x86> 4080 0002 	lw	a0,0\(gp\)
			86: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x1
0+008a <text_label\+0x8a> e080 0000 	lui	a0,0x0
			8a: R_MICROMIPS_HI20	big_external_common\+0x1
0+008e <text_label\+0x8e> 8484 8000 	lw	a0,0\(a0\)
			8e: R_MICROMIPS_LO12	big_external_common\+0x1
0+0092 <text_label\+0x92> 4080 0002 	lw	a0,0\(gp\)
			92: R_MICROMIPS_GPREL19_S2	small_external_common\+0x1
0+0096 <text_label\+0x96> e080 0000 	lui	a0,0x0
			96: R_MICROMIPS_HI20	.bss\+0x1
0+009a <text_label\+0x9a> 8484 8000 	lw	a0,0\(a0\)
			9a: R_MICROMIPS_LO12	.bss\+0x1
0+009e <text_label\+0x9e> 4080 0002 	lw	a0,0\(gp\)
			9e: R_MICROMIPS_GPREL19_S2	.sbss\+0x1
0+00a2 <text_label\+0xa2> e080 0000 	lui	a0,0x0
			a2: R_MICROMIPS_HI20	.data\+0x800
0+00a6 <text_label\+0xa6> 8484 8000 	lw	a0,0\(a0\)
			a6: R_MICROMIPS_LO12	.data\+0x800
0+00aa <text_label\+0xaa> e080 0000 	lui	a0,0x0
			aa: R_MICROMIPS_HI20	big_external_data_label\+0x800
0+00ae <text_label\+0xae> 8484 8000 	lw	a0,0\(a0\)
			ae: R_MICROMIPS_LO12	big_external_data_label\+0x800
0+00b2 <text_label\+0xb2> 4080 0002 	lw	a0,0\(gp\)
			b2: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x800
0+00b6 <text_label\+0xb6> e080 0000 	lui	a0,0x0
			b6: R_MICROMIPS_HI20	big_external_common\+0x800
0+00ba <text_label\+0xba> 8484 8000 	lw	a0,0\(a0\)
			ba: R_MICROMIPS_LO12	big_external_common\+0x800
0+00be <text_label\+0xbe> 4080 0002 	lw	a0,0\(gp\)
			be: R_MICROMIPS_GPREL19_S2	small_external_common\+0x800
0+00c2 <text_label\+0xc2> e080 0000 	lui	a0,0x0
			c2: R_MICROMIPS_HI20	.bss\+0x800
0+00c6 <text_label\+0xc6> 8484 8000 	lw	a0,0\(a0\)
			c6: R_MICROMIPS_LO12	.bss\+0x800
0+00ca <text_label\+0xca> 4080 0002 	lw	a0,0\(gp\)
			ca: R_MICROMIPS_GPREL19_S2	.sbss\+0x800
0+00ce <text_label\+0xce> e080 0000 	lui	a0,0x0
			ce: R_MICROMIPS_HI20	.data-0x800
0+00d2 <text_label\+0xd2> 8484 8000 	lw	a0,0\(a0\)
			d2: R_MICROMIPS_LO12	.data-0x800
0+00d6 <text_label\+0xd6> e080 0000 	lui	a0,0x0
			d6: R_MICROMIPS_HI20	big_external_data_label-0x800
0+00da <text_label\+0xda> 8484 8000 	lw	a0,0\(a0\)
			da: R_MICROMIPS_LO12	big_external_data_label-0x800
0+00de <text_label\+0xde> e080 0000 	lui	a0,0x0
			de: R_MICROMIPS_HI20	small_external_data_label-0x800
0+00e2 <text_label\+0xe2> 8484 8000 	lw	a0,0\(a0\)
			e2: R_MICROMIPS_LO12	small_external_data_label-0x800
0+00e6 <text_label\+0xe6> e080 0000 	lui	a0,0x0
			e6: R_MICROMIPS_HI20	big_external_common-0x800
0+00ea <text_label\+0xea> 8484 8000 	lw	a0,0\(a0\)
			ea: R_MICROMIPS_LO12	big_external_common-0x800
0+00ee <text_label\+0xee> e080 0000 	lui	a0,0x0
			ee: R_MICROMIPS_HI20	small_external_common-0x800
0+00f2 <text_label\+0xf2> 8484 8000 	lw	a0,0\(a0\)
			f2: R_MICROMIPS_LO12	small_external_common-0x800
0+00f6 <text_label\+0xf6> e080 0000 	lui	a0,0x0
			f6: R_MICROMIPS_HI20	.bss-0x800
0+00fa <text_label\+0xfa> 8484 8000 	lw	a0,0\(a0\)
			fa: R_MICROMIPS_LO12	.bss-0x800
0+00fe <text_label\+0xfe> e080 0000 	lui	a0,0x0
			fe: R_MICROMIPS_HI20	.sbss-0x800
0+0102 <text_label\+0x102> 8484 8000 	lw	a0,0\(a0\)
			102: R_MICROMIPS_LO12	.sbss-0x800
0+0106 <text_label\+0x106> e080 0000 	lui	a0,0x0
			106: R_MICROMIPS_HI20	.data\+0x1000
0+010a <text_label\+0x10a> 8484 8000 	lw	a0,0\(a0\)
			10a: R_MICROMIPS_LO12	.data\+0x1000
0+010e <text_label\+0x10e> e080 0000 	lui	a0,0x0
			10e: R_MICROMIPS_HI20	big_external_data_label\+0x1000
0+0112 <text_label\+0x112> 8484 8000 	lw	a0,0\(a0\)
			112: R_MICROMIPS_LO12	big_external_data_label\+0x1000
0+0116 <text_label\+0x116> 4080 0002 	lw	a0,0\(gp\)
			116: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x1000
0+011a <text_label\+0x11a> e080 0000 	lui	a0,0x0
			11a: R_MICROMIPS_HI20	big_external_common\+0x1000
0+011e <text_label\+0x11e> 8484 8000 	lw	a0,0\(a0\)
			11e: R_MICROMIPS_LO12	big_external_common\+0x1000
0+0122 <text_label\+0x122> 4080 0002 	lw	a0,0\(gp\)
			122: R_MICROMIPS_GPREL19_S2	small_external_common\+0x1000
0+0126 <text_label\+0x126> e080 0000 	lui	a0,0x0
			126: R_MICROMIPS_HI20	.bss\+0x1000
0+012a <text_label\+0x12a> 8484 8000 	lw	a0,0\(a0\)
			12a: R_MICROMIPS_LO12	.bss\+0x1000
0+012e <text_label\+0x12e> 4080 0002 	lw	a0,0\(gp\)
			12e: R_MICROMIPS_GPREL19_S2	.sbss\+0x1000
0+0132 <text_label\+0x132> e080 0000 	lui	a0,0x0
			132: R_MICROMIPS_HI20	.data\+0x1a5a5
0+0136 <text_label\+0x136> 8484 8000 	lw	a0,0\(a0\)
			136: R_MICROMIPS_LO12	.data\+0x1a5a5
0+013a <text_label\+0x13a> e080 0000 	lui	a0,0x0
			13a: R_MICROMIPS_HI20	big_external_data_label\+0x1a5a5
0+013e <text_label\+0x13e> 8484 8000 	lw	a0,0\(a0\)
			13e: R_MICROMIPS_LO12	big_external_data_label\+0x1a5a5
0+0142 <text_label\+0x142> 4080 0002 	lw	a0,0\(gp\)
			142: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x1a5a5
0+0146 <text_label\+0x146> e080 0000 	lui	a0,0x0
			146: R_MICROMIPS_HI20	big_external_common\+0x1a5a5
0+014a <text_label\+0x14a> 8484 8000 	lw	a0,0\(a0\)
			14a: R_MICROMIPS_LO12	big_external_common\+0x1a5a5
0+014e <text_label\+0x14e> 4080 0002 	lw	a0,0\(gp\)
			14e: R_MICROMIPS_GPREL19_S2	small_external_common\+0x1a5a5
0+0152 <text_label\+0x152> e080 0000 	lui	a0,0x0
			152: R_MICROMIPS_HI20	.bss\+0x1a5a5
0+0156 <text_label\+0x156> 8484 8000 	lw	a0,0\(a0\)
			156: R_MICROMIPS_LO12	.bss\+0x1a5a5
0+015a <text_label\+0x15a> 4080 0002 	lw	a0,0\(gp\)
			15a: R_MICROMIPS_GPREL19_S2	.sbss\+0x1a5a5
0+015e <text_label\+0x15e> e080 0000 	lui	a0,0x0
			15e: R_MICROMIPS_HI20	.data
0+0162 <text_label\+0x162> 20a4 2150 	addu	a0,a0,a1
0+0166 <text_label\+0x166> 8484 8000 	lw	a0,0\(a0\)
			166: R_MICROMIPS_LO12	.data
0+016a <text_label\+0x16a> e080 0000 	lui	a0,0x0
			16a: R_MICROMIPS_HI20	big_external_data_label
0+016e <text_label\+0x16e> 20a4 2150 	addu	a0,a0,a1
0+0172 <text_label\+0x172> 8484 8000 	lw	a0,0\(a0\)
			172: R_MICROMIPS_LO12	big_external_data_label
0+0176 <text_label\+0x176> e080 0000 	lui	a0,0x0
			176: R_MICROMIPS_HI20	small_external_data_label
0+017a <text_label\+0x17a> 20a4 2150 	addu	a0,a0,a1
0+017e <text_label\+0x17e> 8484 8000 	lw	a0,0\(a0\)
			17e: R_MICROMIPS_LO12	small_external_data_label
0+0182 <text_label\+0x182> e080 0000 	lui	a0,0x0
			182: R_MICROMIPS_HI20	big_external_common
0+0186 <text_label\+0x186> 20a4 2150 	addu	a0,a0,a1
0+018a <text_label\+0x18a> 8484 8000 	lw	a0,0\(a0\)
			18a: R_MICROMIPS_LO12	big_external_common
0+018e <text_label\+0x18e> e080 0000 	lui	a0,0x0
			18e: R_MICROMIPS_HI20	small_external_common
0+0192 <text_label\+0x192> 20a4 2150 	addu	a0,a0,a1
0+0196 <text_label\+0x196> 8484 8000 	lw	a0,0\(a0\)
			196: R_MICROMIPS_LO12	small_external_common
0+019a <text_label\+0x19a> e080 0000 	lui	a0,0x0
			19a: R_MICROMIPS_HI20	.bss
0+019e <text_label\+0x19e> 20a4 2150 	addu	a0,a0,a1
0+01a2 <text_label\+0x1a2> 8484 8000 	lw	a0,0\(a0\)
			1a2: R_MICROMIPS_LO12	.bss
0+01a6 <text_label\+0x1a6> e080 0000 	lui	a0,0x0
			1a6: R_MICROMIPS_HI20	.sbss
0+01aa <text_label\+0x1aa> 20a4 2150 	addu	a0,a0,a1
0+01ae <text_label\+0x1ae> 8484 8000 	lw	a0,0\(a0\)
			1ae: R_MICROMIPS_LO12	.sbss
0+01b2 <text_label\+0x1b2> e080 0000 	lui	a0,0x0
			1b2: R_MICROMIPS_HI20	.data\+0x1
0+01b6 <text_label\+0x1b6> 20a4 2150 	addu	a0,a0,a1
0+01ba <text_label\+0x1ba> 8484 8000 	lw	a0,0\(a0\)
			1ba: R_MICROMIPS_LO12	.data\+0x1
0+01be <text_label\+0x1be> e080 0000 	lui	a0,0x0
			1be: R_MICROMIPS_HI20	big_external_data_label\+0x1
0+01c2 <text_label\+0x1c2> 20a4 2150 	addu	a0,a0,a1
0+01c6 <text_label\+0x1c6> 8484 8000 	lw	a0,0\(a0\)
			1c6: R_MICROMIPS_LO12	big_external_data_label\+0x1
0+01ca <text_label\+0x1ca> e080 0000 	lui	a0,0x0
			1ca: R_MICROMIPS_HI20	small_external_data_label\+0x1
0+01ce <text_label\+0x1ce> 20a4 2150 	addu	a0,a0,a1
0+01d2 <text_label\+0x1d2> 8484 8000 	lw	a0,0\(a0\)
			1d2: R_MICROMIPS_LO12	small_external_data_label\+0x1
0+01d6 <text_label\+0x1d6> e080 0000 	lui	a0,0x0
			1d6: R_MICROMIPS_HI20	big_external_common\+0x1
0+01da <text_label\+0x1da> 20a4 2150 	addu	a0,a0,a1
0+01de <text_label\+0x1de> 8484 8000 	lw	a0,0\(a0\)
			1de: R_MICROMIPS_LO12	big_external_common\+0x1
0+01e2 <text_label\+0x1e2> e080 0000 	lui	a0,0x0
			1e2: R_MICROMIPS_HI20	small_external_common\+0x1
0+01e6 <text_label\+0x1e6> 20a4 2150 	addu	a0,a0,a1
0+01ea <text_label\+0x1ea> 8484 8000 	lw	a0,0\(a0\)
			1ea: R_MICROMIPS_LO12	small_external_common\+0x1
0+01ee <text_label\+0x1ee> e080 0000 	lui	a0,0x0
			1ee: R_MICROMIPS_HI20	.bss\+0x1
0+01f2 <text_label\+0x1f2> 20a4 2150 	addu	a0,a0,a1
0+01f6 <text_label\+0x1f6> 8484 8000 	lw	a0,0\(a0\)
			1f6: R_MICROMIPS_LO12	.bss\+0x1
0+01fa <text_label\+0x1fa> e080 0000 	lui	a0,0x0
			1fa: R_MICROMIPS_HI20	.sbss\+0x1
0+01fe <text_label\+0x1fe> 20a4 2150 	addu	a0,a0,a1
0+0202 <text_label\+0x202> 8484 8000 	lw	a0,0\(a0\)
			202: R_MICROMIPS_LO12	.sbss\+0x1
0+0206 <text_label\+0x206> e080 0000 	lui	a0,0x0
			206: R_MICROMIPS_HI20	.data\+0x800
0+020a <text_label\+0x20a> 20a4 2150 	addu	a0,a0,a1
0+020e <text_label\+0x20e> 8484 8000 	lw	a0,0\(a0\)
			20e: R_MICROMIPS_LO12	.data\+0x800
0+0212 <text_label\+0x212> e080 0000 	lui	a0,0x0
			212: R_MICROMIPS_HI20	big_external_data_label\+0x800
0+0216 <text_label\+0x216> 20a4 2150 	addu	a0,a0,a1
0+021a <text_label\+0x21a> 8484 8000 	lw	a0,0\(a0\)
			21a: R_MICROMIPS_LO12	big_external_data_label\+0x800
0+021e <text_label\+0x21e> e080 0000 	lui	a0,0x0
			21e: R_MICROMIPS_HI20	small_external_data_label\+0x800
0+0222 <text_label\+0x222> 20a4 2150 	addu	a0,a0,a1
0+0226 <text_label\+0x226> 8484 8000 	lw	a0,0\(a0\)
			226: R_MICROMIPS_LO12	small_external_data_label\+0x800
0+022a <text_label\+0x22a> e080 0000 	lui	a0,0x0
			22a: R_MICROMIPS_HI20	big_external_common\+0x800
0+022e <text_label\+0x22e> 20a4 2150 	addu	a0,a0,a1
0+0232 <text_label\+0x232> 8484 8000 	lw	a0,0\(a0\)
			232: R_MICROMIPS_LO12	big_external_common\+0x800
0+0236 <text_label\+0x236> e080 0000 	lui	a0,0x0
			236: R_MICROMIPS_HI20	small_external_common\+0x800
0+023a <text_label\+0x23a> 20a4 2150 	addu	a0,a0,a1
0+023e <text_label\+0x23e> 8484 8000 	lw	a0,0\(a0\)
			23e: R_MICROMIPS_LO12	small_external_common\+0x800
0+0242 <text_label\+0x242> e080 0000 	lui	a0,0x0
			242: R_MICROMIPS_HI20	.bss\+0x800
0+0246 <text_label\+0x246> 20a4 2150 	addu	a0,a0,a1
0+024a <text_label\+0x24a> 8484 8000 	lw	a0,0\(a0\)
			24a: R_MICROMIPS_LO12	.bss\+0x800
0+024e <text_label\+0x24e> e080 0000 	lui	a0,0x0
			24e: R_MICROMIPS_HI20	.sbss\+0x800
0+0252 <text_label\+0x252> 20a4 2150 	addu	a0,a0,a1
0+0256 <text_label\+0x256> 8484 8000 	lw	a0,0\(a0\)
			256: R_MICROMIPS_LO12	.sbss\+0x800
0+025a <text_label\+0x25a> e080 0000 	lui	a0,0x0
			25a: R_MICROMIPS_HI20	.data-0x800
0+025e <text_label\+0x25e> 20a4 2150 	addu	a0,a0,a1
0+0262 <text_label\+0x262> 8484 8000 	lw	a0,0\(a0\)
			262: R_MICROMIPS_LO12	.data-0x800
0+0266 <text_label\+0x266> e080 0000 	lui	a0,0x0
			266: R_MICROMIPS_HI20	big_external_data_label-0x800
0+026a <text_label\+0x26a> 20a4 2150 	addu	a0,a0,a1
0+026e <text_label\+0x26e> 8484 8000 	lw	a0,0\(a0\)
			26e: R_MICROMIPS_LO12	big_external_data_label-0x800
0+0272 <text_label\+0x272> e080 0000 	lui	a0,0x0
			272: R_MICROMIPS_HI20	small_external_data_label-0x800
0+0276 <text_label\+0x276> 20a4 2150 	addu	a0,a0,a1
0+027a <text_label\+0x27a> 8484 8000 	lw	a0,0\(a0\)
			27a: R_MICROMIPS_LO12	small_external_data_label-0x800
0+027e <text_label\+0x27e> e080 0000 	lui	a0,0x0
			27e: R_MICROMIPS_HI20	big_external_common-0x800
0+0282 <text_label\+0x282> 20a4 2150 	addu	a0,a0,a1
0+0286 <text_label\+0x286> 8484 8000 	lw	a0,0\(a0\)
			286: R_MICROMIPS_LO12	big_external_common-0x800
0+028a <text_label\+0x28a> e080 0000 	lui	a0,0x0
			28a: R_MICROMIPS_HI20	small_external_common-0x800
0+028e <text_label\+0x28e> 20a4 2150 	addu	a0,a0,a1
0+0292 <text_label\+0x292> 8484 8000 	lw	a0,0\(a0\)
			292: R_MICROMIPS_LO12	small_external_common-0x800
0+0296 <text_label\+0x296> e080 0000 	lui	a0,0x0
			296: R_MICROMIPS_HI20	.bss-0x800
0+029a <text_label\+0x29a> 20a4 2150 	addu	a0,a0,a1
0+029e <text_label\+0x29e> 8484 8000 	lw	a0,0\(a0\)
			29e: R_MICROMIPS_LO12	.bss-0x800
0+02a2 <text_label\+0x2a2> e080 0000 	lui	a0,0x0
			2a2: R_MICROMIPS_HI20	.sbss-0x800
0+02a6 <text_label\+0x2a6> 20a4 2150 	addu	a0,a0,a1
0+02aa <text_label\+0x2aa> 8484 8000 	lw	a0,0\(a0\)
			2aa: R_MICROMIPS_LO12	.sbss-0x800
0+02ae <text_label\+0x2ae> e080 0000 	lui	a0,0x0
			2ae: R_MICROMIPS_HI20	.data\+0x1000
0+02b2 <text_label\+0x2b2> 20a4 2150 	addu	a0,a0,a1
0+02b6 <text_label\+0x2b6> 8484 8000 	lw	a0,0\(a0\)
			2b6: R_MICROMIPS_LO12	.data\+0x1000
0+02ba <text_label\+0x2ba> e080 0000 	lui	a0,0x0
			2ba: R_MICROMIPS_HI20	big_external_data_label\+0x1000
0+02be <text_label\+0x2be> 20a4 2150 	addu	a0,a0,a1
0+02c2 <text_label\+0x2c2> 8484 8000 	lw	a0,0\(a0\)
			2c2: R_MICROMIPS_LO12	big_external_data_label\+0x1000
0+02c6 <text_label\+0x2c6> e080 0000 	lui	a0,0x0
			2c6: R_MICROMIPS_HI20	small_external_data_label\+0x1000
0+02ca <text_label\+0x2ca> 20a4 2150 	addu	a0,a0,a1
0+02ce <text_label\+0x2ce> 8484 8000 	lw	a0,0\(a0\)
			2ce: R_MICROMIPS_LO12	small_external_data_label\+0x1000
0+02d2 <text_label\+0x2d2> e080 0000 	lui	a0,0x0
			2d2: R_MICROMIPS_HI20	big_external_common\+0x1000
0+02d6 <text_label\+0x2d6> 20a4 2150 	addu	a0,a0,a1
0+02da <text_label\+0x2da> 8484 8000 	lw	a0,0\(a0\)
			2da: R_MICROMIPS_LO12	big_external_common\+0x1000
0+02de <text_label\+0x2de> e080 0000 	lui	a0,0x0
			2de: R_MICROMIPS_HI20	small_external_common\+0x1000
0+02e2 <text_label\+0x2e2> 20a4 2150 	addu	a0,a0,a1
0+02e6 <text_label\+0x2e6> 8484 8000 	lw	a0,0\(a0\)
			2e6: R_MICROMIPS_LO12	small_external_common\+0x1000
0+02ea <text_label\+0x2ea> e080 0000 	lui	a0,0x0
			2ea: R_MICROMIPS_HI20	.bss\+0x1000
0+02ee <text_label\+0x2ee> 20a4 2150 	addu	a0,a0,a1
0+02f2 <text_label\+0x2f2> 8484 8000 	lw	a0,0\(a0\)
			2f2: R_MICROMIPS_LO12	.bss\+0x1000
0+02f6 <text_label\+0x2f6> e080 0000 	lui	a0,0x0
			2f6: R_MICROMIPS_HI20	.sbss\+0x1000
0+02fa <text_label\+0x2fa> 20a4 2150 	addu	a0,a0,a1
0+02fe <text_label\+0x2fe> 8484 8000 	lw	a0,0\(a0\)
			2fe: R_MICROMIPS_LO12	.sbss\+0x1000
0+0302 <text_label\+0x302> e080 0000 	lui	a0,0x0
			302: R_MICROMIPS_HI20	.data\+0x1a5a5
0+0306 <text_label\+0x306> 20a4 2150 	addu	a0,a0,a1
0+030a <text_label\+0x30a> 8484 8000 	lw	a0,0\(a0\)
			30a: R_MICROMIPS_LO12	.data\+0x1a5a5
0+030e <text_label\+0x30e> e080 0000 	lui	a0,0x0
			30e: R_MICROMIPS_HI20	big_external_data_label\+0x1a5a5
0+0312 <text_label\+0x312> 20a4 2150 	addu	a0,a0,a1
0+0316 <text_label\+0x316> 8484 8000 	lw	a0,0\(a0\)
			316: R_MICROMIPS_LO12	big_external_data_label\+0x1a5a5
0+031a <text_label\+0x31a> e080 0000 	lui	a0,0x0
			31a: R_MICROMIPS_HI20	small_external_data_label\+0x1a5a5
0+031e <text_label\+0x31e> 20a4 2150 	addu	a0,a0,a1
0+0322 <text_label\+0x322> 8484 8000 	lw	a0,0\(a0\)
			322: R_MICROMIPS_LO12	small_external_data_label\+0x1a5a5
0+0326 <text_label\+0x326> e080 0000 	lui	a0,0x0
			326: R_MICROMIPS_HI20	big_external_common\+0x1a5a5
0+032a <text_label\+0x32a> 20a4 2150 	addu	a0,a0,a1
0+032e <text_label\+0x32e> 8484 8000 	lw	a0,0\(a0\)
			32e: R_MICROMIPS_LO12	big_external_common\+0x1a5a5
0+0332 <text_label\+0x332> e080 0000 	lui	a0,0x0
			332: R_MICROMIPS_HI20	small_external_common\+0x1a5a5
0+0336 <text_label\+0x336> 20a4 2150 	addu	a0,a0,a1
0+033a <text_label\+0x33a> 8484 8000 	lw	a0,0\(a0\)
			33a: R_MICROMIPS_LO12	small_external_common\+0x1a5a5
0+033e <text_label\+0x33e> e080 0000 	lui	a0,0x0
			33e: R_MICROMIPS_HI20	.bss\+0x1a5a5
0+0342 <text_label\+0x342> 20a4 2150 	addu	a0,a0,a1
0+0346 <text_label\+0x346> 8484 8000 	lw	a0,0\(a0\)
			346: R_MICROMIPS_LO12	.bss\+0x1a5a5
0+034a <text_label\+0x34a> e080 0000 	lui	a0,0x0
			34a: R_MICROMIPS_HI20	.sbss\+0x1a5a5
0+034e <text_label\+0x34e> 20a4 2150 	addu	a0,a0,a1
0+0352 <text_label\+0x352> 8484 8000 	lw	a0,0\(a0\)
			352: R_MICROMIPS_LO12	.sbss\+0x1a5a5
0+0356 <text_label\+0x356> 9008      	nop
	...
#pass