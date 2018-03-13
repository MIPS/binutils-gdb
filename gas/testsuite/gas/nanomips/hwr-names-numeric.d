#objdump: -dr -M gpr-names=numeric,hwr-names=numeric
#name: nanoMIPS HWR disassembly \(numeric\)
#source: hwr-names.s

# Check objdump's handling of -M hwr-names=foo options.

.*: +file format .*mips.*

Disassembly of section \.text:

0+0000 <text_label>:
   0:	2000 01c0 	rdhwr	\$0,\$0
   4:	2001 01c0 	rdhwr	\$0,\$1
   8:	2002 01c0 	rdhwr	\$0,\$2
   c:	2003 01c0 	rdhwr	\$0,\$3
  10:	2004 01c0 	rdhwr	\$0,\$4
  14:	2005 01c0 	rdhwr	\$0,\$5
  18:	2006 01c0 	rdhwr	\$0,\$6
  1c:	2007 01c0 	rdhwr	\$0,\$7
  20:	2008 01c0 	rdhwr	\$0,\$8
  24:	2009 01c0 	rdhwr	\$0,\$9
  28:	200a 01c0 	rdhwr	\$0,\$10
  2c:	200b 01c0 	rdhwr	\$0,\$11
  30:	200c 01c0 	rdhwr	\$0,\$12
  34:	200d 01c0 	rdhwr	\$0,\$13
  38:	200e 01c0 	rdhwr	\$0,\$14
  3c:	200f 01c0 	rdhwr	\$0,\$15
  40:	2010 01c0 	rdhwr	\$0,\$16
  44:	2011 01c0 	rdhwr	\$0,\$17
  48:	2012 01c0 	rdhwr	\$0,\$18
  4c:	2013 01c0 	rdhwr	\$0,\$19
  50:	2014 01c0 	rdhwr	\$0,\$20
  54:	2015 01c0 	rdhwr	\$0,\$21
  58:	2016 01c0 	rdhwr	\$0,\$22
  5c:	2017 01c0 	rdhwr	\$0,\$23
  60:	2018 01c0 	rdhwr	\$0,\$24
  64:	2019 01c0 	rdhwr	\$0,\$25
  68:	201a 01c0 	rdhwr	\$0,\$26
  6c:	201b 01c0 	rdhwr	\$0,\$27
  70:	201c 01c0 	rdhwr	\$0,\$28
  74:	201d 01c0 	rdhwr	\$0,\$29
  78:	201e 01c0 	rdhwr	\$0,\$30
  7c:	201f 01c0 	rdhwr	\$0,\$31
  80:	2004 01c0 	rdhwr	\$0,\$4
  84:	2004 09c0 	rdhwr	\$0,\$4,1
  88:	2004 11c0 	rdhwr	\$0,\$4,2
  8c:	2004 19c0 	rdhwr	\$0,\$4,3
  90:	2004 21c0 	rdhwr	\$0,\$4,4
  94:	2004 29c0 	rdhwr	\$0,\$4,5
  98:	2004 31c0 	rdhwr	\$0,\$4,6
  9c:	2004 39c0 	rdhwr	\$0,\$4,7
  a0:	2004 41c0 	rdhwr	\$0,\$4,8
  a4:	2004 49c0 	rdhwr	\$0,\$4,9
  a8:	2004 51c0 	rdhwr	\$0,\$4,10
  ac:	2004 59c0 	rdhwr	\$0,\$4,11
  b0:	2004 61c0 	rdhwr	\$0,\$4,12
  b4:	2004 69c0 	rdhwr	\$0,\$4,13
  b8:	2004 71c0 	rdhwr	\$0,\$4,14
  bc:	2004 79c0 	rdhwr	\$0,\$4,15
	\.\.\.
