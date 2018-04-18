# Generated from C code - pr70460.c in gcc.torture.  This is the initial
# case that highlights the need for symbol-differences as relocations
# when doing linker relaxations.
	.text
	.linkrelax
	.ent foo
foo:
	addiu $r5,$r28,%gprel(.L5)
	lwxs	$r5,$r4($r5)
	lui	$r4,%hi(.L2)
	addiu	$r4,$r4,%lo(.L2)
	addu	$r4,$r4,$r5
	jr	$r4
.L3:
	lw	$r4,%gprel(c)($r28)
	addiu	$r4,$r4, .L2-(.L3)
	sw	$r4,%gprel(c)($r28)
.L4:
	lw	$r4,%gprel(c)($r28)
	addiu	$r4,$r4,1
	sw	$r4,%gprel(c)($r28)
.L2:
	jr	$r31

.L5:
	.word	.L2-(.L3)
	.word	.L2-(.L4)
	.end foo

	.ent foo2
foo2:
	addiu $r5,$r28,%gprel(.L9)
	lwxs	$r5,$r4($r5)
	lui	$r4,%hi(.L6)
	addiu	$r4,$r4,%lo(.L6)
	addu	$r4,$r4,$r5
	jr	$r4
.L7:
	lw	$r4,4($r28)
	addiu	$r4,$r4, .L6-(.L7)
	sw	$r4,0x100($r28)
	.align 2 # Causes a frag to be generated
.L8:
	lw	$r4,%gprel(foo)($r28)
	addiu	$r4,$r4,1
	.reloc .L6, R_NANOMIPS_JALR16, foo # explicit relocation
.L6:
	jalr	$r31
.L9:
	.end foo2
	.data
	# No intervening relocations, but align directive creates new frag
	.word	.L7-(.L8)
	# No intervening relocations, difference is fixed.
	.word	.L6-(.L8)
	# Explicit relocation causes difference to be variable.
	.word	.L9-(.L6)
