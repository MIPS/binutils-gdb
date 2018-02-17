#objdump: -dr --no-show-raw-insn
#name: load/store indexed macros
#source: ldst-indexed.s
#as: --defsym nms=

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <text_label>:
   0:	lui	at,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.data
   4:	ori	at,at,0x0
			[0-9a-f]+: R_NANOMIPS_LO12	\.data
   8:	lwx	a0,at\(a2\)
   c:	addiu	at,at,4
   e:	lwx	a1,at\(a2\)
  12:	lui	at,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_data_label
  16:	ori	at,at,0x0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_data_label
  1a:	lwx	a0,at\(a0\)
  1e:	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label
  22:	lhx	a0,a0\(a2\)
  26:	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_common
  2a:	ori	a0,a0,0x0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_common
  2e:	lhux	a0,a0\(a3\)
  32:	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common
  36:	lbx	a0,a0\(a4\)
  3a:	lui	a0,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.bss
  3e:	ori	a0,a0,0x0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss
  42:	lbux	a0,a0\(a5\)
  46:	lui	at,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	big_external_common\+0x1
  4a:	ori	at,at,0x0
			[0-9a-f]+: R_NANOMIPS_LO12	big_external_common\+0x1
  4e:	lwc1x	\$f1,at\(s1\)
  52:	addiu	at,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1
  56:	swc1x	\$f2,at\(s2\)
  5a:	lui	at,0x0
			[0-9a-f]+: R_NANOMIPS_HI20	\.bss\+0x1
  5e:	ori	at,at,0x0
			[0-9a-f]+: R_NANOMIPS_LO12	\.bss\+0x1
  62:	ldc1x	\$f3,at\(s3\)
  66:	addiu	at,gp,0
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x1
  6a:	sdc1x	\$f4,at\(s4\)
	\.\.\.
#pass