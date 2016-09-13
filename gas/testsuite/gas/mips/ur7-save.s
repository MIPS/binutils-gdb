	.text
	.ent	test
	.globl	test
test:
	save	32,$31
	save	32,$fp
	save	32,$s0
	save	32,$s0-$s3
	save	128,$s0-$s7,$fp,$gp
	save	128,$3,$s0,$gp

	restore	32,$gp
	restore	32,$fp
	restore	32,$s0
	restore	32,$s0-$s3
	restore	128,$s0-$s7,$fp,$gp
	restore	128,$3,$s0,$gp

	restore.jrc	32,$gp
	restore.jrc	32,$fp
	restore.jrc	32,$s0
	restore.jrc	32,$s0-$s3
	restore.jrc	128,$s0-$s7,$fp,$gp
	restore.jrc	128,$3,$s0,$gp

	save	32,$31
	save	32,$31,$s0
	save	32,$31,$s0-$s3
	save	64,$31,$s0-$s7,$fp
	save	64,$31,$s0

	restore	32,$31
	restore	32,$31,$s0
	restore	32,$31,$s0-$s3
	restore	64,$31,$s0-$s7,$fp
	restore	64,$31,$s0

	restore.jrc	32,$31
	restore.jrc	32,$31,$s0
	restore.jrc	32,$31,$s0-$s3
	restore.jrc	64,$31,$s0-$s7,$fp
	restore.jrc	64,$31,$s0

	save	64,$31,$s0-$fp
	save	64,$31,$s0-$gp
	save	64,$3,$s0-$fp
	save	64,$3,$s0-$sp,$fp
	save	64,$3,$s0-$sp,$gp
	save	64,$3,$s0-$gp

	restore	64,$31,$s0-$fp
	restore	64,$31,$s0-$gp
	restore	64,$3,$s0-$fp
	restore	64,$3,$s0-$sp,$fp
	restore	64,$3,$s0-$sp,$gp
	restore	64,$3,$s0-$gp

	restore.jrc	64,$31,$s0-$fp
	restore.jrc	64,$31,$s0-$gp
	restore.jrc	64,$3,$s0-$fp
	restore.jrc	64,$3,$s0-$sp,$fp
	restore.jrc	64,$3,$s0-$sp,$gp
	restore.jrc	64,$3,$s0-$gp

	restore	120

	savef	64, $f0
	savef	64, $f0-$f15
	# savef	64, $f0-$f31 # disabled for now, clarify spec
	restoref	64, $f0
	restoref	64, $f0-$f15
	# restoref	64, $f0-$f31 # disabled for now, clarify spec

.end	test
