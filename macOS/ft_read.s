SYS_READ equ 0x2000003

section .text
	global _ft_read
	extern ___error

_ft_read:
	mov rax, SYS_READ
	syscall
	cmp rax, 0
	jl _error

_success:
	ret

_error:
	neg rax
	mov rbx, rax
	call ___error
	test rax, rax
	jz _error_protection
	mov [rax], rbx
	mov rax, -1
	ret

_error_protection:
	xor rax, rax
	ret
