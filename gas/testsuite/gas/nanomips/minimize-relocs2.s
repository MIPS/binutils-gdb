# Test reloc-minimization for cascaded overlapping jumps
# The lynch-pin is the instruction which sits at the root of the
# dependency tree. This file tests for the following case:
# 1. when the lynch-pin is external (link relaxable)
# 2. when the lynch-pin is local (not relaxable)
# 3. when the lynch-pin is external but fixed size
# 4. when the lynch-pin is external but fixed format
# 5. when the lynch-pin is external but wrapped in nolinkrelax
#
# Each case is checked for both forward and backward cascades.
	
	.text
	.extern test1
	.linkrelax
	.ent test
test:
	# case 1: jumping forward over cascaded forward jumps
	bc $L1
	balc $L2
$L1:	
	beqzc $a0,$L3
$L2:	
	beqc $a0,$a1,$L4
$L3:	
	bneic $a0,4,$L5
$L4:
	balc test1	# the lynch-pin - an external reference
$L5:
	# case 1: jumping backwards over cascaded backward jumps
	bc $L4
$L6:	
	balc $L5
$L7:	
	beqzc $a0,$L6
$L8:	
	beqc $a0,$a1,$L7
	bneic $a0,4,$L8

 	# case 2: jumping forward over cascaded forward jumps
	bc $L9
	balc $L10	# which are link-invariant.
$L9:	
	beqzc $a0,$L11
$L10:	
	beqc $a0,$a1,$L12
$L11:	
	bneic $a0,4,$L13
$L12:
	balc $L14	# the lynch-pin - a local reference which is invariant
$L13:
 	# case 2: jumping backwards over cascaded backward jumps
	bc $L12
$L14:	
	balc $L13
$L15:	
	beqzc $a0,$L14
$L16:	
	beqc $a0,$a1,$L15
	bneic $a0,4,$L16

	# case 3: jumping forward over cascaded forward jumps
	bc $L17
	balc $L18	# with a fixed-size lynch-pin
$L17:	
	beqzc $a0,$L19
$L18:	
	beqc $a0,$a1,$L20
$L19:	
	bneic $a0,4,$L21
$L20:
	balc32 test1	# the lynch-pin - an external reference of fixed size
$L21:
 	# case 3: jumping backwards over cascaded backward jumps
	bc $L20
$L22:			# with a fixed-size lynch-pin
	balc $L21	
$L23:	
	beqzc $a0,$L22
$L24:	
	beqc $a0,$a1,$L23
	bneic $a0,4,$L24

	# case 4: jumping forward over cascaded forward jumps
	bc $L25
	balc $L26	# with a fixed-size lynch-pin
$L25:	
	beqzc $a0,$L27
$L26:	
	beqc $a0,$a1,$L28
$L27:	
	bneic $a0,4,$L29
$L28:
	balc[32] test1	# the lynch-pin - an external reference of fixed format
$L29:
 	# case 4: jumping backwards over cascaded backward jumps
	bc $L28
$L30:			# with a fixed-size lynch-pin
	balc $L29	
$L31:	
	beqzc $a0,$L30
$L32:	
	beqc $a0,$a1,$L31
	bneic $a0,4,$L32

	# case 5: jumping forward over cascaded forward jumps
	bc $L33
	balc $L34	# with a fixed-size lynch-pin
$L33:	
	beqzc $a0,$L35
$L34:	
	beqc $a0,$a1,$L36
$L35:	
	bneic $a0,4,$L37
$L36:
	.set nolinkrelax
	balc[32] test1	# the lynch-pin - an external reference in norelax region
	.set linkrelax
	nop
$L37:
 	# case 5: jumping backwards over cascaded backward jumps
	bc $L36
$L38:			# with a fixed-size lynch-pin
	balc $L37
$L39:	
	beqzc $a0,$L38
$L40:	
	beqc $a0,$a1,$L39
	bneic $a0,4,$L40
	
	.end test
