	.linkrelax
	.text
$Ltext0:
	.cfi_sections	.debug_frame
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
$LC0:
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
$LFB1 = .
	.file 1 "test.c"
	.loc 1 7 0
	.cfi_startproc
	.ent	main
	.type	main, @function
main:
	save	16,$ra
	.align 2
	.cfi_def_cfa_offset 16
	.cfi_offset 31, -4
	.loc 1 8 0
	lw	$a3,%gprel(_impure_ptr)($gp)
	lapc	$a0,$LC0
	balc	fwrite
$LVL0 = .
	.loc 1 9 0
	li	$a0,1
	balc	foo
$LVL1 = .
	.loc 1 10 0
	move	$a0,$zero
	restore.jrc	16,$ra
	.end	main
.cfi_endproc
$LFE1:
	.size	main, .-main
	.text
$Letext0:
	.section	.debug_line,"",@progbits
$Ldebug_line0:
