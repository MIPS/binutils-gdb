#objdump: -dr --no-show-raw-insn -D -j.text
#name: microMIPS short delay-slot selection
#as: -O3 -relax-branch
#source: micromips-short-delay.s
#stderr: micromips-short-delay.l

.*: +file format .*mips.*


Disassembly of section \.text:

0+00 <test>:
       0:	bgezals	v0,0 <test>
			0: R_MICROMIPS_PC16_S1	test2
       4:	addu	v1,a0,a1
       6:	bltzals	v0,6 <test\+0x6>
			6: R_MICROMIPS_PC16_S1	test2
       a:	addu	v1,a0,a1
       c:	jrs	v0
      10:	addu	v1,a0,a1
      12:	jrs\.hb	v0
      16:	addu	v1,a0,a1
      18:	jalrs	v0,a0
      1c:	addu	v1,a0,a1
      1e:	jalrs	v0
      20:	addu	v1,a0,a1
      22:	jalrs\.hb	v0
      26:	addu	v1,a0,a1
      28:	bltz	v0,28 <test\+0x28>
			28: R_MICROMIPS_PC16_S1	\.L0
      2c:	nop
      2e:	jals	0 <test>
			2e: R_MICROMIPS_26_S1	test3

0+32 <\.L0>:
      32:	addu	v1,a0,a1
      34:	sync
      38:	bgezals	v0,38 <\.L0\+0x6>
			38: R_MICROMIPS_PC16_S1	test2
      3c:	nop
      3e:	addu	v0,a0,a1
      40:	bltzals	v0,40 <\.L0\+0xe>
			40: R_MICROMIPS_PC16_S1	test2
      44:	nop
      46:	addu	v1,a0,a1
      48:	jalrs	v1,v0
      4c:	nop
      4e:	addiu	v1,\$pc,16
      52:	jalrs	v0
      54:	nop
      56:	addu	v1,a0,a1

0+58 <blabel>:
      58:	jalrs\.hb	v0
      5c:	nop
      5e:	addu	v1,a0,a1
      60:	jrs\.hb	v0
      64:	nop
      66:	addu	v1,a0,a1
      68:	jalrs	v0
      6a:	nop
      6c:	addu	v1,a0,a1
      6e:	jalx	910 <test2\+0x488>
			6e: R_MICROMIPS_26_S1	\.text
      72:	nop
      76:	addu	v1,a0,a1
      78:	jal	0 <test>
			78: R_MICROMIPS_26_S1	test3
      7c:	nop
      80:	jalr\.hb	v0
      84:	addu	v1,a0,s5
	\.\.\.

0+488 <test2>:
	\.\.\.

0+10088 <test3>:
   10088:	jr\.hb	v0
   1008c:	addu	v1,a0,s5
   10090:	jal	488 <test2>
			10090: R_MICROMIPS_26_S1	\.text
   10094:	addu	v1,a0,s5
   10098:	bgezals	v0,10098 <test3\+0x10>
			10098: R_MICROMIPS_PC16_S1	test2
   1009c:	addu	v1,a0,a1
   1009e:	nop
	\.\.\.
