	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=xx
	.module	nooddspreg
	.abicalls
	.option	pic0
	.text
$Ltext0:
	.cfi_sections	.debug_frame
	.align	2
$LFB0 = .
	.file 1 "ifunc-static-def.c"
	.loc 1 3 0
	.cfi_startproc
	.set	mips16
	.set	nomicromips
	.ent	f1_a
	.type	f1_a, @function
f1_a:
	.frame	$17,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x00020000,-4
	.fmask	0x00000000,0
	save	8,$17
	.cfi_def_cfa_offset 8
	.cfi_offset 17, -4
	move	$17,$sp
	.cfi_def_cfa_register 17
	.loc 1 3 0
	li	$2,1
	move	$sp,$17
	.cfi_def_cfa_register 29
	restore	8,$17
	.cfi_restore 17
	.cfi_def_cfa_offset 0
	j	$31
	.end	f1_a
	.cfi_endproc
$LFE0:
	.size	f1_a, .-f1_a
	.align	2
$LFB1 = .
	.loc 1 4 0
	.cfi_startproc
	.set	mips16
	.set	nomicromips
	.ent	f1_b
	.type	f1_b, @function
f1_b:
	.frame	$17,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x00020000,-4
	.fmask	0x00000000,0
	save	8,$17
	.cfi_def_cfa_offset 8
	.cfi_offset 17, -4
	move	$17,$sp
	.cfi_def_cfa_register 17
	.loc 1 4 0
	li	$2,2
	move	$sp,$17
	.cfi_def_cfa_register 29
	restore	8,$17
	.cfi_restore 17
	.cfi_def_cfa_offset 0
	j	$31
	.end	f1_b
	.cfi_endproc
$LFE1:
	.size	f1_b, .-f1_b
	.align	2
$LFB2 = .
	.loc 1 5 0
	.cfi_startproc
	.set	mips16
	.set	nomicromips
	.ent	f1_c
	.type	f1_c, @function
f1_c:
	.frame	$17,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x00020000,-4
	.fmask	0x00000000,0
	save	8,$17
	.cfi_def_cfa_offset 8
	.cfi_offset 17, -4
	move	$17,$sp
	.cfi_def_cfa_register 17
	.loc 1 5 0
	li	$2,3
	move	$sp,$17
	.cfi_def_cfa_register 29
	restore	8,$17
	.cfi_restore 17
	.cfi_def_cfa_offset 0
	j	$31
	.end	f1_c
	.cfi_endproc
$LFE2:
	.size	f1_c, .-f1_c

	.comm	global,4,4
	.globl	result
	.data
	.align	2
	.type	result, @object
	.size	result, 4
result:
	.word	6
	.text
	.align	2
	.globl	func1_ifunc
$LFB3 = .
	.loc 1 12 0
	.cfi_startproc
	.set	mips16
	.set	nomicromips
	.ent	func1_ifunc
	.type	func1_ifunc, @function
func1_ifunc:
	.frame	$17,24,$31		# vars= 8, regs= 1/0, args= 0, gp= 8
	.mask	0x00020000,-4
	.fmask	0x00000000,0
	save	24,$17
	.cfi_def_cfa_offset 24
	.cfi_offset 17, -4
	move	$17,$sp
	.cfi_def_cfa_register 17
	.loc 1 15 0
	lw	$2,$L13
	lw	$2,0($2)
	beqz	$2,$L8
	.loc 1 16 0
	li	$2,48
	sw	$2,8($17)
	b	$L9
$L8:
	.loc 1 18 0
	li	$2,3
	sw	$2,8($17)
$L9:
	.loc 1 20 0
	lw	$3,8($17)
	li	$2,240
	and	$2,$3
	beqz	$2,$L10
	.loc 1 21 0
	lw	$2,$L14
	b	$L11
$L10:
	.loc 1 22 0
	lw	$3,8($17)
	li	$2,15
	and	$2,$3
	beqz	$2,$L12
	.loc 1 23 0
	lw	$2,$L15
	b	$L11
$L12:
	.loc 1 25 0
	lw	$2,$L16
$L11:
	.loc 1 26 0
	move	$sp,$17
	.cfi_def_cfa_register 29
	restore	24,$17
	.cfi_restore 17
	.cfi_def_cfa_offset 0
	j	$31
	.align	2
$L13:
	.word	global
$L14:
	.word	f1_a
$L15:
	.word	f1_b
$L16:
	.word	f1_c
	.end	func1_ifunc
	.cfi_endproc
$LFE3:
	.size	func1_ifunc, .-func1_ifunc
	.globl	func1
	.type	func1, @gnu_indirect_function
	func1 = func1_ifunc
$Letext0:
	.section	.debug_info,"",@progbits
$Ldebug_info0:
	.4byte	0xb9
	.2byte	0x4
	.4byte	$Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	$LASF5
	.byte	0xc
	.4byte	$LASF6
	.4byte	$LASF7
	.4byte	$Ltext0
	.4byte	$Letext0-$Ltext0
	.4byte	$Ldebug_line0
	.uleb128 0x2
	.4byte	$LASF0
	.byte	0x1
	.byte	0x3
	.4byte	0x3a
	.4byte	$LFB0
	.4byte	$LFE0-$LFB0
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x2
	.4byte	$LASF1
	.byte	0x1
	.byte	0x4
	.4byte	0x3a
	.4byte	$LFB1
	.4byte	$LFE1-$LFB1
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x2
	.4byte	$LASF2
	.byte	0x1
	.byte	0x5
	.4byte	0x3a
	.4byte	$LFB2
	.4byte	$LFE2-$LFB2
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x4
	.4byte	$LASF8
	.byte	0x1
	.byte	0xb
	.4byte	0x93
	.4byte	$LFB3
	.4byte	$LFE3-$LFB3
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x93
	.uleb128 0x5
	.4byte	$LASF4
	.byte	0x1
	.byte	0xd
	.4byte	0x95
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.byte	0
	.uleb128 0x6
	.byte	0x4
	.uleb128 0x7
	.4byte	0x3a
	.uleb128 0x8
	.4byte	$LASF3
	.byte	0x1
	.byte	0x7
	.4byte	0x3a
	.uleb128 0x5
	.byte	0x3
	.4byte	global
	.uleb128 0x8
	.4byte	$LASF4
	.byte	0x1
	.byte	0x8
	.4byte	0x95
	.uleb128 0x5
	.byte	0x3
	.4byte	result
	.byte	0
	.section	.debug_abbrev,"",@progbits
$Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	$Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	$Ltext0
	.4byte	$Letext0-$Ltext0
	.4byte	0
	.4byte	0
	.section	.debug_line,"",@progbits
$Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
$LASF8:
	.ascii	"func1_ifunc\000"
$LASF5:
	.ascii	"GNU C11 5.0.0 20150302 (experimental) -mel -mno-shared -"
	.ascii	"mips16 -mel -mno-relax-pic-calls -mllsc -mplt -mips32r2 "
	.ascii	"-msynci -mabi=32 -mfpxx -g\000"
$LASF4:
	.ascii	"result\000"
$LASF6:
	.ascii	"ifunc-static-def.c\000"
$LASF7:
	.ascii	"/home/frs/tmp/ifunc/test\000"
$LASF3:
	.ascii	"global\000"
$LASF0:
	.ascii	"f1_a\000"
$LASF1:
	.ascii	"f1_b\000"
$LASF2:
	.ascii	"f1_c\000"
	.ident	"GCC: (GNU) 5.0.0 20150302 (experimental)"
