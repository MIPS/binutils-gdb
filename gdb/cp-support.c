/* Helper routines for C++ support in GDB.
   Copyright 2002, 2003 Free Software Foundation, Inc.

   Contributed by MontaVista Software.

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
#include <ctype.h>
#include "cp-support.h"
#include "gdb_string.h"
#include "demangle.h"
#include "gdb_assert.h"
#include "symtab.h"
#include "gdbcmd.h"
#include "dictionary.h"
#include "objfiles.h"
#include "frame.h"
#include "symtab.h"
#include "block.h"

/* Functions/variables related to overload resolution.  */

static int sym_return_val_size;
static int sym_return_val_index;
static struct symbol **sym_return_val;

static void overload_list_add_symbol (struct symbol *sym,
				      const char *oload_name);

static void make_symbol_overload_list_using (const char *func_name,
					     const char *namespace,
					     const struct block *block);

static void make_symbol_overload_list_qualified (const char *func_name);

static void read_in_psymtabs (const char *oload_name);

/* The list of "maint cplus" commands.  */

struct cmd_list_element *maint_cplus_cmd_list = NULL;

/* The actual commands.  */

static void maint_cplus_command (char *arg, int from_tty);
static void first_component_command (char *arg, int from_tty);

static const char *find_last_component (const char *name);

/* Here are some random pieces of trivia to keep in mind while trying
   to take apart demangled names:

   - Names can contain function arguments or templates, so the process
     has to be, to some extent recursive: maybe keep track of your
     depth based on encountering <> and ().

   - Parentheses don't just have to happen at the end of a name: they
     can occur even if the name in question isn't a function, because
     a template argument might be a type that's a function.

   - Conversely, even if you're trying to deal with a function, its
     demangled name might not end with ')': it could be a const or
     volatile class method, in which case it ends with "const" or
     "volatile".

   - Parentheses are also used in anonymous namespaces: a variable
     'foo' in an anonymous namespace gets demangled as "(anonymous
     namespace)::foo".

   - And operator names can contain parentheses or angle brackets.  */

/* FIXME: carlton/2003-03-13: We have several functions here with
   overlapping functionality; can we combine them?  Also, do they
   handle all the above considerations correctly?  */

/* Find the last component of the demangled C++ name NAME.  NAME
   must be a method name including arguments, in order to correctly
   locate the last component.

   This function return a pointer to the first colon before the
   last component, or NULL if the name had only one component.  */

static const char *
find_last_component (const char *name)
{
  const char *p;
  int depth;

  /* Functions can have local classes, so we need to find the
     beginning of the last argument list, not the end of the first
     one.  */
  p = name + strlen (name) - 1;
  while (p > name && *p != ')')
    p--;

  if (p == name)
    return NULL;

  /* P now points at the `)' at the end of the argument list.  Walk
     back to the beginning.  */
  p--;
  depth = 1;
  while (p > name && depth > 0)
    {
      if (*p == '<' || *p == '(')
	depth--;
      else if (*p == '>' || *p == ')')
	depth++;
      p--;
    }

  if (p == name)
    return NULL;

  while (p > name && *p != ':')
    p--;

  if (p == name || p == name + 1 || p[-1] != ':')
    return NULL;

  return p - 1;
}

/* Return the name of the class containing method PHYSNAME.  */

char *
class_name_from_physname (const char *physname)
{
  char *ret = NULL;
  const char *end;
  int depth = 0;
  char *demangled_name = cplus_demangle (physname, DMGL_ANSI);

  if (demangled_name == NULL)
    return NULL;

  end = find_last_component (demangled_name);
  if (end != NULL)
    {
      ret = xmalloc (end - demangled_name + 1);
      memcpy (ret, demangled_name, end - demangled_name);
      ret[end - demangled_name] = '\0';
    }

  xfree (demangled_name);
  return ret;
}

/* Return the name of the method whose linkage name is PHYSNAME.  */

char *
method_name_from_physname (const char *physname)
{
  char *ret = NULL;
  const char *end;
  int depth = 0;
  char *demangled_name = cplus_demangle (physname, DMGL_ANSI);

  if (demangled_name == NULL)
    return NULL;

  end = find_last_component (demangled_name);
  if (end != NULL)
    {
      char *args;
      int len;

      /* Skip "::".  */
      end = end + 2;

      /* Find the argument list, if any.  */
      args = strchr (end, '(');
      if (args == NULL)
	len = strlen (end + 2);
      else
	{
	  args --;
	  while (*args == ' ')
	    args --;
	  len = args - end + 1;
	}
      ret = xmalloc (len + 1);
      memcpy (ret, end, len);
      ret[len] = 0;
    }

  xfree (demangled_name);
  return ret;
}

