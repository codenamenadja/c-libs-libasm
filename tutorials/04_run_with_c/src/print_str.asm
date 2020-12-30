section .text
    global  print_str

print_str:
    mov     r10, rdi        ; first param pointer
    mov     r11, rsi        ; sec param pointer
    mov     rax, 1          ;
    mov     rdi, 1
    mov     rsi, r10
    mov     rdx, r11
    syscall
    ret
        
