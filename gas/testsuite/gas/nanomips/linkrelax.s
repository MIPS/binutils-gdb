	.text
	.ifdef relaxmode
	.linkrelax
	.endif
	.ent test1
test1:
	addiu $2, $8, 4
	.p2align 3	# no FILL, no MAX
	b32 test2
	.align 3	# no FILL
	b16 test2
	.balign 2	# no FILL, no MAX
	nop
	.set  nolinkrelax
	addiu $2, $3, 4
	.p2align 3
	b32 test2
	.align 3
	b16 test2
	.balign 8
	nop
	.set linkrelax
	nop
	.end test1

	.ent test2
	.align 3
test2:
	addiu $2, $2, 4
	.p2align 3,0xa   # FILL but no MAX
	nop
	.p2align 3,0xab,5 # FILL and MAX, no padding will be done
	nop32
	nop32
	.p2align 3,0xcd,6 # FILL and MAX, padded
	nop32
	.p2alignw 3,0xabcd,6 # FILL hword and MAX
	nop32
	.p2alignl 3,0xabcd1234,6 # FILL word and MAX
	addiu $2, $3, 4	
	.balign 16,0xb   # FILL but no MAX
	nop
	.balign 16,0xba,5 # FILL and MAX, no padding will be done
	nop
	.balign 16,0xba,12 # FILL and MAX, padded
	nop32
	.balignw 16,0xdcba,16 # FILL hword and MAX
	nop32
	.balignl 16,0x4321dcba,16 # FILL word and MAX
	nop
	.word 0x8000c000
	.word 0x8000c000
	.word 0x8000c000
	.end test2
