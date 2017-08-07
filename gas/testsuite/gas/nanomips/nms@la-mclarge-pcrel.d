#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS PC-relative la without li[48] for large memory model
#as: -mlegacyregs -mpcrel
#source: la.s

# Test the la macro PC-relative expansion for mcmodel=large

.*: +file format .*nanomips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> 0080 0000 	li	a0,0
[0-9a-f]+ <[^>]+> 0080 0001 	li	a0,1
[0-9a-f]+ <[^>]+> 0080 8000 	li	a0,32768
[0-9a-f]+ <[^>]+> e09f 8ffd 	lui	a0,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> e081 0000 	lui	a0,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> e081 a000 	lui	a0,%hi\(0x1a000\)
[0-9a-f]+ <[^>]+> 8084 05a5 	ori	a0,a0,1445
[0-9a-f]+ <[^>]+> 0085 0000 	addiu	a0,a1,0
[0-9a-f]+ <[^>]+> 0085 0001 	addiu	a0,a1,1
[0-9a-f]+ <[^>]+> 0085 8000 	addiu	a0,a1,32768
[0-9a-f]+ <[^>]+> e09f 8ffd 	lui	a0,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e081 0000 	lui	a0,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e081 a000 	lui	a0,%hi\(0x1a000\)
[0-9a-f]+ <[^>]+> 8084 05a5 	ori	a0,a0,1445
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			44: R_NANOMIPS_PCHI20	data_label
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			48: R_NANOMIPS_LO12	.data
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			4c: R_NANOMIPS_PCHI20	big_external_data_label
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			50: R_NANOMIPS_LO12	big_external_data_label
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			54: R_NANOMIPS_PCHI20	small_external_data_label
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			58: R_NANOMIPS_LO12	small_external_data_label
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			5c: R_NANOMIPS_PCHI20	big_external_common
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			60: R_NANOMIPS_LO12	big_external_common
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			64: R_NANOMIPS_PCHI20	small_external_common
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			68: R_NANOMIPS_LO12	small_external_common
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			6c: R_NANOMIPS_PCHI20	big_local_common
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			70: R_NANOMIPS_LO12	.bss
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			74: R_NANOMIPS_PCHI20	small_local_common
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			78: R_NANOMIPS_LO12	.sbss
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			7c: R_NANOMIPS_PCHI20	data_label\+0x1
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			80: R_NANOMIPS_LO12	.data\+0x1
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			84: R_NANOMIPS_PCHI20	big_external_data_label\+0x1
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			88: R_NANOMIPS_LO12	big_external_data_label\+0x1
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			8c: R_NANOMIPS_PCHI20	small_external_data_label\+0x1
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			90: R_NANOMIPS_LO12	small_external_data_label\+0x1
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			94: R_NANOMIPS_PCHI20	big_external_common\+0x1
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			98: R_NANOMIPS_LO12	big_external_common\+0x1
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			9c: R_NANOMIPS_PCHI20	small_external_common\+0x1
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			a0: R_NANOMIPS_LO12	small_external_common\+0x1
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			a4: R_NANOMIPS_PCHI20	big_local_common\+0x1
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			a8: R_NANOMIPS_LO12	.bss\+0x1
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			ac: R_NANOMIPS_PCHI20	small_local_common\+0x1
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			b0: R_NANOMIPS_LO12	.sbss\+0x1
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			b4: R_NANOMIPS_PCHI20	data_label\+0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			b8: R_NANOMIPS_LO12	.data\+0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			bc: R_NANOMIPS_PCHI20	big_external_data_label\+0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			c0: R_NANOMIPS_LO12	big_external_data_label\+0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			c4: R_NANOMIPS_PCHI20	small_external_data_label\+0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			c8: R_NANOMIPS_LO12	small_external_data_label\+0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			cc: R_NANOMIPS_PCHI20	big_external_common\+0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			d0: R_NANOMIPS_LO12	big_external_common\+0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			d4: R_NANOMIPS_PCHI20	small_external_common\+0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			d8: R_NANOMIPS_LO12	small_external_common\+0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			dc: R_NANOMIPS_PCHI20	big_local_common\+0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			e0: R_NANOMIPS_LO12	.bss\+0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			e4: R_NANOMIPS_PCHI20	small_local_common\+0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			e8: R_NANOMIPS_LO12	.sbss\+0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			ec: R_NANOMIPS_PCHI20	data_label-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			f0: R_NANOMIPS_LO12	.data-0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			f4: R_NANOMIPS_PCHI20	big_external_data_label-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			f8: R_NANOMIPS_LO12	big_external_data_label-0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			fc: R_NANOMIPS_PCHI20	small_external_data_label-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			100: R_NANOMIPS_LO12	small_external_data_label-0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			104: R_NANOMIPS_PCHI20	big_external_common-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			108: R_NANOMIPS_LO12	big_external_common-0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			10c: R_NANOMIPS_PCHI20	small_external_common-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			110: R_NANOMIPS_LO12	small_external_common-0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			114: R_NANOMIPS_PCHI20	big_local_common-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			118: R_NANOMIPS_LO12	.bss-0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			11c: R_NANOMIPS_PCHI20	small_local_common-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			120: R_NANOMIPS_LO12	.sbss-0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			124: R_NANOMIPS_PCHI20	data_label\+0x10000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			128: R_NANOMIPS_LO12	.data\+0x10000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			12c: R_NANOMIPS_PCHI20	big_external_data_label\+0x10000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			130: R_NANOMIPS_LO12	big_external_data_label\+0x10000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			134: R_NANOMIPS_PCHI20	small_external_data_label\+0x10000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			138: R_NANOMIPS_LO12	small_external_data_label\+0x10000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			13c: R_NANOMIPS_PCHI20	big_external_common\+0x10000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			140: R_NANOMIPS_LO12	big_external_common\+0x10000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			144: R_NANOMIPS_PCHI20	small_external_common\+0x10000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			148: R_NANOMIPS_LO12	small_external_common\+0x10000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			14c: R_NANOMIPS_PCHI20	big_local_common\+0x10000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			150: R_NANOMIPS_LO12	.bss\+0x10000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			154: R_NANOMIPS_PCHI20	small_local_common\+0x10000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			158: R_NANOMIPS_LO12	.sbss\+0x10000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			15c: R_NANOMIPS_PCHI20	data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			160: R_NANOMIPS_LO12	.data\+0x1a5a5
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			164: R_NANOMIPS_PCHI20	big_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			168: R_NANOMIPS_LO12	big_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			16c: R_NANOMIPS_PCHI20	small_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			170: R_NANOMIPS_LO12	small_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			174: R_NANOMIPS_PCHI20	big_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			178: R_NANOMIPS_LO12	big_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			17c: R_NANOMIPS_PCHI20	small_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			180: R_NANOMIPS_LO12	small_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			184: R_NANOMIPS_PCHI20	big_local_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			188: R_NANOMIPS_LO12	.bss\+0x1a5a5
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			18c: R_NANOMIPS_PCHI20	small_local_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			190: R_NANOMIPS_LO12	.sbss\+0x1a5a5
[0-9a-f]+ <[^>]+> 0085 0000 	addiu	a0,a1,0
[0-9a-f]+ <[^>]+> e092 3000 	lui	a0,%hi\(0x123000\)
[0-9a-f]+ <[^>]+> 8084 0456 	ori	a0,a0,1110
[0-9a-f]+ <[^>]+> e092 3000 	lui	a0,%hi\(0x123000\)
[0-9a-f]+ <[^>]+> 8084 0456 	ori	a0,a0,1110
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			1ac: R_NANOMIPS_PCHI20	big_external_data_label
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			1b0: R_NANOMIPS_LO12	big_external_data_label
	...
