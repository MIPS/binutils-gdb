/*  Run function for the nanomips simulator

    Copyright (C) 2005-2013 Free Software Foundation, Inc.
    Contributed by Imagination Technologies, Ltd.  
    Written by Andrew Bennett <andrew.bennett@imgtec.com>.

    This file is part of GDB, the GNU debugger.

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

#include "sim-main.h"
#include "nanomips16_idecode.h"
#include "nanomips32_idecode.h"
#include "bfd.h"


#define SD sd
#define CPU cpu
#define SIM_MONITOR_ADDRESS 0xBFC00000

void 
sim_engine_run (SIM_DESC sd, int next_cpu_nr, int nr_cpus, int signal);

address_word
nanomips_instruction_decode (SIM_DESC sd, sim_cpu * cpu,
			      address_word cia,
			      int instruction_size)
{

  nanomips16_instruction_word instruction_0 = IMEM16_NANOMIPS (cia);

  if((cia & 0xFFF00000) == SIM_MONITOR_ADDRESS) {
    nanomips32_instruction_word instruction_0 = IMEM32 (cia);
    return nanomips32_idecode_issue (sd, instruction_0, cia);
  } else if ((STATE_ARCHITECTURE (sd)->mach == bfd_mach_nanomipsisa32r6
	  || STATE_ARCHITECTURE (sd)->mach == bfd_mach_nanomipsisa64r6)
	     && (NANOMIPS_MAJOR_OPCODE_3_5 (instruction_0) & 0x4) == 4)
	return nanomips16_idecode_issue (sd, instruction_0, cia);
      else
	{
	  nanomips32_instruction_word instruction_0 = IMEM32_NANOMIPS (cia);
	  return nanomips32_idecode_issue (sd, instruction_0, cia);
	}
}

void
sim_engine_run (SIM_DESC sd, int next_cpu_nr, int nr_cpus,
		int signal)
{
  nanomips32_instruction_word instruction_0;
  sim_cpu *cpu = STATE_CPU (sd, next_cpu_nr);
  nanomips32_instruction_address cia = CIA_GET (cpu);
  //isa_mode = ISA_MODE_MIPS32;
  is_nanomips = 1;
  unsigned long bfdmach;

  bfdmach = STATE_ARCHITECTURE(SD)->mach;

  if (is_nms_flag_set == 0 && (bfdmach == bfd_mach_nanomipsisa64r6
      || bfdmach == bfd_mach_nanomipsisa32r6))
    set_nms_flag (sd);

  while (1)
    {
      nanomips32_instruction_address nia;

	    cia = cia & ~0x1;

#if defined (ENGINE_ISSUE_PREFIX_HOOK)
      ENGINE_ISSUE_PREFIX_HOOK ();
#endif

    nia =
      nanomips_instruction_decode (sd, cpu, cia,
            MICROMIPS_DELAYSLOT_SIZE_ANY);

#if defined (ENGINE_ISSUE_POSTFIX_HOOK)
      ENGINE_ISSUE_POSTFIX_HOOK ();
#endif
      // Cycle counting
      COP0_COUNT++;

      /* Update the instruction address */
      cia = nia;

      /* process any events */
      if (sim_events_tick (sd))
	{
	  CIA_SET (CPU, cia);
	  sim_events_process (sd);
	  cia = CIA_GET (CPU);
	}
    }
}
