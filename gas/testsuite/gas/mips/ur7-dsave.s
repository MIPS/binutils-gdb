	.text
	.ent	test
	.globl	test
test:
	dsave	32,$31
	dsave	32,$fp
	dsave	32,$s0
	dsave	32,$s0-$s3
	dsave	128,$s0-$s7,$fp,$gp
	dsave	128,$3,$s0,$gp

	drestore	32,$gp
	drestore	32,$fp
	drestore	32,$s0
	drestore	32,$s0-$s3
	drestore	128,$s0-$s7,$fp,$gp
	drestore	128,$3,$s0,$gp

	dsave	32,$31
	dsave	32,$31,$s0
	dsave	32,$31,$s0-$s3
	dsave	64,$31,$s0-$s7,$fp
	dsave	64,$31,$s0

	drestore	32,$31
	drestore	32,$31,$s0
	drestore	32,$31,$s0-$s3
	drestore	64,$31,$s0-$s7,$fp
	drestore	64,$31,$s0

	dsave	64,$31,$s0-$fp
	dsave	64,$31,$s0-$gp
	dsave	64,$3,$s0-$fp
	dsave	64,$3,$s0-$sp,$fp
	dsave	64,$3,$s0-$sp,$gp
	dsave	64,$3,$s0-$gp

	drestore	64,$31,$s0-$fp
	drestore	64,$31,$s0-$gp
	drestore	64,$3,$s0-$fp
	drestore	64,$3,$s0-$sp,$fp
	drestore	64,$3,$s0-$sp,$gp
	drestore	64,$3,$s0-$gp

	drestore	128

	savef	64, $f0
	savef	64, $f0-$f15
	# savef	64, $f0-$f31 # disabled for now, clarify spec
	restoref	64, $f0
	restoref	64, $f0-$f15
	# restoref	64, $f0-$f31 # disabled for now, clarify spec

.end	test
