#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS lb-svr4pic-ilocks
#source: lb-pic.s
#as: -p32 -KPIC

# Test the lb macro with -KPIC (nanoMIPS).

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> 8480 0000 	lb	a0,0\(zero\)
[0-9a-f]+ <[^>]+> 8480 0001 	lb	a0,1\(zero\)
[0-9a-f]+ <[^>]+> 0080 8000 	li	a0,32768
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
[0-9a-f]+ <[^>]+> e09f 8ffd 	lui	a0,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
[0-9a-f]+ <[^>]+> e081 0000 	lui	a0,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
[0-9a-f]+ <[^>]+> e081 a000 	lui	a0,%hi\(0x1a000\)
[0-9a-f]+ <[^>]+> 8484 05a5 	lb	a0,1445\(a0\)
[0-9a-f]+ <[^>]+> 5e50      	lb	a0,0\(a1\)
[0-9a-f]+ <[^>]+> 5e51      	lb	a0,1\(a1\)
[0-9a-f]+ <[^>]+> 0085 8000 	addiu	a0,a1,32768
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
[0-9a-f]+ <[^>]+> e09f 8ffd 	lui	a0,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
[0-9a-f]+ <[^>]+> e081 0000 	lui	a0,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
[0-9a-f]+ <[^>]+> e081 a000 	lui	a0,%hi\(0x1a000\)
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 8484 05a5 	lb	a0,1445\(a0\)
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_PAGE	.data
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	.data
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	big_external_data_label
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	small_external_data_label
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	big_external_common
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	small_external_common
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_PAGE	.bss
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	.bss
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_PAGE	.bss\+0x3e8
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	.bss\+0x3e8
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_PAGE	.data\+0x1
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	.data\+0x1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	big_external_data_label\+0x1
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	small_external_data_label\+0x1
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	big_external_common\+0x1
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	small_external_common\+0x1
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_PAGE	.bss\+0x1
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	.bss\+0x1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_PAGE	.bss\+0x3e9
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	.bss\+0x3e9
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_PAGE	.data
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	.data
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	big_external_data_label
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	small_external_data_label
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	big_external_common
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	small_external_common
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_PAGE	.bss
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	.bss
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_PAGE	.bss\+0x3e8
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	.bss\+0x3e8
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_PAGE	.data\+0x1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	.data\+0x1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	big_external_data_label\+0x1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	small_external_data_label\+0x1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	big_external_common\+0x1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	small_external_common\+0x1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_PAGE	.bss\+0x1
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	.bss\+0x1
[0-9a-f]+ <[^>]+> 4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_PAGE	.bss\+0x3e9
[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 8484 0000 	lb	a0,0\(a0\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	.bss\+0x3e9
[0-9a-f]+ <[^>]+> 9008      	nop
[0-9a-f]+ <[^>]+> 9008      	nop
