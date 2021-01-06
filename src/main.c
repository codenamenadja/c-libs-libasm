#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "libft_asm.h"

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

    const char  *cmp_dest = "origin\0";
    const char  *cmp_src = "origin\0";
    int         cmp_ret;
    cmp_ret = ft_strcmp(cmp_dest, cmp_src);
    printf("cmp_ret:%d\n", cmp_ret);

    int         fd;
    char        buf[30] = {0};
    ssize_t     write_ret;
    ssize_t     read_ret;

    write_ret = ft_write(1, (const void*)"buf string\n\0", 22);
    printf("write_ret:%ld\n", write_ret);

    fd = open("./sample.txt", O_RDONLY);
    if (fd) {
        read_ret = ft_read(fd, buf, 30);
        printf("read_ret:%ld\n", read_ret);
        printf("read_buf:%s\n", buf);
        close(fd);
    } else
        printf("read file not opend\n");

    return (0);
}
