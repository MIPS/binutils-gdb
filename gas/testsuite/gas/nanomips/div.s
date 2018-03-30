
	# Source file used to test the div macro.
foo:
	div	$0,$4,$5
	div	$4,$5
	div	$4,$5,$6
	div	$4,1
	div	$4,$5,1
	div	$4,-1
	div	$4,$5,-1
	div	$4,2
	div	$4,$5,2
	div	$4,0x8000
	div	$4,$5,0x8000
	div	$4,-0x8000
	div	$4,$5,-0x8000
	div	$4,0x10000
	div	$4,$5,0x10000
	div	$4,0x1a5a5
	div	$4,$5,0x1a5a5

# divu is like div, except when both arguments are registers.
# Just sanity check it otherwise.
	divu	$0,$4,$5
	divu	$4,$5
	divu	$4,$5,$6
	divu	$4,1

# mod is like div, modu is like divu
	mod	$4,$5,$6
	modu	$4,$5,2

# Sanity check the 64 bit versions.
	.set	arch=64r6
	ddiv	$4,$5,$6
	ddivu	$4,$5,2
	dmod	$4,$5,0x8000
	dmodu	$4,$5,-0x8000
