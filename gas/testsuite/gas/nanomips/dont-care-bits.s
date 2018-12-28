	/* Test user-specified bit patterns for instructions containing
	don't care bits.  */
	.text
	.ent	test
	.globl	test
test:
	dvp	$a0
	add	$a0,$a1,$a2
	balrsc	$ra,$a0
	bbeqzc	$a1,24,1f
1:
	.set crc
	crc32w	$a0,$a1
	deret
	ehb
	.set tlb
	tlbinv
	ehb
	eret
	.set ginv
	ginvi	$a0
	ginvt	$a0,1
	llwp	$a0,$a1,($a2)
	lsa	$a0,$a1,$a2,1
	pause
	seb	$a0,$a1
	.set dsp
	repl.qb	$a0,0
	shilo	$ac1,-32
	shra_r.ph	$a0,$a1,7

	.end	test
