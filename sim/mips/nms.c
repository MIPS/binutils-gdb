#include "sim-main.h"
#include "elf/mips-common.h"
#include "elf/nanomips.h"

/* NMS Flag */
int nms_flag = -1;

int is_nms_flag_set = 0;

void
set_nms_flag (SIM_DESC sd)
{
  Elf_Internal_ABIFlags_v0 *abiflags;
  abiflags = bfd_nanomips_elf_get_abiflags (STATE_PROG_BFD(sd));

  nms_flag = 0;

  if (abiflags != NULL
      && ((abiflags->ases & NANOMIPS_ASE_xNMS) != 0))
    nms_flag = 1;

  is_nms_flag_set = 1;
}