/* This returns the length of first component of NAME, which should be
   the demangled name of a C++ variable/function/method/etc.
   Specifically, it returns the index of the first colon forming the
   boundary of the first component: so, given 'A::foo' or 'A::B::foo'
   it returns the 1, and given 'foo', it returns 0.  */

/* Well, that's what it should do when called externally, but to make
   the recursion easier, it also stops if it reaches an unexpected ')'
   or '>'.  */

/* NOTE: carlton/2003-03-13: This function is currently only intended
   for internal use: it's probably not entirely safe when called on
   user-generated input, because some of the 'index += 2' lines might
   go past the end of malformed input.  */

/* Let's optimize away calls to strlen("operator").  */

#define LENGTH_OF_OPERATOR 8

unsigned int
cp_find_first_component (const char *name)
{
  unsigned int index = 0;
  /* Operator names can show up in unexpected places.  Since these can
     contain parentheses or angle brackets, they can screw up the
     recursion.  But not every string 'operator' is part of an
     operater name: e.g. you could have a variable 'cooperator'.  So
     this variable tells us whether or not we should treat the string
     'operator' as starting an operator.  */
  int operator_possible = 1;

  for (;; ++index)
    {
      switch (name[index])
	{
	case '<':
	  /* Template; eat it up.  The calls to cp_first_component
	     should only return (I hope!) when they reach the '>'
	     terminating the component or a '::' between two
	     components.  (Hence the '+ 2'.)  */
	  index += 1;
	  for (index += cp_find_first_component (name + index);
	       name[index] != '>';
	       index += cp_find_first_component (name + index))
	    {
	      gdb_assert (name[index] == ':');
	      index += 2;
	    }
	  operator_possible = 1;
	  break;
	case '(':
	  /* Similar comment as to '<'.  */
	  index += 1;
	  for (index += cp_find_first_component (name + index);
	       name[index] != ')';
	       index += cp_find_first_component (name + index))
	    {
	      gdb_assert (name[index] == ':');
	      index += 2;
	    }
	  operator_possible = 1;
	  break;
	case '>':
	case ')':
	case '\0':
	case ':':
	  return index;
	case 'o':
	  /* Operator names can screw up the recursion.  */
	  if (operator_possible
	      && strncmp (name + index, "operator", LENGTH_OF_OPERATOR) == 0)
	    {
	      index += LENGTH_OF_OPERATOR;
	      while (isspace(name[index]))
		++index;
	      switch (name[index])
		{
		  /* Skip over one less than the appropriate number of
		     characters: the for loop will skip over the last
		     one.  */
		case '<':
		  if (name[index + 1] == '<')
		    index += 1;
		  else
		    index += 0;
		  break;
		case '>':
		case '-':
		  if (name[index + 1] == '>')
		    index += 1;
		  else
		    index += 0;
		  break;
		case '(':
		  index += 1;
		  break;
		default:
		  index += 0;
		  break;
		}
	    }
	  operator_possible = 0;
	  break;
	case ' ':
	case ',':
	case '.':
	case '&':
	case '*':
	  /* NOTE: carlton/2003-04-18: I'm not sure what the precise
	     set of relevant characters are here: it's necessary to
	     include any character that can show up before 'operator'
	     in a demangled name, and it's safe to include any
	     character that can't be part of an identifier's name.  */
	  operator_possible = 1;
	  break;
	default:
	  operator_possible = 0;
	  break;
	}
    }
}

/* If NAME is the fully-qualified name of a C++
   function/variable/method/etc., this returns the length of its
   entire prefix: all of the namespaces and classes that make up its
   name.  Given 'A::foo', it returns 1, given 'A::B::foo', it returns
   4, given 'foo', it returns 0.  */

unsigned int
cp_entire_prefix_len (const char *name)
{
  unsigned int current_len = cp_find_first_component (name);
  unsigned int previous_len = 0;

  while (name[current_len] != '\0')
    {
      gdb_assert (name[current_len] == ':');
      previous_len = current_len;
      /* Skip the '::'.  */
      current_len += 2;
      current_len += cp_find_first_component (name + current_len);
    }

  return previous_len;
}

/* If FULL_NAME is the demangled name of a C++ function (including an
   arg list, possibly including namespace/class qualifications),
   return a new string containing only the function name (without the
   arg list/class qualifications).  Otherwise, return NULL.  Caller is
   responsible for freeing the memory in question.  */

char *
cp_func_name (const char *full_name)
{
  const char *previous_component = full_name;
  const char *next_component;

  if (!full_name)
    return NULL;

  for (next_component = (previous_component
			 + cp_find_first_component (previous_component));
       *next_component == ':';
       next_component = (previous_component
			 + cp_find_first_component (previous_component)))
    {
      /* Skip '::'.  */
      previous_component = next_component + 2;
    }

  return remove_params (previous_component);
}

