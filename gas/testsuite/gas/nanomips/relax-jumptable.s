	.text
	.linkrelax
	.ent test
test:
	/* Load-byte unsigned - in range (no relaxation)  */
	.reloc 1f, R_NANOMIPS_JUMPTABLE_LOAD, lbu_nc_table
1:	
	lbux	$a1,$a2($a3)
$Lbu_nc_l0:
	.section        .rodata,"a",@progbits
	.jumptable	1,3,1
lbu_nc_table:
	.byte ($Lbu_nc_l1 - $Lbu_nc_l0) >> 1
	.byte ($Lbu_nc_l2 - $Lbu_nc_l0) >> 1
	.byte ($Lbu_nc_l3 - $Lbu_nc_l0) >> 1
	.text
$Lbu_nc_l1:
	nop32
$Lbu_nc_l2:
	nop32
$Lbu_nc_l3:

	/* Load-byte unsigned - relaxed to load half-word unsigned  */
	.reloc 1f, R_NANOMIPS_JUMPTABLE_LOAD, lbu_2_lhu_table
1:	
	lbux	$a1,$a2($a3)
$Lbu_2_lhu_l0:	
	.section        .rodata,"a",@progbits
	.align 1
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

	/* Load-byte unsigned - relaxed to load word signed  */
	.reloc 1f, R_NANOMIPS_JUMPTABLE_LOAD, lbu_2_lwx_table
1:
	lbux	$a1,$a2($a3)
$Lbu_2_lwx_l0:	
	.section        .rodata,"a",@progbits
	.align 1
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

	/* Load-byte signed - in range (no relaxation)  */
	.reloc 1f, R_NANOMIPS_JUMPTABLE_LOAD, lb_nc_table
1:	
	lbx	$a1,$a2($a3)
$Lb_nc_l3:
	nop32
$Lb_nc_l0:
	.section        .rodata,"a",@progbits
	.jumptable	1,3,0
lb_nc_table:
	.sbyte ($Lb_nc_l1 - $Lb_nc_l0) >> 1
	.sbyte ($Lb_nc_l2 - $Lb_nc_l0) >> 1
	.sbyte ($Lb_nc_l3 - $Lb_nc_l0) >> 1
	.text
$Lb_nc_l1:
	nop32
$Lb_nc_l2:
	nop32


	/* Load-byte signed - relaxed to load half-word signed due to +ve overflow  */
	.reloc 1f, R_NANOMIPS_JUMPTABLE_LOAD, lb_2_lh_table
1:	
	lbx	$a1,$a2($a3)
$Lb_2_lh_l0:	
	.section        .rodata,"a",@progbits
	.align 1
	.jumptable	1,3,0
lb_2_lh_table:
	.sbyte ($Lb_2_lh_l1 - $Lb_2_lh_l0) >> 1
	.sbyte ($Lb_2_lh_l2 - $Lb_2_lh_l0) >> 1
	.sbyte ($Lb_2_lh_l3 - $Lb_2_lh_l0) >> 1
	.text
$Lb_2_lh_l1:
	.space 254
$Lb_2_lh_l2:
	lw	$a0,%gprel(x)($gp)
$Lb_2_lh_l3:

	/* Load-byte signed - relaxed to load half-word signed due to -ve overflow  */
	.reloc 1f, R_NANOMIPS_JUMPTABLE_LOAD, lb_2_lh_neg_table
1:	
	lbx	$a1,$a2($a3)
$Lb_2_lh_neg_l3:
	nop
$Lb_2_lh_neg_l2:
	lw	$a0,%gprel(x)($gp)
$Lb_2_lh_neg_l1:
	.space 256
$Lb_2_lh_neg_l0:	
	.section        .rodata,"a",@progbits
	.align 1
	.jumptable	1,3,0
lb_2_lh_neg_table:
	.sbyte ($Lb_2_lh_neg_l1 - $Lb_2_lh_neg_l0) >> 1
	.sbyte ($Lb_2_lh_neg_l2 - $Lb_2_lh_neg_l0) >> 1
	.sbyte ($Lb_2_lh_neg_l3 - $Lb_2_lh_neg_l0) >> 1
	.text

	/* Load-byte signed - relaxed to load word signed due to +ve overflow  */
	.reloc 1f, R_NANOMIPS_JUMPTABLE_LOAD, lb_2_lwx_table
1:
	lbx	$a1,$a2($a3)
$Lb_2_lwx_l0:	
	.section        .rodata,"a",@progbits
	.align 1
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

	/* Load-byte signed - relaxed to load word signed due to -ve overflow  */
	.reloc 1f, R_NANOMIPS_JUMPTABLE_LOAD, lb_2_lwx_neg_table
