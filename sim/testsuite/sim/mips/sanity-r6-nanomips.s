# mips r6 nanoMIPS test sanity, expected to pass.
# mach:	 32r6
# as:		-m32
# ld:		-N -Ttext=0x80010000
# output:	*\\npass\\n

	.include "testutils-r6-nanomips.inc"

	setup

	.set noreorder

	.ent DIAG
DIAG:

	writemsg "Sanity is good!"

	pass

	.end DIAG
