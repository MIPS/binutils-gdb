// fileread.h -- read files for gold   -*- C++ -*-

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

// Classes used to read data from binary input files.

#ifndef GOLD_FILEREAD_H
#define GOLD_FILEREAD_H

#include <list>
#include <map>
#include <string>

#include "options.h"

namespace gold
{

class Dirsearch;
class File_view;

// File_read manages a file descriptor for a file we are reading.  We
// close file descriptors if we run out of them, so this class reopens
// the file as needed.

class File_read
{
 public:
  File_read()
    : name_(), descriptor_(-1), size_(0), lock_count_(0), views_(),
      saved_views_(), contents_(NULL), mapped_bytes_(0)
  { }

  ~File_read();

  // Open a file.
  bool
  open(const std::string& name);

  // Pretend to open the file, but provide the file contents.  No
  // actual file system activity will occur.  This is used for
  // testing.
  bool
  open(const std::string& name, const unsigned char* contents, off_t size);

  // Return the file name.
  const std::string&
  filename() const
  { return this->name_; }

  // Lock the file for access within a particular Task::run execution.
  // This means that the descriptor can not be closed.  This routine
  // may only be called from the main thread.
  void
  lock();

  // Unlock the descriptor, permitting it to be closed if necessary.
  void
  unlock();

  // Test whether the object is locked.
  bool
  is_locked() const;

  // Return the size of the file.
  off_t
  filesize() const
  { return this->size_; }

  // Return a view into the file starting at file offset START for
  // SIZE bytes.  The pointer will remain valid until the File_read is
  // unlocked.  It is an error if we can not read enough data from the
  // file.  The CACHE parameter is a hint as to whether it will be
  // useful to cache this data for later accesses--i.e., later calls
  // to get_view, read, or get_lasting_view which retrieve the same
  // data.
  const unsigned char*
  get_view(off_t start, off_t size, bool cache);

  // Read data from the file into the buffer P starting at file offset
  // START for SIZE bytes.
  void
  read(off_t start, off_t size, void* p) const;

  // Return a lasting view into the file starting at file offset START
  // for SIZE bytes.  This is allocated with new, and the caller is
  // responsible for deleting it when done.  The data associated with
  // this view will remain valid until the view is deleted.  It is an
  // error if we can not read enough data from the file.  The CACHE
  // parameter is as in get_view.
  File_view*
  get_lasting_view(off_t start, off_t size, bool cache);

  // Dump statistical information to stderr.
  static void
  print_stats();

 private:
  // This class may not be copied.
  File_read(const File_read&);
  File_read& operator=(const File_read&);

  // Total bytes mapped into memory during the link.  This variable is
  // only accessed from the main thread, when unlocking the object.
  static unsigned long long total_mapped_bytes;

  // Current number of bytes mapped into memory during the link.  This
  // variable is only accessed from the main thread.
  static unsigned long long current_mapped_bytes;

  // High water mark of bytes mapped into memory during the link.
  // This variable is only accessed from the main thread.
  static unsigned long long maximum_mapped_bytes;

  // A view into the file.
  class View
  {
   public:
    View(off_t start, off_t size, const unsigned char* data, bool cache,
         bool mapped)
      : start_(start), size_(size), data_(data), lock_count_(0),
	cache_(cache), mapped_(mapped)
    { }

    ~View();

    off_t
    start() const
    { return this->start_; }

    off_t
    size() const
    { return this->size_; }

    const unsigned char*
    data() const
    { return this->data_; }

    void
    lock();

    void
    unlock();

    bool
    is_locked();

    void
    set_cache()
    { this->cache_ = true; }

    bool
    should_cache() const
    { return this->cache_; }

   private:
    View(const View&);
    View& operator=(const View&);

    off_t start_;
    off_t size_;
    const unsigned char* data_;
    int lock_count_;
    bool cache_;
    bool mapped_;
  };

  friend class View;
  friend class File_view;

  // Find a view into the file.
  View*
  find_view(off_t start, off_t size) const;

  // Read data from the file into a buffer.
  void
  do_read(off_t start, off_t size, void* p) const;

