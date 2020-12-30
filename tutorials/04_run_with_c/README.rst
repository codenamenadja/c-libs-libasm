Call assembly from C
====================

.. code-block:: c

   int main(void) {
       char *str    = "Hello World\n";
       int  len     = strlen(str);
       printHelloWorld(str, len);
       return (EXIT_SUCCESS);
   }

printHelloWorld is assembly function.
As we use x84_64 Linux, we must know x84_64 Linux calling conventions.

function call parmeter
^^^^^^^^^^^^^^^^^^^^^^

   - rdi
   - rsi
   - rdx
   - rcx
   - r8
   - r9
   - stack

   at prev case, we can get first and 2nd param with ``rdi`` ``rsi`` registers
   and call write syscall and then return from function with ret instruction.

