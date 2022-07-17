.data
 s1: 			.space 	50
 s2: 			.space 	50
 count_s1: 		.word	0:26		# Counts the number of character in string  s1
 count_s2: 		.word 	0:26		# Counts the number of character in string  s2
 count_common_char_freq:.word	0:26		# store the common character
 Message1: 		.asciiz "commonCharacterCount(s1, s2) = "
 Message2: 		.asciiz "Enter the 1st string"
 Message3: 		.asciiz "Enter the 2nd string"
 newLine: 		.asciiz "\n"
 slash: 			.asciiz " \" "
 errorMessage:		.asciiz	"String length must be less than 50"
 
.text
main:
input1:
	li 	$v0,54				# show message to enter string from keyboard
	la 	$a0, Message2
	la 	$a1, s1
	li 	$a2, 50				# max strLen : 50
	syscall 		
check1:
 	beq 	$a1, 0, input2
 	beq	$a1, -2, exit
 	beq	$a1, -3, back1
 	beq	$a1, -4, showErrorMess1
showErrorMess1:
 	li 	$v0, 55				#show error message
	la 	$a0, errorMessage				
	syscall				
back1:
	j 	input1				# back to input1
input2:
	li 	$v0,54				# show message to enter string from keyboard
	la 	$a0, Message3
	la 	$a1, s2
	li 	$a2, 50				# max strLen : 50
	syscall 
check2:
 	beq 	$a1, 0, begin
 	beq	$a1, -2, exit
 	beq	$a1, -3, back2
 	beq	$a1, -4, showErrorMess2
showErrorMess2:
 	li 	$v0, 55				#show error message
	la 	$a0, errorMessage				
	syscall				
back2:
	j 	input2				# back to input2
	
begin:
get_lenth:
	la 	$a0, s1 			# a0 = address of s1
	jal	strLength 			# jump to strLength func
	add	$s0, $zero, $s6			# s0 = strLen(s1)
	
	la 	$a0, s2 			# a0 = address of s2
	jal	strLength 			# jump to strLength func
	add	$s1, $zero, $s6			# s1 = strLen(s2)
	
	li 	$s2, 0					# index i of s1
 	li 	$s3,0					# index j of s2
count_char_s1:
	slt 	$s4, $s2, $s0				# i < m ?
	beq 	$s4, $zero, end_count_char_s1		# if i < m => false => end_count
	lb 	$s5, s1($s2)				# $s5 = s1[i]
	sub 	$s5, $s5, 97				# $s5 = s1[i] - 'a'
	add 	$s5, $s5, $s5
	add 	$s5, $s5, $s5				# $s5 = 4*(s1[i] -'a')
	lw 	$s6, count_s1($s5)			# $s6 = count_s1[s1[i]-'a']
	addi 	$s6, $s6, 1				# $s6++
	sw 	$s6, count_s1($s5)			# count_s1[s1[i]-'a'] = $s6
	addi 	$s2, $s2, 1				# i = i + 1 
	j 	count_char_s1
end_count_char_s1:
count_char_s2:
	slt 	$s4, $s3, $s1				# i < n	?
	beq 	$s4, $zero, end_count_char_s2		# if j < n => false => end_count
	lb 	$s5, s2($s3)				# $s5 = s2[j]
	sub 	$s5, $s5, 97				# $s5 = s2[j] - 'a'
	add 	$s5, $s5, $s5
	add 	$s5, $s5, $s5				# $s5 = 4*(s2[j] -'a')
	lw 	$s6, count_s2($s5)				# $s6 = count_s2[s2[j]-'a']
	addi 	$s6, $s6, 1				# $s6++
	sw 	$s6, count_s2($s5)				# count_s2[s2[i]-'a'] = $s6
	addi 	$s3, $s3, 1				# j = j + 1
	j 	count_char_s2
end_count_char_s2:
	li 	$t0, 26					# n = number member of count_common_char_freq
	li 	$t1, 0					# index i of array count_common_char_freq
count_common_char:
	slt 	$t2, $t1, $t0				# i< n ?
	beq 	$t2, $zero, end_count_common_char	# if false => end_count
	add 	$t3, $t1, $t1
	add 	$t3, $t3, $t3				# $t3 = 4*i
	lw 	$t4, count_s1($t3)			# $s4 = count_s1[i]
	lw 	$t5, count_s2($t3)			# $s5 = count_s2[i]
	slt 	$t6, $t4, $t5				# count_s1[i] < count_s2[i] ?
	bne 	$t6, $zero, add_count_s1			
add_count_s2:
	add 	$t7, $t7, $t5				# if count_s1[i] < count_s2[i] false, commonCharacterCount += count_s2[i]
	sw 	$t5,  count_common_char_freq($t3)
	addi 	$t1, $t1, 1				# i++
	j 	count_common_char
add_count_s1:
	add 	$t7, $t7, $t4				# if count_s1[i] < count_s2[i] true, commonCharacterCount += count_s1[i]
	sw 	$t4,  count_common_char_freq($t3)
	addi 	$t1, $t1, 1				# i++
	j 	count_common_char
end_count_common_char:
print:
	li 	$v0, 4					# print  commonCharacterCount(s1, s2)
	la 	$a0, Message1
	syscall
	
	li 	$v0, 1					
	li 	$a0, 0
	add 	$a0, $a0, $t7
	syscall 
 	
 	li 	$t1, 0
 	
print_character:
 	slt 	$t2, $t1, $t0				# Print the number appear of the same character
	beq 	$t2, $zero, end_print_character
	add 	$t3, $t1, $t1
	add 	$t3, $t3, $t3
 	lw 	$t4, count_common_char_freq($t3)
 	beq 	$t4, $zero, add_index
 	li 	$v0,4
 	la 	$a0, newLine
 	syscall
 	
 	li 	$v0,1
 	li 	$a0, 0
	add 	$a0, $a0, $t4
	syscall
	
	li 	$v0, 4
	la 	$a0, slash 
	syscall
	
	li	$v0, 11
        addi 	$a0, $t1,97
        syscall  
add_index:
	addi 	$t1, $t1, 1
	j	print_character
end_print_character:

exit:	
	li	$v0, 10
	syscall
	
#---------------------------------------------------------------------------
# @function:	strLength
# param[in]:	a0	address of string
# return:	s6	strLen of input
#---------------------------------------------------------------------------
strLength:
	add $s6, $zero, $zero  			# set s6 = i = 0
L1:
	add $s4, $s6, $a0  			# s4 = address(a)
	lb $s5, 0($s4)  			# s5 =  a[i]
	beq $s5, 10, end_strLength 		# if (t2 == "\n") thi end L1
	addi $s6, $s6, 1			# i++
	j L1					# L1 back
end_strLength:				
	jr $ra 	
