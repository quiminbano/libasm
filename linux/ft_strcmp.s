section .text
	global ft_strcmp

ft_strcmp:
	mov al, [rdi]
	mov bl, [rsi]
	cmp al, 0
	je return
	cmp bl, 0
	je return
	cmp al, bl
	jne return
	inc rdi
	inc rsi
	jmp ft_strcmp

return:
	movzx eax, BYTE[rdi]
	movzx ebx, BYTE[rsi]
	sub eax, ebx
	ret
