NAME = libftprintf.a
LIBFT = libft/
NAME_LIBFT = libft.a
SRC = 	ft_printf.c \
		ft_print_hexa.c \
		ft_putchar.c \
		ft_putstr.c \
		ft_putnbr.c \
		ft_putnbr_u.c \

OBJ = $(SRC:.c=.o)

CC = gcc
AR = ar csr
CFLAGS = -Wall -Wextra -Werror
RM = rm -f
SANITIZE = -fsanitize=address -g3
VALGRIND = valgrind --leak-check=full --show-leak-kinds=all

all: $(NAME)

$(OBJ): %.o : %.c
		@echo "Compiling SRC and LIBF Makefile"
		$(CC) $(CFLAGS) -c $< -o $@
		@echo "Succesful Compiling"

$(NAME) : $(OBJ)
		@echo "Creating printf library"
		make -C $(LIBFT)
		$(AR) $(NAME) $^
		@echo "Succesfully creating library"

out: re
	$(CC) $(CFLAGS) main.c libftprintf.a $(LIBFT)libft.a
	./a.out

sanitize: re
	$(CC) $(SANITIZE) libftprintf.a libft.a
	./a.out

valgrind: re
	$(CC) main.c libftprintf.a libft.a
	$(VALGRIND) ./a.out	

clean :
	$(RM) $(OBJ) ./a.out


fclean : clean
	make fclean -C $(LIBFT)
	$(RM) $(NAME) $(NAME_LIBFT)

re : fclean all

.PHONY : all clean fclean re