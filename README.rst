libasm
=======

[SOURCE]: https://github.com/codenamenadja/c-libs-asm

inctructions
------------ 
- must write 64 bits ASM. Beware of "calling convention".
- can't do inline ASM, must do '.s' files.
- compile asm code with *nasm.*
- must use Intel syntax, not AT&T.

library must be called libasm.a

- ft_strlen 
- ft_strcpy
- ft_strcmp
- ft_write
- ft_read
- ft_strdup(malloc)

must set the variable errno properly
for that, it is allowed to call ``extern __error``
