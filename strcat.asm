.data
str1:	.asciiz "123"
str2:	.asciiz "456"
msg:	.asciiz "String: "
.text

	la	$a0, str1
	la	$a1, str2
	jal 	strcat
	
	#add $a0, $v0, $zero
	
	la	$a0, msg
	li	$v0, 4
	syscall
		
	li	$v0, 10
	syscall

strcat: addi $sp, $sp, -8 # Preservar $s0 e $s1
	sw $s0, 0($sp)    
	sw $s1, 4($sp) 
	
	add $s0, $a0, $zero   #Guardar end. str1 em $s0
	add $s1, $a1, $zero   # Guardar end. str2 em $s1
			 
conta:  lb $t0, 0($s0) # Carrega byte de str1
        addi $s0, $s0, 1 # Incrementa apontador de str1
	bne $t0, $zero, conta # Testa se chegou ao fim de str1
	addi $s0, $s0, -1 # Decrementa apontador str1 para escerver por cima de ‘\0’
	
copia:  lb $t1, 0($s1) # Carrega byte str2 em $t1
	sb $t1, 0($s0) # Carrega byte $t1 em str1
	addi $s0, $s0, 1 # Incrementa apontador str1
	addi $s1, $s1, 1 # incrementa apontador str2
	bne $t1, $zero, copia #Testa se chegou fim de str2
	
	add $v0, $s0, $zero
	
	lw $s1, 4($sp) # Recuperar $s0 e $s1
	lw $s0, 0($sp) 
	addi $sp, $sp, 8
	jr $ra
