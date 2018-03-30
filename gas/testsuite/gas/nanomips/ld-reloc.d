#objdump: -dr
#name: LD with relocation operators for nanoMIPS

.*file format.*

Disassembly of section \.text:

00000000 <func>:
   0:	84a4 8004 	lw	a1,4\(a0\)
   4:	8484 8000 	lw	a0,0\(a0\)
   8:	0024 7ffb 	addiu	at,a0,32763
   c:	8481 8000 	lw	a0,0\(at\)
  10:	84a1 8004 	lw	a1,4\(at\)
  14:	0024 7ffc 	addiu	at,a0,32764
  18:	8481 8000 	lw	a0,0\(at\)
  1c:	84a1 8004 	lw	a1,4\(at\)
  20:	0024 7fff 	addiu	at,a0,32767
  24:	8481 8000 	lw	a0,0\(at\)
  28:	84a1 8004 	lw	a1,4\(at\)
  2c:	0024 8000 	addiu	at,a0,32768
  30:	8481 8000 	lw	a0,0\(at\)
  34:	84a1 8004 	lw	a1,4\(at\)
  38:	8485 8000 	lw	a0,0\(a1\)
  3c:	84a5 8004 	lw	a1,4\(a1\)
  40:	0025 7ffb 	addiu	at,a1,32763
  44:	8481 8000 	lw	a0,0\(at\)
  48:	84a1 8004 	lw	a1,4\(at\)
  4c:	0025 7ffc 	addiu	at,a1,32764
  50:	8481 8000 	lw	a0,0\(at\)
  54:	84a1 8004 	lw	a1,4\(at\)
  58:	0025 7fff 	addiu	at,a1,32767
  5c:	8481 8000 	lw	a0,0\(at\)
  60:	84a1 8004 	lw	a1,4\(at\)
  64:	0025 8000 	addiu	at,a1,32768
  68:	8481 8000 	lw	a0,0\(at\)
  6c:	84a1 8004 	lw	a1,4\(at\)
  70:	e023 7000 	lui	at,%hi\(0x37000\)
  74:	2025 0950 	addu	at,a1,at
  78:	8481 8ffb 	lw	a0,4091\(at\)
  7c:	84a1 8fff 	lw	a1,4095\(at\)
  80:	e023 7000 	lui	at,%hi\(0x37000\)
  84:	8021 0ffc 	ori	at,at,0xffc
  88:	2025 0950 	addu	at,a1,at
  8c:	8481 8000 	lw	a0,0\(at\)
  90:	84a1 8004 	lw	a1,4\(at\)
  94:	e023 7000 	lui	at,%hi\(0x37000\)
  98:	8021 0fff 	ori	at,at,0xfff
  9c:	2025 0950 	addu	at,a1,at
  a0:	8481 8000 	lw	a0,0\(at\)
  a4:	84a1 8004 	lw	a1,4\(at\)
  a8:	e023 8000 	lui	at,%hi\(0x38000\)
  ac:	2025 0950 	addu	at,a1,at
  b0:	8481 8000 	lw	a0,0\(at\)
  b4:	84a1 8004 	lw	a1,4\(at\)
  b8:	8480 8000 	lw	a0,0\(zero\)
			b8: R_NANOMIPS_LO12	foo
  bc:	84a0 8000 	lw	a1,0\(zero\)
			bc: R_NANOMIPS_LO12	foo\+0x4
  c0:	4080 0002 	lw	a0,0\(gp\)
			c0: R_NANOMIPS_GPREL19_S2	foo
  c4:	40a0 0002 	lw	a1,0\(gp\)
			c4: R_NANOMIPS_GPREL19_S2	foo\+0x4
  c8:	8480 8765 	lw	a0,1893\(zero\)
  cc:	84a0 8769 	lw	a1,1897\(zero\)
  d0:	e034 8244 	lui	at,%hi\(0x12348000\)
  d4:	8481 8000 	lw	a0,0\(at\)
  d8:	84a1 8004 	lw	a1,4\(at\)
  dc:	84a4 8000 	lw	a1,0\(a0\)
			dc: R_NANOMIPS_LO12	foo\+0x4
  e0:	8484 8000 	lw	a0,0\(a0\)
			e0: R_NANOMIPS_LO12	foo
  e4:	8485 8000 	lw	a0,0\(a1\)
			e4: R_NANOMIPS_LO12	foo
  e8:	84a5 8000 	lw	a1,0\(a1\)
			e8: R_NANOMIPS_LO12	foo\+0x4
  ec:	8485 8765 	lw	a0,1893\(a1\)
  f0:	84a5 8769 	lw	a1,1897\(a1\)
  f4:	e034 8244 	lui	at,%hi\(0x12348000\)
  f8:	2025 0950 	addu	at,a1,at
  fc:	8481 8000 	lw	a0,0\(at\)
 100:	84a1 8004 	lw	a1,4\(at\)
 104:	8485 8000 	lw	a0,0\(a1\)
			104: R_NANOMIPS_LO12	foo\+0x12348765
 108:	84a5 8000 	lw	a1,0\(a1\)
			108: R_NANOMIPS_LO12	foo\+0x12348769
#pass
