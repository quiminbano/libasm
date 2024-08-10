section .text
	global _ft_strcmp

_ft_strcmp:
	xor rcx, rcx

_loop_cmp:
	mov al, [rdi + rcx]
	mov bl, [rsi + rcx]
	cmp al, 0
	je _return_cmp
	cmp bl, 0
	je _return_cmp
	cmp al, bl
	jne _return_cmp
	inc rcx
	jmp _loop_cmp

_return:
	movzx eax, BYTE[rdi + rcx]
	movzx ebx, BYTE[rsi + rcx]
	sub eax, ebx
	xor rcx, rcx
	xor rbx, rbx
	ret
