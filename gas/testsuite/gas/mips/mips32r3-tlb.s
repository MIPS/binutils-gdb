# Source file to test assembly of MIPS32r3 TLB instructions.

	.text
foo:
	tlbinv
	tlbinvf

# Force at least 8 (non-delay-slot) zero bytes, to make 'objdump' print ...
	.align	2
	.space  8
