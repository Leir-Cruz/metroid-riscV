.data
.include "sprites/mapametroidteste1.data"
.include "sprites/samusStandBy.data"
.include "sprites/samusWalkRight1.data"
.include "sprites/samusWalkLeft1.data"
.include "sprites/item1Teleport.data"
.include "sprites/item2SuperGun.data"
.include "sprites/samusLife3.data"
.include "sprites/samusLife2.data"
.include "sprites/samusLife1.data"
.include "sprites/samusLife0.data"

SAMUS_POSITION: .word 140, 160
SAMUS_LIFE_POSITION: .word 20, 20
ITEM1_TELEPORT_POSITION: .word 1100, 190
ITEM2_SUPERGUN_POSITION: .word 1470, 115


SAMUS_JUMP:		.byte 0		# jump: 1, nothing: 0
SAMUS_ROLLING:		.byte 0		# roll: 1, nothing: 0
IS_MAP_FIXED: .byte 1
SAMUS_DIRECTION: .byte 0 #left: -1, stand: 0, right: 1

SAMUS_LIFE:	.word 3
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

		jal INPUT
		#jal PHYSICS #only after input

		bnez s4, RENDER_MAP

RENDER_DINAMIC_MAP:
		# calcular a posição do mapa com base na posição da samus
		# samus deve estar sempre no meio do mapa
		la t1, SAMUS_POSITION
		lw t2, 0(t1) # x da samus: t1

		#encontrar a diferenca da primeira posicao da samus para a atual e guardar em t5
		addi t3, t2, -140

		la t4, MAP_POSITION
		lw t5, 0(t4)

		add t6, t5, t3
		sw t6, 0(t4) #calculo do X


RENDER_MAP:
		la t1, MAP_POSITION
		la a0, gamemapteste1
		mv a1, zero
		mv a2, zero
		mv a3, s3
		lw a4, 0(t1)
		lw a5, 4(t1)
		jal PRINT


RENDER_SAMUS_LIFE:
		la t1, SAMUS_LIFE
		lw t1, 0(t1)
		li t2, 1 #comparador

		beqz t1, RENDER_SAMUS_LIFE0

		beq t1, t2, RENDER_SAMUS_LIFE1

		addi t2, t2, 1
		beq t1, t2, RENDER_SAMUS_LIFE2

		addi t2, t2, 1
		beq t1, t2, RENDER_SAMUS_LIFE3

RENDER_SAMUS:
		la t1, SAMUS_POSITION
		la a0, samusStandBy
		lw a1, 0(t1)
		lw a2, 4(t1)
		mv a3, s3
		mv a4, zero
		mv a5, zero
		jal PRINT

RENDER_ITEM1_TELEPORT:
		###### para renderizar o mapa, precisamos saber se a região 1100 em x está aparecendo na tela
 		la t0, ITEM1_TELEPORT_POSITION
		lw t1, 0(t0)         # x do item (1100) em t1

		# pega a posicao do mapa atual
		la t2, MAP_POSITION
		lw t3, 0(t2)         # x do mapa

		# Ajustar a posição do item para a tela (calculo para ver se imprime o item)
		sub t1, t1, t3     # t1 agora é a posição x do item na tela (1100 - posição do mapa)

		# Verificar se o item está dentro da tela
		li t4, 320           # largura da tela em t4
		blt t1, zero, RENDER_ITEM2_SUPERGUN # se x < 0, sair (não desenhar)
		bge t1, t4, RENDER_ITEM2_SUPERGUN # se x >= 320, sair (não desenhar)

		# Renderizar item
		la a0, item1Teleport
		mv a1, t1            # nova posição x ajustada
		lw a2, 4(t0)            # y do item (fixo)
		mv a3, s3
		mv a4, zero       
		mv a5, zero        
		jal PRINT


RENDER_ITEM2_SUPERGUN:
		###### para renderizar o mapa, precisamos saber se a região 1100 em x está aparecendo na tela
 		la t0, ITEM2_SUPERGUN_POSITION
		lw t1, 0(t0)         # x do item (1100) em t1

		# pega a posicao do mapa atual
		la t2, MAP_POSITION
		lw t3, 0(t2)         # x do mapa

		# Ajustar a posição do item para a tela (calculo para ver se imprime o item)
		sub t1, t1, t3     # t1 agora é a posição x do item na tela (1100 - posição do mapa)

		# Verificar se o item está dentro da tela
		li t4, 320           # largura da tela em t4
		blt t1, zero, FINISH_PRINTING # se x < 0, sair (não desenhar)
		bge t1, t4, FINISH_PRINTING # se x >= 320, sair (não desenhar)

		# Renderizar item
		la a0, item2SuperGun
		mv a1, t1            # nova posição x ajustada
		lw a2, 4(t0)            # y do item (fixo)
		mv a3, s3
		mv a4, zero       
		mv a5, zero        
		jal PRINT
		
FINISH_PRINTING:
		csrr s11, 3073
		li	t0, 0xFF200604
		sw	s3, 0(t0)
		xori s3, s3, 1

		j GAME_LOOP


EXIT:	li a0,100000
		li a7, 10
		ecall
		


.include "helpers/play_main_music.s"
.include "helpers/menu.s"
.include "helpers/inputs.s"
.include "helpers/print.s"
.include "helpers/utils.s"
.include "constants.s"
	
	
