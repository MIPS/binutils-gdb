        .text
        .set reorder
        .set micromips
foo:
        maddf.s     $f0,$f1,$f2
        maddf.d     $f3,$f4,$f5
        msubf.s     $f6,$f7,$f8
        msubf.d     $f9,$f10,$f11

        cmp.af.s    $f0,$f1,$f2
        cmp.af.d    $f0,$f1,$f2
        cmp.un.s    $f0,$f1,$f2
        cmp.un.d    $f0,$f1,$f2
        cmp.eq.s    $f0,$f1,$f2
        cmp.eq.d    $f0,$f1,$f2
        cmp.ueq.s   $f0,$f1,$f2
        cmp.ueq.d   $f0,$f1,$f2
        cmp.lt.s    $f0,$f1,$f2
        cmp.lt.d    $f0,$f1,$f2
        cmp.ult.s   $f0,$f1,$f2
        cmp.ult.d   $f0,$f1,$f2
        cmp.le.s    $f0,$f1,$f2
        cmp.le.d    $f0,$f1,$f2
        cmp.ule.s   $f0,$f1,$f2
        cmp.ule.d   $f0,$f1,$f2
        cmp.saf.s   $f0,$f1,$f2
        cmp.saf.d   $f0,$f1,$f2
        cmp.sun.s   $f0,$f1,$f2
        cmp.sun.d   $f0,$f1,$f2
        cmp.seq.s   $f0,$f1,$f2
        cmp.seq.d   $f0,$f1,$f2
        cmp.sueq.s  $f0,$f1,$f2
        cmp.sueq.d  $f0,$f1,$f2
        cmp.slt.s   $f0,$f1,$f2
        cmp.slt.d   $f0,$f1,$f2
        cmp.sult.s  $f0,$f1,$f2
        cmp.sult.d  $f0,$f1,$f2
        cmp.sle.s   $f0,$f1,$f2
        cmp.sle.d   $f0,$f1,$f2
        cmp.sule.s  $f0,$f1,$f2
        cmp.sule.d  $f0,$f1,$f2
        cmp.or.s    $f0,$f1,$f2
        cmp.or.d    $f0,$f1,$f2
        cmp.une.s   $f0,$f1,$f2
        cmp.une.d   $f0,$f1,$f2
        cmp.ne.s    $f0,$f1,$f2
        cmp.ne.d    $f0,$f1,$f2
        cmp.sor.s   $f0,$f1,$f2
        cmp.sor.d   $f0,$f1,$f2
        cmp.sune.s  $f0,$f1,$f2
        cmp.sune.d  $f0,$f1,$f2
        cmp.sne.s   $f0,$f1,$f2
        cmp.sne.d   $f0,$f1,$f2

        bc1eqzc    $f0,1f
        bc1eqzc    $f31,1f
        bc1eqzc    $f31,new
        bc1eqzc    $f31,external_label
        bc1nezc    $f0,1f
        bc1nezc    $f31,1f
        bc1nezc    $f31,new
        bc1nezc    $f31,external_label
        bc2eqzc    $0,1f
        bc2eqzc    $31,1f
        bc2eqzc    $31,new
        bc2eqzc    $31,external_label
        bc2nezc    $0,1f
        bc2nezc    $31,1f
        bc2nezc    $31,new
        bc2nezc    $31,external_label
        sel.s      $f0,$f1,$f2
        sel.d      $f0,$f1,$f2
        seleqz.s   $f0,$f1,$f2
        seleqz.d   $f0,$f1,$f2
        selnez.s   $f0,$f1,$f2
        selnez.d   $f0,$f1,$f2
        seleqz     $2,$3,$4
        selnez     $2,$3,$4
        mul        $2,$3,$4
        muh        $2,$3,$4
        mulu       $2,$3,$4
        muhu       $2,$3,$4
        div        $2,$3,$4
        mod        $2,$3,$4
        divu       $2,$3,$4
        modu       $2,$3,$4
        lsa        $2,$3,$4,1
        lsa        $2,$3,$4,4

        align    $4, $2, $3, 0
        align    $4, $2, $3, 1
        align    $4, $2, $3, 2
        align    $4, $2, $3, 3

        bitswap  $4, $2

        bovc     $0, $0, ext
        bovc     $2, $0, ext
        bovc     $0, $2, ext
        bovc     $2, $4, ext
        bovc     $4, $2, ext
        bovc     $2, $4, . + 4 + (-32768 << 1)
        bovc     $2, $4, . + 4 + (32767 << 1)
        bovc     $2, $4, 1f
        bovc     $2, $2, ext
        bovc     $2, $2, . + 4 + (-32768 << 1)
        beqzalc  $2, ext
        beqzalc  $2, . + 4 + (-32768 << 1)
        beqzalc  $2, . + 4 + (32767 << 1)
        beqzalc  $2, 1f
        beqc     $3, $2, ext
        beqc     $2, $3, ext
        beqc     $3, $2, . + 4 + (-32768 << 1)
        beqc     $3, $2, . + 4 + (32767 << 1)
        beqc     $3, $2, 1f

        bnvc     $0, $0, ext
        bnvc     $2, $0, ext
        bnvc     $0, $2, ext
        bnvc     $2, $4, ext
        bnvc     $4, $2, ext
        bnvc     $2, $4, . + 4 + (-32768 << 1)
        bnvc     $2, $4, . + 4 + (32767 << 1)
        bnvc     $2, $4, 1f
        bnvc     $2, $2, ext
        bnvc     $2, $2, . + 4 + (-32768 << 1)
        bnezalc  $2, ext
        bnezalc  $2, . + 4 + (-32768 << 1)
        bnezalc  $2, . + 4 + (32767 << 1)
        bnezalc  $2, 1f
        bnec     $3, $2, ext
        bnec     $2, $3, ext
        bnec     $3, $2, . + 4 + (-32768 << 1)
        bnec     $3, $2, . + 4 + (32767 << 1)
        bnec     $3, $2, 1f

        blezc    $2, ext
        blezc    $2, . + 4 + (-32768 << 1)
        blezc    $2, . + 4 + (32767 << 1)
        blezc    $2, 1f
        bgezc    $2, ext
        bgezc    $2, . + 4 + (-32768 << 1)
        bgezc    $2, . + 4 + (32767 << 1)
        bgezc    $2, f
        bgec     $2, $3, ext
        bgec     $2, $3, . + 4 + (-32768 << 1)
        bgec     $2, $3, . + 4 + (32767 << 1)
        bgec     $2, $3, 1f
        bgec     $3, $2, 1f

        bgtzc    $2, ext
        bgtzc    $2, . + 4 + (-32768 << 1)
        bgtzc    $2, . + 4 + (32767 << 1)
        bgtzc    $2, 1f
        bltzc    $2, ext
        bltzc    $2, . + 4 + (-32768 << 1)
        bltzc    $2, . + 4 + (32767 << 1)
        bltzc    $2, 1f
        bltc     $2, $3, ext
        bltc     $2, $3, . + 4 + (-32768 << 1)
        bltc     $2, $3, . + 4 + (32767 << 1)
        bltc     $2, $3, 1f
        bltc     $3, $2, 1f

        blezalc  $2, ext
        blezalc  $2, . + 4 + (-32768 << 1)
        blezalc  $2, . + 4 + (32767 << 1)
        blezalc  $2, 1f
        bgezalc  $2, ext
        bgezalc  $2, . + 4 + (-32768 << 1)
        bgezalc  $2, . + 4 + (32767 << 1)
        bgezalc  $2, 1f
        bgeuc    $2, $3, ext
        bgeuc    $2, $3, . + 4 + (-32768 << 1)
        bgeuc    $2, $3, . + 4 + (32767 << 1)
        bgeuc    $2, $3, 1f
        bgeuc    $3, $2, 1f

        bgtzalc  $2, ext
        bgtzalc  $2, . + 4 + (-32768 << 1)
        bgtzalc  $2, . + 4 + (32767 << 1)
        bgtzalc  $2, 1f
        bltzalc  $2, ext
        bltzalc  $2, . + 4 + (-32768 << 1)
        bltzalc  $2, . + 4 + (32767 << 1)
        bltzalc  $2, 1f
        bltuc    $2, $3, ext
        bltuc    $2, $3, . + 4 + (-32768 << 1)
        bltuc    $2, $3, . + 4 + (32767 << 1)
        bltuc    $2, $3, 1f
        bltuc    $3, $2, 1f

        bc      ext
        bc      . + 4 + (-33554432 << 1)
        bc      . + 4 + (33554431 << 1)
        bc      1f
        balc    ext
        balc    . + 4 + (-33554432 << 1)
        balc    . + 4 + (33554431 << 1)
        balc    1f

        beqzc16 $2, . + 2 + (-64 << 1)
        beqzc16 $2, . + 2 + (63 << 1)

        beqzc   $2, ext
        beqzc   $2, . + 4 + (-1048576 << 1)
        beqzc   $2, . + 4 + (1048575 << 1)
        beqzc   $2, 1f
        jic     $3,-32768
        jic     $3,32767
        jrc     $31

        bnezc16   $2, . + 2 + (-64 << 1)
        bnezc16   $2, . + 2 + (63 << 1)

        bnezc   $2, ext
        bnezc   $2, . + 4 + (-1048576 << 1)
        bnezc   $2, . + 4 + (1048575 << 1)
        bnezc   $2, 1f
        jialc        $3,-32768
        jialc        $3,32767

        aui      $3, $2, 0xffff
	.align 2
