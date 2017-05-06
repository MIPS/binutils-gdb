#objdump: -dr --prefix-addresses
#name: MIPS R7 ld-svr4pic
#as: -32 -mips32r7 -mmicromips -KPIC --defsym KPIC=1 -mno-xlp --defsym r7=
#source: ld-pic.s

# Test the ld macro with -KPIC.

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> lw	a0,0\(zero\)
[0-9a-f]+ <[^>]+> lw	a1,4\(zero\)
[0-9a-f]+ <[^>]+> lw	a0,1\(zero\)
[0-9a-f]+ <[^>]+> lw	a1,5\(zero\)
[0-9a-f]+ <[^>]+> li	at,32768
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> lui	at,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> lui	at,%hi\(0x1a000\)
[0-9a-f]+ <[^>]+> lw	a0,1445\(at\)
[0-9a-f]+ <[^>]+> lw	a1,1449\(at\)
[0-9a-f]+ <[^>]+> lw	a0,0\(a1\)
[0-9a-f]+ <[^>]+> lw	a1,4\(a1\)
[0-9a-f]+ <[^>]+> lw	a0,1\(a1\)
[0-9a-f]+ <[^>]+> lw	a1,5\(a1\)
[0-9a-f]+ <[^>]+> addiu	at,a1,32768
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> lui	at,%hi\(0xffff8000\)
[0-9a-f]+ <[^>]+> addu	at,a1,at
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> lui	at,%hi\(0x10000\)
[0-9a-f]+ <[^>]+> addu	at,a1,at
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> lui	at,%hi\(0x1a000\)
[0-9a-f]+ <[^>]+> addu	at,a1,at
[0-9a-f]+ <[^>]+> lw	a0,1445\(at\)
[0-9a-f]+ <[^>]+> lw	a1,1449\(at\)
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_PAGE	.data
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.data
[0-9a-f]+ <[^>]+> lw	a1,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.data\+0x4
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_data_label
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_data_label
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_common
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_common
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_PAGE	.bss
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.bss
[0-9a-f]+ <[^>]+> lw	a1,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.bss\+0x4
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_PAGE	.bss\+0x3e8
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.bss\+0x3e8
[0-9a-f]+ <[^>]+> lw	a1,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.bss\+0x3ec
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_PAGE	.data\+0x1
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.data\+0x1
[0-9a-f]+ <[^>]+> lw	a1,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.data\+0x5
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_data_label\+0x1
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_data_label\+0x1
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_common\+0x1
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_common\+0x1
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_PAGE	.bss\+0x1
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.bss\+0x1
[0-9a-f]+ <[^>]+> lw	a1,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.bss\+0x5
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_PAGE	.bss\+0x3e9
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.bss\+0x3e9
[0-9a-f]+ <[^>]+> lw	a1,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.bss\+0x3ed
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_PAGE	.data
[0-9a-f]+ <[^>]+> addu	at,a1,at
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.data
[0-9a-f]+ <[^>]+> lw	a1,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.data\+0x4
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_data_label
[0-9a-f]+ <[^>]+> addu	at,a1,at
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_data_label
[0-9a-f]+ <[^>]+> addu	at,a1,at
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_common
[0-9a-f]+ <[^>]+> addu	at,a1,at
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_common
[0-9a-f]+ <[^>]+> addu	at,a1,at
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_PAGE	.bss
[0-9a-f]+ <[^>]+> addu	at,a1,at
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.bss
[0-9a-f]+ <[^>]+> lw	a1,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.bss\+0x4
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_PAGE	.bss\+0x3e8
[0-9a-f]+ <[^>]+> addu	at,a1,at
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.bss\+0x3e8
[0-9a-f]+ <[^>]+> lw	a1,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.bss\+0x3ec
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_PAGE	.data\+0x1
[0-9a-f]+ <[^>]+> addu	at,a1,at
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.data\+0x1
[0-9a-f]+ <[^>]+> lw	a1,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.data\+0x5
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_data_label\+0x1
[0-9a-f]+ <[^>]+> addu	at,a1,at
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_data_label\+0x1
[0-9a-f]+ <[^>]+> addu	at,a1,at
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	big_external_common\+0x1
[0-9a-f]+ <[^>]+> addu	at,a1,at
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_DISP	small_external_common\+0x1
[0-9a-f]+ <[^>]+> addu	at,a1,at
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
[0-9a-f]+ <[^>]+> lw	a1,4\(at\)
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_PAGE	.bss\+0x1
[0-9a-f]+ <[^>]+> addu	at,a1,at
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.bss\+0x1
[0-9a-f]+ <[^>]+> lw	a1,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.bss\+0x5
[0-9a-f]+ <[^>]+> lw	at,0\(gp\)
			[0-9a-f]+: R_MICROMIPS_GOT_PAGE	.bss\+0x3e9
[0-9a-f]+ <[^>]+> addu	at,a1,at
[0-9a-f]+ <[^>]+> lw	a0,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.bss\+0x3e9
[0-9a-f]+ <[^>]+> lw	a1,0\(at\)
			[0-9a-f]+: R_MICROMIPS_GOT_OFST	.bss\+0x3ed
[0-9a-f]+ <[^>]+> nop
[0-9a-f]+ <[^>]+> nop
