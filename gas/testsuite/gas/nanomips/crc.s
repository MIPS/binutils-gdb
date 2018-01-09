	.text
test_crc:
	crc32b	$a0,$a3
	crc32h	$a0,$a3
	crc32w	$a0,$a3
	crc32cb	$a0,$a3
	crc32ch	$a0,$a3
	crc32cw	$a0,$a3

# Force at least 8 (non-delay-slot) zero bytes, to make 'objdump' print ...
	.align  2
	.space  8
