#include <string.h>
#include <unistd.h>
#include "print_str.h"

int main(void) {
   char *str    = "Hello World\n";
   int  len     = strlen(str);
   print_str(str, len);
   return (0);
}

