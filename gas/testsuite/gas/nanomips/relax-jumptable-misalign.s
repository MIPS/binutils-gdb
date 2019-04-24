	.text
	.linkrelax
	.ent test
test:
	/* Load-byte unsigned - relaxed to load half-word unsigned
	with 1-byte mis-alignment. */
	.reloc 1f, R_NANOMIPS_JUMPTABLE_LOAD, lbu_2_lhu_table
1:
	lbux	$a1,$a2($a3)
$Lbu_2_lhu_l0:
	.section	.rodata
	.align 1
	.byte 0xa
	.jumptable	1,3,1
lbu_2_lhu_table:
	.byte ($Lbu_2_lhu_l1 - $Lbu_2_lhu_l0) >> 1
	.byte ($Lbu_2_lhu_l2 - $Lbu_2_lhu_l0) >> 1
	.byte ($Lbu_2_lhu_l3 - $Lbu_2_lhu_l0) >> 1
	.text
$Lbu_2_lhu_l1:
	.space 510
$Lbu_2_lhu_l2:
	lw	$a0,%gprel(x)($gp)
$Lbu_2_lhu_l3:

	/* Load-byte unsigned - relaxed to load word signed
	with 1-byte mis-alignment. */
	.reloc 1f, R_NANOMIPS_JUMPTABLE_LOAD, lbu_2_lwx_table
1:
	lbux	$a1,$a2($a3)
$Lbu_2_lwx_l0:
	.section	.rodata
	.align 2
	.byte 0xa
	.jumptable	1,3,1
lbu_2_lwx_table:
	.byte ($Lbu_2_lwx_l1 - $Lbu_2_lwx_l0) >> 1
	.byte ($Lbu_2_lwx_l2 - $Lbu_2_lwx_l0) >> 1
	.byte ($Lbu_2_lwx_l3 - $Lbu_2_lwx_l0) >> 1
	.text
$Lbu_2_lwx_l1:
	.space 131070
$Lbu_2_lwx_l2:
	lw	$a0,%gprel(x)($gp)
$Lbu_2_lwx_l3:

	/* Load-byte signed - relaxed to load word signed due to
	+ve overflow with 2-byte mis-alignment. */
	.reloc 1f, R_NANOMIPS_JUMPTABLE_LOAD, lb_2_lwx_table
1:
	lbx	$a1,$a2($a3)
$Lb_2_lwx_l0:
	.section	.rodata
	.align 2
	.hword 0xaa
	.jumptable	1,3,0
lb_2_lwx_table:
	.sbyte ($Lb_2_lwx_l1 - $Lb_2_lwx_l0) >> 1
	.sbyte ($Lb_2_lwx_l2 - $Lb_2_lwx_l0) >> 1
	.sbyte ($Lb_2_lwx_l3 - $Lb_2_lwx_l0) >> 1
	.text
$Lb_2_lwx_l1:
	.space 65534
$Lb_2_lwx_l2:
	lw	$a0,%gprel(x)($gp)
$Lb_2_lwx_l3:

	/* Load-byte signed - relaxed to load word signed due to
	-ve overflow with 3-byte mis-alignment.  */
	.reloc 1f, R_NANOMIPS_JUMPTABLE_LOAD, lb_2_lwx_neg_table
1:
	lbx	$a1,$a2($a3)
$Lb_2_lwx_neg_l3:
$Lb_2_lwx_neg_l2:
	lw	$a0,%gprel(x)($gp)
$Lb_2_lwx_neg_l1:
	.space 65536
$Lb_2_lwx_neg_l0:
	.section	.rodata
	.align 2
	.hword 0xaa
	.byte 0xa
	.jumptable	1,3,0
lb_2_lwx_neg_table:
	.sbyte ($Lb_2_lwx_neg_l1 - $Lb_2_lwx_neg_l0) >> 1
	.sbyte ($Lb_2_lwx_neg_l2 - $Lb_2_lwx_neg_l0) >> 1
	.sbyte ($Lb_2_lwx_neg_l3 - $Lb_2_lwx_neg_l0) >> 1
	.text

	/* Load-hword unsigned - relaxed to load word signed due to overflow
	   with 2-byte mis-alignment.  */
	.reloc 1f, R_NANOMIPS_JUMPTABLE_LOAD, lhu_2_lwx_table
1:
	lhuxs	$a1,$a2($a3)
$Lhu_2_lwx_l0:
	.section	.rodata
	.align 2
	.hword 0xaa
	.jumptable	2,3,1
lhu_2_lwx_table:
	.hword ($Lhu_2_lwx_l1 - $Lhu_2_lwx_l0) >> 1
	.hword ($Lhu_2_lwx_l2 - $Lhu_2_lwx_l0) >> 1
	.hword ($Lhu_2_lwx_l3 - $Lhu_2_lwx_l0) >> 1
	.text
$Lhu_2_lwx_l1:
	.space 131070
$Lhu_2_lwx_l2:
	lw	$a0,%gprel(x)($gp)
$Lhu_2_lwx_l3:

	/* Load-hword signed - relaxed to load word signed due to +ve overflow
	   with 1-byte mis-alignment.  */
	.reloc 1f, R_NANOMIPS_JUMPTABLE_LOAD, lh_2_lwx_table
1:
	lhxs	$a1,$a2($a3)
$Lh_2_lwx_l0:
	.section	.rodata
	.align 2
	.byte 0xa
	.jumptable	2,3,0
lh_2_lwx_table:
	.shword ($Lh_2_lwx_l1 - $Lh_2_lwx_l0) >> 1
	.shword ($Lh_2_lwx_l2 - $Lh_2_lwx_l0) >> 1
	.shword ($Lh_2_lwx_l3 - $Lh_2_lwx_l0) >> 1
	.text
$Lh_2_lwx_l1:
	.space 65534
$Lh_2_lwx_l2:
	lw	$a0,%gprel(x)($gp)
$Lh_2_lwx_l3:

	/* Load-hword signed - relaxed to load word signed due to -ve overflow
	   with 3-byte mis-alignment.  */
	.reloc 1f, R_NANOMIPS_JUMPTABLE_LOAD, lh_2_lwx_neg_table
1:
	lhxs	$a1,$a2($a3)
$Lh_2_lwx_neg_l3:
$Lh_2_lwx_neg_l2:
	lw	$a0,%gprel(x)($gp)
$Lh_2_lwx_neg_l1:
	.space 65536
$Lh_2_lwx_neg_l0:
	.section	.rodata
	.align 2
	.hword 0xaa
	.byte 0xa
	.jumptable	2,3,0
lh_2_lwx_neg_table:
	.shword ($Lh_2_lwx_neg_l1 - $Lh_2_lwx_neg_l0) >> 1
	.shword ($Lh_2_lwx_neg_l2 - $Lh_2_lwx_neg_l0) >> 1
	.shword ($Lh_2_lwx_neg_l3 - $Lh_2_lwx_neg_l0) >> 1
	.text
	.end test
