test:
	beqc $r7, $r7, 1f
	nop32
1:	jalrc32	$a4
	lapc $a0,test1
	.set arch=32r6
	beqc $a0,$zero,test1
	.align 4
	balc test
test1:
	nop