  // Find or make a view into the file.
  View*
  find_or_make_view(off_t start, off_t size, bool cache);

  // Clear the file views.
  void
  clear_views(bool);

  // The size of a file page for buffering data.
  static const off_t page_size = 8192;

  // Given a file offset, return the page offset.
  static off_t
  page_offset(off_t file_offset)
  { return file_offset & ~ (page_size - 1); }

  // Given a file size, return the size to read integral pages.
  static off_t
  pages(off_t file_size)
  { return (file_size + (page_size - 1)) & ~ (page_size - 1); }

  // The type of a mapping from page start to views.
  typedef std::map<off_t, View*> Views;

  // A simple list of Views.
  typedef std::list<View*> Saved_views;

  // File name.
  std::string name_;
  // File descriptor.
  int descriptor_;
  // File size.
  off_t size_;
  // Number of locks on the file.
  int lock_count_;
  // Buffered views into the file.
  Views views_;
  // List of views which were locked but had to be removed from views_
  // because they were not large enough.
  Saved_views saved_views_;
  // Specified file contents.  Used only for testing purposes.
  const unsigned char* contents_;
  // Total amount of space mapped into memory.  This is only changed
  // while the file is locked.  When we unlock the file, we transfer
  // the total to total_mapped_bytes, and reset this to zero.
  size_t mapped_bytes_;
};

// A view of file data that persists even when the file is unlocked.
// Callers should destroy these when no longer required.  These are
// obtained form File_read::get_lasting_view.  They may only be
// destroyed when the underlying File_read is locked.

class File_view
{
 public:
  // This may only be called when the underlying File_read is locked.
  ~File_view();

  // Return a pointer to the data associated with this view.
  const unsigned char*
  data() const
  { return this->data_; }

 private:
  File_view(const File_view&);
  File_view& operator=(const File_view&);

  friend class File_read;

  // Callers have to get these via File_read::get_lasting_view.
  File_view(File_read& file, File_read::View* view, const unsigned char* data)
    : file_(file), view_(view), data_(data)
  { }

  File_read& file_;
  File_read::View* view_;
  const unsigned char* data_;
};

// All the information we hold for a single input file.  This can be
// an object file, a shared library, or an archive.

class Input_file
{
 public:
  Input_file(const Input_file_argument* input_argument)
    : input_argument_(input_argument), found_name_(), file_(),
      is_in_sysroot_(false)
  { }

  // Create an input file with the contents already provided.  This is
  // only used for testing.  With this path, don't call the open
  // method.
  Input_file(const char* name, const unsigned char* contents, off_t size);

  // Open the file.  If the open fails, this will report an error and
  // return false.
  bool
  open(const General_options&, const Dirsearch&);

  // Return the name given by the user.  For -lc this will return "c".
  const char*
  name() const
  { return this->input_argument_->name(); }

  // Return the file name.  For -lc this will return something like
  // "/usr/lib/libc.so".
  const std::string&
  filename() const
  { return this->file_.filename(); }

  // Return the name under which we found the file, corresponding to
  // the command line.  For -lc this will return something like
  // "libc.so".
  const std::string&
  found_name() const
  { return this->found_name_; }

  // Return the position dependent options.
  const Position_dependent_options&
  options() const
  { return this->input_argument_->options(); }

  // Return the file.
  File_read&
  file()
  { return this->file_; }

  const File_read&
  file() const
  { return this->file_; }

  // Whether we found the file in a directory in the system root.
  bool
  is_in_sysroot() const
  { return this->is_in_sysroot_; }

 private:
  Input_file(const Input_file&);
  Input_file& operator=(const Input_file&);

  // The argument from the command line.
  const Input_file_argument* input_argument_;
  // The name under which we opened the file.  This is like the name
  // on the command line, but -lc turns into libc.so (or whatever).
  // It only includes the full path if the path was on the command
  // line.
  std::string found_name_;
  // The file after we open it.
  File_read file_;
  // Whether we found the file in a directory in the system root.
  bool is_in_sysroot_;
};

} // end namespace gold

#endif // !defined(GOLD_FILEREAD_H)
