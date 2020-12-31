Inline assembly in c
====================

The following method is to write assembly code directly in C code.
Special syntax to c code::

   asm [volatile] ("assembly code" : output operand : input operand : clobbers);

GCC volatile
   The typical use of Extended asm statements is to
   manipulate input values to produce output values.
   However, your asm statements may also produce
   side effects.
   If so, you may need to use the volatile qualifier
   to disable certain optimizations

Each operand is described by constraint string 
   - r: kept variable value in general purpose register
   - g: Any register, memory or immediate integer operand
   is allowed, execpt for non general registers.
   - f: Floating point register
   - m: A memory operand is allowed, with any kind
   of address that machine supports in general.

.. code-block:: c

   #include <string.h>

   int main() {
       char *str    = "Hello World\n";
       long len     = strlen(str);
       int  ret     = 0;

       __asm__("movq $1, %%rax \n\t" // number 1
               "movq $1, %%rdi \n\t" // number 1
               "movq %1, %%rsi \n\t" // arg 1
               "movl %2, %%edx \n\t" // arg 2
               "syscall"
               : "=g"(ret)
               : "g"(str), "g" (len));

       return (0);
   }


