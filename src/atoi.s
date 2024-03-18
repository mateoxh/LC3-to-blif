.text
	.globl atoi

# esi = string
# return: eax
atoi:
	push %ebx
	push %esi
	pushl $1

	xor %eax, %eax
	mov $10, %ebx

	cmpb $45, (%esi)
	jne ciclo
	inc %esi
	movl $-1, (%esp)

ciclo:
	cmpb $0, (%esi)
	je end
	mul %ebx
	add (%esi), %al
	sub $48, %al
	inc %esi
	jmp ciclo

end:
	pop %ebx
	mul %ebx

	pop %esi
	pop %ebx
	ret
