# name: ELF MIPS32r7 markings
# source: empty.s
# objdump: -p
# as: -march=i7001 -mmicromips

.*:.*file format.*elf.*mips.*
private flags = b.......: .*\[mips32r7\].*

MIPS ABI Flags Version: 0

ISA: MIPS32r7
GPR size: 32
CPR1 size: 64
CPR2 size: 0
FP ABI: Hard float \(32-bit CPU, 64-bit FPU\)
ISA Extension: None
ASEs:
	XLP ASE
	TLB ASE
FLAGS 1: 0000000.
FLAGS 2: 00000000

