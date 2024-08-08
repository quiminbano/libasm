section .text
	global ft_strcpy

ft_strcpy:
	mov rcx, rdi

loop:
	mov al, [rsi]
	movsb
	cmp al, 0
	je return
	jmp loop

return:
	mov rax, rcx
	ret
