	.file	"probe1.c"
	.text
	.globl	access_data
	.type	access_data, @function
access_data:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, %eax
	movb	%al, -4(%rbp)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	access_data, .-access_data
	.globl	N
	.section	.rodata
	.align 4
	.type	N, @object
	.size	N, 4
N:
	.long	500
	.globl	WAIT_SECONDS
	.align 4
	.type	WAIT_SECONDS, @object
	.size	WAIT_SECONDS, 4
WAIT_SECONDS:
	.long	990057071
	.globl	TO_MICROSECONDS
	.align 4
	.type	TO_MICROSECONDS, @object
	.size	TO_MICROSECONDS, 4
TO_MICROSECONDS:
	.long	1000000
	.globl	START_TEST
.LC0:
	.string	"./test 1 &"
	.section	.data.rel.local,"aw"
	.align 8
	.type	START_TEST, @object
	.size	START_TEST, 8
START_TEST:
	.quad	.LC0
	.globl	END_TEST
	.section	.rodata
.LC1:
	.string	"pgrep test | xargs kill"
	.section	.data.rel.local
	.align 8
	.type	END_TEST, @object
	.size	END_TEST, 8
END_TEST:
	.quad	.LC1
	.globl	FILE_FORMAT
	.section	.rodata
.LC2:
	.string	"data/%s/%s"
	.section	.data.rel.local
	.align 8
	.type	FILE_FORMAT, @object
	.size	FILE_FORMAT, 8
FILE_FORMAT:
	.quad	.LC2
	.globl	SAVE_PLOTS
	.section	.rodata
.LC3:
	.string	"python3 plotter.py"
	.section	.data.rel.local
	.align 8
	.type	SAVE_PLOTS, @object
	.size	SAVE_PLOTS, 8
SAVE_PLOTS:
	.quad	.LC3
	.section	.rodata
.LC5:
	.string	"w+"
.LC6:
	.string	"Avg ticks: %d\n"
	.text
	.globl	probe
	.type	probe, @function
