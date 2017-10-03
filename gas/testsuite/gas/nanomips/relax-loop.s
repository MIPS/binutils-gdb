	.section .mdebug.abiP32
	.previous
	.module	softfloat
	.text
$Ltext0:
	.globl	sort_pagelist
$LFB1 = .
	.ent	sort_pagelist
	.type	sort_pagelist, @function
sort_pagelist:
$L6:
	bgeuc	$a4,$a0,$L7
	beqzc	$a1,$L56
	nop32
	bltuc	$a4,$a0,$L57
$L7:
	.space 16
	beqzc	$a1,$L5
	nop32
	bc	$L6
	nop
$L5:
	nop
$L10:
	.space 26
	beqzc	$s0,$L44
	.space 6
$L28:
	bgeuc	$a4,$a0,$L13
$L58:
	.space 22
	bltuc	$a4,$a0,$L58
$L13:
	.space 16
	beqzc	$a1,$L16
	nop32
	bc	$L28
$L56:
	nop
	bc	$L10
$L55:
	.space 16
	bnezc	$t4,$L18
	nop32
$L25:
	.space 12
	beqzc	$a0,$L39
	beqzc	$a3,$L40
	nop
	nop
	nop
$L21:
	bgeuc	$a4,$s0,$L22
$L59:
	.space 14
	beqzc	$a1,$L19
	nop32
	bltuc	$a4,$s0,$L59
$L22:
	.space 14
	beqzc	$a1,$L20
	nop32
	bc	$L21
$L40:
	nop
$L20:
	nop
$L24:
	nop32
	bneic	$a5,25,$L25
	nop
$L39:
	nop
$L19:
	nop
	bc	$L24
$L44:
	move	$s0,$a6
$L16:
	.end	sort_pagelist
	.size	sort_pagelist, .-sort_pagelist
