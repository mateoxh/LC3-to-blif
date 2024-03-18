.data

buf: .string "000000000000000000000000000000000000000"

# instr_typeN: (eax, esi) -> eax

# instr_type1: ld, st, ldi, sti, lea
# instr_type2: ldr, str
# instr_type3: add, and
# instr_type4: brX[X[X]]
# instr_type5: not
# instr_type6: trap
# instr_type7: jmp/ret
# instr_type8: jsr/jsrr

gen_array:
	.long instr_type4 # br
	.long instr_type3 # add
	.long instr_type1 # ld
	.long instr_type1 # st
	.long instr_type8 # jsr
	.long instr_type3 # and
	.long instr_type2 # ldr
	.long instr_type2 # str
	.long 0 # RESERVED
	.long instr_type5 # not
	.long instr_type1 # ldi
	.long instr_type1 # sti
	.long instr_type7 # jmp
	.long 0 # RESERVED
	.long instr_type1 # lea
	.long instr_type6 # trap

.text
	.globl emit

# return: esi
emit:
	push %eax
	push %ebx

	lea buf, %esi
	lea gen_array, %ebx

	call word
	call opcode
	call *(%ebx, %eax, 4)
	call num2bin

	pop %ebx
	pop %eax
	ret

instr_type1:
	push %ebx

	mov %eax, %ebx
	shl $12, %ebx

	call word
	call regcode
	shl $9, %eax
	or %eax, %ebx

	call word
	call atoi
	and $511, %eax
	or %eax, %ebx

	mov %ebx, %eax
	pop %ebx
	ret

instr_type2:
	push %ebx

	mov %eax, %ebx
	shl $12, %ebx

	call word
	call regcode
	shl $9, %eax
	or %eax, %ebx

	call word
	call regcode
	shl $6, %eax
	or %eax, %ebx

	call word
	call atoi
	and $63, %eax
	or %eax, %ebx

	mov %ebx, %eax
	pop %ebx
	ret

instr_type3:
	push %ebx

	mov %eax, %ebx
	shl $12, %ebx

	call word
	call regcode
	shl $9, %eax
	or %eax, %ebx

	call word
	call regcode
	shl $6, %eax
	or %eax, %ebx

	call word
	cmpb $57, (%esi)
	jg register_mode
	call atoi
	and $31, %eax
	or $32, %eax
	jmp fine

register_mode:
	call regcode

fine:
	or %eax, %ebx
	mov %ebx, %eax
	pop %ebx
	ret

instr_type4:
	push %ebx

	xor %ebx, %ebx

	inc %esi
ciclo:
	inc %esi
	cmpb $110, (%esi) # n
	jne check_z
	or $2048, %ebx
check_z:
	cmpb $122, (%esi) # z
	jne check_p
	or $1024, %ebx
check_p:
	cmpb $112, (%esi) # p
	jne check_null
	or $512, %ebx
check_null:
	cmpb $0, (%esi)
	jne ciclo

	lea buf, %esi
	call word
	call atoi
	and $511, %eax
	or %eax, %ebx

	mov %ebx, %eax
	pop %ebx
	ret

instr_type5:
	push %ebx
	mov %eax, %ebx

	shl $12, %ebx

	call word
	call regcode
	shl $9, %eax
	or %eax, %ebx

	call word
	call regcode
	shl $6, %eax
	or %eax, %ebx
	or $63, %ebx

	mov %ebx, %eax
	pop %ebx
	ret

instr_type6:
	push %ebx
	mov %eax, %ebx

	shl $12, %ebx

	call word
	call atoi
	and $255, %eax
	or %eax, %ebx

	mov %ebx, %eax
	pop %ebx
	ret

instr_type7:
	push %ebx
	mov %eax, %ebx

	shl $12, %ebx
	mov $7, %eax

	cmpb $114, (%esi) # r
	je return_mode

	call word
	call regcode

return_mode:
	shl $6, %eax
	or %eax, %ebx

	mov %ebx, %eax
	pop %ebx
	ret

instr_type8:
	push %ebx
	mov %eax, %ebx

	shl $12, %ebx
	cmpb $0, 3(%esi)
	jne jsrr_mode
	or $2048, %ebx
	call word
	call atoi
	and $2047, %eax
	or %eax, %ebx
	jmp skip

jsrr_mode:
	call word
	call regcode
	shl $6, %eax
	or %eax, %ebx

skip:
	mov %ebx, %eax
	pop %ebx
	ret
