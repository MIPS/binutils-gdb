#objdump: -dr --show-raw-insn
#name: nanoMIPS ISA instructions expanded to macros for NMS

.*: +file format .*nanomips.*

Disassembly of section .text:
00000000 <test>:
   0:	8043 c011 	sll	t4,t5,17
   4:	8042 c056 	srl	t4,t4,22
   8:	8043 c001 	sll	t4,t5,1
   c:	8042 c041 	srl	t4,t4,1
  10:	8043 c05f 	srl	t4,t5,31
  14:	83fe c05f 	srl	ra,fp,31
  18:	2042 115f 	extw	t4,t4,t4,5
  1c:	2062 13df 	extw	t4,t4,t5,15
  20:	2042 131f 	extw	t4,t4,t4,12
  24:	2042 141f 	extw	t4,t4,t4,16
  28:	2062 141f 	extw	t4,t4,t5,16
  2c:	1043      	move	t4,t5
  2e:	2062 17df 	extw	t4,t4,t5,31
  32:	2042 105f 	extw	t4,t4,t4,1
  36:	2042 17df 	extw	t4,t4,t4,31
  3a:	2062 105f 	extw	t4,t4,t5,1
  3e:	2042 105f 	extw	t4,t4,t4,1
  42:	2062 17df 	extw	t4,t4,t5,31
  46:	2063 095f 	extw	at,t5,t5,5
  4a:	2061 1bdf 	extw	t5,at,t5,15
  4e:	2063 1b1f 	extw	t5,t5,t5,12
  52:	2063 0c1f 	extw	at,t5,t5,16
  56:	2061 1c1f 	extw	t5,at,t5,16
  5a:	9008      	nop
  5c:	9008      	nop
  5e:	2063 0fdf 	extw	at,t5,t5,31
  62:	2061 185f 	extw	t5,at,t5,1
  66:	2063 085f 	extw	at,t5,t5,1
  6a:	2061 1fdf 	extw	t5,at,t5,31
  6e:	9008      	nop
	\.\.\.