/* Overload resolution functions.  */

char *
remove_params (const char *demangled_name)
{
  const char *argp;
  char *new_name;
  int depth;

  if (demangled_name == NULL)
    return NULL;

  /* First find the end of the arg list.  */
  argp = strrchr (demangled_name, ')');
  if (argp == NULL)
    return NULL;

  /* Back up to the beginning.  */
  depth = 1;

  while (argp-- > demangled_name)
    {
      if (*argp == ')')
	depth ++;
      else if (*argp == '(')
	{
	  depth --;

	  if (depth == 0)
	    break;
	}
    }
  if (depth != 0)
    internal_error (__FILE__, __LINE__,
		    "bad demangled name %s\n", demangled_name);
  while (argp[-1] == ' ' && argp > demangled_name)
    argp --;

  new_name = xmalloc (argp - demangled_name + 1);
  memcpy (new_name, demangled_name, argp - demangled_name);
  new_name[argp - demangled_name] = '\0';
  return new_name;
}

/* Helper routine for make_symbol_completion_list.  */

static int sym_return_val_size;
static int sym_return_val_index;
static struct symbol **sym_return_val;

/*  Test to see if the symbol specified by SYMNAME (which is already
   demangled for C++ symbols) matches SYM_TEXT in the first SYM_TEXT_LEN
   characters.  If so, add it to the current completion list. */

static void
overload_list_add_symbol (struct symbol *sym, const char *oload_name)
{
  int newsize;
  int i;
  char *sym_name;

  /* If there is no type information, we can't do anything, so skip */
  if (SYMBOL_TYPE (sym) == NULL)
    return;

  /* skip any symbols that we've already considered. */
  for (i = 0; i < sym_return_val_index; ++i)
    if (!strcmp (DEPRECATED_SYMBOL_NAME (sym), DEPRECATED_SYMBOL_NAME (sym_return_val[i])))
      return;

  /* Get the demangled name without parameters */
  sym_name = remove_params (SYMBOL_DEMANGLED_NAME (sym));
  if (!sym_name)
    return;

  /* skip symbols that cannot match */
  if (strcmp (sym_name, oload_name) != 0)
    {
      xfree (sym_name);
      return;
    }

  xfree (sym_name);

  /* We have a match for an overload instance, so add SYM to the current list
   * of overload instances */
  if (sym_return_val_index + 3 > sym_return_val_size)
    {
      newsize = (sym_return_val_size *= 2) * sizeof (struct symbol *);
      sym_return_val = (struct symbol **) xrealloc ((char *) sym_return_val, newsize);
    }
  sym_return_val[sym_return_val_index++] = sym;
  sym_return_val[sym_return_val_index] = NULL;
}

/* Return a null-terminated list of pointers to function symbols that
   match name of the supplied symbol FSYM and that occur within the
   namespace given by the initial substring of NAMESPACE_NAME of
   length NAMESPACE_LEN.  Apply using directives from BLOCK.  This is
   used in finding all overloaded instances of a function name.  This
   has been modified from make_symbol_completion_list.  */

/* FIXME: carlton/2003-01-30: Should BLOCK be here?  Maybe it's better
   to use get_selected_block (0).  */

struct symbol **
make_symbol_overload_list (const char *func_name,
			   const char *namespace,
			   const struct block *block)
{
  struct cleanup *old_cleanups;

  sym_return_val_size = 100;
  sym_return_val_index = 0;
  sym_return_val = xmalloc ((sym_return_val_size + 1) *
			    sizeof (struct symbol *));
  sym_return_val[0] = NULL;

  old_cleanups = make_cleanup (xfree, sym_return_val);

  make_symbol_overload_list_using (func_name, namespace,
				   block);

  discard_cleanups (old_cleanups);

  return sym_return_val;
}

/* This applies the using directives to add namespaces to search in,
   and then searches for overloads in all of those namespaces.  It
   adds the symbols found to sym_return_val.  Arguments are as in
   make_symbol_overload_list.  */

static void
make_symbol_overload_list_using (const char *func_name,
				 const char *namespace,
				 const struct block *block)
{
  const struct using_direct *current;

  /* First, go through the using directives.  If any of them apply,
     look in the appropriate namespaces for new functions to match
     on.  */

  for (current = block_using (block);
       current != NULL;
       current = current->next)
    {
      if (strcmp (namespace, current->outer) == 0)
	{
	  make_symbol_overload_list_using (func_name,
					   current->inner,
					   block);
	}
    }

  /* Now, add names for this namespace.  */
  
  if (namespace[0] == '\0')
    {
      make_symbol_overload_list_qualified (func_name);
    }
  else
    {
      char *concatenated_name
	= alloca (strlen (namespace) + 2 + strlen (func_name) + 1);
      strcpy (concatenated_name, namespace);
      strcat (concatenated_name, "::");
      strcat (concatenated_name, func_name);
      make_symbol_overload_list_qualified (concatenated_name);
    }
}

