#...
0040010c <main>:
  40010c:	move	a3,ra
  400110:	jal	400164 <\.iplt\.func2>
  400114:	nop
  400118:	jal	400158 <\.iplt\.func1>
  40011c:	nop
  400120:	jr	a3
  400124:	nop

00400128 <test_micromips>:
  400128:	move	a3,ra
  40012a:	jal	40014c <\.iplt\.comp\.func2>
  40012e:	nop
  400132:	nop
  400134:	jal	400140 <\.iplt\.comp\.func1>
  400138:	nop
  40013c:	jr	a3
  40013e:	nop
#pass