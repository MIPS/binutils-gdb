/* Host file transfer support for gdbserver.
   Copyright (C) 2006
   Free Software Foundation, Inc.

   Contributed by CodeSourcery.

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
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

#include "server.h"
#include "gdb/fileio.h"

#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <unistd.h>

extern int remote_debug;

struct fd_list
{
  int fd;
  struct fd_list *next;
};

static struct fd_list *open_fds;

static int
safe_fromhex (char a, int *nibble)
{
  if (a >= '0' && a <= '9')
    *nibble = a - '0';
  else if (a >= 'a' && a <= 'f')
    *nibble = a - 'a' + 10;
  else if (a >= 'A' && a <= 'F')
    *nibble = a - 'A' + 10;
  else
    return -1;

  return 0;
}

static int
require_filename (char **pp, char *filename)
{
  int count;
  char *p;

  p = *pp;
  count = 0;

  while (*p && *p != ',')
    {
      int nib1, nib2;

      /* Don't allow overflow.  */
      if (count >= PATH_MAX - 1)
	return -1;

      if (safe_fromhex (p[0], &nib1)
	  || safe_fromhex (p[1], &nib2))
	return -1;

      filename[count++] = nib1 * 16 + nib2;
      p += 2;
    }

  filename[count] = '\0';
  *pp = p;
  return 0;
}

static int
require_int (char **pp, int *value)
{
  char *p;
  int count;

  p = *pp;
  *value = 0;
  count = 0;

  while (*p && *p != ',')
    {
      int nib;

      /* Don't allow overflow.  */
      if (count >= 7)
	return -1;

      if (safe_fromhex (p[0], &nib))
	return -1;
      *value = *value * 16 + nib;
      p++;
      count++;
    }

  *pp = p;
  return 0;
}

static int
require_data (char *p, int p_len, char **data, int *data_len)
{
  int input_index, output_index, escaped;

  *data = malloc (p_len);

  output_index = 0;
  escaped = 0;
  for (input_index = 0; input_index < p_len; input_index++)
    {
      char b = p[input_index];

      if (escaped)
	{
	  (*data)[output_index++] = b ^ 0x20;
	  escaped = 0;
	}
      else if (b == '}')
	escaped = 1;
      else
	(*data)[output_index++] = b;
    }

  if (escaped)
    return -1;

  *data_len = output_index;
  return 0;
}

static int
require_comma (char **pp)
{
  if (**pp == ',')
    {
      (*pp)++;
      return 0;
    }
  else
    return -1;
}

static int
require_end (char *p)
{
  if (*p == '\0')
    return 0;
  else
    return -1;
}

static int
require_valid_fd (int fd)
{
  struct fd_list *fd_ptr;

  for (fd_ptr = open_fds; fd_ptr != NULL; fd_ptr = fd_ptr->next)
    if (fd_ptr->fd == fd)
      return 0;

  return -1;
}

static int
errno_to_fileio_errno (int error)
{
  switch (error)
    {
    case EPERM:
      return FILEIO_EPERM;
    case ENOENT:
      return FILEIO_ENOENT;
    case EINTR:
      return FILEIO_EINTR;
    case EIO:
      return FILEIO_EIO;
    case EBADF:
      return FILEIO_EBADF;
    case EACCES:
      return FILEIO_EACCES;
    case EFAULT:
      return FILEIO_EFAULT;
    case EBUSY:
      return FILEIO_EBUSY;
    case EEXIST:
      return FILEIO_EEXIST;
    case ENODEV:
      return FILEIO_ENODEV;
    case ENOTDIR:
      return FILEIO_ENOTDIR;
    case EISDIR:
      return FILEIO_EISDIR;
    case EINVAL:
      return FILEIO_EINVAL;
    case ENFILE:
      return FILEIO_ENFILE;
    case EMFILE:
      return FILEIO_EMFILE;
    case EFBIG:
      return FILEIO_EFBIG;
    case ENOSPC:
      return FILEIO_ENOSPC;
    case ESPIPE:
      return FILEIO_ESPIPE;
    case EROFS:
      return FILEIO_EROFS;
    case ENOSYS:
      return FILEIO_ENOSYS;
    case ENAMETOOLONG:
      return FILEIO_ENAMETOOLONG;
    }
  return FILEIO_EUNKNOWN;
}

static void
hostio_error (char *own_buf, int error)
{
  int fileio_error = errno_to_fileio_errno (error);

  sprintf (own_buf, "F-1,%x", fileio_error);
}

static void
hostio_packet_error (char *own_buf)
{
  hostio_error (own_buf, EINVAL);
}

static void
hostio_reply (char *own_buf, int result)
{
  sprintf (own_buf, "F%x", result);
}

static int
hostio_reply_with_data (char *own_buf, char *buffer, int len,
			int *new_packet_len)
{
  int input_index, output_index, out_maxlen;

  sprintf (own_buf, "F%x;", len);
  output_index = strlen (own_buf);

  out_maxlen = PBUFSIZ;

  for (input_index = 0; input_index < len; input_index++)
    {
      char b = buffer[input_index];

      if (b == '$' || b == '#' || b == '}' || b == '*')
	{
	  /* These must be escaped.  */
	  if (output_index + 2 > out_maxlen)
	    break;
	  own_buf[output_index++] = '}';
	  own_buf[output_index++] = b ^ 0x20;
	}
      else
	{
	  if (output_index + 1 > out_maxlen)
	    break;
	  own_buf[output_index++] = b;
	}
    }

  *new_packet_len = output_index;
  return input_index;
}

