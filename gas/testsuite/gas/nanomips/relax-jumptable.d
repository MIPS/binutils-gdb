#objdump: -dr
#name: Jump-table relaxation test

# Check correct relaxation of compressed jumptables.

.*: +file format .*nanomips.*

Disassembly of section \.text:

00000000 <test>:
       0:	20e6 2907 	lbux	a1,a2\(a3\)

00000004 <\$Lbu_nc_l0>:
       4:	8000 c000 	nop

00000008 <\$Lbu_nc_l2>:
       8:	8000 c000 	nop

0000000c <\$Lbu_nc_l3>:
       c:	20e6 2b47 	lhuxs	a1,a2\(a3\)

00000010 <\$Lbu_2_lhu_l0>:
	...

0000020e <\$Lbu_2_lhu_l2>:
     20e:	4080 0002 	lw	a0,0\(gp\)
			20e: R_NANOMIPS_GPREL19_S2	x

00000212 <\$Lbu_2_lhu_l3>:
     212:	20e6 2c47 	lwxs	a1,a2\(a3\)

00000216 <\$Lbu_2_lwx_l0>:
	...

00020214 <\$Lbu_2_lwx_l2>:
   20214:	4080 0002 	lw	a0,0\(gp\)
			20214: R_NANOMIPS_GPREL19_S2	x

00020218 <\$Lbu_2_lwx_l3>:
   20218:	20e6 2807 	lbx	a1,a2\(a3\)

0002021c <\$Lb_nc_l3>:
   2021c:	8000 c000 	nop

00020220 <\$Lb_nc_l0>:
   20220:	8000 c000 	nop

00020224 <\$Lb_nc_l2>:
   20224:	8000 c000 	nop
   20228:	20e6 2a47 	lhxs	a1,a2\(a3\)

0002022c <\$Lb_2_lh_l0>:
	...

0002032a <\$Lb_2_lh_l2>:
   2032a:	4080 0002 	lw	a0,0\(gp\)
			2032a: R_NANOMIPS_GPREL19_S2	x

0002032e <\$Lb_2_lh_l3>:
   2032e:	20e6 2a47 	lhxs	a1,a2\(a3\)

00020332 <\$Lb_2_lh_neg_l3>:
   20332:	9008      	nop

00020334 <\$Lb_2_lh_neg_l2>:
   20334:	4080 0002 	lw	a0,0\(gp\)
			20334: R_NANOMIPS_GPREL19_S2	x

00020338 <\$Lb_2_lh_neg_l1>:
	...

00020438 <\$Lb_2_lh_neg_l0>:
   20438:	20e6 2c47 	lwxs	a1,a2\(a3\)

0002043c <\$Lb_2_lwx_l0>:
	...

0003043a <\$Lb_2_lwx_l2>:
   3043a:	4080 0002 	lw	a0,0\(gp\)
			3043a: R_NANOMIPS_GPREL19_S2	x

0003043e <\$Lb_2_lwx_l3>:
   3043e:	20e6 2c47 	lwxs	a1,a2\(a3\)

00030442 <\$Lb_2_lwx_neg_l2>:
   30442:	4080 0002 	lw	a0,0\(gp\)
			30442: R_NANOMIPS_GPREL19_S2	x

00030446 <\$Lb_2_lwx_neg_l1>:
	...

00040446 <\$Lb_2_lwx_neg_l0>:
   40446:	20e6 2b47 	lhuxs	a1,a2\(a3\)

0004044a <\$Lhu_nc_l0>:
   4044a:	8000 c000 	nop

0004044e <\$Lhu_nc_l2>:
   4044e:	8000 c000 	nop

00040452 <\$Lhu_nc_l3>:
   40452:	20e6 2c47 	lwxs	a1,a2\(a3\)

00040456 <\$Lhu_2_lwx_l0>:
	...

00060454 <\$Lhu_2_lwx_l2>:
   60454:	4080 0002 	lw	a0,0\(gp\)
			60454: R_NANOMIPS_GPREL19_S2	x

00060458 <\$Lhu_2_lwx_l3>:
   60458:	20e6 2a47 	lhxs	a1,a2\(a3\)

0006045c <\$Lh_nc_l3>:
   6045c:	8000 c000 	nop

00060460 <\$Lh_nc_l0>:
   60460:	8000 c000 	nop

00060464 <\$Lh_nc_l2>:
   60464:	8000 c000 	nop
   60468:	20e6 2c47 	lwxs	a1,a2\(a3\)

0006046c <\$Lh_2_lwx_l0>:
	...

0007046a <\$Lh_2_lwx_l2>:
   7046a:	4080 0002 	lw	a0,0\(gp\)
			7046a: R_NANOMIPS_GPREL19_S2	x

0007046e <\$Lh_2_lwx_l3>:
   7046e:	20e6 2c47 	lwxs	a1,a2\(a3\)

00070472 <\$Lh_2_lwx_neg_l2>:
   70472:	4080 0002 	lw	a0,0\(gp\)
			70472: R_NANOMIPS_GPREL19_S2	x

00070476 <\$Lh_2_lwx_neg_l1>:
	...

00080476 <\$Lh_2_lwx_neg_l0>:
   80476:	20e6 2c07 	lwx	a1,a2\(a3\)
			80476: R_NANOMIPS_JUMPTABLE_LOAD	lw_nc_table

0008047a <\$Lw_nc_l3>:
   8047a:	8000 c000 	nop

0008047e <\$Lw_nc_l0>:
   8047e:	8000 c000 	nop

00080482 <\$Lw_nc_l2>:
   80482:	8000 c000 	nop
