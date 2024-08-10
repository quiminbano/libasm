SYS_WRITE equ 1

section .text
	global ft_write
	extern __errno_location

ft_write:
	mov rax, SYS_WRITE
	syscall
	cmp rax, 0
	jl error_write

success_write:
	ret

error_write:
	neg rax
	mov rbx, rax
	call __errno_location wrt ..plt
	test rax, rax
	jz error_protection_write
	mov [rax], rbx
	mov rax, -1
	ret

error_protection_write:
	xor rax, rax
	ret