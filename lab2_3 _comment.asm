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


	.file	1 "lab2_3.c"
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
	.frame	$fp,176,$31		# vars= 144, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-176                                  ; allocate frame of 176 bytes ;
	sw	$31,172($sp)                                  ; Memory[$sp + 172] = $31     ;
	sw	$fp,168($sp)                                  ; Memory[$sp + 168] = $fp     ;
	move	$fp,$sp                                       ; $fp <- $sp ;
	lui	$28,%hi(__gnu_local_gp)
	addiu	$28,$28,%lo(__gnu_local_gp)
	.cprestore	16
	lw	$2,%got(__stack_chk_guard)($28)
	lw	$2,0($2)                                      ; $2 = Memory[$2 + 0]        ;     
	sw	$2,164($fp)                                   ; Memory[$fp + 164] = $2     ;
	li	$2,2			# 0x2                 ; $2 <- 2                    ;
	sw	$2,28($fp)                                    ; Memory[$fp + 28] = $2      ;                                  
	sw	$0,40($fp)                                    ; Memory[$fp + 40] = $0      ;
	addiu	$2,$fp,44                                     ; $2 = $fp + 44              ;
	li	$3,120			# 0x78                ; $3 <- 120                  ;
 	move	$6,$3                                         ; $6 <- [$3]                 ;
	move	$5,$0                                         ; $5 <- [$0]                 ;
	move	$4,$2                                         ; $4 <- [$2]                 ;
	lw	$2,%call16(memset)($28)
	move	$25,$2                                        ; $25 <- [$2]                ;
	.reloc	1f,R_MIPS_JALR,memset
1:	jalr	$25                  
	nop

	lw	$28,16($fp)                                   ; Memory[$fp + 16] = $28     ;
	b	$L2                                           ; Branch to the instruction at label $L2 
	nop

$L8:
	li	$2,1			# 0x1                 ; $2 <- 1                    ;
	sw	$2,36($fp)                                    ; Memory[$fp + 36] = $2      ;
	li	$2,2			# 0x2                 ; $2 <- 2                    ; 
	sw	$2,32($fp)                                    ; Memory[$fp + 32] = $2      ;                            
	b	$L3                                           ; Branch to the instruction at label $L3                        
	nop

$L6:
	lw	$3,28($fp)                                    ; $3 = Memory[$fp + 28]       ;   
	lw	$2,32($fp)                                    ; $2 = Memory[$fp + 32]       ;                                      
	teq	$2,$0,7                                       ; 
	div	$0,$3,$2                                      ; $0 = $3/$2                  ;
	mfhi	$2                                            ; $2 = hi                     ;
	bne	$2,$0,$L4                                     ; if($2 != $0) goto PC + 4 + $L4
	nop

	sw	$0,36($fp)                                    ; Memory[$fp + 36] = $0      ; 
	b	$L5                                           ; Branch to the instruction at label $L5
	nop

$L4:
	lw	$2,32($fp)                                    ; $2 =  Memory[$fp + 32]     ; 
	addiu	$2,$2,1                                       ; $2 = $2 + 1                ;
	sw	$2,32($fp)                                    ; Memory[$fp + 32] = $2      ; 
$L3:
	lw	$3,32($fp)                                    ; $3 =  Memory[$fp + 32]     ;
	lw	$2,28($fp)                                    ; $2 =  Memory[$fp + 28]     ; 
	slt	$2,$3,$2                                      ; if($3<$2)$2=1 else $2=0    ; 
	bne	$2,$0,$L6                                     ; if($2 != $0) goto PC + 4 + $L6
	nop

$L5:
	lw	$3,36($fp)                                    ; $3 =  Memory[$fp + 36]     ;
	li	$2,1			# 0x1                 ; $2 <- 1                    ;
	bne	$3,$2,$L7                                     ; if($3 != $2) goto PC + 4 + $L7
	nop

	lw	$2,40($fp)                                    ; $2 =  Memory[$fp + 40]     ;                 
	addiu	$3,$2,1                                       ; $3 = $2 + 1                ;
	sw	$3,40($fp)                                    : Memory[$fp + 40] = $3      ;
	sll	$2,$2,2                                       ; $2 = $2<<2                 ;
	addiu	$3,$fp,168                                    ; $3 = $fp + 168             ;
	addu	$2,$3,$2                                      ; $2 = $3 + $2               ;
	lw	$3,28($fp)                                    ; $3 =  Memory[$fp + 28]     ;
	sw	$3,-124($2)                                   ; Memory[$2 - 124] = $3      ;
$L7:
	lw	$2,28($fp)                                    ; $2 =  Memory[$fp + 28]     ;
	addiu	$2,$2,1                                       ; $2 = $2 + 1                ;
	sw	$2,28($fp)                                    ; Memory[$fp + 28] = $2      ;                              
$L2:
	lw	$2,28($fp)                                    ; $2 =  Memory[$fp + 28]     ;                                    
	slt	$2,$2,101                                     ; if($2<101)$2=1 else $2=0   ; 
	bne	$2,$0,$L8                                     ; if($2 != $0) goto PC + 4 + $L8
	nop

	move	$2,$0                                         ; $2 <- [$0]                 ;
	lw	$3,%got(__stack_chk_guard)($28)
	lw	$4,164($fp)                                   ; $4 = Memory[$fp + 164]     ;   
	lw	$3,0($3)                                      ; $3 = Memory[$3 + 0]        ;
	beq	$4,$3,$L10                                    ; if($4 == $3) goto PC + 4 + $L10 ;
	nop

	lw	$2,%call16(__stack_chk_fail)($28)
	move	$25,$2                                        ; $25 <- [$2]                 ;
	.reloc	1f,R_MIPS_JALR,__stack_chk_fail
1:	jalr	$25                                           ;
	nop

$L10:
	move	$sp,$fp                                       ; $sp <- [$fp]                 ;
	lw	$31,172($sp)                                  ; $31 = Memory[$sp + 172]      ;
	lw	$fp,168($sp)                                  ; $fp = Memory[$sp + 168]      ;
	addiu	$sp,$sp,176                                   ; $sp = $sp + 176              ;
	j	$31                                           ; go to resgister $31          ; Jump    
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609"
