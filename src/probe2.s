	.file	"probe2.c"
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
	.long	320
	.globl	UPPER_THRESHOLD
	.align 4
	.type	UPPER_THRESHOLD, @object
	.size	UPPER_THRESHOLD, 4
UPPER_THRESHOLD:
	.long	800
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
	.string	"Accessed %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
.L6:
	movq	placenum@GOTPCREL(%rip), %rax
	movq	%rax, -16(%rbp)
	movq	$0, -24(%rbp)
	movq	$0, -32(%rbp)
#APP
# 36 "probe.h" 1
	mfence
rdtsc

# 0 "" 2
#NO_APP
	movq	%rax, -24(%rbp)
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, %edi
	call	access_data
#APP
# 45 "probe.h" 1
	mfence
rdtsc

# 0 "" 2
#NO_APP
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movl	%eax, %edx
	movq	-24(%rbp), %rax
	movl	%eax, %ecx
	movl	%edx, %eax
	subl	%ecx, %eax
	movl	%eax, -4(%rbp)
	movl	$800, %eax
	cmpl	%eax, -4(%rbp)
	jge	.L5
	movl	-4(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L5:
	movq	placenum@GOTPCREL(%rip), %rax
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
#APP
# 57 "probe.h" 1
	clflush (%rax)

# 0 "" 2
#NO_APP
	nop
	movl	$1000000, %eax
	pxor	%xmm1, %xmm1
	cvtsi2ssl	%eax, %xmm1
	movss	.LC1(%rip), %xmm0
	mulss	%xmm1, %xmm0
	cvttss2siq	%xmm0, %rax
	movl	%eax, %edi
	call	usleep@PLT
	jmp	.L6
	.cfi_endproc
.LFE9:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC1:
	.long	1045220557
	.ident	"GCC: (Debian 10.2.0-16) 10.2.0"
	.section	.note.GNU-stack,"",@progbits
