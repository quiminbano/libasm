SYS_WRITE equ 1

section .text
	global ft_write
	extern __errno_location

ft_write:
	mov rax, SYS_WRITE
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