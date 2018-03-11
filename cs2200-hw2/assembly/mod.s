!============================================================
! CS 2200 Homework 2 Part 1: mod
!
! Edit any part of this file necessary to implement the
! mod operation. Store your result in $v0.
!============================================================

mod:
    addi    $a0, $zero, 28     ! $a0 = 28, the number a to compute mod(a,b)
    addi    $a1, $zero, 13     ! $a1 = 13, the number b to compute mod(a,b)
    
    add		$t0, $zero, $a0		! t0 = x
    add 	$t1, $zero, $a1		! t1 = b

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
	add $v0, $zero, $t0
	halt






