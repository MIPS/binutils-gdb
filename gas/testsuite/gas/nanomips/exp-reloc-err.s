.align 2
.type test, @function
	.ent test, 0
test:
	lw	$r26, %lo(tables)($r27)
	lw	$r26, %hi(tables)($r27)
	lw	$r26, tables($r27)
	.end	test
