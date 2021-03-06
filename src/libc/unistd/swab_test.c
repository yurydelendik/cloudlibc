// Copyright (c) 2015 Nuxi, https://nuxi.nl/
//
// SPDX-License-Identifier: BSD-2-Clause

#include <testing.h>
#include <unistd.h>

TEST(swab, example) {
  const char input[] = {
      0x83, 0x3d, 0x93, 0xae, 0x1c, 0x83, 0x11, 0xe5, 0xc5, 0x72, 0xc1,
      0x77, 0xf1, 0x53, 0x2e, 0x7e, 0x5c, 0x96, 0xdd, 0x1f, 0x76, 0x02,
      0x91, 0xbd, 0x20, 0x87, 0x34, 0x23, 0x02, 0x35, 0x60, 0xde, 0x42,
      0x73, 0x31, 0xb1, 0x22, 0xfa, 0x2e, 0x9d, 0xcf, 0x11, 0x5f, 0x8a,
  };
  const char expected_output[sizeof(input)] = {
      0x3d, 0x83, 0xae, 0x93, 0x83, 0x1c, 0xe5, 0x11, 0x72, 0xc5, 0x77,
      0xc1, 0x53, 0xf1, 0x7e, 0x2e, 0x96, 0x5c, 0x1f, 0xdd, 0x02, 0x76,
      0xbd, 0x91, 0x87, 0x20, 0x23, 0x34, 0x35, 0x02, 0xde, 0x60, 0x73,
      0x42, 0xb1, 0x31, 0xfa, 0x22, 0x9d, 0x2e, 0x11, 0xcf, 0x8a, 0x5f,
  };
  char output[sizeof(input)];
  swab(input, output, sizeof(input));
  ASSERT_ARREQ(expected_output, output, __arraycount(input));
}

TEST(swab, negative) {
  swab(NULL, NULL, -123);
}
