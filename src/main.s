.data

filename: .string "instructionNNNNNN.blif"
option_blif: .string "-b"

blifmode: .long 0
counter: .long 0

.text
	.globl _start

_start:
	cmpl $2, (%esp)
	jl ciclo
	add $8, %esp
	pop %edi

check_args:
	lea option_blif, %esi
	call equals
	mov %eax, blifmode

	pop %edi
	cmp $0, %edi
	jne check_args

ciclo:
	call emit
	cmpl $0, blifmode
	je print_instruction

	mov %esi, %edi
	lea filename, %esi
	add $11, %esi
	mov counter, %eax
	call itoa

fino_fine:
	inc %esi
	cmpb $0, (%esi)
	jne fino_fine

	movl $0x696c622e, (%esi)
	movw $0x0066, 4(%esi)

	lea filename, %esi
	call blif
	jmp fine

print_instruction:
	call puts

fine:
	incl counter
	jmp ciclo
