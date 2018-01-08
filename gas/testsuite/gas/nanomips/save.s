	.text
	.ent	test
	.globl	test
test:
	/* save[16] */
	save 	16
	save 	128
	save 	240

	save	32,$ra
	save	32,$fp,$ra
	save	32,$ra,$s0
	save	32,$ra,$s0-$s3
	save	192,$ra,$s0-$gp
	save	192,$fp,$ra,$s0-$gp
	save	128,$fp,$ra,$s0-$k1,$gp

	/* restore16.jrc */
	restore.jrc	16
	restore.jrc	128
	restore.jrc	240

	restore.jrc	32,$ra
	restore.jrc	32,$fp,$ra
	restore.jrc	32,$ra,$s0
	restore.jrc	32,$ra,$s0-$s3
	restore.jrc	192,$ra,$s0-$gp
	restore.jrc	192,$fp,$ra,$s0-$gp
	restore.jrc	128,$fp,$ra,$s0-$k1,$gp


	/* save[32] */
	save	40,$ra
	save	256,$fp,$ra
	save	1024,$ra,$s0
	save	160,$zero,$gp
	save	64,$s0-$s3,$gp
	save	64,$a0-$s0,$gp
	save	128,$t3,$s0,$s1,$gp
	save	128,$a4-$t3,$s0-$s3

	/* restore[32] */
	restore	48,$ra
	restore	256,$fp,$ra
	restore	1024,$ra,$s0
	restore	160,$zero,$gp
	restore	64,$s0,$s1,$s2,$s3,$gp
	restore	64,$t4,$t5,$gp
	restore	128,$fp,$ra,$s0,$s1,$gp
	restore	120,$fp,$ra,$s0-$k1,$gp

	restore.jrc	56,$ra
	restore.jrc	256,$fp,$ra
	restore.jrc	1024,$ra,$s0
	restore.jrc	160,$zero,$gp
	restore.jrc	64,$s0,$s1,$s2,$s3,$gp
	restore.jrc	64,$t4,$t5,$gp
	restore.jrc	128,$fp,$ra,$s0,$s1,$gp
	restore.jrc	120,$fp,$ra,$s0-$k1,$gp
	restore.jrc	64,$fp,$ra,$s0-$s7
	savef	64, $f0
	savef	64, $f0-$f15
	savef	64, $f0-$f5
	restoref	64, $f0
	restoref	64, $f0-$f15
	restoref	64, $f0-$f5

	jraddiusp 96		# restore.jrc[16]
	jraddiusp 4080		# restore.jrc[32]

	jraddiusp 65520
	jraddiusp -2048
	jraddiusp 1048560

.end	test
