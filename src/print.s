.text
	.globl print

# esi = string
print:
	push %ebx

	mov $1, %ebx
	call fprint

	pop %ebx
	ret
