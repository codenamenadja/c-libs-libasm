/*
0123456789n
   3456789n
0120123456789n
   0123456789n
3456789n
     0123456789n
src: 01201234567567
dest:01234567567
*/

#include <string.h>
#include <stdlib.h>
#include <stdio.h>

int     main(void) {
    char buf
    char *src, *dst;

    src = calloc(20, sizeof(char));
    strcpy(src, "0123456789\n\0");
    dst = src;
    src += 3;

    strcpy(dst, src);
    printf("src:\"%s\"\ndest:\"%s\"", src, dst);
    return (0);
}

/*

src:3456789n
dst:0123456789n
    3456789n0

src:"6789
"
dest:"3456789
"
*/
