SYS_READ equ 0

section .text
	global ft_read
	extern __errno_location

ft_read:
	mov rax, SYS_READ
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