section .text
	global ft_atoi_base
	extern ft_strlen

ft_atoi_base:
	push rdi
	mov rdi, rsi
	call validate_base_atoi
	pop rdi
	cmp rax, 0
	je return_zero_atoi_base

return_zero_atoi_base:
	xor rax, rax
	ret

return_one_atoi_base:
	mov rax, 1
	ret

validate_base_atoi:
	call ft_strlen
	cmp rax, 2
	jl return_zero_atoi_base
	call loop_for_spaces_and_symbols
	test rax, rax
	jz return_zero_atoi_base
	push rsi
	call check_repeated_char_base
	pop rsi
	test rax, rax
	jnz return_zero_atoi_base
	jmp return_one_atoi_base

loop_for_spaces_and_symbols:
	mov al, [rdi + rcx]
	cmp al, 43
	je return_zero_atoi_base
	cmp al, 45
	je return_zero_atoi_base
	push rdi
	movzx rdi, BYTE al
	call ft_isspace
	pop rdi
	test rax, rax
	jnz return_zero_atoi_base
	inc rcx
	cmp [rdi + rcx], 0
	jne loop_for_spaces_and_symbols
	xor rcx, rcx
	jmp return_one_atoi_base

check_repeated_char_base:
	movzx rsi, BYTE[rdi + rcx]
	xor r8, r8
	xor rdx, rdx
	cmp rsi, 0
	je return_zero_atoi_base
	call loop_for_repeated_char
	test rax, rax
	jnz return_one_atoi_base
	inc rcx
	jmp check_repeated_char_base

loop_for_repeated_char:
	movzx rax, [rdi + r8]
	cmp rax, 0
	je return_zero_atoi_base
	inc r8
	cmp rax, rsi
	jne loop_for_repeated_char
	inc rdx
	cmp rdx, 2
	jl loop_for_repeated_char
	xor rcx, rcx
	xor r8, r8
	xor rdx, rdx
	jmp return_one_atoi_base

ft_isspace:
	cmp rdi, 32
	je return_one_atoi_base
	cmp rdi, 14
	jge return_zero_atoi_base
	cmp rdi, 8
	jle return_zero_atoi_base
	jmp return_one_atoi_base

section .note.GNU-stack