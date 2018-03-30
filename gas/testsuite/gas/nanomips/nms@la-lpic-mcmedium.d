#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS subset la PIC medium memory model
#as: -mPIC -mcmodel=medium
#source: la.s

# Test the la macro with mPIC on nanoMIPS subset and medium memory model

.*: +file format .*nanomips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> 0080 0000 	li	a0,0
[0-9a-f]+ <[^>]+> 0080 0001 	li	a0,1
[0-9a-f]+ <[^>]+> 0080 8000 	li	a0,32768
[0-9a-f]+ <[^>]+> e09f 8ffd 	lui	a0,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> e081 0000 	lui	a0,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> e081 a000 	lui	a0,%hi\(0x1a000\)
[0-9a-f]+ <[^>]+> 8084 05a5 	ori	a0,a0,0x5a5
[0-9a-f]+ <[^>]+> 0085 0000 	addiu	a0,a1,0
[0-9a-f]+ <[^>]+> 0085 0001 	addiu	a0,a1,1
[0-9a-f]+ <[^>]+> 0085 8000 	addiu	a0,a1,32768
[0-9a-f]+ <[^>]+> e09f 8ffd 	lui	a0,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e081 0000 	lui	a0,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e081 a000 	lui	a0,%hi\(0x1a000\)
[0-9a-f]+ <[^>]+> 8084 05a5 	ori	a0,a0,0x5a5
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PCHI20	data_label
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.data
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	big_external_data_label
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	big_external_data_label
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	small_external_data_label
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	small_external_data_label
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	big_external_common
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	big_external_common
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	small_external_common
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	small_external_common
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PCHI20	big_local_common
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PCHI20	small_local_common
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss\+0x3e8
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PCHI20	data_label\+0x1
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.data\+0x1
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	big_external_data_label\+0x1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	big_external_data_label\+0x1
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	small_external_data_label\+0x1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	small_external_data_label\+0x1
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	big_external_common\+0x1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	big_external_common\+0x1
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	small_external_common\+0x1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	small_external_common\+0x1
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PCHI20	big_local_common\+0x1
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss\+0x1
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PCHI20	small_local_common\+0x1
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss\+0x3e9
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PCHI20	data_label\+0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.data\+0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	big_external_data_label\+0x8000
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	big_external_data_label\+0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	small_external_data_label\+0x8000
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	small_external_data_label\+0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	big_external_common\+0x8000
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	big_external_common\+0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	small_external_common\+0x8000
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	small_external_common\+0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PCHI20	big_local_common\+0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss\+0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PCHI20	small_local_common\+0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss\+0x83e8
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PCHI20	data_label-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.data-0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	big_external_data_label-0x8000
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	big_external_data_label-0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	small_external_data_label-0x8000
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	small_external_data_label-0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	big_external_common-0x8000
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	big_external_common-0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	small_external_common-0x8000
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	small_external_common-0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PCHI20	big_local_common-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss-0x8000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PCHI20	small_local_common-0x8000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss-0x7c18
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PCHI20	data_label\+0x10000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.data\+0x10000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	big_external_data_label\+0x10000
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	big_external_data_label\+0x10000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	small_external_data_label\+0x10000
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	small_external_data_label\+0x10000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	big_external_common\+0x10000
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	big_external_common\+0x10000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	small_external_common\+0x10000
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	small_external_common\+0x10000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PCHI20	big_local_common\+0x10000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss\+0x10000
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PCHI20	small_local_common\+0x10000
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss\+0x103e8
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PCHI20	data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.data\+0x1a5a5
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	big_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	big_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	small_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	small_external_data_label\+0x1a5a5
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	big_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	big_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	small_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	small_external_common\+0x1a5a5
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PCHI20	big_local_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss\+0x1a5a5
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_PCHI20	small_local_common\+0x1a5a5
[0-9a-f]+ <[^>]+> 0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss\+0x1a98d
[0-9a-f]+ <[^>]+> 0085 0000 	addiu	a0,a1,0
[0-9a-f]+ <[^>]+> e092 3000 	lui	a0,%hi\(0x123000\)
[0-9a-f]+ <[^>]+> 8084 0456 	ori	a0,a0,0x456
[0-9a-f]+ <[^>]+> e092 3000 	lui	a0,%hi\(0x123000\)
[0-9a-f]+ <[^>]+> 8084 0456 	ori	a0,a0,0x456
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> e080 0002 	aluipc	a0,[0-9a-f]+ <[^>]+>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	big_external_data_label
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	big_external_data_label
#pass
