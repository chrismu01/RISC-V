#setting up macros
.macro exit #macro to exit program
		li a7, 10
		ecall
		.end_macro	

.macro print_str(%string1) #macro to print any string
	li a7,4 
	la a0, %string1
	ecall
	.end_macro

.macro print_int (%x)  #macro to print any integer or register
	li a7, 1
	add a0, zero, %x
	#zero here refers to register #0
	#the zero register always has constant value of 0
	ecall
	.end_macro

.macro print_exit
	print_str(one)
	loop_exit_1
	ecall
	.end_macro
	
#done with macros


#storing the dats
.data 
	prompt1: .asciz  "Enter the height of the pattern (must be greater than 0):"
	outputMsg: .asciz  "Invalid Entry!"
	newline: .asciz  "\n"  #this prints a newline
	dollar: .asciz  "$"
	star: .asciz  "*"
	both: .asciz  "$*"
	one: .asciz  "$1"

#done storing the data

.text

main: # Label to define the main program.

	#print prompt1 string on console
	print_str(prompt1)
	
	#reading integer n1
	li a7, 5
	ecall
	#a0 now contains user input n1
	
	
	addi t0, a0, 0 #set t0->n1 this is our height
	
	
#this loop keeps asking for for a different input if the given input is less than or equal to 0
loop_body:

	blt zero, t0, loop_exit #this breaks if zero is less than the input(t0)
	#execute loop body only if t0 < 0
	#else exit loop
	
	print_str(outputMsg)
	print_str(newline)
	#print prompt1 string on console
	print_str(prompt1)
	
	li a7, 5
	ecall
	
	addi t0, a0, 0
	
	b loop_body
	
loop_exit:



#initial values of loop

	li t1, 0 #row counter and tell us how many dollar signs in the row
	li t2, 1 #tells us the number at the end of the row. after each iteration, plus 2
	li t3, 1 #this is the one for the if statement to break loop1
	li t4, 0 #this is the counter 
	
	
	
	




loop1_body:
	bge t1, t0, loop1_exit #this loop breaks if t1(row counter) is greater than t0(input row height)
	beq t0, t3, loop3_body #goes to loop3 if t0 is equal to 1
	
	b loop2_body
	


loop1_update:
	addi t1, t1, 1 #moves onto the next row
	addi t2, t2, 2 #plus two for the number at the back and to be printed the next row
	li t4, 0 #sets the counter back to zero
	
	b loop1_body
	
loop1_exit:
	exit



#this is the inner loop of loop1
loop2_body:
	ble t1, t4 loop2_exit
	print_str(both)
	addi t4 t4, 1
	b loop2_body
	
loop2_exit:
	print_str(dollar)
	print_int(t2)
	print_str(newline)
	b loop1_update
	






#this loop is used if the height of rows inputed is 1
loop3_body:
	print_str(dollar)
	print_int(t2)

loop3_exit:
	exit





	
	
	
	
	
	