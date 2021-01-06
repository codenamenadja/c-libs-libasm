section .text
    global  ft_strcmp

ft_strcmp:
    xor rax, rax
    xor rbx, rbx
loop:
    xor al, al
    lodsb
    mov bl, byte [rdi]
    inc rdi
    cmp bl, al
    jne fin
    cmp bl, 0
    je fin
    jmp loop
fin:
    sub rbx, rax
    mov rax, rbx
    ret

