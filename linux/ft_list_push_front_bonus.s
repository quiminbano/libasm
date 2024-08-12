section .text
	global ft_list_push_front
	extern malloc

ft_list_push_front:
	test rsi, rsi
	jz no_context_push_front
	push rdi
	mov rdi, rsi
	call ft_create_elem
	pop rdi
	test rax, rax
	jz no_context_push_front
	

ft_create_elem:
	push rdi
	mov rdi, 16
	call malloc wrt ..plt
	pop rdi
	test rax, rax
	jz malloc_protection_create_elem
	mov [rax], rdi
	ret

malloc_protection_create_elem:
	xor rax, rax
	ret

no_context_push_front:
	xor rax, rax
	ret


