section .text
	global ft_strcmp

ft_strcmp:
	xor rcx, rcx
	xor rax, rax
	xor rbx, rbx

loop_cmp:
	mov al, [rdi + rcx]
	mov bl, [rsi + rcx]
	cmp al, 0
	je return_cmp
	cmp bl, 0
	je return_cmp
	cmp al, bl
	jne return_cmp
	inc rcx
	jmp loop_cmp

return_cmp:
	movzx eax, BYTE[rdi + rcx]
	movzx ebx, BYTE[rsi + rcx]
	sub eax, ebx
	xor ecx, ecx
	xor ebx, ebx
	ret

section .note.GNU-stack