static int
fileio_open_flags_to_host (int fileio_open_flags, int *open_flags_p)
{
  int open_flags = 0;

  if (fileio_open_flags & ~FILEIO_O_SUPPORTED)
    return -1;

  if (fileio_open_flags & FILEIO_O_CREAT)
    open_flags |= O_CREAT;
  if (fileio_open_flags & FILEIO_O_EXCL)
    open_flags |= O_EXCL;
  if (fileio_open_flags & FILEIO_O_TRUNC)
    open_flags |= O_TRUNC;
  if (fileio_open_flags & FILEIO_O_APPEND)
    open_flags |= O_APPEND;
  if (fileio_open_flags & FILEIO_O_RDONLY)
    open_flags |= O_RDONLY;
  if (fileio_open_flags & FILEIO_O_WRONLY)
    open_flags |= O_WRONLY;
  if (fileio_open_flags & FILEIO_O_RDWR)
    open_flags |= O_RDWR;
/* On systems supporting binary and text mode, always open files in
   binary mode. */
#ifdef O_BINARY
  open_flags |= O_BINARY;
#endif

  *open_flags_p = open_flags;
  return 0;
}

static void
handle_fopen (char *own_buf)
{
  char filename[PATH_MAX];
  char *p;
  int fileio_flags, mode, flags, fd;
  struct fd_list *new_fd;

  p = own_buf + strlen ("Fopen,");

  if (require_filename (&p, filename)
      || require_comma (&p)
      || require_int (&p, &fileio_flags)
      || require_comma (&p)
      || require_int (&p, &mode)
      || require_end (p)
      || fileio_open_flags_to_host (fileio_flags, &flags))
    {
      hostio_packet_error (own_buf);
      return;
    }

  /* We do not need to convert MODE, since the fileio protocol
     uses the standard values.  */
  fd = open (filename, flags, mode);

  if (fd == -1)
    {
      hostio_error (own_buf, errno);
      return;
    }

  /* Record the new file descriptor.  */
  new_fd = malloc (sizeof (struct fd_list));
  new_fd->fd = fd;
  new_fd->next = open_fds;
  open_fds = new_fd;

  hostio_reply (own_buf, fd);
}

static void
handle_fread (char *own_buf, int *new_packet_len)
{
  int fd, ret, len, bytes_sent;
  char *p, *data;

  p = own_buf + strlen ("Fread,");

  if (require_int (&p, &fd)
      || require_comma (&p)
      || require_valid_fd (fd)
      || require_int (&p, &len)
      || require_end (p))
    {
      hostio_packet_error (own_buf);
      return;
    }

  data = malloc (len);
  ret = read (fd, data, len);

  if (ret == -1)
    {
      hostio_error (own_buf, errno);
      free (data);
      return;
    }

  bytes_sent = hostio_reply_with_data (own_buf, data, ret, new_packet_len);

  /* If all the data could not fit in the reply, back up the file
     pointer for the next read.  */
  if (bytes_sent < ret)
    lseek (fd, bytes_sent - ret, SEEK_CUR);

  free (data);
}

static void
handle_fwrite (char *own_buf, int packet_len)
{
  int fd, ret, len;
  char *p, *data;

  p = own_buf + strlen ("Fwrite,");

  if (require_int (&p, &fd)
      || require_comma (&p)
      || require_valid_fd (fd)
      || require_data (p, packet_len - (p - own_buf), &data, &len))
    {
      hostio_packet_error (own_buf);
      return;
    }

  ret = write (fd, data, len);

  if (ret == -1)
    {
      hostio_error (own_buf, errno);
      free (data);
      return;
    }

  hostio_reply (own_buf, ret);
  free (data);
}

static void
handle_fclose (char *own_buf)
{
  int fd, ret;
  char *p;
  struct fd_list **open_fd_p, *old_fd;

  p = own_buf + strlen ("Fclose,");

  if (require_int (&p, &fd)
      || require_valid_fd (fd)
      || require_end (p))
    {
      hostio_packet_error (own_buf);
      return;
    }

  ret = close (fd);

  if (ret == -1)
    {
      hostio_error (own_buf, errno);
      return;
    }

  open_fd_p = &open_fds;
  while (*open_fd_p && (*open_fd_p)->fd != fd)
    open_fd_p = &(*open_fd_p)->next;

  old_fd = *open_fd_p;
  *open_fd_p = (*open_fd_p)->next;
  free (old_fd);

  hostio_reply (own_buf, ret);
}

/* Handle all the 'F' file transfer packets.  */

int
handle_f_hostio (char *own_buf, int packet_len, int *new_packet_len)
{
  if (strncmp (own_buf, "Fopen,", 6) == 0)
    handle_fopen (own_buf);
  else if (strncmp (own_buf, "Fread,", 6) == 0)
    handle_fread (own_buf, new_packet_len);
  else if (strncmp (own_buf, "Fwrite,", 7) == 0)
    handle_fwrite (own_buf, packet_len);
  else if (strncmp (own_buf, "Fclose,", 7) == 0)
    handle_fclose (own_buf);
  else
    return 0;

  return 1;
}
