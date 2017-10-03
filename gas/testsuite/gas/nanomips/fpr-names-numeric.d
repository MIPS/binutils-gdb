#objdump: -dr -M gpr-names=numeric,fpr-names=numeric
#name: nanoMIPS FPR disassembly (numeric)
#source: fpr-names.s

# Check objdump's handling of -M fpr-names=foo options.

.*: +file format .*nanomips.*

Disassembly of section \.text:

0+0000 <text_label>:
   0:	a000 283b 	mtc1	\$0,\$f0
   4:	a001 283b 	mtc1	\$0,\$f1
   8:	a002 283b 	mtc1	\$0,\$f2
   c:	a003 283b 	mtc1	\$0,\$f3
  10:	a004 283b 	mtc1	\$0,\$f4
  14:	a005 283b 	mtc1	\$0,\$f5
  18:	a006 283b 	mtc1	\$0,\$f6
  1c:	a007 283b 	mtc1	\$0,\$f7
  20:	a008 283b 	mtc1	\$0,\$f8
  24:	a009 283b 	mtc1	\$0,\$f9
  28:	a00a 283b 	mtc1	\$0,\$f10
  2c:	a00b 283b 	mtc1	\$0,\$f11
  30:	a00c 283b 	mtc1	\$0,\$f12
  34:	a00d 283b 	mtc1	\$0,\$f13
  38:	a00e 283b 	mtc1	\$0,\$f14
  3c:	a00f 283b 	mtc1	\$0,\$f15
  40:	a010 283b 	mtc1	\$0,\$f16
  44:	a011 283b 	mtc1	\$0,\$f17
  48:	a012 283b 	mtc1	\$0,\$f18
  4c:	a013 283b 	mtc1	\$0,\$f19
  50:	a014 283b 	mtc1	\$0,\$f20
  54:	a015 283b 	mtc1	\$0,\$f21
  58:	a016 283b 	mtc1	\$0,\$f22
  5c:	a017 283b 	mtc1	\$0,\$f23
  60:	a018 283b 	mtc1	\$0,\$f24
  64:	a019 283b 	mtc1	\$0,\$f25
  68:	a01a 283b 	mtc1	\$0,\$f26
  6c:	a01b 283b 	mtc1	\$0,\$f27
  70:	a01c 283b 	mtc1	\$0,\$f28
  74:	a01d 283b 	mtc1	\$0,\$f29
  78:	a01e 283b 	mtc1	\$0,\$f30
  7c:	a01f 283b 	mtc1	\$0,\$f31
	\.\.\.
