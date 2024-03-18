.text
	.globl itoa

# eax = num
# esi = string
# return: esi
itoa:
	push %eax
	push %ebx
	push %ecx
	push %edx
	push %esi

	mov $10, %ebx
	xor %ecx, %ecx

	cmp $0, %eax
	jge ciclo
	movb $45, (%esi)
	inc %esi
	neg %eax

ciclo:
	inc %ecx
	xor %edx, %edx
	div %ebx
	push %edx

	cmp $0, %eax
	jne ciclo

ciclo2:
	cmp $0, %ecx
	je end
	pop %ebx
	add $48, %bl
	mov %bl, (%esi)
	inc %esi
	dec %ecx
	jmp ciclo2

end:
	movb $0, (%esi)
	pop %esi
	pop %edx
	pop %ecx
	pop %ebx
	pop %eax
	ret
