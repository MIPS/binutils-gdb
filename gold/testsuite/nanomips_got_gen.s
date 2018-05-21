	.linkrelax
	.globl  an_extra_ordinarily_long_function_name_for_testing_readelf_output_width_control
	.section	.text,"ax",@progbits
	.align	4
	.ent	main
	.type	main, @function
main:
	.set nolinkrelax
	lw	$a3,%got_disp(main)($gp)
	.reloc 1f, R_NANOMIPS_JALR16
1:
	jalrc	$a3
	.set linkrelax
	lw	$a3,%got_call(memcpy)($gp)
	.reloc 1f, R_NANOMIPS_JALR16, memcpy
1:
	jalrc	$a3
	lw	$a3,%got_disp(strcmp)($gp)
	.reloc 1f, R_NANOMIPS_JALR16, strcmp
1:
	jalrc	$a3
	lw	$a3,%got_disp(an_extra_ordinarily_long_function_name_for_testing_readelf_output_width_control)($gp)
	.end main
