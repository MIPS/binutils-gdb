// tls_test.cc -- test TLS variables for gold, main function

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

// This is the main function for the TLS test.  See tls_test.cc for
// more information.

#include <cassert>
#include <cstdio>
#include <pthread.h>

#include "tls_test.h"

struct Mutex_set
{
  pthread_mutex_t mutex1;
  pthread_mutex_t mutex2;
  pthread_mutex_t mutex3;
};

Mutex_set mutexes1 = { PTHREAD_MUTEX_INITIALIZER,
		       PTHREAD_MUTEX_INITIALIZER,
		       PTHREAD_MUTEX_INITIALIZER };

Mutex_set mutexes2 = { PTHREAD_MUTEX_INITIALIZER,
		       PTHREAD_MUTEX_INITIALIZER,
		       PTHREAD_MUTEX_INITIALIZER } ;

bool failed = false;

void
check(const char* name, bool val)
{
  if (!val)
    {
      fprintf(stderr, "Test %s failed\n", name);
      failed = true;
    }
}

// The body of the thread function.  This gets a lock on the first
// mutex, runs the tests, and then unlocks the second mutex.  Then it
// locks the third mutex, and the runs the verification test again.

void*
thread_routine(void* arg)
{
  Mutex_set* pms = static_cast<Mutex_set*>(arg);

  // Lock the first mutex.
  int err = pthread_mutex_lock(&pms->mutex1);
  assert(err == 0);

  // Run the tests.
  check("t1", t1());
  check("t2", t2());
  check("t3", t3());
  check("t4", t4());
  f5b(f5a());
  check("t5", t5());
  f6b(f6a());
  check("t6", t6());
  check("t8", t8());
  check("t9", t9());
  f10b(f10a());
  check("t10", t10());
  check("t_last", t_last());

  // Unlock the second mutex.
  err = pthread_mutex_unlock(&pms->mutex2);
  assert(err == 0);

  // Lock the third mutex.
  err = pthread_mutex_lock(&pms->mutex3);
  assert(err == 0);

  check("t_last", t_last());

  return 0;
}

// The main function.

int
main()
{
  // Set up the mutex locks.  We want the first thread to start right
  // away, tell us when it is done with the first part, and wait for
  // us to release it.  We want the second thread to wait to start,
  // tell us when it is done with the first part, and wait for us to
  // release it.
  int err = pthread_mutex_lock(&mutexes1.mutex2);
  assert(err == 0);
  err = pthread_mutex_lock(&mutexes1.mutex3);
  assert(err == 0);

  err = pthread_mutex_lock(&mutexes2.mutex1);
  assert(err == 0);
  err = pthread_mutex_lock(&mutexes2.mutex2);
  assert(err == 0);
  err = pthread_mutex_lock(&mutexes2.mutex3);
  assert(err == 0);

  pthread_t thread1;
  err = pthread_create(&thread1, NULL, thread_routine, &mutexes1);
  assert(err == 0);

  pthread_t thread2;
  err = pthread_create(&thread2, NULL, thread_routine, &mutexes2);
  assert(err == 0);

  // Wait for the first thread to complete the first part.
  err = pthread_mutex_lock(&mutexes1.mutex2);
  assert(err == 0);

  // Tell the second thread to start.
  err = pthread_mutex_unlock(&mutexes2.mutex1);
  assert(err == 0);

  // Wait for the second thread to complete the first part.
  err = pthread_mutex_lock(&mutexes2.mutex2);
  assert(err == 0);

  // Tell the first thread to continue and finish.
  err = pthread_mutex_unlock(&mutexes1.mutex3);
  assert(err == 0);

  // Wait for the first thread to finish.
  void* thread_val;
  err = pthread_join(thread1, &thread_val);
  assert(err == 0);
  assert(thread_val == 0);

  // Tell the second thread to continue and finish.
  err = pthread_mutex_unlock(&mutexes2.mutex3);
  assert(err == 0);

  // Wait for the second thread to finish.
  err = pthread_join(thread2, &thread_val);
  assert(err == 0);
  assert(thread_val == 0);

  // All done.
  return failed ? 1 : 0;
}
