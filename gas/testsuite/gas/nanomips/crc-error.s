	.text
test_crc:
	.set crc		# OK
	crc32b	$a0,$a3	# OK
	crc32d	$a0,$a3	# ERROR: 64-bit only
	crc32b	$a0,$a3	# OK
	.set nocrc
	crc32b	$a0,$a3	# ERROR: crc not enabled
	.set arch=64r6
	.set crc
	crc32d	$a0,$a3	# OK
	.set nocrc
	crc32b	$a0,$a3	# ERROR: crc not enabled
