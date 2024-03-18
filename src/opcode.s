.data

op_error1: .string "Eccezione: \""
op_error2: .string "\" non è un'istruzione!\n"

brn:   .string "brn"
brz:   .string "brz"
brp:   .string "brp"
brnz:  .string "brnz"
brzp:  .string "brzp"
brnzp: .string "brnzp"

add:  .string "add"
ld:   .string "ld"
st:   .string "st"

jsr:  .string "jsr"
jsrr: .string "jsrr"

and:  .string "and"
ldr:  .string "ldr"
str:  .string "str"
not:  .string "not"
ldi:  .string "ldi"
sti:  .string "sti"

jmp:  .string "jmp"
ret:  .string "ret"

lea:  .string "lea"
trap: .string "trap"

instr_array:
	.long brn
	.long brz
	.long brp
	.long brnz
	.long brzp
	.long brnzp

	.long add
	.long ld
	.long st

	.long jsr
	.long jsrr

	.long and
	.long ldr
	.long str
	.long not
	.long ldi
	.long sti

	.long jmp
	.long ret

	.long lea
	.long trap
	.long 0

oc_array:
	.long 0b0000 # brn
	.long 0b0000 # brz
	.long 0b0000 # brp
	.long 0b0000 # brnz
	.long 0b0000 # brzp
	.long 0b0000 # brnzp

	.long 0b0001 # add
	.long 0b0010 # ld
	.long 0b0011 # st

	.long 0b0100 # jsr
	.long 0b0100 # jsrr

	.long 0b0101 # and
	.long 0b0110 # ldr
	.long 0b0111 # str

	# .long 0b1000 RESERVED

	.long 0b1001 # not
	.long 0b1010 # ldi
	.long 0b1011 # sti

	.long 0b1100 # jmp
	.long 0b1100 # ret

	#.long 0b1101 RESERVED

	.long 0b1110 # lea
	.long 0b1111 # trap

.text
	.globl opcode

# esi = string
# return: eax
opcode:
	push %ebx
	push %edi

	lea instr_array, %ebx

ciclo:
	mov (%ebx), %edi
	cmp $0, %edi
	jne check

	mov %esi, %edi
	lea op_error1, %esi
	call print
	mov %edi, %esi
	call print
	lea op_error2, %esi
	call print
	mov $1, %eax
	xor %ebx, %ebx
	int $0x80

check:
	add $4, %ebx
	call equals
	cmp $1, %eax
	jne ciclo

	lea instr_array, %edi
	sub %edi, %ebx

	lea oc_array, %edi
	mov -4(%edi, %ebx), %eax

	pop %edi
	pop %ebx
	ret
