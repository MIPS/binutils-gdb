#objdump: -dr --prefix-addresses --show-raw-insn -mmips:isa32r6
#name: MIPS branch local symbol relocation 3 (ignore branch ISA)
#as: -32 -mignore-branch-isa
#source: branch-local-3.s

.*: +file format .*mips.*

Disassembly of section \.text:
	\.\.\.
[0-9a-f]+ <[^>]*> 001f 0f3c 	jrc	ra
[0-9a-f]+ <[^>]*> cbffffff 	bc	00001004 <bar>
[ 	]*[0-9a-f]+: R_MIPS_PC26_S2	foo
[0-9a-f]+ <[^>]*> d85fffff 	beqzc	v0,00001008 <bar\+0x4>
[ 	]*[0-9a-f]+: R_MIPS_PC21_S2	foo
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> d81f0000 	jrc	ra
	\.\.\.
