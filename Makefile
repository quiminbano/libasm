# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: corellan <corellan@student.hive.fi>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/07 18:35:00 by corellan          #+#    #+#              #
#    Updated: 2024/08/09 17:28:40 by corellan         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = libasm.a

OS = $(shell uname -s)

ifeq ($(OS), Darwin)
	FOLDER = macOS/
	NASM = nasm -f macho64
else
	FOLDER = linux/
	NASM = nasm -f elf64
endif

SRC = $(addprefix $(FOLDER), ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s)

OBJ = $(patsubst $(FOLDER)%.s, obj/%.o, $(SRC))

LIB = ar -rcs

all: $(NAME)

$(NAME): $(OBJ)
	$(LIB) $(NAME) $(OBJ)

obj/%.o: $(FOLDER)%.s
	@mkdir -p obj/
	$(NASM) $< -o $@

clean:
	rm -f $(OBJ)
	rm -rf obj/

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re