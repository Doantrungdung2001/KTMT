#Mini Project
#$s0 = freq1 ,$s1 = freq2 ,$v0 = min,$v1= count,$t0 = i,$s3 =strlen(s1),$s4= strlen(s2)
.data
s1: .asciiz "aabcc"
s2: .asciiz "adcaa"
freq1: .word 0:256 # int freq1[256]
freq2: .word 0:256 # int freq2[256]
.text
#Tim do dai cua s1 -- strlen(s1).
get_length_s1:
	la $a0 ,s1 #$a0 = Address(s1[0])
	xor $s3 ,$zero ,$zero # s3=length = 0
	xor $t0, $zero, $zero # t0 = i = 0
check_char_s1:
	add $t1 ,$a0,$t0 # t1 = a0+t0 = Address(s1[0] + i)
	lb $t2 ,0($t1) # $t2 = s1[i]
	beq $t2 ,$zero,end_of_str_s1 # Is null char?
	addi $s3,$s3, 1 # s3 = s3+1 = length =  length+1
	addi $t0 ,$t0 ,1 # t0 = t0+1 = i+1
	j check_char_s1
end_of_str_s1:
end_of_get_length_s1:

#Tim do dai cua s2 -- strlen(s2).
get_length_s2:
	la $a0 ,s2 #$a0 = Address(s2[0])
	xor $s4 ,$zero ,$zero # s4=length = 0
	xor $t0, $zero, $zero # t0 = i = 0
check_char_s2:
	add $t1 ,$a0,$t0 # t1 = a0+t0 = Address(s2[0] + i)
	lb $t2 ,0($t1) # $t2 = s1[i]
	beq $t2 ,$zero,end_of_str_s2 # Is null char?
	addi $s4,$s4, 1 # s4 = s4+1 = >length =  length+1
	addi $t0 ,$t0 ,1 # t0 = t0+1 = i+1
	j check_char_s2
end_of_str_s2:
end_of_get_length_s2:

#Tim GTNN cua hai so nguyen :min(int a,int b)
min_a_b:
	addi $sp,$sp,-16 #tao  4 vi tri o Stack
	sw $t0 ,12($sp) # Cat noi dung vao t0
	sw $t1 ,8($sp) # Cat noi dung vao t1
	sw $t2 ,4($sp) # Cat noi dung vao t2
	sw $s5 ,0($sp) # Cat noi dung vao s5
	add $s5 ,$zero,$zero # s5 = min = 0
	addi $t0 ,$zero,6 # a
	addi $t1 ,$zero,5# b
	slt $t3,$t0,$t1#  a <b thi t3 =1 nguoc lai t3 = 0
	bne $t3 ,$zero,check_min # t3 !=0 jump den check_min:
	add $s5,$zero,$t1# s5 =t1
	add $v0 ,$s5,$zero #v0 = s5
	lw $s5,0($sp) # Khoi phuc s5
	lw $t2,4($sp) # Khoi phuc t2
	lw $t1,8($sp) # Khoi phuc t1
	lw $t0,12($sp) # Khoi phuc t0	#tro ve noi da goi
check_min:
	add $s5,$zero,$t0
	add $v0 ,$s5,$zero
	j exit	

exit:
CommonCharacterCount:
	la $a0 ,freq1 # $a0 = Address(freq1[0])
	la $a1 ,s1 #$a1 = Address(s1[0])
	xor $t0, $zero, $zero # t0 = i = 0
for:
	xor $t4, $zero, $zero # t0 = count = 0
	slt $t1,$t0,$s3 #i > strlen(s1) 
	beq $t1,$0,done # thi done
	add $t1 ,$a1,$t0 # t1 = a1+t0 = Address(s1[0] + i)
	lb $t2 ,0($t1) # $t2 = s1[i]
find_char:
	addi $t6,$t6,1 # j=1
	slt $t1,$t0,$s3 #i > strlen(s1) 
	beq $t1,$0,for # thi for
	add $t1 ,$a1,$t6 # t1 = a1+t6 = Address(s1[0] + j)
	lb $t3,0($t1)# $t3 = s1[j]
	bne $t2,$t3 ,find_char # Neu s[j]
	addi $t4,$t4,1
	j find_char
end_find_char:
	sw $t4 ,freq1($t2) #freq1[s[i]] = 0
	addi $t0,$t0,1# i=i+1
	j for
done:
	
	
	
	
