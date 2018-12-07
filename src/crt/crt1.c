// Removing ctors/dtors invocation from crt0
#ifdef CRT1
#define CRT1_FILE
#include "crt0.c"
#undef CRT1_FILE
#endif
