	.text
foo:
	mfgc0   $3,$29
	mfgc0   $11,$20,5
	mtgc0   $23,$2
	mtgc0   $7,$14,2

	hypcall
	hypcall 0x1
	hypcall 0x256

	tlbginv
	tlbginvf
	tlbgp
	tlbgr
	tlbgwi
	tlbgwr
