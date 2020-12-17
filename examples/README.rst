01_stack
--------

procedure
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
