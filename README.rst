libasm
=======

[SOURCE]: https://github.com/codenamenadja/c-libs-asm

tutorial lists
--------------

- ** 01_: string operations/stack&reverse_string program**
- ** 02_: macro/README only**
- ** 04_: run_with_c/print_str.asm object usage in C**
- ** 05_: inline_asm_in_c/asm expression in C program**
- ** 06_: call_c_in_asm/asm call C function**

.. _01: tutorials/01_string_operations
.. _02: tutorials/02_macros
.. _04: tutorials/04_run_with_c
.. _05: tutorials/05_inline_asm_in_c
.. _06: tutorials/06_call_c_in_asm

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

functions
---------

``ft_strlen``::

   - DESC: increases counter register, and cmp ``[rdi + rcx]``
   - RETURNS:
       - success: index of null-termination from ``rcx``
       - failure: no failure exception.

``ft_strcpy``::

   - DESC: using ``lodsb``, push src to stack loop -> pop loop.
   - RETURNS:
       - success: poped rdi include null-termination.
       - failure: no failure, 
   - *if null first found in dst? recapture src to buffer and copies.*
   - copie using stack, if 0 in to dst? re capture stack from src for rcx left.
