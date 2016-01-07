/* TID parsing for GDB, the GNU debugger.

   Copyright (C) 2015-2016 Free Software Foundation, Inc.

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

#include "defs.h"
#include "tid-parse.h"
#include "inferior.h"
#include "gdbthread.h"
#include <ctype.h>

/* See tid-parse.h.  */

void ATTRIBUTE_NORETURN
invalid_thread_id_error (const char *string)
{
  error (_("Invalid thread ID: %s"), string);
}

/* See tid-parse.h.  */

struct thread_info *
parse_thread_id (const char *tidstr, const char **end)
{
  const char *number = tidstr;
  const char *dot, *p1;
  struct thread_info *tp;
  struct inferior *inf;
  int thr_num;
  int explicit_inf_id = 0;

  dot = strchr (number, '.');

  if (dot != NULL)
    {
      /* Parse number to the left of the dot.  */
      int inf_num;

      p1 = number;
      inf_num = get_number_trailer (&p1, '.');
      if (inf_num == 0)
	invalid_thread_id_error (number);

      inf = find_inferior_id (inf_num);
      if (inf == NULL)
	error (_("No inferior number '%d'"), inf_num);

      explicit_inf_id = 1;
      p1 = dot + 1;
    }
  else
    {
      inf = current_inferior ();

      p1 = number;
    }

  thr_num = get_number_const (&p1);
  if (thr_num == 0)
    invalid_thread_id_error (number);

  ALL_THREADS (tp)
    {
      if (ptid_get_pid (tp->ptid) == inf->pid
	  && tp->per_inf_num == thr_num)
	break;
    }

  if (tp == NULL)
    {
      if (show_inferior_qualified_tids () || explicit_inf_id)
	error (_("Unknown thread %d.%d."), inf->num, thr_num);
      else
	error (_("Unknown thread %d."), thr_num);
    }

  if (end != NULL)
    *end = p1;

  return tp;
}

/* See tid-parse.h.  */

void
tid_range_parser_init (struct tid_range_parser *parser, const char *tidlist,
		       int default_inferior)
{
  parser->state = TID_RANGE_STATE_INFERIOR;
  parser->string = tidlist;
  parser->inf_num = 0;
  parser->qualified = 0;
  parser->default_inferior = default_inferior;
}

/* See tid-parse.h.  */

int
tid_range_parser_finished (struct tid_range_parser *parser)
{
  switch (parser->state)
    {
    case TID_RANGE_STATE_INFERIOR:
      return *parser->string == '\0';
    case TID_RANGE_STATE_THREAD_RANGE:
      return parser->range_parser.finished;
    }

  gdb_assert_not_reached (_("unhandled state"));
}

/* See tid-parse.h.  */

const char *
tid_range_parser_string (struct tid_range_parser *parser)
{
  switch (parser->state)
    {
    case TID_RANGE_STATE_INFERIOR:
      return parser->string;
    case TID_RANGE_STATE_THREAD_RANGE:
      return parser->range_parser.string;
    }

  gdb_assert_not_reached (_("unhandled state"));
}

/* See tid-parse.h.  */

void
tid_range_parser_skip (struct tid_range_parser *parser)
{
  gdb_assert ((parser->state == TID_RANGE_STATE_THREAD_RANGE)
	      && parser->range_parser.in_range);

  tid_range_parser_init (parser, parser->range_parser.end_ptr,
			 parser->default_inferior);
}

/* See tid-parse.h.  */

int
tid_range_parser_qualified (struct tid_range_parser *parser)
{
  return parser->qualified;
}

/* Helper for tid_range_parser_get_tid and
   tid_range_parser_get_tid_range.  Return the next range if THR_END
   is non-NULL, return a single thread ID otherwise.  */

static int
get_tid_or_range (struct tid_range_parser *parser, int *inf_num,
		  int *thr_start, int *thr_end)
{
  if (parser->state == TID_RANGE_STATE_INFERIOR)
    {
      const char *p;
      const char *space;

      space = skip_to_space (parser->string);

      p = parser->string;
      while (p < space && *p != '.')
	p++;
      if (p < space)
	{
	  const char *dot = p;

	  /* Parse number to the left of the dot.  */
	  p = parser->string;
	  parser->inf_num = get_number_trailer (&p, '.');
	  if (parser->inf_num == 0)
	    invalid_thread_id_error (parser->string);

	  parser->qualified = 1;
	  p = dot + 1;

	  if (isspace (*p))
	    invalid_thread_id_error (parser->string);
	}
      else
	{
	  parser->inf_num = parser->default_inferior;
	  parser->qualified = 0;
	  p = parser->string;
	}

      init_number_or_range (&parser->range_parser, p);
      parser->state = TID_RANGE_STATE_THREAD_RANGE;
    }

  *inf_num = parser->inf_num;
  *thr_start = get_number_or_range (&parser->range_parser);
  if (*thr_start == 0)
    invalid_thread_id_error (parser->string);

  /* If we successfully parsed a thread number or finished parsing a
     thread range, switch back to assuming the next TID is
     inferior-qualified.  */
  if (parser->range_parser.end_ptr == NULL
      || parser->range_parser.string == parser->range_parser.end_ptr)
    {
      parser->state = TID_RANGE_STATE_INFERIOR;
      parser->string = parser->range_parser.string;

      if (thr_end != NULL)
	*thr_end = *thr_start;
    }

  /* If we're midway through a range, and the caller wants the end
     value, return it and skip to the end of the range.  */
  if (thr_end != NULL && parser->state == TID_RANGE_STATE_THREAD_RANGE)
    {
      *thr_end = parser->range_parser.end_value;
      tid_range_parser_skip (parser);
    }

  return (*inf_num != 0 && *thr_start != 0);
}

/* See tid-parse.h.  */

int
tid_range_parser_get_tid_range (struct tid_range_parser *parser, int *inf_num,
				int *thr_start, int *thr_end)
{
  gdb_assert (inf_num != NULL && thr_start != NULL && thr_end != NULL);

  return get_tid_or_range (parser, inf_num, thr_start, thr_end);
}

/* See tid-parse.h.  */

int
tid_range_parser_get_tid (struct tid_range_parser *parser,
			  int *inf_num, int *thr_num)
{
  gdb_assert (inf_num != NULL && thr_num != NULL);

  return get_tid_or_range (parser, inf_num, thr_num, NULL);
}

/* See tid-parse.h.  */

int
tid_is_in_list (const char *list, int default_inferior,
		int inf_num, int thr_num)
{
  struct tid_range_parser parser;

  if (list == NULL || *list == '\0')
    return 1;

  tid_range_parser_init (&parser, list, default_inferior);
  while (!tid_range_parser_finished (&parser))
    {
      int tmp_inf, tmp_thr_start, tmp_thr_end;

      if (!tid_range_parser_get_tid_range (&parser, &tmp_inf,
					   &tmp_thr_start, &tmp_thr_end))
	invalid_thread_id_error (parser.string);
      if (tmp_inf == inf_num
	  && tmp_thr_start <= thr_num && thr_num <= tmp_thr_end)
	return 1;
    }
  return 0;
}
