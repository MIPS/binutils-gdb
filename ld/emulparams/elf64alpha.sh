ENTRY=__start
SCRIPT_NAME=elf
ELFSIZE=64
TEMPLATE_NAME=elf32
OUTPUT_FORMAT="elf64-alpha"
TEXT_START_ADDR="0x120000000"
MAXPAGESIZE=0x100000
NONPAGED_TEXT_START_ADDR="0x120000000"
ARCH=alpha
MACHINE=
GENERATE_SHLIB_SCRIPT=yes
DATA_PLT=
NOP=0x47ff041f

OTHER_READONLY_SECTIONS='.reginfo : { *(.reginfo) }'

# This code gets inserted into the generic elf32.sc linker script
# and allows us to define our own command line switches.
PARSE_AND_LIST_ARGS='
#define OPTION_TASO            300
/* Set the start address as in the Tru64 ld */
#define ALPHA_TEXT_START_32BIT 0x12000000

static int elf64alpha_32bit = 0;

static struct option longopts[] =
{
  {"taso", no_argument, NULL, OPTION_TASO},
  {NULL, no_argument, NULL, 0}
};

static void
gld_elf64alpha_list_options (file)
     FILE * file;
{
  fprintf (file, _(
"  -taso                       Load executable in the lower 31-bit addressable
                                virtual address range.\n"));
}

struct ld_emulation_xfer_struct ld_elf64alpha_emulation;
static void gld_elf64alpha_finish ();

static int
gld_elf64alpha_parse_args (argc, argv)
     int argc;
     char ** argv;
{
  int        longind;
  int        optc;
  int        prevoptind = optind;
  int        prevopterr = opterr;
  int        wanterror;
  static int lastoptind = -1;

  if (lastoptind != optind)
    opterr = 0;
  
  wanterror  = opterr;
  lastoptind = optind;

  optc   = getopt_long_only (argc, argv, "-", longopts, & longind);
  opterr = prevopterr;

  switch (optc)
    {
    default:
      if (wanterror)
       xexit (1);
      optind =  prevoptind;
      return 0;

    case EOF:
      if (elf64alpha_32bit && !link_info.shared && !link_info.relocateable)
	{
	  lang_section_start (".interp",
			      exp_binop ('\''+'\'',
					 exp_intop (ALPHA_TEXT_START_32BIT),
					 exp_nameop (SIZEOF_HEADERS, NULL)));
	  ld_elf64alpha_emulation.finish = gld_elf64alpha_finish;
	}
      return 0;

    case OPTION_TASO:
      elf64alpha_32bit = 1;
      break;
    }
  
  return 1;
}

#include "elf/internal.h"
#include "elf/alpha.h"
#include "elf-bfd.h"

static void
gld_elf64alpha_finish ()
{
  elf_elfheader (output_bfd)->e_flags |= EF_ALPHA_32BIT;
}'
