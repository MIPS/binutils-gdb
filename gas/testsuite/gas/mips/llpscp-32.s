	.text
test:
	llwp $2, $3, $4  /* No macro expansion needed */
	llwp $2, $3, 0($4)
	llwp $2, $0, 0x1234($4)
	llwp $0, $3, %hi(sync_mem)($4)
	llwp $2, $3, %lo(sync_mem)($2)
	llwp $2, $3, 0xffffffff01234567($3)
	llwp $0, $0, sync_mem($4)

	llwpe $2, $3, 0x1234
	llwpe $2, $0, 0xabcd($0)
	llwpe $0, $3, %lo(sync_mem)
	llwpe $2, $2, 0xffffffff01234567($0)
	llwpe $0, $0, sync_mem

	scwp $2, $3, $4  /* No macro expansion needed */
	scwp $2, $3, 0($4)
	scwp $2, $0, 0x1234($4)
	scwp $0, $3, %hi(sync_mem)($4)
	scwp $2, $3, %lo(sync_mem)($2)
	scwp $2, $3, 0xffffffff01234567($3)
	scwp $0, $0, sync_mem($4)

	scwpe $2, $3, 0x1234
	scwpe $2, $0, 0xabcd($0)
	scwpe $0, $3, %lo(sync_mem)
	scwpe $2, $2, 0xffffffff01234567($0)
	scwpe $0, $0, sync_mem

	.space 8

	.data
sync_mem:
	.word
	.word

	.space 8
