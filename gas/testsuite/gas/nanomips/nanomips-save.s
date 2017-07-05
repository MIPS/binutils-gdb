	.text
	.ent	test
	.globl	test
test:
	/* save[16] */
	save 	16
	save 	128
	save 	240

	save	32,$ra
	save	32,$ra,$fp
	save	32,$s0,$ra
	save	32,$s0-$s3,$ra
	save	192,$ra,$s0-$gp
	save	192,$fp,$ra,$s0-$gp
	save	128,$s0-$k1,$fp,$ra,$gp

	/* restore16.jrc */
	restore.jrc	16
	restore.jrc	128
	restore.jrc	240

	restore.jrc	32,$ra
	restore.jrc	32,$ra,$fp
	restore.jrc	32,$s0,$ra
	restore.jrc	32,$s0-$s3,$ra
	restore.jrc	192,$ra,$s0-$gp
	restore.jrc	192,$fp,$ra,$s0-$gp
	restore.jrc	128,$s0-$k1,$fp,$ra,$gp


	/* save[32] */
	save	40,$ra
	save	256,$ra,$fp
	save	1024,$s0,$ra
	save	64,$s0-$s3,$gp
	save	64,$a0-$s0,$gp
	save	128,$gp,$t3,$s0,$s1
	save	128,$a4-$t3,$s0-$s3

	/* restore[32] */
	restore	48,$ra
	restore	256,$ra,$fp
	restore	1024,$s0,$ra
	restore	64,$s0,$s1,$s2,$s3,$gp
	restore	64,$t4,$t5,$gp
	restore	128,$ra,$s0,$s1,$fp,$gp
	restore	120,$s0-$k1,$fp,$ra,$gp

	restore.jrc	56,$ra
	restore.jrc	256,$ra,$fp
	restore.jrc	1024,$s0,$ra
	restore.jrc	64,$s0,$s1,$s2,$s3,$gp
	restore.jrc	64,$t4,$t5,$gp
	restore.jrc	128,$ra,$s0,$s1,$fp,$gp
	restore.jrc	120,$s0-$k1,$fp,$ra,$gp
	restore.jrc	64,$ra,$s0-$s7,$fp
	savef	64, $f0
	savef	64, $f0-$f15
	savef	64, $f0-$f5
	restoref	64, $f0
	restoref	64, $f0-$f15
	restoref	64, $f0-$f5

.end	test
