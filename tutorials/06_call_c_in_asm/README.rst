Call C from asm
===============

.. code-block:: c

   #include <stdio.h>

   extern int  print();

   int print(){
       printf("Hello World\n");
       return (0);
   }

.. code-block:: asm

   section .text
       global  _start
       extern print

   _start:
       call    print
       mov     rax, 60
       mov     rdi, 0
       syscall

.. code-block:: Make

   $(NAME): build $(OBJECTS)
       ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 \
       -lc $(OBJECTS) -o $(NAME)

