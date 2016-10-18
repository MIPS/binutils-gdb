#objdump: -dr --prefix-addresses --show-raw-insn -M reg-names=numeric
#name: MIPS32 R7 odd single-precision float registers
#source: mips32-sf32.s
#as: -32

# Check MIPS32 instruction assembly \(microMIPS R7\).

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <func> e020 07f0 	lui	\$1,0x3f800
0+0004 <func\+0x4> a021 283b 	mtc1	\$1,\$f1
0+0008 <func\+0x8> 847c a000 	lwc1	\$f3,0\(\$28\)
			8: R_MICROMIPS_LITERAL	.lit4
0+000c <func\+0xc> a061 2830 	add.s	\$f5,\$f1,\$f3
0+0010 <func\+0x10> a107 137b 	cvt\.d\.s	\$f8,\$f7
0+0014 <func\+0x14> a107 337b 	cvt\.d\.w	\$f8,\$f7
0+0018 <func\+0x18> a0e8 1b7b 	cvt\.s\.d	\$f7,\$f8
0+001c <func\+0x1c> a0e8 6b3b 	trunc\.w\.d	\$f7,\$f8
	\.\.\.
