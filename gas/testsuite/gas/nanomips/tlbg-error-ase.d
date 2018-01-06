#name: nanoMIPS TLB instructions with TLB disabled
#source: tlbg.s
#as: -mvirt -mno-tlb
#error-output: tlbg-error-ase.l
