.text
	.globl word

# esi = string
# result: esi
word:
	push %eax
	push %esi

skip_delims:
	call getchar
	cmp $9, %eax
	je skip_delims
	cmp $10, %eax
	je skip_delims
	cmp $32, %eax
	je skip_delims
	cmp $44, %eax
	je skip_delims

	cmp $0, %eax
	jne save_word
	mov $1, %eax
	xor %ebx, %ebx
	int $0x80

save_word:
	mov %al, (%esi)
	inc %esi
	call getchar
	cmp $9, %eax
	je fine
	cmp $10, %eax
	je fine
	cmp $32, %eax
	je fine
	cmp $44, %eax
	je fine
	cmp $0, %eax
	jne save_word

fine:
	movb $0, (%esi)

	pop %esi
	pop %eax
	ret
