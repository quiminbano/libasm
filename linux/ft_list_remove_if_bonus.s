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

return_void_list_remove_if:
	xor rax, rax
	ret