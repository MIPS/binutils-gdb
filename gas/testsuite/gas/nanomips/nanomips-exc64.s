	.text
	.ent test
test:	
	ualdm	$r2, 4($r5),4
	uasdm	$r2, 4($r5),6
	uald	$r2, 4($r5)
	uasd	$r2, 4($r5)
	ualdm	$r2, 4($r5),8
	uasdm	$r2, 4($r5),7
	ldm	$r2, 4($r5),8
	sdm	$r2, 4($r5),7
	.ifndef insn32
	ldpc $r5, 10000
	sdpc $r8, 10000
	ldpc $r5, test
	sdpc $r8, test
	.endif
	.end test
