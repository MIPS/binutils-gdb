	.set	reorder
	daddi	$23,$24,1023
	ddiv $2, $4
	ddivu $2, $4
	dmult	$2,$3
	dmultu	$2,$3
	ldl	$2, 1($3)
	ldr	$2, 1($3)
	lld   $3, 32768($4)
	lld   $3, -32769($5)
	scd   $5, 32768($4)
	scd   $5, -32769($5)
	sdl	$2, 1($3)
	sdr	$2, 1($3)
