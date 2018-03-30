#objdump: -dr --show-raw-insn
#name: nanoMIPS %-operations in assembly with addends

# Check nanoMIPS percent-ops with addends

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <test>:
   [0-9a-f]+:	4498 0000 	lwc1	\$f4,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL16_S2	test\+0x1
   [0-9a-f]+:	4498 0001 	swc1	\$f4,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL16_S2	test\+0x2
   [0-9a-f]+:	4498 0002 	ldc1	\$f4,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL16_S2	test\+0x3
   [0-9a-f]+:	4498 0003 	sdc1	\$f4,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL16_S2	test\+0x4
  [0-9a-f]+:	4480 0000 	lb	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL18	test\+0x5
  [0-9a-f]+:	4490 0000 	lh	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL17_S1	test\+0x6
  [0-9a-f]+:	4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	test\+0x7
  [0-9a-f]+:	4488 0000 	lbu	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL18	test\+0x8
  [0-9a-f]+:	4490 0001 	lhu	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL17_S1	test\+0x9
  [0-9a-f]+:	4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	test\+0xa
  [0-9a-f]+:	4484 0000 	sb	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL18	test\+0xb
  [0-9a-f]+:	4494 0000 	sh	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL17_S1	test\+0xc
  [0-9a-f]+:	4080 0003 	sw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	test\+0xd
  [0-9a-f]+:	448c 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL18	test\+0xe
  [0-9a-f]+:	448c 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL18	test\+0xf
  [0-9a-f]+:	4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	test\+0x10
  [0-9a-f]+:	6082 0000 	addiu	a0,gp,0
  [0-9a-f]+:	0000.
			[0-9a-f]+: R_NANOMIPS_GPREL_I32	test\+0x11
  [0-9a-f]+:	0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	test\+0x12
  [0-9a-f]+:	1650      	lw	a0,0\(a1\)
			4a: R_NANOMIPS_LO4_S2	test\+0x13
  [0-9a-f]+:	4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_CALL	test\+0x14
  [0-9a-f]+:	4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	test\+0x15
  [0-9a-f]+:	4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_PAGE	test\+0x16
  [0-9a-f]+:	849c 8000 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_OFST	test\+0x17
  [0-9a-f]+:	4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	test\+0x18
  [0-9a-f]+:	e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_GPREL_HI20	test\+0x19
  [0-9a-f]+:	0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_GPREL_LO12	test\+0x1a
  [0-9a-f]+:	6082 0000 	addiu	a0,gp,0
  [0-9a-f]+:	0000.
			[0-9a-f]+: R_NANOMIPS_GPREL_I32	test\+0x1b
  [0-9a-f]+:	e080 0000 	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	test\+0x1c
  [0-9a-f]+:	0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	test\+0x1d
  [0-9a-f]+:	e080 0002 	aluipc	a0,1e <test\+0x1e>
			[0-9a-f]+: R_NANOMIPS_PCHI20	test\+0x1e
  [0-9a-f]+:	0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_LO12	test\+0x1f
  [0-9a-f]+:	e080 0002 	aluipc	a0,20 <test\+0x20>
			[0-9a-f]+: R_NANOMIPS_GOTPC_HI20	test\+0x20
  [0-9a-f]+:	0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	test\+0x21
  [0-9a-f]+:	0084 0000 	addiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_GOT_LO12	test\+0x22
  [0-9a-f]+:	608b 0000 	lwpc	a0,23 <test\+0x23>
  [0-9a-f]+:	0000.
			[0-9a-f]+: R_NANOMIPS_GOTPC_I32	test\+0x23
  [0-9a-f]+:	db30      	jalrc	t9
			[0-9a-f]+: R_NANOMIPS_JALR32	end\+0x24
  [0-9a-f]+:	db30      	jalrc	t9
			[0-9a-f]+: R_NANOMIPS_JALR16	end\+0x25
