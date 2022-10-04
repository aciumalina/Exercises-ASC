//eax factorial recursiv

.data
	x: .long 10
	print: .asciz "%d"

.text




.global main

fact:
	pushl %ebp
	movl %esp, %ebp
	
	movl 8(%ebp), %ecx
	subl $1, %ecx
	cmp $0, %ecx
	je stop
	imul %ecx
	
	pushl %ecx
	call fact
	popl %ebx
	
	
stop:
	popl %ebp
	ret


main:
	movl x, %eax

	pushl %eax
	call fact
	popl %ebx
	
	pushl %eax
	pushl $print
	call printf
	popl %ebx
	popl %ebx
	
	pushl $0
	call fflush
	popl %ebx
	
et_exit:
	movl $1, %eax
	popl %ebx
	int $0x80








