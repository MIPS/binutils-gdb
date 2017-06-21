	.set	noreorder
	.set	nomacro
local:
	la	$4,late_global
	la	$4,local
	jrc	$5
	la	$4,late_global
	jrc	$5
	la	$4,local
	.globl	local_global
