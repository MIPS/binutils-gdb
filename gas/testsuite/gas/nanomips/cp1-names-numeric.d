#objdump: -dr -M gpr-names=numeric,cp1-names=numeric
#name: nanoMIPS CP1 register disassembly \(numeric\)
#source: cp1-names.s

# Check objdump's handling of -M cp1-names=foo options.

.*: +file format .*nanomips.*

Disassembly of section \.text:

0+0000 <text_label>:
   0:	a000 183b 	ctc1	\$0,\$f0
   4:	a001 183b 	ctc1	\$0,\$f1
   8:	a002 183b 	ctc1	\$0,\$f2
   c:	a003 183b 	ctc1	\$0,\$f3
  10:	a004 183b 	ctc1	\$0,\$f4
  14:	a005 183b 	ctc1	\$0,\$f5
  18:	a006 183b 	ctc1	\$0,\$f6
  1c:	a007 183b 	ctc1	\$0,\$f7
  20:	a008 183b 	ctc1	\$0,\$f8
  24:	a009 183b 	ctc1	\$0,\$f9
  28:	a00a 183b 	ctc1	\$0,\$f10
  2c:	a00b 183b 	ctc1	\$0,\$f11
  30:	a00c 183b 	ctc1	\$0,\$f12
  34:	a00d 183b 	ctc1	\$0,\$f13
  38:	a00e 183b 	ctc1	\$0,\$f14
  3c:	a00f 183b 	ctc1	\$0,\$f15
  40:	a010 183b 	ctc1	\$0,\$f16
  44:	a011 183b 	ctc1	\$0,\$f17
  48:	a012 183b 	ctc1	\$0,\$f18
  4c:	a013 183b 	ctc1	\$0,\$f19
  50:	a014 183b 	ctc1	\$0,\$f20
  54:	a015 183b 	ctc1	\$0,\$f21
  58:	a016 183b 	ctc1	\$0,\$f22
  5c:	a017 183b 	ctc1	\$0,\$f23
  60:	a018 183b 	ctc1	\$0,\$f24
  64:	a019 183b 	ctc1	\$0,\$f25
  68:	a01a 183b 	ctc1	\$0,\$f26
  6c:	a01b 183b 	ctc1	\$0,\$f27
  70:	a01c 183b 	ctc1	\$0,\$f28
  74:	a01d 183b 	ctc1	\$0,\$f29
  78:	a01e 183b 	ctc1	\$0,\$f30
  7c:	a01f 183b 	ctc1	\$0,\$f31
  80:	a000 103b 	cfc1	\$0,\$f0
  84:	a001 103b 	cfc1	\$0,\$f1
  88:	a002 103b 	cfc1	\$0,\$f2
  8c:	a003 103b 	cfc1	\$0,\$f3
  90:	a004 103b 	cfc1	\$0,\$f4
  94:	a005 103b 	cfc1	\$0,\$f5
  98:	a006 103b 	cfc1	\$0,\$f6
  9c:	a007 103b 	cfc1	\$0,\$f7
  a0:	a008 103b 	cfc1	\$0,\$f8
  a4:	a009 103b 	cfc1	\$0,\$f9
  a8:	a00a 103b 	cfc1	\$0,\$f10
  ac:	a00b 103b 	cfc1	\$0,\$f11
  b0:	a00c 103b 	cfc1	\$0,\$f12
  b4:	a00d 103b 	cfc1	\$0,\$f13
  b8:	a00e 103b 	cfc1	\$0,\$f14
  bc:	a00f 103b 	cfc1	\$0,\$f15
  c0:	a010 103b 	cfc1	\$0,\$f16
  c4:	a011 103b 	cfc1	\$0,\$f17
  c8:	a012 103b 	cfc1	\$0,\$f18
  cc:	a013 103b 	cfc1	\$0,\$f19
  d0:	a014 103b 	cfc1	\$0,\$f20
  d4:	a015 103b 	cfc1	\$0,\$f21
  d8:	a016 103b 	cfc1	\$0,\$f22
  dc:	a017 103b 	cfc1	\$0,\$f23
  e0:	a018 103b 	cfc1	\$0,\$f24
  e4:	a019 103b 	cfc1	\$0,\$f25
  e8:	a01a 103b 	cfc1	\$0,\$f26
  ec:	a01b 103b 	cfc1	\$0,\$f27
  f0:	a01c 103b 	cfc1	\$0,\$f28
  f4:	a01d 103b 	cfc1	\$0,\$f29
  f8:	a01e 103b 	cfc1	\$0,\$f30
  fc:	a01f 103b 	cfc1	\$0,\$f31
#pass
