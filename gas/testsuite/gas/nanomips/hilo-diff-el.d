#objdump: -dr
#name: nanoMIPS hilo-diff p32/EL
#as: -EL
#source: hilo-diff.s

.*file format .*nanomips.*

Disassembly of section \.text:

00000000 <foo>:
       0:	e080 7000 	lui	a0,%hi\(0x7000\)
       4:	0084 0ffc 	addiu	a0,a0,4092
       8:	0080 7ffc 	li	a0,32764
       c:	e0bf 7ffd 	lui	a1,%hi\(0xffff7000\)
      10:	00a5 0ffe 	addiu	a1,a1,4094
      14:	60a0 7ffe 	li	a1,0xffff7ffe
      18:	ffff.
      1a:	e080 7000 	lui	a0,%hi\(0x7000\)
      1e:	0084 0ffc 	addiu	a0,a0,4092
      22:	0080 7ffc 	li	a0,32764
      26:	e0bf 7ffd 	lui	a1,%hi\(0xffff7000\)
      2a:	00a5 0ffe 	addiu	a1,a1,4094
      2e:	60a0 7ffe 	li	a1,0xffff7ffe
      32:	ffff.
	\.\.\.
    801c:	e080 7000 	lui	a0,%hi\(0x7000\)
    8020:	0084 0ffc 	addiu	a0,a0,4092
    8024:	0080 7ffc 	li	a0,32764
    8028:	e0bf 7ffd 	lui	a1,%hi\(0xffff7000\)
    802c:	00a5 0ffe 	addiu	a1,a1,4094
    8030:	60a0 7ffe 	li	a1,0xffff7ffe
    8034:	ffff.
    8036:	e080 8000 	lui	a0,%hi\(0x8000\)
    803a:	0084 0000 	addiu	a0,a0,0
    803e:	0080 8000 	li	a0,32768
    8042:	e0bf 7ffd 	lui	a1,%hi\(0xffff7000\)
    8046:	00a5 0ffe 	addiu	a1,a1,4094
    804a:	60a0 7ffe 	li	a1,0xffff7ffe
    804e:	ffff.
    8050:	e080 8000 	lui	a0,%hi\(0x8000\)
    8054:	0084 0000 	addiu	a0,a0,0
    8058:	0080 8000 	li	a0,32768
    805c:	e0bf 7ffd 	lui	a1,%hi\(0xffff7000\)
    8060:	00a5 0ffe 	addiu	a1,a1,4094
    8064:	60a0 7ffe 	li	a1,0xffff7ffe
    8068:	ffff.
	\.\.\.
   10052:	e080 8000 	lui	a0,%hi\(0x8000\)
   10056:	0084 0000 	addiu	a0,a0,0
   1005a:	0080 8000 	li	a0,32768
   1005e:	e0bf 7ffd 	lui	a1,%hi\(0xffff7000\)
   10062:	00a5 0ffe 	addiu	a1,a1,4094
   10066:	60a0 7ffe 	li	a1,0xffff7ffe
   1006a:	ffff.
   1006c:	e091 f000 	lui	a0,%hi\(0x11f000\)
   10070:	0084 0fdc 	addiu	a0,a0,4060
   10074:	6080 ffdc 	li	a0,0x11ffdc
   10078:	0011.
   1007a:	e0ae 0ffd 	lui	a1,%hi\(0xffee0000\)
   1007e:	00a5 0024 	addiu	a1,a1,36
   10082:	60a0 0024 	li	a1,0xffee0024
   10086:	ffee.
   10088:	e091 f000 	lui	a0,%hi\(0x11f000\)
   1008c:	0084 0fdc 	addiu	a0,a0,4060
   10090:	6080 ffdc 	li	a0,0x11ffdc
   10094:	0011.
   10096:	e0ae 0ffd 	lui	a1,%hi\(0xffee0000\)
   1009a:	00a5 0024 	addiu	a1,a1,36
   1009e:	60a0 0024 	li	a1,0xffee0024
   100a2:	ffee.
	\.\.\.
  130064:	e091 f000 	lui	a0,%hi\(0x11f000\)
  130068:	0084 0fdc 	addiu	a0,a0,4060
  13006c:	6080 ffdc 	li	a0,0x11ffdc
  130070:	0011.
  130072:	e0ae 0ffd 	lui	a1,%hi\(0xffee0000\)
  130076:	00a5 0024 	addiu	a1,a1,36
  13007a:	60a0 0024 	li	a1,0xffee0024
  13007e:	ffee.
#pass
