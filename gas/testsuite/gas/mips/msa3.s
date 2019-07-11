	;;
	addwl_s.b	$w3, $w5, $w7
	addwl_s.h	$w0, $w1, $w2
	addwl_u.b	$w13, $w15, $w17
	addwl_u.h	$w10, $w11, $w12
	addwpl_s.b	$w3, $w5, $w7
	addwpl_s.h	$w0, $w1, $w2
	addwpl_u.b	$w13, $w15, $w17
	addwpl_u.h	$w10, $w11, $w12
	addwpr_s.b	$w23, $w25, $w27
	addwpr_s.h	$w10, $w11, $w12
	addwpr_u.b	$w2, $w4, $w31
	addwpr_u.h	$w17, $w18, $w19
	addwr_s.b	$w23, $w25, $w27
	addwr_s.h	$w10, $w11, $w12
	addwr_u.b	$w2, $w4, $w31
	addwr_u.h	$w17, $w18, $w19
	bsel		$w4, $w6, $w8, $w10
	dotp_us.d	$w6, $w7, $w29
	dotp_us.h	$w1, $w2, $w3
	dotp_us.w	$w4, $w5, $w6
	dotpo_s.b	$w7, $w8, $w9
	dotpo_u.b	$w10, $w11, $w12
	dotpo_us.b	$w13, $w14, $w15
	dotpq_s.b	$w16, $w17, $w19
	dotpq_u.b	$w20, $w21, $w22
	dotpq_us.b	$w23, $w24, $w25
	dpadd_us.d	$w6, $w7, $w29
	dpadd_us.h	$w1, $w2, $w3
	dpadd_us.w	$w4, $w5, $w6
	dpoadd_s.b	$w7, $w8, $w9
	dpoadd_u.b	$w26, $w27, $w28
	dpoadd_us.b	$w29, $w30, $w31
	dpqadd_s.b	$w16, $w18, $w19
	dpqadd_u.b	$w20, $w21, $w22
	dpqadd_us.b	$w23, $w24, $w25
	dpqaddix_s.b	$w0, $w1, $w2, 0
	dpqaddix_s.b	$w3, $w4, $w5, 1
	dpqaddix_s.b	$w6, $w7, $w8, 0x2
	dpqaddix_s.b	$w9, $w10, $w11, 3
	fadd.bh		$w5, $w6, $w7
	faddwl.bh	$w8, $w9, $w0
	faddwpl.bh	$w28, $w29, $w20
	faddwpr.bh	$w11, $w12, $w13
	faddwr.bh	$w18, $w19, $w10
	fceil_s.w	$w29, $w30
	fceil_s.d	$w28, $w31
	fceil_u.w	$w19, $w10
	fceil_u.d	$w18, $w11
	fceilf.w	$w1, $w2
	fceilf.d	$w0, $w3
	and		$5,$6,$7
	fceq.bh		$w7, $w9, $w10
	fcle.bh		$w17, $w19, $w11
	fclt.bh		$w27, $w29, $w21
	fcne.bh		$w11, $w12, $w13
	fcmadd.w	$w5, $w7, $w2
	fcmadd.d	$w25, $w27, $w22
	fcmul.w		$w11, $w13, $w15
	fcmul.d		$w1, $w3, $w5
	fcvtf2q.bh	$w2, $w3, 6
	fcvtf2q.bh	$w4, $w5, 5
	fcvtf2q.bh	$w6, $w7, 4
	fcvtf2q.bh	$w8, $w9, 3
	fcvtf2q.bh	$w10, $w11, 2
	fcvtf2q.bh	$w12, $w13, 1
	fcvtf2q.bh	$w14, $w15, 0
	fcvtf2q.bh	$w16, $w17, 15
	fcvtf2q.bh	$w18, $w19, 14
	fcvtf2q.bh	$w20, $w21, 13
	fcvtf2q.bh	$w22, $w23, 12
	fcvtf2q.bh	$w24, $w25, 11
	fcvtf2q.bh	$w26, $w27, 10
	fcvtf2q.bh	$w28, $w29, 9
	fcvtf2q.bh	$w30, $w31, 8
	fcvtf2q.bh	$w0, $w1, 7
	fcvtq2f.bh	$w2, $w3, 6
	fcvtq2f.bh	$w4, $w5, 5
	fcvtq2f.bh	$w6, $w7, 4
	fcvtq2f.bh	$w8, $w9, 3
	fcvtq2f.bh	$w10, $w11, 2
	fcvtq2f.bh	$w12, $w13, 1
	fcvtq2f.bh	$w14, $w15, 0
	fcvtq2f.bh	$w16, $w17, 15
	fcvtq2f.bh	$w18, $w19, 14
	fcvtq2f.bh	$w20, $w21, 13
	fcvtq2f.bh	$w22, $w23, 12
	fcvtq2f.bh	$w24, $w25, 11
	fcvtq2f.bh	$w26, $w27, 10
	fcvtq2f.bh	$w28, $w29, 9
	fcvtq2f.bh	$w30, $w31, 8
	fcvtq2f.bh	$w0, $w1, 7
	fdiv.bh		$w31, $w30, $w29
	fdotpix.bh	$w28, $w27, $w26, 0
	fdotpix.bh	$w18, $w17, $w16, 1
	fdotpix.bh	$w8, $w7, $w6, 2
	fdotpix.bh	$w20, $w21, $w22, 3
	fdpaddix.bh	$w28, $w27, $w26, 0
	fdpaddix.bh	$w18, $w17, $w16, 1
	fdpaddix.bh	$w8, $w7, $w6, 2
	fdpaddix.bh	$w20, $w21, $w22, 3
	fexdo_rn.bh	$w8, $w9, $w0
	fexp2.bh	$w1, $w2, $w3
	ffintbl_s.bh	$w20,$w21
	ffintbl_u.bh	$w10,$w11
	ffintbr_s.bh	$w20,$w21
	ffintbr_u.bh	$w0,$w0
	ffloor_s.w	$w1, $w1
	ffloor_s.d	$w3, $w3
	ffloor_u.w	$w2, $w2
	ffloor_u.d	$w4, $w4
	ffloorf.w	$w5, $w6
	ffloorf.d	$w7, $w8
	fhadd.bh	$w9, $w3
	fhmax.bh	$w14, $w15, $w16
	fhmax_a.bh	$w28, $w24, $w1
	flog2.bh	$w9, $w8
	fmadd.bh	$w17,$w19,$w23
	fmaddix.w	$w18, $w17, $w16, 1
	fmaddix.w	$w28, $w27, $w26, 0
	fmaddix.w	$w8, $w7, $w6, 2
	fmaddix.w	$w15, $w14, $w13, 3
	fmaddix.d	$w5, $w4, $w3, 1
	fmaddix.d	$w9, $w7, $w8, 0
	fmax.bh		$w8, $w7, $w6
	fmax_a.bh	$w15, $w14, $w13
	fmsub.bh	$w2, $w3, $w4
	fmul.bh		$w8, $w9, $w10
	fmulix.w	$w18, $w17, $w16, 1
	fmulix.w	$w28, $w27, $w26, 0
	fmulix.w	$w8, $w7, $w6, 2
	fmulix.w	$w15, $w14, $w13, 3
	fmulix.d	$w5, $w4, $w3, 1
	fmulix.d	$w9, $w7, $w8, 0
	frcp.bh		$w19,$w23
	fround_s.w	$w31, $w30
	fround_s.d	$w28, $w27
	fround_u.w	$w18, $w17
	fround_u.d	$w21, $w22
	froundf.w	$w7, $w8
	froundf.d	$w1, $w1
	fsub.bh		$w9, $w7, $w8
	ftruncf.w	$w2, $w2
	ftruncf.d	$w4, $w4
	nop
	maddwl_s.b	$w26, $w27, $w28
	maddwl_s.h	$w29, $w30, $w31
	maddwl_u.b	$w16, $w18, $w19
	maddwl_u.h	$w20, $w21, $w22
	maddwr_s.b	$w23, $w24, $w25
	maddwr_s.h	$w26, $w27, $w28
	maddwr_u.b	$w29, $w30, $w31
	maddwr_u.h	$w16, $w18, $w19
	mulwl_s.b	$w20, $w21, $w22
	mulwl_s.h	$w23, $w24, $w25
	mulwl_u.b	$w26, $w27, $w28
	mulwl_u.h	$w29, $w30, $w31
	mulwr_s.b	$w16, $w18, $w19
	mulwr_s.h	$w20, $w21, $w22
	mulwr_u.b	$w23, $w24, $w25
	mulwr_u.h	$w21, $w22, $w28
	n2x_s.b		$w21, $w22, 0
	n2x_s.b		$w1, $w2, 15
	n2x_s.h		$w26, $w27, 1
	n2x_s.h		$w6, $w7, 31
	n2x_s.w		$w30, $w31, 2
	n2x_s.w		$w30, $w31, 63
	n2x_u.b		$w21, $w22, 0
	n2x_u.h		$w26, $w27, 27
	n2x_u.w		$w24, $w25, 40
	n2xr_s.b	$w21, $w22, 1
	n2xr_s.h	$w26, $w27, 16
	n2xr_s.w	$w24, $w25, 41
	n2xr_u.b	$w21, $w22, 2
	n2xr_u.h	$w26, $w27, 17
	n2xr_u.w	$w24, $w25, 42
	n2x_sat_s.b	$w21, $w22, 3
	n2x_sat_s.h	$w26, $w27, 18
	n2x_sat_s.w	$w24, $w25, 43
	n2x_sat_u.b	$w21, $w22, 4
	n2x_sat_u.h	$w26, $w27, 19
	n2x_sat_u.w	$w24, $w25, 44
	n2x_ssat_u.b	$w21, $w22, 5
	n2x_ssat_u.h	$w26, $w27, 20
	n2x_ssat_u.w	$w24, $w25, 45
	n2x_usat_s.b	$w21, $w22, 6
	n2x_usat_s.h	$w26, $w27, 21
	n2x_usat_s.w	$w24, $w25, 46
	n2xr_sat_s.b	$w21, $w22, 7
	n2xr_sat_s.h	$w26, $w27, 22
	n2xr_sat_s.w	$w24, $w25, 47
	n2xr_sat_u.b	$w21, $w22, 8
	n2xr_sat_u.h	$w26, $w27, 23
	n2xr_sat_u.w	$w24, $w25, 48
	n2xr_ssat_u.b	$w21, $w22, 9
	n2xr_ssat_u.h	$w26, $w27, 24
	n2xr_ssat_u.w	$w24, $w25, 49
	n2xr_usat_s.b	$w21, $w22, 10
	n2xr_usat_s.h	$w26, $w27, 25
	n2xr_usat_s.w	$w24, $w25, 50
	oadd_s.b	$w4, $w5, $w6
	oadd_u.b	$w14, $w15, $w16
	ror.b		$w24, $w25, $w26
	ror.h		$w2, $w3, $w4
	ror.w		$w4, $w6, $w8
	ror.d		$w11, $w13, $w17
	rori.b		$w1, $w2, 6
	rori.h		$w3, $w4, 14
	rori.w		$w5, $w6, 30
	rori.d		$w7, $w8, 62
	sad_u.b		$w10, $w11, $w12
	sad_u.b		$w10, $w11, $w2
	sadac_u.b	$w13, $w14, $w15
	sadac_u.b	$w13, $w19, $w10
	sats_u.b	$w1, $w2, 6
	sats_u.h	$w3, $w4, 14
	sats_u.w	$w5, $w6, 30
	sats_u.d	$w7, $w8, 62
	sraraz.b	$w0, $w10, $w20
	sraraz.h	$w1, $w11, $w21
	sraraz.w	$w2, $w13, $w23
	sraraz.d	$w4, $w14, $w24
	subssu_u.b	$w0, $w10, $w20
	subssu_u.h	$w1, $w11, $w21
	subssu_u.w	$w2, $w13, $w23
	subssu_u.d	$w4, $w14, $w24
	subwl_s.b	$w0, $w0, $w10
	subwl_s.h	$w1, $w1, $w11
	subwl_u.b	$w2, $w2, $w13
	subwl_u.h	$w4, $w4, $w14
	subwr_s.b	$w0, $w0, $w10
	subwr_s.h	$w1, $w1, $w11
	subwr_u.b	$w2, $w2, $w13
	subwr_u.h	$w4, $w4, $w14
	vperm.b		$w28, $w29, $w30, $w31
	w2x.hi.s.b	$w10, $w11
	w2x.hi.s.h	$w12, $w13
	w2x.hi.s.w	$w14, $w15
	w2x.lo.s.b	$w16, $w17
	w2x.lo.s.h	$w18, $w19
	w2x.lo.s.w	$w20, $w21
	nop
	nop
	nop
	nop
