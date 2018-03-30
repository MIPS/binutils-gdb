#objdump: -dr --no-show-raw-insn
#name: load/store indexed macros with 64-bit mode
#source: ldst-indexed.s
#as: -m64

.*: +file format .*nanomips.*

Disassembly of section \.text:

0000000000000000 <text_label>:
   0:	dlui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI32	\.data
   6:	daddiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_I32	\.data
   c:	ldx	a0,a0\(a2\)
  10:	dlui	at,0x0
			[0-9a-f]+: R_NANOMIPS_HI32	big_external_data_label
  16:	daddiu	at,at,0
			[0-9a-f]+: R_NANOMIPS_I32	big_external_data_label
  1c:	lwx	a0,at\(a0\)
  20:	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label
  24:	lhx	a0,a0\(a2\)
  28:	dlui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI32	big_external_common
  2e:	daddiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_I32	big_external_common
  34:	lhux	a0,a0\(a3\)
  38:	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common
  3c:	lbx	a0,a0\(a4\)
  40:	dlui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI32	\.bss
  46:	daddiu	a0,a0,0
			[0-9a-f]+: R_NANOMIPS_I32	\.bss
  4c:	lbux	a0,a0\(a5\)
  50:	addiu	at,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss
  54:	sdx	a0,at\(a6\)
  58:	dlui	at,0x0
			[0-9a-f]+: R_NANOMIPS_HI32	\.data\+0x1
  5e:	daddiu	at,at,0
			[0-9a-f]+: R_NANOMIPS_I32	\.data\+0x1
  64:	swx	a0,at\(a7\)
  68:	dlui	at,0x0
			[0-9a-f]+: R_NANOMIPS_HI32	big_external_data_label\+0x1
  6e:	daddiu	at,at,0
			[0-9a-f]+: R_NANOMIPS_I32	big_external_data_label\+0x1
  74:	shx	a0,at\(t0\)
  78:	addiu	at,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1
  7c:	sbx	a0,at\(s0\)
  80:	dlui	at,0x0
			[0-9a-f]+: R_NANOMIPS_HI32	big_external_common\+0x1
  86:	daddiu	at,at,0
			[0-9a-f]+: R_NANOMIPS_I32	big_external_common\+0x1
  8c:	lwc1x	\$f1,at\(s1\)
  90:	addiu	at,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1
  94:	swc1x	\$f2,at\(s2\)
  98:	dlui	at,0x0
			[0-9a-f]+: R_NANOMIPS_HI32	\.bss\+0x1
  9e:	daddiu	at,at,0
			[0-9a-f]+: R_NANOMIPS_I32	\.bss\+0x1
  a4:	ldc1x	\$f3,at\(s3\)
  a8:	addiu	at,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x1
  ac:	sdc1x	\$f4,at\(s4\)
#pass
