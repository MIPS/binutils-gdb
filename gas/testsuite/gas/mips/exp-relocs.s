	.text
	.align	3
	.ent	test
test:
	lwc1	$f4, %gp_rel(test)($28)
	swc1	$f4, %gp_rel(test)($28)
	ldc1	$f4, %gp_rel(test)($28)
	sdc1	$f4, %gp_rel(test)($28)
	lb	$4, %gp_rel(test)($28)
	lh	$4, %gp_rel(test)($28)
	lw	$4, %gp_rel(test)($28)
	lbu	$4, %gp_rel(test)($28)
	lhu	$4, %gp_rel(test)($28)
	lw	$4, %gp_rel(test)($28)
	sb	$4, %gp_rel(test)($28)
	sh	$4, %gp_rel(test)($28)
	sw	$4, %gp_rel(test)($28)
	addiu	$4, $28, %gp_rel(test)
	addiu.b	$4, $28, %gp_rel(test)
	addiu.w	$4, $28, %gp_rel(test)
	addiu48	$4, $28, %gp_rel(test)
	.end	test
