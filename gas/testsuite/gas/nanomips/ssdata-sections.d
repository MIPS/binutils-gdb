#objdump: -dr --show-raw-insn
#name: Macro expansions for special small data sections

# Check macro expansions for ssdata and ssbss sections

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <test>:
   0:	40a0 0000 	addiu	a1,gp,0
			0: R_NANOMIPS_GPREL19_S2	\.sbss
   4:	40a0 0000 	addiu	a1,gp,0
			4: R_NANOMIPS_GPREL19_S2	\.sdata
   8:	44ac 0000 	addiu	a1,gp,0
			8: R_NANOMIPS_GPREL18	\.ssbss
   c:	44ac 0000 	addiu	a1,gp,0
			c: R_NANOMIPS_GPREL18	\.ssdata
  10:	44ac 0000 	addiu	a1,gp,0
			10: R_NANOMIPS_GPREL18	\.ssbss\+0x2
  14:	44ac 0000 	addiu	a1,gp,0
			14: R_NANOMIPS_GPREL18	\.ssdata\+0x2
  18:	40a0 0002 	lw	a1,0\(gp\)
			18: R_NANOMIPS_GPREL19_S2	\.sbss
  1c:	40a0 0002 	lw	a1,0\(gp\)
			1c: R_NANOMIPS_GPREL19_S2	\.sdata
  20:	44b0 0000 	lh	a1,0\(gp\)
			20: R_NANOMIPS_GPREL17_S1	\.ssbss
  24:	44b0 0000 	lh	a1,0\(gp\)
			24: R_NANOMIPS_GPREL17_S1	\.ssdata
  28:	44a0 0000 	lb	a1,0\(gp\)
			28: R_NANOMIPS_GPREL18	\.ssbss\+0x2
  2c:	44a0 0000 	lb	a1,0\(gp\)
			2c: R_NANOMIPS_GPREL18	\.ssdata\+0x2
