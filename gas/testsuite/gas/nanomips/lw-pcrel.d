#objdump: -dr --prefix-addresses
#as: --defsym tlw=1 -mpcrel
#name: nanoMIPS lw PC-relative
#source: ld.s

# Test PC-relative expansion of the lw macro.

.*: +file format .*nanomips.*

Disassembly of section \.text:
[0-9a-f]+ <text_label> lw	a0,0\(zero\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,1\(zero\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,4092\(zero\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> li	a0,-4092
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,0\(a0\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> li	a0,4096
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,0\(a0\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lui	a0,%hi\(0x1a000\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,1445\(a0\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,0\(a1\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,1\(a1\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,4092\(a1\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> addiu	a0,a1,-4092
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,0\(a0\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> addiu	a0,a1,4096
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,0\(a0\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lui	a0,%hi\(0x1a000\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> addu	a0,a0,a1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,1445\(a0\)
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <data_label>
			[0-9a-f]+: R_NANOMIPS_PC_I32	data_label
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <big_external_data_label>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_data_label
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <big_external_common>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_common
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <big_local_common>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_local_common
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	data_label\+0x1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <big_external_data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_data_label\+0x1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <big_external_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_common\+0x1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <big_local_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_local_common\+0x1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x1
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	data_label\+0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <big_external_data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_data_label\+0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <big_external_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_common\+0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <big_local_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_local_common\+0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	data_label-0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <big_external_data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_data_label-0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <small_external_data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	small_external_data_label-0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <big_external_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_common-0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <small_external_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	small_external_common-0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <big_local_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_local_common-0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <small_local_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	small_local_common-0xffc
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	data_label\+0x1000
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <big_external_data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_data_label\+0x1000
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1000
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <big_external_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_common\+0x1000
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1000
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <big_local_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_local_common\+0x1000
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x1000
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	data_label\+0x1a5a5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <big_external_data_label\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_data_label\+0x1a5a5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_data_label\+0x1a5a5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <big_external_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_external_common\+0x1a5a5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	small_external_common\+0x1a5a5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lwpc	a0,[0-9a-f]+ <big_local_common\+0x[0-9a-f]+>
			[0-9a-f]+: R_NANOMIPS_PC_I32	big_local_common\+0x1a5a5
[0-9a-f]+ <text_label\+0x[0-9a-f]+> lw	a0,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GPREL19_S2	\.sbss\+0x1a5a5
#pass
