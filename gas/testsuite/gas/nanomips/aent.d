#objdump: -dr --prefix-addresses
#name: nanoMIPS .aent directive

# Test the .aent directive retains function symbol type annotation.

.*: +file format .*nanomips.*

Disassembly of section \.text:
0+0000 <foo> sllv	t4,a0,a2
0+0004 <foo\+0x4> srav	a4,a6,t0
0+0008 <bar> sllv	t4,a0,a2
0+000c <bar\+0x4> srav	a4,a6,t0
	\.\.\.
