	.text
	.extern test2
	.ent	test
	.globl	test
test:
	.ifndef insn32_broken
	.set noat
	movep	$r4, $r5, $r9, $r8
	movep	$r5, $r6, $r0, $r10
	movep	$r6, $r7, $r5, $r4
	movep	$r7, $r8, $r7, $r6

	movep	$r4, $r5, $r16, $r17
	movep	$r5, $r6, $r18, $r19
	movep	$r6, $r7, $r20, $r21
	movep	$r7, $r8, $r22, $r23
	/* movep[rev] */
	movep[rev]	$r8, $r7, $r4, $r5
	movep	$r9, $r6, $r5, $r6
	movep	$r10, $r5, $r6, $r7
	movep	$r11, $r4, $r7, $r8

	movep	$r16, $r20, $r4, $r5
	movep	$r21, $r17, $r5, $r6
	movep	$r18, $r22, $r6, $r7
	movep	$r23, $r19, $r7, $r8

	/* movep - arg pair reversed */
	movep	$r5, $r4, $r8, $r9
	movep	$r6, $r5, $r10, $r0
	movep	$r7, $r6, $r4, $r5
	movep	$r8, $r7, $r6, $r7

	movep	$r5, $r4, $r17, $r16
	movep	$r6, $r5, $r19, $r18
	movep	$r7, $r6, $r21, $r20
	movep	$r8, $r7, $r23, $r22
	/* movep[rev] - arg pair reversed */
	movep[rev]	$r7, $r8,  $r5, $r4
	movep	$r6, $r9,  $r6, $r5
	movep	$r5, $r10, $r7, $r6
	movep	$r4, $r11, $r8, $r7

	movep	$r20, $r16, $r5, $r4
	movep	$r17, $r21, $r6, $r5
	movep	$r22, $r18, $r7, $r6
	movep	$r19, $r23, $r8, $r7
	.endif

	lw	$r8, 0($r8)
	lw	$r9, 4($r9)
	lw	$r10, 8($r10)
	lw	$r11, 12($r11)

	lw	$r8, 0($r4)
	lw	$r9, 4($r5)
	lw	$r10, 8($r6)
	lw	$r11, 12($r7)

	lw	$r8, 0($r16)
	lw	$r9, 4($r17)
	lw	$r10, 8($r18)
	lw	$r11, 12($r19)

	lw	$r8, 0($r20)
	lw	$r9, 4($r21)
	lw	$r10, 8($r22)
	lw	$r11, 12($r23)

	lw	$r4, 0($r8)
	lw	$r5, 4($r9)
	lw	$r6, 8($r10)
	lw	$r7, 12($r11)

	sw	$r16, 0($r8)
	sw	$r17, 4($r9)
	sw	$r18, 8($r10)
	sw	$r19, 12($r11)

	sw	$r20, 0($r8)
	sw	$r21, 4($r9)
	sw	$r22, 8($r10)
	sw	$r23, 12($r11)

	sw	$r20, 0($r4)
	sw	$r21, 4($r5)
	sw	$r22, 8($r6)
	sw	$r23, 12($r7)

	sw	$r20, 0($r16)
	sw	$r21, 4($r17)
	sw	$r22, 8($r18)
	sw	$r23, 12($r19)

	sw	$r20, 0($r20)
	sw	$r21, 4($r21)
	sw	$r22, 8($r22)
	sw	$r23, 12($r23)

	sw	$r4, 0($r20)
	sw	$r5, 4($r21)
	sw	$r6, 8($r22)
	sw	$r7, 12($r23)

	sw	$r16, 0($r20)
	sw	$r17, 4($r21)
	sw	$r18, 8($r22)
	sw	$r19, 12($r23)

	brsc	$r3
	brsc	$r31

	balrsc	$r16, $r17
	balrsc	$r17

	addiu	$r3, $r28, 0x12345
	.ifndef insn32_broken
	addiu	$r3, $r28, 0x12345678
	addiu	$r3, $r28, -0x12345
	addiu	$r3, $r28, -0x12345678

	addiu	$r3, $r3, 0x12345
	addiu	$r3, 0x12345678
	addiu	$r3, $r3, -0x12345
	addiu	$r3, -0x12345678
	.endif

	bgeiuc	$r2, 1, test
	bgeiuc	$r2, 127, test
	bltiuc	$r2, 1, test
	bltiuc	$r2, 127, test
	
	extw	$r4, $r2, $r3, 0
	extw    $r4, $r2, $r3, 24
	extw    $r4, $r2, $r3, 16
	extw    $r4, $r2, $r3, 8
	extw	$r4, $r2, $r3, 1
	extw    $r4, $r2, $r3, 2
	extw    $r4, $r2, $r3, 3
	extw    $r4, $r2, $r3, 4

	align   $r4, $r2, $r3, 0
	align32 $r4, $r2, $r3, 0
	align   $r4, $r2, $r3, 1
	align   $r4, $r2, $r3, 2
	align   $r4, $r2, $r3, 3

	lwxs	$r4, $r5($r6)
	lwxs	$r7, $r16($r17)
	lwxs	$r18, $r19($r4)

	sw	$r16,%gp_rel(x)($r28)
	sw	$r17,16($r28)
	.ifndef insn32
	sw16	$r17,16($r28)
	sw16	$r17,%gp_rel(test)($r28)
	.endif
	lapc 	$r5,test
	lapc 	$r5,test2
	.set at
	pref 	4,4000($r3)
	pref 	4,-30($r3)
	pref 	4,%lo(test)($r3)

	bbeqzc $r4,24,test
	bbeqzc $r4,1,test
	bbeqzc $r4,31,test
	bbnezc $r4,0,test
	bbnezc $r4,16,test
	teq	$r3,$r4
	tne 	$r5,$r6
	teq	$r3,$r4,6
	tne 	$r5,$r6,7
	.ifndef insn32
	lwpc $r3, 10000
	swpc $r3, 10000
	lapc48 $r3, test
	lwpc $r3, test
	swpc $r3, test
	.endif

	ualh	$r2, 4($r5)
	uash	$r2, 4($r5)
	ualwm	$r2, 4($r5),4
	uaswm	$r2, 4($r5),6
	ualw	$r2, 4($r5)
	uasw	$r2, 4($r5)
	ualwm	$r2, 4($r5),8
	uaswm	$r2, 4($r5),7
	
	lwm	$r2, 4($r5),8
	swm	$r2, 4($r5),7

	rotx    $r2, $r3, 5, 30, 1
	rotx    $r2, $r3, 31, 0
	bitrevw $r2,$r3
	rotx    $r2, $r3, 7, 8, 1
	bitswap $r2,$r3
	bitrevb $r2,$r3
	rotx    $r2, $r3, 15, 16
	bitrevh $r2,$r3
	rotx    $r2, $r3, 24, 8
	byterevw $r2,$r3
	rotx    $r2, $r3, 8, 24
	wsbh 	$r2,$r3
	byterevh 	$r2,$r3

	addiupc		$r5, 0
	addiupc 	$r5, 4
	addiupc 	$r5, 8
	.ifndef insn32
	addiupc48 	$r5, 0
	addiupc48 	$r5,6
	addiupc48 	$r5,8
	.endif
	addiupc 	$r5,2097154
	.ifndef insn32_broken
	addiupc 	$r5,2097156
	.endif
	addiupc 	$r5,-2097148
	.ifndef insn32_broken
	addiupc 	$r5,-2097150
	.endif

	aluipc	$r3,%pcrel_hi(test)
	aluipc	$r3,0x25
	addiu	$r3, $r3, %pcrel_lo(test)

	addu	$r4, $r4, $r5
	addu	$r8, $r8, $r10
	addu	$r16, $r16, $r18
	addu	$r20, $r20, $r23

	addu	$r5, $r5, $r11
	addu	$r10, $r10, $r17
	addu	$r19, $r19, $r22
	addu	$r21, $r21, $r9

	addu	$r8, $r10, $r8
	addu	$r20, $r23, $r20
	addu	$r5, $r11, $r5
	addu	$r10, $r17, $r10
	addu	$r19, $r22, $r19
	addu	$r21, $r9, $r21

	mul	$r6, $r6, $r7
	mul	$r9, $r9, $r11
	mul	$r17, $r17, $r19
	mul	$r22, $r22, $r20

	mul	$r7, $r7, $r9
	mul	$r11, $r11, $r16
	mul	$r18, $r18, $r21
	mul	$r23, $r23, $r8

	mul	$r6, $r7, $r6
	mul	$r9, $r11, $r9
	mul	$r17, $r19, $r17
	mul	$r22, $r20, $r22

	mul	$r7, $r9, $r7
	mul	$r11, $r16, $r11
	mul	$r18, $r21, $r18
	mul	$r23, $r8, $r23

	beqc	$r6, $r7, 1f
	beqc	$r6, $r6, 1f
	beqc 	$r7, $r6, 1f
	beqc 	$r6, $r0, 1f
	nop32
1:
	bnec	$r6, $r7, 2f
	bnec	$r6, $r6, 2f
	bnec 	$r7, $r6, 2f
	bnec 	$r6, $r0, 2f
	nop32
2:
	eretnc
	.end	test
	.align	2
	.space	8
