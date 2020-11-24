section .data
    msg DB  "Allocated 16 kb of memory!", 10
    len equ $-  msg

section .text
    global _start

_start:

    MOV EAX, 45         ; sys_brk
    XOR EBX, EBX
    INT 0x80

    ADD EAX, 16384      ; number of bytes to be reserved
    MOV EBX, EAX
    MOV EAX, 45         ; sys_brk
    INT 0x80

    CMP EAX, 0
    JL  exit            ; if EAX < 0 goto exit
    MOV EDI, EAX        ; EDI = 16394; highest available address.(end)
    SUB EDI, 4          ; poiniting to the last DWORD(end - 4bytes)
    MOV ECX, 4096       ; number of 4bytes allocated.
    XOR EAX, EAX        ; clear EAX
    STD                 ; backward
    REP STOSD           ; repeat of entire allocated area
    CLD                 ; PUT DF flag to normal start

    MOV EAX, 4
    MOV EBX, 1
    MOV ECX, msg
    MOV EDX, len
    INT 0x80            ; sys write print msg.

exit:
    MOV EAX, 1
    XOR EBX, EBX
    int 0x80
