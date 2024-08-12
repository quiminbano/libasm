# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: corellan <corellan@student.hive.fi>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/07 18:35:00 by corellan          #+#    #+#              #
#    Updated: 2024/08/12 15:57:39 by corellan         ###   ########.fr        #
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

SRC = $(addprefix $(FOLDER), ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s \
ft_read.s ft_strdup.s)

SRC_BONUS = $(addprefix $(FOLDER), ft_strlen.s ft_strcpy.s ft_strcmp.s \
ft_write.s ft_read.s ft_strdup.s ft_atoi_base_bonus.s)

OBJ = $(patsubst $(FOLDER)%.s, obj/%.o, $(SRC))

OBJ_BONUS = $(patsubst $(FOLDER)%.s, obj/%.o, $(SRC_BONUS))

LIB = ar -rcs

all: $(NAME)

$(NAME): $(OBJ)
	$(LIB) $(NAME) $(OBJ)

bonus: .bonus

.bonus: $(OBJ_BONUS)
	$(LIB) $(NAME) $(OBJ_BONUS)
	@touch .bonus

obj/%.o: $(FOLDER)%.s
	@mkdir -p obj/
	$(NASM) $< -o $@

clean:
	@rm -f .bonus
	rm -f $(OBJ)
	rm -rf obj/

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re