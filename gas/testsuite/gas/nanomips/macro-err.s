	.set	nomacro
	.globl	early_global
local:
	.cpsetup $25
	li	$5, 0x10101010
	la	$4, early_global
	la	$4, early_global+10
	la	$4, local+10
	la	$4, late_global+10
	jrc	$5
	la	$4, early_global
	jrc	$5
	la	$4, early_global+10
	jrc	$5
	la	$4, local+10
	jrc	$5
	la	$4, late_global+10
	.globl	late_global
