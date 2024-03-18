.text
	.globl puts

# esi = string
puts:
	push %ebx

	mov $1, %ebx
	call fputs

	pop %ebx
	ret
