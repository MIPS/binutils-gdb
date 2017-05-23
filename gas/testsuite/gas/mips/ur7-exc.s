	.text
	.extern test2
	.ent	test
	.globl	test
test:
	.set noat
	movep	$4, $5, $9, $8
	movep	$5, $6, $0, $10
	movep	$6, $7, $5, $4
	movep	$7, $8, $7, $6

	movep	$4, $5, $16, $17
	movep	$5, $6, $18, $19
	movep	$6, $7, $20, $21
	movep	$7, $8, $22, $23
	/* movep[rev] */
	movep	$8, $7, $4, $5
	movep	$9, $6, $5, $6
	movep	$10, $5, $6, $7
	movep	$11, $4, $7, $8

	movep	$16, $20, $4, $5
	movep	$21, $17, $5, $6
	movep	$18, $22, $6, $7
	movep	$23, $19, $7, $8

	lw	$8, 0($8)
	lw	$9, 4($9)
	lw	$10, 8($10)
	lw	$11, 12($11)

	lw	$8, 0($4)
	lw	$9, 4($5)
	lw	$10, 8($6)
	lw	$11, 12($7)

	lw	$8, 0($16)
	lw	$9, 4($17)
	lw	$10, 8($18)
	lw	$11, 12($19)

	lw	$8, 0($20)
	lw	$9, 4($21)
	lw	$10, 8($22)
	lw	$11, 12($23)

	lw	$4, 0($8)
	lw	$5, 4($9)
	lw	$6, 8($10)
	lw	$7, 12($11)

	sw	$16, 0($8)
	sw	$17, 4($9)
	sw	$18, 8($10)
	sw	$19, 12($11)

	sw	$20, 0($8)
	sw	$21, 4($9)
	sw	$22, 8($10)
	sw	$23, 12($11)

	sw	$20, 0($4)
	sw	$21, 4($5)
	sw	$22, 8($6)
	sw	$23, 12($7)

	sw	$20, 0($16)
	sw	$21, 4($17)
	sw	$22, 8($18)
	sw	$23, 12($19)

	sw	$20, 0($20)
	sw	$21, 4($21)
	sw	$22, 8($22)
	sw	$23, 12($23)

	sw	$4, 0($20)
	sw	$5, 4($21)
	sw	$6, 8($22)
	sw	$7, 12($23)

	sw	$16, 0($20)
	sw	$17, 4($21)
	sw	$18, 8($22)
	sw	$19, 12($23)

	brc	$3
	brsc	$16

	balrsc	$16, $17
	balrsc	$17

	addiu	$3, $28, 0x12345
	addiu	$3, $28, 0x12345678
	addiu	$3, $28, -0x12345
	addiu	$3, $28, -0x12345678

	addiu	$3, $3, 0x12345
	addiu	$3, 0x12345678
	addiu	$3, $3, -0x12345
	addiu	$3, -0x12345678

	bgeiuc	$2, 1, test
	bgeiuc	$2, 127, test
	bltiuc	$2, 1, test
	bltiuc	$2, 127, test
	
	extw	$4, $2, $3, 0
	extw    $4, $2, $3, 24
	extw    $4, $2, $3, 16
	extw    $4, $2, $3, 8
	extw	$4, $2, $3, 1
	extw    $4, $2, $3, 2
	extw    $4, $2, $3, 3
	extw    $4, $2, $3, 4

	align   $4, $2, $3, 0
	align   $4, $2, $3, 1
	align   $4, $2, $3, 2
	align   $4, $2, $3, 3

	lwxs	$4, $5($6)
	lwxs	$7, $16($17)
	lwxs	$18, $19($4)

	sw	$16,%gp_rel(x)($28)
	sw	$17,16($28)
	sw16	$17,16($28)
	sw16	$17,%gp_rel(test)($28)
	lapc $5,test
	lapc $5,test2
	.set at
	pref 	4,4000($3)
	pref 	4,-30($3)
	pref 	4,%lo(test)($3)

	bbeqzc $4,24,test
	bbeqzc $4,1,test
	bbeqzc $4,31,test
	bbnezc $4,0,test
	bbnezc $4,16,test
	teq	$3, $4
	tne $5,$6
	addu $8,$8,$10
	mulu $20,$20,$22
	lwpc $3, 10000
	swpc $3, 10000
	ldpc $5, 10000
	sdpc $8, 10000
	lapc48 $3, test
	lwpc $3, test
	swpc $3, test
	ldpc $5, test
	sdpc $8, test

	ualh	$2, 4($5)
	uash	$2, 4($5)
	ualwm	$2, 4($5),4
	uaswm	$2, 4($5),6
	ualw	$2, 4($5)
	uasw	$2, 4($5)
	ualwm	$2, 4($5),8
	uaswm	$2, 4($5),7
	
	lwm	$2, 4($5),8
	swm	$2, 4($5),7

	ualdm	$2, 4($5),4
	uasdm	$2, 4($5),6
	uald	$2, 4($5)
	uasd	$2, 4($5)
	ualdm	$2, 4($5),8
	uasdm	$2, 4($5),7
	ldm	$2, 4($5),8
	sdm	$2, 4($5),7

	rotx    $2, $3, 5, 30, 1
	rotx    $2, $3, 31, 0
	bitrev 	$2,$3
	rotx    $2, $3, 7, 8, 1
	bitswap $2,$3
	rotx    $2, $3, 15, 16
	bitswaph $2,$3
	rotx    $2, $3, 24, 8
	byterev $2,$3
	rotx    $2, $3, 8, 24
	wsbh 	$2,$3

	addiupc		$5, 0
	addiupc 	$5, 4
	addiupc 	$5, 8
	addiupc48 	$5, 0
	addiupc48 	$5,6
	addiupc48 	$5,8
	addiupc 	$5,2097154
	addiupc 	$5,2097156
	addiupc 	$5,-2097148
	addiupc 	$5,-2097150

	.end	test
	.align	2
	.space	8
