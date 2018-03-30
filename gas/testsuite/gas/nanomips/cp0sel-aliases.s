# source file to test assembly using various styles of
# CP0 (w/ non-zero select code) register names.

	.text
text_label:
	# test CP0 register aliases
	mtc0	$0,$watchlo0
	mtc0	$0,$watchlo1
	mtc0	$0,$watchlo2
	mtc0	$0,$watchlo3
	mtc0	$0,$watchlo4
	mtc0	$0,$watchlo5
	mtc0	$0,$watchlo6
	mtc0	$0,$watchlo7
	mtc0	$0,$watchlo8
	mtc0	$0,$watchlo9
	mtc0	$0,$watchlo10
	mtc0	$0,$watchlo11
	mtc0	$0,$watchlo12
	mtc0	$0,$watchlo13
	mtc0	$0,$watchlo14
	mtc0	$0,$watchlo15

	mtc0	$0,$watchhi0
	mtc0	$0,$watchhi1
	mtc0	$0,$watchhi2
	mtc0	$0,$watchhi3
	mtc0	$0,$watchhi4
	mtc0	$0,$watchhi5
	mtc0	$0,$watchhi6
	mtc0	$0,$watchhi7
	mtc0	$0,$watchhi8
	mtc0	$0,$watchhi9
	mtc0	$0,$watchhi10
	mtc0	$0,$watchhi11
	mtc0	$0,$watchhi12
	mtc0	$0,$watchhi13
	mtc0	$0,$watchhi14
	mtc0	$0,$watchhi15

	mtc0	$0,$perfctl0
	mtc0	$0,$perfcnt0
	mtc0	$0,$perfctl1
	mtc0	$0,$perfcnt1
	mtc0	$0,$perfctl2
	mtc0	$0,$perfcnt2
	mtc0	$0,$perfctl3
	mtc0	$0,$perfcnt3
	mtc0	$0,$perfctl4
	mtc0	$0,$perfcnt4
	mtc0	$0,$perfctl5
	mtc0	$0,$perfcnt5
	mtc0	$0,$perfctl6
	mtc0	$0,$perfcnt6
	mtc0	$0,$perfctl7
	mtc0	$0,$perfcnt7

	mtc0	$0,$itaglo
	mtc0	$0,$idatalo
	mtc0	$0,$dtaglo
	mtc0	$0,$ddatalo
	mtc0	$0,$itaghi
	mtc0	$0,$idatahi
	mtc0	$0,$dtaghi
	mtc0	$0,$ddatahi
