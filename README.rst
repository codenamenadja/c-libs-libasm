libasm
=======

[SOURCE]: https://github.com/codenamenadja/c-libs-asm

intro
-----

Assembly language has very strong correspndence between
the architecture's machine code instructions.
Each assembly language is specific to a particular computer architecture.
Assembly language may also be called *symbolic machine-code.*

Assembly language programs consist of three types of statments::

   - Executable instructions, or instructions.
   - Assembler directives or pseudo-ops.
   - Macros

*executable instructions* or simple *instructions* tell the processor what to do.
Each instruction consists of an *operation code(opcode).*

The *assembler directives* or *pseudo-ops* tell teh assmebler about the
various aspects of the assmbly process.
Theses are non-executable and do not generate machine language instructions.

*Macros* are basically a text subtitution mechanism.

"Hello world!" program for 64 bit linux nasm style assembly
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: asm

   ;  build: nasm -f elf64 -F dwarf hello.asm
   ;  link:  ld -o hello hello.o

   DEFAULT REL			; use RIP-relative addressing modes by default, so [foo] = [rel foo]

   SECTION .rodata			; read-only data can go in the .rodata section on GNU/Linux, like .rdata on Windows
   Hello:		db "Hello world!",10        ; 10 = `\n`.
   len_Hello:	equ $-Hello                 ; get NASM to calculate the length as an assemble-time constant
   ;;  write() takes a length so a 0-terminated C-style string isn't needed. It would be for puts

   SECTION .text

   global _start
   _start:
       mov eax, 1				; __NR_write syscall number from Linux asm/unistd_64.h (x86_64)
       mov edi, 1				; int fd = STDOUT_FILENO
       lea rsi, [rel Hello]			; x86-64 uses RIP-relative LEA to put static addresses into regs
       mov rdx, len_Hello		; size_t count = len_Hello
       syscall					; write(1, Hello, len_Hello);  call into the kernel to actually do the system call
   ;; return value in RAX.  RCX and R11 are also overwritten by syscall

       mov eax, 60				; __NR_exit call number (x86_64)
       xor edi, edi				; status = 0 (exit normally)
       syscall					; _exit(0)


Section
-------

data section
^^^^^^^^^^^^

``section.data``

``data`` section is used for declaring initialized data or constants.
this data does not chage at runtime.
can declare various constant values, filenames, buffer size, etc.

bss section
^^^^^^^^^^^

``section.bss``

``bss`` section is used for declaring variables.

text section
^^^^^^^^^^^^

.. code-block:: asm

   section.text
       global _start
   _start:

``text`` section is used for keeping the actual code.
must begin with the declaration ``global _start`` ,
which tells the kernel where the program execution begins.

Syntax of Assembly language statements
--------------------------------------

statements are entered one statement per line, in format::

   ``[label]    mnemonic    [operands]  [;comment]``

square brakets are optionals.
default instructions has two parts::

   1. name of the instruction(mnemonic).
   2. operands or parameters of the command.

.. code-block:: asm

   INC  COUNT       ; Increment the memory variable COUNT
   MOV  TOTAL, 48   ; Tranfer the value 48 -> memory variable TOTAL
   ADD  AH, BH      ; Add the content of the BH register into the AH register
   AND  MASK1, 128  ; Perforem AND operation on the variable MASK1 and 128
   ADD  MARKS, 10   ; Add 10 to variable MARKS
   MOV  AL, 10      ; transfer the value 10 to the AL register

Registers
---------

To speed up the processor operations,
the processor includes some internal memory storage locations called, *registers.*

The registers store data elements for processing without having to access the memory.
A limited number of registers are built into the processor chip.

Processor Registers
^^^^^^^^^^^^^^^^^^^

x86, In IA-32 architecture, there are,

- 10 of 32-bit processor registers
- 6 of 16-bit processor registers

And these registers are grouped into 3-categories::

   - General registers
      - Data registers
      - Pointer registers
      - Index registers

   - Control registers
   - Segment registers

Data Register
^^^^^^^^^^^^^

4 of 32-bit registers are used for arithmetic, logical and other operations.
These registers can be used in 3 ways::

   - As compleate 32-bit data registers: ``EAX`` ``EBX`` ``ECX`` ``EDX``
   - Lower havles of the them can be used as 4 of 16 bit data registers: ``AX`` ``BX`` ``CX`` ``DX``
   - Lower and higher halves of the above mentioned four 16-bvit registers can be used as 8 of 8-bit data registers: ``AH`` ``AL`` ``BH`` ``BL`` ``CH`` ``CL`` ``DH`` ``DL``

