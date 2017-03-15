#include "sim-main.h"
#include "elf/mips.h"

/* XLP Flag */
int xlp_flag = -1;

int is_xlp_flag_set = 0;

void
set_xlp_flag (SIM_DESC sd)
{
  Elf_Internal_ABIFlags_v0 *abiflags;
  abiflags = bfd_mips_elf_get_abiflags (STATE_PROG_BFD(sd));

  xlp_flag = 0;

  if (abiflags != NULL
      && ((abiflags->ases & AFL_ASE_XLP) != 0))
    xlp_flag = 1;

  is_xlp_flag_set = 1;
}
