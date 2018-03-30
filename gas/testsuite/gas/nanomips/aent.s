	.text

	.globl	foo
	.ent	foo
foo:
	sllv	$2, $4, $6
	srav	$8, $10, $12

	.globl	bar
	.aent	bar
bar:
	sllv	$2, $4, $6
	srav	$8, $10, $12

	.end	foo
	.size	foo, . - foo
