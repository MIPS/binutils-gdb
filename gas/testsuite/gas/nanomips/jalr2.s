	.ent	test
test:
	jal	local
	jal	local+12
	jal	global
	jal	global+12
	.end	test

local:
	nop
	nop
	nop
	nop
