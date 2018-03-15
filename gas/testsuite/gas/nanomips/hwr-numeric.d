#objdump: -dr -M gpr-names=numeric,hwr-names=numeric
#name: nanoMIPS HWR disassembly with numeric registers
#source: hwr-names.s

# Check objdump's handling of -M hwr-names=foo options.

.*: +file format .*nanomips.*

Disassembly of section \.text:

0+0000 <text_label>:
   0:	2000 01c0 	rdhwr	\$0,\$0
   4:	2001 01c0 	rdhwr	\$0,\$1
   8:	2002 01c0 	rdhwr	\$0,\$2
   c:	2003 01c0 	rdhwr	\$0,\$3
  10:	2004 01c0 	rdhwr	\$0,\$4
  14:	2004 09c0 	rdhwr	\$0,\$4,1
  18:	2004 11c0 	rdhwr	\$0,\$4,2
  1c:	2004 19c0 	rdhwr	\$0,\$4,3
  20:	2004 21c0 	rdhwr	\$0,\$4,4
  24:	2004 29c0 	rdhwr	\$0,\$4,5
  28:	2004 31c0 	rdhwr	\$0,\$4,6
  2c:	2004 39c0 	rdhwr	\$0,\$4,7
  30:	2004 41c0 	rdhwr	\$0,\$4,8
  34:	2004 49c0 	rdhwr	\$0,\$4,9
  38:	2004 51c0 	rdhwr	\$0,\$4,10
  3c:	2004 59c0 	rdhwr	\$0,\$4,11
  40:	2004 61c0 	rdhwr	\$0,\$4,12
  44:	2004 69c0 	rdhwr	\$0,\$4,13
  48:	2004 71c0 	rdhwr	\$0,\$4,14
  4c:	2004 79c0 	rdhwr	\$0,\$4,15
  50:	2004 01c0 	rdhwr	\$0,\$4
  54:	2004 09c0 	rdhwr	\$0,\$4,1
  58:	2004 11c0 	rdhwr	\$0,\$4,2
  5c:	2004 19c0 	rdhwr	\$0,\$4,3
  60:	2004 21c0 	rdhwr	\$0,\$4,4
  64:	2004 29c0 	rdhwr	\$0,\$4,5
  68:	2004 31c0 	rdhwr	\$0,\$4,6
  6c:	2004 39c0 	rdhwr	\$0,\$4,7
  70:	2004 41c0 	rdhwr	\$0,\$4,8
  74:	2004 49c0 	rdhwr	\$0,\$4,9
  78:	2004 51c0 	rdhwr	\$0,\$4,10
  7c:	2004 59c0 	rdhwr	\$0,\$4,11
  80:	2004 61c0 	rdhwr	\$0,\$4,12
  84:	2004 69c0 	rdhwr	\$0,\$4,13
  88:	2004 71c0 	rdhwr	\$0,\$4,14
  8c:	2004 79c0 	rdhwr	\$0,\$4,15
  90:	2005 01c0 	rdhwr	\$0,\$5
  94:	201d 01c0 	rdhwr	\$0,\$29
	\.\.\.
