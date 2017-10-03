#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS la using li[48] PC-relative
#as: -mlegacyregs -mpcrel
#source: la.s

# Test PC-relative expansion of the la macro.

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> 0080 0000 	li	a0,0
[0-9a-f]+ <[^>]+> 0080 0001 	li	a0,1
[0-9a-f]+ <[^>]+> 0080 8000 	li	a0,32768
[0-9a-f]+ <[^>]+> e09f 8ffd 	lui	a0,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> e081 0000 	lui	a0,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> 6080 a5a5 0001 	li	a0,0x1a5a5
[0-9a-f]+ <[^>]+> 0085 0000 	addiu	a0,a1,0
[0-9a-f]+ <[^>]+> 0085 0001 	addiu	a0,a1,1
[0-9a-f]+ <[^>]+> 0085 8000 	addiu	a0,a1,32768
[0-9a-f]+ <[^>]+> e09f 8ffd 	lui	a0,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e081 0000 	lui	a0,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 a5a5 0001 	li	a0,0x1a5a5
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			42: R_NANOMIPS_PC_I32	data_label
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			48: R_NANOMIPS_PC_I32	big_external_data_label
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			4c: R_NANOMIPS_GPREL19_S2	small_external_data_label
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			52: R_NANOMIPS_PC_I32	big_external_common
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			56: R_NANOMIPS_GPREL19_S2	small_external_common
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			5c: R_NANOMIPS_PC_I32	big_local_common
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			60: R_NANOMIPS_GPREL19_S2	.sbss
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			66: R_NANOMIPS_PC_I32	data_label\+0x1
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			6c: R_NANOMIPS_PC_I32	big_external_data_label\+0x1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			70: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			76: R_NANOMIPS_PC_I32	big_external_common\+0x1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			7a: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			80: R_NANOMIPS_PC_I32	big_local_common\+0x1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			84: R_NANOMIPS_GPREL19_S2	.sbss\+0x1
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			8a: R_NANOMIPS_PC_I32	data_label\+0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			90: R_NANOMIPS_PC_I32	big_external_data_label\+0x8000
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			94: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			9a: R_NANOMIPS_PC_I32	big_external_common\+0x8000
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			9e: R_NANOMIPS_GPREL19_S2	small_external_common\+0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			a4: R_NANOMIPS_PC_I32	big_local_common\+0x8000
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			a8: R_NANOMIPS_GPREL19_S2	.sbss\+0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			ae: R_NANOMIPS_PC_I32	data_label-0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			b4: R_NANOMIPS_PC_I32	big_external_data_label-0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			ba: R_NANOMIPS_PC_I32	small_external_data_label-0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			c0: R_NANOMIPS_PC_I32	big_external_common-0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			c6: R_NANOMIPS_PC_I32	small_external_common-0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			cc: R_NANOMIPS_PC_I32	big_local_common-0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			d2: R_NANOMIPS_PC_I32	small_local_common-0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			d8: R_NANOMIPS_PC_I32	data_label\+0x10000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			de: R_NANOMIPS_PC_I32	big_external_data_label\+0x10000
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			e2: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x10000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			e8: R_NANOMIPS_PC_I32	big_external_common\+0x10000
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			ec: R_NANOMIPS_GPREL19_S2	small_external_common\+0x10000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			f2: R_NANOMIPS_PC_I32	big_local_common\+0x10000
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			f6: R_NANOMIPS_GPREL19_S2	.sbss\+0x10000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			fc: R_NANOMIPS_PC_I32	data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			102: R_NANOMIPS_PC_I32	big_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			106: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			10c: R_NANOMIPS_PC_I32	big_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			110: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			116: R_NANOMIPS_PC_I32	big_local_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			11a: R_NANOMIPS_GPREL19_S2	.sbss\+0x1a5a5
[0-9a-f]+ <[^>]+> 0085 0000 	addiu	a0,a1,0
[0-9a-f]+ <[^>]+> 6080 3456 0012 	li	a0,0x123456
[0-9a-f]+ <[^>]+> 6080 3456 0012 	li	a0,0x123456
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			134: R_NANOMIPS_PC_I32	big_external_data_label
	...
