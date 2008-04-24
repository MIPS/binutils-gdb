/* Handling of inferior events for the event loop for GDB, the GNU debugger.
   Copyright (C) 1999, 2007, 2008 Free Software Foundation, Inc.
   Written by Elena Zannoni <ezannoni@cygnus.com> of Cygnus Solutions.

   This file is part of GDB.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>. */

#include "defs.h"
#include "inferior.h"		/* For fetch_inferior_event. */
#include "target.h"             /* For enum inferior_event_type. */
#include "event-loop.h"
#include "event-top.h"
#include "inf-loop.h"
#include "remote.h"
#include "exceptions.h"
#include "language.h"

static int fetch_inferior_event_wrapper (gdb_client_data client_data);

void
inferior_event_handler_wrapper (gdb_client_data client_data)
{
  inferior_event_handler (INF_QUIT_REQ, client_data);
}

/* General function to handle events in the inferior. So far it just
   takes care of detecting errors reported by select() or poll(),
   otherwise it assumes that all is OK, and goes on reading data from
   the fd. This however may not always be what we want to do. */
void
inferior_event_handler (enum inferior_event_type event_type, 
			gdb_client_data client_data)
{
  int was_sync = 0;
  switch (event_type)
    {
    case INF_ERROR:
      printf_unfiltered (_("error detected from target.\n"));
      target_async (NULL, 0);
      pop_target ();
      do_all_continuations (1);
      async_enable_stdin ();
      break;

    case INF_REG_EVENT:
      /* Use catch errors for now, until the inner layers of
	 fetch_inferior_event (i.e. readchar) can return meaningful
	 error status.  If an error occurs while getting an event from
	 the target, just get rid of the target. */
      if (!catch_errors (fetch_inferior_event_wrapper, 
			 client_data, "", RETURN_MASK_ALL))
	{
	  target_async (NULL, 0);
	  pop_target ();
	  do_all_continuations (1);
	  async_enable_stdin ();
	  display_gdb_prompt (0);
	}
      break;

    case INF_EXEC_COMPLETE:

      /* This is the first thing to do -- so that continuations know that
	 the target is stopped.  For example, command_line_handler_continuation
	 will run breakpoint commands, and if we think that the target is
	 running, we'll refuse to execute most commands.  MI continuation
	 presently uses target_executing to either print or not print *stopped.  */
      target_executing = 0;

      /* Unregister the inferior from the event loop. This is done so that
	 when the inferior is not running we don't get distracted by
	 spurious inferior output.  */
      if (target_has_execution)
	target_async (NULL, 0);

      /* The call to async_enable_stdin below resets 'sync_execution'.
	 However, if sync_execution is 1 now, we also need to show the
	 prompt below, so save the current value.  */
      was_sync = sync_execution;
      async_enable_stdin ();

      /* If we were doing a multi-step (eg: step n, next n), but it
	 got interrupted by a breakpoint, still do the pending
	 continuations.  The continuation itself is responsible for
	 distinguishing the cases.  */
      do_all_intermediate_continuations (0);

      do_all_continuations (0);

      if (current_language != expected_language)
	{
	  if (language_mode == language_mode_auto)
	    {
	      language_info (1);	/* Print what changed.  */
	    }
	}

      /* If the continuation did not start the target again,
	 prepare for interation with the user.  */
      if (!target_executing)
	{              
	  if (was_sync)
	    {
	      display_gdb_prompt (0);
	    }
	  else
	    {
	      if (exec_done_display_p)
		printf_unfiltered (_("completed.\n"));
	    }
	}
      break;

    case INF_EXEC_CONTINUE:
      /* Is there anything left to do for the command issued to
         complete? */
      do_all_intermediate_continuations (0);
      break;

    case INF_QUIT_REQ: 
      /* FIXME: ezannoni 1999-10-04. This call should really be a
	 target vector entry, so that it can be used for any kind of
	 targets. */
      async_remote_interrupt_twice (NULL);
      break;

    case INF_TIMER:
    default:
      printf_unfiltered (_("Event type not recognized.\n"));
      break;
    }
}

static int 
fetch_inferior_event_wrapper (gdb_client_data client_data)
{
  fetch_inferior_event (client_data);
  return 1;
}
