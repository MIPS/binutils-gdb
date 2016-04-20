#objdump: -dr --no-show-raw-insn
#name: microMIPS optimized out-of-range relaxation sequence
#as: -O3 -relax-branch
#source: micromips-relax-O3.s
#stderr: micromips-relax-O3.l

.*: +file format .*mips.*


Disassembly of section \.text:

0+00 <test>:
       0:	addu	v0,v1,a0
       2:	bnez	v0,2 <test\+0x2>
			2: R_MICROMIPS_PC7_S1	\.L0
       4:	nop
       6:	j	10060 <test2>
			6: R_MICROMIPS_26_S1	\.text

0+0a <\.L0>:
       a:	beqz	a1,a <\.L0>
			a: R_MICROMIPS_PC7_S1	\.L1
       c:	nop
       e:	j	10060 <test2>
			e: R_MICROMIPS_26_S1	\.text

0+12 <\.L1>:
      12:	addu	v0,v1,a0
      14:	addu	v0,v1,a0
      16:	beqz	v0,16 <\.L1\+0x4>
			16: R_MICROMIPS_PC7_S1	\.L2
      18:	nop
      1a:	j	10060 <test2>
			1a: R_MICROMIPS_26_S1	\.text
      1e:	nop

0+20 <\.L2>:
      20:	addu	v0,v1,a0
      22:	bnez	a1,22 <\.L2\+0x2>
			22: R_MICROMIPS_PC7_S1	\.L3
      24:	nop
      26:	j	10060 <test2>
			26: R_MICROMIPS_26_S1	\.text
      2a:	nop

0+2c <\.L3>:
      2c:	addu	v0,v1,a0
      2e:	bne	v0,a1,2e <\.L3\+0x2>
			2e: R_MICROMIPS_PC16_S1	\.L4
      32:	nop
      34:	j	10060 <test2>
			34: R_MICROMIPS_26_S1	\.text

0+38 <\.L4>:
      38:	nop
      3a:	beq	v1,a1,3a <\.L4\+0x2>
			3a: R_MICROMIPS_PC16_S1	\.L5
      3e:	nop
      40:	j	10060 <test2>
			40: R_MICROMIPS_26_S1	\.text

0+44 <\.L5>:
      44:	addu	v0,v1,a0
      46:	addu	v0,v1,a0
      48:	bltz	v0,48 <\.L5\+0x4>
			48: R_MICROMIPS_PC16_S1	\.L6
      4c:	nop
      4e:	jals	10060 <test2>
			4e: R_MICROMIPS_26_S1	\.text

0+52 <\.L6>:
      52:	nop
      54:	bgez	a1,54 <\.L6\+0x2>
			54: R_MICROMIPS_PC16_S1	\.L7
      58:	nop
      5a:	jals	10060 <test2>
			5a: R_MICROMIPS_26_S1	\.text

0+5e <\.L7>:
      5e:	addu	v0,v1,a0
	\.\.\.

0+10060 <test2>:
	\.\.\.
