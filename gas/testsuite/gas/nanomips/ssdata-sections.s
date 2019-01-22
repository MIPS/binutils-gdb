	.section .sbss,"aw",@nobits
sbss_label:	
	.word 0x0
	.section .sdata,"aw",@progbits
sdata_label:	
	.word 0xa
	.section .ssbss,"aw",@nobits
ssbss_half_label:	
	.half 0x0
ssbss_byte_label:
	.byte 0x0
	.section .ssdata,"aw",@progbits
ssdata_half_label:	
	.half 0xa
ssdata_byte_label:
	.byte 0xa

	.text
	.ent test
test:
	la	$a1, sbss_label
	la	$a1, sdata_label
	la	$a1, ssbss_half_label
	la	$a1, ssdata_half_label
	la	$a1, ssbss_byte_label
	la	$a1, ssdata_byte_label
	lw	$a1, sbss_label
	lw	$a1, sdata_label
	lh	$a1, ssbss_half_label
	lh	$a1, ssdata_half_label
	lb	$a1, ssbss_byte_label
	lb	$a1, ssdata_byte_label
	.end test
