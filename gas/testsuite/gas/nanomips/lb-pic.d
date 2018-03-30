#objdump: -dr --no-show-raw-insn
#name: nanoMIPS lb-pic
#as: -mpic
#source: lb-pic.s

# Test the lb macro with -mpic.

.*: +file format .*nanomips.*

Disassembly of section \.text:

[0-9a-f]+ <text_label>:
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
  58:	lwpc	a0,0 <data_label>
			[0-9a-f]+: R_NANOMIPS_PC_I32	data_label
  5e:	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	big_external_data_label
  62:	lb	a0,0\(a0\)
  66:	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	small_external_data_label
  6a:	lb	a0,0\(a0\)
  6e:	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	big_external_common
  72:	lb	a0,0\(a0\)
  76:	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	small_external_common
  7a:	lb	a0,0\(a0\)
  7e:	lwpc	a0,0 <big_local_common>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_local_common
  84:	lwpc	a0,3e8 <small_local_common>
			[0-9a-f]+: R_NANOMIPS_PC_I32	small_local_common
  8a:	lwpc	a0,1 <data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	data_label\+0x1
  90:	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	big_external_data_label\+0x1
  94:	lb	a0,0\(a0\)
  98:	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	small_external_data_label\+0x1
  9c:	lb	a0,0\(a0\)
  a0:	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	big_external_common\+0x1
  a4:	lb	a0,0\(a0\)
  a8:	lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	small_external_common\+0x1
  ac:	lb	a0,0\(a0\)
  b0:	lwpc	a0,1 <big_local_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_local_common\+0x1
  b6:	lwpc	a0,3e9 <small_local_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	small_local_common\+0x1
#pass
