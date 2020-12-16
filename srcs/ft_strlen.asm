section .text
    global  _ft_strlen

_ft_strlen:
    xor rcx, rcx
    cmp [rsi], byte 0
    je fin
loop:
    inc rcx
    inc rsi
    cmp [rsi], byte 0
    jne loop
fin:
    mov rax, rcx
    ret
