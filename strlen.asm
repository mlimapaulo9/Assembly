#counts length of a string
.data
  string: .asciiz "Ola!"
  mensagem: .asciiz "O tamanho da String é: "
.text
main:
        la $a0, string          # carrega o endereço da string
        jal strlen              # chama a função

        #copia resultado para $s1
      	add $s1, $zero, $v0
      	
      	#imprime o resultado
      	la   $a0, mensagem   # endereco de "msg_result" em $a0
      	li   $v0, 4          # especiica o servico de impressao de string
      	syscall              # faz a chamada de system para imprimir a string
  
      	add  $a0, $s1, $zero  # resultado final
      	li   $v0, 1           # especifica o servido de impressao de inteiros
      	syscall               # imprime o valor de resultado
        
        # Terminando o programa
      	li   $v0, 10          
      	syscall               


strlen:
  addi 	$sp, $sp, -4		#ajusta pilha para mais 1 item
  sw	$a0, 0($sp)		#salva $s0
  
  li $t0, 0                     # inicializa t0 com 
  loop:
    lb $t1, 0($a0)        # carrega o próximo caracter em t1
    beqz $t1, exit        # confere se o caracter é nulo
    addi $a0, $a0, 1      # incrementa o próximo caracter
    addi $t0, $t0, 1      # incrementa o contador
    j loop                # returna para o início do loop
  exit:
    add $v0, $t0, $zero
    lw	 $a0, 0($sp)		# y[i] == 0; fim da string; restura $s0
    addi $sp, $sp, 4		#retira 1 word da pilha
    jr $ra
