	.ent	func
func:
	la	$4,%lo(foo)
	.ifndef nanomips_broken
	la	$4,%hi(foo)
	.endif
	la	$4,%lo(0x12348765)
	.ifndef nanomips_broken
	la	$4,%hi(0x12348765)
	.endif
	la	$4,%lo(0x12348765)($5)
	.ifndef nanomips_broken
	la	$4,%hi(0x12348765)($5)
	.endif
	.end	func
