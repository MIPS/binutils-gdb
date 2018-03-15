#objdump: -dr -M gpr-names=numeric,hwr-names=32r6
#name: nanoMIPS HWR disassembly

# Check objdump's handling of -M hwr-names=foo options.

.*: +file format .*nanomips.*

Disassembly of section \.text:

0+0000 <text_label>:
   0:	2000 01c0 	rdhwr	\$0,cpunum
   4:	2001 01c0 	rdhwr	\$0,synci_step
   8:	2002 01c0 	rdhwr	\$0,cc
   c:	2003 01c0 	rdhwr	\$0,ccres
  10:	2004 01c0 	rdhwr	\$0,perfctl0
  14:	2004 09c0 	rdhwr	\$0,perfcnt0
  18:	2004 11c0 	rdhwr	\$0,perfctl1
  1c:	2004 19c0 	rdhwr	\$0,perfcnt1
  20:	2004 21c0 	rdhwr	\$0,perfctl2
  24:	2004 29c0 	rdhwr	\$0,perfcnt2
  28:	2004 31c0 	rdhwr	\$0,perfctl3
  2c:	2004 39c0 	rdhwr	\$0,perfcnt3
  30:	2004 41c0 	rdhwr	\$0,perfctl4
  34:	2004 49c0 	rdhwr	\$0,perfcnt4
  38:	2004 51c0 	rdhwr	\$0,perfctl5
  3c:	2004 59c0 	rdhwr	\$0,perfcnt5
  40:	2004 61c0 	rdhwr	\$0,perfctl6
  44:	2004 69c0 	rdhwr	\$0,perfcnt6
  48:	2004 71c0 	rdhwr	\$0,perfctl7
  4c:	2004 79c0 	rdhwr	\$0,perfcnt7
  50:	2004 01c0 	rdhwr	\$0,perfctl0
  54:	2004 09c0 	rdhwr	\$0,perfcnt0
  58:	2004 11c0 	rdhwr	\$0,perfctl1
  5c:	2004 19c0 	rdhwr	\$0,perfcnt1
  60:	2004 21c0 	rdhwr	\$0,perfctl2
  64:	2004 29c0 	rdhwr	\$0,perfcnt2
  68:	2004 31c0 	rdhwr	\$0,perfctl3
  6c:	2004 39c0 	rdhwr	\$0,perfcnt3
  70:	2004 41c0 	rdhwr	\$0,perfctl4
  74:	2004 49c0 	rdhwr	\$0,perfcnt4
  78:	2004 51c0 	rdhwr	\$0,perfctl5
  7c:	2004 59c0 	rdhwr	\$0,perfcnt5
  80:	2004 61c0 	rdhwr	\$0,perfctl6
  84:	2004 69c0 	rdhwr	\$0,perfcnt6
  88:	2004 71c0 	rdhwr	\$0,perfctl7
  8c:	2004 79c0 	rdhwr	\$0,perfcnt7
  90:	2005 01c0 	rdhwr	\$0,xnp
  94:	201d 01c0 	rdhwr	\$0,userlocal
	\.\.\.
