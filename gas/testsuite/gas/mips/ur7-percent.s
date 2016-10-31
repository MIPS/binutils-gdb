	.text
	.align	3
	.ent	test
test:
	lwc1	$f4, %gp_rel(.L0)($28)
	swc1	$f4, %gp_rel(.L0)($28)
	ldc1	$f4, %gp_rel(.L0)($28)
	sdc1	$f4, %gp_rel(.L0)($28)
	.end	test
