#objdump: -dr
#name: Minimize relocs special cases
#as: -mminimize-relocs

# Check reloc minimization special cases

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <test>:
   0:	dacf      	beqc	a0,a1,6 <\$L1>
			0: R_NANOMIPS_PC4_S1	\$L1
   2:	88a4 0000 	beqc	a0,a1,28 <\$L2>
			2: R_NANOMIPS_PC14_S1	\$L2

00000006 <\$L1>:
   6:	0085 0000 	addiu	a0,a1,0
			6: R_NANOMIPS_GPREL_LO12	test
   a:	4080 0000 	addiu	a0,gp,0
			a: R_NANOMIPS_GPREL19_S2	test
	\.\.\.

00000028 <\$L2>:
  28:	dac2      	beqc	a0,a1,2e <\$L2\+0x6>
  2a:	88a4 0000 	beqc	a0,a1,4e <\$L4>
			2a: R_NANOMIPS_PC14_S1	\$L4
  2e:	448c 0000 	addiu	a0,gp,0
			2e: R_NANOMIPS_GPREL18	test
	\.\.\.

0000004e <\$L4>:
  4e:	dacf      	beqc	a0,a1,54 <\$L5>
			4e: R_NANOMIPS_PC4_S1	\$L5
  50:	88a4 0000 	beqc	a0,a1,74 <\$L6>
			50: R_NANOMIPS_PC14_S1	\$L6

00000054 <\$L5>:
  54:	4080 0002 	lw	a0,0\(gp\)
			54: R_NANOMIPS_GPREL19_S2	test
	\.\.\.

00000074 <\$L6>:
  74:	9008      	nop
	\.\.\.
  86:	0000 9008 	sigrie	0x9008
  8a:	dacf      	beqc	a0,a1,90 <\$L7>
			8a: R_NANOMIPS_PC4_S1	\$L7
  8c:	88a4 0000 	beqc	a0,a1,ae <\$L8>
			8c: R_NANOMIPS_PC14_S1	\$L8

00000090 <\$L7>:
  90:	4080 0002 	lw	a0,0\(gp\)
			90: R_NANOMIPS_GPREL19_S2	test
  94:	8000 c000 	nop
			94: R_NANOMIPS_ALIGN	__reloc_align__1
  98:	8000 c000 	nop
  9c:	8000 c000 	nop
	\.\.\.

000000ae <\$L8>:
  ae:	9008      	nop
  b0:	9008      	nop
  b2:	dac2      	beqc	a0,a1,b8 <\$L8\+0xa>
  b4:	88a4 0000 	beqc	a0,a1,da <\$L10>
			b4: R_NANOMIPS_PC14_S1	\$L10
  b8:	4080 0002 	lw	a0,0\(gp\)
			b8: R_NANOMIPS_GPREL19_S2	test
  bc:	8000 c000 	nop
			bc: R_NANOMIPS_ALIGN	__reloc_align__2
	\.\.\.

000000da <\$L10>:
  da:	9008      	nop
  dc:	8000 c000 	nop
#pass
