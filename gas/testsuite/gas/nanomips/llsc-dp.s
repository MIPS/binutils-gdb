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
	lldp	$a0, $t5, 0
	lldp	$a1, $t5, 0($zero)
	lldp	$a2, $t5, 8
	lldp	$a3, $t5, 8($zero)
	lldp	$a4, $t5, 32760($zero)
	lldp	$a5, $t5, -3276($zero)
	lldp	$a6, $t5, 65528($zero)
	lldp	$a7, $s0, 0xffff0000($zero)
	lldp	$a7, $s1, 0xffff8000($zero)
	lldp	$a7, $s4, 0xf0000000($zero)
	lldp	$a7, $s5, 0xfffffff8($zero)
	lldp	$a7, $s6, 0x12345680($zero)
	lldp	$a7, $s7, ($a0)
	lldp	$a7, $t8, 0($a0)
	lldp	$a0, $a1, 4($a1)
	lldp	$a1, $a2, 32767($a0)
	lldp	$a2, $a0, -3276($a0)
	lldp	$a3, $a4, 65535($a0)
	lldp	$a4, $a0, 0xffff0000($a0)
	lldp	$a5, $a6, 0xffff8000($a0)
	lldp	$a6, $a7, 0xffff0001($a0)
	lldp	$a7, $a0, 0xffff8001($a0)
	lldp	$t8, $t9, 0xf0000000($a0)
	lldp	$s0, $s1, 0xffffffff($a0)
	lldp	$s1, $s2, 0x12345678($a0)

	scdp	$a0, $t5, 0
	scdp	$a1, $t5, 0($zero)
	scdp	$a2, $t5, 8
	scdp	$a3, $t5, 8($zero)
	scdp	$a4, $t5, 32760($zero)
	scdp	$a5, $t5, -3276($zero)
	scdp	$a6, $t5, 65528($zero)
	scdp	$a7, $s0, 0xffff0000($zero)
	scdp	$a7, $s1, 0xffff8000($zero)
	scdp	$a7, $s4, 0xf0000000($zero)
	scdp	$a7, $s5, 0xfffffff8($zero)
	scdp	$a7, $s6, 0x12345680($zero)
	scdp	$a7, $s7, ($a0)
	scdp	$a7, $t8, 0($a0)
	scdp	$a0, $a1, 4($a1)
	scdp	$a1, $a2, 32767($a0)
	scdp	$a2, $a0, -3276($a0)
	scdp	$a3, $a4, 65535($a0)
	scdp	$a4, $a0, 0xffff0000($a0)
	scdp	$a5, $a6, 0xffff8000($a0)
	scdp	$a6, $a7, 0xffff0001($a0)
	scdp	$a7, $a0, 0xffff8001($a0)
	scdp	$t8, $t9, 0xf0000000($a0)
	scdp	$s0, $s1, 0xffffffff($a0)
	scdp	$s1, $s2, 0x12345678($a0)


	lldp	$a0, $t5, data_label
	lldp	$a1, $t5, big_external_data_label
	lldp	$a2, $t5, small_external_data_label
	lldp	$a3, $t5, big_external_common
	lldp	$a4, $t5, small_external_common
	lldp	$a5, $t5, big_local_common
	lldp	$a6, $t5, small_local_common
	lldp	$a7, $s0, data_label+1
	lldp	$a7, $s1, big_external_data_label+1
	lldp	$a7, $s4, small_external_data_label+1
	lldp	$a7, $s5, big_external_common+1
	lldp	$a7, $s6, small_external_common+1
	lldp	$a7, $s7, big_local_common+1
	lldp	$a7, $t8, small_local_common+1
	lldp	$a0, $a1, data_label+32768
	lldp	$a1, $a2, big_external_data_label+32768
	lldp	$a2, $a0, small_external_data_label+32768
	lldp	$a3, $a4, big_external_common+32768
	lldp	$a4, $a0, small_external_common+32768
	lldp	$a5, $a6, big_local_common+32768
	lldp	$a6, $a7, small_local_common+32768
	lldp	$a7, $a0, data_label-3276
	lldp	$t8, $t9, big_external_data_label-3276
	lldp	$s0, $s1, small_external_data_label-3276
	lldp	$s1, $s2, big_external_common-3276

	scdp	$a0, $t5, big_local_common-3276
	scdp	$a1, $t5, small_local_common-3276
	scdp	$a2, $t5, small_external_common-3276
	scdp	$a3, $t5, data_label-1
	scdp	$a4, $t5, big_external_data_label-1
	scdp	$a5, $t5, small_external_data_label-1
	scdp	$a6, $t5, big_external_common-1
	scdp	$a7, $s0, small_external_common-1
	scdp	$a7, $s1, big_local_common-1
	scdp	$a7, $s4, small_local_common-1
