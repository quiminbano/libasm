section .text
	global _ft_strcmp

_ft_strcmp:
	mov al, [rdi]
	mov bl, [rsi]
	cmp al, 0
	je _return
	cmp bl, 0
	je _return
	cmp al, bl
	jne _return
	inc rdi
	inc rsi
	jmp _ft_strcmp

_return:
	movzx eax, BYTE[rdi]
	movzx ebx, BYTE[rsi]
	sub eax, ebx
	ret
