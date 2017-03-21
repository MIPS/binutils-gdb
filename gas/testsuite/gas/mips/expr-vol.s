/* Verify disassembly with local volatile labels.  */

	.text
	.ent	test
test:
	nop
$LVL2 = .
	addiu	$7,$7,1
$L2:
$LVL3 = .
	li	$16,232
	jrc	$31
	.end	test

	.data
.word $LVL3
.word $LVL2
