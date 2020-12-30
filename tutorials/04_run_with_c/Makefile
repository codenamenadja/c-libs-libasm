CC      			= gcc
CFLAGS				= -Wall -Werror -Wextra -Iinclude
.DEFAULT_GOAL		:= all
NAME				= run.out

.PHONY:	all
all:		$(NAME)

$(NAME): print_str.o
	$(CC) $(CFLAGS) src/$^ src/main.c -o $(NAME)

print_str.o:
	nasm -f elf64 -o src/$@ src/print_str.asm

.PHONY: clean
clean:
	/bin/rm src/print_str.o $(NAME)