[0-9a-f]+ <end>:
  [0-9a-f]+:	4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_TLS_GD	tlsvar\+0x1
  [0-9a-f]+:	4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_TLS_GD	tlsvar\+0x2
  [0-9a-f]+:	6082 0000 	addiu	a0,gp,0
  [0-9a-f]+:	0000.
			[0-9a-f]+: R_NANOMIPS_TLS_GD_I32	tlsvar\+0x3
  [0-9a-f]+:	6082 0000 	addiu	a0,gp,0
  [0-9a-f]+:	0000 
			[0-9a-f]+: R_NANOMIPS_TLS_GD_I32	tlsvar\+0x4
  [0-9a-f]+:	4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_TLS_LD	tlsvar\+0x5
  [0-9a-f]+:	4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_TLS_LD	tlsvar\+0x6
  [0-9a-f]+:	6082 0000 	addiu	a0,gp,0
  [0-9a-f]+:	0000.
			[0-9a-f]+: R_NANOMIPS_TLS_LD_I32	tlsvar\+0x7
  [0-9a-f]+:	6082 0000 	addiu	a0,gp,0
  [0-9a-f]+:	0000.
			[0-9a-f]+: R_NANOMIPS_TLS_LD_I32	tlsvar\+0x8
  [0-9a-f]+:	8485 a000 	lwc1	\$f4,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_TPREL12	tlsvar\+0x9
  [0-9a-f]+:	8485 b000 	swc1	\$f4,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_TPREL12	tlsvar\+0xa
  [0-9a-f]+:	8485 e000 	ldc1	\$f4,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_TPREL12	tlsvar\+0xb
  [0-9a-f]+:	8485 f000 	sdc1	\$f4,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_TPREL12	tlsvar\+0xc
  [0-9a-f]+:	8485 0000 	lb	a0,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_TPREL12	tlsvar\+0xd
  [0-9a-f]+:	8485 4000 	lh	a0,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_TPREL12	tlsvar\+0xe
  [0-9a-f]+:	8485 8000 	lw	a0,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_TPREL12	tlsvar\+0xf
  [0-9a-f]+:	8485 2000 	lbu	a0,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_TPREL12	tlsvar\+0x10
  [0-9a-f]+:	8485 6000 	lhu	a0,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_TPREL12	tlsvar\+0x11
  [0-9a-f]+:	8485 8000 	lw	a0,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_TPREL12	tlsvar\+0x12
  [0-9a-f]+:	8485 1000 	sb	a0,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_TPREL12	tlsvar\+0x13
  [0-9a-f]+:	8485 5000 	sh	a0,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_TPREL12	tlsvar\+0x14
  [0-9a-f]+:	8485 9000 	sw	a0,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_TPREL12	tlsvar\+0x15
  [0-9a-f]+:	0085 0000 	addiu	a0,a1,0
			[0-9a-f]+: R_NANOMIPS_TLS_TPREL16	tlsvar\+0x16
  [0-9a-f]+:	6081 0000 	addiu	a0,a0,0
  [0-9a-f]+:	0000.
			[0-9a-f]+: R_NANOMIPS_TLS_TPREL_I32	tlsvar\+0x17
  [0-9a-f]+:	6080 0000 	li	a0,0x0
  [0-9a-f]+:	0000.
			[0-9a-f]+: R_NANOMIPS_TLS_TPREL_I32	tlsvar\+0x18
 [0-9a-f]+:	8485 a000 	lwc1	\$f4,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_DTPREL12	tlsvar\+0x19
 [0-9a-f]+:	8485 b000 	swc1	\$f4,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_DTPREL12	tlsvar\+0x1a
 [0-9a-f]+:	8485 e000 	ldc1	\$f4,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_DTPREL12	tlsvar\+0x1b
 [0-9a-f]+:	8485 f000 	sdc1	\$f4,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_DTPREL12	tlsvar\+0x1c
 [0-9a-f]+:	8485 0000 	lb	a0,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_DTPREL12	tlsvar\+0x1d
 [0-9a-f]+:	8485 4000 	lh	a0,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_DTPREL12	tlsvar\+0x1e
 [0-9a-f]+:	8485 8000 	lw	a0,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_DTPREL12	tlsvar\+0x1f
 [0-9a-f]+:	8485 2000 	lbu	a0,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_DTPREL12	tlsvar\+0x20
 [0-9a-f]+:	8485 6000 	lhu	a0,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_DTPREL12	tlsvar\+0x21
 [0-9a-f]+:	8485 8000 	lw	a0,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_DTPREL12	tlsvar\+0x22
 [0-9a-f]+:	8485 1000 	sb	a0,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_DTPREL12	tlsvar\+0x23
 [0-9a-f]+:	8485 5000 	sh	a0,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_DTPREL12	tlsvar\+0x24
 [0-9a-f]+:	8485 9000 	sw	a0,0\(a1\)
			[0-9a-f]+: R_NANOMIPS_TLS_DTPREL12	tlsvar\+0x25
 [0-9a-f]+:	0085 0000 	addiu	a0,a1,0
			[0-9a-f]+: R_NANOMIPS_TLS_DTPREL16	tlsvar\+0x26
 [0-9a-f]+:	6081 0000 	addiu	a0,a0,0
 [0-9a-f]+:	0000.
			[0-9a-f]+: R_NANOMIPS_TLS_DTPREL_I32	tlsvar\+0x27
 [0-9a-f]+:	6080 0000 	li	a0,0x0
 [0-9a-f]+:	0000.
			[0-9a-f]+: R_NANOMIPS_TLS_DTPREL_I32	tlsvar\+0x28
 [0-9a-f]+:	4080 0002 	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_TLS_GOTTPREL	tlsvar\+0x29
 [0-9a-f]+:	608b 0000 	lwpc	a0,2a <tlsvar\+0x2a>
 [0-9a-f]+:	0000.
			[0-9a-f]+: R_NANOMIPS_TLS_GOTTPREL_PC_I32	tlsvar\+0x2a
#pass
