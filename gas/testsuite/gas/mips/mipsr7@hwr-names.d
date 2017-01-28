#objdump: -dr --prefix-addresses --show-raw-insn -M gpr-names=numeric,hwr-names=mips32r6
#name: MIPS HWR disassembly (mips32r7)
#as: -defsym r6= 
#source: hwr-names.s

# Check objdump's handling of -M hwr-names=foo options.

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> 2000 01c0 	rdhwr	\$0,hwr_cpunum
[0-9a-f]+ <[^>]+> 2001 01c0 	rdhwr	\$0,hwr_synci_step
[0-9a-f]+ <[^>]+> 2002 01c0 	rdhwr	\$0,hwr_cc
[0-9a-f]+ <[^>]+> 2003 01c0 	rdhwr	\$0,hwr_ccres
[0-9a-f]+ <[^>]+> 2004 01c0 	rdhwr	\$0,\$4
[0-9a-f]+ <[^>]+> 2005 01c0 	rdhwr	\$0,\$5
[0-9a-f]+ <[^>]+> 2006 01c0 	rdhwr	\$0,\$6
[0-9a-f]+ <[^>]+> 2007 01c0 	rdhwr	\$0,\$7
[0-9a-f]+ <[^>]+> 2008 01c0 	rdhwr	\$0,\$8
[0-9a-f]+ <[^>]+> 2009 01c0 	rdhwr	\$0,\$9
[0-9a-f]+ <[^>]+> 200a 01c0 	rdhwr	\$0,\$10
[0-9a-f]+ <[^>]+> 200b 01c0 	rdhwr	\$0,\$11
[0-9a-f]+ <[^>]+> 200c 01c0 	rdhwr	\$0,\$12
[0-9a-f]+ <[^>]+> 200d 01c0 	rdhwr	\$0,\$13
[0-9a-f]+ <[^>]+> 200e 01c0 	rdhwr	\$0,\$14
[0-9a-f]+ <[^>]+> 200f 01c0 	rdhwr	\$0,\$15
[0-9a-f]+ <[^>]+> 2010 01c0 	rdhwr	\$0,\$16
[0-9a-f]+ <[^>]+> 2011 01c0 	rdhwr	\$0,\$17
[0-9a-f]+ <[^>]+> 2012 01c0 	rdhwr	\$0,\$18
[0-9a-f]+ <[^>]+> 2013 01c0 	rdhwr	\$0,\$19
[0-9a-f]+ <[^>]+> 2014 01c0 	rdhwr	\$0,\$20
[0-9a-f]+ <[^>]+> 2015 01c0 	rdhwr	\$0,\$21
[0-9a-f]+ <[^>]+> 2016 01c0 	rdhwr	\$0,\$22
[0-9a-f]+ <[^>]+> 2017 01c0 	rdhwr	\$0,\$23
[0-9a-f]+ <[^>]+> 2018 01c0 	rdhwr	\$0,\$24
[0-9a-f]+ <[^>]+> 2019 01c0 	rdhwr	\$0,\$25
[0-9a-f]+ <[^>]+> 201a 01c0 	rdhwr	\$0,\$26
[0-9a-f]+ <[^>]+> 201b 01c0 	rdhwr	\$0,\$27
[0-9a-f]+ <[^>]+> 201c 01c0 	rdhwr	\$0,\$28
[0-9a-f]+ <[^>]+> 201d 01c0 	rdhwr	\$0,\$29
[0-9a-f]+ <[^>]+> 201e 01c0 	rdhwr	\$0,\$30
[0-9a-f]+ <[^>]+> 201f 01c0 	rdhwr	\$0,\$31
[0-9a-f]+ <[^>]+> 2004 01c0 	rdhwr	\$0,\$4
[0-9a-f]+ <[^>]+> 2004 09c0 	rdhwr	\$0,\$4,1
[0-9a-f]+ <[^>]+> 2004 11c0 	rdhwr	\$0,\$4,2
[0-9a-f]+ <[^>]+> 2004 19c0 	rdhwr	\$0,\$4,3
[0-9a-f]+ <[^>]+> 2004 21c0 	rdhwr	\$0,\$4,4
[0-9a-f]+ <[^>]+> 2004 29c0 	rdhwr	\$0,\$4,5
[0-9a-f]+ <[^>]+> 2004 31c0 	rdhwr	\$0,\$4,6
[0-9a-f]+ <[^>]+> 2004 39c0 	rdhwr	\$0,\$4,7
	\.\.\.
