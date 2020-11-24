section .data
msg DB  "The sum is:"
len EQU $- msg

segment .bss
res RESB 1

section .text
global _start

_start:
    MOV ECX, '4'
    SUB ECX, '0'

    MOV EDX, '5'
    SUB EDX, '0'

    CALL    sum ; call sum procedure
    MOV [res], EAX
    MOV EDX, len
    MOV ECX, msg
    MOV EBX, 1  ; file descriptor
    MOV EAX, 4  ; sys_write
    INT 0x80    ; call kernel

    MOV ECX, res
    MOV EDX, 1
    MOV EBX, 1
    MOV EAX, 4
    INT 0x80

    MOV EAX, 1 ; sys_exit
    INT 0x80

sum:
    MOV EAX, ECX
    ADD EAX, EDX
    ADD EAX, '0'
    ret
