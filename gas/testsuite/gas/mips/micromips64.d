#objdump: -dr --show-raw-insn
#name: microMIPS for MIPS64r2
#as: -mmicromips -n32 -mips64r2 -mfp64 -EB
#stderr: micromips64-warn.l
#source: micromips64.s

.*: +file format .*mips.*

Disassembly of section \.text:

[0-9a-f]+ <test_mips64>:
[ 0-9a-f]+:	4043 0000 	bgez	v1,[0-9a-f]+ <.*>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.*
[ 0-9a-f]+:	0c43      	move	v0,v1
[ 0-9a-f]+:	5860 1190 	dneg	v0,v1
[ 0-9a-f]+:	4042 0000 	bgez	v0,[0-9a-f]+ <.*>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.*
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	5840 1190 	dneg	v0,v0
[ 0-9a-f]+:	4042 0000 	bgez	v0,[0-9a-f]+ <.*>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.*
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	5840 1190 	dneg	v0,v0
[ 0-9a-f]+:	5883 1110 	dadd	v0,v1,a0
[ 0-9a-f]+:	5bfe e910 	dadd	sp,s8,ra
[ 0-9a-f]+:	5862 1110 	dadd	v0,v0,v1
[ 0-9a-f]+:	5862 1110 	dadd	v0,v0,v1
[ 0-9a-f]+:	5843 001c 	daddi	v0,v1,0
[ 0-9a-f]+:	5843 005c 	daddi	v0,v1,1
[ 0-9a-f]+:	5843 801c 	daddi	v0,v1,-512
[ 0-9a-f]+:	5843 7fdc 	daddi	v0,v1,511
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	5823 1110 	dadd	v0,v1,at
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	5823 1110 	dadd	v0,v1,at
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	5823 1110 	dadd	v0,v1,at
[ 0-9a-f]+:	41a1 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5678 	ori	at,at,0x5678
[ 0-9a-f]+:	5823 1110 	dadd	v0,v1,at
[ 0-9a-f]+:	41a1 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5678 	ori	at,at,0x5678
[ 0-9a-f]+:	5821 8000 	dsll	at,at,0x10
[ 0-9a-f]+:	5021 8765 	ori	at,at,0x8765
[ 0-9a-f]+:	5821 8000 	dsll	at,at,0x10
[ 0-9a-f]+:	5021 4321 	ori	at,at,0x4321
[ 0-9a-f]+:	5823 1110 	dadd	v0,v1,at
[ 0-9a-f]+:	5843 001c 	daddi	v0,v1,0
[ 0-9a-f]+:	5843 005c 	daddi	v0,v1,1
[ 0-9a-f]+:	5843 801c 	daddi	v0,v1,-512
[ 0-9a-f]+:	5843 7fdc 	daddi	v0,v1,511
[ 0-9a-f]+:	5842 7fdc 	daddi	v0,v0,511
[ 0-9a-f]+:	5842 7fdc 	daddi	v0,v0,511
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	5823 1110 	dadd	v0,v1,at
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	5823 1110 	dadd	v0,v1,at
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	5823 1110 	dadd	v0,v1,at
[ 0-9a-f]+:	41a1 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5678 	ori	at,at,0x5678
[ 0-9a-f]+:	5823 1110 	dadd	v0,v1,at
[ 0-9a-f]+:	5c43 0000 	daddiu	v0,v1,0
[ 0-9a-f]+:	5c43 8000 	daddiu	v0,v1,-32768
[ 0-9a-f]+:	5c43 7fff 	daddiu	v0,v1,32767
[ 0-9a-f]+:	5c42 7fff 	daddiu	v0,v0,32767
[ 0-9a-f]+:	5c42 7fff 	daddiu	v0,v0,32767
[ 0-9a-f]+:	5883 1150 	daddu	v0,v1,a0
[ 0-9a-f]+:	5bfe e950 	daddu	sp,s8,ra
[ 0-9a-f]+:	5862 1150 	daddu	v0,v0,v1
[ 0-9a-f]+:	5862 1150 	daddu	v0,v0,v1
[ 0-9a-f]+:	5803 1150 	move	v0,v1
[ 0-9a-f]+:	5c43 0000 	daddiu	v0,v1,0
[ 0-9a-f]+:	5c43 0001 	daddiu	v0,v1,1
[ 0-9a-f]+:	5c43 7fff 	daddiu	v0,v1,32767
[ 0-9a-f]+:	5c43 8000 	daddiu	v0,v1,-32768
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	5823 1150 	daddu	v0,v1,at
[ 0-9a-f]+:	5843 4b3c 	dclo	v0,v1
[ 0-9a-f]+:	5862 4b3c 	dclo	v1,v0
[ 0-9a-f]+:	5843 5b3c 	dclz	v0,v1
[ 0-9a-f]+:	5862 5b3c 	dclz	v1,v0
[ 0-9a-f]+:	5862 ab3c 	ddiv	zero,v0,v1
[ 0-9a-f]+:	5bfe ab3c 	ddiv	zero,s8,ra
[ 0-9a-f]+:	5860 ab3c 	ddiv	zero,zero,v1
[ 0-9a-f]+:	5be0 ab3c 	ddiv	zero,zero,ra
[ 0-9a-f]+:	4687      	break	0x7
[ 0-9a-f]+:	b404 0000 	bnez	a0,[0-9a-f]+ <.*\+0x[0-9a-f]+>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.*
[ 0-9a-f]+:	5883 ab3c 	ddiv	zero,v1,a0
[ 0-9a-f]+:	4687      	break	0x7
[ 0-9a-f]+:	3020 ffff 	li	at,-1
[ 0-9a-f]+:	b424 0000 	bne	a0,at,[0-9a-f]+ <.*\+0x[0-9a-f]+>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.*
[ 0-9a-f]+:	3020 0001 	li	at,1
[ 0-9a-f]+:	5821 f808 	dsll32	at,at,0x1f
[ 0-9a-f]+:	b423 0000 	bne	v1,at,[0-9a-f]+ <.*\+0x[0-9a-f]+>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.*
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	4686      	break	0x6
[ 0-9a-f]+:	4642      	mflo	v0
[ 0-9a-f]+:	4687      	break	0x7
[ 0-9a-f]+:	0c64      	move	v1,a0
[ 0-9a-f]+:	5880 1990 	dneg	v1,a0
[ 0-9a-f]+:	3020 0002 	li	at,2
[ 0-9a-f]+:	5824 ab3c 	ddiv	zero,a0,at
[ 0-9a-f]+:	4643      	mflo	v1
[ 0-9a-f]+:	5862 bb3c 	ddivu	zero,v0,v1
[ 0-9a-f]+:	5bfe bb3c 	ddivu	zero,s8,ra
[ 0-9a-f]+:	5860 bb3c 	ddivu	zero,zero,v1
[ 0-9a-f]+:	5be0 bb3c 	ddivu	zero,zero,ra
[ 0-9a-f]+:	b400 0000 	bnez	zero,[0-9a-f]+ <.*\+0x[0-9a-f]+>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.*
[ 0-9a-f]+:	5803 bb3c 	ddivu	zero,v1,zero
[ 0-9a-f]+:	4687      	break	0x7
[ 0-9a-f]+:	4642      	mflo	v0
[ 0-9a-f]+:	b404 0000 	bnez	a0,[0-9a-f]+ <.*\+0x[0-9a-f]+>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.*
[ 0-9a-f]+:	5883 bb3c 	ddivu	zero,v1,a0
[ 0-9a-f]+:	4687      	break	0x7
[ 0-9a-f]+:	4642      	mflo	v0
[ 0-9a-f]+:	4687      	break	0x7
[ 0-9a-f]+:	0c64      	move	v1,a0
[ 0-9a-f]+:	3020 ffff 	li	at,-1
[ 0-9a-f]+:	5824 bb3c 	ddivu	zero,a0,at
[ 0-9a-f]+:	4643      	mflo	v1
[ 0-9a-f]+:	3020 0002 	li	at,2
[ 0-9a-f]+:	5824 bb3c 	ddivu	zero,a0,at
[ 0-9a-f]+:	4643      	mflo	v1
[ 0-9a-f]+:	5843 07ec 	dext	v0,v1,0x1f,0x1
[ 0-9a-f]+:	5843 f82c 	dext	v0,v1,0x0,0x20
[ 0-9a-f]+:	5843 07e4 	dext	v0,v1,0x1f,0x21
[ 0-9a-f]+:	5843 07e4 	dext	v0,v1,0x1f,0x21
[ 0-9a-f]+:	5843 4854 	dext	v0,v1,0x21,0xa
[ 0-9a-f]+:	5843 4854 	dext	v0,v1,0x21,0xa
[ 0-9a-f]+:	5843 ffcc 	dins	v0,v1,0x1f,0x1
[ 0-9a-f]+:	5843 f80c 	dins	v0,v1,0x0,0x20
[ 0-9a-f]+:	5843 ffc4 	dins	v0,v1,0x1f,0x21
[ 0-9a-f]+:	5843 ffc4 	dins	v0,v1,0x1f,0x21
[ 0-9a-f]+:	5843 5074 	dins	v0,v1,0x21,0xa
[ 0-9a-f]+:	5843 5074 	dins	v0,v1,0x21,0xa
[ 0-9a-f]+:	41a2 0000 	lui	v0,0x0
[ 	]*[0-9a-f]+: R_MICROMIPS_HI16	test
[ 0-9a-f]+:	3042 0000 	addiu	v0,v0,0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	41a2 0000 	lui	v0,0x0
[ 	]*[0-9a-f]+: R_MICROMIPS_HI16	test
[ 0-9a-f]+:	3042 0000 	addiu	v0,v0,0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	3040 8000 	li	v0,-32768
[ 0-9a-f]+:	3040 7fff 	li	v0,32767
[ 0-9a-f]+:	5040 ffff 	li	v0,0xffff
[ 0-9a-f]+:	41a2 1234 	lui	v0,0x1234
[ 0-9a-f]+:	5042 5678 	ori	v0,v0,0x5678
[ 0-9a-f]+:	5840 00fc 	dmfc0	v0,c0_index
[ 0-9a-f]+:	5841 00fc 	dmfc0	v0,c0_random
[ 0-9a-f]+:	5842 00fc 	dmfc0	v0,c0_entrylo0
[ 0-9a-f]+:	5843 00fc 	dmfc0	v0,c0_entrylo1
[ 0-9a-f]+:	5844 00fc 	dmfc0	v0,c0_context
[ 0-9a-f]+:	5845 00fc 	dmfc0	v0,c0_pagemask
[ 0-9a-f]+:	5846 00fc 	dmfc0	v0,c0_wired
[ 0-9a-f]+:	5847 00fc 	dmfc0	v0,c0_hwrena
[ 0-9a-f]+:	5848 00fc 	dmfc0	v0,c0_badvaddr
[ 0-9a-f]+:	5849 00fc 	dmfc0	v0,c0_count
[ 0-9a-f]+:	584a 00fc 	dmfc0	v0,c0_entryhi
[ 0-9a-f]+:	584b 00fc 	dmfc0	v0,c0_compare
[ 0-9a-f]+:	584c 00fc 	dmfc0	v0,c0_status
[ 0-9a-f]+:	584d 00fc 	dmfc0	v0,c0_cause
[ 0-9a-f]+:	584e 00fc 	dmfc0	v0,c0_epc
[ 0-9a-f]+:	584f 00fc 	dmfc0	v0,c0_prid
[ 0-9a-f]+:	5850 00fc 	dmfc0	v0,c0_config
[ 0-9a-f]+:	5851 00fc 	dmfc0	v0,c0_lladdr
[ 0-9a-f]+:	5852 00fc 	dmfc0	v0,c0_watchlo
[ 0-9a-f]+:	5853 00fc 	dmfc0	v0,c0_watchhi
[ 0-9a-f]+:	5854 00fc 	dmfc0	v0,c0_xcontext
[ 0-9a-f]+:	5855 00fc 	dmfc0	v0,\$21
[ 0-9a-f]+:	5856 00fc 	dmfc0	v0,\$22
[ 0-9a-f]+:	5857 00fc 	dmfc0	v0,c0_debug
[ 0-9a-f]+:	5858 00fc 	dmfc0	v0,c0_depc
[ 0-9a-f]+:	5859 00fc 	dmfc0	v0,c0_perfcnt
[ 0-9a-f]+:	585a 00fc 	dmfc0	v0,c0_errctl
[ 0-9a-f]+:	585b 00fc 	dmfc0	v0,c0_cacheerr
[ 0-9a-f]+:	585c 00fc 	dmfc0	v0,c0_taglo
[ 0-9a-f]+:	585d 00fc 	dmfc0	v0,c0_taghi
[ 0-9a-f]+:	585e 00fc 	dmfc0	v0,c0_errorepc
[ 0-9a-f]+:	585f 00fc 	dmfc0	v0,c0_desave
[ 0-9a-f]+:	5840 00fc 	dmfc0	v0,c0_index
[ 0-9a-f]+:	5840 08fc 	dmfc0	v0,c0_mvpcontrol
[ 0-9a-f]+:	5840 10fc 	dmfc0	v0,c0_mvpconf0
[ 0-9a-f]+:	5840 18fc 	dmfc0	v0,c0_mvpconf1
[ 0-9a-f]+:	5840 20fc 	dmfc0	v0,\$0,4
[ 0-9a-f]+:	5840 28fc 	dmfc0	v0,\$0,5
[ 0-9a-f]+:	5840 30fc 	dmfc0	v0,\$0,6
[ 0-9a-f]+:	5840 38fc 	dmfc0	v0,\$0,7
[ 0-9a-f]+:	5841 00fc 	dmfc0	v0,c0_random
[ 0-9a-f]+:	5841 08fc 	dmfc0	v0,c0_vpecontrol
[ 0-9a-f]+:	5841 10fc 	dmfc0	v0,c0_vpeconf0
[ 0-9a-f]+:	5841 18fc 	dmfc0	v0,c0_vpeconf1
[ 0-9a-f]+:	5841 20fc 	dmfc0	v0,c0_yqmask
[ 0-9a-f]+:	5841 28fc 	dmfc0	v0,c0_vpeschedule
[ 0-9a-f]+:	5841 30fc 	dmfc0	v0,c0_vpeschefback
[ 0-9a-f]+:	5841 38fc 	dmfc0	v0,\$1,7
[ 0-9a-f]+:	5842 00fc 	dmfc0	v0,c0_entrylo0
[ 0-9a-f]+:	5842 08fc 	dmfc0	v0,c0_tcstatus
[ 0-9a-f]+:	5842 10fc 	dmfc0	v0,c0_tcbind
[ 0-9a-f]+:	5842 18fc 	dmfc0	v0,c0_tcrestart
[ 0-9a-f]+:	5842 20fc 	dmfc0	v0,c0_tchalt
[ 0-9a-f]+:	5842 28fc 	dmfc0	v0,c0_tccontext
[ 0-9a-f]+:	5842 30fc 	dmfc0	v0,c0_tcschedule
[ 0-9a-f]+:	5842 38fc 	dmfc0	v0,c0_tcschefback
[ 0-9a-f]+:	5840 02fc 	dmtc0	v0,c0_index
[ 0-9a-f]+:	5841 02fc 	dmtc0	v0,c0_random
[ 0-9a-f]+:	5842 02fc 	dmtc0	v0,c0_entrylo0
[ 0-9a-f]+:	5843 02fc 	dmtc0	v0,c0_entrylo1
[ 0-9a-f]+:	5844 02fc 	dmtc0	v0,c0_context
[ 0-9a-f]+:	5845 02fc 	dmtc0	v0,c0_pagemask
[ 0-9a-f]+:	5846 02fc 	dmtc0	v0,c0_wired
[ 0-9a-f]+:	5847 02fc 	dmtc0	v0,c0_hwrena
[ 0-9a-f]+:	5848 02fc 	dmtc0	v0,c0_badvaddr
[ 0-9a-f]+:	5849 02fc 	dmtc0	v0,c0_count
[ 0-9a-f]+:	584a 02fc 	dmtc0	v0,c0_entryhi
[ 0-9a-f]+:	584b 02fc 	dmtc0	v0,c0_compare
[ 0-9a-f]+:	584c 02fc 	dmtc0	v0,c0_status
[ 0-9a-f]+:	584d 02fc 	dmtc0	v0,c0_cause
[ 0-9a-f]+:	584e 02fc 	dmtc0	v0,c0_epc
[ 0-9a-f]+:	584f 02fc 	dmtc0	v0,c0_prid
[ 0-9a-f]+:	5850 02fc 	dmtc0	v0,c0_config
[ 0-9a-f]+:	5851 02fc 	dmtc0	v0,c0_lladdr
[ 0-9a-f]+:	5852 02fc 	dmtc0	v0,c0_watchlo
[ 0-9a-f]+:	5853 02fc 	dmtc0	v0,c0_watchhi
[ 0-9a-f]+:	5854 02fc 	dmtc0	v0,c0_xcontext
[ 0-9a-f]+:	5855 02fc 	dmtc0	v0,\$21
[ 0-9a-f]+:	5856 02fc 	dmtc0	v0,\$22
[ 0-9a-f]+:	5857 02fc 	dmtc0	v0,c0_debug
[ 0-9a-f]+:	5858 02fc 	dmtc0	v0,c0_depc
[ 0-9a-f]+:	5859 02fc 	dmtc0	v0,c0_perfcnt
[ 0-9a-f]+:	585a 02fc 	dmtc0	v0,c0_errctl
[ 0-9a-f]+:	585b 02fc 	dmtc0	v0,c0_cacheerr
[ 0-9a-f]+:	585c 02fc 	dmtc0	v0,c0_taglo
[ 0-9a-f]+:	585d 02fc 	dmtc0	v0,c0_taghi
[ 0-9a-f]+:	585e 02fc 	dmtc0	v0,c0_errorepc
[ 0-9a-f]+:	585f 02fc 	dmtc0	v0,c0_desave
[ 0-9a-f]+:	5840 02fc 	dmtc0	v0,c0_index
[ 0-9a-f]+:	5840 0afc 	dmtc0	v0,c0_mvpcontrol
[ 0-9a-f]+:	5840 12fc 	dmtc0	v0,c0_mvpconf0
[ 0-9a-f]+:	5840 1afc 	dmtc0	v0,c0_mvpconf1
[ 0-9a-f]+:	5840 22fc 	dmtc0	v0,\$0,4
[ 0-9a-f]+:	5840 2afc 	dmtc0	v0,\$0,5
[ 0-9a-f]+:	5840 32fc 	dmtc0	v0,\$0,6
[ 0-9a-f]+:	5840 3afc 	dmtc0	v0,\$0,7
[ 0-9a-f]+:	5841 02fc 	dmtc0	v0,c0_random
[ 0-9a-f]+:	5841 0afc 	dmtc0	v0,c0_vpecontrol
[ 0-9a-f]+:	5841 12fc 	dmtc0	v0,c0_vpeconf0
[ 0-9a-f]+:	5841 1afc 	dmtc0	v0,c0_vpeconf1
[ 0-9a-f]+:	5841 22fc 	dmtc0	v0,c0_yqmask
[ 0-9a-f]+:	5841 2afc 	dmtc0	v0,c0_vpeschedule
[ 0-9a-f]+:	5841 32fc 	dmtc0	v0,c0_vpeschefback
[ 0-9a-f]+:	5841 3afc 	dmtc0	v0,\$1,7
[ 0-9a-f]+:	5842 02fc 	dmtc0	v0,c0_entrylo0
[ 0-9a-f]+:	5842 0afc 	dmtc0	v0,c0_tcstatus
[ 0-9a-f]+:	5842 12fc 	dmtc0	v0,c0_tcbind
[ 0-9a-f]+:	5842 1afc 	dmtc0	v0,c0_tcrestart
[ 0-9a-f]+:	5842 22fc 	dmtc0	v0,c0_tchalt
[ 0-9a-f]+:	5842 2afc 	dmtc0	v0,c0_tccontext
[ 0-9a-f]+:	5842 32fc 	dmtc0	v0,c0_tcschedule
[ 0-9a-f]+:	5842 3afc 	dmtc0	v0,c0_tcschefback
[ 0-9a-f]+:	54a0 243b 	dmfc1	a1,\$f0
[ 0-9a-f]+:	54a1 243b 	dmfc1	a1,\$f1
[ 0-9a-f]+:	54a2 243b 	dmfc1	a1,\$f2
[ 0-9a-f]+:	54a3 243b 	dmfc1	a1,\$f3
[ 0-9a-f]+:	54a4 243b 	dmfc1	a1,\$f4
[ 0-9a-f]+:	54a5 243b 	dmfc1	a1,\$f5
[ 0-9a-f]+:	54a6 243b 	dmfc1	a1,\$f6
[ 0-9a-f]+:	54a7 243b 	dmfc1	a1,\$f7
[ 0-9a-f]+:	54a8 243b 	dmfc1	a1,\$f8
[ 0-9a-f]+:	54a9 243b 	dmfc1	a1,\$f9
[ 0-9a-f]+:	54aa 243b 	dmfc1	a1,\$f10
[ 0-9a-f]+:	54ab 243b 	dmfc1	a1,\$f11
[ 0-9a-f]+:	54ac 243b 	dmfc1	a1,\$f12
[ 0-9a-f]+:	54ad 243b 	dmfc1	a1,\$f13
[ 0-9a-f]+:	54ae 243b 	dmfc1	a1,\$f14
[ 0-9a-f]+:	54af 243b 	dmfc1	a1,\$f15
[ 0-9a-f]+:	54b0 243b 	dmfc1	a1,\$f16
[ 0-9a-f]+:	54b1 243b 	dmfc1	a1,\$f17
[ 0-9a-f]+:	54b2 243b 	dmfc1	a1,\$f18
[ 0-9a-f]+:	54b3 243b 	dmfc1	a1,\$f19
[ 0-9a-f]+:	54b4 243b 	dmfc1	a1,\$f20
[ 0-9a-f]+:	54b5 243b 	dmfc1	a1,\$f21
[ 0-9a-f]+:	54b6 243b 	dmfc1	a1,\$f22
[ 0-9a-f]+:	54b7 243b 	dmfc1	a1,\$f23
[ 0-9a-f]+:	54b8 243b 	dmfc1	a1,\$f24
[ 0-9a-f]+:	54b9 243b 	dmfc1	a1,\$f25
[ 0-9a-f]+:	54ba 243b 	dmfc1	a1,\$f26
[ 0-9a-f]+:	54bb 243b 	dmfc1	a1,\$f27
[ 0-9a-f]+:	54bc 243b 	dmfc1	a1,\$f28
[ 0-9a-f]+:	54bd 243b 	dmfc1	a1,\$f29
[ 0-9a-f]+:	54be 243b 	dmfc1	a1,\$f30
[ 0-9a-f]+:	54bf 243b 	dmfc1	a1,\$f31
[ 0-9a-f]+:	54a0 243b 	dmfc1	a1,\$f0
[ 0-9a-f]+:	54a1 243b 	dmfc1	a1,\$f1
[ 0-9a-f]+:	54a2 243b 	dmfc1	a1,\$f2
[ 0-9a-f]+:	54a3 243b 	dmfc1	a1,\$f3
[ 0-9a-f]+:	54a4 243b 	dmfc1	a1,\$f4
[ 0-9a-f]+:	54a5 243b 	dmfc1	a1,\$f5
[ 0-9a-f]+:	54a6 243b 	dmfc1	a1,\$f6
[ 0-9a-f]+:	54a7 243b 	dmfc1	a1,\$f7
[ 0-9a-f]+:	54a8 243b 	dmfc1	a1,\$f8
[ 0-9a-f]+:	54a9 243b 	dmfc1	a1,\$f9
[ 0-9a-f]+:	54aa 243b 	dmfc1	a1,\$f10
[ 0-9a-f]+:	54ab 243b 	dmfc1	a1,\$f11
[ 0-9a-f]+:	54ac 243b 	dmfc1	a1,\$f12
[ 0-9a-f]+:	54ad 243b 	dmfc1	a1,\$f13
[ 0-9a-f]+:	54ae 243b 	dmfc1	a1,\$f14
[ 0-9a-f]+:	54af 243b 	dmfc1	a1,\$f15
[ 0-9a-f]+:	54b0 243b 	dmfc1	a1,\$f16
[ 0-9a-f]+:	54b1 243b 	dmfc1	a1,\$f17
[ 0-9a-f]+:	54b2 243b 	dmfc1	a1,\$f18
[ 0-9a-f]+:	54b3 243b 	dmfc1	a1,\$f19
[ 0-9a-f]+:	54b4 243b 	dmfc1	a1,\$f20
[ 0-9a-f]+:	54b5 243b 	dmfc1	a1,\$f21
[ 0-9a-f]+:	54b6 243b 	dmfc1	a1,\$f22
[ 0-9a-f]+:	54b7 243b 	dmfc1	a1,\$f23
[ 0-9a-f]+:	54b8 243b 	dmfc1	a1,\$f24
[ 0-9a-f]+:	54b9 243b 	dmfc1	a1,\$f25
[ 0-9a-f]+:	54ba 243b 	dmfc1	a1,\$f26
[ 0-9a-f]+:	54bb 243b 	dmfc1	a1,\$f27
[ 0-9a-f]+:	54bc 243b 	dmfc1	a1,\$f28
[ 0-9a-f]+:	54bd 243b 	dmfc1	a1,\$f29
[ 0-9a-f]+:	54be 243b 	dmfc1	a1,\$f30
[ 0-9a-f]+:	54bf 243b 	dmfc1	a1,\$f31
[ 0-9a-f]+:	54a0 2c3b 	dmtc1	a1,c1_fir
[ 0-9a-f]+:	54a1 2c3b 	dmtc1	a1,c1_ufr
[ 0-9a-f]+:	54a2 2c3b 	dmtc1	a1,\$2
[ 0-9a-f]+:	54a3 2c3b 	dmtc1	a1,\$3
[ 0-9a-f]+:	54a4 2c3b 	dmtc1	a1,c1_unfr
[ 0-9a-f]+:	54a5 2c3b 	dmtc1	a1,\$5
[ 0-9a-f]+:	54a6 2c3b 	dmtc1	a1,\$6
[ 0-9a-f]+:	54a7 2c3b 	dmtc1	a1,\$7
[ 0-9a-f]+:	54a8 2c3b 	dmtc1	a1,\$8
[ 0-9a-f]+:	54a9 2c3b 	dmtc1	a1,\$9
[ 0-9a-f]+:	54aa 2c3b 	dmtc1	a1,\$10
[ 0-9a-f]+:	54ab 2c3b 	dmtc1	a1,\$11
[ 0-9a-f]+:	54ac 2c3b 	dmtc1	a1,\$12
[ 0-9a-f]+:	54ad 2c3b 	dmtc1	a1,\$13
[ 0-9a-f]+:	54ae 2c3b 	dmtc1	a1,\$14
[ 0-9a-f]+:	54af 2c3b 	dmtc1	a1,\$15
[ 0-9a-f]+:	54b0 2c3b 	dmtc1	a1,\$16
[ 0-9a-f]+:	54b1 2c3b 	dmtc1	a1,\$17
[ 0-9a-f]+:	54b2 2c3b 	dmtc1	a1,\$18
[ 0-9a-f]+:	54b3 2c3b 	dmtc1	a1,\$19
[ 0-9a-f]+:	54b4 2c3b 	dmtc1	a1,\$20
[ 0-9a-f]+:	54b5 2c3b 	dmtc1	a1,\$21
[ 0-9a-f]+:	54b6 2c3b 	dmtc1	a1,\$22
[ 0-9a-f]+:	54b7 2c3b 	dmtc1	a1,\$23
[ 0-9a-f]+:	54b8 2c3b 	dmtc1	a1,\$24
[ 0-9a-f]+:	54b9 2c3b 	dmtc1	a1,c1_fccr
[ 0-9a-f]+:	54ba 2c3b 	dmtc1	a1,c1_fexr
[ 0-9a-f]+:	54bb 2c3b 	dmtc1	a1,\$27
[ 0-9a-f]+:	54bc 2c3b 	dmtc1	a1,c1_fenr
[ 0-9a-f]+:	54bd 2c3b 	dmtc1	a1,\$29
[ 0-9a-f]+:	54be 2c3b 	dmtc1	a1,\$30
[ 0-9a-f]+:	54bf 2c3b 	dmtc1	a1,c1_fcsr
[ 0-9a-f]+:	54a0 2c3b 	dmtc1	a1,c1_fir
[ 0-9a-f]+:	54a1 2c3b 	dmtc1	a1,c1_ufr
[ 0-9a-f]+:	54a2 2c3b 	dmtc1	a1,\$2
[ 0-9a-f]+:	54a3 2c3b 	dmtc1	a1,\$3
[ 0-9a-f]+:	54a4 2c3b 	dmtc1	a1,c1_unfr
[ 0-9a-f]+:	54a5 2c3b 	dmtc1	a1,\$5
[ 0-9a-f]+:	54a6 2c3b 	dmtc1	a1,\$6
[ 0-9a-f]+:	54a7 2c3b 	dmtc1	a1,\$7
[ 0-9a-f]+:	54a8 2c3b 	dmtc1	a1,\$8
[ 0-9a-f]+:	54a9 2c3b 	dmtc1	a1,\$9
[ 0-9a-f]+:	54aa 2c3b 	dmtc1	a1,\$10
[ 0-9a-f]+:	54ab 2c3b 	dmtc1	a1,\$11
[ 0-9a-f]+:	54ac 2c3b 	dmtc1	a1,\$12
[ 0-9a-f]+:	54ad 2c3b 	dmtc1	a1,\$13
[ 0-9a-f]+:	54ae 2c3b 	dmtc1	a1,\$14
[ 0-9a-f]+:	54af 2c3b 	dmtc1	a1,\$15
[ 0-9a-f]+:	54b0 2c3b 	dmtc1	a1,\$16
[ 0-9a-f]+:	54b1 2c3b 	dmtc1	a1,\$17
[ 0-9a-f]+:	54b2 2c3b 	dmtc1	a1,\$18
[ 0-9a-f]+:	54b3 2c3b 	dmtc1	a1,\$19
[ 0-9a-f]+:	54b4 2c3b 	dmtc1	a1,\$20
[ 0-9a-f]+:	54b5 2c3b 	dmtc1	a1,\$21
[ 0-9a-f]+:	54b6 2c3b 	dmtc1	a1,\$22
[ 0-9a-f]+:	54b7 2c3b 	dmtc1	a1,\$23
[ 0-9a-f]+:	54b8 2c3b 	dmtc1	a1,\$24
[ 0-9a-f]+:	54b9 2c3b 	dmtc1	a1,c1_fccr
[ 0-9a-f]+:	54ba 2c3b 	dmtc1	a1,c1_fexr
[ 0-9a-f]+:	54bb 2c3b 	dmtc1	a1,\$27
[ 0-9a-f]+:	54bc 2c3b 	dmtc1	a1,c1_fenr
[ 0-9a-f]+:	54bd 2c3b 	dmtc1	a1,\$29
[ 0-9a-f]+:	54be 2c3b 	dmtc1	a1,\$30
[ 0-9a-f]+:	54bf 2c3b 	dmtc1	a1,c1_fcsr
[ 0-9a-f]+:	0040 6d3c 	dmfc2	v0,\$0
[ 0-9a-f]+:	0041 6d3c 	dmfc2	v0,\$1
[ 0-9a-f]+:	0042 6d3c 	dmfc2	v0,\$2
[ 0-9a-f]+:	0043 6d3c 	dmfc2	v0,\$3
[ 0-9a-f]+:	0044 6d3c 	dmfc2	v0,\$4
[ 0-9a-f]+:	0045 6d3c 	dmfc2	v0,\$5
[ 0-9a-f]+:	0046 6d3c 	dmfc2	v0,\$6
[ 0-9a-f]+:	0047 6d3c 	dmfc2	v0,\$7
[ 0-9a-f]+:	0048 6d3c 	dmfc2	v0,\$8
[ 0-9a-f]+:	0049 6d3c 	dmfc2	v0,\$9
[ 0-9a-f]+:	004a 6d3c 	dmfc2	v0,\$10
[ 0-9a-f]+:	004b 6d3c 	dmfc2	v0,\$11
[ 0-9a-f]+:	004c 6d3c 	dmfc2	v0,\$12
[ 0-9a-f]+:	004d 6d3c 	dmfc2	v0,\$13
[ 0-9a-f]+:	004e 6d3c 	dmfc2	v0,\$14
[ 0-9a-f]+:	004f 6d3c 	dmfc2	v0,\$15
[ 0-9a-f]+:	0050 6d3c 	dmfc2	v0,\$16
[ 0-9a-f]+:	0051 6d3c 	dmfc2	v0,\$17
[ 0-9a-f]+:	0052 6d3c 	dmfc2	v0,\$18
[ 0-9a-f]+:	0053 6d3c 	dmfc2	v0,\$19
[ 0-9a-f]+:	0054 6d3c 	dmfc2	v0,\$20
[ 0-9a-f]+:	0055 6d3c 	dmfc2	v0,\$21
[ 0-9a-f]+:	0056 6d3c 	dmfc2	v0,\$22
[ 0-9a-f]+:	0057 6d3c 	dmfc2	v0,\$23
[ 0-9a-f]+:	0058 6d3c 	dmfc2	v0,\$24
[ 0-9a-f]+:	0059 6d3c 	dmfc2	v0,\$25
[ 0-9a-f]+:	005a 6d3c 	dmfc2	v0,\$26
[ 0-9a-f]+:	005b 6d3c 	dmfc2	v0,\$27
[ 0-9a-f]+:	005c 6d3c 	dmfc2	v0,\$28
[ 0-9a-f]+:	005d 6d3c 	dmfc2	v0,\$29
[ 0-9a-f]+:	005e 6d3c 	dmfc2	v0,\$30
[ 0-9a-f]+:	005f 6d3c 	dmfc2	v0,\$31
[ 0-9a-f]+:	0040 7d3c 	dmtc2	v0,\$0
[ 0-9a-f]+:	0041 7d3c 	dmtc2	v0,\$1
[ 0-9a-f]+:	0042 7d3c 	dmtc2	v0,\$2
[ 0-9a-f]+:	0043 7d3c 	dmtc2	v0,\$3
[ 0-9a-f]+:	0044 7d3c 	dmtc2	v0,\$4
[ 0-9a-f]+:	0045 7d3c 	dmtc2	v0,\$5
[ 0-9a-f]+:	0046 7d3c 	dmtc2	v0,\$6
[ 0-9a-f]+:	0047 7d3c 	dmtc2	v0,\$7
[ 0-9a-f]+:	0048 7d3c 	dmtc2	v0,\$8
[ 0-9a-f]+:	0049 7d3c 	dmtc2	v0,\$9
[ 0-9a-f]+:	004a 7d3c 	dmtc2	v0,\$10
[ 0-9a-f]+:	004b 7d3c 	dmtc2	v0,\$11
[ 0-9a-f]+:	004c 7d3c 	dmtc2	v0,\$12
[ 0-9a-f]+:	004d 7d3c 	dmtc2	v0,\$13
[ 0-9a-f]+:	004e 7d3c 	dmtc2	v0,\$14
[ 0-9a-f]+:	004f 7d3c 	dmtc2	v0,\$15
[ 0-9a-f]+:	0050 7d3c 	dmtc2	v0,\$16
[ 0-9a-f]+:	0051 7d3c 	dmtc2	v0,\$17
[ 0-9a-f]+:	0052 7d3c 	dmtc2	v0,\$18
[ 0-9a-f]+:	0053 7d3c 	dmtc2	v0,\$19
[ 0-9a-f]+:	0054 7d3c 	dmtc2	v0,\$20
[ 0-9a-f]+:	0055 7d3c 	dmtc2	v0,\$21
[ 0-9a-f]+:	0056 7d3c 	dmtc2	v0,\$22
[ 0-9a-f]+:	0057 7d3c 	dmtc2	v0,\$23
[ 0-9a-f]+:	0058 7d3c 	dmtc2	v0,\$24
[ 0-9a-f]+:	0059 7d3c 	dmtc2	v0,\$25
[ 0-9a-f]+:	005a 7d3c 	dmtc2	v0,\$26
[ 0-9a-f]+:	005b 7d3c 	dmtc2	v0,\$27
[ 0-9a-f]+:	005c 7d3c 	dmtc2	v0,\$28
[ 0-9a-f]+:	005d 7d3c 	dmtc2	v0,\$29
[ 0-9a-f]+:	005e 7d3c 	dmtc2	v0,\$30
[ 0-9a-f]+:	005f 7d3c 	dmtc2	v0,\$31
[ 0-9a-f]+:	5862 8b3c 	dmult	v0,v1
[ 0-9a-f]+:	5862 9b3c 	dmultu	v0,v1
[ 0-9a-f]+:	5883 9b3c 	dmultu	v1,a0
[ 0-9a-f]+:	4642      	mflo	v0
[ 0-9a-f]+:	41a1 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5678 	ori	at,at,0x5678
[ 0-9a-f]+:	5823 8b3c 	dmult	v1,at
[ 0-9a-f]+:	4642      	mflo	v0
[ 0-9a-f]+:	5883 8b3c 	dmult	v1,a0
[ 0-9a-f]+:	4642      	mflo	v0
[ 0-9a-f]+:	5842 f888 	dsra32	v0,v0,0x1f
[ 0-9a-f]+:	4601      	mfhi	at
[ 0-9a-f]+:	9422 0000 	beq	v0,at,[0-9a-f]+ <.*\+0x[0-9a-f]+>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.*
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	4686      	break	0x6
[ 0-9a-f]+:	4642      	mflo	v0
[ 0-9a-f]+:	3020 0004 	li	at,4
[ 0-9a-f]+:	5823 8b3c 	dmult	v1,at
[ 0-9a-f]+:	4642      	mflo	v0
[ 0-9a-f]+:	5842 f888 	dsra32	v0,v0,0x1f
[ 0-9a-f]+:	4601      	mfhi	at
[ 0-9a-f]+:	9422 0000 	beq	v0,at,[0-9a-f]+ <.*\+0x[0-9a-f]+>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.*
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	4686      	break	0x6
[ 0-9a-f]+:	4642      	mflo	v0
[ 0-9a-f]+:	5883 9b3c 	dmultu	v1,a0
[ 0-9a-f]+:	4601      	mfhi	at
[ 0-9a-f]+:	4642      	mflo	v0
[ 0-9a-f]+:	9401 0000 	beqz	at,[0-9a-f]+ <.*\+0x[0-9a-f]+>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.*
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	4686      	break	0x6
[ 0-9a-f]+:	3020 0004 	li	at,4
[ 0-9a-f]+:	5823 9b3c 	dmultu	v1,at
[ 0-9a-f]+:	4601      	mfhi	at
[ 0-9a-f]+:	4642      	mflo	v0
[ 0-9a-f]+:	9401 0000 	beqz	at,[0-9a-f]+ <.*\+0x[0-9a-f]+>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.*
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	4686      	break	0x6
[ 0-9a-f]+:	4687      	break	0x7
[ 0-9a-f]+:	0c60      	move	v1,zero
[ 0-9a-f]+:	0c60      	move	v1,zero
[ 0-9a-f]+:	3020 0002 	li	at,2
[ 0-9a-f]+:	5824 ab3c 	ddiv	zero,a0,at
[ 0-9a-f]+:	4603      	mfhi	v1
[ 0-9a-f]+:	5862 ab3c 	ddiv	zero,v0,v1
[ 0-9a-f]+:	5bfe ab3c 	ddiv	zero,s8,ra
[ 0-9a-f]+:	b403 0000 	bnez	v1,[0-9a-f]+ <.*\+0x[0-9a-f]+>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.*
[ 0-9a-f]+:	5860 ab3c 	ddiv	zero,zero,v1
[ 0-9a-f]+:	4687      	break	0x7
[ 0-9a-f]+:	3020 ffff 	li	at,-1
[ 0-9a-f]+:	b423 0000 	bne	v1,at,[0-9a-f]+ <.*\+0x[0-9a-f]+>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.*
[ 0-9a-f]+:	3020 0001 	li	at,1
[ 0-9a-f]+:	5821 f808 	dsll32	at,at,0x1f
[ 0-9a-f]+:	b420 0000 	bne	zero,at,[0-9a-f]+ <.*\+0x[0-9a-f]+>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.*
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	4686      	break	0x6
[ 0-9a-f]+:	4600      	mfhi	zero
[ 0-9a-f]+:	b41f 0000 	bnez	ra,[0-9a-f]+ <.*\+0x[0-9a-f]+>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.*
[ 0-9a-f]+:	5be0 ab3c 	ddiv	zero,zero,ra
[ 0-9a-f]+:	4687      	break	0x7
[ 0-9a-f]+:	3020 ffff 	li	at,-1
[ 0-9a-f]+:	b43f 0000 	bne	ra,at,[0-9a-f]+ <.*\+0x[0-9a-f]+>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.*
[ 0-9a-f]+:	3020 0001 	li	at,1
[ 0-9a-f]+:	5821 f808 	dsll32	at,at,0x1f
[ 0-9a-f]+:	b420 0000 	bne	zero,at,[0-9a-f]+ <.*\+0x[0-9a-f]+>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.*
[ 0-9a-f]+:	0c00      	nop
[ 0-9a-f]+:	4686      	break	0x6
[ 0-9a-f]+:	4600      	mfhi	zero
[ 0-9a-f]+:	4687      	break	0x7
[ 0-9a-f]+:	0c60      	move	v1,zero
[ 0-9a-f]+:	0c60      	move	v1,zero
[ 0-9a-f]+:	3020 0002 	li	at,2
[ 0-9a-f]+:	5824 ab3c 	ddiv	zero,a0,at
[ 0-9a-f]+:	4603      	mfhi	v1
[ 0-9a-f]+:	5862 bb3c 	ddivu	zero,v0,v1
[ 0-9a-f]+:	5bfe bb3c 	ddivu	zero,s8,ra
[ 0-9a-f]+:	b403 0000 	bnez	v1,[0-9a-f]+ <.*\+0x[0-9a-f]+>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.*
[ 0-9a-f]+:	5860 bb3c 	ddivu	zero,zero,v1
[ 0-9a-f]+:	4687      	break	0x7
[ 0-9a-f]+:	4600      	mfhi	zero
[ 0-9a-f]+:	b41f 0000 	bnez	ra,[0-9a-f]+ <.*\+0x[0-9a-f]+>
[ 	]*[0-9a-f]+: R_MICROMIPS_PC16_S1	.*
[ 0-9a-f]+:	5be0 bb3c 	ddivu	zero,zero,ra
[ 0-9a-f]+:	4687      	break	0x7
[ 0-9a-f]+:	4600      	mfhi	zero
[ 0-9a-f]+:	4687      	break	0x7
[ 0-9a-f]+:	0c60      	move	v1,zero
[ 0-9a-f]+:	3020 ffff 	li	at,-1
[ 0-9a-f]+:	5824 bb3c 	ddivu	zero,a0,at
[ 0-9a-f]+:	4603      	mfhi	v1
[ 0-9a-f]+:	3020 0002 	li	at,2
[ 0-9a-f]+:	5824 bb3c 	ddivu	zero,a0,at
[ 0-9a-f]+:	4603      	mfhi	v1
[ 0-9a-f]+:	5880 11d0 	dnegu	v0,a0
[ 0-9a-f]+:	5862 10d0 	drorv	v0,v1,v0
[ 0-9a-f]+:	5880 09d0 	dnegu	at,a0
[ 0-9a-f]+:	5841 10d0 	drorv	v0,v0,at
[ 0-9a-f]+:	5843 e0c8 	dror32	v0,v1,0x1c
[ 0-9a-f]+:	5864 10d0 	drorv	v0,v1,a0
[ 0-9a-f]+:	5843 20c0 	dror	v0,v1,0x4
[ 0-9a-f]+:	5843 20c8 	dror32	v0,v1,0x4
[ 0-9a-f]+:	5864 10d0 	drorv	v0,v1,a0
[ 0-9a-f]+:	5843 20c8 	dror32	v0,v1,0x4
[ 0-9a-f]+:	5880 11d0 	dnegu	v0,a0
[ 0-9a-f]+:	5862 10d0 	drorv	v0,v1,v0
[ 0-9a-f]+:	5880 09d0 	dnegu	at,a0
[ 0-9a-f]+:	5841 10d0 	drorv	v0,v0,at
[ 0-9a-f]+:	5843 e0c8 	dror32	v0,v1,0x1c
[ 0-9a-f]+:	5864 10d0 	drorv	v0,v1,a0
[ 0-9a-f]+:	5843 20c0 	dror	v0,v1,0x4
[ 0-9a-f]+:	5843 20c8 	dror32	v0,v1,0x4
[ 0-9a-f]+:	5864 10d0 	drorv	v0,v1,a0
[ 0-9a-f]+:	5843 20c8 	dror32	v0,v1,0x4
[ 0-9a-f]+:	5843 7b3c 	dsbh	v0,v1
[ 0-9a-f]+:	5842 7b3c 	dsbh	v0,v0
[ 0-9a-f]+:	5842 7b3c 	dsbh	v0,v0
[ 0-9a-f]+:	5843 fb3c 	dshd	v0,v1
[ 0-9a-f]+:	5842 fb3c 	dshd	v0,v0
[ 0-9a-f]+:	5842 fb3c 	dshd	v0,v0
[ 0-9a-f]+:	5864 1010 	dsllv	v0,v1,a0
[ 0-9a-f]+:	5843 f808 	dsll32	v0,v1,0x1f
[ 0-9a-f]+:	5864 1010 	dsllv	v0,v1,a0
[ 0-9a-f]+:	5843 f808 	dsll32	v0,v1,0x1f
[ 0-9a-f]+:	5843 f800 	dsll	v0,v1,0x1f
[ 0-9a-f]+:	5864 1090 	dsrav	v0,v1,a0
[ 0-9a-f]+:	5843 2088 	dsra32	v0,v1,0x4
[ 0-9a-f]+:	5864 1090 	dsrav	v0,v1,a0
[ 0-9a-f]+:	5843 2088 	dsra32	v0,v1,0x4
[ 0-9a-f]+:	5843 2080 	dsra	v0,v1,0x4
[ 0-9a-f]+:	5864 1050 	dsrlv	v0,v1,a0
[ 0-9a-f]+:	5843 f848 	dsrl32	v0,v1,0x1f
[ 0-9a-f]+:	5864 1050 	dsrlv	v0,v1,a0
[ 0-9a-f]+:	5843 2048 	dsrl32	v0,v1,0x4
[ 0-9a-f]+:	5843 2040 	dsrl	v0,v1,0x4
[ 0-9a-f]+:	5883 1190 	dsub	v0,v1,a0
[ 0-9a-f]+:	5bfe e990 	dsub	sp,s8,ra
[ 0-9a-f]+:	5862 1190 	dsub	v0,v0,v1
[ 0-9a-f]+:	5862 1190 	dsub	v0,v0,v1
[ 0-9a-f]+:	5883 11d0 	dsubu	v0,v1,a0
[ 0-9a-f]+:	5bfe e9d0 	dsubu	sp,s8,ra
[ 0-9a-f]+:	5862 11d0 	dsubu	v0,v0,v1
[ 0-9a-f]+:	5862 11d0 	dsubu	v0,v0,v1
[ 0-9a-f]+:	5c43 edcc 	daddiu	v0,v1,-4660
[ 0-9a-f]+:	41a1 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5678 	ori	at,at,0x5678
[ 0-9a-f]+:	5823 11d0 	dsubu	v0,v1,at
[ 0-9a-f]+:	5843 001c 	daddi	v0,v1,0
[ 0-9a-f]+:	5843 ffdc 	daddi	v0,v1,-1
[ 0-9a-f]+:	5843 801c 	daddi	v0,v1,-512
[ 0-9a-f]+:	5843 7fdc 	daddi	v0,v1,511
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	5823 1190 	dsub	v0,v1,at
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	5823 1190 	dsub	v0,v1,at
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	5823 1190 	dsub	v0,v1,at
[ 0-9a-f]+:	41a1 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5678 	ori	at,at,0x5678
[ 0-9a-f]+:	5823 1190 	dsub	v0,v1,at
[ 0-9a-f]+:	41a1 8888 	lui	at,0x8888
[ 0-9a-f]+:	5021 1111 	ori	at,at,0x1111
[ 0-9a-f]+:	5821 8000 	dsll	at,at,0x10
[ 0-9a-f]+:	5021 1234 	ori	at,at,0x1234
[ 0-9a-f]+:	5821 8000 	dsll	at,at,0x10
[ 0-9a-f]+:	5021 5678 	ori	at,at,0x5678
[ 0-9a-f]+:	5823 1190 	dsub	v0,v1,at
[ 0-9a-f]+:	dc40 0000 	ld	v0,0\(zero\)
[ 0-9a-f]+:	dc40 0004 	ld	v0,4\(zero\)
[ 0-9a-f]+:	dc40 0000 	ld	v0,0\(zero\)
[ 0-9a-f]+:	dc40 0000 	ld	v0,0\(zero\)
[ 0-9a-f]+:	dc40 0004 	ld	v0,4\(zero\)
[ 0-9a-f]+:	dc43 0004 	ld	v0,4\(v1\)
[ 0-9a-f]+:	dc43 8000 	ld	v0,-32768\(v1\)
[ 0-9a-f]+:	dc43 7fff 	ld	v0,32767\(v1\)
[ 0-9a-f]+:	6040 4000 	ldl	v0,0\(zero\)
[ 0-9a-f]+:	6040 4004 	ldl	v0,4\(zero\)
[ 0-9a-f]+:	6040 4000 	ldl	v0,0\(zero\)
[ 0-9a-f]+:	6040 4000 	ldl	v0,0\(zero\)
[ 0-9a-f]+:	6040 4004 	ldl	v0,4\(zero\)
[ 0-9a-f]+:	6043 4004 	ldl	v0,4\(v1\)
[ 0-9a-f]+:	6043 4e00 	ldl	v0,-512\(v1\)
[ 0-9a-f]+:	6043 41ff 	ldl	v0,511\(v1\)
[ 0-9a-f]+:	3023 8000 	addiu	at,v1,-32768
[ 0-9a-f]+:	6041 4000 	ldl	v0,0\(at\)
[ 0-9a-f]+:	41a1 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5000 	ori	at,at,0x5000
[ 0-9a-f]+:	0061 0950 	addu	at,at,v1
[ 0-9a-f]+:	6041 4678 	ldl	v0,1656\(at\)
[ 0-9a-f]+:	6040 5000 	ldr	v0,0\(zero\)
[ 0-9a-f]+:	6040 5004 	ldr	v0,4\(zero\)
[ 0-9a-f]+:	6040 5000 	ldr	v0,0\(zero\)
[ 0-9a-f]+:	6040 5000 	ldr	v0,0\(zero\)
[ 0-9a-f]+:	6040 5004 	ldr	v0,4\(zero\)
[ 0-9a-f]+:	6043 5004 	ldr	v0,4\(v1\)
[ 0-9a-f]+:	6043 5e00 	ldr	v0,-512\(v1\)
[ 0-9a-f]+:	6043 51ff 	ldr	v0,511\(v1\)
[ 0-9a-f]+:	3023 8000 	addiu	at,v1,-32768
[ 0-9a-f]+:	6041 5000 	ldr	v0,0\(at\)
[ 0-9a-f]+:	41a1 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5000 	ori	at,at,0x5000
[ 0-9a-f]+:	0061 0950 	addu	at,at,v1
[ 0-9a-f]+:	6041 5678 	ldr	v0,1656\(at\)
[ 0-9a-f]+:	6040 7000 	lld	v0,0\(zero\)
[ 0-9a-f]+:	6040 7004 	lld	v0,4\(zero\)
[ 0-9a-f]+:	6040 7000 	lld	v0,0\(zero\)
[ 0-9a-f]+:	6040 7000 	lld	v0,0\(zero\)
[ 0-9a-f]+:	6040 7004 	lld	v0,4\(zero\)
[ 0-9a-f]+:	6043 7004 	lld	v0,4\(v1\)
[ 0-9a-f]+:	6043 7e00 	lld	v0,-512\(v1\)
[ 0-9a-f]+:	6043 71ff 	lld	v0,511\(v1\)
[ 0-9a-f]+:	3043 8000 	addiu	v0,v1,-32768
[ 0-9a-f]+:	6042 7000 	lld	v0,0\(v0\)
[ 0-9a-f]+:	41a2 1234 	lui	v0,0x1234
[ 0-9a-f]+:	5042 5000 	ori	v0,v0,0x5000
[ 0-9a-f]+:	0062 1150 	addu	v0,v0,v1
[ 0-9a-f]+:	6042 7678 	lld	v0,1656\(v0\)
[ 0-9a-f]+:	6040 e000 	lwu	v0,0\(zero\)
[ 0-9a-f]+:	6040 e004 	lwu	v0,4\(zero\)
[ 0-9a-f]+:	6040 e000 	lwu	v0,0\(zero\)
[ 0-9a-f]+:	6040 e000 	lwu	v0,0\(zero\)
[ 0-9a-f]+:	6040 e004 	lwu	v0,4\(zero\)
[ 0-9a-f]+:	6043 e004 	lwu	v0,4\(v1\)
[ 0-9a-f]+:	6043 ee00 	lwu	v0,-512\(v1\)
[ 0-9a-f]+:	6043 e1ff 	lwu	v0,511\(v1\)
[ 0-9a-f]+:	3043 8000 	addiu	v0,v1,-32768
[ 0-9a-f]+:	6042 e000 	lwu	v0,0\(v0\)
[ 0-9a-f]+:	41a2 1234 	lui	v0,0x1234
[ 0-9a-f]+:	5042 5000 	ori	v0,v0,0x5000
[ 0-9a-f]+:	0062 1150 	addu	v0,v0,v1
[ 0-9a-f]+:	6042 e678 	lwu	v0,1656\(v0\)
[ 0-9a-f]+:	6040 f000 	scd	v0,0\(zero\)
[ 0-9a-f]+:	6040 f004 	scd	v0,4\(zero\)
[ 0-9a-f]+:	6040 f000 	scd	v0,0\(zero\)
[ 0-9a-f]+:	6040 f000 	scd	v0,0\(zero\)
[ 0-9a-f]+:	6040 f004 	scd	v0,4\(zero\)
[ 0-9a-f]+:	6043 f004 	scd	v0,4\(v1\)
[ 0-9a-f]+:	6043 fe00 	scd	v0,-512\(v1\)
[ 0-9a-f]+:	6043 f1ff 	scd	v0,511\(v1\)
[ 0-9a-f]+:	3023 8000 	addiu	at,v1,-32768
[ 0-9a-f]+:	6041 f000 	scd	v0,0\(at\)
[ 0-9a-f]+:	41a1 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5000 	ori	at,at,0x5000
[ 0-9a-f]+:	0061 0950 	addu	at,at,v1
[ 0-9a-f]+:	6041 f678 	scd	v0,1656\(at\)
[ 0-9a-f]+:	d840 0000 	sd	v0,0\(zero\)
[ 0-9a-f]+:	d840 0004 	sd	v0,4\(zero\)
[ 0-9a-f]+:	d840 0000 	sd	v0,0\(zero\)
[ 0-9a-f]+:	d840 0000 	sd	v0,0\(zero\)
[ 0-9a-f]+:	d840 0004 	sd	v0,4\(zero\)
[ 0-9a-f]+:	d843 0004 	sd	v0,4\(v1\)
[ 0-9a-f]+:	d843 8000 	sd	v0,-32768\(v1\)
[ 0-9a-f]+:	d843 7fff 	sd	v0,32767\(v1\)
[ 0-9a-f]+:	6040 c000 	sdl	v0,0\(zero\)
[ 0-9a-f]+:	6040 c004 	sdl	v0,4\(zero\)
[ 0-9a-f]+:	6040 c000 	sdl	v0,0\(zero\)
[ 0-9a-f]+:	6040 c000 	sdl	v0,0\(zero\)
[ 0-9a-f]+:	6040 c004 	sdl	v0,4\(zero\)
[ 0-9a-f]+:	6043 c004 	sdl	v0,4\(v1\)
[ 0-9a-f]+:	3023 8000 	addiu	at,v1,-32768
[ 0-9a-f]+:	6041 c000 	sdl	v0,0\(at\)
[ 0-9a-f]+:	3023 7fff 	addiu	at,v1,32767
[ 0-9a-f]+:	6041 c000 	sdl	v0,0\(at\)
[ 0-9a-f]+:	41a1 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5000 	ori	at,at,0x5000
[ 0-9a-f]+:	0061 0950 	addu	at,at,v1
[ 0-9a-f]+:	6041 c678 	sdl	v0,1656\(at\)
[ 0-9a-f]+:	6040 d000 	sdr	v0,0\(zero\)
[ 0-9a-f]+:	6040 d004 	sdr	v0,4\(zero\)
[ 0-9a-f]+:	6040 d000 	sdr	v0,0\(zero\)
[ 0-9a-f]+:	6040 d000 	sdr	v0,0\(zero\)
[ 0-9a-f]+:	6040 d004 	sdr	v0,4\(zero\)
[ 0-9a-f]+:	6043 d004 	sdr	v0,4\(v1\)
[ 0-9a-f]+:	3023 8000 	addiu	at,v1,-32768
[ 0-9a-f]+:	6041 d000 	sdr	v0,0\(at\)
[ 0-9a-f]+:	3023 7fff 	addiu	at,v1,32767
[ 0-9a-f]+:	6041 d000 	sdr	v0,0\(at\)
[ 0-9a-f]+:	41a1 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5000 	ori	at,at,0x5000
[ 0-9a-f]+:	0061 0950 	addu	at,at,v1
[ 0-9a-f]+:	6041 d678 	sdr	v0,1656\(at\)
[ 0-9a-f]+:	2020 7000 	ldm	s0,0\(zero\)
[ 0-9a-f]+:	2020 7004 	ldm	s0,4\(zero\)
[ 0-9a-f]+:	2025 7000 	ldm	s0,0\(a1\)
[ 0-9a-f]+:	2025 77ff 	ldm	s0,2047\(a1\)
[ 0-9a-f]+:	2045 77ff 	ldm	s0-s1,2047\(a1\)
[ 0-9a-f]+:	2065 77ff 	ldm	s0-s2,2047\(a1\)
[ 0-9a-f]+:	2085 77ff 	ldm	s0-s3,2047\(a1\)
[ 0-9a-f]+:	20a5 77ff 	ldm	s0-s4,2047\(a1\)
[ 0-9a-f]+:	20c5 77ff 	ldm	s0-s5,2047\(a1\)
[ 0-9a-f]+:	20e5 77ff 	ldm	s0-s6,2047\(a1\)
[ 0-9a-f]+:	2105 77ff 	ldm	s0-s7,2047\(a1\)
[ 0-9a-f]+:	2125 77ff 	ldm	s0-s7,s8,2047\(a1\)
[ 0-9a-f]+:	2205 77ff 	ldm	ra,2047\(a1\)
[ 0-9a-f]+:	2225 7000 	ldm	s0,ra,0\(a1\)
[ 0-9a-f]+:	2245 7000 	ldm	s0-s1,ra,0\(a1\)
[ 0-9a-f]+:	2265 7000 	ldm	s0-s2,ra,0\(a1\)
[ 0-9a-f]+:	2285 7000 	ldm	s0-s3,ra,0\(a1\)
[ 0-9a-f]+:	22a5 7000 	ldm	s0-s4,ra,0\(a1\)
[ 0-9a-f]+:	22c5 7000 	ldm	s0-s5,ra,0\(a1\)
[ 0-9a-f]+:	22e5 7000 	ldm	s0-s6,ra,0\(a1\)
[ 0-9a-f]+:	2305 7000 	ldm	s0-s7,ra,0\(a1\)
[ 0-9a-f]+:	2325 7000 	ldm	s0-s7,s8,ra,0\(a1\)
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	2021 7000 	ldm	s0,0\(at\)
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	2021 7000 	ldm	s0,0\(at\)
[ 0-9a-f]+:	2020 7000 	ldm	s0,0\(zero\)
[ 0-9a-f]+:	41a1 0001 	lui	at,0x1
[ 0-9a-f]+:	2021 7fff 	ldm	s0,-1\(at\)
[ 0-9a-f]+:	303d 8000 	addiu	at,sp,-32768
[ 0-9a-f]+:	2021 7000 	ldm	s0,0\(at\)
[ 0-9a-f]+:	303d 7fff 	addiu	at,sp,32767
[ 0-9a-f]+:	2021 7000 	ldm	s0,0\(at\)
[ 0-9a-f]+:	203d 7000 	ldm	s0,0\(sp\)
[ 0-9a-f]+:	41a1 0001 	lui	at,0x1
[ 0-9a-f]+:	03a1 0950 	addu	at,at,sp
[ 0-9a-f]+:	2021 7fff 	ldm	s0,-1\(at\)
[ 0-9a-f]+:	41a1 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5000 	ori	at,at,0x5000
[ 0-9a-f]+:	03a1 0950 	addu	at,at,sp
[ 0-9a-f]+:	2021 7678 	ldm	s0,1656\(at\)
[ 0-9a-f]+:	2040 4000 	ldp	v0,0\(zero\)
[ 0-9a-f]+:	2040 4004 	ldp	v0,4\(zero\)
[ 0-9a-f]+:	205d 4000 	ldp	v0,0\(sp\)
[ 0-9a-f]+:	205d 4000 	ldp	v0,0\(sp\)
[ 0-9a-f]+:	2043 4800 	ldp	v0,-2048\(v1\)
[ 0-9a-f]+:	2043 47ff 	ldp	v0,2047\(v1\)
[ 0-9a-f]+:	3023 8000 	addiu	at,v1,-32768
[ 0-9a-f]+:	2041 4000 	ldp	v0,0\(at\)
[ 0-9a-f]+:	3023 7fff 	addiu	at,v1,32767
[ 0-9a-f]+:	2041 4000 	ldp	v0,0\(at\)
[ 0-9a-f]+:	2043 4000 	ldp	v0,0\(v1\)
[ 0-9a-f]+:	41a1 0001 	lui	at,0x1
[ 0-9a-f]+:	0061 0950 	addu	at,at,v1
[ 0-9a-f]+:	2041 4fff 	ldp	v0,-1\(at\)
[ 0-9a-f]+:	3060 8000 	li	v1,-32768
[ 0-9a-f]+:	2043 4000 	ldp	v0,0\(v1\)
[ 0-9a-f]+:	3060 7fff 	li	v1,32767
[ 0-9a-f]+:	2043 4000 	ldp	v0,0\(v1\)
[ 0-9a-f]+:	41a3 0001 	lui	v1,0x1
[ 0-9a-f]+:	2043 4fff 	ldp	v0,-1\(v1\)
[ 0-9a-f]+:	41a3 1234 	lui	v1,0x1234
[ 0-9a-f]+:	5063 5000 	ori	v1,v1,0x5000
[ 0-9a-f]+:	2043 4678 	ldp	v0,1656\(v1\)
[ 0-9a-f]+:	2020 f000 	sdm	s0,0\(zero\)
[ 0-9a-f]+:	2020 f004 	sdm	s0,4\(zero\)
[ 0-9a-f]+:	2025 f000 	sdm	s0,0\(a1\)
[ 0-9a-f]+:	2025 f7ff 	sdm	s0,2047\(a1\)
[ 0-9a-f]+:	2045 f7ff 	sdm	s0-s1,2047\(a1\)
[ 0-9a-f]+:	2065 f7ff 	sdm	s0-s2,2047\(a1\)
[ 0-9a-f]+:	2085 f7ff 	sdm	s0-s3,2047\(a1\)
[ 0-9a-f]+:	20a5 f7ff 	sdm	s0-s4,2047\(a1\)
[ 0-9a-f]+:	20c5 f7ff 	sdm	s0-s5,2047\(a1\)
[ 0-9a-f]+:	20e5 f7ff 	sdm	s0-s6,2047\(a1\)
[ 0-9a-f]+:	2105 f7ff 	sdm	s0-s7,2047\(a1\)
[ 0-9a-f]+:	2125 f7ff 	sdm	s0-s7,s8,2047\(a1\)
[ 0-9a-f]+:	2205 f7ff 	sdm	ra,2047\(a1\)
[ 0-9a-f]+:	2225 f000 	sdm	s0,ra,0\(a1\)
[ 0-9a-f]+:	2245 f000 	sdm	s0-s1,ra,0\(a1\)
[ 0-9a-f]+:	2265 f000 	sdm	s0-s2,ra,0\(a1\)
[ 0-9a-f]+:	2285 f000 	sdm	s0-s3,ra,0\(a1\)
[ 0-9a-f]+:	22a5 f000 	sdm	s0-s4,ra,0\(a1\)
[ 0-9a-f]+:	22c5 f000 	sdm	s0-s5,ra,0\(a1\)
[ 0-9a-f]+:	22e5 f000 	sdm	s0-s6,ra,0\(a1\)
[ 0-9a-f]+:	2305 f000 	sdm	s0-s7,ra,0\(a1\)
[ 0-9a-f]+:	2325 f000 	sdm	s0-s7,s8,ra,0\(a1\)
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	2021 f000 	sdm	s0,0\(at\)
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	2021 f000 	sdm	s0,0\(at\)
[ 0-9a-f]+:	2020 f000 	sdm	s0,0\(zero\)
[ 0-9a-f]+:	41a1 0001 	lui	at,0x1
[ 0-9a-f]+:	2021 ffff 	sdm	s0,-1\(at\)
[ 0-9a-f]+:	303d 8000 	addiu	at,sp,-32768
[ 0-9a-f]+:	2021 f000 	sdm	s0,0\(at\)
[ 0-9a-f]+:	303d 7fff 	addiu	at,sp,32767
[ 0-9a-f]+:	2021 f000 	sdm	s0,0\(at\)
[ 0-9a-f]+:	203d f000 	sdm	s0,0\(sp\)
[ 0-9a-f]+:	41a1 0001 	lui	at,0x1
[ 0-9a-f]+:	03a1 0950 	addu	at,at,sp
[ 0-9a-f]+:	2021 ffff 	sdm	s0,-1\(at\)
[ 0-9a-f]+:	41a1 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5000 	ori	at,at,0x5000
[ 0-9a-f]+:	03a1 0950 	addu	at,at,sp
[ 0-9a-f]+:	2021 f678 	sdm	s0,1656\(at\)
[ 0-9a-f]+:	2040 c000 	sdp	v0,0\(zero\)
[ 0-9a-f]+:	2040 c004 	sdp	v0,4\(zero\)
[ 0-9a-f]+:	205d c000 	sdp	v0,0\(sp\)
[ 0-9a-f]+:	205d c000 	sdp	v0,0\(sp\)
[ 0-9a-f]+:	2043 c800 	sdp	v0,-2048\(v1\)
[ 0-9a-f]+:	2043 c7ff 	sdp	v0,2047\(v1\)
[ 0-9a-f]+:	3023 8000 	addiu	at,v1,-32768
[ 0-9a-f]+:	2041 c000 	sdp	v0,0\(at\)
[ 0-9a-f]+:	3023 7fff 	addiu	at,v1,32767
[ 0-9a-f]+:	2041 c000 	sdp	v0,0\(at\)
[ 0-9a-f]+:	2043 c000 	sdp	v0,0\(v1\)
[ 0-9a-f]+:	41a1 0001 	lui	at,0x1
[ 0-9a-f]+:	0061 0950 	addu	at,at,v1
[ 0-9a-f]+:	2041 cfff 	sdp	v0,-1\(at\)
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	2041 c000 	sdp	v0,0\(at\)
[ 0-9a-f]+:	3020 7fff 	li	at,32767
[ 0-9a-f]+:	2041 c000 	sdp	v0,0\(at\)
[ 0-9a-f]+:	41a1 0001 	lui	at,0x1
[ 0-9a-f]+:	2041 cfff 	sdp	v0,-1\(at\)
[ 0-9a-f]+:	41a1 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5000 	ori	at,at,0x5000
[ 0-9a-f]+:	2041 c678 	sdp	v0,1656\(at\)
[ 0-9a-f]+:	6060 4000 	ldl	v1,0\(zero\)
[ 0-9a-f]+:	6060 5007 	ldr	v1,7\(zero\)
[ 0-9a-f]+:	6060 4000 	ldl	v1,0\(zero\)
[ 0-9a-f]+:	6060 5007 	ldr	v1,7\(zero\)
[ 0-9a-f]+:	6060 4004 	ldl	v1,4\(zero\)
[ 0-9a-f]+:	6060 500b 	ldr	v1,11\(zero\)
[ 0-9a-f]+:	6060 4004 	ldl	v1,4\(zero\)
[ 0-9a-f]+:	6060 500b 	ldr	v1,11\(zero\)
[ 0-9a-f]+:	3020 07ff 	li	at,2047
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	6060 4800 	ldl	v1,-2048\(zero\)
[ 0-9a-f]+:	6060 5807 	ldr	v1,-2041\(zero\)
[ 0-9a-f]+:	3020 0800 	li	at,2048
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	3020 f7ff 	li	at,-2049
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	3020 7ff1 	li	at,32753
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	41a1 ffff 	lui	at,0xffff
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	41a1 ffff 	lui	at,0xffff
[ 0-9a-f]+:	5021 0001 	ori	at,at,0x1
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	3020 8001 	li	at,-32767
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	41a1 f000 	lui	at,0xf000
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	6060 4fff 	ldl	v1,-1\(zero\)
[ 0-9a-f]+:	6060 5006 	ldr	v1,6\(zero\)
[ 0-9a-f]+:	41a1 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5678 	ori	at,at,0x5678
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	6064 4000 	ldl	v1,0\(a0\)
[ 0-9a-f]+:	6064 5007 	ldr	v1,7\(a0\)
[ 0-9a-f]+:	6064 4004 	ldl	v1,4\(a0\)
[ 0-9a-f]+:	6064 500b 	ldr	v1,11\(a0\)
[ 0-9a-f]+:	3024 07ff 	addiu	at,a0,2047
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	6064 4800 	ldl	v1,-2048\(a0\)
[ 0-9a-f]+:	6064 5807 	ldr	v1,-2041\(a0\)
[ 0-9a-f]+:	3024 0800 	addiu	at,a0,2048
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	3024 f7ff 	addiu	at,a0,-2049
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	3024 7ff1 	addiu	at,a0,32753
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	3024 8000 	addiu	at,a0,-32768
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	41a1 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	3024 8000 	addiu	at,a0,-32768
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	41a1 ffff 	lui	at,0xffff
[ 0-9a-f]+:	5021 0001 	ori	at,at,0x1
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	3024 8001 	addiu	at,a0,-32767
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	41a1 f000 	lui	at,0xf000
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	6064 4fff 	ldl	v1,-1\(a0\)
[ 0-9a-f]+:	6064 5006 	ldr	v1,6\(a0\)
[ 0-9a-f]+:	41a1 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5678 	ori	at,at,0x5678
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	6061 4000 	ldl	v1,0\(at\)
[ 0-9a-f]+:	6061 5007 	ldr	v1,7\(at\)
[ 0-9a-f]+:	6060 c000 	sdl	v1,0\(zero\)
[ 0-9a-f]+:	6060 d007 	sdr	v1,7\(zero\)
[ 0-9a-f]+:	6060 c000 	sdl	v1,0\(zero\)
[ 0-9a-f]+:	6060 d007 	sdr	v1,7\(zero\)
[ 0-9a-f]+:	6060 c004 	sdl	v1,4\(zero\)
[ 0-9a-f]+:	6060 d00b 	sdr	v1,11\(zero\)
[ 0-9a-f]+:	6060 c004 	sdl	v1,4\(zero\)
[ 0-9a-f]+:	6060 d00b 	sdr	v1,11\(zero\)
[ 0-9a-f]+:	3020 07ff 	li	at,2047
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	6060 c800 	sdl	v1,-2048\(zero\)
[ 0-9a-f]+:	6060 d807 	sdr	v1,-2041\(zero\)
[ 0-9a-f]+:	3020 0800 	li	at,2048
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	3020 f7ff 	li	at,-2049
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	3020 7ff1 	li	at,32753
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	41a1 ffff 	lui	at,0xffff
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	3020 8000 	li	at,-32768
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	41a1 ffff 	lui	at,0xffff
[ 0-9a-f]+:	5021 0001 	ori	at,at,0x1
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	3020 8001 	li	at,-32767
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	41a1 f000 	lui	at,0xf000
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	6060 cfff 	sdl	v1,-1\(zero\)
[ 0-9a-f]+:	6060 d006 	sdr	v1,6\(zero\)
[ 0-9a-f]+:	41a1 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5678 	ori	at,at,0x5678
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	6064 c000 	sdl	v1,0\(a0\)
[ 0-9a-f]+:	6064 d007 	sdr	v1,7\(a0\)
[ 0-9a-f]+:	6064 c004 	sdl	v1,4\(a0\)
[ 0-9a-f]+:	6064 d00b 	sdr	v1,11\(a0\)
[ 0-9a-f]+:	3024 07ff 	addiu	at,a0,2047
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	6064 c800 	sdl	v1,-2048\(a0\)
[ 0-9a-f]+:	6064 d807 	sdr	v1,-2041\(a0\)
[ 0-9a-f]+:	3024 0800 	addiu	at,a0,2048
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	3024 f7ff 	addiu	at,a0,-2049
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	3024 7ff1 	addiu	at,a0,32753
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	3024 8000 	addiu	at,a0,-32768
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	5020 ffff 	li	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	41a1 ffff 	lui	at,0xffff
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	3024 8000 	addiu	at,a0,-32768
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	41a1 ffff 	lui	at,0xffff
[ 0-9a-f]+:	5021 0001 	ori	at,at,0x1
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	3024 8001 	addiu	at,a0,-32767
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	41a1 f000 	lui	at,0xf000
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	6064 cfff 	sdl	v1,-1\(a0\)
[ 0-9a-f]+:	6064 d006 	sdr	v1,6\(a0\)
[ 0-9a-f]+:	41a1 1234 	lui	at,0x1234
[ 0-9a-f]+:	5021 5678 	ori	at,at,0x5678
[ 0-9a-f]+:	0081 0950 	addu	at,at,a0
[ 0-9a-f]+:	6061 c000 	sdl	v1,0\(at\)
[ 0-9a-f]+:	6061 d007 	sdr	v1,7\(at\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	6201 4000 	ldl	s0,0\(at\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	6201 5000 	ldr	s0,0\(at\)
[ 0-9a-f]+:	3203 0000 	addiu	s0,v1,0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	6210 7000 	lld	s0,0\(s0\)
[ 0-9a-f]+:	3203 0000 	addiu	s0,v1,0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	6210 e000 	lwu	s0,0\(s0\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	6201 f000 	scd	s0,0\(at\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	6201 c000 	sdl	s0,0\(at\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	6201 d000 	sdr	s0,0\(at\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	2021 7000 	ldm	s0,0\(at\)
[ 0-9a-f]+:	3223 0000 	addiu	s1,v1,0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	2211 4000 	ldp	s0,0\(s1\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	2021 f000 	sdm	s0,0\(at\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	2201 c000 	sdp	s0,0\(at\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	2201 2000 	ldc2	\$16,0\(at\)
[ 0-9a-f]+:	3023 0000 	addiu	at,v1,0
[ 	]*[0-9a-f]+: R_MICROMIPS_LO16	test
[ 0-9a-f]+:	2201 a000 	sdc2	\$16,0\(at\)
[ 0-9a-f]+:	0c00      	nop
#pass
