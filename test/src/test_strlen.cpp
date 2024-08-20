/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test_strlen.cpp                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: corellan <corellan@student.hive.fi>        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/08/20 14:11:47 by corellan          #+#    #+#             */
/*   Updated: 2024/08/20 16:22:29 by corellan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <string>
#include <iostream>
#include <cstring>
#include <signal.h>
#include "libasm.h"

static int	*get_status(void)
{
	static int	test_status = 0;

	return (&test_status);
}

static void	signal_handler(int sig)
{
	int	*test_status_addr;

	test_status_addr = get_status();
	if (sig == SIGSEGV && !(*test_status_addr))
		std::cout << "[CRASH] -> [KO]" << "\n";
	else if (sig == SIGSEGV && (*test_status_addr))
		std::cout << "[CRASH] -> [OK]" << "\n";
	std::exit(0);
}

static int	process_test(char const *nbr_str)
{
	int		nbr;
	int		*ptr;
	size_t	result_ft;
	size_t	result_orig;

	nbr = std::stoi(nbr_str);
	std::cout << "Test " << nbr << ": ";
	switch (nbr)
	{
	case 1:
		result_ft = ft_strlen("Hello, World\n");
		result_orig = std::strlen("Hello, World\n");
		break;
	case 2:
		result_ft = ft_strlen("Hello\0,World\n");
		result_ft = std::strlen("Hello\0,World\n");
	case 3:
		ptr = get_status();
		*ptr = 1;
		result_ft = ft_strlen(NULL);
	case 4:
		ptr = get_status();
		*ptr = 1;
		result_ft = std::strlen(NULL);
	default:
		std::cerr << "Error\n";
		break;
	}
	if (result_ft == result_orig)
		std::cout << "[OK]\n";
	else
		std::cout << "[KO]\n";
}

int	main(int ac, char **av)
{
	signal(SIGSEGV, &signal_handler);
	if (ac == 2)
		process_test(av[2]);
	return (0);
}
