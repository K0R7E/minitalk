# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: akortvel <akortvel@student.42vienna.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/10/23 16:10:49 by akortvel          #+#    #+#              #
#    Updated: 2023/11/04 13:56:42 by akortvel         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAMES				=	server
NAMEC				=	client

CC					=	cc
CFLAGS 				=	-Wall -Werror -Wextra
AR 					=	ar
ARFLAGS				=	rcs
RM					=	rm -rf

SRC_S				=	server.c
SRC_C				=	client.c


OBJ_DIR_S			=	objs
OBJS_S				=	$(SRC_S:%.c=$(OBJ_DIR_S)/%.o)

OBJ_DIR_C			=	objc
OBJS_C				=	$(SRC_C:%.c=$(OBJ_DIR_C)/%.o)


LIBFT_PATH			= 	./libft
LIBFT				= 	$(LIBFT_PATH)/libft.a

$(OBJ_DIR_S)/%.o:		%.c	
								$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_DIR_C)/%.o:		%.c	
								$(CC) $(CFLAGS) -c $< -o $@

all:				$(NAMEC) $(NAMES)

$(LIBFT):		
						make -C $(LIBFT_PATH) all
					

$(NAMEC): 			$(LIBFT) $(OBJ_DIR_C) $(OBJS_C)
						cp	$(LIBFT) $(NAMEC)
							$(CC) $(CFLAGS) $(OBJS_C) -o $(NAMEC) -L$(LIBFT_PATH) -lft

$(OBJ_DIR_C):
					mkdir -p $(OBJ_DIR_C)


$(NAMES): 			$(LIBFT) $(OBJ_DIR_S) $(OBJS_S)
						cp	$(LIBFT) $(NAMES)
							$(CC) $(CFLAGS) $(OBJS_S) -o $(NAMES) -L$(LIBFT_PATH) -lft

$(OBJ_DIR_S):
					mkdir -p $(OBJ_DIR_S)

clean:
						make -C $(LIBFT_PATH) clean
						${RM} ${OBJ_DIR_C}
						${RM} ${OBJ_DIR_S}

fclean: 			clean
						make -C $(LIBFT_PATH) fclean
						${RM} $(NAMEC)
						${RM} $(NAMES)
			

re: 				fclean all

.PHONY: 			all clean fclean re libft
