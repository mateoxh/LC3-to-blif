.text
	.globl fprint

# esi = string
# ebx = fd
fprint:
	push %eax
	push %ecx
	push %edx
	push %edi
	push %esi

	mov %esi, %edi
ciclo:
	cmpb $0, (%esi)
	je write
	inc %esi
	jmp ciclo

write:
	mov %esi, %edx
	sub %edi, %edx

	mov $4, %eax
	mov %edi, %ecx
	int $0x80

	pop %esi
	pop %edi
	pop %edx
	pop %ecx
	pop %eax
	ret
