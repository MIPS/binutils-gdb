#objdump: -dr
#name: nanoMIPS LAPC variants w/o linker relaxation

# Test all LAPC variants without linker relaxation

.*: +file format .*nanomips.*
Disassembly of section \.text:

00000000 <test>:
   0:	0480 0000 	lapc	a0,0 <test>
			0: R_NANOMIPS_PC21_S1	test
   4:	0480 0000 	lapc	a0,0 <test1>
			4: R_NANOMIPS_PC21_S1	test1
   8:	0480 0000 	lapc	a0,0 <test>
			8: R_NANOMIPS_PC21_S1	test
   c:	6083 0000 	lapc	a0,0 <test1>
  10:	0000 
			e: R_NANOMIPS_PC_I32	test1
  12:	0480 0000 	lapc	a0,0 <test>
			12: R_NANOMIPS_PC21_S1	test
  16:	6083 0000 	lapc	a0,0 <test1>
  1a:	0000 
			18: R_NANOMIPS_PC_I32	test1
  1c:	0480 0000 	lapc	a0,0 <test>
			1c: R_NANOMIPS_PC21_S1	test
  20:	6083 0000 	lapc	a0,0 <test1>
  24:	0000 
			22: R_NANOMIPS_PC_I32	test1
  26:	9008      	nop
	\.\.\.
