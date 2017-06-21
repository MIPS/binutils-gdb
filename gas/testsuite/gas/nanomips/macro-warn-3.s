	.set	noreorder
	.set	nomacro
early_big:
	la	$4,early_big
	la	$4,sdata
	jrc	$5
	la	$4,early_big
	jrc	$5
	la	$4,sdata
	.comm	sdata,4
