section .data
        SYS_WRITE       equ 1
        STDOUT_FILENO   equ 1
        SYS_EXIT        equ 60
        EXIT_CODE       equ 0

        NEW_LINE        db  0xa
        ERR_MSG         db  "MUST be two command line argument", 0xa    ; message byte array, byte

section .text
        global      _start
_start: 
        pop         rcx     ; rsp == rbp - rcx*8 - 8; && rsp + 8 ; now rsp points program name
        cmp         rcx, 3
		jne         argcError

		add         rsp, 8  ; progname to first param.
		pop         rsi     ; pop first arg and rsp+8
		call        str_to_int ; numeric string

		mov         r10, rax ; str_to_int set rax ; r10 = first arg function call
		pop         rsi     ; last arg
		call        str_to_int ; numeric string ; rax changed
		mov         r11, rax ; r11 = last arg function call

		add         r10, r11 ; two numeric string changed as int. adds and save to r10
        mov         rax, r10 ; summation move to rax
        xor         r12, r12 ; set zero
        jmp         int_to_str

argcError:
        mov         rax, SYS_WRITE
        mov         rdi, STDOUT_FILENO
        mov         rsi, ERR_MSG
        mov         rdx, 34 ; len of ERR_MSG 33 + 1(0xa) = 34

        syscall
        jmp         exit

strlen:
        xor rcx rcx
loop:
        cmp [rsi + rcx], byte 0
        je found
        inc rcx
        jmp loop

str_to_int:
        xor         rax, rax        ; set rax to 0
        mov         rcx, 10         ; set rcx to 10
        cmp         [rsi], byte 0   ; content of source string index; first byte of rsi
        je          return_str      ; end of string in c(null terminate)
        
next:
        mov         bl, [rsi]       ; rsi content to bl(1byte) ascii char less than 255
        sub         bl, 48          ; ascii key to integer
        add         rax, rbx        ; myadd1

        inc         rsi             ; next index of source
        cmp         [rsi], byte 0   ; content of source string index; first byte of rsi
        je          return_str      ; end of string in c(null terminate)
        mul         rcx
        jmp         next            ; loop

int_to_str: ; str_to_int will set string to number in rax with loop.
        mov         rdx, 0
        add         rdx, 0xa
        push        rdx
        inc         r12 
loop_its:
        mov         rdx, 0
        mov         rbx, 10         ; arbitary variable set
        div         rbx             ; rdx = rax % rbx(10); rax = rax//10
        add         rdx, 48         ; rdx is data register which helps rax operation
        push        rdx
        inc         r12             ; before this function call, r12 is 0
        cmp         rax, 0x0        ; rax emptyfor dividing 10?
        jne         loop_its
        jmp         print

print:
        mov rax, 1
        mul r12                     ; rax *= r12
        mov r12, 8                  ; size of symbol
        mul r12
        mov rdx, rax
        mov rax, SYS_WRITE
        mov rdi, STDOUT_FILENO
        mov rsi, rsp
        syscall
        jmp exit
        

return_str:
        ret

exit:
        mov rax, SYS_EXIT
        mov rdi, EXIT_CODE
        syscall
