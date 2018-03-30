#objdump: -dr -M gpr-names=numeric,cp0-names=32r6
#name: nanoMIPS CP0 register disassembly \(32r6\)
#source: cp0-names.s

# Check objdump's handling of -M cp0-names=foo options.

.*: +file format .*nanomips.*

Disassembly of section \.text:

0+0000 <text_label>:
   0:	2000 0070 	mtc0	\$0,index
   4:	2001 0070 	mtc0	\$0,random
   8:	2002 0070 	mtc0	\$0,entrylo0
   c:	2003 0070 	mtc0	\$0,entrylo1
  10:	2004 0070 	mtc0	\$0,context
  14:	2005 0070 	mtc0	\$0,pagemask
  18:	2006 0070 	mtc0	\$0,wired
  1c:	2007 0070 	mtc0	\$0,hwrena
  20:	2008 0070 	mtc0	\$0,badvaddr
  24:	2009 0070 	mtc0	\$0,count
  28:	200a 0070 	mtc0	\$0,entryhi
  2c:	200b 0070 	mtc0	\$0,compare
  30:	200c 0070 	mtc0	\$0,status
  34:	200d 0070 	mtc0	\$0,cause
  38:	200e 0070 	mtc0	\$0,epc
  3c:	200f 0070 	mtc0	\$0,prid
  40:	2010 0070 	mtc0	\$0,config
  44:	2011 0070 	mtc0	\$0,lladdr
  48:	2012 0070 	mtc0	\$0,watchlo0
  4c:	2013 0070 	mtc0	\$0,watchhi0
  50:	2014 0070 	mtc0	\$0,xcontext
  54:	2015 0070 	mtc0	\$0,\$21
  58:	2016 0070 	mtc0	\$0,\$22
  5c:	2017 0070 	mtc0	\$0,debug
  60:	2018 0070 	mtc0	\$0,depc
  64:	2019 0070 	mtc0	\$0,perfctl0
  68:	201a 0070 	mtc0	\$0,errctl
  6c:	201b 0070 	mtc0	\$0,cacheerr
  70:	201c 0070 	mtc0	\$0,itaglo
  74:	201d 0070 	mtc0	\$0,itaghi
  78:	201e 0070 	mtc0	\$0,errorepc
  7c:	201f 0070 	mtc0	\$0,desave
#pass
