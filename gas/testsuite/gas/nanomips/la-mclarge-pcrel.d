#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS PC-relative la using li[48] for large memory model
#source: la.s
#as: -mlegacyregs -mpcrel

# Test the la macro PC-relative expansion for mcmodel=large

.*: +file format .*nanomips.*

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
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			4e: R_NANOMIPS_PC_I32	small_external_data_label
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			54: R_NANOMIPS_PC_I32	big_external_common
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			5a: R_NANOMIPS_PC_I32	small_external_common
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			60: R_NANOMIPS_PC_I32	big_local_common
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			66: R_NANOMIPS_PC_I32	small_local_common
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			6c: R_NANOMIPS_PC_I32	data_label\+0x1
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			72: R_NANOMIPS_PC_I32	big_external_data_label\+0x1
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			78: R_NANOMIPS_PC_I32	small_external_data_label\+0x1
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			7e: R_NANOMIPS_PC_I32	big_external_common\+0x1
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			84: R_NANOMIPS_PC_I32	small_external_common\+0x1
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			8a: R_NANOMIPS_PC_I32	big_local_common\+0x1
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			90: R_NANOMIPS_PC_I32	small_local_common\+0x1
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			96: R_NANOMIPS_PC_I32	data_label\+0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			9c: R_NANOMIPS_PC_I32	big_external_data_label\+0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			a2: R_NANOMIPS_PC_I32	small_external_data_label\+0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			a8: R_NANOMIPS_PC_I32	big_external_common\+0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			ae: R_NANOMIPS_PC_I32	small_external_common\+0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			b4: R_NANOMIPS_PC_I32	big_local_common\+0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			ba: R_NANOMIPS_PC_I32	small_local_common\+0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			c0: R_NANOMIPS_PC_I32	data_label-0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			c6: R_NANOMIPS_PC_I32	big_external_data_label-0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			cc: R_NANOMIPS_PC_I32	small_external_data_label-0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			d2: R_NANOMIPS_PC_I32	big_external_common-0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			d8: R_NANOMIPS_PC_I32	small_external_common-0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			de: R_NANOMIPS_PC_I32	big_local_common-0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			e4: R_NANOMIPS_PC_I32	small_local_common-0x8000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			ea: R_NANOMIPS_PC_I32	data_label\+0x10000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			f0: R_NANOMIPS_PC_I32	big_external_data_label\+0x10000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			f6: R_NANOMIPS_PC_I32	small_external_data_label\+0x10000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			fc: R_NANOMIPS_PC_I32	big_external_common\+0x10000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			102: R_NANOMIPS_PC_I32	small_external_common\+0x10000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			108: R_NANOMIPS_PC_I32	big_local_common\+0x10000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			10e: R_NANOMIPS_PC_I32	small_local_common\+0x10000
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			114: R_NANOMIPS_PC_I32	data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			11a: R_NANOMIPS_PC_I32	big_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			120: R_NANOMIPS_PC_I32	small_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			126: R_NANOMIPS_PC_I32	big_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			12c: R_NANOMIPS_PC_I32	small_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			132: R_NANOMIPS_PC_I32	big_local_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			138: R_NANOMIPS_PC_I32	small_local_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 0085 0000 	addiu	a0,a1,0
[0-9a-f]+ <[^>]+> 6080 3456 0012 	li	a0,0x123456
[0-9a-f]+ <[^>]+> 6080 3456 0012 	li	a0,0x123456
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6083 0000 0000 	lapc	a0,[0-9a-f]+ <[^>]+>
			152: R_NANOMIPS_PC_I32	big_external_data_label
	...
[0-9a-f]+ <[^>]+> 9008      	nop
