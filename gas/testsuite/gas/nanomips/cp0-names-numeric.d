#objdump: -dr -M gpr-names=numeric,cp0-names=numeric
#name: nanoMIPS CP0 register disassembly (numeric)
#source: cp0-names.s

# Check objdump's handling of -M cp0-names=foo options.

.*: +file format .*nanomips.*

Disassembly of section .text:

0+0000 <text_label>:
   0:	2000 0070 	mtc0	\$0,\$0
   4:	2001 0070 	mtc0	\$0,\$1
   8:	2002 0070 	mtc0	\$0,\$2
   c:	2003 0070 	mtc0	\$0,\$3
  10:	2004 0070 	mtc0	\$0,\$4
  14:	2005 0070 	mtc0	\$0,\$5
  18:	2006 0070 	mtc0	\$0,\$6
  1c:	2007 0070 	mtc0	\$0,\$7
  20:	2008 0070 	mtc0	\$0,\$8
  24:	2009 0070 	mtc0	\$0,\$9
  28:	200a 0070 	mtc0	\$0,\$10
  2c:	200b 0070 	mtc0	\$0,\$11
  30:	200c 0070 	mtc0	\$0,\$12
  34:	200d 0070 	mtc0	\$0,\$13
  38:	200e 0070 	mtc0	\$0,\$14
  3c:	200f 0070 	mtc0	\$0,\$15
  40:	2010 0070 	mtc0	\$0,\$16
  44:	2011 0070 	mtc0	\$0,\$17
  48:	2012 0070 	mtc0	\$0,\$18
  4c:	2013 0070 	mtc0	\$0,\$19
  50:	2014 0070 	mtc0	\$0,\$20
  54:	2015 0070 	mtc0	\$0,\$21
  58:	2016 0070 	mtc0	\$0,\$22
  5c:	2017 0070 	mtc0	\$0,\$23
  60:	2018 0070 	mtc0	\$0,\$24
  64:	2019 0070 	mtc0	\$0,\$25
  68:	201a 0070 	mtc0	\$0,\$26
  6c:	201b 0070 	mtc0	\$0,\$27
  70:	201c 0070 	mtc0	\$0,\$28
  74:	201d 0070 	mtc0	\$0,\$29
  78:	201e 0070 	mtc0	\$0,\$30
  7c:	201f 0070 	mtc0	\$0,\$31
#pass
