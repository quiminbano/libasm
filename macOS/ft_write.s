SYS_WRITE equ 0x2000004

section .text
	global _ft_write
	extern ___error

_ft_write:
	mov rax, SYS_WRITE
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
