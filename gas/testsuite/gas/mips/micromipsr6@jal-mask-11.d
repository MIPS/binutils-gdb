#objdump: -dr --prefix-addresses --show-raw-insn --adjust-vma=0x55555550
#name: MIPS jal mask 1.1
#as: -32
#source: jal-mask-1.s

# Check address masks for JAL/J instructions.

.*: +file format .*mips.*

Disassembly of section \.text:
55555550 <[^>]*> 9400 0000 	bc	55555554 <[^>]*>
			55555550: R_MICROMIPS_PC26_S1	\*ABS\*
55555554 <[^>]*> 9555 5556 	bc	58000004 <[^>]*>
			55555554: R_MICROMIPS_PC26_S1	\*ABS\*
55555558 <[^>]*> b400 0000 	balc	5555555c <[^>]*>
			55555558: R_MICROMIPS_PC26_S1	\*ABS\*
5555555c <[^>]*> b555 5556 	balc	5800000c <[^>]*>
			5555555c: R_MICROMIPS_PC26_S1	\*ABS\*
	\.\.\.
