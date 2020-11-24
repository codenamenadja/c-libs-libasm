section .data
    achar   db '0'

section .text
    global _start

_start:
    call    display
    mov     eax, 1      ; syscall sysexit
    int     0x80        ; call kernel

display:
    mov     ecx, 256

next:
    push    ecx
    mov     eax, 4  ; syscall syswrite
    mov     ebx, 1  ; file descriptor
    mov     ecx, achar ; msg
    mov     edx, 1 ; len
    int     0x80

    pop     ecx
    mov     dx, [achar]
    cmp     byte [achar], 0dh
    inc     byte [achar]
    loop    next
    ret
