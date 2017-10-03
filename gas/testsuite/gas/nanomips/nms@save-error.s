	.text
	.ent	test
	.globl	test
test:
	/* save[16] */
	save 	16
	save 	128
	save 	240

	save	32,$ra,$s0-$s7
	save	48,$fp,$ra,$s0-$t8

	/* save[32] */
	save	64,$s0-$s3,$gp
	save	64,$a0-$s0,$gp
	save	128,$t3,$s0,$s1,$gp

	/* restore[32] */
	restore	64,$s0,$s1,$s2,$s3,$gp
	restore	64,$t4,$t5,$gp

	restore.jrc	64,$s0,$s1,$s2,$s3,$gp
	restore.jrc	64,$t4,$t5,$gp
	restore.jrc	128,$fp,$ra,$s0,$s1,$gp

.end	test
