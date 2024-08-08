section .text
	global _ft_strcpy

_ft_strcpy:
	mov rcx, rdi

_loop:
	mov al, [rsi]
	movsb
	cmp al, 0
	je _return
	jmp _loop

_return:
	mov rax, rcx
	ret
