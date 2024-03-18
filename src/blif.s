.data

one: .string "1\n"
buf: .string "00"
end: .string ".end\n"
model: .string ".model "
names: .string ".names A"
outputs: .string ".outputs A15 A14 A13 A12 A11 A10 A9 A8 A7 A6 A5 A4 A3 A2 A1 A0\n"

.text
	.globl blif

# esi = string filename
# edi = string instruction
blif:
	push %esi
	push %eax
	push %ebx
	push %ecx

	mov $8, %eax
	mov %esi, %ebx
	mov $0644, %ecx
	int $0x80

	mov %eax, %ebx
	mov %esi, %eax

remove_ext:
	inc %esi
	cmpb $46, (%esi)
	jne remove_ext
	movb $0, (%esi)

	lea model, %esi
	call fprint

	mov %eax, %esi
	call fputs

	lea outputs, %esi
	call fprint

	xor %eax, %eax
ciclo:
	lea names, %esi
	call fprint

	lea buf, %esi
	xor $15, %eax
	call itoa
	xor $15, %eax
	call fputs

	cmpb $48, (%edi, %eax)
	je skip
	lea one, %esi
	call fprint
skip:
	inc %eax
	cmp $16, %eax
	jl ciclo

	lea end, %esi
	call fprint

	mov $6, %eax
	int $0x80

	pop %ecx
	pop %ebx
	pop %eax
	pop %esi
	ret
