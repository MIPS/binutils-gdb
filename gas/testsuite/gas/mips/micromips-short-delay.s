	.text
	.set	micromips
	.set	reorder
	.globl test3
test:
	/* Following branches should be modified to use short delay slots.  */

	/* 1. Sequences where conversion allows us to fill the slot.  */
	addu	$3, $4, $5
	bgezal	$2, test2

	addu	$3, $4, $5
	bltzal	$2, test2

	addu	$3, $4, $5
	jr32	$2

	addu	$3, $4, $5
	jr.hb	$2

	addu	$3, $4, $5
	jalr	$2, $4		/* 32-bit  */

	addu	$3, $4, $5
	jalr	$2		/* 16-bit  */

	addu	$3, $4, $5
	jalr.hb $2

	addu	$3, $4, $5
	bgezal	$2, test3	/* Out-of-range & short-delay  */

	/* 2. Sequences where the slot is compacted but remains empty.  */
	sync			/* Instruction cannot be swapped.  */
	bgezal	$2, test2

	addu	$2, $4, $5	/* INSN writes, branch reads $2.  */
	bltzal	$2, test2

	addu	$3, $4, $5	/* INSN writes, branch writes $3.  */
	jalr	$3, $2

	addiupc	$3, 16		/* INSN reads, branch writes pc.  */
	jalr	$2

	addu	$3, $4, $5
blabel:				/* Might be a branch target itself.  */
	jalr.hb	$2

	.set noreorder		/* Foils the swap.  */
	addu	$3, $4, $5
	jr.hb	$2
	nop
	.set reorder

	addu	$3, $4, $5
	.set nomove		/* Foils the swap.  */
	jalr	$2
	.set move

	/* Following branches should NOT be modified.  */

	/* 1. Instruction has only 32-bit delay slot.  */
	addu	$3, $4, $5
	jalx	test2

	/* 2. Left for linker because ISA of target is not known.  */
	addu	$3, $4, $5
	jal	test3

	/* 3. Preceding instruction is 32-bit, can swap without relaxation.  */
	addu	$3, $4, $21
	jalr.hb $2

	.skip	1024
test2:
	.skip	(65536 - 1024)
test3:
	/* Compaction within no-reorder block.  */
	.set noreorder
	jr.hb	$2		/* Can't modify, INSN is 32-bit.  */
	addu	$3, $4, $21

	jal	test2		/* Can't modify, delay slot inns is 32-bit.  */
	addu	$3, $4, $21

	bgezal	$2, test2	/* Compact branch & insn.  */
	addu	$3, $4, $5
	.set reorder

# Force at least 8 (non-delay-slot) zero bytes, to make 'objdump' print ...
	.align	2
	.space	8
