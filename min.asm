//cele mai mici 2 elemente din array

.data
	v: .long 20, 77, 9, 18, 34, 23, 17, 33
	n: .long 7
	format: .asciz "Nr cel mai mic este %d, iar al doilea cel mai mic este %d "
.text
.global main

min:
	pushl %ebp
	movl %esp, %ebp
	pushl %edi
	pushl %ebx
	pushl %esi
	
	movl 16(%ebp), %esi
	movl 8(%ebp), %edx
	movl 12(%ebp), %eax
	incl %ecx
	
	cmp %esi, %ecx
	je stop
	
	movl (%edi,%ecx,4), %ebx
	cmp %ebx, %edx
	jg nou_min
	

cont:	
	pushl %esi
	pushl %eax
	pushl %edx
	call min
	popl %ebx
	popl %ebx
	popl %ebx
	
stop:
	popl %esi
	popl %ebx
	popl %edi
	popl %ebp
	ret

nou_min:
	movl %ebx, %edx
	cmp %edx, %eax
	jg intersch
	jmp cont
	
	
intersch:
	xorl %edx, %eax
	xorl %eax, %edx
	xorl %edx, %eax
	jmp cont
	


main:
	lea v, %edi
	
	xorl %ecx, %ecx
	movl (%edi, %ecx,4), %eax
	incl %ecx
	movl (%edi, %ecx,4), %edx
	
	cmp %eax, %edx
	jl schimb
proc:	
	movl n, %esi
	
	pushl %esi
	pushl %eax
	pushl %edx
	call min
	popl %ebx
	popl %ebx
	popl %ebx
	jmp afisare

schimb:
	xorl %edx, %eax
	xorl %eax, %edx
	xorl %edx, %eax
	jmp proc


afisare:
	pushl %edx
	pushl %eax
	pushl $format
	call printf
	popl %ebx
	popl %ebx
	popl %ebx

	pushl $0
	call fflush
	popl %ebx


iesire:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
