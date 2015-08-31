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
	.globl	main
$LFB0 = .
	.file 1 "ifunc-static-main.c"
	.loc 1 4 0
	.cfi_startproc
	.set	mips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$17,16,$31		# vars= 0, regs= 2/0, args= 16, gp= 8
	.mask	0x80020000,-4
	.fmask	0x00000000,0
	save	32,$17,$31
	.cfi_def_cfa_offset 32
	.cfi_offset 31, -4
	.cfi_offset 17, -8
	addiu	$17,$sp,16
	.cfi_def_cfa 17, 16
	.loc 1 5 0
	jal	func1
	.loc 1 6 0
	move	$sp,$17
	.cfi_def_cfa_register 29
	restore	16,$17,$31
	.cfi_restore 17
	.cfi_restore 31
	.cfi_def_cfa_offset 0
	j	$31
	.end	main
	.cfi_endproc
$LFE0:
	.size	main, .-main
$Letext0:
	.section	.debug_info,"",@progbits
$Ldebug_info0:
	.4byte	0x3e
	.2byte	0x4
	.4byte	$Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	$LASF0
	.byte	0xc
	.4byte	$LASF1
	.4byte	$LASF2
	.4byte	$Ltext0
	.4byte	$Letext0-$Ltext0
	.4byte	$Ldebug_line0
	.uleb128 0x2
	.4byte	$LASF3
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
	.uleb128 0x2116
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
$LASF1:
	.ascii	"ifunc-static-main.c\000"
$LASF0:
	.ascii	"GNU C11 5.0.0 20150302 (experimental) -mel -mno-shared -"
	.ascii	"mips16 -mel -mllsc -mplt -mips32r2 "
	.ascii	"-msynci -mabi=32 -mfpxx -g\000"
$LASF2:
	.ascii	"/home/frs/tmp/ifunc/test\000"
$LASF3:
	.ascii	"main\000"
	.ident	"GCC: (GNU) 5.0.0 20150302 (experimental)"
