CC      			= gcc
CFLAGS				= -Wall -Werror -Wextra -Iinclude
SRC					= src/inline_asm.c
.DEFAULT_GOAL		:= all
NAME				= run.out

.PHONY:	all
all:		$(NAME)

$(NAME): $(SRC)
	$(CC) $(CFLAGS) $^ -o $(NAME)

.PHONY: clean
clean:
	/bin/rm $(NAME)


