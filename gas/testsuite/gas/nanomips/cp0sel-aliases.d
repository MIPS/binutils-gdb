#objdump: -dr -M gpr-names=numeric,cp0-names=32r6
#name: nanoMIPS CP0 register alias names

# Check assembly of cp0-names register name aliases

.*: +file format .*nanomips.*

Disassembly of section \.text:

0+0000 <text_label>:
   0:	2012 0070 	mtc0	\$0,watchlo0
   4:	2012 0870 	mtc0	\$0,watchlo1
   8:	2012 1070 	mtc0	\$0,watchlo2
   c:	2012 1870 	mtc0	\$0,watchlo3
  10:	2012 2070 	mtc0	\$0,watchlo4
  14:	2012 2870 	mtc0	\$0,watchlo5
  18:	2012 3070 	mtc0	\$0,watchlo6
  1c:	2012 3870 	mtc0	\$0,watchlo7
  20:	2012 4070 	mtc0	\$0,watchlo8
  24:	2012 4870 	mtc0	\$0,watchlo9
  28:	2012 5070 	mtc0	\$0,watchlo10
  2c:	2012 5870 	mtc0	\$0,watchlo11
  30:	2012 6070 	mtc0	\$0,watchlo12
  34:	2012 6870 	mtc0	\$0,watchlo13
  38:	2012 7070 	mtc0	\$0,watchlo14
  3c:	2012 7870 	mtc0	\$0,watchlo15
  40:	2013 0070 	mtc0	\$0,watchhi0
  44:	2013 0870 	mtc0	\$0,watchhi1
  48:	2013 1070 	mtc0	\$0,watchhi2
  4c:	2013 1870 	mtc0	\$0,watchhi3
  50:	2013 2070 	mtc0	\$0,watchhi4
  54:	2013 2870 	mtc0	\$0,watchhi5
  58:	2013 3070 	mtc0	\$0,watchhi6
  5c:	2013 3870 	mtc0	\$0,watchhi7
  60:	2013 4070 	mtc0	\$0,watchhi8
  64:	2013 4870 	mtc0	\$0,watchhi9
  68:	2013 5070 	mtc0	\$0,watchhi10
  6c:	2013 5870 	mtc0	\$0,watchhi11
  70:	2013 6070 	mtc0	\$0,watchhi12
  74:	2013 6870 	mtc0	\$0,watchhi13
  78:	2013 7070 	mtc0	\$0,watchhi14
  7c:	2013 7870 	mtc0	\$0,watchhi15
  80:	2019 0070 	mtc0	\$0,perfctl0
  84:	2019 0870 	mtc0	\$0,perfcnt0
  88:	2019 1070 	mtc0	\$0,perfctl1
  8c:	2019 1870 	mtc0	\$0,perfcnt1
  90:	2019 2070 	mtc0	\$0,perfctl2
  94:	2019 2870 	mtc0	\$0,perfcnt2
  98:	2019 3070 	mtc0	\$0,perfctl3
  9c:	2019 3870 	mtc0	\$0,perfcnt3
  a0:	2019 4070 	mtc0	\$0,perfctl4
  a4:	2019 4870 	mtc0	\$0,perfcnt4
  a8:	2019 5070 	mtc0	\$0,perfctl5
  ac:	2019 5870 	mtc0	\$0,perfcnt5
  b0:	2019 6070 	mtc0	\$0,perfctl6
  b4:	2019 6870 	mtc0	\$0,perfcnt6
  b8:	2019 7070 	mtc0	\$0,perfctl7
  bc:	2019 7870 	mtc0	\$0,perfcnt7
  c0:	201c 0070 	mtc0	\$0,itaglo
  c4:	201c 0870 	mtc0	\$0,idatalo
  c8:	201c 1070 	mtc0	\$0,dtaglo
  cc:	201c 1870 	mtc0	\$0,ddatalo
  d0:	201d 0070 	mtc0	\$0,itaghi
  d4:	201d 0870 	mtc0	\$0,idatahi
  d8:	201d 1070 	mtc0	\$0,dtaghi
  dc:	201d 1870 	mtc0	\$0,ddatahi
	\.\.\.
