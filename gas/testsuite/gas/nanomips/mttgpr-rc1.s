# source file to test RC1-style MTTGPR format
	.text
text_label:
	mttgpr		$28,$29
	mttr		$13,$14,1,0,0

# Force at least 8 (non-delay-slot) zero bytes, to make 'objdump' print ...
	.space	8
