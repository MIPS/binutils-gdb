# source file to test objdump's disassembly using various styles of
# HWR (hardware register) names.

	.text
text_label:
	rdhwr	$0,$cpunum
	rdhwr	$0,$synci_step
	rdhwr	$0,$cc
	rdhwr	$0,$ccres
	rdhwr	$0,$perfctl0
	rdhwr	$0,$perfcnt0
	rdhwr	$0,$perfctl1
	rdhwr	$0,$perfcnt1
	rdhwr	$0,$perfctl2
	rdhwr	$0,$perfcnt2
	rdhwr	$0,$perfctl3
	rdhwr	$0,$perfcnt3
	rdhwr	$0,$perfctl4
	rdhwr	$0,$perfcnt4
	rdhwr	$0,$perfctl5
	rdhwr	$0,$perfcnt5
	rdhwr	$0,$perfctl6
	rdhwr	$0,$perfcnt6
	rdhwr	$0,$perfctl7
	rdhwr	$0,$perfcnt7
	rdhwr	$0,$perfcnt,0
	rdhwr	$0,$perfcnt,1
	rdhwr	$0,$perfcnt,2
	rdhwr	$0,$perfcnt,3
	rdhwr	$0,$perfcnt,4
	rdhwr	$0,$perfcnt,5
	rdhwr	$0,$perfcnt,6
	rdhwr	$0,$perfcnt,7
	rdhwr	$0,$perfcnt,8
	rdhwr	$0,$perfcnt,9
	rdhwr	$0,$perfcnt,10
	rdhwr	$0,$perfcnt,11
	rdhwr	$0,$perfcnt,12
	rdhwr	$0,$perfcnt,13
	rdhwr	$0,$perfcnt,14
	rdhwr	$0,$perfcnt,15
	rdhwr	$0,$xnp
	rdhwr	$0,$userlocal
