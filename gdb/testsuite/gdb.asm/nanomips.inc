	comment "subroutine declare"
	.purgem gdbasm_declare
	.macro gdbasm_declare name
	.align	1
	.ent	\name
	.type	\name,@function
\name:
	.endm

	comment "subroutine prologue"
	.macro gdbasm_enter
	save 32, $fp, $ra
	addiu $fp, $sp, -4080
	.endm

	comment "subroutine epilogue"
	.macro gdbasm_leave
	restore.jrc 32, $fp, $ra
	.endm

	comment "subroutine end"
	.purgem gdbasm_end
	.macro gdbasm_end name
	.end	\name
	.endm

	.macro gdbasm_call subr
        li     $t9, \subr
        jalrc  $ra, $t9
	.endm

	.macro gdbasm_several_nops
	nop
	nop
	nop
	nop
	.endm

	comment "exit (0)"
	.macro gdbasm_exit0
	comment "Don't know how to exit, but this will certainly halt..."
	lw 	$a3, 0($zero)
	.endm

	comment "crt0 startup"
	.macro gdbasm_startup
	li $sp, 0x8007fff0
	li $fp, 0
	.endm
