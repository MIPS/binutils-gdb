#objdump: -pdr --prefix-addresses --show-raw-insn
#name: MIPS Crypto
#as: -mcrypto

# Test the Crypto instructions

.*: +file format .*mips.*
#...
ASEs:
#...
	CRYPTO ASE
#...

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> 78003917 	aes128.enc	\$w4,\$w7
[0-9a-f]+ <[^>]*> 78013917 	aes128.dec	\$w4,\$w7
[0-9a-f]+ <[^>]*> 78463917 	aes192.enc	\$w4,\$w7,\$w6
[0-9a-f]+ <[^>]*> 78663917 	aes192.dec	\$w4,\$w7,\$w6
[0-9a-f]+ <[^>]*> 78863917 	aes256.enc	\$w4,\$w7,\$w6
[0-9a-f]+ <[^>]*> 78a63917 	aes256.dec	\$w4,\$w7,\$w6
[0-9a-f]+ <[^>]*> 781a3917 	aes.kg	\$w4,\$w7
[0-9a-f]+ <[^>]*> 78103917 	aes.fr.enc	\$w4,\$w7
[0-9a-f]+ <[^>]*> 78113917 	aes.fr.dec	\$w4,\$w7
[0-9a-f]+ <[^>]*> 78123917 	aes.lr.enc	\$w4,\$w7
[0-9a-f]+ <[^>]*> 78133917 	aes.lr.dec	\$w4,\$w7
[0-9a-f]+ <[^>]*> 78160117 	aes.mc.enc	\$w4
[0-9a-f]+ <[^>]*> 78170117 	aes.mc.dec	\$w4
[0-9a-f]+ <[^>]*> 78140117 	aes.sb.enc	\$w4
[0-9a-f]+ <[^>]*> 78150117 	aes.sb.dec	\$w4
[0-9a-f]+ <[^>]*> 78180117 	aes.sr.enc	\$w4
[0-9a-f]+ <[^>]*> 78190117 	aes.sr.dec	\$w4
[0-9a-f]+ <[^>]*> 7be63917 	md5.ms	\$w4,\$w7,\$w6
[0-9a-f]+ <[^>]*> 7ae63917 	md5.4r	\$w4,\$w7,\$w6
[0-9a-f]+ <[^>]*> 7b063917 	sha1.ms.1	\$w4,\$w7,\$w6
[0-9a-f]+ <[^>]*> 7b203917 	sha1.ms.2	\$w4,\$w7,\$w4
[0-9a-f]+ <[^>]*> 7a063917 	sha1.hash.4r	\$w4,\$w7,\$w6
[0-9a-f]+ <[^>]*> 7b463917 	sha256.ms.1	\$w4,\$w7,\$w6
[0-9a-f]+ <[^>]*> 7b663917 	sha256.ms.2	\$w4,\$w7,\$w6
[0-9a-f]+ <[^>]*> 7a463917 	sha256.hash.2r	\$w4,\$w7,\$w6
[0-9a-f]+ <[^>]*> 7b863917 	sha512.ms.1	\$w4,\$w7,\$w6
[0-9a-f]+ <[^>]*> 7ba63917 	sha512.ms.2	\$w4,\$w7,\$w6
[0-9a-f]+ <[^>]*> 7a863917 	sha512.hash.r.1	\$w4,\$w7,\$w6
[0-9a-f]+ <[^>]*> 7aa63917 	sha512.hash.r.2	\$w4,\$w7,\$w6

	\.\.\.
