/* verify disassembly with local volatile labels.  */

	.text
	.ent	test
test:
	nop
$LVL2 = .
	addiu	$a3,$a3,1
$L2:
$LVL3 = .
	li	$s0,232
	jrc	$ra
	.end	test

	.data
.word $LVL3
.word $LVL2
