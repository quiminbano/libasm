%ifidn __OUTPUT_FORMAT__, macho64
	%define FT_STRLEN _ft_strlen
	%define LOOPS _loops
	%define RETURN _return
%else
	%define FT_STRLEN ft_strlen
	%define LOOPS loops
	%define RETURN return
%endif

section .text
	global FT_STRLEN

FT_STRLEN:
	xor rcx, rcx

LOOPS:
	mov al, [rdi]
	cmp al, 0
	je RETURN
	inc rcx
	inc rdi
	jmp LOOPS

RETURN:
	mov rax, rcx
	ret
