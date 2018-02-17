.align 2
.type test, @function
	.ent test, 0
test:
	ulw	$r26, %lo(tables)($r27)
	ulh	$r26, %hi(tables)($r27)
	ulhu	$r26, tables($r27)
	.end	test
