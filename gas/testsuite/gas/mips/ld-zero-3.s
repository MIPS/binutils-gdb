	.text
foo:
	lwu	$0, 0x12345678($2)
	ld	$0, 0x12345678($2)
.ifndef r6
	lld	$0, 0x12345678($2)
.endif

# Force some (non-delay-slot) zero bytes, to make 'objdump' print ...
	.align	4, 0
	.space	16
