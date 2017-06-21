#objdump: -dr --prefix-addresses --show-raw-insn
#name: nanoMIPS abs
#source: abs.s

# Test the abs macro (nanoMIPS).

.*: +file format .*mips.*

Disassembly of section \.text:
0+0000 <foo> 8804 8000 	bgezc	a0,00000008 <.*>
			0: R_NANOMIPS_PC14_S1	.*
0+0004 <foo\+0x4> 2080 21d0 	negu	a0,a0
0+0008 <.L0> 1085      	move	a0,a1
0+000a <.L0\+0x2> 8805 8000 	bgezc	a1,00000014 <.*>
			a: R_NANOMIPS_PC14_S1	.*
0+000e <.L0\+0x6> 20a0 21d0 	negu	a0,a1
0+0012 <.L0\+0xa> 9008      	nop
	\.\.\.
