#objdump: -dr --no-show-raw-insn
#name: nanoMIPS lb-pic
#as: -mpic -G0
#source: lb-pic.s

# Test the lb macro with -mpic.

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <text_label>:
   0:	lb	a0,0\(zero\)
   4:	lb	a0,1\(zero\)
   8:	li	a0,32768
   c:	lb	a0,0\(a0\)
  10:	lui	a0,%hi\(0xffff8000\)
  14:	lb	a0,0\(a0\)
  18:	lui	a0,%hi\(0x10000\)
  1c:	lb	a0,0\(a0\)
  20:	lui	a0,%hi\(0x1a000\)
  24:	lb	a0,1445\(a0\)
  28:	lb	a0,0\(a1\)
  2a:	lb	a0,1\(a1\)
  2c:	addiu	a0,a1,32768
  30:	lb	a0,0\(a0\)
  34:	lui	a0,%hi\(0xffff8000\)
  38:	addu	a0,a0,a1
  3c:	lb	a0,0\(a0\)
  40:	lui	a0,%hi\(0x10000\)
  44:	addu	a0,a0,a1
  48:	lb	a0,0\(a0\)
  4c:	lui	a0,%hi\(0x1a000\)
  50:	addu	a0,a0,a1
  54:	lb	a0,1445\(a0\)
  58:	aluipc	a0,0 <data_label>
			58: R_NANOMIPS_PCHI20	data_label
  5c:	lb	a0,0\(a0\)
			5c: R_NANOMIPS_LO12	\.data
  60:	lw	a0,0\(gp\)
			60: R_NANOMIPS_GOT_DISP	big_external_data_label
  64:	lb	a0,0\(a0\)
  68:	lw	a0,0\(gp\)
			68: R_NANOMIPS_GOT_DISP	small_external_data_label
  6c:	lb	a0,0\(a0\)
  70:	lw	a0,0\(gp\)
			70: R_NANOMIPS_GOT_DISP	big_external_common
  74:	lb	a0,0\(a0\)
  78:	lw	a0,0\(gp\)
			78: R_NANOMIPS_GOT_DISP	small_external_common
  7c:	lb	a0,0\(a0\)
  80:	aluipc	a0,0 <big_local_common>
			80: R_NANOMIPS_PCHI20	big_local_common
  84:	lb	a0,0\(a0\)
			84: R_NANOMIPS_LO12	\.bss
  88:	aluipc	a0,3e8 <small_local_common>
			88: R_NANOMIPS_PCHI20	small_local_common
  8c:	lb	a0,0\(a0\)
			8c: R_NANOMIPS_LO12	\.bss\+0x3e8
  90:	aluipc	a0,1 <data_label\+0x1>
			90: R_NANOMIPS_PCHI20	data_label\+0x1
  94:	lb	a0,0\(a0\)
			94: R_NANOMIPS_LO12	\.data\+0x1
  98:	lw	a0,0\(gp\)
			98: R_NANOMIPS_GOT_DISP	big_external_data_label\+0x1
  9c:	lb	a0,0\(a0\)
  a0:	lw	a0,0\(gp\)
			a0: R_NANOMIPS_GOT_DISP	small_external_data_label\+0x1
  a4:	lb	a0,0\(a0\)
  a8:	lw	a0,0\(gp\)
			a8: R_NANOMIPS_GOT_DISP	big_external_common\+0x1
  ac:	lb	a0,0\(a0\)
  b0:	lw	a0,0\(gp\)
			b0: R_NANOMIPS_GOT_DISP	small_external_common\+0x1
  b4:	lb	a0,0\(a0\)
  b8:	aluipc	a0,1 <big_local_common\+0x1>
			b8: R_NANOMIPS_PCHI20	big_local_common\+0x1
  bc:	lb	a0,0\(a0\)
			bc: R_NANOMIPS_LO12	\.bss\+0x1
  c0:	aluipc	a0,3e9 <small_local_common\+0x1>
			c0: R_NANOMIPS_PCHI20	small_local_common\+0x1
  c4:	lb	a0,0\(a0\)
			c4: R_NANOMIPS_LO12	\.bss\+0x3e9
#pass
