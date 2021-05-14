	.text
	.intel_syntax noprefix
	.file	"arithmetic.c"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	push	r15
	.cfi_def_cfa_offset 16
	push	r14
	.cfi_def_cfa_offset 24
	push	rbx
	.cfi_def_cfa_offset 32
	.cfi_offset rbx, -32
	.cfi_offset r14, -24
	.cfi_offset r15, -16
	cmp	edi, 2
	jne	.LBB0_1
# %bb.2:
	mov	r14, qword ptr [rsi + 8]
	mov	rbx, r14
	.p2align	4, 0x90
.LBB0_3:                                # =>This Inner Loop Header: Depth=1
	movsx	r15, byte ptr [rbx]
	test	r15, r15
	je	.LBB0_6
# %bb.4:                                #   in Loop: Header=BB0_3 Depth=1
	call	__ctype_b_loc@PLT
	mov	rax, qword ptr [rax]
	add	rbx, 1
	test	byte ptr [rax + 2*r15 + 1], 8
	jne	.LBB0_3
# %bb.5:
	mov	rax, qword ptr [rip + stdout@GOTPCREL]
	mov	rdi, qword ptr [rax]
	lea	rsi, [rip + .L.str]
	mov	rdx, r14
	xor	eax, eax
	call	fprintf@PLT
	mov	ebx, 1
	jmp	.LBB0_7
.LBB0_1:
	mov	rax, qword ptr [rip + stdout@GOTPCREL]
	mov	rcx, qword ptr [rax]
	lea	rdi, [rip + .L.str.2]
	mov	esi, 60
	mov	edx, 1
	call	fwrite@PLT
	mov	ebx, 1
	jmp	.LBB0_7
.LBB0_6:
	xor	ebx, ebx
	mov	rdi, r14
	xor	esi, esi
	mov	edx, 10
	call	strtol@PLT
	mov	rcx, qword ptr [rip + stdout@GOTPCREL]
	mov	r14, qword ptr [rcx]
	mov	edi, eax
	call	arithmetic
	lea	rsi, [rip + .L.str.1]
	mov	rdi, r14
	mov	edx, eax
	xor	eax, eax
	call	fprintf@PLT
.LBB0_7:
	mov	eax, ebx
	pop	rbx
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90         # -- Begin function arithmetic
	.type	arithmetic,@function
arithmetic:                             # @arithmetic
	.cfi_startproc
# %bb.0:
                                        # kill: def $edi killed $edi def $rdi
	xor	eax, eax
	cmp	edi, 2
	jl	.LBB1_2
# %bb.1:
	lea	eax, [rdi - 2]
	lea	ecx, [rdi - 3]
	imul	rcx, rax
	shr	rcx
	lea	eax, [rcx + 2*rdi]
	add	eax, -3
.LBB1_2:
	ret
.Lfunc_end1:
	.size	arithmetic, .Lfunc_end1-arithmetic
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Error: %s is not a number!\n"
	.size	.L.str, 28

	.type	.L.str.1,@object        # @.str.1
.L.str.1:
	.asciz	"Arithmetic sum: %d\n"
	.size	.L.str.1, 20

	.type	.L.str.2,@object        # @.str.2
.L.str.2:
	.asciz	"arithmetic: Compute sum from 1 to n.\n\nUsage: arithmetic <n>\n"
	.size	.L.str.2, 61

	.ident	"clang version 10.0.1 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
