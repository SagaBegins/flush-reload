	.file	"autoprobe.c"
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
	.globl	THRESHOLD
	.section	.rodata
	.align 4
	.type	THRESHOLD, @object
	.size	THRESHOLD, 4
THRESHOLD:
	.long	400
	.globl	WAIT_SECONDS
	.align 4
	.type	WAIT_SECONDS, @object
	.size	WAIT_SECONDS, 4
WAIT_SECONDS:
	.long	1045220557
	.globl	TO_MICROSECONDS
	.align 4
	.type	TO_MICROSECONDS, @object
	.size	TO_MICROSECONDS, 4
TO_MICROSECONDS:
	.long	1000000
.LC0:
	.string	"accessed digits: "
.LC1:
	.string	"%d "
	.text
	.globl	autoprobe_func
	.type	autoprobe_func, @function
autoprobe_func:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$256, %rsp
	movl	$0, -4(%rbp)
	movl	$1, -8(%rbp)
	jmp	.L4
.L8:
	movl	-8(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	numbers(%rip), %rax
	movq	(%rdx,%rax), %rax
	movq	%rax, -248(%rbp)
	movq	$0, -24(%rbp)
	movq	$0, -32(%rbp)
#APP
# 14 "probe.h" 1
	mfence
rdtscp
movl %eax, %esi
mov 0-248(%rbp), %rax
movzbl (%rax), %eax
mfence
rdtscp
sub %esi, %eax

# 0 "" 2
#NO_APP
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movl	%eax, -16(%rbp)
	movl	$400, %eax
	cmpl	%eax, -16(%rbp)
	jge	.L6
	movl	-8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	-4(%rbp), %eax
	cltq
	movl	%edx, -240(%rbp,%rax,4)
	addl	$1, -4(%rbp)
	cmpl	$50, -4(%rbp)
	je	.L12
.L6:
	addl	$1, -8(%rbp)
.L4:
	cmpl	$10, -8(%rbp)
	jle	.L8
	jmp	.L7
.L12:
	nop
.L7:
	cmpl	$0, -4(%rbp)
	jle	.L13
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -12(%rbp)
	jmp	.L10
.L11:
	movl	-12(%rbp), %eax
	cltq
	movl	-240(%rbp,%rax,4), %eax
	movl	%eax, %esi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -12(%rbp)
.L10:
	movl	-12(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jl	.L11
	movl	$10, %edi
	call	putchar@PLT
.L13:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	autoprobe_func, .-autoprobe_func
	.section	.rodata
.LC2:
	.string	"%d"
.LC4:
	.string	"start: %ld\n"
	.align 8
.LC5:
	.string	"Expected End: %ld, Actual End:%ld \n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$272, %rsp
	movl	%edi, -260(%rbp)
	movq	%rsi, -272(%rbp)
	movl	$0, -244(%rbp)
	cmpl	$1, -260(%rbp)
	jle	.L15
	movq	-272(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	-244(%rbp), %rdx
	leaq	.LC2(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf@PLT
.L15:
	movl	-244(%rbp), %eax
	testl	%eax, %eax
	jg	.L16
.L19:
	movl	$0, %eax
	call	autoprobe_func
	movl	$1, -4(%rbp)
	jmp	.L17
.L18:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	numbers(%rip), %rax
	movq	(%rdx,%rax), %rax
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
#APP
# 63 "probe.h" 1
	clflush (%rax)

# 0 "" 2
#NO_APP
	nop
	addl	$1, -4(%rbp)
.L17:
	cmpl	$10, -4(%rbp)
	jle	.L18
	movl	$1000000, %eax
	pxor	%xmm1, %xmm1
	cvtsi2ssl	%eax, %xmm1
	movss	.LC3(%rip), %xmm0
	mulss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, %edi
	call	usleep@PLT
	jmp	.L19
.L16:
	movl	$0, %edi
	call	time@PLT
	movq	%rax, %rdx
	movl	-244(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movq	%rax, -16(%rbp)
	movl	-244(%rbp), %eax
	movslq	%eax, %rdx
	movq	-16(%rbp), %rax
	subq	%rdx, %rax
	movq	%rax, %rsi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L20
.L23:
	movl	$0, %eax
	call	autoprobe_func
	movl	$1, -8(%rbp)
	jmp	.L21
.L22:
	movl	-8(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	numbers(%rip), %rax
	movq	(%rdx,%rax), %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
#APP
# 63 "probe.h" 1
	clflush (%rax)

# 0 "" 2
#NO_APP
	nop
	addl	$1, -8(%rbp)
.L21:
	cmpl	$10, -8(%rbp)
	jle	.L22
	movl	$1000000, %eax
	pxor	%xmm1, %xmm1
	cvtsi2ssl	%eax, %xmm1
	movss	.LC3(%rip), %xmm0
	mulss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, %edi
	call	usleep@PLT
.L20:
	movl	$0, %edi
	call	time@PLT
	cmpq	%rax, -16(%rbp)
	jg	.L23
	movl	$0, %edi
	call	time@PLT
	movq	%rax, %rdx
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC3:
	.long	1045220557
	.ident	"GCC: (Debian 10.2.0-16) 10.2.0"
	.section	.note.GNU-stack,"",@progbits
