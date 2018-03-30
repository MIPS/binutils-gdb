#name: nanoMIPS expression 1
#objdump: -dr

.*:     file format .*

Disassembly of section \.text:

0+0000 <foo>:
   0:	8484 8000 	lw	a0,0\(a0\)
			0: R_NANOMIPS_LO12	foo
   4:	164e      	lw	a0,56\(a0\)
   6:	8484 8000 	lw	a0,0\(a0\)
			6: R_NANOMIPS_LO12	foo\+0x8
   a:	8484 8000 	lw	a0,0\(a0\)
			a: R_NANOMIPS_LO12	foo\+0x8
   e:	8484 8000 	lw	a0,0\(a0\)
			e: R_NANOMIPS_LO12	foo\+0x8
#pass
