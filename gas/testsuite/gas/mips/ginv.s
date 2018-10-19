	.text
test:
	ginvi	$2
	ginvt	$3,0
	ginvt	$4,1

	.ifdef VX
	ginvgt	$4,2
	ginvgt	$5,3
	.endif

# Force at least 8 (non-delay-slot) zero bytes, to make 'objdump' print ...
	.align	2
	.space	8
