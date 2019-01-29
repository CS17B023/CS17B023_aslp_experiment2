         // lw :- LOAD WORD
         // sw :- STORE WORD
         // li :- LOAD IMMIDIATE
         // teq :- TRAP IF EQUAL 
         // addiu :- ADD IMMIDIATE UNSIGNED
         // addu  :- ADD UNSIGNED
         // mfhi :- MOVE FROM HI
         // mflo :- MOVE FROM LO
         // j    :- JUMP 
         // beq  :- BRANCH ON EQUAL
         // bnq  :- BRANCH ON NOT EQUAL
         // sll  :- SHIFT LEFT LOGICAL
         // slt  :- SET ON LESS THAN


	.file	1 "lab2_2.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=xx
	.module	nooddspreg
	.abicalls
	.text
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$fp,64,$31		# vars= 32, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-64                               ; allocate frame of 64 bytes
	sw	$31,60($sp)                               ; Memory[$sp + 60] = $31
	sw	$fp,56($sp)                               ; Memory[$sp + 56] = $fp
	move	$fp,$sp                                   ; $fp <- [$sp]   ; establish our fp ;
	lui	$28,%hi(__gnu_local_gp)                   ;
	addiu	$28,$28,%lo(__gnu_local_gp)               ;
	.cprestore	16
	lw	$2,%got(__stack_chk_guard)($28)
	lw	$2,0($2)                                  ; $2 = Memory[$2 + 0]   ;
	sw	$2,52($fp)                                ; Memory[$fp + 52] = $2 ;
	sw	$0,32($fp)                                ; Memory[$fp + 32] = $0 ;
	li	$2,1			# 0x1             ; [$2] <- 1             ; Load immidiate ;
	sw	$2,36($fp)                                ; Memory[$fp + 36] = $2 ;
	li	$2,2			# 0x2             ; [$2] <- 2             ; Load immidiate ;
	sw	$2,40($fp)                                ; Memory[$fp + 40] = $2 ;
	li	$2,3			# 0x3             ; [$2] <- 3             ; Load immidiate ;
	sw	$2,44($fp)                                ; Memory[$fp + 44] = $2 ;
	li	$2,4			# 0x4             ; [$2] <- 4             ; Load immidiate ;
	sw	$2,48($fp)                                ; Memory[$fp + 48] = $2 ;
	sw	$0,28($fp)                                ; Memory[$fp + 28] = $0 ;
	b	$L2                                       ; Branch to the instruction at label $L2 
	nop

$L3:
	lw	$2,28($fp)                                ; $2 = Memory[$fp + 28] ;
	sll	$2,$2,2                                   ; $2 = $2<<2            ;
	addiu	$3,$fp,56                                 ; $3 = $fp + 56         ;
	addu	$2,$3,$2                                  ; $2 = $3 + $2          ;
	lw	$2,-24($2)                                ; $2 = Memory[$fp - 24] ;
	addiu	$3,$2,2                                   ; $3 = $2 + 2           ;
	lw	$2,28($fp)                                ; $2 = Memory[$fp + 28] ;
	sll	$2,$2,2                                   ; $2 = $2<<2            ;
	addiu	$4,$fp,56                                 ; $4 = $fp + 56         ; 
	addu	$2,$4,$2                                  ; $2 = $4  + $2         ;
	sw	$3,-24($2)                                ; Memory[$sp + 20] = $fp;
	lw	$2,28($fp)                                ; $2 = Memory[$fp + 28] ;
	addiu	$2,$2,1                                   ; $2 = $2 + 1           ;
	sw	$2,28($fp)                                ; Memory[$fp + 28] = $2 ;
$L2:
	lw	$2,28($fp)                                ; $2 = Memory[$fp + 28] ;
	slt	$2,$2,5                                   ; if($2<5)$2=1 else $2=0; 
	bne	$2,$0,$L3                                 ; if($2 != $0) goto PC + 4 + $L3
	nop 

	move	$2,$0                                     ; $2 <- [$0] 
	lw	$3,%got(__stack_chk_guard)($28)           ;
	lw	$4,52($fp)                                ; $4 = Memory[$fp + 52]
	lw	$3,0($3)                                  ; $3 = Memory[$3 + 0]
	beq	$4,$3,$L5                                 ; if($4 == $3) goto PC + 4 + $L5 ;
	nop

	lw	$2,%call16(__stack_chk_fail)($28)         ;
	move	$25,$2                                    ; $25 <- [$2] ;
	.reloc	1f,R_MIPS_JALR,__stack_chk_fail           ;
1:	jalr	$25                                       ; 
	nop

$L5:
	move	$sp,$fp                                   ; $sp <- [$fp]           ;
	lw	$31,60($sp)                               ; $31 = Memory[$sp + 60] ;
	lw	$fp,56($sp)                               ; $fp = Memory[$sp + 64] ;
	addiu	$sp,$sp,64                                ; $sp = $sp + 64         ;
	j	$31                                       ; go to resgister $31   ; Jump    
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609"
