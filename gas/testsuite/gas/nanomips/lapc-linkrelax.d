#objdump: -dr
#name: nanoMIPS LAPC variants with linker relaxation
#as: --linkrelax -mno-minimize-relocs
#source: lapc.s

# Test all LAPC variants with linker relaxation

.*: +file format .*nanomips.*
Disassembly of section \.text:

00000000 <test>:
   0:	0480 0000 	lapc	a0,0 <test>
			0: R_NANOMIPS_PC21_S1	test
   4:	0480 0000 	lapc	a0,0 <test1>
			4: R_NANOMIPS_PC21_S1	test1
   8:	0480 0000 	lapc	a0,0 <test>
			8: R_NANOMIPS_PC21_S1	test
			8: R_NANOMIPS_INSN32	\*ABS\*
   c:	6083 0000 	lapc	a0,0 <test1>
  10:	0000 
			e: R_NANOMIPS_PC_I32	test1
  12:	0480 0000 	lapc	a0,0 <test>
			12: R_NANOMIPS_PC21_S1	test
			12: R_NANOMIPS_FIXED	\*ABS\*
  16:	6083 0000 	lapc	a0,0 <test1>
  1a:	0000 
			18: R_NANOMIPS_PC_I32	test1
			18: R_NANOMIPS_FIXED	\*ABS\*
  1c:	0480 0000 	lapc	a0,0 <test>
			1c: R_NANOMIPS_PC21_S1	test
  20:	6083 0000 	lapc	a0,0 <test1>
  24:	0000 
			22: R_NANOMIPS_PC_I32	test1
  26:	9008      	nop
			26: R_NANOMIPS_ALIGN	__reloc_align__1
	\.\.\.
