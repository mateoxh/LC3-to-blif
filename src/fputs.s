.data

newline: .string "\n"

.text
	.globl fputs

# esi = string
# ebx = fd
fputs:
	push %esi

	call fprint
	lea newline, %esi
	call fprint

	pop %esi
	ret
