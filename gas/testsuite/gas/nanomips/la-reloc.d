#objdump: -dr --prefix-addresses --show-raw-insn
#name: LA with relocation operators for nanoMIPS
#source: la-reloc.s

.*file format.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> 0080 0000 	li	a0,0
			[0-9A-F]+: R_NANOMIPS_LO12	foo
#[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
#			[0-9A-F]+: R_NANOMIPS_HI20	foo
[0-9a-f]+ <[^>]+> 0080 0765 	li	a0,1893
#[0-9a-f]+ <[^>]+> e094 8244 	lui	a0,%hi\(0x12348000\)
[0-9a-f]+ <[^>]+> 0085 0765 	addiu	a0,a1,1893
#[0-9a-f]+ <[^>]+> e094 8244 	lui	a0,%hi\(0x12348000\)
#[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
