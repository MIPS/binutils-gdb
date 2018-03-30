#objdump: -dr
#name: LDC1 with relocation operators

.*file format.*

Disassembly of section \.text:

00000000 <func>:
   0:	8485 e000 	ldc1	\$f4,0\(a1\)
   4:	0025 7ffb 	addiu	at,a1,32763
   8:	8481 e000 	ldc1	\$f4,0\(at\)
   c:	0025 7ffc 	addiu	at,a1,32764
  10:	8481 e000 	ldc1	\$f4,0\(at\)
  14:	0025 7fff 	addiu	at,a1,32767
  18:	8481 e000 	ldc1	\$f4,0\(at\)
  1c:	0025 8000 	addiu	at,a1,32768
  20:	8481 e000 	ldc1	\$f4,0\(at\)
  24:	e023 7000 	lui	at,%hi\(0x37000\)
  28:	20a1 0950 	addu	at,at,a1
  2c:	8481 effb 	ldc1	\$f4,4091\(at\)
  30:	e023 7000 	lui	at,%hi\(0x37000\)
  34:	20a1 0950 	addu	at,at,a1
  38:	8481 effc 	ldc1	\$f4,4092\(at\)
  3c:	e023 7000 	lui	at,%hi\(0x37000\)
  40:	20a1 0950 	addu	at,at,a1
  44:	8481 efff 	ldc1	\$f4,4095\(at\)
  48:	e023 8000 	lui	at,%hi\(0x38000\)
  4c:	20a1 0950 	addu	at,at,a1
  50:	8481 e000 	ldc1	\$f4,0\(at\)
  54:	8480 e000 	ldc1	\$f4,0\(zero\)
			54: R_NANOMIPS_LO12	foo
  58:	e020 0000 	lui	at,0x0
			58: R_NANOMIPS_HI20	foo
  5c:	8481 e000 	ldc1	\$f4,0\(at\)
			5c: R_NANOMIPS_LO12	foo
  60:	8480 e765 	ldc1	\$f4,1893\(zero\)
  64:	e034 8244 	lui	at,%hi\(0x12348000\)
  68:	8481 e000 	ldc1	\$f4,0\(at\)
  6c:	8485 e000 	ldc1	\$f4,0\(a1\)
			6c: R_NANOMIPS_LO12	foo
  70:	8485 e765 	ldc1	\$f4,1893\(a1\)
  74:	e034 8244 	lui	at,%hi\(0x12348000\)
  78:	20a1 0950 	addu	at,at,a1
  7c:	8481 e000 	ldc1	\$f4,0\(at\)
  80:	8485 e000 	ldc1	\$f4,0\(a1\)
			80: R_NANOMIPS_LO12	foo\+0x12348765
#pass