2:
	.word 4
3:
        lapc     $4, 2b+(-4 << 2)
	nop16
        lapc     $4, 2b+(-4 << 2)
	b 3b
	
	.align 2
2:
        lapc     $4, 2b+(-262144 << 2)
2:
	nop16
        lapc     $4, 2b+(-262144 << 2)
	.align 2
2:
        lapc     $4, 2b+(262143 << 2)
2:
	nop16
        lapc     $4, 2b+(262143 << 2)
        addiupc  $4, (-262144 << 2)
        addiupc  $4, (262143 << 2)
        addiu    $8,$pc, (-262144 << 2)
        addiu    $8,$pc, (262143 << 2)
        auipc    $3, 0xffff
        aluipc   $3, 0xffff
        lwpc     $4, 1f
	.align 2
2:
        lwpc     $4, 2b+(-262144 << 2)
2:
	nop16
        lwpc     $4, 2b+(-262144 << 2)
	.align 2
2:
        lwpc     $4, 2b+(262143 << 2)
2:
	nop16
        lwpc     $4, 2b+(262143 << 2)
        lw       $4, (-262144 << 2)($pc)
        lw       $4, (262143 << 2)($pc)
        rint.s   $f2,$f3
        rint.d   $f2,$f3
        class.s  $f2,$f3
        class.d  $f2,$f3
        min.s    $f2,$f3,$f4
        min.d    $f2,$f3,$f4
        max.s    $f2,$f3,$f4
        max.d    $f2,$f3,$f4
        mina.s   $f2,$f3,$f4
        mina.d   $f2,$f3,$f4
        maxa.s   $f2,$f3,$f4
        maxa.d   $f2,$f3,$f4

        synci    0xffff
        lui      $2,0xffff
        not16    $2,$3
        xor16    $2,$3
        and16    $2,$3
        or16     $2,$3
        lwm      $s0,$ra, ($5)
        swm      $s0,$ra, ($5)
        jrc16    $3
        jalrc16  $2
        jrcaddiusp   4
        break16  10
        sdbbp16
        sdbbp16  0
        sdbbp16  1
        sdbbp16  15

        jrc.hb   $31
        jalrc.hb $31, $0
        jalrc.hb $0, $31
        jalrc.hb $2, $31
        jalrc.hb $0, $v0
        jrc.hb   $10

	.align 2
1:
        nop

	llwp	$5, $4, $6
	scwp	$5, $4, $6
	sc	$4, 0($5)
	b	1b
	sc	$4, 0($5)
	b	1b

	.set push
	.set eva
	llwpe	$5, $4, $6
	scwpe	$5, $4, $6
	sce	$4, 0($5)
	b	1b
	sce	$4, 0($5)
	b	1b
	.set pop

	rdhwr	$0, $4, 0
	rdhwr	$0, $4, 1
	rdhwr	$0, $4, 2
	rdhwr	$0, $4, 3
	rdhwr	$0, $4, 4
	rdhwr	$0, $4, 5
	rdhwr	$0, $4, 6
	rdhwr	$0, $4, 7

	sigrie	0
	sigrie	0xffff

	.align	2
	.space	8
