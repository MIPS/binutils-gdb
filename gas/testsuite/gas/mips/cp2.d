#objdump: -d --prefix-addresses --show-raw-insn
#name: MIPS CP2 register move instructions
#as: -32

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> 48800000 	mtc2	zero,\$0
[0-9a-f]+ <[^>]*> 48800800 	mtc2	zero,\$1
[0-9a-f]+ <[^>]*> 48801000 	mtc2	zero,\$2
[0-9a-f]+ <[^>]*> 48801800 	mtc2	zero,\$3
[0-9a-f]+ <[^>]*> 48802000 	mtc2	zero,\$4
[0-9a-f]+ <[^>]*> 48802800 	mtc2	zero,\$5
[0-9a-f]+ <[^>]*> 48803000 	mtc2	zero,\$6
[0-9a-f]+ <[^>]*> 48803800 	mtc2	zero,\$7
[0-9a-f]+ <[^>]*> 48804000 	mtc2	zero,\$8
[0-9a-f]+ <[^>]*> 48804800 	mtc2	zero,\$9
[0-9a-f]+ <[^>]*> 48805000 	mtc2	zero,\$10
[0-9a-f]+ <[^>]*> 48805800 	mtc2	zero,\$11
[0-9a-f]+ <[^>]*> 48806000 	mtc2	zero,\$12
[0-9a-f]+ <[^>]*> 48806800 	mtc2	zero,\$13
[0-9a-f]+ <[^>]*> 48807000 	mtc2	zero,\$14
[0-9a-f]+ <[^>]*> 48807800 	mtc2	zero,\$15
[0-9a-f]+ <[^>]*> 48808000 	mtc2	zero,\$16
[0-9a-f]+ <[^>]*> 48808800 	mtc2	zero,\$17
[0-9a-f]+ <[^>]*> 48809000 	mtc2	zero,\$18
[0-9a-f]+ <[^>]*> 48809800 	mtc2	zero,\$19
[0-9a-f]+ <[^>]*> 4880a000 	mtc2	zero,\$20
[0-9a-f]+ <[^>]*> 4880a800 	mtc2	zero,\$21
[0-9a-f]+ <[^>]*> 4880b000 	mtc2	zero,\$22
[0-9a-f]+ <[^>]*> 4880b800 	mtc2	zero,\$23
[0-9a-f]+ <[^>]*> 4880c000 	mtc2	zero,\$24
[0-9a-f]+ <[^>]*> 4880c800 	mtc2	zero,\$25
[0-9a-f]+ <[^>]*> 4880d000 	mtc2	zero,\$26
[0-9a-f]+ <[^>]*> 4880d800 	mtc2	zero,\$27
[0-9a-f]+ <[^>]*> 4880e000 	mtc2	zero,\$28
[0-9a-f]+ <[^>]*> 4880e800 	mtc2	zero,\$29
[0-9a-f]+ <[^>]*> 4880f000 	mtc2	zero,\$30
[0-9a-f]+ <[^>]*> 4880f800 	mtc2	zero,\$31
[0-9a-f]+ <[^>]*> 48000000 	mfc2	zero,\$0
[0-9a-f]+ <[^>]*> 48000800 	mfc2	zero,\$1
[0-9a-f]+ <[^>]*> 48001000 	mfc2	zero,\$2
[0-9a-f]+ <[^>]*> 48001800 	mfc2	zero,\$3
[0-9a-f]+ <[^>]*> 48002000 	mfc2	zero,\$4
[0-9a-f]+ <[^>]*> 48002800 	mfc2	zero,\$5
[0-9a-f]+ <[^>]*> 48003000 	mfc2	zero,\$6
[0-9a-f]+ <[^>]*> 48003800 	mfc2	zero,\$7
[0-9a-f]+ <[^>]*> 48004000 	mfc2	zero,\$8
[0-9a-f]+ <[^>]*> 48004800 	mfc2	zero,\$9
[0-9a-f]+ <[^>]*> 48005000 	mfc2	zero,\$10
[0-9a-f]+ <[^>]*> 48005800 	mfc2	zero,\$11
[0-9a-f]+ <[^>]*> 48006000 	mfc2	zero,\$12
[0-9a-f]+ <[^>]*> 48006800 	mfc2	zero,\$13
[0-9a-f]+ <[^>]*> 48007000 	mfc2	zero,\$14
[0-9a-f]+ <[^>]*> 48007800 	mfc2	zero,\$15
[0-9a-f]+ <[^>]*> 48008000 	mfc2	zero,\$16
[0-9a-f]+ <[^>]*> 48008800 	mfc2	zero,\$17
[0-9a-f]+ <[^>]*> 48009000 	mfc2	zero,\$18
[0-9a-f]+ <[^>]*> 48009800 	mfc2	zero,\$19
[0-9a-f]+ <[^>]*> 4800a000 	mfc2	zero,\$20
[0-9a-f]+ <[^>]*> 4800a800 	mfc2	zero,\$21
[0-9a-f]+ <[^>]*> 4800b000 	mfc2	zero,\$22
[0-9a-f]+ <[^>]*> 4800b800 	mfc2	zero,\$23
[0-9a-f]+ <[^>]*> 4800c000 	mfc2	zero,\$24
[0-9a-f]+ <[^>]*> 4800c800 	mfc2	zero,\$25
[0-9a-f]+ <[^>]*> 4800d000 	mfc2	zero,\$26
[0-9a-f]+ <[^>]*> 4800d800 	mfc2	zero,\$27
[0-9a-f]+ <[^>]*> 4800e000 	mfc2	zero,\$28
[0-9a-f]+ <[^>]*> 4800e800 	mfc2	zero,\$29
[0-9a-f]+ <[^>]*> 4800f000 	mfc2	zero,\$30
[0-9a-f]+ <[^>]*> 4800f800 	mfc2	zero,\$31
[0-9a-f]+ <[^>]*> 48c00000 	ctc2	zero,\$0
[0-9a-f]+ <[^>]*> 48c00800 	ctc2	zero,\$1
[0-9a-f]+ <[^>]*> 48c01000 	ctc2	zero,\$2
[0-9a-f]+ <[^>]*> 48c01800 	ctc2	zero,\$3
[0-9a-f]+ <[^>]*> 48c02000 	ctc2	zero,\$4
[0-9a-f]+ <[^>]*> 48c02800 	ctc2	zero,\$5
[0-9a-f]+ <[^>]*> 48c03000 	ctc2	zero,\$6
[0-9a-f]+ <[^>]*> 48c03800 	ctc2	zero,\$7
[0-9a-f]+ <[^>]*> 48c04000 	ctc2	zero,\$8
[0-9a-f]+ <[^>]*> 48c04800 	ctc2	zero,\$9
[0-9a-f]+ <[^>]*> 48c05000 	ctc2	zero,\$10
[0-9a-f]+ <[^>]*> 48c05800 	ctc2	zero,\$11
[0-9a-f]+ <[^>]*> 48c06000 	ctc2	zero,\$12
[0-9a-f]+ <[^>]*> 48c06800 	ctc2	zero,\$13
[0-9a-f]+ <[^>]*> 48c07000 	ctc2	zero,\$14
[0-9a-f]+ <[^>]*> 48c07800 	ctc2	zero,\$15
[0-9a-f]+ <[^>]*> 48c08000 	ctc2	zero,\$16
[0-9a-f]+ <[^>]*> 48c08800 	ctc2	zero,\$17
[0-9a-f]+ <[^>]*> 48c09000 	ctc2	zero,\$18
[0-9a-f]+ <[^>]*> 48c09800 	ctc2	zero,\$19
[0-9a-f]+ <[^>]*> 48c0a000 	ctc2	zero,\$20
[0-9a-f]+ <[^>]*> 48c0a800 	ctc2	zero,\$21
[0-9a-f]+ <[^>]*> 48c0b000 	ctc2	zero,\$22
[0-9a-f]+ <[^>]*> 48c0b800 	ctc2	zero,\$23
[0-9a-f]+ <[^>]*> 48c0c000 	ctc2	zero,\$24
[0-9a-f]+ <[^>]*> 48c0c800 	ctc2	zero,\$25
[0-9a-f]+ <[^>]*> 48c0d000 	ctc2	zero,\$26
[0-9a-f]+ <[^>]*> 48c0d800 	ctc2	zero,\$27
[0-9a-f]+ <[^>]*> 48c0e000 	ctc2	zero,\$28
[0-9a-f]+ <[^>]*> 48c0e800 	ctc2	zero,\$29
[0-9a-f]+ <[^>]*> 48c0f000 	ctc2	zero,\$30
[0-9a-f]+ <[^>]*> 48c0f800 	ctc2	zero,\$31
[0-9a-f]+ <[^>]*> 48400000 	cfc2	zero,\$0
[0-9a-f]+ <[^>]*> 48400800 	cfc2	zero,\$1
[0-9a-f]+ <[^>]*> 48401000 	cfc2	zero,\$2
[0-9a-f]+ <[^>]*> 48401800 	cfc2	zero,\$3
[0-9a-f]+ <[^>]*> 48402000 	cfc2	zero,\$4
[0-9a-f]+ <[^>]*> 48402800 	cfc2	zero,\$5
[0-9a-f]+ <[^>]*> 48403000 	cfc2	zero,\$6
[0-9a-f]+ <[^>]*> 48403800 	cfc2	zero,\$7
[0-9a-f]+ <[^>]*> 48404000 	cfc2	zero,\$8
[0-9a-f]+ <[^>]*> 48404800 	cfc2	zero,\$9
[0-9a-f]+ <[^>]*> 48405000 	cfc2	zero,\$10
[0-9a-f]+ <[^>]*> 48405800 	cfc2	zero,\$11
[0-9a-f]+ <[^>]*> 48406000 	cfc2	zero,\$12
[0-9a-f]+ <[^>]*> 48406800 	cfc2	zero,\$13
[0-9a-f]+ <[^>]*> 48407000 	cfc2	zero,\$14
[0-9a-f]+ <[^>]*> 48407800 	cfc2	zero,\$15
[0-9a-f]+ <[^>]*> 48408000 	cfc2	zero,\$16
[0-9a-f]+ <[^>]*> 48408800 	cfc2	zero,\$17
[0-9a-f]+ <[^>]*> 48409000 	cfc2	zero,\$18
[0-9a-f]+ <[^>]*> 48409800 	cfc2	zero,\$19
[0-9a-f]+ <[^>]*> 4840a000 	cfc2	zero,\$20
[0-9a-f]+ <[^>]*> 4840a800 	cfc2	zero,\$21
[0-9a-f]+ <[^>]*> 4840b000 	cfc2	zero,\$22
[0-9a-f]+ <[^>]*> 4840b800 	cfc2	zero,\$23
[0-9a-f]+ <[^>]*> 4840c000 	cfc2	zero,\$24
[0-9a-f]+ <[^>]*> 4840c800 	cfc2	zero,\$25
[0-9a-f]+ <[^>]*> 4840d000 	cfc2	zero,\$26
[0-9a-f]+ <[^>]*> 4840d800 	cfc2	zero,\$27
[0-9a-f]+ <[^>]*> 4840e000 	cfc2	zero,\$28
[0-9a-f]+ <[^>]*> 4840e800 	cfc2	zero,\$29
[0-9a-f]+ <[^>]*> 4840f000 	cfc2	zero,\$30
[0-9a-f]+ <[^>]*> 4840f800 	cfc2	zero,\$31
	\.\.\.
