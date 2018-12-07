// Copyright (c) 2015-2017 Nuxi, https://nuxi.nl/
//
// SPDX-License-Identifier: BSD-2-Clause

#include <setjmp.h>
#include <testing.h>

#ifndef __wasm__

TEST(setjmp_longjmp, example) {
  jmp_buf jmp;
  while (setjmp(jmp) != 123)
    longjmp(jmp, 123);
}

#endif
