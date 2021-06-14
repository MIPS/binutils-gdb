/* Support for signoring SIGTTOU.

   Copyright (C) 2003-2021 Free Software Foundation, Inc.

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
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

#ifndef SCOPED_IGNORE_SIGTTOU_H
#define SCOPED_IGNORE_SIGTTOU_H

#include "gdbsupport/scoped_ignore_signal.h"
#include "gdbsupport/job-control.h"
#include "gdbsupport/gdb_optional.h"

/* RAII class used to ignore SIGTTOU in a scope.  This isn't simply
   scoped_ignore_signal<SIGTTOU> because we want to check the
   `job_control' global.  */

#ifdef SIGTTOU
class scoped_ignore_sigttou
{
public:
  scoped_ignore_sigttou ()
  {
    if (job_control)
      m_ignore_signal.emplace ();
  }

  ~scoped_ignore_sigttou ()
  {
    if (job_control)
      m_ignore_signal.reset ();
  }

private:
  /* Could use an aligned buffer + placement new, but gdb::optional is
     so much more readable...  */
  gdb::optional<scoped_ignore_signal<SIGTTOU>> m_ignore_signal;
};
#else
using scoped_ignore_sigttou = scoped_ignore_signal_nop;
#endif

#endif /* SCOPED_IGNORE_SIGTTOU_H */
