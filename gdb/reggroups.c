/* Register groupings for GDB, the GNU debugger.

   Copyright 2002 Free Software Foundation, Inc.

   Contributed by Red Hat.

   This file is part of GDB.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place - Suite 330,
   Boston, MA 02111-1307, USA.  */

#include "defs.h"
#include "reggroups.h"
#include "gdbtypes.h"
#include "gdb_assert.h"
#include "regcache.h"
#include "command.h"
#include "gdbcmd.h"		/* For maintenanceprintlist.  */

/* Individual register groups.  */

struct reggroup
{
  const char *name;
  enum reggroup_type type;
};

struct reggroup *
reggroup_new (const char *name, enum reggroup_type type)
{
  struct reggroup *group = XMALLOC (struct reggroup);
  group->name = name;
  group->type = type;
  return group;
}

/* Register group attributes.  */

const char *
reggroup_name (struct reggroup *group)
{
  return group->name;
}

enum reggroup_type
reggroup_type (struct reggroup *group)
{
  return group->type;
}

/* All the groups for a given architecture.  */

struct reggroups
{
  int nr_group;
  struct reggroup **group;
};

static struct gdbarch_data *reggroups_data;

static void *
reggroups_init (struct gdbarch *gdbarch)
{
  struct reggroups *groups = XMALLOC (struct reggroups);
  groups->nr_group = 0;
  groups->group = NULL;
  return groups;
}

static void
reggroups_free (struct gdbarch *gdbarch, void *data)
{
  struct reggroups *groups = data;
  xfree (groups->group);
  xfree (groups);
}

/* Add a register group (with attribute values) to the pre-defined
   list.  This function can be called during architecture
   initialization and hence needs to handle NULL architecture groups.  */

static void
add_group (struct reggroups *groups, struct reggroup *group)
{
  gdb_assert (group != NULL);
  groups->nr_group++;
  groups->group = xrealloc (groups->group, (sizeof (struct reggroup *)
					    * (groups->nr_group + 1)));
  groups->group[groups->nr_group - 1] = group;
  groups->group[groups->nr_group] = NULL;
}

void
reggroup_add (struct gdbarch *gdbarch, struct reggroup *group)
{
  struct reggroups *groups = gdbarch_data (gdbarch, reggroups_data);
  if (groups == NULL)
    {
      /* ULGH, called during architecture initialization.  Patch
         things up.  */
      groups = reggroups_init (gdbarch);
      set_gdbarch_data (gdbarch, reggroups_data, groups);
    }
  add_group (groups, group);
}

/* The register groups for the current architecture.  Mumble something
   about the lifetime of the buffer....  */

static struct reggroups *default_groups;

struct reggroup * const*
reggroups (struct gdbarch *gdbarch)
{
  struct reggroups *groups = gdbarch_data (gdbarch, reggroups_data);
  /* Don't allow this function to be called during architecture
     creation.  */
  gdb_assert (groups != NULL);
  if (groups->group == NULL)
    return default_groups->group;
  else
    return groups->group;
}

/* Is REGNUM a member of REGGROUP?  */
int
default_register_reggroup_p (struct gdbarch *gdbarch, int regnum,
			     struct reggroup *group)
{
  int vector_p;
  int float_p;
  int raw_p;
  if (REGISTER_NAME (regnum) == NULL
      || *REGISTER_NAME (regnum) == '\0')
    return 0;
  if (group == all_reggroup)
    return 1;
  vector_p = TYPE_VECTOR (register_type (gdbarch, regnum));
  float_p = TYPE_CODE (register_type (gdbarch, regnum)) == TYPE_CODE_FLT;
  raw_p = regnum < gdbarch_num_regs (gdbarch);
  if (group == float_reggroup)
    return float_p;
  if (group == vector_reggroup)
    return vector_p;
  if (group == general_reggroup)
    return (!vector_p && !float_p);
  if (group == save_reggroup || group == restore_reggroup)
    return raw_p;
  return 0;   
}

/* Dump out a table of register groups for the current architecture.  */

static void
reggroups_dump (struct gdbarch *gdbarch, struct ui_file *file)
{
  struct reggroup *const *groups = reggroups (gdbarch);
  int i = -1;
  do
    {
      /* Group name.  */
      {
	const char *name;
	if (i < 0)
	  name = "Group";
	else
	  name = reggroup_name (groups[i]);
	fprintf_unfiltered (file, " %-10s", name);
      }
      
      /* Group type.  */
      {
	const char *type;
	if (i < 0)
	  type = "Type";
	else
	  {
	    switch (reggroup_type (groups[i]))
	      {
	      case USER_REGGROUP:
		type = "user";
		break;
	      case INTERNAL_REGGROUP:
		type = "internal";
		break;
	      default:
		internal_error (__FILE__, __LINE__, "bad switch");
	      }
	  }
	fprintf_unfiltered (file, " %-10s", type);
      }

      /* Note: If you change this, be sure to also update the
         documentation.  */
      
      fprintf_unfiltered (file, "\n");
      i++;
    }
  while (groups[i] != NULL);
}

static void
maintenance_print_reggroups (char *args, int from_tty)
{
  if (args == NULL)
    reggroups_dump (current_gdbarch, gdb_stdout);
  else
    {
      struct ui_file *file = gdb_fopen (args, "w");
      if (file == NULL)
	perror_with_name ("maintenance print reggroups");
      reggroups_dump (current_gdbarch, file);    
      ui_file_delete (file);
    }
}

/* Pre-defined register groups.  */
static struct reggroup general_group = { "general", USER_REGGROUP };
static struct reggroup float_group = { "float", USER_REGGROUP };
static struct reggroup system_group = { "system", USER_REGGROUP };
static struct reggroup vector_group = { "vector", USER_REGGROUP };
static struct reggroup all_group = { "all", USER_REGGROUP };
static struct reggroup save_group = { "save", INTERNAL_REGGROUP };
static struct reggroup restore_group = { "restore", INTERNAL_REGGROUP };

struct reggroup *const general_reggroup = &general_group;
struct reggroup *const float_reggroup = &float_group;
struct reggroup *const system_reggroup = &system_group;
struct reggroup *const vector_reggroup = &vector_group;
struct reggroup *const all_reggroup = &all_group;
struct reggroup *const save_reggroup = &save_group;
struct reggroup *const restore_reggroup = &restore_group;

void
_initialize_reggroup (void)
{
  reggroups_data = register_gdbarch_data (reggroups_init, reggroups_free);

  /* The pre-defined list of groups.  */
  default_groups = reggroups_init (NULL);
  add_group (default_groups, general_reggroup);
  add_group (default_groups, float_reggroup);
  add_group (default_groups, system_reggroup);
  add_group (default_groups, vector_reggroup);
  add_group (default_groups, all_reggroup);
  add_group (default_groups, save_reggroup);
  add_group (default_groups, restore_reggroup);


  add_cmd ("reggroups", class_maintenance,
	   maintenance_print_reggroups, "\
Print the internal register group names.\n\
Takes an optional file parameter.",
	   &maintenanceprintlist);

}
