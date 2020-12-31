CC      			= gcc
CFLAGS				= -Wall -Werror -Wextra
.DEFAULT_GOAL		:= all
NAME				= run.out
OBJECTS				= src/hello_world.o src/main.o

.PHONY:	all
all:		$(NAME)

$(NAME): build $(OBJECTS)
	ld	-dynamic-linker /lib64/ld-linux-x86-64.so.2 \
	-lc $(OBJECTS) -o $(NAME)

.PHONY: build
build:
	nasm -f elf64 src/main.asm -o src/main.o 

.PHONY: clean
clean:
	/bin/rm $(OBJECTS) $(NAME)
