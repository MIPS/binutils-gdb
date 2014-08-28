# Source file used to test microMIPS instruction size overrides (#1).

	.text
foo:
# Smoke-test a trivial case.
	nop
	nop16
	nop32

# Test ALU operations.
	addu	$2, $4
	addu16	$2, $4
	addu32	$2, $4
	addu	$12, $14
	addu32	$12, $14
	addiusp	256
	addiusp16 256

# Test jumps and branches.
	jalr	$4
	jalr16	$4
	jalr32	$4
	jalr	$24
	jalr16	$24
	jalr32	$24
	jalr	$31,$5
	jalr16	$31,$5
	jalr32	$31,$5
	jalr	$31,$25
	jalr16	$31,$25
	jalr32	$31,$25
	jalr	$30,$26
	jalr32	$30,$26
	b	bar
	b16	bar
	b32	bar
	beqz	$7, bar
	beqz16	$7, bar
	beqz32	$7, bar
	beqz	$27, bar
	beqz32	$27, bar

# Test shift instructions to complement 64-bit tests.
	sll	$2, $3, 5
	sll16	$2, $3, 5
	sll32	$2, $3, 5
	sll	$2, $3, 13
	sll32	$2, $3, 13
	sll	$10, $11, 5
	sll32	$10, $11, 5

# Force at least 8 (non-delay-slot) zero bytes, to make 'objdump' print ...
	.align	2
	.space	8
