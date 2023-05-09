	.text
	.globl main
main:
	addi $sp, $sp, -16			#offsets the stack pointer to create a stack frame
	sw $ra, 0($sp)				#stores the return address on the stack
	
	addi $a0, $zero, 7			#argument: 7
	jal fib						#fib
	addi $a0, $v0, 0    		#argument: int
	li $v0, 1       			#syscall 1 (print_int)
    syscall        				#print the int
	
	lw $ra, 0($sp)				#restores the return address
	addi $sp, $sp, 16			#restores the stack pointer
	jr $ra						#returns the function
	
fib:
	addi $sp, $sp, -16			#offsets the stack pointer to create a stack frame
	sw $ra, 8($sp)				#stores the return address on the stack
	sw $s0, 4($sp)				#stores s0 on the stack
	sw $s1, 0($sp)				#stores s1 on the stack

	addi $s0, $a0, 0			#copies the argument n onto s0

	bne $s0, $zero, elif		#jumps to elif if n is not zero
	addi $v0, $zero, 0			#sets the return value to 0
	j end						#jumps to the end of function
elif:
	addi $t0, $zero, 1
	bne $s0, $t0, else			#jumps to else if n is not 1
	addi $v0, $zero, 1			#sets the return value to 1
	j end						#jumps to the end of function
else:
	addi $a0, $s0, -1			#sets the argument to n-1
	jal fib						#calls self recursively
	addi $s1, $v0, 0			#copies the return value onto s1

	addi $a0, $s0, -2			#sets the argument to n-2
	jal fib						#calls self recursively
	add $v0, $s1, $v0			#sets the return value to sum of two
end:
	lw $s1, 0($sp)				#restores s1
	lw $s0, 4($sp)				#restores s0
	lw $ra, 8($sp)				#restores the return address
	addi $sp, $sp, 16			#restores the stack pointer
	jr $ra						#returns the function
