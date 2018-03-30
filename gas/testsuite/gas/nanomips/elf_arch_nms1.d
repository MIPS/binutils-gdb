# name: ELF nanoMIPS subset markings
# source: empty.s
# objdump: -p

.*:.*file format.*elf.*nanomips.*
private flags = 0.......: .*\[nanomips32r6\].*

nanoMIPS ABI Flags Version: 0

ISA: nanoMIPS32r6
GPR size: 32
CPR1 size: 64
CPR2 size: 0
FP ABI: Hard float \(double precision\)
ISA Extension: None
ASEs:
	nanoMIPS subset
FLAGS 1: 0000000.
FLAGS 2: 00000000
