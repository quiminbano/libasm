SYS_WRITE equ 1

section .text
	global ft_write
	extern __errno_location

ft_write:
	mov rax, SYS_WRITE
	syscall
	cmp rax, 0
	jl error

success:
	ret

error:
	neg rax
	mov rbx, rax
	call __errno_location wrt ..plt
	test rax, rax
	jz error_protection
	mov [rax], rbx
	mov rax, -1
	ret

error_protection:
	xor rax, rax
	ret