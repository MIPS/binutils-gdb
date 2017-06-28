	.text
test:
	addiu[r1.sp] $a0, $sp, 8
	addiu[r2] $a0, $a1, 4
	addiu[rs5] $t0, $t0, 3
	addiu[gp.b] $a0, $gp, %gprel(test)
	addiu[gp.w] $a0, $gp, %gprel(test)
	addiu[neg] $a0, $a1, -4
	addiu[32] $a0, $a1, 64
	addiu[48] $a0, $a0, 12
	addiu[gp48] $a0, $gp, %gprel32(test)

	addiu[r1.sp]16 $a0, $sp, 8
	addiu[r2]16 $a0, $a1, 4
	addiu[rs5]16 $t0, $t0, 3
	addiu[gp.b]32 $a0, $gp, %gprel(test)
	addiu[gp.w]32 $a0, $gp, %gprel(test)
	addiu[neg]32 $a0, $a1, -4
	addiu[32]32 $a0, $a1, 64
	addiu[48]48 $a0, $a0, 12
	addiu[gp48]48 $a0, $gp, %gprel32(test)
	
	lw[16]	$a0,8($a1)
	lw[4x4] $a1,12($a2)
	lw[gp16] $a3,24($gp)
	lw[gp16] $a3,%gprel(test)($gp)
	lw[sp]	$a3,20($sp)
	lw[gp] $a3,224($gp)
	lw[gp] $a3,%gprel(test)($gp)
	lw[s9]	$a3,20($s0)
	lw[u12] $a3,20($s1)
	lwpc[48] $a3,test

	lw[16]16 $a0,8($a1)
	lw[4x4]16 $a1,12($a2)
	lw[gp16]16 $a3,24($gp)
	lw[gp16]16 $a3,%gprel(test)($gp)
	lw[sp]16 $a3,20($sp)
	lw[gp]32 $a3,224($gp)
	lw[gp]32 $a3,%gprel(test)($gp)
	lw[s9]32 $a3,20($s0)
	lw[u12]32 $a3,20($s1)
	lwpc[48]48 $a3,test
