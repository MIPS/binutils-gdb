# Test reloc-minimization for a mutually recursive spiral

	.text
	.extern test1
	.linkrelax
	.ent test
test:
	# case1: mutually recursive spiral
$L0:
	balc $L11
$L1:	
	bc $L10
$L2:	
	balc $L9
$L3:	
	beqzc $a0,$L8
$L4:	
	beqc $a0,$a1,$L7
$L5:	
	bneic $a0,4,$L6
	beqc $a0,$a1,$L5
$L6:
	bneic $a0,4,$L4
$L7:
	beqzc $a0,$L3
$L8:
	balc $L2
$L9:
	bc $L1
$L10:
	bc $L0
$L11:	
	nop
	.end test
