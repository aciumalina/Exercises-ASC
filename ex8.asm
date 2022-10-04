//verif daca un nr e palindrom in reprez binara

.data
	x: .long 8
	ct: .long 2
	print: .asciz "Nr %d nu e palindrom"
	nl: .asciz "\n"
	formatPrintf: .asciz "Nr %d este palindrom"
	vect: .space 4
	invers: .space 4
.text

.global main

comp:
	pushl %ebp
	movl %esp, %ebp
	
	pushl %esi
	pushl %edi
	pushl %ebx
	
	movl 8(%ebp), %ecx
	movl 12(%ebp), %edx
	
	cmp $0, %edx
	je oprire
	
	movl (%edi, %ecx, 4), %eax
	movl (%esi, %edx,4), %ebx
	
	cmp %eax, %ebx
	jne stop
	
	incl %ecx
	decl %edx
	
	pushl %edx
	pushl %ecx
	call comp
	popl %ebx
	popl %ebx

		
stop:
	pushl x
	pushl $print
	call printf
	popl %ebx
	popl %ebx
	
	pushl $nl
	call printf
	popl %ebx
	
	popl %ebx
	popl %edi
	popl %esi
	popl %ebp
	
	ret
oprire:
	pushl x
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	
	pushl $nl
	call printf
	popl %ebx

	popl %ebx
	popl %edi
	popl %esi
	popl %ebp
	
	jmp iesire	

main:
	lea vect, %esi
	lea invers, %edi
	
	movl x, %eax
	xorl %ecx, %ecx
b2:	
	cmp $1, %eax
	jle done
	xorl %edx, %edx
	idivl ct
	movl %edx, (%esi, %ecx,4)
	incl %ecx
	jmp b2

done:
	movl %eax, (%esi, %ecx, 4)
	xorl %edx, %edx
transf:
	cmp $0, %ecx
	jl prelucrare
	movl (%esi, %ecx,4), %ebx
	movl %ebx, (%edi, %edx, 4)
	incl %edx
	decl %ecx
	jmp transf

prelucrare:
	addl $1, %ecx

	pushl %edx
	pushl %ecx
	call comp
	popl %ebx
	popl %ebx
	

iesire:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
