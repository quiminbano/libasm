section .text
	global ft_strlen

ft_strlen:
	xor rcx, rcx

loop:
	mov al, [rdi]
	cmp al, 0
	je return
	inc rcx
	inc rdi
	jmp loop

return:
	mov rax, rcx
	ret

section .note.GNU-stack
