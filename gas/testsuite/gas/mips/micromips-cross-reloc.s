	.text
	.set micromips
	.ent test1
test1:
	.insn
	.half 0x0c00
	.half 0x0c00

	.set nomicromips
	.align 2
test3:
	la $3, test1+2
	.end test1
# Force at least 8 (non-delay-slot) zero bytes, to make 'objdump' print ...
      .space  8
