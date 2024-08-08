# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: corellan <corellan@student.hive.fi>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/07 18:35:00 by corellan          #+#    #+#              #
#    Updated: 2024/08/08 15:15:02 by corellan         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = libasm.a

OS = $(shell uname -s)

ifeq ($(OS), Darwin)
	FOLDER = macOS/
	SRC = $(addprefix $(FOLDER), ft_strlen.s ft_strcpy.s)
	NASM = nasm -f macho64
else
	FOLDER = linux/
	SRC = $(addprefix $(FOLDER), ft_strlen.s ft_strcpy.s)
	NASM = nasm -f elf64
endif

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