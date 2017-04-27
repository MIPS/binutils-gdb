# mips r6 nanoMIPS test sanity, expected to pass.
# mach:	 mips32r7
# as:		-mabi=eabi
# ld:		-N -Ttext=0x80010000
# output:	*\\npass\\n

	.include "testutils.inc"

	setup 4, 6

	.set noreorder

	.ent DIAG
DIAG:

	writemsg "Sanity is good!", 4, 6

	pass

	.end DIAG
