CC				= gcc
CFLAGS			= -Werror -Wall -Wextra -Iinclude -g
SRC				= src/main.c
OBJECTS			= src/ft_strlen.o src/ft_strcpy.o \
				src/ft_strcmp.o
NAME			= run.out
.DEFAULT_GOAL	:= all

all: $(NAME)

$(NAME): build
	$(CC) $(CFLAGS) src/main.c ./include/libft_asm.a -o run.out

.PHONY: build
build: $(OBJECTS)
	ld -o ./include/libft_asm.a $^
	
src/ft_strlen.o:
	nasm -g -f elf64 -o src/ft_strlen.o src/ft_strlen.asm

src/ft_strcpy.o:
	nasm -g -f elf64 -o src/ft_strcpy.o src/ft_strcpy.asm

src/ft_strcmp.o:
	nasm -g -f elf64 -o src/ft_strcmp.o src/ft_strcmp.asm


clean:
	/bin/rm $(OBJECTS) $(NAME) ./include/libft_asm.a
