.text
	.globl equals

# esi = string
# edi = string
# return: eax
equals:
	push %ebx
	push %edx
	push %esi
	push %edi

	xor %eax, %eax

ciclo:
	mov (%esi), %dl
	mov (%edi), %bl

	cmp $0, %dl
	je controllo
	cmp $0, %bl
	je fine

	cmp %dl, %bl
	jne fine

	inc %esi
	inc %edi
	jmp ciclo

controllo:
	cmp %dl, %bl
	sete %al

fine:
	pop %edi
	pop %esi
	pop %edx
	pop %ebx
	ret
