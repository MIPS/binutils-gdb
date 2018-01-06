#name: nanoMIPS TLB instructions with VZ disabled
#source: tlbg.s
#as: -mno-virt -mtlb
#error-output: tlbg-error-isa.l
