default rel

section .text
	global ft_atoi_base
	extern ft_strlen

ft_atoi_base:
	push rdi
	mov rdi, rsi
	call validate_base_atoi
	pop rdi
	test rax, rax
	jz return_zero_atoi_base
	mov rax, 1
	mov [sign], rax
	mov rax, 0
	mov [number_prev_step], rax
	xor rax, rax

loop_spaces_atoi_base:
	mov al, [rdi + rcx]
	push rdi
	movzx rdi, BYTE al
	call ft_isspace
	pop rdi
	test rax, rax
	jz loop_signs_atoi_base
	inc rcx
	jmp loop_spaces_atoi_base

loop_signs_atoi_base:
	mov al, [rdi + rcx]
	push rdi
	movzx rdi, BYTE al
	call ft_issign
	pop rdi
	test rax, rax
	jz calculate_number_atoi_base
	movzx rax, BYTE[rdi + rcx]
	inc rcx
	cmp rax, 43
	je loop_signs_atoi_base
	mov rax, -1
	mov [sign], rax
	xor rax, rax
	jmp loop_signs_atoi_base

calculate_number_atoi_base:
	movzx rax, BYTE[rdi + rcx]
	cmp rax, 0
	je return_calculated_number_atoi_base
	push rdi
	push rcx
	xor rcx, rcx
	mov rdi, rax
	call return_base_index_loop
	pop rcx
	pop rdi
	cmp rax, [length_base]
	je return_calculated_number_atoi_base
	push rax
	mov rax, [number_prev_step]
	xor rdx, rdx
	imul rax, [length_base]
	mov [number_prev_step], rax
	pop rax
	add rax, [number_prev_step]
	mov [number_prev_step], rax
	inc rcx
	jmp calculate_number_atoi_base

return_calculated_number_atoi_base:
	mov rax, [number_prev_step]
	xor rdx, rdx
	imul rax, [sign]
	ret

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
	mov [length_base], rax
	call loop_for_spaces_and_symbols
	xor rcx, rcx
	test rax, rax
	jnz return_zero_atoi_base
	push rsi
	call check_repeated_char_base
	pop rsi
	xor rcx, rcx
	xor r8, r8
	xor rdx, rdx
	test rax, rax
	jnz return_zero_atoi_base
	jmp return_one_atoi_base

loop_for_spaces_and_symbols:
	mov al, [rdi + rcx]
	cmp al, 43
	je return_one_atoi_base
	cmp al, 45
	je return_one_atoi_base
	push rdi
	movzx rdi, BYTE al
	call ft_isspace
	pop rdi
	test rax, rax
	jnz return_one_atoi_base
	inc rcx
	mov al, [rdi + rcx]
	cmp al, 0
	jne loop_for_spaces_and_symbols
	jmp return_zero_atoi_base

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
	movzx rax, BYTE[rdi + r8]
	cmp rax, 0
	je return_zero_atoi_base
	inc r8
	cmp rax, rsi
	jne loop_for_repeated_char
	inc rdx
	cmp rdx, 2
	jl loop_for_repeated_char
	jmp return_one_atoi_base

ft_isspace:
	cmp rdi, 32
	je return_one_atoi_base
	cmp rdi, 14
	jge return_zero_atoi_base
	cmp rdi, 8
	jle return_zero_atoi_base
	jmp return_one_atoi_base

ft_issign:
	cmp rdi, 43
	je return_one_atoi_base
	cmp rdi, 45
	je return_one_atoi_base
	jmp return_zero_atoi_base

return_base_index_loop:
	movzx rax, BYTE[rsi + rcx]
	cmp rax, 0
	je return_base_index
	cmp rax, rdi
	je return_base_index
	inc rcx
	jmp return_base_index_loop

return_base_index:
	mov rax, rcx
	ret

section .bss
	sign resq 1
	length_base resq 1
	number_prev_step resq 1

section .note.GNU-stack