probe:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movq	%rdi, -72(%rbp)
	movq	%rsi, -80(%rbp)
	movq	%rdx, -88(%rbp)
	movl	$0, -4(%rbp)
	movl	$0, -12(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L4
.L6:
	movq	-72(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	$0, -40(%rbp)
	movq	$0, -48(%rbp)
#APP
# 14 "probe.h" 1
	mfence
rdtscp
movl %eax, %esi
mov 0-56(%rbp), %rax
movzbl (%rax), %eax
mfence
rdtscp
sub %esi, %eax

# 0 "" 2
#NO_APP
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	movl	%eax, -12(%rbp)
	movl	-8(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-80(%rbp), %rax
	addq	%rax, %rdx
	movl	-12(%rbp), %eax
	movl	%eax, (%rdx)
	movl	-8(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-80(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	addl	%eax, -4(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
#APP
# 63 "probe.h" 1
	clflush (%rax)

# 0 "" 2
#NO_APP
	nop
	movl	$1000000, %eax
	pxor	%xmm1, %xmm1
	cvtsi2ssl	%eax, %xmm1
	movss	.LC4(%rip), %xmm0
	mulss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, %edi
	call	usleep@PLT
	addl	$1, -8(%rbp)
.L4:
	movl	$500, %eax
	cmpl	%eax, -8(%rbp)
	jl	.L6
	movq	-88(%rbp), %rax
	leaq	.LC5(%rip), %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -24(%rbp)
	movq	-80(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	file_write
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	movl	$500, %ecx
	movl	-4(%rbp), %eax
	cltd
	idivl	%ecx
	movl	%eax, %esi
	leaq	.LC6(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	probe, .-probe
	.section	.rodata
.LC7:
	.string	"couldn't open file"
.LC8:
	.string	"%d, %d\n"
	.text
	.globl	file_write
	.type	file_write, @function
file_write:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.L8
	leaq	.LC7(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$1, %edi
	call	exit@PLT
.L8:
	movl	$0, -4(%rbp)
	jmp	.L9
.L10:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %ecx
	movl	-4(%rbp), %edx
	movq	-24(%rbp), %rax
	leaq	.LC8(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	addl	$1, -4(%rbp)
.L9:
	movl	$500, %eax
	cmpl	%eax, -4(%rbp)
	jl	.L10
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	file_write, .-file_write
	.section	.rodata
	.align 8
.LC9:
	.string	"Please enter test machine Char(A, B, C or D)"
.LC10:
	.string	"notest/one.csv"
.LC11:
	.string	"Probing One: "
.LC12:
	.string	"notest/three.csv"
.LC13:
	.string	"Probing Three: "
.LC14:
	.string	"notest/six.csv"
.LC15:
	.string	"Probing Six: "
.LC16:
	.string	"notest/placenum.csv"
.LC17:
	.string	"Probing placenum: "
	.align 8
.LC18:
	.string	"\nStarting measurments with test."
.LC19:
	.string	"testf/one.csv"
.LC20:
	.string	"testf/three.csv"
.LC21:
	.string	"testf/six.csv"
.LC22:
	.string	"testf/placenum.csv"
.LC23:
	.string	"\nEnd of test"
.LC24:
	.string	"\nStarting to save plots"
.LC25:
	.string	"Plots saved to ../results"
	.text
	.globl	main
	.type	main, @function
main:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$104, %rsp
	.cfi_offset 3, -24
	movl	%edi, -100(%rbp)
	movq	%rsi, -112(%rbp)
	movq	%rsp, %rax
	movq	%rax, %rbx
	movl	$500, %eax
	cltq
	subq	$1, %rax
	movq	%rax, -24(%rbp)
	movl	$500, %eax
	cltq
	movq	%rax, %r10
	movl	$0, %r11d
	movl	$500, %eax
	cltq
	movq	%rax, %r8
	movl	$0, %r9d
	movl	$500, %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movl	$16, %eax
	subq	$1, %rax
	addq	%rdx, %rax
	movl	$16, %ecx
	movl	$0, %edx
	divq	%rcx
	imulq	$16, %rax, %rax
	subq	%rax, %rsp
	movq	%rsp, %rax
	addq	$3, %rax
	shrq	$2, %rax
	salq	$2, %rax
	movq	%rax, -32(%rbp)
	cmpl	$1, -100(%rbp)
	jne	.L12
	leaq	.LC9(%rip), %rdi
	call	puts@PLT
	movl	$1, %edi
	call	exit@PLT
.L12:
	movq	-112(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	FILE_FORMAT(%rip), %rsi
	movq	-40(%rbp), %rdx
	leaq	-96(%rbp), %rax
	leaq	.LC10(%rip), %rcx
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	leaq	.LC11(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	16+numbers(%rip), %rax
	leaq	-96(%rbp), %rdx
	movq	-32(%rbp), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	probe
	movq	FILE_FORMAT(%rip), %rsi
	movq	-40(%rbp), %rdx
	leaq	-96(%rbp), %rax
	leaq	.LC12(%rip), %rcx
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	leaq	.LC13(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	32+numbers(%rip), %rax
	leaq	-96(%rbp), %rdx
	movq	-32(%rbp), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	probe
	movq	FILE_FORMAT(%rip), %rsi
	movq	-40(%rbp), %rdx
	leaq	-96(%rbp), %rax
	leaq	.LC14(%rip), %rcx
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	leaq	.LC15(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	56+numbers(%rip), %rax
	leaq	-96(%rbp), %rdx
	movq	-32(%rbp), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	probe
	movq	FILE_FORMAT(%rip), %rsi
	movq	-40(%rbp), %rdx
	leaq	-96(%rbp), %rax
	leaq	.LC16(%rip), %rcx
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	leaq	.LC17(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-96(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	movq	placenum@GOTPCREL(%rip), %rax
	movq	%rax, %rdi
	call	probe
	movq	START_TEST(%rip), %rax
	movq	%rax, %rdi
	call	system@PLT
	leaq	.LC18(%rip), %rdi
	call	puts@PLT
	movq	FILE_FORMAT(%rip), %rsi
	movq	-40(%rbp), %rdx
	leaq	-96(%rbp), %rax
	leaq	.LC19(%rip), %rcx
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	leaq	.LC11(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	16+numbers(%rip), %rax
	leaq	-96(%rbp), %rdx
	movq	-32(%rbp), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	probe
	movq	FILE_FORMAT(%rip), %rsi
	movq	-40(%rbp), %rdx
	leaq	-96(%rbp), %rax
	leaq	.LC20(%rip), %rcx
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	leaq	.LC13(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	32+numbers(%rip), %rax
	leaq	-96(%rbp), %rdx
	movq	-32(%rbp), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	probe
	movq	FILE_FORMAT(%rip), %rsi
	movq	-40(%rbp), %rdx
	leaq	-96(%rbp), %rax
	leaq	.LC21(%rip), %rcx
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	leaq	.LC15(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	56+numbers(%rip), %rax
	leaq	-96(%rbp), %rdx
	movq	-32(%rbp), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	probe
	movq	FILE_FORMAT(%rip), %rsi
	movq	-40(%rbp), %rdx
	leaq	-96(%rbp), %rax
	leaq	.LC22(%rip), %rcx
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	leaq	.LC17(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-96(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	movq	placenum@GOTPCREL(%rip), %rax
	movq	%rax, %rdi
	call	probe
	movq	END_TEST(%rip), %rax
	movq	%rax, %rdi
	call	system@PLT
	leaq	.LC23(%rip), %rdi
	call	puts@PLT
	leaq	.LC24(%rip), %rdi
	call	puts@PLT
	movq	SAVE_PLOTS(%rip), %rax
	movq	%rax, %rdi
	call	system@PLT
	leaq	.LC25(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	movq	%rbx, %rsp
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC4:
	.long	990057071
	.ident	"GCC: (Debian 10.2.0-16) 10.2.0"
	.section	.note.GNU-stack,"",@progbits
