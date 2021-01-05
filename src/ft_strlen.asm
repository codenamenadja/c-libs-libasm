section .text
    global  ft_strlen

ft_strlen:
    xor rcx, rcx
    cmp [rdi], byte 0
    je fin
loop:
    inc rcx
    cmp [rdi + rcx], byte 0
    jne loop
fin:
    mov rax, rcx
    ret
