#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS R7 la using li[48]
#as: -32 -mips32r7 -mmicromips
#source: la.s

# Test the la macro.

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
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.data
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_data_label
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	small_external_data_label
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_common
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	small_external_common
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.bss
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	\.sbss
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.data\+0x1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_data_label\+0x1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_common\+0x1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	small_external_common\+0x1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.bss\+0x1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	\.sbss\+0x1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.data\+0x8000
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_data_label\+0x8000
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x8000
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_common\+0x8000
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	small_external_common\+0x8000
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.bss\+0x8000
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	\.sbss\+0x8000
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.data-0x8000
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_data_label-0x8000
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	small_external_data_label-0x8000
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_common-0x8000
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	small_external_common-0x8000
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.bss-0x8000
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.sbss-0x8000
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.data\+0x10000
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_data_label\+0x10000
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x10000
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_common\+0x10000
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	small_external_common\+0x10000
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.bss\+0x10000
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	\.sbss\+0x10000
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.data\+0x1a5a5
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	small_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.bss\+0x1a5a5
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	\.sbss\+0x1a5a5
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.data
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_data_label
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	small_external_data_label
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_common
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	small_external_common
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.bss
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	\.sbss
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.data\+0x1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_data_label\+0x1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_common\+0x1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	small_external_common\+0x1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.bss\+0x1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	\.sbss\+0x1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.data\+0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_data_label\+0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_common\+0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	small_external_common\+0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.bss\+0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	\.sbss\+0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.data-0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_data_label-0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	small_external_data_label-0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_common-0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	small_external_common-0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.bss-0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.sbss-0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.data\+0x10000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_data_label\+0x10000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x10000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_common\+0x10000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	small_external_common\+0x10000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.bss\+0x10000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	\.sbss\+0x10000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.data\+0x1a5a5
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	small_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	small_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	\.bss\+0x1a5a5
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_MICROMIPS_GPREL19_S2	\.sbss\+0x1a5a5
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 0085 0000 	addiu	a0,a1,0
[0-9a-f]+ <[^>]+> 6080 3456 0012 	li	a0,0x123456
[0-9a-f]+ <[^>]+> 6080 3456 0012 	li	a0,0x123456
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_data_label
[0-9a-f]+ <[^>]+> 6080 0000 0000 	li	a0,0x0
			[0-9a-f]+: R_MICROMIPS_32	big_external_data_label
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
	\.\.\.
