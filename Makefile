all:
	nasm -g -f elf64 -o $1.o $1.asm
	ld -o $1 $1.o

clean:
	rm $1 $1.o
