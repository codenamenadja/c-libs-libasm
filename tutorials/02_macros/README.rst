02_MACROS
=========

%include
--------

This is using nasm assembler and it's processor.
Like .h file macro and definitions in c,
assembly also can include file and use lables or call functions.
with using ``%include`` directive.

macro and function macro
------------------------

Nasms supports two form of macro::

   - single-line:   start from ``%define`` directive.
   - multiline:     start with ``%macro`` ~ ``%endmacro`` directive.

.. code-block:: asm

   ; ----Single line Macro----Start

   %define m_argc      RSP + 8   ; comments
   %define m_cliarg1   RSP + 8   ; comments

   mov   rax, [m_argc]   ; argc will be expanded to rsp + 8
   cmp   rax, 3
   jne   _argc_error     ; will be err, rsp + 8 may be a filename.

   ; ----Single line Macro----END

   ; ----Multi line Macro----Start

   %macro bootstrap 1    ; macro_name numofparam
       push  ebp
       mov   ebp, esp
   %endmacro

   _start:
       bootstrap

   %macro PRINT 1
       pusha        ; push all registers
       pushf        ; push all flags
       jmp %%astr   ; %%astr is label
   %%str    db %1, 0    ; local label name, string ends with 0
   %%stln   equ $-%%str
   %%astr:  _syscall_write %%str, %%strln
   popf
   popa
   %endmacro

   %macro _syscall_write 2
       mov  rax, 1
       mov  rdi, 1
       mov  rsi, %%str      ; its local label mean first param
       mov  rdx, %%strln    ; can it be substitude with %2?
       syscall
   %endmacro

   ; now can use like below,
   print_str: PRINT "Hello World!"
   ; ----Multi line Macro----END

STRUC
-----

can use ``STRUC`` and ``ENCSTRUC`` for data structure definition.

.. code-block:: asm

   struc person
       name:    resb 10
       age:     resb 1
   endstruc

   section .data
       p: person john
           at name  db "name"
           at age   db 25
       iend

   section .text
   _start:
       mov  rax, [p + john.name]
