section .data
    SYS_WRITE       equ     1
    STDOUT_FILENO   equ     1
    SYS_EXIT        equ     60
    EXIT_CODE       equ     0

    NEW_LINE        db      0xa
    INPUT           db      "Hello world!"  ; ascii 72=H/33=! 

section .bss
    OUTPUT          resb    12              ; for use as buffer
     
section .text
    global          _start

_start:
    mov rsi, INPUT
    xor rcx, rcx    ; counter register
    cld             ; clear direction flag register 
                        ; make available to handle string,
                        ; from left to right
                    ; !alert!
                        ; no diff found
    cmp [rsi], byte 72
    jne exit    

    mov rdi, $ + 15 ; need to know pos of after this line
                        ; this line takes 10 bytes
    call ft_strlen  ; pushes all params rtol to the stack
                    ; and push return address to stack
                    ; this call line take 5 bytes.

    mov rdi, $ + 15
    call reverse_str ; rdi($+15) value was addr of this line.
    call print
    jmp exit

reverse_str:        ; stack [ret-addr, params, reversed string]
    add rsp, 8              ; pop return addr
    xor rdx, rdx
loop:
    cmp rcx, 0
    je  exit_routine        ; rdx stop as 12
    pop rax                 ; char key
    mov [OUTPUT + rdx], rax ; rdx starts from 0
                            ; store symbol to first byte of buffer
    dec rcx
    inc rdx
    jmp loop

print:
    mov RAX, 1
    mov RDI, 1
    mov RSI, OUTPUT
    syscall
    jmp print_newline

print_newline:
    mov rax, SYS_WRITE
    mov rdi, STDOUT_FILENO
    mov rsi, NEW_LINE
    mov rdx, 1
    syscall
    ret

exit:
    mov rax, SYS_EXIT
    mov rdi, EXIT_CODE
    syscall

ft_strlen:
    cmp byte [rsi], 0   ; [rsi] i string data
                        ; 1byte of data from address and 0.
    je exit_routine     ; finish if 1byte data equal to 0.
    lodsb       ; load byte from rsi to al and inc rsi
                    ; take first symbol of si and inc so on.
                    ; mov al, [rsi]; inc rsi
    inc rcx     ; increase counter
    push rax    ; push symbol to stack(al stores [rsi])
                ; last char will be top of stack. 
    jmp ft_strlen

exit_routine:
    push rdi    ; $(that line pos) + 15bytes.
    ret         ; return using top of the stack.
