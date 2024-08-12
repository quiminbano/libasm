section .text
	global _ft_list_push_front
	extern _malloc

_ft_list_push_front:
	test rsi, rsi
	jz _no_context_push_front
	push rdi
	mov rdi, rsi
	call _ft_create_elem
	pop rdi
	test rax, rax
	jz _no_context_push_front
	push rsi
	mov rsi, [rdi]
	mov [rax + 8], rsi
	pop rsi
	mov [rdi], rax
	xor rax, rax
	ret


_ft_create_elem:
	push rdi
	push rsi
	mov rdi, 16
	call _malloc
	pop rsi
	pop rdi
	test rax, rax
	jz _no_context_push_front
	mov [rax], rdi
	ret

_no_context_push_front:
	xor rax, rax
	ret
