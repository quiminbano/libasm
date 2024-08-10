section .text
	global ft_strcpy

ft_strcpy:
	push rdi
	push rsi

loop:
	mov al, [rsi]
	movsb
	cmp al, 0
	je return
	jmp loop

return:
	pop rsi
	pop rdi
	mov rax, rdi
	ret

section .note.GNU-stack