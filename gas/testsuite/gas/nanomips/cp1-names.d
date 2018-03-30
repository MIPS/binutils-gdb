#objdump: -dr -M gpr-names=numeric,cp1-names=32r6
#name: nanoMIPS CP1 register disassembly

# Check objdump's handling of -M cp1-names=foo options.

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <text_label>:
   0:	a000 183b 	ctc1	\$0,c1_fir
   4:	a001 183b 	ctc1	\$0,c1_ufr
   8:	a002 183b 	ctc1	\$0,\$2
   c:	a003 183b 	ctc1	\$0,\$3
  10:	a004 183b 	ctc1	\$0,c1_unfr
  14:	a005 183b 	ctc1	\$0,\$5
  18:	a006 183b 	ctc1	\$0,\$6
  1c:	a007 183b 	ctc1	\$0,\$7
  20:	a008 183b 	ctc1	\$0,\$8
  24:	a009 183b 	ctc1	\$0,\$9
  28:	a00a 183b 	ctc1	\$0,\$10
  2c:	a00b 183b 	ctc1	\$0,\$11
  30:	a00c 183b 	ctc1	\$0,\$12
  34:	a00d 183b 	ctc1	\$0,\$13
  38:	a00e 183b 	ctc1	\$0,\$14
  3c:	a00f 183b 	ctc1	\$0,\$15
  40:	a010 183b 	ctc1	\$0,\$16
  44:	a011 183b 	ctc1	\$0,\$17
  48:	a012 183b 	ctc1	\$0,\$18
  4c:	a013 183b 	ctc1	\$0,\$19
  50:	a014 183b 	ctc1	\$0,\$20
  54:	a015 183b 	ctc1	\$0,\$21
  58:	a016 183b 	ctc1	\$0,\$22
  5c:	a017 183b 	ctc1	\$0,\$23
  60:	a018 183b 	ctc1	\$0,\$24
  64:	a019 183b 	ctc1	\$0,c1_fccr
  68:	a01a 183b 	ctc1	\$0,c1_fexr
  6c:	a01b 183b 	ctc1	\$0,\$27
  70:	a01c 183b 	ctc1	\$0,c1_fenr
  74:	a01d 183b 	ctc1	\$0,\$29
  78:	a01e 183b 	ctc1	\$0,\$30
  7c:	a01f 183b 	ctc1	\$0,c1_fcsr
  80:	a000 103b 	cfc1	\$0,c1_fir
  84:	a001 103b 	cfc1	\$0,c1_ufr
  88:	a002 103b 	cfc1	\$0,\$2
  8c:	a003 103b 	cfc1	\$0,\$3
  90:	a004 103b 	cfc1	\$0,c1_unfr
  94:	a005 103b 	cfc1	\$0,\$5
  98:	a006 103b 	cfc1	\$0,\$6
  9c:	a007 103b 	cfc1	\$0,\$7
  a0:	a008 103b 	cfc1	\$0,\$8
  a4:	a009 103b 	cfc1	\$0,\$9
  a8:	a00a 103b 	cfc1	\$0,\$10
  ac:	a00b 103b 	cfc1	\$0,\$11
  b0:	a00c 103b 	cfc1	\$0,\$12
  b4:	a00d 103b 	cfc1	\$0,\$13
  b8:	a00e 103b 	cfc1	\$0,\$14
  bc:	a00f 103b 	cfc1	\$0,\$15
  c0:	a010 103b 	cfc1	\$0,\$16
  c4:	a011 103b 	cfc1	\$0,\$17
  c8:	a012 103b 	cfc1	\$0,\$18
  cc:	a013 103b 	cfc1	\$0,\$19
  d0:	a014 103b 	cfc1	\$0,\$20
  d4:	a015 103b 	cfc1	\$0,\$21
  d8:	a016 103b 	cfc1	\$0,\$22
  dc:	a017 103b 	cfc1	\$0,\$23
  e0:	a018 103b 	cfc1	\$0,\$24
  e4:	a019 103b 	cfc1	\$0,c1_fccr
  e8:	a01a 103b 	cfc1	\$0,c1_fexr
  ec:	a01b 103b 	cfc1	\$0,\$27
  f0:	a01c 103b 	cfc1	\$0,c1_fenr
  f4:	a01d 103b 	cfc1	\$0,\$29
  f8:	a01e 103b 	cfc1	\$0,\$30
  fc:	a01f 103b 	cfc1	\$0,c1_fcsr
#pass
