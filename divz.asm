//sa se verifice daca un nr e prim (sau aflati div lui)
.data
	x: .space 4
	formatPrintf: .asciz "%d "
	vect: .space 4
	endl: .asciz "\n"
	formatScanf: .asciz "%d"
	count: .long 0
	format: .asciz "Nr %d este prim"

.text


.global main

divisors:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %ebx
	
	
	movl 8(%ebp), %eax
	movl %eax, %ebx
	subl $1, %ebx
	xorl %ecx, %ecx
	
loop:
	pushl %eax
	xorl %edx, %edx
	cmp $1, %ebx
	je stop_loop
	cdq
	idivl %ebx
	cmp $0, %edx
	je adaug
	popl %eax
	decl %ebx
	jmp loop
adaug:
	//addl $1, count
	movl %ebx, (%esi, %ecx,4)
	incl %ecx
	popl %eax
	decl %ebx
	jmp loop
stop_loop:
	popl %eax
	popl %ebx
	popl %esi
	popl %ebp
	ret
	
	

main:
	lea vect, %esi
	
	pushl $x
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	pushl x
	call divisors
	popl %ebx
aici:	
	//movl count, %ebx
	//cmp $0, %ebx
	//je este_prim

	movl %ecx, %edi
	xorl %ecx, %ecx
	
afisare_loop:
	cmp %ecx, %edi
	je et_exit
	movl (%esi, %ecx,4), %eax
	
	pushl %ecx
	
	pushl %eax
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	
	pushl $0
	call fflush
	popl %ebx
	
	popl %ecx
	incl %ecx
	
	jmp afisare_loop

este_prim:
	pushl x
	pushl $format
	call printf
	popl %ebx
	popl %ebx

et_exit:
	pushl $endl
	call printf
	popl %ebx
	
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
