# Check how linker relaxations place-holders affect disassembly
# of PC-relative instructions

test:
	.linkrelax
	.balign 8,8,0xa
	lapc $a0,test1
	.set nolinkrelax
	beqc $a0,$zero,test1
	.set linkrelax
	.align 4
	balc test
test1:
	nop
