#objdump: -dr
#name: nanoMIPS ADDIU[GP] w/o linker relaxation

# Test all ADDIU[GP] variants without linker relaxation

.*: +file format .*nanomips.*

Disassembly of section .text:

00000000 <test>:
   0:	448c 0002 	addiu	a0,gp,2
   4:	448c 0004 	addiu	a0,gp,4
   8:	6082 0008 	addiu	a0,gp,8
   c:	0000.
   e:	448c 0005 	addiu	a0,gp,5
  12:	4080 0020 	addiu	a0,gp,32
  16:	6082 3456 	addiu	a0,gp,1193046
  1a:	0012.
  1c:	448c 0007 	addiu	a0,gp,7
  20:	4087 fffc 	addiu	a0,gp,524284
  24:	6082 3456 	addiu	a0,gp,1193046
  28:	0012.
  2a:	448c 0000 	addiu	a0,gp,0
			2a: R_NANOMIPS_GPREL18	test
  2e:	448c 0000 	addiu	a0,gp,0
			2e: R_NANOMIPS_GPREL18	test
  32:	6082 0000 	addiu	a0,gp,0
  36:	0000.
			34: R_NANOMIPS_GPREL_I32	test
  38:	448c 0000 	addiu	a0,gp,0
			38: R_NANOMIPS_GPREL18	test
  3c:	4080 0000 	addiu	a0,gp,0
			3c: R_NANOMIPS_GPREL19_S2	test
  40:	6082 0000 	addiu	a0,gp,0
  44:	0000.
			42: R_NANOMIPS_GPREL_I32	test
  46:	448c 0000 	addiu	a0,gp,0
			46: R_NANOMIPS_GPREL18	test
  4a:	4080 0000 	addiu	a0,gp,0
			4a: R_NANOMIPS_GPREL19_S2	test
  4e:	6082 0000 	addiu	a0,gp,0
  52:	0000.
			50: R_NANOMIPS_GPREL_I32	test
#pass
