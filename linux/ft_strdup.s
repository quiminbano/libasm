section .text
	global ft_strdup
	extern ft_strlen
	extern ft_strcpy
	extern malloc

ft_strdup:
	xor rax, rax
	call ft_strlen
	inc rax
	mov rsi, rdi
	mov rdi, rax
	xor rax, rax
	call malloc
	test rax, rax
	jz malloc_protection
	mov rdi, rax
	xor rax, rax
	call ft_strcpy
	ret

malloc_protection:
	xor rax, rax
	ret