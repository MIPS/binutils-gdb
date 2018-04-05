# Test for special cases
# case1: a 32-bit branch in danger of being relaxed to 16-bit
# 	cannot be assumed to be of fixed size
# case2: a 32-bit branch not in danger of being relaxed to 16-bit
# 	is assumed to be of fixed size

	.text
	.linkrelax
test:
	beqc $a0,$a1,$L1
	beqc $a0,$a1,$L2 # Jump over 34 bytes, reducible to 28
$L1:
	addiu $a0, $a1,%gprel_lo(test)
	addiu.w $a0, $gp, %gprel(test)
	.space 26
$L2:
	beqc $a0,$a1,$L3
	beqc $a0,$a1,$L4 # Jump over 32 bytes, not reducible to 30
$L3:
	addiu $a0,$gp,%gprel(test)
	.space 28
$L4:
	beqc $a0,$a1,$L5
	beqc $a0,$a1,$L6 # Jump over 32 bytes, reducible to 30
$L5:
	lw $a0,%gprel(test)($gp)
	.space 28
$L6:
	nop
	.org 0x88
	nop
	beqc $a0,$a1,$L7
	beqc $a0,$a1,$L8 # Jump over 32 bytes, reducible to 18
$L7:
	lw $a0,%gprel(test)($gp)
	.align 4
	.space 14
$L8:
	nop
	.org 0xb0
	nop
	beqc $a0,$a1,$L9
	beqc $a0,$a1,$L10 # Jump over 44 bytes, reducible to 28
$L9:
	lw $a0,%gprel(test)($gp)
	.align 4
	.space 26
$L10:
	nop
	.data
	.word ($L1 - test)
	.word ($L2 - $L3)
	.word ($L4 - $L5)
	.word ($L7 - $L6)
	.word ($L9 - $L8)
