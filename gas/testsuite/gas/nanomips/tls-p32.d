#objdump: -dr
#name: nanoMIPS ELF TLS p32

dump.o:     file format .*

Disassembly of section .text:

00000000 \<fn\>:
   0:	e380 0002 	aluipc	gp,0 <_gp>
			[0-9a-f]+: R_NANOMIPS_PCHI20	_gp
   4:	83bd 8010 	addiu	sp,sp,-16
   8:	b7c2      	sw	fp,8\(sp\)
   a:	13dd      	move	fp,sp
   c:	4320 0002 	lw	t9,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_CALL	__tls_get_addr
  10:	4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_TLS_GD	tlsvar_gd
  14:	db30      	jalrc	t9
  16:	4320 0002 	lw	t9,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_GOT_CALL	__tls_get_addr
  1a:	4080 0000 	addiu	a0,gp,0
			[0-9a-f]+: R_NANOMIPS_TLS_LDM	tlsvar_ld
  1e:	db30      	jalrc	t9
  20:	1042      	move	t4,t4
  22:	e060 0000 	lui	t5,0x0
			[0-9a-f]+: R_NANOMIPS_TLS_DTPREL_HI20	tlsvar_ld
  26:	0063 0000 	addiu	t5,t5,0
			[0-9a-f]+: R_NANOMIPS_TLS_DTPREL_LO12	tlsvar_ld
  2a:	2043 1950 	addu	t5,t5,t4
  2e:	2045 01c0 	rdhwr	t4,\$5
  32:	4060 0002 	lw	t5,0\(gp\)
			[0-9a-f]+: R_NANOMIPS_TLS_GOTTPREL	tlsvar_ie
  36:	2043 1950 	addu	t5,t5,t4
  3a:	2045 01c0 	rdhwr	t4,\$5
  3e:	e060 0000 	lui	t5,0x0
			[0-9a-f]+: R_NANOMIPS_TLS_TPREL_HI20	tlsvar_le
  42:	8063 0000 	ori	t5,t5,0
			[0-9a-f]+: R_NANOMIPS_TLS_TPREL_LO12	tlsvar_le
  46:	2043 1950 	addu	t5,t5,t4
  4a:	13be      	move	sp,fp
  4c:	37c2      	lw	fp,8\(sp\)
  4e:	03bd 0010 	addiu	sp,sp,16
  52:	dbe0      	jrc	ra
