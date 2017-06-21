#objdump: -dr
#name: nanoMIPS TLB instructions

# Check nanoMIPS TLB instructions

.*: +file format .*mips.*

Disassembly of section \.text:

00000000 <test>:
   0:	2000 077f 	tlbinv
   4:	2000 177f 	tlbinvf
   8:	2000 037f 	tlbp
   c:	2000 137f 	tlbr
  10:	2000 237f 	tlbwi
  14:	2000 337f 	tlbwr
