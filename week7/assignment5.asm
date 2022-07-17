.text
main:
       li $s0, 13 
       li $s1, 8
       li $s2, 9
       li $s3, -17
       li $s4, 31
       li $s5, 33
       li $s6, -27
       li $s7,5
       
       li $t1,1
       li $t2,1
       li $t3,1
       jal init
       nop
       li $t4,9
       sub $a0, $t4, $t2	
       sub $a1, $t4, $t3
       j end
       nop
endmain:
init:
       add $v0, $s7, $zero
       add $v1, $s7, $zero
push:
       addi $sp, $sp, -32
       sw $s0,28 ($sp)
       sw $s1,24 ($sp)
       sw $s2,20 ($sp)
       sw $s3,16 ($sp)
       sw $s4,12 ($sp)
       sw $s5,8 ($sp)
       sw $s6,4 ($sp)
       sw $s7,0 ($sp)
pop:
	addi $sp,$sp,4
	lw $a1,0 ($sp)
	addi $t1,$t1,1
	sub $t0, $a1, $v0
	bltz $t0, parel
	nop
	add $v0, $a1, $zero
	add $t2, $t1, $zero
parel:
	sub $t0, $a1, $v1
	bgtz $t0, pare2
	nop
	add $v1, $a1, $zero
	add $t3, $t1, $zero
pare2:
	bne $a1, $s0, pop
	nop
done:
	jr $ra
end: