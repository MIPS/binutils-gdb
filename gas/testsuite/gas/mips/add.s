# Source file used to test the add macro.
	
foo:
	add	$4,$4,0
	add	$4,$4,1
	add	$4,$4,0x8000
	add	$4,$4,-0x8000
	add	$4,$4,0x10000
	add	$4,$4,0x1a5a5
	
# Round to a 16 byte boundary, for ease in testing multiple targets.
	nop
