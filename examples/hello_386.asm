section .data
msg db 'Hello, world!', 0xa     ; string to be printed
len equ $-msg                   ; length of the stirng.

section .text
    global _start               ; must be declared for the linker

_start:
    mov     edx, len
    mov     ecx, msg
    mov     ebx, 1              ; file descripter
    mov     eax, 4              ; syscall number (sys_write)
    int     0x80                ; call kernel

    mov     eax, 1
    int     0x80
