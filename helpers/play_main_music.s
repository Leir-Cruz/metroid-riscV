.data
CURRENT_NOTE_INDEX:	.word 0
MUSIC_NUM_NOTAS:        .word 19
MUSIC_NOTAS:		.word 60,4740,64,3555,62,296,64,296,62,296,59,296,60,4740,64,3555,62,296,64,296,62,296,59,296,60,4740,64,3555,62,296,64,296,62,296,59,296,60,9480
.text
###################### PROCEDIMENTO MUSIC ######################
#	ARGUMENTOS:		
#		a0 = nota
#		a1 = duracao nota				
#		a2 = instrumento			
#		a3 = volume			
#		s0 = guardar qual nota está sendo tocada
#		s1 = qual nota está
#		s2 = guardar o número de notas
#################################################################


#### TODO FIX: LOOP



MUSIC_SETUP:	la s1, CURRENT_NOTE_INDEX	# define index
		la s2, MUSIC_NUM_NOTAS		# define o numero de notas
		la s0, MUSIC_NOTAS		# define o endereço das notas
		mv t0 , zero # zera t1
		mv t1 , zero # zera t2
		ret


MUSIC_PLAY:	lw t0, 0(s1)			#load index
		lw t1, 0(s2)			#carrega número de notas
		beq t0,t1, NOTE_END		# reinicia
		li a2, 7			# define o instrumento
		li a3, 127			# define o volume
		lw a0, 0(s0)			# le o valor da nota
		lw a1, 4(s0)			# le a duracao da nota
		li a7, 31			# define a chamada de syscall
		ecall				# toca a nota

		mv a0, a1			# passa a duração da nota para a pausa
		li a7, 32			# define a chamada de syscal 
		ecall				# realiza uma pausa de a0 ms
		
		
		addi s0, s0, 8			# incrementa para o endereço da próxima nota
		addi t0, t0, 1			# incrementa index 
		sw t0, 0(s1)
		
		
NOTE_END:	ret



