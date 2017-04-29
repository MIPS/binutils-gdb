#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPSR7 la-svr4pic
#as: -KPIC --defsym KPIC=1
#source: la.s

# Test the la macro with -KPIC.

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> 0080 0000 	li	a0,0
[0-9a-f]+ <[^>]+> 0080 0001 	li	a0,1
[0-9a-f]+ <[^>]+> 0080 8000 	li	a0,32768
[0-9a-f]+ <[^>]+> e09f 8ffd 	lui	a0,0xffff8
[0-9a-f]+ <[^>]+> e081 0000 	lui	a0,0x10
[0-9a-f]+ <[^>]+> e081 a000 	lui	a0,0x1a
[0-9a-f]+ <[^>]+> 8084 05a5 	ori	a0,a0,1445
[0-9a-f]+ <[^>]+> 0085 0000 	addiu	a0,a1,0
[0-9a-f]+ <[^>]+> 0085 0001 	addiu	a0,a1,1
[0-9a-f]+ <[^>]+> 0085 8000 	addiu	a0,a1,32768
[0-9a-f]+ <[^>]+> e09f 8ffd 	lui	a0,0xffff8
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e081 0000 	lui	a0,0x10
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e081 a000 	lui	a0,0x1a
[0-9a-f]+ <[^>]+> 8084 05a5 	ori	a0,a0,1445
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	.data
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_data_label
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_data_label
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_common
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_common
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss\+0x3e8
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	.data\+0x1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_data_label
[0-9a-f]+ <[^>]+> 0084 0001 	addiu	a0,a0,1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_data_label
[0-9a-f]+ <[^>]+> 0084 0001 	addiu	a0,a0,1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_common
[0-9a-f]+ <[^>]+> 0084 0001 	addiu	a0,a0,1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_common
[0-9a-f]+ <[^>]+> 0084 0001 	addiu	a0,a0,1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss\+0x1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss\+0x3e9
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	.data\+0x8000
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_data_label
[0-9a-f]+ <[^>]+> 0084 8000 	addiu	a0,a0,32768
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_data_label
[0-9a-f]+ <[^>]+> 0084 8000 	addiu	a0,a0,32768
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_common
[0-9a-f]+ <[^>]+> 0084 8000 	addiu	a0,a0,32768
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_common
[0-9a-f]+ <[^>]+> 0084 8000 	addiu	a0,a0,32768
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss\+0x8000
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss\+0x83e8
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	.data-0x8000
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_data_label
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_data_label
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_common
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_common
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss-0x8000
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss-0x7c18
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	.data\+0x10000
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_data_label
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_data_label
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_common
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_common
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss\+0x10000
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss\+0x103e8
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	.data\+0x1a5a5
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_data_label
[0-9a-f]+ <[^>]+> e021 a000 	lui	at,0x1a
[0-9a-f]+ <[^>]+> 8021 05a5 	ori	at,at,1445
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_data_label
[0-9a-f]+ <[^>]+> e021 a000 	lui	at,0x1a
[0-9a-f]+ <[^>]+> 8021 05a5 	ori	at,at,1445
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_common
[0-9a-f]+ <[^>]+> e021 a000 	lui	at,0x1a
[0-9a-f]+ <[^>]+> 8021 05a5 	ori	at,at,1445
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_common
[0-9a-f]+ <[^>]+> e021 a000 	lui	at,0x1a
[0-9a-f]+ <[^>]+> 8021 05a5 	ori	at,at,1445
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss\+0x1a5a5
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss\+0x1a98d
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	.data
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_data_label
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_data_label
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_common
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_common
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss\+0x3e8
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	.data\+0x1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_data_label
[0-9a-f]+ <[^>]+> 0084 0001 	addiu	a0,a0,1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_data_label
[0-9a-f]+ <[^>]+> 0084 0001 	addiu	a0,a0,1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_common
[0-9a-f]+ <[^>]+> 0084 0001 	addiu	a0,a0,1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_common
[0-9a-f]+ <[^>]+> 0084 0001 	addiu	a0,a0,1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss\+0x1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss\+0x3e9
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	.data\+0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_data_label
[0-9a-f]+ <[^>]+> 0084 8000 	addiu	a0,a0,32768
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_data_label
[0-9a-f]+ <[^>]+> 0084 8000 	addiu	a0,a0,32768
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_common
[0-9a-f]+ <[^>]+> 0084 8000 	addiu	a0,a0,32768
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_common
[0-9a-f]+ <[^>]+> 0084 8000 	addiu	a0,a0,32768
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss\+0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss\+0x83e8
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	.data-0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_data_label
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_data_label
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_common
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_common
[0-9a-f]+ <[^>]+> e03f 8ffd 	lui	at,0xffff8
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss-0x8000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss-0x7c18
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	.data\+0x10000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_data_label
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_data_label
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_common
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_common
[0-9a-f]+ <[^>]+> e021 0000 	lui	at,0x10
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss\+0x10000
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss\+0x103e8
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	.data\+0x1a5a5
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_data_label
[0-9a-f]+ <[^>]+> e021 a000 	lui	at,0x1a
[0-9a-f]+ <[^>]+> 8021 05a5 	ori	at,at,1445
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_data_label
[0-9a-f]+ <[^>]+> e021 a000 	lui	at,0x1a
[0-9a-f]+ <[^>]+> 8021 05a5 	ori	at,at,1445
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_common
[0-9a-f]+ <[^>]+> e021 a000 	lui	at,0x1a
[0-9a-f]+ <[^>]+> 8021 05a5 	ori	at,at,1445
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_common
[0-9a-f]+ <[^>]+> e021 a000 	lui	at,0x1a
[0-9a-f]+ <[^>]+> 8021 05a5 	ori	at,at,1445
[0-9a-f]+ <[^>]+> 2024 2150 	addu	a0,a0,at
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss\+0x1a5a5
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	\.bss\+0x1a98d
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 0085 0000 	addiu	a0,a1,0
[0-9a-f]+ <[^>]+> e092 3000 	lui	a0,0x123
[0-9a-f]+ <[^>]+> 8084 0456 	ori	a0,a0,1110
[0-9a-f]+ <[^>]+> e092 3000 	lui	a0,0x123
[0-9a-f]+ <[^>]+> 8084 0456 	ori	a0,a0,1110
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_data_label
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_data_label
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
	\.\.\.
