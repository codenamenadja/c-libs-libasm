CC				= gcc
CFLAGS			= -Werror -Wall -Wextra -Iinclude
SRC				= src/main.c
OBJECTS			= src/ft_strlen.o
NAME			= run.out
.DEFAULT_GOAL	:= all

all: $(NAME)

$(NAME): build
	$(CC) $(CFLAGS) src/main.c $(OBJECTS) -o run.out

.PHONY: build
build: $(OBJECTS)
	
src/ft_strlen.o:
	nasm -g -f elf64 -o src/ft_strlen.o src/ft_strlen.asm
	ld -o ft_strlen src/ft_strlen.o

clean:
	/bin/rm $(OBJECTS) $(NAME)
