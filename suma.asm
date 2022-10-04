// suma dintr-un tablou unidimensional si ma, citite de la tastatura


.data
	suma: .long 0
	ps: .asciz "Suma este %d"
	pm: .asciz "Catul mediei este %d, restul este %d"
	nl: .asciz "\n"
	scanLinie: .asciz "%300[^\n]"
	delim: .asciz " "
	formatScanf: .asciz "%d"
	v: .space 100
	n: .space 4
	ma: .space 4
	str: .space 300
.text
.global main

proc:
	pushl %ebp
	movl %esp, %ebp
	
	movl 8(%ebp), %ecx
	cmp n, %ecx
	je stop
	movl (%edi, %ecx,4), %edx
	addl %edx, suma
	movl suma, %eax
	
	incl %ecx
	pushl %ecx
	call proc
	popl %ebx
stop:
	popl %ebp
	ret

main:
	lea v, %edi

	pushl $str
	pushl $scanLinie
	call scanf
	popl %ebx
	popl %ebx

	pushl $delim
	pushl $str
	call strtok
	popl %ebx
	popl %ebx
	
	pushl %eax
	call atoi
	popl %ebx
	
	movl %eax, n
	
	xorl %ecx, %ecx
	
loop_citire:
	cmp n, %ecx
	je pre_proc
	
	pushl %ecx
	
	pushl $delim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx

	pushl %eax
	call atoi
	popl %ebx
	
	popl %ecx
	
	lea v, %edi
	movl %eax, (%edi,%ecx,4)
	addl $1, %ecx
	
	jmp loop_citire
	
	
pre_proc:	
	xorl %ecx, %ecx
	
	pushl %ecx
	call proc
	popl %ebx
	
	pushl %eax
	
	pushl %eax
	pushl $ps
	call printf
	popl %ebx
	popl %ebx
	
	pushl $nl
	call printf
	popl %ebx
	
	movl n, %ecx
	popl %eax
	
	xorl %edx, %edx
	divl %ecx
	
	pushl %edx
	pushl %eax
	pushl $pm
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
