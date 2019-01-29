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
         // sra  :- SHIFT RIGHT ARITHMATIC


	.file	1 "lab2_4.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=xx
	.module	nooddspreg
	.abicalls
	.text
	.align	2
	.globl	IsEven
	.set	nomips16
	.set	nomicromips
	.ent	IsEven
	.type	IsEven, @function
IsEven:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-8                        ; $sp = $sp -8                ;
	sw	$fp,4($sp)                        ; Memory[$sp + 4] = $fp       ;
	move	$fp,$sp                           ; $fp <- [$sp]                ;
	sw	$4,8($fp)                         ; Memory[$fp + 8] = $4        ;
	lw	$2,8($fp)                         ; $2 = Memory[$fp + 8]        ;
	andi	$2,$2,0x1                         ; $2 = $2 & 0x1               ;
	bne	$2,$0,$L2                         ; if($2 != $0) goto PC + 4 + $L2;
	nop

	li	$2,1			# 0x1     ; $2 <-1                      ;
	b	$L3                               ; Branch to the instruction at label $L3
	nop

$L2:
	move	$2,$0                             ; $2 <- [$0]                    ;
$L3:
	move	$sp,$fp                           ; $sp <- [$fp]                  ;                       
	lw	$fp,4($sp)                        ; $fp = Memory[$sp + 4]         ;                      
	addiu	$sp,$sp,8                         ; $sp = $sp + 8                 ;
	j	$31                               ; go to resgister $31   ; Jump  ;
	nop

	.set	macro
	.set	reorder
	.end	IsEven
	.size	IsEven, .-IsEven
	.align	2
	.globl	IsPrime
	.set	nomips16
	.set	nomicromips
	.ent	IsPrime
	.type	IsPrime, @function
IsPrime:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-16                         ; $sp = $sp - 16 ;
	sw	$fp,12($sp)                         ; Memory[$sp + 12] = $fp        ;                         
	move	$fp,$sp                             ; $fp <- [$sp]                  ;
	sw	$4,16($fp)                          ; Memory[$fp + 16] = $4         ;
	li	$2,1			# 0x1       ; $2 <- 1                       ;                   
	sw	$2,0($fp)                           ; Memory[$fp + 0] = $2          ;
	li	$2,2			# 0x2       ; $2 <- 2                       ;
	sw	$2,4($fp)                           ; Memory[$fp + 4] = $2          ;
	b	$L5                                 ; Branch to the instruction at label $L5
	nop

$L8:
	lw	$3,16($fp)                          ; $3 = Memory[$fp + 16]         ;                     
	lw	$2,4($fp)                           ; $2 = Memory[$fp + 4]          ;    
	teq	$2,$0,7  
	div	$0,$3,$2
	mfhi	$2
	bne	$2,$0,$L6
	nop

	sw	$0,0($fp)
	b	$L7
	nop

$L6:
	lw	$2,4($fp)
	addiu	$2,$2,1
	sw	$2,4($fp)
$L5:
	lw	$2,16($fp)
	srl	$3,$2,31
	addu	$2,$3,$2
	sra	$2,$2,1
	move	$3,$2
	lw	$2,4($fp)
	slt	$2,$3,$2
	beq	$2,$0,$L8
	nop

$L7:
	lw	$3,0($fp)
	li	$2,1			# 0x1
	bne	$3,$2,$L9
	nop

	li	$2,1			# 0x1
	b	$L10
	nop

$L9:
	move	$2,$0
$L10:
	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	IsPrime
	.size	IsPrime, .-IsPrime
	.align	2
	.globl	op
	.set	nomips16
	.set	nomicromips
	.ent	op
	.type	op, @function
op:
	.frame	$fp,40,$31		# vars= 8, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	sw	$4,40($fp)
	lw	$4,40($fp)
	.option	pic0
	jal	IsPrime
	nop

	.option	pic2
	move	$3,$2
	li	$2,1			# 0x1
	bne	$3,$2,$L12
	nop

	li	$2,1			# 0x1
	sw	$2,28($fp)
	b	$L13
	nop

