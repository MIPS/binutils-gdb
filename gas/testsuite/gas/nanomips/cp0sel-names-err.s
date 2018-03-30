# source file to test assembly using various incorrect
# select numbers for CP0 register names.

	.text
text_label:
	mtc0	$a0,$watchlo,16	# limited to 15
	mtc0	$a0,$watchhi,17  # limited to 15
	mtc0	$a0,$perfctl,18	# limited to 15
	mtc0	$a0,$perfcnt,19	# limited to 15

	mtc0	$a0,$perfctl,3	# must be even
	mtc0	$a0,$datalo,2	# must be odd
	mtc0	$a0,$taglo,3	# must be even
	mtc0	$a0,$datalo,0	# must be odd
	mtc0	$a0,$taghi,1	# must be even
