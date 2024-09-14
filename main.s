.data
.include "sprites/mapametroidteste1.data"
SAMUS_MOVE_X:		.byte 0		# left: -1, right: 1
SAMUS_MOVE_Y:		.byte 0		# up: -1, down: 1
SAMUS_JUMP:		.byte 0		# jump: 1, nothing: 0
SAMUS_ROLLING:		.byte 0		# roll: 1, nothing: 0


###################### REGISTRADORES GLOBAIS ######################
#	GLOBAIS:
#		s0 = guardar qual nota está sendo tocada
#		s1 = qual nota está
#		s2 = guardar o número de notas
#		S3 = qual frame está sendo exibido
#################################################################

.text
GAME_START:	la a0, title2   #MENU INICIAL DO JOGO
		li a1, 0
		li a2, 0
		li a3, 0
		li a4, 0
		li a5, 0
            	jal PRINT
            	li a0,1000		
	  	li a7,32
	 	ecall
AFT_CLOSE_MENU: jal MUSIC_SETUP
            	
            	
GAME_LOOP: 	jal MUSIC_PLAY


		xori s3, s3, 1
		
            	la a0, gamemapteste1
		mv a1, zero
		mv a2, zero
		mv a3, s3
		li a4, 500
		mv a5, zero
            	jal PRINT_BACKGROUND
            	j GAME_LOOP
		j EXIT
		



EXIT:		li a0,100000
		li		a7, 10
		ecall
		


.include "helpers/play_main_music.s"
.include "helpers/menu.s"
.include "helpers/inputs.s"
.include "helpers/print.s"
.include "constants.s"
	
	
