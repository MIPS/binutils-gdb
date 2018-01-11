	.ent test
test:
	addiu		$a0, $gp, 2
	addiu32		$a0, $gp, 4
	addiu48		$a0, $gp, 8
	addiu[gp.b]	$a0, $gp, 5
	addiu[gp.w]	$a0, $gp, 32
	addiu[gp48]	$a0, $gp, 0x123456
	addiu.b		$a0, $gp, 7
	addiu.w		$a0, $gp, 0x7fffc
	addiu.b32	$a0, $gp, 0x123456
	addiu		$a0, $gp, %gprel(test)
	addiu32		$a0, $gp, %gprel(test)
	addiu48		$a0, $gp, %gprel(test)
	addiu[gp.b]	$a0, $gp, %gprel(test)
	addiu[gp.w]	$a0, $gp, %gprel(test)
	addiu[gp48]	$a0, $gp, %gprel(test)
	addiu.b		$a0, $gp, %gprel(test)
	addiu.w		$a0, $gp, %gprel(test)
	addiu.b32	$a0, $gp, %gprel(test)
	.end test
