.data
	x: .long 12
	y: .long 3
	sum: .space 4
	formatPrintf: .asciz "%d"
	ct: .long 10
	cifra: .space 4
	

.text


.global main


proc:
	pushl %ebp
	movl %esp, %ebp
	
	
	movl 8(%esp), %eax
	movl 12(%esp), %ecx
	imul %ecx
while:
	cmp $0, %eax
	je proc_end
	xorl %edx, %edx
	divl ct
	addl %edx, sum
	jmp while
proc_end:
	movl sum, %eax
	and $1, %eax
	
	cmp $0, %eax
	jne impar

par:
	movl $1, %eax
	popl %ebp
	ret
impar:
	movl $0, %eax
	
	popl %ebp
	ret
	
	


main:
	pushl x
	pushl y
	call proc
	popl %ebx
	popl %ebx



et_exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
