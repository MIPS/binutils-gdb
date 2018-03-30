# Source file used to check the lack of branch swapping with a relaxed macro.

	.text
foo:
	la	$2, bar
	jr	$3

	la	$2, bar
	beqz	$3, 0f
0:
