#objdump: -dr --prefix-addresses
#as: -32 --defsym tsdc1=1 --defsym forward=1
#name: MIPS R7 sdc1 forward
#source: ld.s

dump.o:     file format elf32-tradbigmips

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(zero\)
[0-9a-f]+ <[^>]+> sdc1	\$f4,1\(zero\)
[0-9a-f]+ <[^>]+> sdc1	\$f4,4092\(zero\)
[0-9a-f]+ <[^>]+> li	at,-4092
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
[0-9a-f]+ <[^>]+> li	at,4096
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
[0-9a-f]+ <[^>]+> lui	at,%hi\(0x1a000\)
[0-9a-f]+ <[^>]+> sdc1	\$f4,1445\(at\)
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(a1\)
[0-9a-f]+ <[^>]+> sdc1	\$f4,1\(a1\)
[0-9a-f]+ <[^>]+> sdc1	\$f4,4092\(a1\)
[0-9a-f]+ <[^>]+> addiu	at,a1,-4092
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
[0-9a-f]+ <[^>]+> addiu	at,a1,4096
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
[0-9a-f]+ <[^>]+> lui	at,%hi\(0x1a000\)
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,1445\(at\)
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.data
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.data
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_data_label
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_data_label
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GPREL16_S2	small_external_data_label
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_common
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_common
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GPREL16_S2	small_external_common
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.bss
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.bss
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GPREL16_S2	.sbss
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.data\+0x1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.data\+0x1
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_data_label\+0x1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_data_label\+0x1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GPREL16_S2	small_external_data_label\+0x1
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_common\+0x1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_common\+0x1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GPREL16_S2	small_external_common\+0x1
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.bss\+0x1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.bss\+0x1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GPREL16_S2	.sbss\+0x1
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.data\+0xffc
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.data\+0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_data_label\+0xffc
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_data_label\+0xffc
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GPREL16_S2	small_external_data_label\+0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_common\+0xffc
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_common\+0xffc
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GPREL16_S2	small_external_common\+0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.bss\+0xffc
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.bss\+0xffc
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GPREL16_S2	.sbss\+0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.data-0xffc
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.data-0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_data_label-0xffc
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_data_label-0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	small_external_data_label-0xffc
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	small_external_data_label-0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_common-0xffc
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_common-0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	small_external_common-0xffc
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	small_external_common-0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.bss-0xffc
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.bss-0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.sbss-0xffc
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.sbss-0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.data\+0x1000
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.data\+0x1000
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_data_label\+0x1000
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_data_label\+0x1000
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GPREL16_S2	small_external_data_label\+0x1000
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_common\+0x1000
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_common\+0x1000
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GPREL16_S2	small_external_common\+0x1000
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.bss\+0x1000
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.bss\+0x1000
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GPREL16_S2	.sbss\+0x1000
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.data\+0x1a5a5
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.data\+0x1a5a5
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GPREL16_S2	small_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GPREL16_S2	small_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.bss\+0x1a5a5
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.bss\+0x1a5a5
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GPREL16_S2	.sbss\+0x1a5a5
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.data
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.data
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_data_label
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_data_label
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	small_external_data_label
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	small_external_data_label
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_common
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_common
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	small_external_common
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	small_external_common
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.bss
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.bss
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.sbss
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.sbss
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.data\+0x1
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.data\+0x1
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_data_label\+0x1
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_data_label\+0x1
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	small_external_data_label\+0x1
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	small_external_data_label\+0x1
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_common\+0x1
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_common\+0x1
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	small_external_common\+0x1
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	small_external_common\+0x1
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.bss\+0x1
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.bss\+0x1
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.sbss\+0x1
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.sbss\+0x1
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.data\+0xffc
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.data\+0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_data_label\+0xffc
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_data_label\+0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	small_external_data_label\+0xffc
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	small_external_data_label\+0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_common\+0xffc
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_common\+0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	small_external_common\+0xffc
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	small_external_common\+0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.bss\+0xffc
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.bss\+0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.sbss\+0xffc
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.sbss\+0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.data-0xffc
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.data-0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_data_label-0xffc
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_data_label-0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	small_external_data_label-0xffc
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	small_external_data_label-0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_common-0xffc
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_common-0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	small_external_common-0xffc
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	small_external_common-0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.bss-0xffc
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.bss-0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.sbss-0xffc
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.sbss-0xffc
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.data\+0x1000
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.data\+0x1000
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_data_label\+0x1000
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_data_label\+0x1000
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	small_external_data_label\+0x1000
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	small_external_data_label\+0x1000
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_common\+0x1000
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_common\+0x1000
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	small_external_common\+0x1000
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	small_external_common\+0x1000
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.bss\+0x1000
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.bss\+0x1000
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.sbss\+0x1000
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.sbss\+0x1000
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.data\+0x1a5a5
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.data\+0x1a5a5
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	small_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	small_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	big_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	big_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	small_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	small_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.bss\+0x1a5a5
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.bss\+0x1a5a5
[0-9a-f]+ <[^>]+> lui	at,0x0
			[0-9a-f]+: R_MICROMIPS_HI20	.sbss\+0x1a5a5
[0-9a-f]+ <[^>]+> addu	at,at,a1
[0-9a-f]+ <[^>]+> sdc1	\$f4,0\(at\)
			[0-9a-f]+: R_MICROMIPS_LO12	.sbss\+0x1a5a5
	\.\.\.
#pass
