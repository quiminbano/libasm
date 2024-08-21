/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test_strcpy.cpp                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: corellan <corellan@student.hive.fi>        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/08/20 14:11:47 by corellan          #+#    #+#             */
/*   Updated: 2024/08/21 10:58:11 by corellan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <string>
#include <iostream>
#include <fstream>
#include <sstream>
#include <cstring>
#include <csignal>
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

static void	create_log(size_t &result_ft, size_t &result_orig, int &nbr)
{
	std::ofstream		file;
	std::ostringstream	oss;

	oss << "logs/ft_strlen" << nbr << ".txt";
	file.open(oss.str(), std::ios_base::out);
	if (file.fail())
	{
		std::cerr << "Error trying to create/modify the file\n";
		return ;
	}
		file << "TEST CASE NUMBER " << nbr << ".\n\n";
	if (nbr == 4)
	{
		file << "YOUR FT_STRLEN FUNCTION DIDN'T CRASH WHEN IT SHOULD CRASH.\n\n";
		file << "REMEMBER THAT OVERPROTECTION OF YOUR FUNCTIONS MAKES MORE DIFFICULT FOR YOU TO\n";
		file << "DEBUG YOUR CODE IN CASE OF AN ERROR.\n";
	}
	else
	{
		file << "YOUR FT_STRLEN GOT AS RESULT: " << result_ft << "\n";
		file << "IT MUST GET: " << result_orig << "\n";
	}
	file.close();
	return ;
}

static void	process_test(char const *nbr_str)
{
	int				nbr;
	int				*ptr;
	size_t			result_ft;
	size_t			result_orig;

	signal(SIGSEGV, &signal_handler);
	nbr = std::stoi(nbr_str);
	result_ft = 0;
	result_orig = 0;
	if (nbr != 5)
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
		result_ft = ft_strlen("");
		result_ft = std::strlen("");
	case 4:
		ptr = get_status();
		*ptr = 1;
		result_ft = ft_strlen(NULL);
	case 5:
		ptr = get_status();
		*ptr = 1;
		result_ft = std::strlen(NULL);
	default:
		std::cerr << "Error\n";
		break;
	}
	if (result_ft == result_orig || nbr != 4)
		std::cout << "[OK]\n";
	else
	{
		std::cout << "[KO]\n";
		create_log(result_ft, result_orig, nbr);
	}
}

int	main(int ac, char **av)
{
	if (ac == 2)
		process_test(av[2]);
	return (0);
}
