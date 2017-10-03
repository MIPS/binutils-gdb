	.text
test8:
	la $4, %hi(test8)
	lw $4, %hi(test8)($3)
	bbeqzc $r4,24,test
	bbeqzc $r4,1,test
	bbeqzc $r4,31,test
	bbnezc $r4,0,test
	bbnezc $r4,16,test
	bbeqzc $r4,34,test
	bbeqzc $r4,41,test
	bbnezc $r4,61,test

        ll $r8, 255($r9)
        sc $r8, 255($r9)
        lle $r8, 255($r9)
        sce $r8, 255($r9)
	
        ll $r8, -252($r9)
        sc $r8, -252($r9)
        lle $r8, -252($r9)
        sce $r8, -256($r9)
	

	la $r1, test8
$L24:
$LBE19 = .
$LBE18 = .
	addiu	$a5,$a5,1
$LVL51 = .
$LBB22 = .
$LBB20 = .
	lw	$a0,32($sp)
$LVL52 = .
$LBE20 = .
$LBE22 = .
	bneic	$a5,25,$L25
	restore.jrc	160,$ra,$s0
$LVL53 = .
$L39:
$LBB23 = .
$LBB21 = .
	move	$a0,$a6
$LVL54 = .
$L19:
	sw	$a3,32($a0)
	bc	$L24
$L2:
	nop
