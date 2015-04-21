#objdump: -dr --prefix-addresses --show-raw-insn --adjust-vma=0xaaaaaaa0
#name: MIPS jal mask 1.2
#as: -32
#source: jal-mask-1.s

# Check address masks for JAL/J instructions.

.*: +file format .*mips.*

Disassembly of section \.text:
aaaaaaa0 <[^>]*> 9400 0000 	bc	aaaaaaa4 <[^>]*>
			aaaaaaa0: R_MICROMIPS_PC26_S1	\*ABS\*
aaaaaaa4 <[^>]*> 9555 5556 	bc	ad555554 <[^>]*>
			aaaaaaa4: R_MICROMIPS_PC26_S1	\*ABS\*
aaaaaaa8 <[^>]*> b400 0000 	balc	aaaaaaac <[^>]*>
			aaaaaaa8: R_MICROMIPS_PC26_S1	\*ABS\*
aaaaaaac <[^>]*> b555 5556 	balc	ad55555c <[^>]*>
			aaaaaaac: R_MICROMIPS_PC26_S1	\*ABS\*
	\.\.\.
