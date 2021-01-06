#include <stdio.h>
#include <stdlib.h>
#include "libft_asm.h"
#include <string.h>

int main(void)
{
    int     res;

    res = ft_strlen("sample");
    printf("%d\n", res);

    char    *src;
    char    *dest;
    char    *ret;

    src = calloc(32, sizeof(char));
    strcpy(src, "0123456789\0");
    dest = src + 3;
    ret = ft_strcpy(dest, src);

    printf("%s\n", src);
    printf("%s\n", dest);
    printf("%s\n", ret);
    free(src);

    const char *cmp_dest = "origin\0";
    const char *cmp_src = "origim\0";
    int         cmp_ret;
    cmp_ret = ft_strcmp(cmp_dest, cmp_src);

    printf("cmp_ret:%d\n", cmp_ret);
    return (0);
}
/*
6
3456789
01201234564567
01234564567
01234564567
*/
