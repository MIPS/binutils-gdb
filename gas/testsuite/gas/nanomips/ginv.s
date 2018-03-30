	.text
test:
	ginvi	$2
	ginvt	$3,0
	ginvt	$4,1

	.ifdef VX
	ginvgt	$5,2
	ginvgt	$6,3
	.endif
