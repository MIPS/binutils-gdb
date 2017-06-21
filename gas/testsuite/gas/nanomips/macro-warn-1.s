	.set 	noreorder
	.set	nomacro
	.globl	early_global
local:
	.cpload	$25
	.cpsetup $25,16,local
	.cprestore 16
	.cpreturn
	la	$4,early_global
	la	$4,early_global+10
	la	$4,local+10
	la	$4,late_global+10
	jrc	$5
	la	$4,early_global
	jrc	$5
	la	$4,early_global+10
	jrc	$5
	la	$4,local+10
	jrc	$5
	la	$4,late_global+10
	.globl	late_global
