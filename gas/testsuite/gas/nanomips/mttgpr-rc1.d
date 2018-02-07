#objdump: -dr --prefix-addresses --show-raw-insn -M cp0-names=32r6 -Mshow-mttgpr-rc1
#name: MTTGPR RC1 format check

# Check MTTGPR RC1 format

.*: +file format .*nanomips.*

Disassembly of section .text:
[0-9a-f]+ <.*> 23bc 0670 	mttgpr	gp,sp
[0-9a-f]+ <.*> 21ae 0670 	mttgpr	t2,t1
	\.\.\.