$L12:
	li	$2,-1			# 0xffffffffffffffff
	sw	$2,28($fp)
$L13:
	lw	$3,28($fp)
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L14
	nop

	lw	$4,40($fp)
	.option	pic0
	jal	IsEven
	nop

	.option	pic2
	move	$3,$2
	li	$2,1			# 0x1
	bne	$3,$2,$L15
	nop

	li	$2,2			# 0x2
	sw	$2,28($fp)
	b	$L14
	nop

$L15:
	li	$2,3			# 0x3
	sw	$2,28($fp)
$L14:
	lw	$2,28($fp)
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	op
	.size	op, .-op
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
	addiu	$sp,$sp,-64
	sw	$31,60($sp)
	sw	$fp,56($sp)
	move	$fp,$sp
	li	$2,481			# 0x1e1
	sw	$2,36($fp)
	lw	$4,36($fp)
	.option	pic0
	jal	op
	nop

	.option	pic2
	sw	$2,40($fp)
	lw	$2,40($fp)
	li	$3,2			# 0x2
	beq	$2,$3,$L19
	nop

	slt	$3,$2,3
	beq	$3,$0,$L20
	nop

	li	$3,1			# 0x1
	beq	$2,$3,$L21
	nop

	b	$L18
	nop

$L20:
	li	$3,3			# 0x3
	beq	$2,$3,$L22
	nop

	b	$L18
	nop

$L21:
	lw	$3,36($fp)
	li	$2,2			# 0x2
	bne	$3,$2,$L24
	nop

	li	$2,2			# 0x2
	sw	$2,44($fp)
	b	$L18
	nop

$L24:
	lw	$2,36($fp)
	addiu	$2,$2,1
	sw	$2,44($fp)
	b	$L18
	nop

$L19:
	lw	$2,36($fp)
	addiu	$2,$2,1
	sw	$2,48($fp)
	b	$L18
	nop

$L22:
	lw	$4,36($fp)
	.option	pic0
	jal	IsPrime
	nop

	.option	pic2
	beq	$2,$0,$L26
	nop

	lw	$2,36($fp)
	sw	$2,52($fp)
$L26:
	lw	$4,36($fp)
	.option	pic0
	jal	IsEven
	nop

	.option	pic2
	bne	$2,$0,$L38
	nop

	lw	$4,36($fp)
	.option	pic0
	jal	IsPrime
	nop

	.option	pic2
	bne	$2,$0,$L38
	nop

	lw	$2,36($fp)
	sw	$2,28($fp)
	lw	$2,36($fp)
	sw	$2,32($fp)
$L30:
	lw	$4,28($fp)
	.option	pic0
	jal	IsPrime
	nop

	.option	pic2
	bne	$2,$0,$L39
	nop

	lw	$2,28($fp)
	addiu	$2,$2,1
	sw	$2,28($fp)
	b	$L30
	nop

$L39:
	nop
	b	$L31
	nop

$L34:
	lw	$4,32($fp)
	.option	pic0
	jal	IsPrime
	nop

	.option	pic2
	bne	$2,$0,$L40
	nop

	lw	$2,32($fp)
	addiu	$2,$2,-1
	sw	$2,32($fp)
$L31:
	lw	$2,32($fp)
	slt	$2,$2,2
	beq	$2,$0,$L34
	nop

	b	$L33
	nop

$L40:
	nop
$L33:
	lw	$3,28($fp)
	lw	$2,36($fp)
	subu	$3,$3,$2
	lw	$4,36($fp)
	lw	$2,32($fp)
	subu	$2,$4,$2
	slt	$2,$2,$3
	beq	$2,$0,$L35
	nop

	lw	$2,28($fp)
	sw	$2,52($fp)
	b	$L38
	nop

$L35:
	lw	$2,32($fp)
	sw	$2,52($fp)
$L38:
	nop
$L18:
	move	$2,$0
	move	$sp,$fp
	lw	$31,60($sp)
	lw	$fp,56($sp)
	addiu	$sp,$sp,64
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609"
