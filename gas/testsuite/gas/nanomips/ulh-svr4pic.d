#objdump: -dr --no-show-raw-insn
#name: nanoMIPS ulh-svr4pic
#as: -KPIC
#source: ulh-pic.s

# Test the unaligned load and store macros with -KPIC for nanoMIPS.

.*: +file format .*nanomips.*

Disassembly of section \.text:

0+0000 <text_label>:
   0:	lw	at,0\(gp\)
			0: R_NANOMIPS_GOT_PAGE	\.data
   4:	lh	a0,0\(at\)
			4: R_NANOMIPS_GOT_OFST	\.data
   8:	lw	at,0\(gp\)
			8: R_NANOMIPS_GOT_DISP	big_external_data_label
   c:	lhu	a0,0\(at\)
  10:	lw	at,0\(gp\)
			10: R_NANOMIPS_GOT_DISP	small_external_data_label
  14:	lw	a0,0\(at\)
  18:	lw	at,0\(gp\)
			18: R_NANOMIPS_GOT_DISP	big_external_common
  1c:	sh	a0,0\(at\)
  20:	lw	at,0\(gp\)
			20: R_NANOMIPS_GOT_DISP	small_external_common
  24:	sw	a0,0\(at\)
  28:	lw	at,0\(gp\)
			28: R_NANOMIPS_GOT_PAGE	\.bss
  2c:	lh	a0,0\(at\)
			2c: R_NANOMIPS_GOT_OFST	\.bss
  30:	lw	at,0\(gp\)
			30: R_NANOMIPS_GOT_PAGE	\.bss\+0x3e8
  34:	lhu	a0,0\(at\)
			34: R_NANOMIPS_GOT_OFST	\.bss\+0x3e8
  38:	lw	at,0\(gp\)
			38: R_NANOMIPS_GOT_PAGE	\.data\+0x1
  3c:	lw	a0,0\(at\)
			3c: R_NANOMIPS_GOT_OFST	\.data\+0x1
  40:	lw	at,0\(gp\)
			40: R_NANOMIPS_GOT_DISP	big_external_data_label\+0x1
  44:	sh	a0,0\(at\)
  48:	lw	at,0\(gp\)
			48: R_NANOMIPS_GOT_DISP	small_external_data_label\+0x1
  4c:	sw	a0,0\(at\)
  50:	lw	at,0\(gp\)
			50: R_NANOMIPS_GOT_DISP	big_external_common\+0x1
  54:	lh	a0,0\(at\)
  58:	lw	at,0\(gp\)
			58: R_NANOMIPS_GOT_DISP	small_external_common\+0x1
  5c:	lhu	a0,0\(at\)
  60:	lw	at,0\(gp\)
			60: R_NANOMIPS_GOT_PAGE	\.bss\+0x1
  64:	lw	a0,0\(at\)
			64: R_NANOMIPS_GOT_OFST	\.bss\+0x1
  68:	lw	at,0\(gp\)
			68: R_NANOMIPS_GOT_PAGE	\.bss\+0x3e9
  6c:	sh	a0,0\(at\)
			6c: R_NANOMIPS_GOT_OFST	\.bss\+0x3e9
  70:	nop
  72:	nop
  74:	nop
  76:	nop
