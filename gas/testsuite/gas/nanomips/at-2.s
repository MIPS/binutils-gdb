	.text
foo:
	.set	at=$0
	sw	$1, 0x8000($1)
	sw	$26, 0x8000($26)
	sw	$27, 0x8000($27)
	.set	at=$1
	sw	$1, 0x8000($1)
	sw	$26, 0x8000($26)
	sw	$27, 0x8000($27)
	.set	at=$26
	sw	$1, 0x8000($1)
	sw	$26, 0x8000($26)
	sw	$27, 0x8000($27)
	.set	at=$27
	sw	$1, 0x8000($1)
	sw	$26, 0x8000($26)
	sw	$27, 0x8000($27)

# Force at least 8 (non-delay-slot) zero bytes, to make 'objdump' print ...
	.space	8
