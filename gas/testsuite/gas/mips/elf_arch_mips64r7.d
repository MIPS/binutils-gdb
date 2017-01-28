# name: ELF MIPS64r7 markings
# source: empty.s
# objdump: -p
# as: -p32 -march=mips64r7 -mmicromips

.*:.*file format.*elf.*mips.*
private flags = c.......: .*\[mips64r7\].*

MIPS ABI Flags Version: 0

ISA: MIPS64r7
GPR size: 32
CPR1 size: 64
CPR2 size: 0
FP ABI: Hard float \(32-bit CPU, 64-bit FPU\)
ISA Extension: None
ASEs:
	XLP ASE
FLAGS 1: 0000000.
FLAGS 2: 00000000
