.text
	.globl num2bin

# eax = num
# esi = string
num2bin:
	push %eax
	push %ebx
	push %ecx
	push %esi

	mov $16, %ecx
ciclo:
	mov %eax, %ebx
	shl $1, %eax

	shr $15, %ebx
	and $1, %ebx
	add $48, %ebx
	mov %bl, (%esi)
	inc %esi
	loop ciclo

	movb $0, (%esi)

	pop %esi
	pop %ecx
	pop %ebx
	pop %eax
	ret