1:
	lbx	$a1,$a2($a3)
$Lb_2_lwx_neg_l3:
$Lb_2_lwx_neg_l2:
	lw	$a0,%gprel(x)($gp)
$Lb_2_lwx_neg_l1:
	.space 65536
$Lb_2_lwx_neg_l0:	
	.section        .rodata,"a",@progbits
	.align 1
	.jumptable	1,3,0
lb_2_lwx_neg_table:
	.sbyte ($Lb_2_lwx_neg_l1 - $Lb_2_lwx_neg_l0) >> 1
	.sbyte ($Lb_2_lwx_neg_l2 - $Lb_2_lwx_neg_l0) >> 1
	.sbyte ($Lb_2_lwx_neg_l3 - $Lb_2_lwx_neg_l0) >> 1
	.text

	/* Load half-word unsigned - in range (no relaxation)  */
	.reloc 1f, R_NANOMIPS_JUMPTABLE_LOAD, lhu_nc_table
1:	
	lhuxs	$a1,$a2($a3)
$Lhu_nc_l0:
	.section        .rodata,"a",@progbits
	.jumptable	2,3,1
lhu_nc_table:
	.hword ($Lhu_nc_l1 - $Lhu_nc_l0) >> 1
	.hword ($Lhu_nc_l2 - $Lhu_nc_l0) >> 1
	.hword ($Lhu_nc_l3 - $Lhu_nc_l0) >> 1
	.text
$Lhu_nc_l1:
	nop32
$Lhu_nc_l2:
	nop32
$Lhu_nc_l3:

	/* Load-hword unsigned - relaxed to load word signed due to overflow  */
	.reloc 1f, R_NANOMIPS_JUMPTABLE_LOAD, lhu_2_lwx_table
1:
	lhuxs	$a1,$a2($a3)
$Lhu_2_lwx_l0:	
	.section        .rodata,"a",@progbits
	.align 1
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
	
	/* Load half-word signed - in range (no relaxation)  */
	.reloc 1f, R_NANOMIPS_JUMPTABLE_LOAD, lh_nc_table
1:	
	lhxs	$a1,$a2($a3)
$Lh_nc_l3:
	nop32
$Lh_nc_l0:
	.section        .rodata,"a",@progbits
	.jumptable	2,3,0
lh_nc_table:
	.shword ($Lh_nc_l1 - $Lh_nc_l0) >> 1
	.shword ($Lh_nc_l2 - $Lh_nc_l0) >> 1
	.shword ($Lh_nc_l3 - $Lh_nc_l0) >> 1
	.text
$Lh_nc_l1:
	nop32
$Lh_nc_l2:
	nop32

	/* Load-hword signed - relaxed to load word signed due to +ve overflow  */
	.reloc 1f, R_NANOMIPS_JUMPTABLE_LOAD, lh_2_lwx_table
1:
	lhxs	$a1,$a2($a3)
$Lh_2_lwx_l0:	
	.section        .rodata,"a",@progbits
	.align 1
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

	/* Load-hword signed - relaxed to load word signed due to -ve overflow  */	
	.reloc 1f, R_NANOMIPS_JUMPTABLE_LOAD, lh_2_lwx_neg_table
1:
	lhxs	$a1,$a2($a3)
$Lh_2_lwx_neg_l3:
$Lh_2_lwx_neg_l2:
	lw	$a0,%gprel(x)($gp)
$Lh_2_lwx_neg_l1:
	.space 65536
$Lh_2_lwx_neg_l0:	
	.section        .rodata,"a",@progbits
	.align 1
	.jumptable	2,3,0
lh_2_lwx_neg_table:
	.shword ($Lh_2_lwx_neg_l1 - $Lh_2_lwx_neg_l0) >> 1
	.shword ($Lh_2_lwx_neg_l2 - $Lh_2_lwx_neg_l0) >> 1
	.shword ($Lh_2_lwx_neg_l3 - $Lh_2_lwx_neg_l0) >> 1
	.text

	/* Load word signed - in range (no relaxation)  */
	.reloc 1f, R_NANOMIPS_JUMPTABLE_LOAD, lw_nc_table
1:	
	lwx	$a1,$a2($a3)
$Lw_nc_l3:
	nop32
$Lw_nc_l0:
	.section        .rodata,"a",@progbits
	.jumptable	4,3,0
lw_nc_table:
	.word ($Lw_nc_l1 - $Lw_nc_l0) >> 1
	.word ($Lw_nc_l2 - $Lw_nc_l0) >> 1
	.word ($Lw_nc_l3 - $Lw_nc_l0) >> 1
	.text
$Lw_nc_l1:
	nop32
$Lw_nc_l2:
	nop32

	.end test
