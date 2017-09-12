# Source file used to test the jal macro with PIC code.

	.weak	weak_text_label
	.set pic
	.ent	text_label
text_label:
	.frame	$sp,0,$31
	.set	noreorder
	.cpsetup $25
	.set	reorder
	.cprestore	0
	jal	$25
	jal	$4,$25
	jal	text_label
	jal	weak_text_label
	jal	external_text_label

# Test j as well.
	j	text_label
	.end	text_label

# Force at least 8 (non-delay-slot) zero bytes, to make 'objdump' print ...
	.align	2
	.space	8
