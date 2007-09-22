// common.h -- handle common symbols for gold   -*- C++ -*-

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

#ifndef GOLD_COMMON_H
#define GOLD_COMMON_H

#include "workqueue.h"

namespace gold
{

class General_options;
class Symbol_table;

// This task is used to allocate the common symbols.

class Allocate_commons_task : public Task
{
 public:
  Allocate_commons_task(const General_options& options, Symbol_table* symtab,
			Layout* layout, Task_token* symtab_lock,
			Task_token* blocker)
    : options_(options), symtab_(symtab), layout_(layout),
      symtab_lock_(symtab_lock), blocker_(blocker)
  { }

  // The standard Task methods.

  Is_runnable_type
  is_runnable(Workqueue*);

  Task_locker*
  locks(Workqueue*);

  void
  run(Workqueue*);

 private:
  class Allocate_commons_locker;

  const General_options& options_;
  Symbol_table* symtab_;
  Layout* layout_;
  Task_token* symtab_lock_;
  Task_token* blocker_;
};

} // End namespace gold.

#endif // !defined(GOLD_COMMON_H)
