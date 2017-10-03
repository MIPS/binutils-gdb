.globl end
test:
	.reloc 1f, R_NANOMIPS_JALR32, end
	bc test
1:	jalrc	$24
	nop32
end:
	nop
