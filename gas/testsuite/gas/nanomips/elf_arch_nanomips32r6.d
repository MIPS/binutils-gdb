# name: ELF nanoMIPS markings
# source: empty.s
# objdump: -p

.*:.*file format.*elf.*mips.*
private flags = b.......: .*\[nanomips32r6\].*

nanoMIPS ABI Flags Version: 0

ISA: nanoMIPS32r6
GPR size: 32
CPR1 size: 64
CPR2 size: 0
FP ABI: Hard float \(32-bit CPU, 64-bit FPU\)
ISA Extension: None
ASEs:
	TLB ASE
FLAGS 1: 0000000.
FLAGS 2: 00000000

