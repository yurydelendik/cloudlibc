// Copyright (c) 2015 Nuxi, https://nuxi.nl/
//
// SPDX-License-Identifier: BSD-2-Clause

#include <pthread.h>
#include <testing.h>

static pthread_once_t noblock_once = PTHREAD_ONCE_INIT;
static int noblock_count = 0;

static void noblock(void) {
  ++noblock_count;
}

TEST(pthread_once, noblock) {
  // Function should only be executed once. No threads will be blocked.
  pthread_once(&noblock_once, noblock);
  ASSERT_EQ(1, noblock_count);
  pthread_once(&noblock_once, noblock);
  ASSERT_EQ(1, noblock_count);
}

static pthread_once_t block_once = PTHREAD_ONCE_INIT;
static int block_count;

static void block_increment(void) {
  // Wait a bit to let all the other threads block on the once object.
  ASSERT_EQ(0, clock_nanosleep(CLOCK_MONOTONIC, 0,
                               &(struct timespec){.tv_nsec = 100000000}));
  ++block_count;
}

static void *block_thread(void *arg) {
  pthread_once(&block_once, block_increment);
  ASSERT_EQ(1, block_count);
  return NULL;
}

TEST(pthread_once, block) {
  pthread_t handles[10];

  // Spawn a number of threads to set the value.
  for (size_t i = 0; i < __arraycount(handles); ++i) {
    ASSERT_EQ(0, pthread_create(&handles[i], NULL, block_thread, NULL));
  }

  // Wait for all the threads to finish.
  for (size_t i = 0; i < __arraycount(handles); ++i) {
    ASSERT_EQ(0, pthread_join(handles[i], NULL));
  }

  // The once function should be called at least once.
  ASSERT_EQ(1, block_count);
}
