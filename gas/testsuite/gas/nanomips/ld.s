# Source file used to test the doubleword memory access macros
# (ld and friends).

	.ifdef mc_large
	.set mcmodel=large
	.endif
	
	.ifdef mc_medium
	.set mcmodel=medium
	.endif
	
# By default test ld.
	.set	d4, $4
	
# If defined, test sd instead.
	.ifdef	tsd
	.macro	ld ops:vararg
	sd	\ops
	.endm
	.endif
# If defined, test l.d instead.
	.ifdef	tl_d
	.set	d4, $f4
	.macro	ld ops:vararg
	l.d	\ops
	.endm
	.endif
# If defined, test s.d instead.
	.ifdef	ts_d
	.set	d4, $f4
	.macro	ld ops:vararg
	s.d	\ops
	.endm
	.endif
# If defined, test ldc1 instead.
	.ifdef	tldc1
	.set	d4, $f4
	.macro	ld ops:vararg
	ldc1	\ops
	.endm
	.endif
# If defined, test sdc1 instead.
	.ifdef	tsdc1
	.set	d4, $f4
	.macro	ld ops:vararg
	sdc1	\ops
	.endm
	.endif
# If defined, test lw instead.
	.ifdef	tlw
	.macro	ld ops:vararg
	lw	\ops
	.endm
	.endif
# If defined, test sw instead.
	.ifdef	tsw
	.macro	ld ops:vararg
	sw	\ops
	.endm
	.endif

	.ifdef	nanomips
	.equ lo_max,0xffc
	.equ hi_min,0x1000
	.else
	.equ lo_max,0x8000
	.equ hi_min,0x10000
	.endif

	.macro	data
	.bss
	.align	12
	.sbss
	.align	12
	.data
	.align	12
data_label:
	.extern big_external_data_label,1000
	.extern small_external_data_label,1
	.comm big_external_common,1000
	.comm small_external_common,1
	.lcomm big_local_common,1000
	.lcomm small_local_common,1
	.endm

	.ifndef	forward
	data
	.endif

	.text
	.align	12
text_label:
	ld	d4,0
	ld	d4,1
	ld	d4,lo_max
	ld	d4,-lo_max
	ld	d4,hi_min
	ld	d4,0x1a5a5
	ld	d4,0($5)
	ld	d4,1($5)
	ld	d4,lo_max($5)
	ld	d4,-lo_max($5)
	ld	d4,hi_min($5)
	ld	d4,0x1a5a5($5)
	ld	d4,data_label
	ld	d4,big_external_data_label
	ld	d4,small_external_data_label
	ld	d4,big_external_common
	ld	d4,small_external_common
	ld	d4,big_local_common
	ld	d4,small_local_common
	ld	d4,data_label+1
	ld	d4,big_external_data_label+1
	ld	d4,small_external_data_label+1
	ld	d4,big_external_common+1
	ld	d4,small_external_common+1
	ld	d4,big_local_common+1
	ld	d4,small_local_common+1
	ld	d4,data_label+lo_max
	ld	d4,big_external_data_label+lo_max
	ld	d4,small_external_data_label+lo_max
	ld	d4,big_external_common+lo_max
	ld	d4,small_external_common+lo_max
	ld	d4,big_local_common+lo_max
	ld	d4,small_local_common+lo_max
	ld	d4,data_label-lo_max
	ld	d4,big_external_data_label-lo_max
	ld	d4,small_external_data_label-lo_max
	ld	d4,big_external_common-lo_max
	ld	d4,small_external_common-lo_max
	ld	d4,big_local_common-lo_max
	ld	d4,small_local_common-lo_max
	ld	d4,data_label+hi_min
	ld	d4,big_external_data_label+hi_min
	ld	d4,small_external_data_label+hi_min
	ld	d4,big_external_common+hi_min
	ld	d4,small_external_common+hi_min
	ld	d4,big_local_common+hi_min
	ld	d4,small_local_common+hi_min
	ld	d4,data_label+0x1a5a5
	ld	d4,big_external_data_label+0x1a5a5
	ld	d4,small_external_data_label+0x1a5a5
	ld	d4,big_external_common+0x1a5a5
	ld	d4,small_external_common+0x1a5a5
	ld	d4,big_local_common+0x1a5a5
	ld	d4,small_local_common+0x1a5a5

# Force at least 8 (non-delay-slot) zero bytes, to make 'objdump' print ...
	.align	2
	.space	8

	.ifdef	forward
	data
	.endif
