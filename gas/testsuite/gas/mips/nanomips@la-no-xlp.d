#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS la without li[48]
#as:
#source: la.s

# Test the la macro.

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <text_label> 0080 0000 	li	a0,0
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
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.data
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.data
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_data_label
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_data_label
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_common
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_common
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.bss
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.data\+0x1
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.data\+0x1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_data_label\+0x1
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_data_label\+0x1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_common\+0x1
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_common\+0x1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.bss\+0x1
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss\+0x1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.data\+0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.data\+0x8000
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_data_label\+0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_data_label\+0x8000
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x8000
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_common\+0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_common\+0x8000
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x8000
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.bss\+0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss\+0x8000
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x8000
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.data-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.data-0x8000
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_data_label-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_data_label-0x8000
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	small_external_data_label-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	small_external_data_label-0x8000
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_common-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_common-0x8000
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	small_external_common-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	small_external_common-0x8000
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.bss-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss-0x8000
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.sbss-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.sbss-0x8000
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.data\+0x10000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.data\+0x10000
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_data_label\+0x10000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_data_label\+0x10000
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x10000
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_common\+0x10000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_common\+0x10000
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x10000
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.bss\+0x10000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss\+0x10000
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x10000
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.data\+0x1a5a5
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.data\+0x1a5a5
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.bss\+0x1a5a5
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss\+0x1a5a5
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x1a5a5
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.data
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.data
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_data_label
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_data_label
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_common
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_common
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.bss
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.data\+0x1
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.data\+0x1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_data_label\+0x1
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_data_label\+0x1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_common\+0x1
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_common\+0x1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.bss\+0x1
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss\+0x1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.data\+0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.data\+0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_data_label\+0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_data_label\+0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_common\+0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_common\+0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.bss\+0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss\+0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.data-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.data-0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_data_label-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_data_label-0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	small_external_data_label-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	small_external_data_label-0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_common-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_common-0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	small_external_common-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	small_external_common-0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.bss-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss-0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.sbss-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.sbss-0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.data\+0x10000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.data\+0x10000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_data_label\+0x10000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_data_label\+0x10000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x10000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_common\+0x10000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_common\+0x10000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x10000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.bss\+0x10000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss\+0x10000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x10000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.data\+0x1a5a5
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.data\+0x1a5a5
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.bss\+0x1a5a5
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss\+0x1a5a5
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x1a5a5
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 0085 0000 	addiu	a0,a1,0
[0-9a-f]+ <[^>]+> e092 3000 	lui	a0,%hi\(0x123000\)
[0-9a-f]+ <[^>]+> 8084 0456 	ori	a0,a0,1110
[0-9a-f]+ <[^>]+> e092 3000 	lui	a0,%hi\(0x123000\)
[0-9a-f]+ <[^>]+> 8084 0456 	ori	a0,a0,1110
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_data_label
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_data_label
[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_data_label
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_data_label
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
	\.\.\.
