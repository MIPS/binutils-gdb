#objdump: -dr
#name: nanoMIPS TLB instructions

# Check nanoMIPS TLB instructions

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <test>:
   0:	2000 057f 	tlbginv
   4:	2000 157f 	tlbginvf
   8:	2000 017f 	tlbgp
   c:	2000 117f 	tlbgr
  10:	2000 217f 	tlbgwi
  14:	2000 317f 	tlbgwr
#pass
