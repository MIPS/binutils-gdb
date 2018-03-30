/* Test sync aliases  */
	.text
	.ent test
test:
	sync
	sync_wmb
	sync_mb
	sync_acquire
	sync_release
	sync_rmb
	.set ginv
	sync_ginv
	.end test
