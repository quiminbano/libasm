section .text
	global _ft_atoi_base
	extern _ft_strlen

_ft_atoi_base:
	push rdi
	mov rdi, rsi
	call _validate_base_atoi
	pop rdi
	test rax, rax
	jz _return_zero_atoi_base
	mov rax, 1
	mov [rel sign], rax
	mov rax, 0
	mov [rel number_prev_step], rax
	xor rax, rax

_loop_spaces_atoi_base:
	mov al, [rdi + rcx]
	push rdi
	movzx rdi, BYTE al
	call _ft_isspace
	pop rdi
	test rax, rax
	jz _loop_signs_atoi_base
	inc rcx
	jmp _loop_spaces_atoi_base

_loop_signs_atoi_base:
	mov al, [rdi + rcx]
	push rdi
	movzx rdi, BYTE al
	call _ft_issign
	pop rdi
	test rax, rax
	jz _calculate_number_atoi_base
	movzx rax, BYTE[rdi + rcx]
	inc rcx
	cmp rax, 43
	je _loop_signs_atoi_base
	mov rax, -1
	mov [rel sign], rax
	xor rax, rax
	jmp _loop_signs_atoi_base

_calculate_number_atoi_base:
	movzx rax, BYTE[rdi + rcx]
	cmp rax, 0
	je _return_calculated_number_atoi_base
	push rdi
	push rcx
	xor rcx, rcx
	mov rdi, rax
	call _return_base_index_loop
	pop rcx
	pop rdi
	cmp rax, [rel length_base]
	je _return_calculated_number_atoi_base
	push rax
	mov rax, [rel number_prev_step]
	xor rdx, rdx
	imul rax, [rel length_base]
	mov [rel number_prev_step], rax
	pop rax
	add rax, [rel number_prev_step]
	mov [rel number_prev_step], rax
	inc rcx
	jmp _calculate_number_atoi_base

_return_calculated_number_atoi_base:
	mov rax, [rel number_prev_step]
	xor rdx, rdx
	imul rax, [rel sign]
	ret

_return_zero_atoi_base:
	xor rax, rax
	ret

_return_one_atoi_base:
	mov rax, 1
	ret

_validate_base_atoi:
	call _ft_strlen
	cmp rax, 2
	jl _return_zero_atoi_base
	mov [rel length_base], rax
	call _loop_for_spaces_and_symbols
	xor rcx, rcx
	test rax, rax
	jnz _return_zero_atoi_base
	push rsi
	call _check_repeated_char_base
	pop rsi
	xor rcx, rcx
	xor r8, r8
	xor rdx, rdx
	test rax, rax
	jnz _return_zero_atoi_base
	jmp _return_one_atoi_base

_loop_for_spaces_and_symbols:
	mov al, [rdi + rcx]
	cmp al, 43
	je _return_one_atoi_base
	cmp al, 45
	je _return_one_atoi_base
	push rdi
	movzx rdi, BYTE al
	call _ft_isspace
	pop rdi
	test rax, rax
	jnz _return_one_atoi_base
	inc rcx
	mov al, [rdi + rcx]
	cmp al, 0
	jne _loop_for_spaces_and_symbols
	jmp _return_zero_atoi_base

_check_repeated_char_base:
	movzx rsi, BYTE[rdi + rcx]
	xor r8, r8
	xor rdx, rdx
	cmp rsi, 0
	je _return_zero_atoi_base
	call _loop_for_repeated_char
	test rax, rax
	jnz _return_one_atoi_base
	inc rcx
	jmp _check_repeated_char_base

_loop_for_repeated_char:
	movzx rax, BYTE[rdi + r8]
	cmp rax, 0
	je _return_zero_atoi_base
	inc r8
	cmp rax, rsi
	jne _loop_for_repeated_char
	inc rdx
	cmp rdx, 2
	jl _loop_for_repeated_char
	jmp _return_one_atoi_base

_ft_isspace:
	cmp rdi, 32
	je _return_one_atoi_base
	cmp rdi, 14
	jge _return_zero_atoi_base
	cmp rdi, 8
	jle _return_zero_atoi_base
	jmp _return_one_atoi_base

_ft_issign:
	cmp rdi, 43
	je _return_one_atoi_base
	cmp rdi, 45
	je _return_one_atoi_base
	jmp _return_zero_atoi_base

_return_base_index_loop:
	movzx rax, BYTE[rsi + rcx]
	cmp rax, 0
	je _return_base_index
	cmp rax, rdi
	je _return_base_index
	inc rcx
	jmp _return_base_index_loop

_return_base_index:
	mov rax, rcx
	ret

section .bss
	sign resq 1
	length_base resq 1
	number_prev_step resq 1
