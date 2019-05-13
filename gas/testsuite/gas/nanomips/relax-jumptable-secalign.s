/* Check for section alignment - reduced test case to so that
   there is no larger alignment requested in the source for .rodata.  */

	.text
	.linkrelax
	.ent test
test:
	/* Load-byte unsigned - relaxed to load word signed
	with 1-byte mis-alignment. */
	.reloc 1f, R_NANOMIPS_JUMPTABLE_LOAD, lbu_2_lwx_table
1:
	lbux	$a1,$a2($a3)
$Lbu_2_lwx_l0:
	.section	.rodata
	.align 1
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
	.end test
