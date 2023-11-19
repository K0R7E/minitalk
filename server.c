/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: akortvel <akortvel@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/10/24 13:42:44 by akortvel          #+#    #+#             */
/*   Updated: 2023/11/07 12:58:19 by akortvel         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

void	ft_signals(int sig)
{
	static int	bit;
	static int	character;

	if (sig == SIGUSR1)
		character |= (1 << bit);
	bit++;
	if (bit == 8)
	{
		ft_printf("%c", character);
		bit = 0;
		character = 0;
	}
}

int	main(int ac, char **av)
{
	int	pid;

	(void)av;
	if (ac != 1)
	{
		ft_printf("Error, please do not entere a value!");
		return (1);
	}
	pid = (int)(getpid());
	ft_printf("%d\n", pid);
	while (ac == 1)
	{
		signal(SIGUSR1, ft_signals);
		signal(SIGUSR2, ft_signals);
		pause();
	}
	return (0);
}
