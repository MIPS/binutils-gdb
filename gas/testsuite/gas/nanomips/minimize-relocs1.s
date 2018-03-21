# Test reloc-minimization for nested overlapping jumps
# The lynch-pin is the instruction which sits at the root of the
# dependency tree. This file tests for the following case:
# 1. when the lynch-pin is relaxable
# 2. when the lynch-pin is local (not relaxable), using 32-bit instructions
# 3. when the lynch-pin is partially relaxable, using fixed-format instructions
# 4. when the lynch-pin is external but fixed size
# 5. when the lynch-pin is external but wrapped in nolinkrelax
#
# Each case is checked for both forward and backward nested blocks.
	
	# Test reloc-minimization for nested overlapping jumps
	.text
	.extern test1
	.linkrelax
	.ent test
test:
	# case1: nested jumps forward over a relaxable instruction
	bc $L2
	balc $L2
	beqzc $a0,$L2
	beqc $a0,$a1,$L2
	bneic $a0,4,$L2
$L1:
	lw $a0,%gprel(test)($gp) # lynch-pin is link-time relaxble
$L2:
	# case1: nested jumps backward over a relaxable instruction
	beqc $a0,$a1,$L1
	bneic $a0,4,$L1
	beqzc $a0,$L1
	balc $L1
	bc $L1

 	# case2: nested jumps forward over a fixed instruction
	bc32 $L4 	# using fixed 32-bit instructions
	balc32 $L4
	beqzc32 $a0,$L4
	beqc32 $a0,$a1,$L4
$L3:	
	balc test	# lynch-pin is a local resolved reference
$L4:
	# case2: nested jumps backward over a fixed instruction
	bc32 $L3 	# using fixed 32-bit instructions
	balc32 $L3
	beqzc32 $a0,$L3
	beqc32 $a0,$a1,$L3

	# case3: nested jump forward over a partial
	bc $L6
	balc $L6
	beqzc $a0,$L6
	bneic $a0,4,$L6
	beqc $a0,$a1,$L6
$L5:
	lw $a0,%gprel(test)($gp)
	.set nolinkrelax
	lapc $a0,test1
	.set linkrelax
	nop
$L6:
	# case3: nested jumps backward over a partial
	bc $L5
	balc $L5
	beqzc $a0,$L5
	bneic $a0,4,$L5
	beqc $a0,$a1,$L5

	# case4: nested jump forward over a fixed size relocation
	bc $L8
	balc $L8
	beqzc $a0,$L8
	bneic $a0,4,$L8
	beqc $a0,$a1,$L8
$L7:
	balc16 test_ext
$L8:
	# case4: nested jumps backward over a fixed size relocation
	bc $L7
	balc $L7
	beqzc $a0,$L7
	bneic $a0,4,$L7
	beqc $a0,$a1,$L7

	# case5: nested jump forward over nolinkrelax region
	bc $L10
	balc $L10
	beqzc $a0,$L10
	bneic $a0,4,$L10
	beqc $a0,$a1,$L10
$L9:
	.set nolinkrelax
	nop
	balc test_ext
	.set linkrelax
	nop
$L10:
	# case5: nested jumps backward over nolinkrelax region
	bc $L9
	balc $L9
	beqzc $a0,$L9
	bneic $a0,4,$L9
	beqc $a0,$a1,$L9

	.end test
