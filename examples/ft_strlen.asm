section .data
    SYS_WRITE           equ 1
    SYS_EXIT            equ 60

    STDOUT_FILENO       equ 1
    EXIT_CODE           equ 0

    NEW_LINE            db 0xa
    MSG                 db "Hello wo"

section .text
    global  _start

_start:
    mov rsi, MSG
    jmp ft_strlen

ft_strlen:
    xor rcx, rcx
    cmp [rsi], byte 0
    je fin
    jmp loop

loop:
    inc rcx
    inc rsi
    cmp [rsi], byte 0
    jne loop
    jmp print

print:
    mov rax, SYS_WRITE
    mov rdi, STDOUT_FILENO
    mov rdx, rcx
    add rdx, 48
    mov rsi, rdx
    mov rdx, 1
    syscall
    jmp fin

fin:
    mov rax, SYS_EXIT
    mov rdi, EXIT_CODE
    syscall
