#objdump: -dr --prefix-addresses --show-raw-insn -mmips:isa32r6
#name: MIPS branch local symbol relocation 3 (ignore branch ISA, n32)
#as: -n32 -march=from-abi -mignore-branch-isa
#source: branch-local-3.s

.*: +file format .*mips.*

Disassembly of section \.text:
	\.\.\.
[0-9a-f]+ <[^>]*> 001f 0f3c 	jrc	ra
[0-9a-f]+ <[^>]*> c8000000 	bc	00001008 <bar\+0x4>
[ 	]*[0-9a-f]+: R_MIPS_PC26_S2	foo-0x4
[0-9a-f]+ <[^>]*> d8400000 	beqzc	v0,0000100c <bar\+0x8>
[ 	]*[0-9a-f]+: R_MIPS_PC21_S2	foo-0x4
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> d81f0000 	jrc	ra
	\.\.\.
