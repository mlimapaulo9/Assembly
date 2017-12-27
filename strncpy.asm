############################################
#Funcao principal que chama a funcao ncopy
############################################
.data
	aviso_1: .asciiz "ANTES DE EXECUTAR STRCPY\n"
	aviso_2: .asciiz "\n\nDEPOIS DE EXECUTAR STRCPY\n"
	msg_1: .asciiz "String 1: "
	msg_2: .asciiz "String 2: "
	str_1: .asciiz "Ola_Mundo...\n"
	str_2: .asciiz 
	n: .word  3	# quantidade de caracteres a serem copiados	 
.text
	
	# carregando variaveis
	la  $s0, str_1        	# endereco de "str_1" em $t0      	
      	la  $s1, str_2        	# endereco de "str_2" em $t1
      	la  $t0, n     
        lw  $s2, 0($t0)
      	   	
	######################
	
	#imprime aviso 1
      	la   $a0, aviso_1 
      	li   $v0, 4          # especiica o servico de impressao de string
      	syscall              # faz a chamada de system para imprimir a string
	
	#imprime valor da string 1
      	la   $a0, msg_1 
      	li   $v0, 4          # especiica o servico de impressao de string
      	syscall              # faz a chamada de system para imprimir a string
  
  	la   $a0, str_1
      	li   $v0, 4           # especifica o servido de impressao a string
      	syscall               # imprime 
      	
      	
      	#imprime valor da string 2
      	la   $a0, msg_2 
      	li   $v0, 4          # especiica o servico de impressao de string
      	syscall              # faz a chamada de system para imprimir a string
  
      	la   $a0, str_2
      	li   $v0, 4           # especifica o servido de impressao a string
      	syscall               # imprime 
      	############################
      	
      	# parametros da funcao
      	add  $a0, $s1, $zero	# copiando endereco str_2
      	add  $a1, $s0, $zero	# copiando endereco srt_1
      	
      	#chama a funcao
      	jal strncpy
      	
     	
     	######################
     	#imprime aviso 2
      	la   $a0, aviso_2 
      	li   $v0, 4          # especiica o servico de impressao de string
      	syscall              # faz a chamada de system para imprimir a string
     	
	#imprime valor da string 1
      	la   $a0, msg_1 
      	li   $v0, 4          # especiica o servico de impressao de string
      	syscall              # faz a chamada de system para imprimir a string
  
  	la   $a0, str_1
      	li   $v0, 4           # especifica o servido de impressao a string
      	syscall               # imprime 
      	
      	
      	#imprime valor da string 2
      	la   $a0, msg_2 
      	li   $v0, 4          # especiica o servico de impressao de string
      	syscall              # faz a chamada de system para imprimir a string
  
      	la   $a0, str_2
      	li   $v0, 4           # especifica o servido de impressao a string
      	syscall               # imprime 
      	############################
     	
     	
     	
      	# Terminando o programa
      	li   $v0, 10          # system call for exit
      	syscall               # we are out of here.
      	
 


strncpy:

	addi 	$sp, $sp, -4		#ajusta pilha para mais 1 item
	sw	$s0, 0($sp)		#salva $s0
	add	$s0, $zero, $zero	# i = 0+0
L1:	add	$t1, $s0, $a1		#endereço de y[i] em $t1
	lb	$t2, 0($t1)		# $t2 = y[i]
	add	$t3, $s0, $a0		#endereço de x[i] em $t3
	sb	$t2, 0($t3)		# x[i] = y[i]
	beq	$t2, $zero, L2		#se y[i] == 0, vai para L2
	addi	$s0, $s0, 1		# i = i+1
	slt     $t4, $s0, $s2		# se s0 menor que s2, então t4 = 1, senão t4 = 0
	beq     $t4, $zero, L2		# se t4 = zero, saia do loop, pois já foi copiada a quantidade de caracter desejada
	j	L1			# vai para L1
L2: 	lw	$s0, 0($sp)		# y[i] == 0; fim da string; restura $s0
	addi	$sp, $sp, 4		#retira 1 word da pilha	
	jr	$ra			#retorna
