%ifidn __OUTPUT_FORMAT__, macho64
	%define FT_STRCPY _ft_strcpy
	%define LOOP _loop
	%define RETURN _return
%else
	%define FT_STRCPY ft_strcpy
	%define LOOP loop
	%define RETURN return
%endif
section .text
	global FT_STRCPY

FT_STRCPY:
	mov rcx, rdi

LOOP:
	mov al, [rsi]
	movsb
	cmp al, 0
	je RETURN
	jmp LOOP

RETURN:
	mov rax, rcx
	ret
