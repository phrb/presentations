	.file	"b.c"
	.text
	.section	.rodata
.LC0:
	.string	"Oi!"
	.text
	.globl	b
	.type	b, @function
b:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	b, .-b
	.ident	"GCC: (GNU) 10.2.0"
	.section	.note.GNU-stack,"",@progbits
