01_stack
--------

Description
^^^^^^^^^^^

   - Input stored to Stack as constant referencing address.
   - read with poping to ``rsi`` and ``rsi`` increasing ``[rsi]`` referencing.
   - mov ``[rsi]`` to bl and converts to number.
   - adds two of them restore as string with storing into stack.
   - bottom saved line break and topmost stored largest number.
   - set rsi(was string address) to rsp and syscall print

Procedure
^^^^^^^^^

   1. get data from command line with executing program.
   #. check argc count, proper or not.
   #. top stack ``rsp`` stores argc, remove with adding 8
   #. pop stack and get first param to rsi
   #. call str_to_int function
      1. rsi is source index register
      #. cmp [rsi]pointer with byte 0 if equal return str
      #. save [rsi] to bl & bl += 48 & rax = bl
      #. mov [rsi] (ref of address) to bl(data)
      #. add bl, 48
      #. inc rsi(address)
      #. cmp with byte 0 and [rsi]incresed, loop while non equal

   #. save str_to_int ret rax to r10 and r11.
   #. add r10, r11 & mov r10 to rax
   #. int_to_str call
      1. push values into the stack.
      #. byte size counter using r12 0 to goon.
      #. loop_symbol
         #. rbx to 10 rdx to 0
         #. div rbx: leave divded to rax and move left to rdx
         #. push rdx(which is less than 10) & r12++
         #. while rax != 0 loop.

      #. goto print. all integer to string sets to stack. top most is largest one.

   #. print rsi(source index) set to rsp(top most address)
   #. print from top most address + counted register r12
   #. done.

02_Reverse string
-----------------

Description
^^^^^^^^^^^
 
   - Input string is constant in data section.
      - so we need place to hold processing data.

   - use ``BSS.RESB.12:OUTPUT`` as buffer(upper was stack)
   - Can use Stack, ``BSS-RESX`` or ``Malloc`` as in c.
   - ``cld`` ``lodsb`` increses rsi rdi pointer by 1
      - ``cld``:    clear direction flag.
      - ``lodsb``:  load rsi to al 1byte.

   - function pushes chars with ``lodsb`` and keeps the stack.
   - so no return address at the top of stack? ``ret`` will not work.
   - on function call, stack push args rtol, and push return instruction-address.
      - ``$``:  returns position in mem of string where $ defined.
      - ``$$``: returns position in mem of currect section start.
      - ``mov rdi, $+15`` takes 10 bytes of instuction ``call ft_strlen`` take 5bytes
      - checking ``objdump -D compiled_file`` shows instruction size.

Procedure
^^^^^^^^^

   - _start
   - ft_strlen
      1. compare byte in rsi referencing[] with 0.
      #. equal? function escape.
      #. ``mov al, [rsi]; inc rsi;`` equal to shortcut ``lodsb``
      #. save al data to stack and increase counter. ``inc rcx; push rax;``
      #. rax is accumulator and also main data register. c
         - rax also can store address but can't change the value.
         - in this part we used [rsi] to store value reference.

      #. loop: changed: rsi addr, rcx counter.

   - reverse_str
      1. check rcx is 0 or not, none zero? loop-label start.
      #. pop stack, save to rax, and ``MOV [OUTPUT + %RDX], %RAX``
      #. inc rdx, dec rcx, and poptop

   - print OUTPUT
      1. ``mov RSI, OUTPUT``
      #. print syscall with rdx as counter
