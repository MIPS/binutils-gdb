#name: nanoMIPS relax ADDIU 48-bits
#objdump: -dr

# Test ADDIU[48] relaxation on nanoMIPS

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <foo>:
	\.\.\.
   10004:	6081 fffc 	addiu	a0,a0,-65540
   10008:	fffe.
   1000a:	6081 0004 	addiu	a0,a0,65540
   1000e:	0001.
   10010:	6080 fffc 	li	a0,0xfffefffc
   10014:	fffe.
   10016:	6080 0004 	li	a0,0x10004
   1001a:	0001.
   1001c:	6081 fffc 	addiu	a0,a0,-65540
   10020:	fffe.
   10022:	6081 0004 	addiu	a0,a0,65540
   10026:	0001.
   10028:	6080 fffc 	li	a0,0xfffefffc
   1002c:	fffe.
   1002e:	6080 0004 	li	a0,0x10004
   10032:	0001.
#pass
