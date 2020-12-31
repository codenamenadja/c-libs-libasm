section .text
    global  _start
    extern print

_start:
    call    print
    mov     rax, 60
    mov     rdi, 0
    syscall

