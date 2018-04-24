#objdump: -dr
#name: nanoMIPS ELF TLS p32

.*:     file format .*

Disassembly of section .text:

00000000 \<fn\>:
 +[0-9a-f]+:	6383 0000 	lapc	gp,0 <_gp>
 +[0-9a-f]+:	0000.
			2: R_NANOMIPS_PC_I32	_gp
 +[0-9a-f]+:	83bd 8010 	addiu	sp,sp,-16
 +[0-9a-f]+:	b7c2      	sw	fp,8\(sp\)
 +[0-9a-f]+:	13dd      	move	fp,sp
 +[0-9a-f]+:	4320 0002 	lw	t9,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_CALL	__tls_get_addr
 +[0-9a-f]+:	4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_TLS_GD	tlsvar_gd
 +[0-9a-f]+:	db30      	jalrc	t9
 +[0-9a-f]+:	4320 0002 	lw	t9,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_CALL	__tls_get_addr
 +[0-9a-f]+:	4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_TLS_LD	tlsvar_ld
 +[0-9a-f]+:	db30      	jalrc	t9
 +[0-9a-f]+:	1042      	move	t4,t4
 +[0-9a-f]+:	0062 0000 	addiu	t5,t4,0
			[0-9a-f]+: R_NANOMIPS_TLS_DTPREL16	tlsvar_ld
 +[0-9a-f]+:	205d 01c0 	rdhwr	t4,userlocal
 +[0-9a-f]+:	4060 0002 	lw	t5,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_TLS_GOTTPREL	tlsvar_ie
 +[0-9a-f]+:	2043 1950 	addu	t5,t5,t4
 +[0-9a-f]+:	205d 01c0 	rdhwr	t4,userlocal
 +[0-9a-f]+:	0062 0000 	addiu	t5,t4,0
			[0-9a-f]+: R_NANOMIPS_TLS_TPREL16	tlsvar_le
 +[0-9a-f]+:	13be      	move	sp,fp
 +[0-9a-f]+:	37c2      	lw	fp,8\(sp\)
 +[0-9a-f]+:	03bd 0010 	addiu	sp,sp,16
 +[0-9a-f]+:	dbe0      	jrc	ra
#pass
