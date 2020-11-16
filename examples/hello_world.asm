DEFAULT REL

SECTION .rodata

MSG:        db 'Hello, world!', 0xa ; string to be printed
len_Hello:  equ $-MSG               ; length of the stirng.

SECTION .text

global _start               ; must be declared for the linker
_start:
    mov     eax, 1          ; syscall number save register
    mov     edi, 1          ; 
    mov     edx, len_Hello
    mov     ecx, MSG
    mov     ebx, 1
    mov     eax, 4
    int     0x80

    mov     eax, 1
    int     0x80

