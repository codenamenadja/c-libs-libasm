section .text
    global  ft_strcpy

ft_strcpy:
    xor rcx, rcx
    xor rax, rax
push_loop:
    lodsb
    push rax
    inc rcx
    cmp [rsp], byte 0
    jne push_loop
pop_loop:
    dec rcx
    pop rax
    mov byte [rdi + rcx], al
    cmp rcx, 0
    jne pop_loop
fin:
    mov rax, rdi
    ret

