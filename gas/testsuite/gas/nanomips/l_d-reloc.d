#objdump: -dr --no-show-raw-insn -Mgpr-names=numeric
#name: LDC1 with relocation operators

.*file format.*

Disassembly of section \.text:

00000000 <func>:
   0:	ldc1	\$f4,0\(\$5\)
   4:	addiu	\$1,\$5,32763
   8:	ldc1	\$f4,0\(\$1\)
   c:	addiu	\$1,\$5,32764
  10:	ldc1	\$f4,0\(\$1\)
  14:	addiu	\$1,\$5,32767
  18:	ldc1	\$f4,0\(\$1\)
  1c:	addiu	\$1,\$5,32768
  20:	ldc1	\$f4,0\(\$1\)
  24:	lui	\$1,%hi\(0x37000\)
  28:	addu	\$1,\$1,\$5
  2c:	ldc1	\$f4,4091\(\$1\)
  30:	lui	\$1,%hi\(0x37000\)
  34:	addu	\$1,\$1,\$5
  38:	ldc1	\$f4,4092\(\$1\)
  3c:	lui	\$1,%hi\(0x37000\)
  40:	addu	\$1,\$1,\$5
  44:	ldc1	\$f4,4095\(\$1\)
  48:	lui	\$1,%hi\(0x38000\)
  4c:	addu	\$1,\$1,\$5
  50:	ldc1	\$f4,0\(\$1\)
  54:	ldc1	\$f4,0\(\$0\)
			54: R_NANOMIPS_LO12	foo
  58:	lui	\$1,0x0
			58: R_NANOMIPS_HI20	foo
  5c:	ldc1	\$f4,0\(\$1\)
			5c: R_NANOMIPS_LO12	foo
  60:	lui	\$1,0x0
			60: R_NANOMIPS_HI20	foo
  64:	ldc1	\$f4,0\(\$1\)
			64: R_NANOMIPS_LO12	foo
  68:	ldc1	\$f4,1893\(\$0\)
  6c:	lui	\$1,%hi\(0x12348000\)
  70:	ldc1	\$f4,1893\(\$1\)
  74:	ldc1	\$f4,0\(\$5\)
			74: R_NANOMIPS_LO12	foo
  78:	lui	\$1,0x0
			78: R_NANOMIPS_HI20	foo
  7c:	addu	\$1,\$1,\$5
  80:	ldc1	\$f4,0\(\$1\)
			80: R_NANOMIPS_LO12	foo
  84:	lui	\$1,0x0
			84: R_NANOMIPS_HI20	foo
  88:	addu	\$1,\$1,\$5
  8c:	ldc1	\$f4,0\(\$1\)
			8c: R_NANOMIPS_LO12	foo
  90:	ldc1	\$f4,1893\(\$5\)
  94:	lui	\$1,%hi\(0x12348000\)
  98:	addu	\$1,\$1,\$5
  9c:	ldc1	\$f4,1893\(\$1\)
  a0:	ldc1	\$f4,0\(\$5\)
			a0: R_NANOMIPS_LO12	foo\+0x12348765
  a4:	lui	\$1,0x0
			a4: R_NANOMIPS_HI20	foo\+0x12348765
  a8:	addu	\$1,\$1,\$5
  ac:	ldc1	\$f4,0\(\$1\)
			ac: R_NANOMIPS_LO12	foo\+0x12348765
