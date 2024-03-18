.data

reg_error1: .string "Eccezione: \""
reg_error2: .string "\" non è un registro!\n"

r0: .string "r0"
r1: .string "r1"
r2: .string "r2"
r3: .string "r3"
r4: .string "r4"
r5: .string "r5"
r6: .string "r6"
r7: .string "r7"

reg_array:
	.long r0
	.long r1
	.long r2
	.long r3
	.long r4
	.long r5
	.long r6
	.long r7
	.long 0

.text
	.globl regcode

# esi = string
# return: eax
regcode:
	push %ebx
	push %edi

	lea reg_array, %ebx
ciclo:
	mov (%ebx), %edi
	cmp $0, %edi
	jne check

	mov %esi, %edi
	lea reg_error1, %esi
	call print
	mov %edi, %esi
	call print
	lea reg_error2, %esi
	call print
	mov $1, %eax
	xor %ebx, %ebx
	int $0x80

check:
	add $4, %ebx
	call equals
	cmp $1, %eax
	jne ciclo

	xor %eax, %eax
	mov 1(%esi), %al
	sub $48, %eax

	pop %edi
	pop %ebx
	ret
