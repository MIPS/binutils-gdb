#source: abiflags-fake.s
#objcopy_objects: -R .MIPS.abiflags
#ld: -T abiflags-fake.ld -e 0
#objcopy_linked_file: --rename-section .rename.me=.MIPS.abiflags
#objdump: -p

#...
