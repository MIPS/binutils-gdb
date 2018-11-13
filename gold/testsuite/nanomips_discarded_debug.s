	.linkrelax
	.section	.text,"ax",@progbits
	.align	1
	.globl	__start
	.ent	__start
__start:
	jr	$ra
	.end	__start

	.section	.text.foo,"ax",@progbits
	.globl	foo
	.ent	foo
foo:
$L1:
	la	$a0, foo
$L2:
	.end	foo

	.section	.data,"aw",@progbits
	.globl d_addend
	.globl d_diff
d_sym:
	.word $L2
d_addend:
	.word $L1 + 4
d_diff:
	.word $L2 - $L1

	.section	.debug_ranges,"",@progbits
	.globl dr_sym1
	.globl dr_sym2
dr_sym2:
	.word $L2
dr_sym1:
	.word $L1

	.section	.debug_line,"",@progbits
	.globl dl_sym
	.globl dl_addend
	.globl dl_diff
dl_sym:
	.word $L2
dl_addend:
	.word $L1 + 4
dl_diff:
	.word $L2 - $L1

	.section	.debug_info,"",@progbits
	.globl di_sym
	.globl di_addend
	.globl di_diff
di_sym:
	.word $L2
di_addend:
	.word $L1 + 4
di_diff:
	.word $L2 - $L1

	.section	.debug_frame,"",@progbits
	.globl df_sym
	.globl df_addend
	.globl df_dfff
df_sym:
	.word $L2
df_addend:
	.word $L1 + 4
df_diff:
	.word $L2 - $L1

	.section	.debug_loc,"",@progbits
	.globl dloc_sym
	.globl dloc_addend
	.globl dloc_dlocff
dloc_sym:
	.word $L2
dloc_addend:
	.word $L1 + 4
dloc_diff:
	.word $L2 - $L1

	.section	.debug_aranges,"",@progbits
	.globl dar_sym1
	.globl dar_sym2
dar_sym2:
	.word $L1
dar_diff:
	.word $L2 - $L1
