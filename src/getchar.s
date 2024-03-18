.data

ch: .byte 0

.text
	.globl getchar

# return: eax
getchar:
	push %ebx
	push %ecx
	push %edx

	mov $3, %eax
	xor %ebx, %ebx
	lea ch, %ecx
	mov $1, %edx
	int $0x80

	cmp $0, %eax
	je fine
	movzx ch, %eax

fine:
	pop %edx
	pop %ecx
	pop %ebx
	ret
