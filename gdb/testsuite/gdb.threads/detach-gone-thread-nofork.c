/* This testcase is part of GDB, the GNU debugger.

   Copyright 2016 Free Software Foundation, Inc.

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

#include <pthread.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

pthread_barrier_t barrier;

#define NTHREADS 256

void *
child_function (void *arg)
{
  pthread_barrier_wait (&barrier);
  _exit (0);
}

int
main ()
{
  pthread_t threads[NTHREADS];
  int res;
  int i;
  pid_t pid;

  pthread_barrier_init (&barrier, NULL, NTHREADS + 1);

  for (i = 0; i < NTHREADS; i++)
    res = pthread_create (&threads[i], NULL, child_function, NULL);
  pthread_barrier_wait (&barrier);
  exit (0);

}
