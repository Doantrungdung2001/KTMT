#Laboratory Exercise 5, Home Assignment 3
.data
string: .space 50
Message1: .asciiz "Nhap xau:"
MessFalse: .asciiz "False"
MessTrue: .asciiz "True"
.text
main:
get_string: # TODO 
 li $v0, 54
 la $a0, Message1
 la $a1, string
 la $a2, 20
 syscall 
get_length: la $a0, string # a0 = Address(string[0])
 add $t0,$0,$0 # t0 = i = 1
  lb $t2, 0($a0)
 jal check_digit_first
check_char: add $t1, $a0, $t0 # t1 = a0 + t0 
 #= Address(string[0]+i) 
 lb $t2, 0($t1) # t2 = string[i]
 beq $t2,$zero,true # Is null char? 
 jal Check_condition
 addi $t0, $t0, 1 # t0=t0+1->i = i + 1
 j check_char
#Check First character
check_digit_first:
li  $t3, '/'
bltu   $t3,$t2, check2     # Jump if t2 >= '0'
jr $ra
check2:
li $t3,':'
bltu   $t2,$t3, false # Jump if t2 <='9'
jr $ra
####################
Check_condition:
check_character_up:
li  $t3, 'A'
bltu   $t2,$t3, check_digit     # Jump if t2 <'A'
li $t3,'Z'
bltu   $t3,$t2, check_insert # Jump if t2 >'Z'
jr $ra
check_digit:
li  $t3, '0'
bltu   $t2,$t3, false        # Jump if char < '0'
li $t3,'9'
bltu   $t3,$t2, false       # Jump if '9' < char
jr $ra
check_insert:
li  $t3, '_'
bltu   $t2,$t3, false        # Jump if char < '_'
li $t3,'_'
bltu   $t3,$t2, check_character_low       # Jump if '_' < char
jr $ra
check_character_low:
li  $t3, 'a'
bltu   $t2,$t3, false     # Jump if t2 <'a'
li $t3,'z'
bltu   $t3,$t2, false # Jump if t2 >'z'
jr $ra
false:
li $v0,4
la $a0,MessFalse
syscall
j end
true:
li $v0,4
la $a0,MessTrue
syscall
j end
end:
