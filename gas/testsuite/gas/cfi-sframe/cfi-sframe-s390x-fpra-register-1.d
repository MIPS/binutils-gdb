#name: SFrame generation on s390x - RA and then FP saved in registers
#objdump: --sframe=.sframe
#...
Contents of the SFrame section .sframe:

  Header :

    Version: SFRAME_VERSION_2
    Flags: SFRAME_F_FDE_FUNC_START_PCREL
    Num FDEs: 1
    Num FREs: 5

  Function Index :

    func idx \[0\]: pc = 0x0, size = 26 bytes
    STARTPC +CFA +FP +RA +
    0+0000 +sp\+160 +u +u +
    0+0004 +sp\+160 +u +r16 +
    0+0008 +sp\+160 +r17 +r16 +
    0+0014 +sp\+160 +u +r16 +
    0+0018 +sp\+160 +u +u +
#pass
