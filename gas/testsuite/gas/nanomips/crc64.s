	.text
test_crc:
	crc32d	$a0,$a3
	crc32cd	$a0,$a3

# Force at least 8 (non-delay-slot) zero bytes, to make 'objdump' print ...
	.align  2
	.space  8
