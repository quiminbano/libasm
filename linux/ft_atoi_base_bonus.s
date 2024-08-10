section .text
	global ft_atoi_base
	extern ft_strlen

ft_atoi_base:
	xor rcx, rcx
	xor rdx, rdx

validate_base_atoi:
	push rdi
	mov rdi, rsi
	call ft_strlen
	pop rdi
	cmp rax, 2
	jl return_zero_atoi_base

return_zero_atoi_base:
	mov rax, 0
	ret
