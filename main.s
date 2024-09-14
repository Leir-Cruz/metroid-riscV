.data
.include "sprites/mapametroidteste1.data"
.include "sprites/samusStandBy.data"
SAMUS_MOVE_X:		.byte 0		# left: -1, right: 1
SAMUS_MOVE_Y:		.byte 0		# up: -1, down: 1
SAMUS_JUMP:		.byte 0		# jump: 1, nothing: 0
SAMUS_ROLLING:		.byte 0		# roll: 1, nothing: 0


###################### REGISTRADORES GLOBAIS ######################
#	GLOBAIS:
#		s0 = guardar qual nota esta sendo tocada
#		s1 = qual nota esta
#		s2 = guardar o numero de notas
#		S3 = qual frame esta sendo exibido
#################################################################

.text
GAME_START:	la a0, title2   #MENU INICIAL DO JOGO
		li a1, 0
		li a2, 0
		li a3, 0
		li a4, 0
		li a5, 0
            	jal PRINT
            	li a0 , 1000
				#call SLEEP
				li a7 , 32
				ecall
GAME_SETUP: 
		#xori s3, s3, 1  #mover essa parte para o loop
		la a0, gamemapteste1
		mv a1, zero
		mv a2, zero
		li a3, 0 
		li a4, 500
		mv a5, zero
		jal PRINT
		li a3, 1
		jal PRINT #termino de imprimir O MAPA
		la a0, samusStandBy
		li a1, 140
		li a2, 160
		mv a3, zero
		mv a4, zero
		mv a5, zero
		jal PRINT
		jal MUSIC_SETUP     	
            	
GAME_LOOP: 	xori s3, s3, 1
		jal MUSIC_PLAY
		j GAME_LOOP
		j EXIT
		



EXIT:		li a0,100000
		li		a7, 10
		ecall
		


.include "helpers/play_main_music.s"
.include "helpers/menu.s"
.include "helpers/inputs.s"
.include "helpers/print.s"
.include  "helpers/sleep.s"
.include "helpers/update_print.s"
.include "constants.s"
	
	
