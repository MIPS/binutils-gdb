	.text
test8:
	addiu[r1.sp]32 $a0, $sp, 8
	addiu[r2]32 $a0, $a1, 4
	addiu[rs5]48 $t0, $t0, 3
	addiu[gp.b]16 $a0, $gp, %gprel(test8)
	addiu[gp.w]16 $a0, $gp, %gprel(test8)
	addiu[neg]48 $a0, $a1, -4
	addiu[32]48 $a0, $a1, 64
	addiu[48]32 $a0, $a0, 12
	addiu[gp48]16 $a0, $gp, %gprel32(test8)
	
	lw[16]32 $a0,8($a1)
	lw[4x4]32 $a1,12($a2)
	lw[gp16]48 $a3,24($gp)
	lw[gp16]32 $a3,%gprel(test8)($gp)
	lw[sp]32 $a3,20($sp)
	lw[gp]16 $a3,224($gp)
	lw[gp]48 $a3,%gprel(test8)($gp)
	lw[s9]48 $a3,20($s0)
	lw[u12]16 $a3,20($s1)
	lwpc[48]32 $a3,test8
