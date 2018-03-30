#objdump: -d -l
#name: assembly line numbers
#as: --gstabs


.*: +file format .*nanomips.*

Disassembly of section \.text:
00000000 <main>:
main\(\):
.*:10
   0:	83bd 8018 	addiu	sp,sp,-24
.*:11
   4:	b7e5      	sw	ra,20\(sp\)
.*:12
   6:	b7c4      	sw	fp,16\(sp\)
.*:13
   8:	13dd      	move	fp,sp
.*:14
   a:	2a00 0000 	balc	0 <__main>
.*:15
   e:	0040 0002 	li	t4,2
.*:16
  12:	845e 9000 	sw	t4,0\(fp\)
.*:17
  16:	845e 8000 	lw	t4,0\(fp\)
.*:18
  1a:	1062      	move	t5,t4
.*:19
  1c:	8083 c001 	sll	a0,t5,1
.*:20
  20:	2044 1150 	addu	t4,a0,t4
.*:21
  24:	845e 9004 	sw	t4,4\(fp\)
.*:22
  28:	849e 8004 	lw	a0,4\(fp\)
.*:23
  2c:	2a00 0000 	balc	44 <g>
.*:24
  30:	847e 8000 	lw	t5,0\(fp\)
.*:25
  34:	1043      	move	t4,t5
.*:26
  36:	1800      	bc	38 <\$L1>

00000038 <\$L1>:
.*:28
  38:	13be      	move	sp,fp
.*:29
  3a:	37e5      	lw	ra,20\(sp\)
.*:30
  3c:	37c4      	lw	fp,16\(sp\)
.*:31
  3e:	03bd 0018 	addiu	sp,sp,24
.*:32
  42:	dbe0      	jrc	ra

00000044 <g>:
g\(\):
.*:41
  44:	83bd 8018 	addiu	sp,sp,-24
.*:42
  48:	b7c4      	sw	fp,16\(sp\)
.*:43
  4a:	13dd      	move	fp,sp
.*:44
  4c:	849e 9000 	sw	a0,0\(fp\)
.*:45
  50:	845e 8000 	lw	t4,0\(fp\)
.*:46
  54:	0062 0001 	addiu	t5,t4,1
.*:47
  58:	1043      	move	t4,t5
.*:48
  5a:	1800      	bc	5c <\$L2>

0000005c <\$L2>:
.*:50
  5c:	13be      	move	sp,fp
.*:51
  5e:	37c4      	lw	fp,16\(sp\)
.*:52
  60:	03bd 0018 	addiu	sp,sp,24
.*:53
  64:	dbe0      	jrc	ra
#pass
