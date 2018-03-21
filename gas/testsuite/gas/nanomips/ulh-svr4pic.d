#objdump: -dr --no-show-raw-insn
#name: nanoMIPS ulh-svr4pic
#as: -mpic
#source: ulh-pic.s

# Test the unaligned load and store macros with -mpic for nanoMIPS.

.*: +file format .*nanomips.*

Disassembly of section \.text:

0+0000 <text_label>:
   0:	lwpc	a0,0 <data_label>
			[0-9a-f]+: R_NANOMIPS_PC_I32	data_label
   6:	lw	at,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	big_external_data_label
   a:	lhu	a0,0\(at\)
   e:	lw	at,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	small_external_data_label
  12:	lw	a0,0\(at\)
  16:	lw	at,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	big_external_common
  1a:	sh	a0,0\(at\)
  1e:	lw	at,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	small_external_common
  22:	sw	a0,0\(at\)
  26:	lwpc	a0,0 <big_local_common>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_local_common
  2c:	lwpc	a0,3e8 <small_local_common>
			[0-9a-f]+: R_NANOMIPS_PC_I32	small_local_common
  32:	lwpc	a0,1 <data_label\+0x1>
			[0-9a-f]+: R_NANOMIPS_PC_I32	data_label\+0x1
  38:	lw	at,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	big_external_data_label\+0x1
  3c:	sh	a0,0\(at\)
  40:	lw	at,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	small_external_data_label\+0x1
  44:	sw	a0,0\(at\)
  48:	lw	at,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	big_external_common\+0x1
  4c:	lh	a0,0\(at\)
  50:	lw	at,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_DISP	small_external_common\+0x1
  54:	lhu	a0,0\(at\)
  58:	lwpc	a0,1 <big_local_common\+0x1>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_local_common\+0x1
  5e:	lwpc	a0,3e9 <small_local_common\+0x1>
			[0-9a-f]+: R_NANOMIPS_PC_I32	small_local_common\+0x1
  64:	nop
  66:	nop
  68:	nop
  6a:	nop
