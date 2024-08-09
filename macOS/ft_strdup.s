section .text
	global _ft_strdup
	extern _ft_strlen
	extern _ft_strcpy
	extern _malloc

_ft_strdup:
	call _ft_strlen
	inc rax
	mov rsi, rdi
	mov rdi, rax
	xor rax, rax
	call _malloc
	test rax, rax
	jz _malloc_protection:
	mov rdi, rax
	xor rax, rax
	call _ft_strcpy
	ret

_malloc_protection:
	xor rax, rax
	ret

