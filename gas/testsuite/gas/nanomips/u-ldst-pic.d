#objdump: -dr --no-show-raw-insn
#name: nanoMIPS uld/ust pic
#as: -mpic -G0

# Test the unaligned load and store macros with -mpic for nanoMIPS.

.*: +file format .*nanomips.*

Disassembly of section \.text:

0+0000 <text_label>:
   0:	lapc	at,0 <data_label>
			2: R_NANOMIPS_PC_I32	data_label
   6:	ualh	a0,0\(at\)
   a:	lw	at,0\(gp\)
			a: R_NANOMIPS_GOT_DISP	small_external_data_label
   e:	ualw	a0,0\(at\)
  12:	lw	at,0\(gp\)
			12: R_NANOMIPS_GOT_DISP	big_external_common
  16:	uash	a0,0\(at\)
  1a:	lw	at,0\(gp\)
			1a: R_NANOMIPS_GOT_DISP	small_external_common
  1e:	uasw	a0,0\(at\)
  22:	lapc	at,0 <big_local_common>
			24: R_NANOMIPS_PC_I32	big_local_common
  28:	ualh	a0,0\(at\)
  2c:	lapc	at,1 <data_label\+0x1>
			2e: R_NANOMIPS_PC_I32	data_label\+0x1
  32:	ualw	a0,0\(at\)
  36:	lw	at,0\(gp\)
			36: R_NANOMIPS_GOT_DISP	big_external_data_label\+0x1
  3a:	uash	a0,0\(at\)
  3e:	lw	at,0\(gp\)
			3e: R_NANOMIPS_GOT_DISP	small_external_data_label\+0x1
  42:	uasw	a0,0\(at\)
  46:	lw	at,0\(gp\)
			46: R_NANOMIPS_GOT_DISP	big_external_common\+0x1
  4a:	ualh	a0,0\(at\)
  4e:	lapc	at,1 <big_local_common\+0x1>
			50: R_NANOMIPS_PC_I32	big_local_common\+0x1
  54:	ualw	a0,0\(at\)
  58:	lapc	at,3e9 <small_local_common\+0x1>
			5a: R_NANOMIPS_PC_I32	small_local_common\+0x1
  5e:	uash	a0,0\(at\)
  62:	lapc	at,3e9 <small_local_common\+0x1>
			64: R_NANOMIPS_PC_I32	small_local_common\+0x1
  68:	uasw	a0,0\(at\)
#pass
