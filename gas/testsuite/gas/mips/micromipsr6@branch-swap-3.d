#objdump: -dr -M reg-names=numeric
#as: -32 -O2 -aln=branch-swap-lst.lst
#name: MIPS branch swapping with assembler listing
#source: branch-swap-3.s

# Check delay slot filling with a listing file works (microMIPS)

.*: +file format .*mips.*

Disassembly of section \.text:

[0-9a-f]+ <test>:
[ 0-9a-f]+:	0e02      	move	\$16,\$2
[ 0-9a-f]+:	b7ff fffe 	balc	2 <test\+0x2>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	func
[ 0-9a-f]+:	6c10      	addiu	\$16,\$17,1
[ 0-9a-f]+:	b7ff fffe 	balc	8 <test\+0x8>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	func
[ 0-9a-f]+:	3211 0001 	addiu	\$16,\$17,1
[ 0-9a-f]+:	b7ff fffe 	balc	10 <test\+0x10>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	func
[ 0-9a-f]+:	3211 3fff 	addiu	\$16,\$17,16383
[ 0-9a-f]+:	b7ff fffe 	balc	18 <test\+0x18>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	func
[ 0-9a-f]+:	3211 3fff 	addiu	\$16,\$17,16383
[ 0-9a-f]+:	b7ff fffe 	balc	20 <test\+0x20>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC26_S1	func
[ 0-9a-f]+:	0e02      	move	\$16,\$2
[ 0-9a-f]+:	47e3      	jrc	\$31
[ 0-9a-f]+:	6c10      	addiu	\$16,\$17,1
[ 0-9a-f]+:	47e3      	jrc	\$31
[ 0-9a-f]+:	3211 0001 	addiu	\$16,\$17,1
[ 0-9a-f]+:	47e3      	jrc	\$31
[ 0-9a-f]+:	3211 3fff 	addiu	\$16,\$17,16383
[ 0-9a-f]+:	47e3      	jrc	\$31
[ 0-9a-f]+:	3211 3fff 	addiu	\$16,\$17,16383
[ 0-9a-f]+:	47e3      	jrc	\$31
	\.\.\.
