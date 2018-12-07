// Copyright (c) 2017 Nuxi, https://nuxi.nl/
//
// SPDX-License-Identifier: BSD-2-Clause

#include <setjmp.h>

#if !defined(__aarch64__) && !defined(__wasm__)

void longjmp(jmp_buf env, int val) {
  env->__val = val == 0 ? 1 : val;
  __builtin_longjmp(env->__ptr, 1);
}

__strong_reference(longjmp, siglongjmp);

#endif
