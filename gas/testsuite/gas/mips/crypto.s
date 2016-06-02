	.set	noreorder
	.set	noat

	.text
test_crypto:
	aes128.enc	$w4, $w7
	aes128.dec	$w4, $w7
	aes192.enc	$w4, $w7, $w6
	aes192.dec	$w4, $w7, $w6
	aes256.enc	$w4, $w7, $w6
	aes256.dec	$w4, $w7, $w6
	aes.kg		$w4, $w7
	aes.fr.enc	$w4, $w7
	aes.fr.dec	$w4, $w7
	aes.lr.enc	$w4, $w7
	aes.lr.dec	$w4, $w7
	aes.mc.enc	$w4
	aes.mc.dec	$w4
	aes.sb.enc	$w4
	aes.sb.dec	$w4
	aes.sr.enc	$w4
	aes.sr.dec	$w4
	md5.ms		$w4, $w7, $w6
	md5.4r		$w4, $w7, $w6
	sha1.ms.1	$w4, $w7, $w6
	sha1.ms.2	$w4, $w7, $w4
	sha1.hash.4r	$w4, $w7, $w6
	sha256.ms.1	$w4, $w7, $w6
	sha256.ms.2	$w4, $w7, $w6
	sha256.hash.2r	$w4, $w7, $w6
	sha512.ms.1	$w4, $w7, $w6
	sha512.ms.2	$w4, $w7, $w6
	sha512.hash.r.1	$w4, $w7, $w6
	sha512.hash.r.2	$w4, $w7, $w6

# Force at least 8 (non-delay-slot) zero bytes, to make 'objdump' print ...
	.align	2
	.space	8

