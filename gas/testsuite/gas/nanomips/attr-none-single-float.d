#as: -msingle-float
#PROG: readelf
#source: empty.s
#readelf: -A
#name: MIPS infer fpabi (single-precision)

nanoMIPS ABI Flags Version: 0

ISA: nanoMIPS.*
GPR size: .*
CPR1 size: .*
CPR2 size: 0
FP ABI: Hard float \(single precision\)
ISA Extension: .*
ASEs:
#...
FLAGS 1: 0000000.
FLAGS 2: 00000000

