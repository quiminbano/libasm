/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: corellan <corellan@student.hive.fi>        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/08/19 12:08:54 by corellan          #+#    #+#             */
/*   Updated: 2024/08/19 12:24:02 by corellan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"
#include <stdio.h>

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

	test = NULL;
	str = ft_strdup("apple");
	ft_list_push_front(&test, str);
	str = ft_strdup("milk");
	ft_list_push_front(&test, str);
	str = ft_strdup("bread");
	ft_list_push_front(&test, str);
	tmp = test;
	while (tmp)
	{
		printf("STRING: %s\n", (char *)tmp->data);
		tmp = tmp->next;
	}
	return (0);
}
