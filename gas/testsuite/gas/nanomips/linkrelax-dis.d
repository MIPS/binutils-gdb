#objdump: -dr
#name: nanoMIPS PC-relative disassembly with linkrelax flag
#as: -mno-minimize-relocs

# Check nanoMIPS PC-relative disassembly with linkrelax

.*: +file format .*nanomips.*

Disassembly of section \.text:

[0-9a-f]+ <test>:
   0:	0480 0000 	lapc	a0,12 <test1>
			[0-9a-f]+: R_NANOMIPS_PC21_S1	test1
			[0-9a-f]+: R_NANOMIPS_ALIGN	__reloc_align__1
			[0-9a-f]+: R_NANOMIPS_FILL	__reloc_fill__8
			[0-9a-f]+: R_NANOMIPS_MAX	__reloc_max__a
   4:	9a00      	beqzc	a0,12 <test1>
			[0-9a-f]+: R_NANOMIPS_PC7_S1	test1
			[0-9a-f]+: R_NANOMIPS_NORELAX	\*ABS\*
   6:	9008      	nop
   8:	8000 c000 	nop
   c:	8000 c000 	nop
  10:	3800      	balc	0 <test>
			[0-9a-f]+: R_NANOMIPS_PC10_S1	test
			[0-9a-f]+: R_NANOMIPS_RELAX	\*ABS\*

[0-9a-f]+ <test1>:
  12:	9008      	nop
  14:	8000 c000 	nop
  18:	8000 c000 	nop
  1c:	8000 c000 	nop
