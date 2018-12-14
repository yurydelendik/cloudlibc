#include <stdio.h>
#include <stdlib.h>

int main () {
   FILE *f = fdopen(1, "w");
   fprintf(f, "Hello, world!\n");
   fclose(f);
   return 0;
}
