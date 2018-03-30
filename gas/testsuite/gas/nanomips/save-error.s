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
	save16	64,$s0-$s3,$gp
	save	64,$a0-$s0,$gp
	save	128,$t3,$s0,$s1,$gp

	/* restore[32] */
	restore	64,$s0,$s1,$s2,$s3,$gp
	restore	64,$t4,$t5,$gp

	restore.jrc	64,$s0,$s1,$s2,$s3,$gp
	restore.jrc	64,$t4,$t5,$gp
	restore.jrc	128,$fp,$ra,$s0,$s1,$gp

	save	48,$fp,$s0-$s7
	restore.jrc	48,$fp,$ra,$s0-$s7,$t9
	restore 48,$t0,$t1,$t2,$t3,$t4,$t5
	restore 48,$t0-$t5

	save	48,$ra,$fp,$s0-$s7
	restore.jrc	256,$t4-$gp
	restore16	48,$s0

	save	128,$k0-$sp
	restore	128,$s0-$s7,$fp,$ra
	save	128,$s0-$s7,$ra
	restore	128,$s0-$s7,$ra,$fp
	save	128,$ra,$s0-$s7,$fp
	restore	128,$fp,$ra,$s1

	.end	test
