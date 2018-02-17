# source file to test load/store indexed macro expansions

	.data
data_label:
	.extern big_external_data_label,1000
	.extern small_external_data_label,1
	.comm big_external_common,1000
	.comm small_external_common,1
	.lcomm big_local_common,1000
	.lcomm small_local_common,1

	.text
text_label:
	ld	$a0,data_label($a2)
	lw	$a0,big_external_data_label($a0)
	lh	$a0,small_external_data_label($a2)
	lhu	$a0,big_external_common($a3)
	lb	$a0,small_external_common($a4)
	lbu	$a0,big_local_common($a5)
	.ifndef nms
	sd	$a0,small_local_common($a6)
	sw	$a0,data_label+1($a7)
	sh	$a0,big_external_data_label+1($t0)
	sb	$a0,small_external_data_label+1($s0)
	.endif
	lwc1	$f1,big_external_common+1($s1)
	swc1	$f2,small_external_common+1($s2)
	ldc1	$f3,big_local_common+1($s3)
	sdc1	$f4,small_local_common+1($s4)

	.space 8
