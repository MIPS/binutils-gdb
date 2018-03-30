#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS li

# Test the li macro (nanoMIPS).

.*: +file format .*nanomips.*

Disassembly of section \.text:
0+0000 <foo> d200      	li	a0,0
0+0002 <foo\+0x2> d201      	li	a0,1
0+0004 <foo\+0x4> 0080 8000 	li	a0,32768
0+0008 <foo\+0x8> e09f 8ffd 	lui	a0,%hi\(0xffff8000\)
0+000c <foo\+0xc> e081 0000 	lui	a0,%hi\(0x10000\)
0+0010 <foo\+0x10> e081 a000 	lui	a0,%hi\(0x1a000\)
0+0014 <foo\+0x14> 8084 05a5 	ori	a0,a0,0x5a5
#pass
