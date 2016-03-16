	.section .mdebug.abi32
	.previous
	.abicalls
	.option	pic0
	.text
	.align	2
	.set nomips16
	.globl	func1_ifunc
	.ent	func1_ifunc
	.type	func1_ifunc, @function
func1_ifunc:
	j	$31
	.end	func1_ifunc
	.size	func1_ifunc, .-func1_ifunc
	.globl func1
	.type	func1, @gnu_indirect_function
	func1 = func1_ifunc

	.set mips16
	.globl	func2_ifunc
	.ent	func2_ifunc
	.type	func2_ifunc, @function
func2_ifunc:
	j	$31
	.end	func2_ifunc
	.size	func2_ifunc, .-func2_ifunc
	.type	func2, @gnu_indirect_function
	.globl func2
	func2 = func2_ifunc	
	
	.align	2
	.set 	nomips16
	.globl	main
	.ent	main
	.option	pic0
	.type	main, @function
main:
	.set	reorder
	move 	$7, $31
	jal	func2
	nop
	jal	func1
	nop
	jr	$7

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main

	.set  	mips16
	.globl	test_mips16
	.ent	test_mips16
	.type	test_mips16, @function
test_mips16:
	.set	reorder
	move 	$7, $31
	jal	func2
	nop
	jal	func1
	nop
	jr	$7

	.set	macro
	.set	reorder
	.end	test_mips16
	.size	test_mips16, .-test_mips16