Some of these data registes have specific use in arithmetical operations

- AX is primary accumulator::

   used in input/output and most arithmetic instructions.
   For example, in multipication operation,
   one operand is stored in EAX or AX or AL register according to the size og the operand.

- BX is known as the base register::

   it used be used in indexed addressing.

- CX is known as the count register::

   as the ``ECX`` ``CX`` registers store the loop count in iterative operations.

- DX is known as the data register::

   is is also used in input/output operations.
   and also used with ``AX`` register along with ``DX`` for mutiply and divide operations involoving large values.

Pointer Registers
^^^^^^^^^^^^^^^^^

The pointer registers are 32bit ``EIP`` ``ESP`` ``EBP`` registers and
corresponding 16-bit right portions ``IP`` ``SP `` BP`` ,
There are three categories of pointer registers.

- Instruction Pointer (IP)::

   16 bit IP regitser store the offset address of the next instruction to be executed.
   IP in association with the CS register (as CS:IP) gives the complete address of the current instruction in the code segment.


- Stack Pointer (SP)::

   16 bit SP register provides the offset value within the program stack.
   SP in association with the SS register (as SS:SP) refers to be
   current position of data or address within the program stack.

- Base Pointer (BP)::

   16 bit BP register mainly helps in referencing the parameter variables passed to a subroutine.
   The address in SS register is combined with the offset in BP to get the location of the parameter.
   BP can also be combined with DI and SI as base register for special addressing.

Index Registers
^^^^^^^^^^^^^^^

The 32-bit index registers ``ESI`` ``EDI`` and their 16-bit right portions, ``SI`` ``DI`` .
They are used for indexed addressing and sometimes used in addtion and subtraction.

- Source Index (SI)::

   used as source index for string operations.

- Destination Index (DI)::

   used as destination index for string operations.

Control Registers
^^^^^^^^^^^^^^^^^

32-bit instruction pointer register and 32-bit flags register combined are considerd as the control registers.

Many instruction involve comparisons and mathematical calculation and change the status of the flags and
some other conditional instructions test the value of these status flags to take the control flow to other location.

Common flag bits are::

   - Overflow Flag
   - Direction FLag
   - Interrupt Flag
   - Trap Flag
   - Sign Flag
   - Zero Flag
   - Auxiliary Carry Flag
   - Parity Flag
   - Carry Flag

Segment Registers
^^^^^^^^^^^^^^^^^

Segments are specific areas defined in program for containing data, code, stack.
THere are 3 of main segments

- Code Segment: stores starting address of the code segment of program-file in memory.

- Data Segment: stores startin address of the data segment of the program-file in memory.

- Stack Segment::

   it contains data and return addressed of procedures or subroutines.
   it is implemented as a 'stack' data structure.
   The stack Segment register or SS register stores the starting address of the stack.

- ES, FS, GS: Extra segment 16-bits registers for provide additional segment for storing data.

Segment registers stores the starting address of a segment.
To get the exact location of data or instruction within segment and offset is required.
To reference any memory location in a segment, processor combines it with an offset.

Variables
---------

There are few *define directives* for reserving storage space for variable.
It is used for allocation of storage space.

Allocating Storage Space for initialized Data
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

SYNTAX
   ``[variable-name]    define-directive    initial-value   [,initial-value]...``

Assembler associates an offset value for each vaiable name defined in the data segment.

=========       ==========     ==============
directive       purpose        storeage space
=========       ==========     ==============
DB              byte           alloc 1 bytes
DW              word           alloc 2 bytes
DD              doubleword     alloc 4 bytes
DQ              quadword       alloc 8 bytes
DT              ten bytes      alloc 10 bytes
=========       ===========    ==============

.. note::

   - Each byte of char is stored as ACII value in hex.
   - Each decimal value is automatically converted to its 16-bit binary equals and stored as hex-number.
   - Processor uses the littel endian byte ordering.
   - Negative numbers are convertied to its 2's complement representation.
   - Short and long float-point numbers are represented using 32 or 64 bits.

Allocating Storage Space for Uninitialized Data
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The reserve directives are used for reserving space for uninitialized data.
The reserver directives take single operand that specific the number of units of space to be reserved.

=========       ==========
directive       purpose   
=========       ==========
RESB            byte     
RESW            word     
RESD            doubleword
RESQ            quadword 
REST            ten bytess
=========       ==========

.. note::

   Reseve directive does not Actually allocate Storage before initializing.

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

bonus
