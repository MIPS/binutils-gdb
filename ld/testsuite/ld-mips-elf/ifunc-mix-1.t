#...
0040010c <main>:
  40010c:	move	a3,ra
  400110:	jalx	400150 <\.iplt\.func2>
  400114:	nop
  400118:	jal	400140 <\.iplt\.func1>
  40011c:	nop
  400120:	jr	a3
  400124:	nop

00400128 <test_mips16>:
  400128:	move	a3,ra
  40012a:	jal	400150 <\.iplt\.func2>
  40012e:	nop
  400130:	jalx	400140 <\.iplt\.func1>
  400134:	nop
  400136:	jr	a3
#pass
