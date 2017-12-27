.data
	msg1:.asciiz "Insira uma palavra de no máximo 20 caractéres: "
	msg2:.asciiz "\nAs palavras são diferentes!"
	msg3:.asciiz "\nAs palavras são iguais!"
	str1: .space 20
	str2: .space 20
.text

	#exibe a mensagem de inserção da palavra
	addi $v0, $zero, 4
	la $a0,msg1
	syscall
	
	#armazerna a primeira palavra digitada em a0
	li $v0,8
	la $a0,str1
	addi $a1,$zero,20
	syscall
	
	#exibe a mensagem de inserção da palavra novamente
	li $v0,4
	la $a0,msg1
	syscall
	
	#armazerna a segunda palavra digitada em a0
	li $v0,8
	la $a0,str2
	addi $a1,$zero,20
	syscall

	la $a0, str1 #armazenando o valor de str1 em a0
	la $a1, str2 #armazenando o valor de str2 em a1
	jal strcmp   #chama a funcao strcmp

	beq $v0,$zero,ok #check result
	li $v0, 4 	 # caso as palavras sejam diferentes
	la $a0,msg2	 # chama a string que avisa que as palavraas são diferentes
	syscall
	j exit
	
ok:
	li $v0,4
	la $a0,msg3 # chama a string que avisa que as palavraas são iguais
	syscall
	
exit:
	li $v0,10
	syscall

strcmp:
	addi $sp, $sp, -8
	sw $a0, 4($sp)
	sw $a1, 0($sp)
	
	add $t0, $zero, $zero #seta t0 com 0
	add $t1, $zero, $a0   #seta t1 com o endereço de a0
	add $t2, $zero, $a1   #seta t2 com o endereço de a1
	loop:
		lb $t3($t1) #carrega um byte de cada letra da palavra 1
		lb $t4($t2) #carrega um byte de cada letra da palavra 2
		beqz $t3, L1 # confere se algum caracter é nulo, se sim entra em L1
		beqz $t4, L2 # confere se algum caracter é nulo, se sim entra em L2
		slt $t5, $t3, $t4 #compara os dois bytes
		bnez $t5, L2 # confere se algum caracter é nulo, se sim entra em L2
		addi $t1, $t1, 1 #incrementa o próximo caracter da palavra 1
		addi $t2,$t2,1   #incrementa o próximo caracter da palavra 2
		j loop #retora para o inicio do loop

L2: 
	addi $v0, $zero, 1 #seta o valor do retorno como 1
	j fimfuncao
L1:
	bnez $t4, L2
	add $v0, $zero, $zero #seta o valor do retorno como 0

fimfuncao:
	lw $a1, 0($sp)
	lw $a0, 4($sp)
	addi $sp, $sp, 8
	jr $ra
