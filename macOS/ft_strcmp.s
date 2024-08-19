section .text
	global _ft_strcmp

_ft_strcmp:
	xor rcx, rcx
	xor rdx, rdx

_loop_cmp:
	mov al, [rdi + rcx]
	mov dl, [rsi + rcx]
	cmp al, 0
	je _return_cmp
	cmp dl, 0
	je _return_cmp
	cmp al, dl
	jne _return_cmp
	inc rcx
	jmp _loop_cmp

_return_cmp:
	xor rax, rax
	xor rdx, rdx
	movzx eax, BYTE[rdi + rcx]
	movzx edx, BYTE[rsi + rcx]
	sub eax, edx
	xor rcx, rcx
	xor rdx, rdx
	ret
