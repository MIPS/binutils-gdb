	.linkrelax
	.module	pcrel
	.module	softfloat
	.section .text
	.globl	main
	.ent	main
	.type	main, @function
main:
	lapc.h	$a3,$L178
	.reloc	1f,R_NANOMIPS_JUMPTABLE_LOAD,$L178
1:
	lbux	$a3,$a0($a3)
	brsc	$a3
	.section	.rodata
	.align	1
	.jumptable 1,18,1
$L178:
	.section	.text.x
$LTB178 = . - 4
	.section	.rodata
	.byte	($L273-($LTB178+4))>>1
	.byte	($L273-($LTB178+4))>>1
	.byte	($L273-($LTB178+4))>>1
	.byte	($L273-($LTB178+4))>>1
	.byte	($L273-($LTB178+4))>>1
	.byte	($L273-($LTB178+4))>>1
	.byte	($L273-($LTB178+4))>>1
	.byte	($L273-($LTB178+4))>>1
	.byte	($L273-($LTB178+4))>>1
	.byte	($L273-($LTB178+4))>>1
	.byte	($L273-($LTB178+4))>>1
	.byte	($L273-($LTB178+4))>>1
	.byte	($L273-($LTB178+4))>>1
	.byte	($L273-($LTB178+4))>>1
	.byte	($L273-($LTB178+4))>>1
	.byte	($L273-($LTB178+4))>>1
	.byte	($L273-($LTB178+4))>>1
	.byte	($L273-($LTB178+4))>>1
	.section	.text
$L176:
	.space 200000
$L273:
	nop
	.end	main
