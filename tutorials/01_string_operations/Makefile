all:
	nasm -g -f elf64 -o reverse.o 02_reverse_string.asm
	ld -o reverse reverse.o

clean:
	rm reverse reverse.o
