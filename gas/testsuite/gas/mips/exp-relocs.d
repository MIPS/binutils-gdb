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
  [0-9a-f]+:	9008      	nop
