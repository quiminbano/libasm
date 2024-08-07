%ifidn __OUTPUT_FORMAT__, "macho64"
	%define FT_STRCPY _ft_strcpy
	%define LOOP _loop
	%define RETURN return
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
	cmp al, 0
	je RETURN
	movsb
	jmp LOOP

RETURN:
	movsb
	mov rax, rcx
	ret
