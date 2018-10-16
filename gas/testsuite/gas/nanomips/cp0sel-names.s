# source file to test assembly using various styles of
# CP0 (w/ non-zero select code) register names.

	.text
text_label:
	mtc0	$0, $mvpcontrol
	mtc0	$0, $mvpconf0
	mtc0	$0, $mvpconf1
	mtc0	$0, $vpcontrol
	mtc0	$0, $0, 5
	mtc0	$0, $0, 6
	mtc0	$0, $0, 7
	mtc0	$0, $vpecontrol
	mtc0	$0, $vpeconf0
	mtc0	$0, $vpeconf1
	mtc0	$0, $yqmask
	mtc0	$0, $vpeschedule
	mtc0	$0, $vpeschefback
	mtc0	$0, $vpeopt
	mtc0	$0, $tcstatus
	mtc0	$0, $tcbind
	mtc0	$0, $tcrestart
	mtc0	$0, $tchalt
	mtc0	$0, $tccontext
	mtc0	$0, $tcschedule
	mtc0	$0, $tcschefback
	mtc0	$0, $globalnumber
	mtc0	$0, $3, 2
	mtc0	$0, $3, 3
	mtc0	$0, $3, 4
	mtc0	$0, $3, 5
	mtc0	$0, $3, 6
	mtc0	$0, $tcopt
	mtc0	$0, $contextconfig
	mtc0	$0, $userlocal
	mtc0	$0, $xcontextconfig
	mtc0	$0, $debugcontextid
	mtc0	$0, $memorymapid
	mtc0	$0, $4, 6
	mtc0	$0, $4, 7
	mtc0	$0, $pagegrain
	mtc0	$0, $segctl0
	mtc0	$0, $segctl1
	mtc0	$0, $segctl2
	mtc0	$0, $pwbase
	mtc0	$0, $pwfield
	mtc0	$0, $pwsize
	mtc0	$0, $srsconf0
	mtc0	$0, $srsconf1
	mtc0	$0, $srsconf2
	mtc0	$0, $srsconf3
	mtc0	$0, $srsconf4
	mtc0	$0, $pwctl
	mtc0	$0, $6, 7
	mtc0	$0, $7, 1
	mtc0	$0, $7, 2
	mtc0	$0, $7, 3
	mtc0	$0, $7, 4
	mtc0	$0, $7, 5
	mtc0	$0, $7, 6
	mtc0	$0, $7, 7
	mtc0	$0, $badinst
	mtc0	$0, $badinstrp
	mtc0	$0, $badinstrx
	mtc0	$0, $8, 4
	mtc0	$0, $8, 5
	mtc0	$0, $8, 6
	mtc0	$0, $8, 7
	mtc0	$0, $9, 1
	mtc0	$0, $9, 2
	mtc0	$0, $9, 3
	mtc0	$0, $9, 4
	mtc0	$0, $9, 5
	mtc0	$0, $9, 6
	mtc0	$0, $9, 7
	mtc0	$0, $10, 1
	mtc0	$0, $10, 2
	mtc0	$0, $10, 3
	mtc0	$0, $guestctl1
	mtc0	$0, $guestctl2
	mtc0	$0, $guestctl3
	mtc0	$0, $10, 7
	mtc0	$0, $11, 1
	mtc0	$0, $11, 2
	mtc0	$0, $11, 3
	mtc0	$0, $guestctl0ext
	mtc0	$0, $11, 5
	mtc0	$0, $11, 6
	mtc0	$0, $11, 7
	mtc0	$0, $intctl
	mtc0	$0, $srsctl
	mtc0	$0, $srsmap
	mtc0	$0, $view_ipl
	mtc0	$0, $srsmap2
	mtc0	$0, $guestctl0
	mtc0	$0, $gtoffset
	mtc0	$0, $13, 1
	mtc0	$0, $13, 2
	mtc0	$0, $13, 3
	mtc0	$0, $view_ripl
	mtc0	$0, $nestedexc
	mtc0	$0, $13, 6
	mtc0	$0, $13, 7
	mtc0	$0, $14, 1
	mtc0	$0, $nestedepc
	mtc0	$0, $14, 3
	mtc0	$0, $14, 4
	mtc0	$0, $14, 5
	mtc0	$0, $14, 6
	mtc0	$0, $14, 7
	mtc0	$0, $ebase
	mtc0	$0, $cdmmbase
	mtc0	$0, $cmgcrbase
	mtc0	$0, $bevva
	mtc0	$0, $15, 5
	mtc0	$0, $15, 6
	mtc0	$0, $15, 7
	mtc0	$0, $config1
	mtc0	$0, $config2
	mtc0	$0, $config3
	mtc0	$0, $config4
	mtc0	$0, $config5
	mtc0	$0, $16, 6
	mtc0	$0, $16, 7
	mtc0	$0, $maar
	mtc0	$0, $maari
	mtc0	$0, $17, 3
	mtc0	$0, $17, 4
	mtc0	$0, $17, 5
	mtc0	$0, $17, 6
	mtc0	$0, $17, 7
	mtc0	$0, $watchlo, 1
	mtc0	$0, $watchlo, 2
	mtc0	$0, $watchlo, 3
	mtc0	$0, $watchlo, 4
	mtc0	$0, $watchlo, 5
	mtc0	$0, $watchlo, 6
	mtc0	$0, $watchlo, 7
	mtc0	$0, $watchhi, 1
	mtc0	$0, $watchhi, 2
	mtc0	$0, $watchhi, 3
	mtc0	$0, $watchhi, 4
	mtc0	$0, $watchhi, 5
	mtc0	$0, $watchhi, 6
	mtc0	$0, $watchhi, 7
	mtc0	$0, $20, 1
	mtc0	$0, $20, 2
	mtc0	$0, $20, 3
	mtc0	$0, $20, 4
	mtc0	$0, $20, 5
	mtc0	$0, $20, 6
	mtc0	$0, $20, 7
	mtc0	$0, $21, 1
	mtc0	$0, $21, 2
	mtc0	$0, $21, 3
	mtc0	$0, $21, 4
	mtc0	$0, $21, 5
	mtc0	$0, $21, 6
	mtc0	$0, $21, 7
	mtc0	$0, $22, 1
	mtc0	$0, $22, 2
	mtc0	$0, $22, 3
	mtc0	$0, $22, 4
	mtc0	$0, $22, 5
	mtc0	$0, $22, 6
	mtc0	$0, $22, 7
	mtc0	$0, $tracecontrol
	mtc0	$0, $tracecontrol2
	mtc0	$0, $usertracedata1
	mtc0	$0, $traceibpc
	mtc0	$0, $tracedbpc
	mtc0	$0, $debug2
	mtc0	$0, $23, 7
	mtc0	$0, $24, 1
	mtc0	$0, $tracecontrol3
	mtc0	$0, $usertracedata2
	mtc0	$0, $24, 4
	mtc0	$0, $24, 5
	mtc0	$0, $24, 6
	mtc0	$0, $24, 7
	mtc0	$0, $perfcnt, 1
	mtc0	$0, $perfctl, 2
	mtc0	$0, $perfcnt, 3
	mtc0	$0, $perfctl, 4
	mtc0	$0, $perfcnt, 5
	mtc0	$0, $perfctl, 6
	mtc0	$0, $perfcnt, 7
	mtc0	$0, $26, 1
	mtc0	$0, $26, 2
	mtc0	$0, $26, 3
	mtc0	$0, $26, 4
	mtc0	$0, $26, 5
	mtc0	$0, $26, 6
	mtc0	$0, $26, 7
	mtc0	$0, $27, 1
	mtc0	$0, $27, 2
	mtc0	$0, $27, 3
	mtc0	$0, $27, 4
	mtc0	$0, $27, 5
	mtc0	$0, $27, 6
	mtc0	$0, $27, 7
	mtc0	$0, $datalo, 1
	mtc0	$0, $taglo, 2
	mtc0	$0, $datalo, 3
	mtc0	$0, $taglo, 4
	mtc0	$0, $datalo, 5
	mtc0	$0, $taglo, 6
	mtc0	$0, $datalo, 7
	mtc0	$0, $datahi, 1
	mtc0	$0, $taghi, 2
	mtc0	$0, $datahi, 3
	mtc0	$0, $taghi, 4
	mtc0	$0, $datahi, 5
	mtc0	$0, $taghi, 6
	mtc0	$0, $datahi, 7
	mtc0	$0, $30, 1
	mtc0	$0, $30, 2
	mtc0	$0, $30, 3
	mtc0	$0, $30, 4
	mtc0	$0, $30, 5
	mtc0	$0, $30, 6
	mtc0	$0, $30, 7
	mtc0	$0, $31, 1
	mtc0	$0, $kscratch1
	mtc0	$0, $kscratch2
	mtc0	$0, $kscratch3
	mtc0	$0, $kscratch4
	mtc0	$0, $kscratch5
	mtc0	$0, $kscratch6
