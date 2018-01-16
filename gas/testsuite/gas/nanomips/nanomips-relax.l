GAS LISTING .*/nanomips-relax.s 			page 1


   1              		.text
   2              		.align	3
   3              		.ent	test
   4              		.globl	test
   5              		/\* Relax to 16-bit \*/
   6              	test:
   7 0000 A4880000 		beqc	\$a0,\$a1,test1 /\* forward, relax to 32-bit \*/
   8 0004 00000000 		.space	\(1<<5\)
   8      00000000.
   8      00000000.
   8      00000000.
   8      00000000.
   9              	test1:
  10 0024 00280000 		bc	test2	/\* forward, relax to 32-bit \*/
  11 0028 00000000 		.space	\(1<<10\)
  11      00000000.
  11      00000000.
  11      00000000.
  11      00000000.
  12              	test2:
  13 0428 00280000 		bc 	test1	/\* backward, relax to 32-bit \*/
  14 042c 85A80000 		bnec	\$a1, \$a0, test3
  15 0430 00000000 		.space \(1<<5\)
  15      00000000.
  15      00000000.
  15      00000000.
  15      00000000.
  16              	test3:
  17 0450 A4880000 		beqc	\$a0, \$a1, test2 /\* backward, relax to 32-bit \*/
  18 0454 00000000 		.space \(1<<5\)
  18      00000000.
  18      00000000.
  18      00000000.
  18      00000000.
  19              	test4:
  20 0474 002A0000 		balc	test5 /\* forward, relax to 32-bit \*/
  21 0478 00000000 		.space \(1<<10\)
  21      00000000.
  21      00000000.
  21      00000000.
  21      00000000.
  22              		.end	test
  23              		.ent test5
  24              		.globl test5
  25              	test5:
  26 0878 CFDA     		beqc	\$a0,\$a1,test6 /\* forward, no relax \*/
  27 087a 00000000 		.space	\(1<<5\)-4
  27      00000000.
  27      00000000.
  27      00000000.
  27      00000000.
  28              	test6:
  29 0896 0018     		bc	test7	/\* forward, no relax \*/
  30              	test6a:
  31 0898 00000000 		.space	\(1<<10\)-4
  31      00000000.
  31      00000000.
GAS LISTING .*/nanomips-relax.s 			page 2


  31      00000000.
  31      00000000.
  32              	test7:
  33 0c94 0018     		bc 	test6a	/\* backward, no relax \*/
  34 0c96 5FDA     		bnec	\$a1, \$a0, test8 /\* forward, no relax \*/
  35 0c98 00000000 		.space \(1<<5\)-4
  35      00000000.
  35      00000000.
  35      00000000.
  35      00000000.
  36              	test8:
  37 0cb4 00000000 		.space \(1<<10\)-2
  37      00000000.
  37      00000000.
  37      00000000.
  37      00000000.
  38              	test9:
  39 10b2 0038     		balc	test8 /\* backward, no relax \*/
  40              .
  41 10b4 F1880000 		beqc \$s1,\$a3,\$L1 /\* unreachable forward to relaxable, relax.  \*/
  42              	\$L1:
  43 10b8 F1880000 		beqc \$s1,\$a3,\$L2 /\* unreachable forward to non-relaxable, relax.  \*/
  44              	\$L2:
  45 10bc 0890     		nop
  46 10be 9FDB     		beqc \$s1,\$a3,\$L3 /\* reachable forward over non-relaxable, no relax.  \*/
  47 10c0 111F     		restore.jrc	16,\$ra
  48              	\$L3:
  49 10c2 9FDB     		beqc \$s1,\$a3,\$L4 /\* reachable forward over relaxable, no relax.  \*/
  50 10c4 8098     		beqzc \$s1, \$L3
  51              	\$L4:
  52 10c6 8098     		beqzc \$s1, \$L3
  53.*
  54              		.end test5
  55 10c8 00000000 		.space 8
  55      00000000.
