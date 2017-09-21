#objdump: -dr --show-raw-insn
#name: nanoMIPS %-operations in assembly

# Check nanoMIPS percent-ops

.*: +file format .*mips.*

Disassembly of section \.text:

00000000 <test>:
   [0-9a-f]+:	4498 0000 	lwc1	\$f4,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL16_S2	test
   [0-9a-f]+:	4498 0001 	swc1	\$f4,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL16_S2	test
   [0-9a-f]+:	4498 0002 	ldc1	\$f4,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL16_S2	test
   [0-9a-f]+:	4498 0003 	sdc1	\$f4,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL16_S2	test
  [0-9a-f]+:	4480 0000 	lb	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL18	test
  [0-9a-f]+:	4490 0000 	lh	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL17_S1	test
  [0-9a-f]+:	4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	test
  [0-9a-f]+:	4488 0000 	lbu	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL18	test
  [0-9a-f]+:	4490 0001 	lhu	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL17_S1	test
  [0-9a-f]+:	4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	test
  [0-9a-f]+:	4484 0000 	sb	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL18	test
  [0-9a-f]+:	4494 0000 	sh	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL17_S1	test
  [0-9a-f]+:	4080 0003 	sw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	test
  [0-9a-f]+:	448c 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL18	test
  [0-9a-f]+:	448c 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL18	test
  [0-9a-f]+:	4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	test
  [0-9a-f]+:	6082 0000 	addiu	a0,gp,0
  [0-9a-f]+:	0000 
			[0-9a-f]+: R_NANOMIPS_GPREL_I32	test
  [0-9a-f]+:	0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	test
  [0-9a-f]+:	1650      	lw	a0,0\(a1\)
			4a: R_NANOMIPS_LO4_S2	test
  [0-9a-f]+:	4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_CALL	test
  [0-9a-f]+:	4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	test
  [0-9a-f]+:	4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_PAGE	test
  [0-9a-f]+:	849c 8000 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	test
  [0-9a-f]+:	4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	test
  [0-9a-f]+:	e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_GPREL_HI20	test
  [0-9a-f]+:	0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_GPREL_LO12	test
  [0-9a-f]+:	6082 0000 	addiu	a0,gp,0
  [0-9a-f]+:	0000 
			[0-9a-f]+: R_NANOMIPS_GPREL_I32	test
  [0-9a-f]+:	e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	test
  [0-9a-f]+:	0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	test
  [0-9a-f]+:	e080 0002 	aluipc	a0,0 <test>
			[0-9a-f]+: R_NANOMIPS_PCHI20	test
  [0-9a-f]+:	0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	test
  [0-9a-f]+:	e080 0002 	aluipc	a0,0 <test>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	test
  [0-9a-f]+:	0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	test
  [0-9a-f]+:	0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	test
  [0-9a-f]+:	608b 0000 	lwpc	a0,0 <test>
  [0-9a-f]+:	0000 
			[0-9a-f]+: R_NANOMIPS_GOTPC_I32	test
  [0-9a-f]+:	db30      	jalrc	t9
			[0-9a-f]+: R_NANOMIPS_JALR32	test
  [0-9a-f]+:	db30      	jalrc	t9
			[0-9a-f]+: R_NANOMIPS_JALR16	test
#pass