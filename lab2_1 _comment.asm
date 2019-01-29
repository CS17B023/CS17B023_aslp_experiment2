         // lw :- LOAD WORD
         // sw :- STORE WORD
         // li :- LOAD IMMIDIATE
         // teq :- TRAP IF EQUAL 
         // addiu :- ADD IMMIDIATE UNSIGNED
         // addu  :- ADD UNSIGNED
         // mfhi :- MOVE FROM HI
         // mflo :- MOVE FROM LO
         // j    :- JUMP


	.file	1 "lab2_1.c"
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
	.frame	$fp,24,$31		# vars= 16, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24                      ; allocate frame of 24 bytes
	sw	$fp,20($sp)                      ; Memory[$sp + 20] = $fp
	move	$fp,$sp                          ; $fp <- [$sp]   ; establish our fp ;
	li	$2,10			# 0xa    ; [$2] <- 10     ; Load immidiate   ;
	sw	$2,4($fp)                        ; Memory[$fp + 4] = $2    ;
	li	$2,30			# 0x1e   ; [$2] <- 30 ; Load immidiate ;
	sw	$2,8($fp)                        ; Memory[$fp + 8] = $2  ; store word
	lw	$3,4($fp)                        ; $3 = Memory[$fp + 4]  ; load word
	lw	$2,8($fp)                        ; $2 = Memory[$fp + 8]  ;
	addu	$2,$3,$2                         ; $2 = $3 + $2          ; Add unsigned
	sw	$2,12($fp)                       ; Memory[$fp + 12] = $2 ; 
	lw	$3,4($fp)                        ; $3 = Memory[$fp + 4]  ; 
	lw	$2,8($fp)                        ; $2 = Memory[$fp + 8]  ; 
	subu	$2,$3,$2                         ; $2 = $3 - S2          ; Substract unsigned
	sw	$2,12($fp)                       ; Memory[$fp + 12] = $2 ; 
	lw	$3,4($fp)                        ; $3 = Memory[$fp + 4]  ; 
	lw	$2,8($fp)                        ; $2 = Memory[$fp + 8]  ; 
	mul	$2,$3,$2                         ; $2 = $2*$3            ; Multiply(Without overflow)
	sw	$2,12($fp)                       ; Memory[$fp + 12] = $2 ;
	lw	$3,4($fp)                        ; $3 = Memory[$fp + 12] ;
	lw	$2,8($fp)                        ; $2 = Memory[$fp + 8]  ;
	teq	$2,$0,7                          ; TRAP IF EQUAL         ;
	div	$0,$3,$2                         ; $0 = $3/$2            ; Divide
	mfhi	$2                               ; $2 = hi               ; Move from HI
	mflo	$2                               ; $2 = lo               ; Move from LO
	sw	$2,12($fp)                       ; Memory[$fp + 12] = $2 ;
	lw	$3,4($fp)                        ; $3 = Memory[$fp + 4]  ;
	lw	$2,8($fp)                        ; $2 = Memory[$fp + 8]  ;
	and	$2,$3,$2                         ; $2=$2&$3              ; Bitwise AND 
	sw	$2,12($fp)                       ; Memory[$fp + 12] = $2 ;
	lw	$3,4($fp)                        ; $3 = Memory[$fp + 4]  ;
	lw	$2,8($fp)                        ; $2 = Memory[$fp+ 8]   ;
	or	$2,$3,$2                         ; $2=$2|$3 ; Bitwise OR ;
	sw	$2,12($fp)                       ; Memory[$fp + 12] = $2 ;  
	lw	$3,4($fp)                        ; $3 = Memory[$fp + 4]  ;
	lw	$2,8($fp)                        ; $2 = Memory[$fp + 8]  ;
	xor	$2,$3,$2                         ; $2=$2^$3              ; Bitwise XOR
	sw	$2,12($fp)                       ; Memory[$fp + 12] = $2 ;
	move	$2,$0                            ; $2 <- [$0]            ;
	move	$sp,$fp                          ; $sp <- [$fp]          ;
	lw	$fp,20($sp)                      ; $fp = Memory[$sp + 20];
	addiu	$sp,$sp,24                       ; $sp = $sp + 24        ; Add immidiate unsigned word
	j	$31                              ; go to resgister $31   ; Jump                                                   
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609"
