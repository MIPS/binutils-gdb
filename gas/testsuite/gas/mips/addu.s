# Source file used to test the addu macro.
	
foo:
	addu	$4,$4,0
	addu	$4,$4,1
	addu	$4,$4,0x8000
	addu	$4,$4,-0x8000
	addu	$4,$4,0x10000
	addu	$4,$4,0x1a5a5
	
# Round to a 16 byte boundary, for ease in testing multiple targets.
	nop
