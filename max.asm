//maxim si nr de aparitii din array cu recursivitate

.data
	v: .long 10, 76, 34, 76, 12, 9, 76
	n: .long 7
	count: .long 0
	max: .space 4
	printmax: .asciz "Nr max din array este %d"
	printapar: .asciz "Nr max apare de %d ori"
	nl: .asciz "\n"
.text


.global main


counter:
	pushl %ebp
	movl %esp, %ebp
	pushl %edi
	pushl %ebx
	
	movl 12(%ebp), %ecx
	movl 8(%ebp), %edi

	movl n, %ebx
	cmp %ecx, %ebx
	je stop_count
	movl (%edi, %ecx,4), %edx
	cmp %edx, %eax
	je found
	
cont_counter:	
	incl %ecx
	
	pushl %ecx
	pushl $v
	call counter
	popl %ebx
	popl %ebx
	
stop_count:
	movl count, %eax

	popl %ebx
	popl %edi
	popl %ebp
	ret
found:
	addl $1, count
	jmp cont_counter


maxim:
	pushl %ebp
	movl %esp, %ebp
	pushl %edi
	pushl %ebx
	
	movl n, %ebx
	
	movl 12(%ebp), %eax
	movl 8(%ebp), %edi
	
	incl %ecx
	cmp %ebx, %ecx
	je stop
	movl (%edi, %ecx,4), %edx
	cmp %edx, %eax
	jl schimb

cont:	
	pushl max
	pushl $v
	call maxim
	popl %ebx
	popl %ebx

stop:
	popl %ebx
	popl %edi
	popl %ebp
	ret

schimb:
	movl %edx, max
	jmp cont
	


main:
	lea v, %edi
	
	xorl %ecx, %ecx
	movl (%edi, %ecx,4), %ebx
	movl %ebx, max
	
	pushl max
	pushl $v
	call maxim
	popl %ebx
	popl %ebx
	
	pushl %eax
	
	pushl %eax
	pushl $printmax
	call printf
	popl %ebx
	popl %ebx

	pushl $nl
	call printf
	popl %ebx

	popl %eax
	
	xorl %ecx, %ecx
	
	pushl %ecx
	pushl $v
	call counter
	popl %ebx
	popl %ebx
	
	pushl %eax
	pushl $printapar
	call printf
	popl %ebx
	popl %ebx

	pushl $0
	call fflush
	popl %ebx



iesire:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
