# **************************************************************************** #
clean:
	rm -f $(OBJ#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: corellan <corellan@student.hive.fi>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/07 18:02:45 by corellan          #+#    #+#              #
#    Updated: 2024/08/07 18:26:29 by corellan         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = libasm.a

SRC = ft_strlen.s ft_strcpy.s

OBJ = $(patsubst %.c, obj/%.o, $(SRC))

OS = $(shell uname -s)

LIB = ar -rcs

ifeq ($(OS), Linux)
	NASM = nasm -f elf64
else
	NASM = nasm -f macho64
endif

all: $(NAME)

$(NAME): $(OBJ)
	$(LIB) $(NAME) $(OBJ)

obj/%.o: %.s:
	mkdir -p obj/
	$(NASM) $<

clean:
	rm -f $(OBJ)
	rm -rf obj/

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re