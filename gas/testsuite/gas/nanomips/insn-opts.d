#objdump: -dtz -j .text --prefix-addresses --show-raw-insn
#name: MIPS .insn default file options

# Check that .insn at the beginning of assembly sees default file options
# such as the ISA mode right.

.*: +file format .*nanomips.*

SYMBOL TABLE:
0+000000 l    d  \.text	0+000000 \.text
0+000000 g     F \.text	0+000004 foo
0+000004 g     F \.text	0+000004 bar
0+000008 g     O \.text	0+000004 baz

Disassembly of section \.text:
0+000000 <foo> 8000 c000 	nop
0+000004 <bar> 8000 c000 	nop
0+000008 <baz> .*
