// divizori si prim recursiv

.data
	x: .long 5
	v: .space 4
	formatPrintf: .asciz "%d "
	count: .long 0
	prim: .asciz "Nr dat e prim "
.text


.global main

div:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	
	movl x, %eax
	
	movl 8(%ebp), %ebx
	cmp $1, %ebx
	je stop
	
	xorl %edx, %edx
	idivl %ebx
	cmp $0, %edx
	je adaug
	
conti:	
	decl %ebx
	
	pushl %ebx
	call div
	popl %ebx
	
stop:
	popl %ebx
	popl %ebp
	movl count, %eax
	ret
	
	
adaug:
	pushl %ebx
	
	pushl %ebx
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	
	pushl $0
	call fflush
	popl %ebx
	
	popl %ebx
	
	addl $1, count
	
	jmp conti







main:
	movl x, %eax
	subl $1, %eax
	
	xorl %ecx, %ecx
	pushl %eax
	call div
	popl %ebx
	
	cmp $0, %eax
	je afis_prim

iesire:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
	
afis_prim:
	pushl $prim
	call printf
	popl %ebx
	
	pushl $0
	call fflush
	popl %ebx
	jmp iesire