/* This does the bulk of the work of finding overloaded symbols.
   FUNC_NAME is the name of the overloaded function we're looking for
   (possibly including namespace info); NEW_LIST is 1 if we should
   allocate a new list of overloads and 0 if we should continue using
   the same old list.  */

static void
make_symbol_overload_list_qualified (const char *func_name)
{
  struct symbol *sym;
  struct symtab *s;
  struct objfile *objfile;
  const struct block *b, *surrounding_static_block = 0;
  struct dict_iterator iter;
  const struct dictionary *dict;

  /* Look through the partial symtabs for all symbols which begin
     by matching FUNC_NAME.  Make sure we read that symbol table in. */

  read_in_psymtabs (func_name);

  /* Search upwards from currently selected frame (so that we can
     complete on local vars.  */

  for (b = get_selected_block (0); b != NULL; b = BLOCK_SUPERBLOCK (b))
    {
      dict = BLOCK_DICT (b);

      for (sym = dict_iter_name_first (dict, func_name, &iter);
	   sym;
	   sym = dict_iter_name_next (func_name, &iter))
	{
	  overload_list_add_symbol (sym, func_name);
	}
    }

  surrounding_static_block = block_static_block (get_selected_block (0));

  /* Go through the symtabs and check the externs and statics for
     symbols which match.  */

  /* FIXME: carlton/2003-01-30: Why are we checking all the statics?
     Also, this shouldn't check all the globals if there's an
     anonymous namespace involved somewhere.  */

  ALL_SYMTABS (objfile, s)
  {
    QUIT;
    b = BLOCKVECTOR_BLOCK (BLOCKVECTOR (s), GLOBAL_BLOCK);
    dict = BLOCK_DICT (b);

    for (sym = dict_iter_name_first (dict, func_name, &iter);
	 sym;
	 sym = dict_iter_name_next (func_name, &iter))
    {
      overload_list_add_symbol (sym, func_name);
    }
  }

  ALL_SYMTABS (objfile, s)
  {
    QUIT;
    b = BLOCKVECTOR_BLOCK (BLOCKVECTOR (s), STATIC_BLOCK);
    /* Don't do this block twice.  */
    if (b == surrounding_static_block)
      continue;
    dict = BLOCK_DICT (b);

    for (sym = dict_iter_name_first (dict, func_name, &iter);
	 sym;
	 sym = dict_iter_name_next (func_name, &iter))
    {
      overload_list_add_symbol (sym, func_name);
    }
  }
}

/* Look through the partial symtabs for all symbols which begin
   by matching FUNC_NAME.  Make sure we read that symbol table in. */

static void
read_in_psymtabs (const char *func_name)
{
  struct partial_symtab *ps;
  struct objfile *objfile;

  ALL_PSYMTABS (objfile, ps)
  {
    if (ps->readin)
      continue;

    if ((lookup_partial_symbol (ps, func_name, NULL, 1, VAR_DOMAIN)
	 != NULL)
	|| (lookup_partial_symbol (ps, func_name, NULL, 0, VAR_DOMAIN)
	    != NULL))
      psymtab_to_symtab (ps);
  }
}

/* Don't allow just "maintenance cplus".  */

static  void
maint_cplus_command (char *arg, int from_tty)
{
  printf_unfiltered ("\"maintenance cplus\" must be followed by the name of a command.\n");
  help_list (maint_cplus_cmd_list, "maintenance cplus ", -1, gdb_stdout);
}

/* This is a front end for cp_find_first_component, for unit testing.
   Be careful when using it: see the NOTE above
   cp_find_first_component.  */

static void
first_component_command (char *arg, int from_tty)
{
  int len = cp_find_first_component (arg);
  char *prefix = alloca (len + 1);

  memcpy (prefix, arg, len);
  prefix[len] = '\0';

  printf_unfiltered ("%s\n", prefix);
}

extern initialize_file_ftype _initialize_cp_support; /* -Wmissing-prototypes */

void
_initialize_cp_support (void)
{
  add_prefix_cmd ("cplus", class_maintenance, maint_cplus_command,
		  "C++ maintenance commands.", &maint_cplus_cmd_list,
		  "maintenance cplus ", 0, &maintenancelist);
  add_alias_cmd ("cp", "cplus", class_maintenance, 1, &maintenancelist);

  add_cmd ("first_component", class_maintenance, first_component_command,
	   "Print the first class/namespace component of NAME.",
	   &maint_cplus_cmd_list);
}
