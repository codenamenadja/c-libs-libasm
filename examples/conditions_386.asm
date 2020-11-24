section .data

    msg DB  "The largest digit is: "
    len EQU $- msg
    num1    DD  '47'    ; define Double word 4byte.
    num2    DD  '22'
    num3    DD  '31'

segment .bss
    largest RESB 2;   reserve 1byte.

section .text
    global _start

_start:
    MOV ecx, [num1] ; 32-bit full register <- num1[4byte:32bits]
    cmp ecx, [num2] ; compare 32bit with 4yte
    jg  check_third_num ;   if ecx is greater? jump
    mov ecx, [num2] ; if not greater save more greater.

        check_third_num:

    cmp ecx, [num3]
    jg  _exit
    mov ecx, [num3]

        _exit:

    mov [largest], ecx;
    mov ecx, msg
    mov edx, len ; syscall positonal argument
    mov ebx, 1 ; file descriptor STDOUT
    mov eax, 4 ; syscall SYS_WRITE
    int 0x80

    mov ecx, largest
    mov edx, 2
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, 1
    int 80h
    
