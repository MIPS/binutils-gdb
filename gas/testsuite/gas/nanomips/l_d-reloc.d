#objdump: -dr --no-show-raw-insn -Mgpr-names=numeric
#name: LDC1 with relocation operators

.*file format.*

Disassembly of section \.text:

00000000 <func>:
  .+[0-9a-f]+:	ldc1	\$f4,0\(\$5\)
  .+[0-9a-f]+:	addiu	\$1,\$5,32763
  .+[0-9a-f]+:	ldc1	\$f4,0\(\$1\)
  .+[0-9a-f]+:	addiu	\$1,\$5,32764
 .+[0-9a-f]+:	ldc1	\$f4,0\(\$1\)
 .+[0-9a-f]+:	addiu	\$1,\$5,32767
 .+[0-9a-f]+:	ldc1	\$f4,0\(\$1\)
 .+[0-9a-f]+:	addiu	\$1,\$5,32768
 .+[0-9a-f]+:	ldc1	\$f4,0\(\$1\)
 .+[0-9a-f]+:	lui	\$1,%hi\(0x37000\)
 .+[0-9a-f]+:	addu	\$1,\$1,\$5
 .+[0-9a-f]+:	ldc1	\$f4,4091\(\$1\)
 .+[0-9a-f]+:	lui	\$1,%hi\(0x37000\)
 .+[0-9a-f]+:	addu	\$1,\$1,\$5
 .+[0-9a-f]+:	ldc1	\$f4,4092\(\$1\)
 .+[0-9a-f]+:	lui	\$1,%hi\(0x37000\)
 .+[0-9a-f]+:	addu	\$1,\$1,\$5
 .+[0-9a-f]+:	ldc1	\$f4,4095\(\$1\)
 .+[0-9a-f]+:	lui	\$1,%hi\(0x38000\)
 .+[0-9a-f]+:	addu	\$1,\$1,\$5
 .+[0-9a-f]+:	ldc1	\$f4,0\(\$1\)
 .+[0-9a-f]+:	ldc1	\$f4,0\(\$0\)
			54: R_NANOMIPS_LO12	foo
 .+[0-9a-f]+:	lui	\$1,0x0
			58: R_NANOMIPS_HI20	foo
 .+[0-9a-f]+:	ldc1	\$f4,0\(\$1\)
			5c: R_NANOMIPS_LO12	foo
 .+[0-9a-f]+:	lui	\$1,0x0
			60: R_NANOMIPS_HI20	foo
 .+[0-9a-f]+:	ldc1	\$f4,0\(\$1\)
			64: R_NANOMIPS_LO12	foo
 .+[0-9a-f]+:	ldc1	\$f4,1893\(\$0\)
 .+[0-9a-f]+:	lui	\$1,%hi\(0x12348000\)
 .+[0-9a-f]+:	ldc1	\$f4,1893\(\$1\)
 .+[0-9a-f]+:	ldc1	\$f4,0\(\$5\)
			74: R_NANOMIPS_LO12	foo
 .+[0-9a-f]+:	ldc1	\$f4,1893\(\$5\)
 .+[0-9a-f]+:	lui	\$1,%hi\(0x12348000\)
 .+[0-9a-f]+:	addu	\$1,\$1,\$5
 .+[0-9a-f]+:	ldc1	\$f4,1893\(\$1\)
 .+[0-9a-f]+:	ldc1	\$f4,0\(\$5\)
			88: R_NANOMIPS_LO12	foo\+0x12348765
