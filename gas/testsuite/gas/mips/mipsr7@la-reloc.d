#objdump: -dr --prefix-addresses --show-raw-insn
#name: LA with relocation operators for MIPS R7
#source: la-reloc.s
#as: -p32

.*file format.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]+> 0080 0000 	li	a0,0
			[0-9A-F]+: R_MICROMIPS_LO12	foo
#[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
#			[0-9A-F]+: R_MICROMIPS_HI20	foo
[0-9a-f]+ <[^>]+> 0080 0765 	li	a0,1893
#[0-9a-f]+ <[^>]+> e094 8244 	lui	a0,0x12348
[0-9a-f]+ <[^>]+> 0085 0000 	addiu	a0,a1,0
			[0-9A-F]+: R_MICROMIPS_LO12	foo
#[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
#			[0-9A-F]+: R_MICROMIPS_HI20	foo
#[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 0085 0765 	addiu	a0,a1,1893
#[0-9a-f]+ <[^>]+> e094 8244 	lui	a0,0x12348
#[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
[0-9a-f]+ <[^>]+> 0085 0000 	addiu	a0,a1,0
			[0-9A-F]+: R_MICROMIPS_LO12	foo\+0x12348765
#[0-9a-f]+ <[^>]+> e080 0000 	lui	a0,0x0
#			[0-9a-f]+: R_MICROMIPS_HI20	foo\+0x12348765
#[0-9a-f]+ <[^>]+> 20a4 2150 	addu	a0,a0,a1
