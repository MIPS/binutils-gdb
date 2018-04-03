#objdump: -dr --prefix-addresses
#as: --defsym tsd=1 -mpcrel
#name: nanoMIPS sd PC-relative
#source: ld.s

# Test PC-relative expansion of the sd macro.

.*: +file format .*nanomips.*

Disassembly of section \.text:
[0-9a-f]+ <text_label> sw	a0,0\(zero\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,4\(zero\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,1\(zero\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,5\(zero\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> li	at,4092
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,0\(at\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,4\(at\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> li	at,-4092
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,0\(at\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,4\(at\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> li	at,4096
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,0\(at\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,4\(at\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <\*ABS\*\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	\*ABS\*\+0x1a5a5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <\*ABS\*\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	\*ABS\*\+0x1a5a9
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,0\(a1\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,4\(a1\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,1\(a1\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,5\(a1\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> addiu	at,a1,4092
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,0\(at\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,4\(at\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> addiu	at,a1,-4092
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,0\(at\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,4\(at\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> addiu	at,a1,4096
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,0\(at\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,4\(at\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <\*ABS\*\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	\*ABS\*\+0x1a5a5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <\*ABS\*\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	\*ABS\*\+0x1a5a9
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <data_label>
			[0-9a-f]+: R_NANOMIPS_PC_I32	data_label
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	data_label\+0x4
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <big_external_data_label>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_data_label
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <big_external_data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_data_label\+0x4
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x4
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <big_external_common>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_common
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <big_external_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_common\+0x4
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x4
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <big_local_common>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_local_common
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <big_local_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_local_common\+0x4
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x4
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	data_label\+0x1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	data_label\+0x5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <big_external_data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_data_label\+0x1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <big_external_data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_data_label\+0x5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <big_external_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_common\+0x1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <big_external_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_common\+0x5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <big_local_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_local_common\+0x1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <big_local_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_local_common\+0x5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	data_label\+0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	data_label\+0x1000
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <big_external_data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_data_label\+0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <big_external_data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_data_label\+0x1000
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1000
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <big_external_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_common\+0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <big_external_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_common\+0x1000
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1000
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <big_local_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_local_common\+0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <big_local_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_local_common\+0x1000
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x1000
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	data_label-0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	data_label-0xff8
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <big_external_data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_data_label-0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <big_external_data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_data_label-0xff8
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <small_external_data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	small_external_data_label-0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <small_external_data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	small_external_data_label-0xff8
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <big_external_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_common-0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <big_external_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_common-0xff8
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <small_external_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	small_external_common-0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <small_external_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	small_external_common-0xff8
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <big_local_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_local_common-0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <big_local_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_local_common-0xff8
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <small_local_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	small_local_common-0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <small_local_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	small_local_common-0xff8
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	data_label\+0x1000
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	data_label\+0x1004
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <big_external_data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_data_label\+0x1000
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <big_external_data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_data_label\+0x1004
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1000
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1004
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <big_external_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_common\+0x1000
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <big_external_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_common\+0x1004
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1000
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1004
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <big_local_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_local_common\+0x1000
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <big_local_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_local_common\+0x1004
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x1000
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x1004
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	data_label\+0x1a5a5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	data_label\+0x1a5a9
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <big_external_data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_data_label\+0x1a5a5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <big_external_data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_data_label\+0x1a5a9
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1a5a5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1a5a9
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <big_external_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_common\+0x1a5a5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <big_external_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_common\+0x1a5a9
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1a5a5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1a5a9
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a0,[0-9a-f]+ <big_local_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_local_common\+0x1a5a5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> swpc	a1,[0-9a-f]+ <big_local_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_local_common\+0x1a5a9
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x1a5a5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> sw	a1,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x1a5a9
#pass
