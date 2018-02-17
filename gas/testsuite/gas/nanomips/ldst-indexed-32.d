#objdump: -dr --no-show-raw-insn
#name: load/store indexed macros with insn32 mode
#source: ldst-indexed.s
#as: -minsn32

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <text_label>:
   0:	lui	at,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.data
   4:	ori	at,at,0x0
			[0-9a-f]+: R_NANOMIPS_LO12	\.data
   8:	lwx	a0,at\(a2\)
   c:	addiu	at,at,4
  10:	lwx	a1,at\(a2\)
  14:	lui	at,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_data_label
  18:	ori	at,at,0x0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_data_label
  1c:	lwx	a0,at\(a0\)
  20:	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label
  24:	lhx	a0,a0\(a2\)
  28:	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_common
  2c:	ori	a0,a0,0x0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_common
  30:	lhux	a0,a0\(a3\)
  34:	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common
  38:	lbx	a0,a0\(a4\)
  3c:	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.bss
  40:	ori	a0,a0,0x0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss
  44:	lbux	a0,a0\(a5\)
  48:	addiu	at,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss
  4c:	swx	a0,at\(a6\)
  50:	addiu	at,at,4
  54:	swx	a1,at\(a6\)
  58:	lui	at,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.data\+0x1
  5c:	ori	at,at,0x0
			[0-9a-f]+: R_NANOMIPS_LO12	\.data\+0x1
  60:	swx	a0,at\(a7\)
  64:	lui	at,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_data_label\+0x1
  68:	ori	at,at,0x0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_data_label\+0x1
  6c:	shx	a0,at\(t0\)
  70:	addiu	at,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1
  74:	sbx	a0,at\(s0\)
  78:	lui	at,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_common\+0x1
  7c:	ori	at,at,0x0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_common\+0x1
  80:	lwc1x	\$f1,at\(s1\)
  84:	addiu	at,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1
  88:	swc1x	\$f2,at\(s2\)
  8c:	lui	at,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.bss\+0x1
  90:	ori	at,at,0x0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss\+0x1
  94:	ldc1x	\$f3,at\(s3\)
  98:	addiu	at,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x1
  9c:	sdc1x	\$f4,at\(s4\)
	\.\.\.
