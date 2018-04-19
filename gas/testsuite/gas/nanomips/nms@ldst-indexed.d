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
#pass
