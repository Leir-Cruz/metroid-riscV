.data
.include "sprites/mapametroidteste1.data"
.include "sprites/samusStandBy.data"
.include "sprites/samusWalkRight1.data"

SAMUS_POSITION: .word 140, 160
SAMUS_LAST_POSITION: .word 140, 160

SAMUS_MOVE_X:		.byte 0		# left: -1, right: 1
SAMUS_MOVE_Y:		.byte 0		# up: -1, down: 1
SAMUS_JUMP:		.byte 0		# jump: 1, nothing: 0
SAMUS_ROLLING:		.byte 0		# roll: 1, nothing: 0

IS_MAP_FIXED: .byte 1
MAP_POSITION: .word 500, 0


###################### REGISTRADORES GLOBAIS ######################
#	GLOBAIS:
#		s0 = guardar qual nota esta sendo tocada
#		s1 = qual nota esta
#		s2 = guardar o numero de notas
#		S3 = qual frame esta sendo exibido
#		s4 = se mapa está se movimentando
#		#s11 = indica tempo fim de renderização -> aux para fps
###################################################################

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
LOOP_SETUP: 
		li t0, 0xFF200604
		lw s3, 0(t0)

		jal MUSIC_SETUP     	
            	
GAME_LOOP: 
		csrr t0, 3073		# t0 = current time
		sub t0, t0, s11		# t0 = current time - last frame time
		li t1, 42			# 33ms entre cada frame (1000ms/24fps)
		bltu t0, t1, GAME_LOOP	# enquanto n tiver passado 33ms, repete

		la t1, IS_MAP_FIXED
		lb s4, 0(t1)
		#bnez s4, MAP_MOVIMENT

		jal INPUT
		#jal PHYSICS #only after input

		#bnez s4, RENDER_DINAMIC_MAP

		j RENDER_MAP

#RENDER_DINAMIC_MAP

RENDER_MAP:
		la t1, MAP_POSITION
		la a0, gamemapteste1
		mv a1, zero
		mv a2, zero
		mv a3, s3
		lw a4, 0(t1)
		lw a5, 4(t1)
		jal PRINT

RENDER_SAMUS:
		la t1, SAMUS_POSITION
		la a0, samusStandBy
		lw a1, 0(t1)
		lw a2, 4(t1)
		mv a3, s3
		mv a4, zero
		mv a5, zero
		jal PRINT	
		
#### indica quando frame termina rendereizacao e troca de frame para poder renderizar #######
		csrr s11, 3073
		li	t0, 0xFF200604
		sw	s3, 0(t0)
		xori s3, s3, 1

		j GAME_LOOP


EXIT:		li a0,100000
		li		a7, 10
		ecall
		


.include "helpers/play_main_music.s"
.include "helpers/menu.s"
.include "helpers/inputs.s"
.include "helpers/print.s"
.include "constants.s"
	
	
