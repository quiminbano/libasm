/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: corellan <corellan@student.hive.fi>        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/08/19 12:08:54 by corellan          #+#    #+#             */
/*   Updated: 2024/08/19 17:01:37 by corellan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static void	ft_lstclear(t_list **lst, void (*del)(void *))
{
	t_list	*temp;

	if (lst)
		return ;
	if ((*lst))
	{
		while ((*lst) != 0)
		{
			temp = ((*lst)->next);
			(*del)((*lst)->data);
			free((*lst));
			(*lst) = temp;
		}
	}
	else
		temp = (*lst);
}

int	main(void)
{
	t_list	*test;
	t_list	*tmp;
	char	*str;
	int		return_atoi;

	test = NULL;
	return_atoi = ft_atoi_base("---ff", "0123456789abcdef");
	if (return_atoi == -255)
		printf("RETURN ATOI_BASE: %d\n", return_atoi);
	str = ft_strdup("milk");
	ft_list_push_front(&test, str);
	str = ft_strdup("bread");
	ft_list_push_front(&test, str);
	printf("VALUE OF STRCMP: %d\n", strcmp(test->data, test->next->data));
	printf("VALUE OF FT_STRCMP: %d\n", ft_strcmp(test->data, test->next->data));
	str = ft_strdup("milk");
	ft_list_push_front(&test, str);
	str = ft_strdup("apple");
	ft_list_push_front(&test, str);
	str = ft_strdup("ZEBRA");
	ft_list_push_front(&test, str);
	str = ft_strdup("tomato");
	ft_list_push_front(&test, str);
	str = ft_strdup("milk");
	ft_list_push_front(&test, str);
	tmp = test;
	printf("\nBEFORE SORTING:\n");
	while (tmp)
	{
		printf("STRING: %s\n", (char *)tmp->data);
		tmp = tmp->next;
	}
	ft_list_sort(&test, &ft_strcmp);
	tmp = test;
	printf("\nAFTER_SORTING:\n");
	while (tmp)
	{
		printf("STRING: %s\n", (char *)tmp->data);
		tmp = tmp->next;
	}
	ft_lstclear(&test, &free);
	return (0);
}
