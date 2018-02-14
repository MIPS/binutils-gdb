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

	.text
test:
	llwp	$a0, $t5, 0
	llwp	$a1, $t5, 0($zero)
	llwp	$a2, $t5, 8
	llwp	$a3, $t5, 8($zero)
	llwp	$a4, $t5, 32760($zero)
	llwp	$a5, $t5, -3276($zero)
	llwp	$a6, $t5, 65528($zero)
	llwp	$a7, $s0, 0xffff0000($zero)
	llwp	$a7, $s1, 0xffff8000($zero)
	llwp	$a7, $s4, 0xf0000000($zero)
	llwp	$a7, $s5, 0xfffffff8($zero)
	llwp	$a7, $s6, 0x12345678($zero)
	llwp	$a7, $s7, ($a0)
	llwp	$a7, $t8, 0($a0)
	llwp	$a0, $a1, 4($a1)
	llwp	$a1, $a2, 32767($a0)
	llwp	$a2, $a0, -3276($a0)
	llwp	$a3, $a4, 65535($a0)
	llwp	$a4, $a0, 0xffff0000($a0)
	llwp	$a5, $a6, 0xffff8000($a0)
	llwp	$a6, $a7, 0xffff0001($a0)
	llwp	$a7, $a0, 0xffff8001($a0)
	llwp	$t8, $t9, 0xf0000000($a0)
	llwp	$s0, $s1, 0xffffffff($a0)
	llwp	$s1, $s2, 0x12345678($a0)

	scwp	$a0, $t5, 0
	scwp	$a1, $t5, 0($zero)
	scwp	$a2, $t5, 8
	scwp	$a3, $t5, 8($zero)
	scwp	$a4, $t5, 32760($zero)
	scwp	$a5, $t5, -3276($zero)
	scwp	$a6, $t5, 65528($zero)
	scwp	$a7, $s0, 0xffff0000($zero)
	scwp	$a7, $s1, 0xffff8000($zero)
	scwp	$a7, $s4, 0xf0000000($zero)
	scwp	$a7, $s5, 0xfffffff8($zero)
	scwp	$a7, $s6, 0x12345678($zero)
	scwp	$a7, $s7, ($a0)
	scwp	$a7, $t8, 0($a0)
	scwp	$a0, $a1, 4($a1)
	scwp	$a1, $a2, 32767($a0)
	scwp	$a2, $a0, -3276($a0)
	scwp	$a3, $a4, 65535($a0)
	scwp	$a4, $a0, 0xffff0000($a0)
	scwp	$a5, $a6, 0xffff8000($a0)
	scwp	$a6, $a7, 0xffff0001($a0)
	scwp	$a7, $a0, 0xffff8001($a0)
	scwp	$t8, $t9, 0xf0000000($a0)
	scwp	$s0, $s1, 0xffffffff($a0)
	scwp	$s1, $s2, 0x12345678($a0)


	llwpe	$a0, $t5, data_label
	llwpe	$a1, $t5, big_external_data_label
	llwpe	$a2, $t5, small_external_data_label
	llwpe	$a3, $t5, big_external_common
	llwpe	$a4, $t5, small_external_common
	llwpe	$a5, $t5, big_local_common
	llwpe	$a6, $t5, small_local_common
	llwpe	$a7, $s0, data_label+1
	llwpe	$a7, $s1, big_external_data_label+1
	llwpe	$a7, $s4, small_external_data_label+1
	llwpe	$a7, $s5, big_external_common+1
	llwpe	$a7, $s6, small_external_common+1
	llwpe	$a7, $s7, big_local_common+1
	llwpe	$a7, $t8, small_local_common+1
	llwpe	$a0, $a1, data_label+32768
	llwpe	$a1, $a2, big_external_data_label+32768
	llwpe	$a2, $a0, small_external_data_label+32768
	llwpe	$a3, $a4, big_external_common+32768
	llwpe	$a4, $a0, small_external_common+32768
	llwpe	$a5, $a6, big_local_common+32768
	llwpe	$a6, $a7, small_local_common+32768
	llwpe	$a7, $a0, data_label-3276
	llwpe	$t8, $t9, big_external_data_label-3276
	llwpe	$s0, $s1, small_external_data_label-3276
	llwpe	$s1, $s2, big_external_common-3276

	scwpe	$a0, $t5, big_local_common-3276
	scwpe	$a1, $t5, small_local_common-3276
	scwpe	$a2, $t5, small_external_common-3276
	scwpe	$a3, $t5, data_label-1
	scwpe	$a4, $t5, big_external_data_label-1
	scwpe	$a5, $t5, small_external_data_label-1
	scwpe	$a6, $t5, big_external_common-1
	scwpe	$a7, $s0, small_external_common-1
	scwpe	$a7, $s1, big_local_common-1
	scwpe	$a7, $s4, small_local_common-1
