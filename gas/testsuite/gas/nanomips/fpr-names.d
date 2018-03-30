#objdump: -dr -M gpr-names=numeric,fpr-names=p32
#name: nanoMIPS FPR disassembly \(p32\)
#source: fpr-names.s

# Check objdump's handling of -M fpr-names=foo options.

.*: +file format .*nanomips.*

Disassembly of section \.text:

0+0000 <text_label>:
   0:	a000 283b 	mtc1	\$0,fv0
   4:	a001 283b 	mtc1	\$0,ft12
   8:	a002 283b 	mtc1	\$0,fv1
   c:	a003 283b 	mtc1	\$0,ft13
  10:	a004 283b 	mtc1	\$0,ft0
  14:	a005 283b 	mtc1	\$0,ft1
  18:	a006 283b 	mtc1	\$0,ft2
  1c:	a007 283b 	mtc1	\$0,ft3
  20:	a008 283b 	mtc1	\$0,ft4
  24:	a009 283b 	mtc1	\$0,ft5
  28:	a00a 283b 	mtc1	\$0,ft6
  2c:	a00b 283b 	mtc1	\$0,ft7
  30:	a00c 283b 	mtc1	\$0,fa0
  34:	a00d 283b 	mtc1	\$0,fa1
  38:	a00e 283b 	mtc1	\$0,fa2
  3c:	a00f 283b 	mtc1	\$0,fa3
  40:	a010 283b 	mtc1	\$0,fa4
  44:	a011 283b 	mtc1	\$0,fa5
  48:	a012 283b 	mtc1	\$0,fa6
  4c:	a013 283b 	mtc1	\$0,fa7
  50:	a014 283b 	mtc1	\$0,ft8
  54:	a015 283b 	mtc1	\$0,ft9
  58:	a016 283b 	mtc1	\$0,ft10
  5c:	a017 283b 	mtc1	\$0,ft11
  60:	a018 283b 	mtc1	\$0,fs0
  64:	a019 283b 	mtc1	\$0,fs1
  68:	a01a 283b 	mtc1	\$0,fs2
  6c:	a01b 283b 	mtc1	\$0,fs3
  70:	a01c 283b 	mtc1	\$0,fs4
  74:	a01d 283b 	mtc1	\$0,fs5
  78:	a01e 283b 	mtc1	\$0,fs6
  7c:	a01f 283b 	mtc1	\$0,fs7
#pass
