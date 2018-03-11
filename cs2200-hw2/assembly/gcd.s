!============================================================
! CS 2200 Homework 2 Part 2: gcd
!
! Please do not change mains functionality,
! except to change the argument for gcd or to meet your
! calling convention
!============================================================

main:
    lea     $sp, stack          ! load ADDRESS of stack label into $sp

    lw 		$sp, 0x0 ($sp)		! Here, you need to initialize the stack
                                ! using the label below by loading its
                                ! VALUE into $sp (CHANGE THIS INSTRUCTION)
                                ! loading the memory into the $sp

    

    lea     $at, gcd            ! load address of gcd label into $at
    addi    $a0, $zero, 25      ! $a0 = 25, the number a to compute gcd(a,b)
    addi    $a1, $zero, 15      ! $a1 = 15, the number b to compute gcd(a,b)

    jalr    $at, $ra            ! jump to gcd, set $ra to return addr
    halt                        ! when we return, just halt

gcd:
    addi 	$sp, $sp, -1		! increments the stack pointer
    sw		$a0, 0x0($sp)		! storing a0 = 25 to my stack
    addi	$sp, $sp, -1		! incrementing stack pointer
    sw		$a1, 0x0($sp)		! storing a1 = 15 to my stack
    addi 	$sp, $sp, -3		! make space for 3 additional things
    sw		$ra, 0x2($sp)		! storing the return address to the stack
    sw		$fp, 0x1($sp)		! storing the old frame pointer to the stack
    addi 	$fp, $sp, 0			! add the new frame pointer to the stack 
     		
    
	skpe	$a1, $zero			! if (b == 0)
	goto recursion
	goto endgcd


recursion:
	goto mod					!load address of gcd label into $at
aftermod:
	addi 	$sp, $sp, -1		!make room for a % b value
	sw		$s2, 0($sp)			!store result of gcd into the stack
	add     $a0, $zero, $t2
	add 	$a1, $zero, $s2
	jalr	$at, $ra			!takes me back to gcd


endgcd:
	add 	$v0, $zero, $a0		!return value is now a
	addi 	$sp, $fp, 0x3		!moves stack pointer back to return value
	lw		$ra, 0x2($fp)		!load return address from the stack
	lw		$fp, 0x1($fp)		!load frame pointer to old frame pointer position
	addi    $sp, $sp, 0x2		!place my sp to the beginning of the stack
	jalr	$ra, $zero			!jumps back to main



stack: .word 0xFFFFFF         ! the stack begins here (for example, that is)



mod:	
    add    $s0, $zero, $a0      ! $s0 = 25, the number a to compute mod(a,b)
    add    $s1, $zero, $a1      ! $s1 = 15, the number b to compute mod(a,b)
    
    add		$t0, $zero, $s0		! t0 = x
    add 	$t1, $zero, $s1		! t1 = b

    add 	$t2, $zero, $t1     ! t2 = b
    nand 	$t1, $t1, $t1       
    addi 	$t1, $t1, 0x1       ! t1 = -b

loop:
    skpgt $t2, $t0    ! if (b > x) go to end
    goto subtract     ! going through the loop and subtracting x = x - b 
    goto end
subtract:
    add 	$t0, $t0, $t1
    goto loop 
end:
	add $s2, $zero, $t0			!s2 holds the return value of the mod
	goto aftermod