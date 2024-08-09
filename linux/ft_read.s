SYS_READ equ 0

section .text
	global ft_read
	extern __errno_location

ft_read:
	mov rax, SYS_READ
	syscall
	jc error

success:
	ret

error:
	mov rbx, rax
	call __errno_location
	test rax, rax
	jz error_protection
	mov [rax], rbx
	mov rax, -1
	ret

error_protection:
	xor rax, rax
	ret