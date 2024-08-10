section .text
	global _ft_strlen

_ft_strlen:
	xor rcx, rcx

_loop:
	mov al, [rdi + rcx]
	cmp al, 0
	je _return
	inc rcx
	jmp _loop

_return:
	mov rax, rcx
	xor rcx, rcx
	ret
