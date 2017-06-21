	.set	noreorder
	.set	nomacro
	la	$4,late_big
	jrc	$5
	la	$4,late_big
	.comm	sdata,4
late_big:
