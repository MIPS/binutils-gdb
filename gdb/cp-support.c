/* Helper routines for C++ support in GDB.
   Copyright 2002 Free Software Foundation, Inc.

   Contributed by MontaVista Software and by David Carlton, Stanford
   University.

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
#include "cp-support.h"
#include "gdb_string.h"
#include "demangle.h"
#include "gdb_obstack.h"
#include "gdb_assert.h"
#include "symtab.h"
#include "symfile.h"
#include "block.h"
#include "objfiles.h"
#include "gdbtypes.h"
#include "dictionary.h"
#include "gdbcmd.h"

static const char *find_last_component (const char *name);

/* This block exists only to store symbols associated to namespaces.
   Normally, try to avoid accessing it directly: instead, use
   get_namespace_block if you can.  Similarly with
   possible_namespace_block and namespace_objfile.  */

static struct block *namespace_block = NULL;

static struct block *possible_namespace_block = NULL;

static struct objfile *namespace_objfile = NULL;

static void initialize_namespace_blocks (void);

static struct block *get_namespace_block (void);

static struct block *get_possible_namespace_block (void);

static struct objfile *get_namespace_objfile (void);

static void free_namespace_blocks (struct symtab *symtab);

static int check_one_possible_namespace_symbol (const char *name,
						int len);

static int check_possible_namespace_symbols_loop (const char *name,
						  int len);

static void maintenance_print_namespace (char *args, int from_tty);

/* Here are some random pieces of trivia to keep in mind while trying
   to take apart demangled names:

   - Names can contain function arguments or templates, so the process
     has to be, to some extent recursive: maybe keep track of your
     depth based on encountering <> and ().

   - Parentheses don't just have to happen at the end of a name: they
     can occur even if the name in question isn't a function, because
     a template argument might be a type that's a function.

   - Conversely, even if you're trying to deal with a function, its
     demangled name might not end with ')': it could be a const (or
     volatile, I suppose) class method, in which case it ends with
     "const".

   - Parentheses are also used in anonymous namespaces: a variable
     'foo' in an anonymous namespace gets demangled as "(anonymous
     namespace)::foo".

   - And operator names can contain parentheses or angle brackets.
     Fortunately, I _think_ that operator names can only occur in a
     fairly restrictive set of locations (in particular, they have be
     at depth 0, don't they?).  */

/* NOTE: carlton/2002-10-25: Daniel Jacobowitz came up with an example
   where operator names don't occur at depth 0.  Sigh.  (It involved a
   template argument that was a pointer: I hadn't realized that was
   possible.)  Handling such edge cases does not seem like a
   high-priority problem to me.  */

/* FIXME: carlton/2002-10-09: Do all the functions here handle all the
   above considerations correctly?  */

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

/* This allocates a new using_direct structure initialized to contain
   NAME, OUTER_LENGTH, and INNER_LENGTH, and puts it at the beginning
   of the linked list given by NEXT.  It returns the resulting struct
   using_direct_node.  All memory is allocated using OBSTACK.  */

struct using_direct_node *
cp_add_using_obstack (const char *name,
		      unsigned short outer_length,
		      unsigned short inner_length,
		      struct using_direct_node *next,
		      struct obstack *obstack)
{
  struct using_direct *current
    = obstack_alloc (obstack, sizeof (struct using_direct));
  struct using_direct_node *retval
    = obstack_alloc (obstack, sizeof (struct using_direct_node));

  gdb_assert (outer_length < inner_length);

  current->name = name;
  current->outer_length = outer_length;
  current->inner_length = inner_length;
  retval->current = current;
  retval->next = next;

  return retval;
}

/* Same as cp_add_using, except that it uses xmalloc instead of
   obstacks.  */

struct using_direct_node *
cp_add_using_xmalloc (const char *name,
		      unsigned short outer_length,
		      unsigned short inner_length,
		      struct using_direct_node *next)
{
  struct using_direct *current = xmalloc (sizeof (struct using_direct));
  struct using_direct_node *retval
    = xmalloc (sizeof (struct using_direct_node));

  gdb_assert (outer_length < inner_length);

  current->name = name;
  current->outer_length = outer_length;
  current->inner_length = inner_length;
  retval->current = current;
  retval->next = next;

  return retval;
}

/* This copies the using_direct_nodes in TOCOPY, using xmalloc, and
   sticks them onto a list ending in TAIL.  (It doesn't copy the
   using_directs, just the using_direct_nodes.)  */

struct using_direct_node *
cp_copy_usings (struct using_direct_node *tocopy,
		struct using_direct_node *tail)
{
  struct using_direct_node *new_node;
  
  if (tocopy == NULL)
    return tail;

  new_node = xmalloc (sizeof (struct using_direct_node));
  new_node->current = tocopy->current;
  new_node->next = cp_copy_usings (tocopy->next, tail);

  return new_node;
}

/* This xfree's all the using_direct_nodes in USING (but not their
   using_directs!)  */
void
cp_free_usings (struct using_direct_node *using)
{
  struct using_direct_node *next;

  if (using != NULL)
    {
      for (next = using->next; next;
	   using = next, next = next->next)
	xfree (using);
      
      xfree (using);
    }
}


/* This returns the first component of NAME, which should be the
   demangled name of a C++ variable/function/method/etc.
   Specifically, it returns a pointer to the first colon forming the
   boundary of the first component: so, given 'A::foo' or 'A::B::foo'
   it returns a pointer to the first :, and given 'foo', it returns a
   pointer to the trailing '\0'.  */

/* Well, that's what it should do when called externally, but to make
   the recursion easier, it also stops if it reaches an unexpected ')'
   or '>'.  */

/* Let's optimize away calls to strlen("operator").  */

#define LENGTH_OF_OPERATOR 8

const char *
cp_find_first_component (const char *name)
{
  /* Names like 'operator<<' screw up the recursion, so let's
     special-case them.  I _hope_ they can only occur at the start of
     a component.  */

  if (strncmp (name, "operator", LENGTH_OF_OPERATOR) == 0)
    {
      name += LENGTH_OF_OPERATOR;
      switch (*name)
	{
	case '<':
	  if (name[1] == '<')
	    name += 2;
	  else
	    name += 1;
	  break;
	case '>':
	case '-':
	  if (name[1] == '>')
	    name +=2;
	  else
	    name += 1;
	  break;
	case '(':
	  name += 2;
	  break;
	default:
	  name += 1;
	  break;
	}
    }

  for (;; ++name)
    {
      switch (*name)
	{
	case '<':
	  /* Template; eat it up.  The calls to cp_first_component
	     should only return (I hope!) when they reach the '>'
	     terminating the component or a '::' between two
	     components.  (Hence the '+ 2'.)  */
	  for (name = cp_find_first_component (name + 1);
	       *name != '>';
	       name = cp_find_first_component (name + 2))
	    gdb_assert (*name == ':');
	  break;
	case '(':
	  /* Similar comment as to '<'.  */
	  for (name = cp_find_first_component (name + 1);
	       *name != ')';
	       name = cp_find_first_component (name + 2))
	    gdb_assert (*name == ':');
	  break;
	case '>':
	case ')':
	case '\0':
	case ':':
	  return name;
	default:
	  break;
	}
    }
}

/* Allocate everything necessary for namespace_block and
   possible_namespace_block.  */

static void
initialize_namespace_blocks (void)
{
  struct objfile *objfile = get_namespace_objfile ();
  struct symtab *namespace_symtab;
  struct blockvector *bv;
  struct block *bl;

  namespace_symtab = allocate_symtab ("<C++-namespaces>", objfile);
  namespace_symtab->language = language_cplus;
  namespace_symtab->free_code = free_nothing;
  namespace_symtab->dirname = NULL;

  /* 2 = 3 blocks (global = namespace_block, static = NULL,
     possible_namespace_block) - 1 block that's always part of struct
     blockvector.  */
  bv = obstack_alloc (&objfile->symbol_obstack,
		      sizeof (struct blockvector)
		      + 2 * sizeof (struct block *));
  BLOCKVECTOR_NBLOCKS (bv) = 3;
  BLOCKVECTOR (namespace_symtab) = bv;
  
  /* Allocate dummy STATIC_BLOCK. */
  bl = allocate_block (&objfile->symbol_obstack);
  BLOCK_DICT (bl) = dict_create_linear (&objfile->symbol_obstack,
					NULL);
  BLOCKVECTOR_BLOCK (bv, STATIC_BLOCK) = bl;

  /* Allocate GLOBAL_BLOCK, which is namespace_block.  */
  bl = allocate_block (&objfile->symbol_obstack);
  BLOCK_DICT (bl) = dict_create_linear_expandable ();
  BLOCKVECTOR_BLOCK (bv, GLOBAL_BLOCK) = bl;
  namespace_block = bl;

  /* Allocate possible_namespace_block; we put it where the first
     local block will live, though I don't think there's any need to
     pretend that it's actually a local block (e.g. by setting
     BLOCK_SUPERBLOCK appropriately).  */
  bl = allocate_block (&objfile->symbol_obstack);
  BLOCK_DICT (bl) = dict_create_linear_expandable ();
  BLOCKVECTOR_BLOCK (bv, 2) = bl;
  possible_namespace_block = bl;

  namespace_symtab->free_func = free_namespace_blocks;
}

/* Locate namespace_block, allocating it if necessary.  */

static struct block *
get_namespace_block (void)
{
  if (namespace_block == NULL)
    initialize_namespace_blocks ();

  return namespace_block;
}

/* Locate possible_namespace_block, allocating it if necessary.  */

static struct block *
get_possible_namespace_block (void)
{
  if (namespace_block == NULL)
    initialize_namespace_blocks ();

  return possible_namespace_block;
}

/* Free the dictionary associated to the namespace block.  */

static void
free_namespace_blocks (struct symtab *symtab)
{
  gdb_assert (namespace_block != NULL);
  dict_free (BLOCK_DICT (namespace_block));
  namespace_block = NULL;
  dict_free (BLOCK_DICT (possible_namespace_block));
  possible_namespace_block = NULL;
  namespace_objfile = NULL;
}

/* Locate the namespace objfile, allocating it if necessary.  */

static struct objfile *
get_namespace_objfile (void)
{
  if (namespace_objfile == NULL)
    {
      namespace_objfile = allocate_objfile (NULL, 0);
      namespace_objfile->name = "<C++-namespaces>";
    }

  return namespace_objfile;
}

/* Check to see if there's already a namespace symbol corresponding to
   the initial substring of NAME whose length is LEN; if there isn't
   one, allocate one and add it to the namespace symtab.  Return the
   symbol in question.  */

struct symbol *
cp_check_namespace_symbol (const char *name, int len)
{
  struct objfile *objfile = get_namespace_objfile ();
  char *name_copy = obsavestring (name, len, &objfile->symbol_obstack);
  struct symbol *sym = cp_lookup_namespace_symbol (name_copy);

  if (sym == NULL)
    {
      struct type *type = init_type (TYPE_CODE_NAMESPACE, 0, 0,
				     name_copy, objfile);
      TYPE_TAG_NAME (type) = TYPE_NAME (type);

      sym = obstack_alloc (&objfile->symbol_obstack, sizeof (struct symbol));
      memset (sym, 0, sizeof (struct symbol));
      SYMBOL_LANGUAGE (sym) = language_cplus;
      SYMBOL_NAME (sym) = name_copy;
      SYMBOL_CLASS (sym) = LOC_TYPEDEF;
      SYMBOL_TYPE (sym) = type;
      SYMBOL_NAMESPACE (sym) = VAR_NAMESPACE;

      dict_add_symbol (BLOCK_DICT (get_namespace_block ()), sym);
    }
  else
    {
      obstack_free (&objfile->symbol_obstack, name_copy);
    }

  return sym;
}

/* Look for a symbol in namespace_block named NAME.  */

struct symbol *
cp_lookup_namespace_symbol (const char *name)
{
  return lookup_block_symbol (get_namespace_block (), name, NULL,
			      VAR_NAMESPACE);
}

/* The next few functions deal with "possible namespace symbols".
   These are symbols that claim to be associated to namespaces,
   whereas in fact we don't know if the object of that name is a
   namespace or a class.  So don't trust them until you've searched
   through all the global symbols to see if there's a class of that
   name or not.  */

/* FIXME: carlton/2002-12-18: This concept is a hack.  But it seems to
   be the easiest way to deal with our desire for namespace symbols,
   given the commonness of compilers that don't generate debugging
   info for them.  Once such compilers are more common, we should
   delete all the possible namespace stuff.  */

/* Check to see if there's already a possible namespace symbol whose
   name is the initial substring of NAME of length LEN.  If not,
   create one and return 0; otherwise, return 1.  */

static int
check_one_possible_namespace_symbol (const char *name, int len)
{
  struct objfile *objfile = get_namespace_objfile ();
  char *name_copy = obsavestring (name, len, &objfile->symbol_obstack);
  const struct block *block = get_possible_namespace_block ();
  struct symbol *sym = lookup_block_symbol (block, name_copy,
					    NULL, VAR_NAMESPACE);

  if (sym == NULL)
    {
      struct type *type = init_type (TYPE_CODE_NAMESPACE, 0, 0,
				     name_copy, objfile);
      TYPE_TAG_NAME (type) = TYPE_NAME (type);

      sym = obstack_alloc (&objfile->symbol_obstack, sizeof (struct symbol));
      memset (sym, 0, sizeof (struct symbol));
      SYMBOL_LANGUAGE (sym) = language_cplus;
      SYMBOL_NAME (sym) = name_copy;
      SYMBOL_CLASS (sym) = LOC_TYPEDEF;
      SYMBOL_TYPE (sym) = type;
      SYMBOL_NAMESPACE (sym) = VAR_NAMESPACE;

      dict_add_symbol (BLOCK_DICT (block), sym);
      return 0;
    }
  else
    {
      obstack_free (&objfile->symbol_obstack, name_copy);
      return 1;
    }
}

/* This is a helper loop for cp_check_possible_namespace_symbols; it
   ensures that there are namespace symbols for all namespaces that
   are initial substrings of NAME of length LEN.  It returns 1 if a
   previous loop had already created the shortest such symbol and 0
   otherwise.  */

static int
check_possible_namespace_symbols_loop (const char *name, int len)
{
  if (name[len] == ':')
    {
      const char *next_name = cp_find_first_component (name + len + 2);
      int done = check_possible_namespace_symbols_loop (name,
							next_name - name);

      if (!done)
	{
	  done = check_one_possible_namespace_symbol (name, len);
	}
      return done;
    }
  else
    return 0;
}

/* Ensure that there are symbols in possible_namespace_block for all
   initial substrings of NAME that look like namespaces or
   classes.  */

void
cp_check_possible_namespace_symbols (const char *name)
{
  check_possible_namespace_symbols_loop (name,
					 cp_find_first_component (name)
					 - name);
}

/* Look for a symbol in possible_namespace_block named NAME.  */

struct symbol *
cp_lookup_possible_namespace_symbol (const char *name)
{
  return lookup_block_symbol (get_possible_namespace_block (),
			      name, NULL, VAR_NAMESPACE);
}

static void
maintenance_print_namespace (char *args, int from_tty)
{
  const struct block *namespace_block = get_namespace_block ();
  const struct block *possible_namespace_block
    = get_possible_namespace_block ();
  struct dict_iterator iter;
  struct symbol *sym;

  printf_unfiltered ("Definite namespaces:\n");
  ALL_BLOCK_SYMBOLS (namespace_block, iter, sym)
    {
      printf_unfiltered ("%s\n", SYMBOL_BEST_NAME (sym));
    }
  printf_unfiltered ("Possible namespaces:\n");
  ALL_BLOCK_SYMBOLS (possible_namespace_block, iter, sym)
    {
      printf_unfiltered ("%s\n", SYMBOL_BEST_NAME (sym));
    }
}

/* Test whether or not the initial substring of NAMESPACE_NAME of
   length NAMESPACE_LEN mentions an anonymous namespace.
   NAMESPACE_NAME must be a NULL-terminated string.  If NAMESPACE_LEN
   is -1, search the entire string.  */

int
cp_is_anonymous (const char *namespace_name, int namespace_len)
{
  const char *location = strstr (namespace_name, "(anonymous namespace)");

  if (location == NULL)
    return 0;
  else if (namespace_len == -1)
    return 1;
  else
    return (location - namespace_name) < namespace_len;
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

  for (next_component = cp_find_first_component (previous_component);
       *next_component == ':';
       next_component = cp_find_first_component (previous_component))
    {
      /* Skip '::'.  */
      previous_component = next_component + 2;
    }

  return remove_params (previous_component);
}

void
_initialize_cp_support (void)
{
  add_cmd ("namespace", class_maintenance, maintenance_print_namespace,
	   "Print the list of current known C++ namespaces.",
	   &maintenanceprintlist);
}
