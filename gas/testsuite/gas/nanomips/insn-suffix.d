#as: --linkrelax -mno-minimize-relocs
#objdump: -dr --no-show-raw-insn -Mshow-arch-insn
#name: nanoMIPS instructions with suffixes

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <test>:
   0:	addiu\[r1.sp\]	a0,sp,8
   2:	addiu\[r2\]	a0,a1,4
   4:	addiu\[rs5\]	t0,t0,3
   6:	addiu\[gp.b\]	a0,gp,0
			6: R_NANOMIPS_GPREL18	test
			6: R_NANOMIPS_FIXED	\*ABS\*
   a:	addiu\[gp.w\]	a0,gp,0
			a: R_NANOMIPS_GPREL19_S2	test
			a: R_NANOMIPS_FIXED	\*ABS\*
   e:	addiu\[neg\]	a0,a1,-4
  12:	addiu\[32\]	a0,a1,64
  16:	addiu\[48\]	a0,a0,12
  1c:	addiu\[gp48\]	a0,gp,0
			1e: R_NANOMIPS_GPREL_I32	test
			1e: R_NANOMIPS_FIXED	\*ABS\*
  22:	addiu\[r1.sp\]	a0,sp,8
  24:	addiu\[r2\]	a0,a1,4
  26:	addiu\[rs5\]	t0,t0,3
  28:	addiu\[gp.b\]	a0,gp,0
			28: R_NANOMIPS_GPREL18	test
			28: R_NANOMIPS_FIXED	\*ABS\*
  2c:	addiu\[gp.w\]	a0,gp,0
			2c: R_NANOMIPS_GPREL19_S2	test
			2c: R_NANOMIPS_FIXED	\*ABS\*
  30:	addiu\[neg\]	a0,a1,-4
  34:	addiu\[32\]	a0,a1,64
  38:	addiu\[48\]	a0,a0,12
  3e:	addiu\[gp48\]	a0,gp,0
			40: R_NANOMIPS_GPREL_I32	test
			40: R_NANOMIPS_FIXED	\*ABS\*
  44:	lw\[16\]	a0,8\(a1\)
  46:	lw\[4x4\]	a1,12\(a2\)
  48:	lw\[gp16\]	a3,24\(gp\)
  4a:	lw\[gp16\]	a3,0\(gp\)
			4a: R_NANOMIPS_GPREL7_S2	test
			4a: R_NANOMIPS_FIXED	\*ABS\*
  4c:	lw\[sp\]	a3,20\(sp\)
  4e:	lw\[gp\]	a3,224\(gp\)
  52:	lw\[gp\]	a3,0\(gp\)
			52: R_NANOMIPS_GPREL19_S2	test
			52: R_NANOMIPS_FIXED	\*ABS\*
  56:	lw\[s9\]	a3,20\(s0\)
  5a:	lw\[u12\]	a3,20\(s1\)
  5e:	lwpc\[48\]	a3,0 <test>
			60: R_NANOMIPS_PC_I32	test
			60: R_NANOMIPS_FIXED	\*ABS\*
  64:	lw\[16\]	a0,8\(a1\)
  66:	lw\[4x4\]	a1,12\(a2\)
  68:	lw\[gp16\]	a3,24\(gp\)
  6a:	lw\[gp16\]	a3,0\(gp\)
			6a: R_NANOMIPS_GPREL7_S2	test
			6a: R_NANOMIPS_FIXED	\*ABS\*
  6c:	lw\[sp\]	a3,20\(sp\)
  6e:	lw\[gp\]	a3,224\(gp\)
  72:	lw\[gp\]	a3,0\(gp\)
			72: R_NANOMIPS_GPREL19_S2	test
			72: R_NANOMIPS_FIXED	\*ABS\*
  76:	lw\[s9\]	a3,20\(s0\)
  7a:	lw\[u12\]	a3,20\(s1\)
  7e:	lwpc\[48\]	a3,0 <test>
			80: R_NANOMIPS_PC_I32	test
			80: R_NANOMIPS_FIXED	\*ABS\*
  84:	bc\[16\]	0 <test>
			84: R_NANOMIPS_PC10_S1	test
			84: R_NANOMIPS_FIXED	\*ABS\*
  86:	bc\[32\]	0 <test>
			86: R_NANOMIPS_PC25_S1	test
			86: R_NANOMIPS_FIXED	\*ABS\*
  8a:	beqc\[16\]	a0,a1,92 <.L1.*>
			8a: R_NANOMIPS_PC4_S1	.L1.*
			8a: R_NANOMIPS_FIXED	\*ABS\*
  8c:	bnec\[16\]	a1,a0,92 <.L1.*>
			8c: R_NANOMIPS_PC4_S1	.L1.*
			8c: R_NANOMIPS_FIXED	\*ABS\*
  8e:	beqzc\[16\]	a0,92 <.L1.*>
			8e: R_NANOMIPS_PC7_S1	.L1.*
			8e: R_NANOMIPS_FIXED	\*ABS\*
  90:	bnezc\[16\]	a1,94 <.L2.*>
			90: R_NANOMIPS_PC7_S1	.L2.*
			90: R_NANOMIPS_FIXED	\*ABS\*

00000092 <.L1.*>:
  92:	balc\[16\]	0 <test>
			92: R_NANOMIPS_PC10_S1	test
			92: R_NANOMIPS_FIXED	\*ABS\*
#pass
