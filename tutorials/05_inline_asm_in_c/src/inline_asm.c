#include <string.h>

int main() {
    char *str    = "Hello World\n";
    long len     = strlen(str);
    int  ret     = 0;

    __asm__("movq $1, %%rax \n\t" // number 1
            "movq $1, %%rdi \n\t" // number 1
            "movq %1, %%rsi \n\t" // arg 1
            "movl %2, %%edx \n\t" // arg 2
            "syscall"
            : "=g"(ret)
            : "g"(str), "g" (len));

    return (0);
}
