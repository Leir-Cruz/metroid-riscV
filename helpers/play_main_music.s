.data
MUSIC_NUM_NOTAS:        .word 19
MUSIC_NOTAS:		.word 60,4740,64,3555,62,296,64,296,62,296,59,296,60,4740,64,3555,62,296,64,296,62,296,59,296,60,4740,64,3555,62,296,64,296,62,296,59,296,60,9480

.text
###################### PROCEDIMENTO MUSIC ######################
#	ARGUMENTOS:						
#		a0 = endereco status
#		a1 = instrumento			
#		a2 = volume					
#################################################################
MUSIC_SETUP:	la s0, MUSIC_NUM_NOTAS		# define o endereço do número de notas
		lw s1, 0(s0)		# le o numero de notas
		la s0, MUSIC_NOTAS		# define o endereço das notas
		li t0, 0			# zera o contador de notas
		li a2, 7		# define o instrumento
		li a3, 127		# define o volume
		
		ret

MUSIC_PLAY_NOTES:	beq t0,s1, END		# contador chegou no final? então  vá para FIM
		lw a0, 0(s0)		# le o valor da nota
		lw a1, 4(s0)		# le a duracao da nota
		li a7, 31		# define a chamada de syscall
		ecall			# toca a nota
		mv a0, a1		# passa a duração da nota para a pausa
		li a7, 32		# define a chamada de syscal 
		ecall			# realiza uma pausa de a0 ms
		addi s0, s0, 8		# incrementa para o endereço da próxima nota
		addi t0, t0, 1		# incrementa o contador de notas
		j MUSIC_PLAY_NOTES	# volta ao loop
	
END:	li a0, 40		# define a nota
	li a1, 1500		# define a duração da nota em ms
	li a2, 7			# define o instrumento
	li a3, 127		# define o volume
	li a7, 33		# define o syscall
	ecall			# toca a nota
	ret


