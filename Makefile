# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ezeh <ezeh@student.42.fr>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/27 10:51:03 by ezeh              #+#    #+#              #
#    Updated: 2024/08/28 14:03:50 by ezeh             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = pipex
NAME_BONUS = pipex_bonus

GREEN			= \033[0;32m
YELLOW			= \033[0;33m
RED				= \033[0;31m
RESET			= \033[0m
# ANSI color codes

LIBFT 			= ./libraries/libft/libft.a
CC 				= gcc
STANDARD_FLAGS 	= -Wall -Werror -Wextra -fsanitize=address,leak
REMOVE 			= rm -f

VALGRIND		= valgrind --leak-check=full --show-leak-kinds=all \
--track-origins=yes --tool=memcheck --keep-debuginfo=yes

SRCS 			= source/pipex.c source/utils.c
OBJS 			= ${SRCS:.c=.o}
SRCS_BONUS 		= source/pipex_bonus.c source/utils_bonus.c
OBJS_BONUS		= ${SRCS:.c=.o}

all:			${LIBFT} ${NAME}

${NAME}: 		
				${CC} ${SRCS} ${LIBFT} ${STANDARD_FLAGS} -o ${NAME}
				@echo "$(NAME): $(GREEN)$(NAME) was compiled.$(RESET)"
				@echo

bonus:			${LIBFT} ${NAME_BONUS}

${NAME_BONUS}:	
				@$(CC) ${SRCS_BONUS} source/utils.c ${LIBFT} ${STANDARD_FLAGS} -o ${NAME_BONUS}
				@echo "\n$(NAME): $(GREEN)$(NAME_BONUS) was compiled with Bonus.$(RESET)"
				@echo

${LIBFT}:
				@echo
				make all -C libraries/libft
				
clean:
				rm -f source/*.o
				make clean -C libraries/libft
				@echo

fclean:			clean
				${REMOVE} ${NAME} ${NAME_BONUS}
				@echo "${NAME}: ${RED}${NAME} and ${NAME_BONUS} were deleted.${RESET}"
				@echo

re:				fclean all

rebonus:		fclean ${NAME_BONUS}

run:			${NAME}
				./${NAME} files/file1 "ls -l" "wc -l" files/file2
				# ${VALGRIND} ./${NAME} files/file1 "ls -l" "wc -l" files/file2

run_bonus:		${NAME_BONUS}
				${VALGRIND} ./${NAME_BONUS} files/file1 "ls -l" "wc -l" "ls -l" files/file2

.PHONY:			all  bonus clean fclean re rebonus run run_bonus
