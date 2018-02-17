#objdump: -dr --no-show-raw-insn
#name: load/store indexed macros

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <text_label>:
   0:	li	at,0x0
			[0-9a-f]+: R_NANOMIPS_I32	\.data
   6:	lwx	a0,at\(a2\)
   a:	addiu	at,at,4
   c:	lwx	a1,at\(a2\)
  10:	li	at,0x0
			[0-9a-f]+: R_NANOMIPS_I32	big_external_data_label
  16:	lwx	a0,at\(a0\)
  1a:	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label
  1e:	lhx	a0,a0\(a2\)
  22:	li	a0,0x0
			[0-9a-f]+: R_NANOMIPS_I32	big_external_common
  28:	lhux	a0,a0\(a3\)
  2c:	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common
  30:	lbx	a0,a0\(a4\)
  34:	li	a0,0x0
			[0-9a-f]+: R_NANOMIPS_I32	\.bss
  3a:	lbux	a0,a0\(a5\)
  3e:	addiu	at,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss
  42:	swx	a0,at\(a6\)
  46:	addiu	at,at,4
  48:	swx	a1,at\(a6\)
  4c:	li	at,0x0
			[0-9a-f]+: R_NANOMIPS_I32	\.data\+0x1
  52:	swx	a0,at\(a7\)
  56:	li	at,0x0
			[0-9a-f]+: R_NANOMIPS_I32	big_external_data_label\+0x1
  5c:	shx	a0,at\(t0\)
  60:	addiu	at,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1
  64:	sbx	a0,at\(s0\)
  68:	li	at,0x0
			[0-9a-f]+: R_NANOMIPS_I32	big_external_common\+0x1
  6e:	lwc1x	\$f1,at\(s1\)
  72:	addiu	at,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1
  76:	swc1x	\$f2,at\(s2\)
  7a:	li	at,0x0
			[0-9a-f]+: R_NANOMIPS_I32	\.bss\+0x1
  80:	ldc1x	\$f3,at\(s3\)
  84:	addiu	at,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x1
  88:	sdc1x	\$f4,at\(s4\)
	\.\.\.
