#name: nanoMIPS relax ADDIU limited insn32
#objdump: -dr
#as: -minsn32 --defsym insn32=
#source: relax-addiu.s

# Test ADDIU relaxation on nanoMIPS limited to 32-bit fixed instruction mode

.*: +file format .*nanomips.*

Disassembly of section \.text:

[0-9a-f]+ <[^>]+>:
   0:	8000 c000 	nop
   4:	8000 c000 	nop
   8:	8000 c000 	nop
	\.\.\.
  20:	8000 c000 	nop
  24:	03ff 0009 	addiu	ra,ra,9
  28:	8042 800c 	addiu	t4,t4,-12
  2c:	0085 000c 	addiu	a0,a1,12
  30:	0085 0020 	addiu	a0,a1,32
  34:	03e2 0009 	addiu	ra,t4,9
  38:	8043 800c 	addiu	t4,t5,-12
  3c:	0088 000c 	addiu	a0,a4,12
  40:	0082 0020 	addiu	a0,t4,32
  44:	03ff 000c 	addiu	ra,ra,12
  48:	8042 8010 	addiu	t4,t4,-16
  4c:	8085 800c 	addiu	a0,a1,-12
  50:	0085 0024 	addiu	a0,a1,36
  54:	0085 0008 	addiu	a0,a1,8
  58:	03ff 0009 	addiu	ra,ra,9
  5c:	8042 800c 	addiu	t4,t4,-12
  60:	0085 000c 	addiu	a0,a1,12
  64:	0085 0020 	addiu	a0,a1,32
  68:	03e2 0009 	addiu	ra,t4,9
  6c:	8043 800c 	addiu	t4,t5,-12
  70:	0088 000c 	addiu	a0,a4,12
  74:	0082 0020 	addiu	a0,t4,32
  78:	03ff 000c 	addiu	ra,ra,12
  7c:	8042 8010 	addiu	t4,t4,-16
  80:	8085 800c 	addiu	a0,a1,-12
  84:	0085 0024 	addiu	a0,a1,36
  88:	0085 0008 	addiu	a0,a1,8
  8c:	03ff 0009 	addiu	ra,ra,9
  90:	8042 800c 	addiu	t4,t4,-12
  94:	0085 000c 	addiu	a0,a1,12
  98:	0085 0020 	addiu	a0,a1,32
  9c:	03ff 0009 	addiu	ra,ra,9
  a0:	8042 800c 	addiu	t4,t4,-12
  a4:	0085 000c 	addiu	a0,a1,12
  a8:	0085 0020 	addiu	a0,a1,32
  ac:	8080 8001 	li	a0,-1
  b0:	0080 0020 	li	a0,32
  b4:	8060 8001 	li	t5,-1
  b8:	0060 0020 	li	t5,32
  bc:	8080 800c 	li	a0,-12
  c0:	0080 007f 	li	a0,127
  c4:	8080 8001 	li	a0,-1
  c8:	0080 0020 	li	a0,32
  cc:	8080 8001 	li	a0,-1
  d0:	0080 0020 	li	a0,32
  d4:	8000 c000 	nop
  d8:	8000 c000 	nop
  dc:	8000 c000 	nop
	\.\.\.
  f4:	8000 c000 	nop
	\.\.\.
 178:	8000 c000 	nop
#pass
