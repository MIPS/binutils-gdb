#name: SFrame generation on s390x - .cfi_offset and .cfi_def_cfa_{offset,register}
#objdump: --sframe=.sframe
#...
Contents of the SFrame section .sframe:

  Header :

    Version: SFRAME_VERSION_2
    Flags: SFRAME_F_FDE_FUNC_START_PCREL
    Num FDEs: 1
    Num FREs: 6

  Function Index :

    func idx \[0\]: pc = 0x0, size = 40 bytes
    STARTPC +CFA +FP +RA +
    0+0000 +sp\+160 +u +u +
    0+0006 +sp\+160 +c\-72 +c\-48 +
    0+000c +sp\+320 +c\-72 +c\-48 +
    0+0010 +fp\+320 +c\-72 +c\-48 +
    0+001c +sp\+160 +u +u +
    0+001e +fp\+320 +c\-72 +c\-48 +
#pass
