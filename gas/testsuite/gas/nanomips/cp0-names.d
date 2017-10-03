#objdump: -dr -M gpr-names=numeric,cp0-names=32r6
#name: nanoMIPS CP0 register disassembly \(32r6\)
#source: cp0-names.s

# Check objdump's handling of -M cp0-names=foo options.

.*: +file format .*nanomips.*

Disassembly of section \.text:

0+0000 <text_label>:
   0:	2000 0070 	mtc0	\$0,c0_index
   4:	2001 0070 	mtc0	\$0,c0_random
   8:	2002 0070 	mtc0	\$0,c0_entrylo0
   c:	2003 0070 	mtc0	\$0,c0_entrylo1
  10:	2004 0070 	mtc0	\$0,c0_context
  14:	2005 0070 	mtc0	\$0,c0_pagemask
  18:	2006 0070 	mtc0	\$0,c0_wired
  1c:	2007 0070 	mtc0	\$0,c0_hwrena
  20:	2008 0070 	mtc0	\$0,c0_badvaddr
  24:	2009 0070 	mtc0	\$0,c0_count
  28:	200a 0070 	mtc0	\$0,c0_entryhi
  2c:	200b 0070 	mtc0	\$0,c0_compare
  30:	200c 0070 	mtc0	\$0,c0_status
  34:	200d 0070 	mtc0	\$0,c0_cause
  38:	200e 0070 	mtc0	\$0,c0_epc
  3c:	200f 0070 	mtc0	\$0,c0_prid
  40:	2010 0070 	mtc0	\$0,c0_config
  44:	2011 0070 	mtc0	\$0,c0_lladdr
  48:	2012 0070 	mtc0	\$0,c0_watchlo
  4c:	2013 0070 	mtc0	\$0,c0_watchhi
  50:	2014 0070 	mtc0	\$0,c0_xcontext
  54:	2015 0070 	mtc0	\$0,\$21
  58:	2016 0070 	mtc0	\$0,\$22
  5c:	2017 0070 	mtc0	\$0,c0_debug
  60:	2018 0070 	mtc0	\$0,c0_depc
  64:	2019 0070 	mtc0	\$0,c0_perfcnt
  68:	201a 0070 	mtc0	\$0,c0_errctl
  6c:	201b 0070 	mtc0	\$0,c0_cacheerr
  70:	201c 0070 	mtc0	\$0,c0_taglo
  74:	201d 0070 	mtc0	\$0,c0_taghi
  78:	201e 0070 	mtc0	\$0,c0_errorepc
  7c:	201f 0070 	mtc0	\$0,c0_desave
	\.\.\.
