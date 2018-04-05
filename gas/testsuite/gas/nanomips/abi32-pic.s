	.sdata
shared:
	.word	11

	.data
unshared:
	.word	1
	.word	2
	.word	3
	.word	4

	.text
	.ent	func
func:
	.cpsetup $25
	li	$4, 0x12345678
	la	$4, shared
	la	$4, unshared
	la	$4, end
	j	end
	jal	end
	lw	$4, shared
	lw	$4, unshared
	lw	$4, end
	ld	$4, shared
	ld	$4, unshared
	ld	$4, end
	sw	$4, shared
	sw	$4, unshared
	sd	$4, shared
	sd	$4, unshared
	li.d	$4, 1.0
	li.d	$4, 1.9
	li.d	$f0, 1.0
	li.d	$f0, 1.9
	seq	$4, $5, -100
	sne	$4, $5, -100
	move	$4, $5
	.end	func
end:
