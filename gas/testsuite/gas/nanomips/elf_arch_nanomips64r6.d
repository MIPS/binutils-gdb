# name: ELF nanoMIPS64 markings
# source: empty.s
# objdump: -p

.*:.*file format.*elf.*nanomips.*
private flags = 1.......: .*\[nanomips64r6\].*

nanoMIPS ABI Flags Version: 0

ISA: nanoMIPS64r6
GPR size: 32
CPR1 size: 64
CPR2 size: 0
FP ABI: Hard float \(double precision\)
ISA Extension: None
ASEs:
	TLB ASE
FLAGS 1: 0000000.
FLAGS 2: 00000000
