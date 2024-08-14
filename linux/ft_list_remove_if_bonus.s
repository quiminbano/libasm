section .data
	initial_ptr qword 0
	current_node qword 0
	next_node qword 0

section .text
	global ft_list_remove_if
	extern free

ft_list_remove_if:
	test rsi, rsi
	jz return_void_list_remove_if ; Return ; if the data of reference is NULL
	test rdx, rdx
	jz return_void_list_remove_if ; Return ; if Function pointer cmp is NULL
	test rcx, rcx
	jz return_void_list_remove_if ; Return ; if Function delete pointer is NULL
	test rdi, rdi
	jz return_void_list_remove_if ; Return ; if the address of the list is NULL
	push rdi
	mov rax, [rdi]
	pop rdi
	test rax, rax
	jz return_void_list_remove_if ; Return ; if the list is empty
	push rdi
	mov rdi, rax
	lea rax, [initial_ptr]
	mov QWORD[rax], rdi



return_void_list_remove_if:
	xor rax, rax
	ret