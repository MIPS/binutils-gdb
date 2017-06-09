	.text
	.align	3
	.ent	test
test:
	lwc1	$f4, %gp_rel(test)($gp)
	swc1	$f4, %gp_rel(test)($gp)
	ldc1	$f4, %gp_rel(test)($gp)
	sdc1	$f4, %gp_rel(test)($gp)
	lb	$a0, %gp_rel(test)($gp)
	lh	$a0, %gp_rel(test)($gp)
	lw	$a0, %gp_rel(test)($gp)
	lbu	$a0, %gp_rel(test)($gp)
	lhu	$a0, %gp_rel(test)($gp)
	lw	$a0, %gp_rel(test)($gp)
	sb	$a0, %gp_rel(test)($gp)
	sh	$a0, %gp_rel(test)($gp)
	sw	$a0, %gp_rel(test)($gp)
	addiu	$a0, $gp, %gp_rel(test)
	addiu.b	$a0, $gp, %gp_rel(test)
	addiu.w	$a0, $gp, %gp_rel(test)
	addiu48	$a0, $gp, %gp_rel(test)
	.end	test
