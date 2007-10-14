// main.cc -- gold main function.

// Copyright 2006, 2007 Free Software Foundation, Inc.
// Written by Ian Lance Taylor <iant@google.com>.

// This file is part of gold.

// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston,
// MA 02110-1301, USA.

#include "gold.h"

#ifdef HAVE_MALLINFO
#include <malloc.h>
#endif
#include "libiberty.h"

#include "options.h"
#include "parameters.h"
#include "errors.h"
#include "dirsearch.h"
#include "workqueue.h"
#include "object.h"
#include "symtab.h"
#include "layout.h"

using namespace gold;

int
main(int argc, char** argv)
{
#if defined (HAVE_SETLOCALE) && defined (HAVE_LC_MESSAGES)
  setlocale (LC_MESSAGES, "");
#endif
#if defined (HAVE_SETLOCALE)
  setlocale (LC_CTYPE, "");
#endif
  bindtextdomain (PACKAGE, LOCALEDIR);
  textdomain (PACKAGE);

  program_name = argv[0];

  Errors errors(program_name);

  // Handle the command line options.
  Command_line command_line;
  command_line.process(argc - 1, argv + 1);

  long start_time = 0;
  if (command_line.options().print_stats())
    start_time = get_run_time();

  initialize_parameters(&command_line.options(), &errors);

  // The work queue.
  Workqueue workqueue(command_line.options());

  // The list of input objects.
  Input_objects input_objects;

  // The symbol table.
  Symbol_table symtab;

  // The layout object.
  Layout layout(command_line.options());

  // Get the search path from the -L options.
  Dirsearch search_path;
  search_path.initialize(&workqueue, &command_line.options().search_path());

  // Queue up the first set of tasks.
  queue_initial_tasks(command_line.options(), search_path,
		      command_line, &workqueue, &input_objects,
		      &symtab, &layout);

  // Run the main task processing loop.
  workqueue.process();

  if (command_line.options().print_stats())
    {
      long run_time = get_run_time() - start_time;
      fprintf(stderr, _("%s: total run time: %ld.%06ld seconds\n"),
	      program_name, run_time / 1000000, run_time % 1000000);
#ifdef HAVE_MALLINFO
      struct mallinfo m = mallinfo();
      fprintf(stderr, _("%s: total space allocated by malloc: %d bytes\n"),
	      program_name, m.arena);
#endif
      File_read::print_stats();
      fprintf(stderr, _("%s: output file size: %lld bytes\n"),
	      program_name, static_cast<long long>(layout.output_file_size()));
    }

  gold_exit(errors.error_count() == 0);
}
