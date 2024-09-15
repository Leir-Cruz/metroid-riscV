.text
###################### PROCEDIMENTO INPUT ######################
#	AUXILIARES:						
#		t0 = le o bit de controle no teclado & posteriormente guarda qual tecla foi pressionado no teclado
#		t1 = aponta o endereço da leitura do teclado
#################################################################
INPUT: 	li t1,0xFF200000
		lw t0,0(t1)			# Le bit de Controle Teclado
		andi t0,t0, 1		
   		beqz t0, END_INPUT  	   	# Se n�o h� tecla pressionada ent�o vai para END__INPUT
  		lw t0,4(t1)  			# le o valor da tecla tecla


		# movimentacao samus
		li		t1, 'w'
  		beq		t0, t1, INPUT.W
  		li		t1, 'a'
  		beq		t0, t1, INPUT.A
  		li		t1, 's'
  		beq		t0, t1, INPUT.S
  		li		t1, 'd'
		beq		t0, t1, INPUT.D


INPUT.W:	la		t0, SAMUS_MOVE_Y
		li		t1, -1
		sb		t1, 0(t0)		# moveY = -1 (cima)
		
		la		t0, SAMUS_JUMP
		li		t1, 1
		sb		t1, 0(t0)		# input jump = 1
		
		ret

INPUT.A:	la		t0, SAMUS_MOVE_X
		li		t1, -1
		sb		t1, 0(t0)		# moveX = -1 (esquerda)
		
		#la		t0, CHAR_DIR
		#li		t1, 1
		#sb		t1, 0(t0)		# charDir = 1 (esquerda)
		
		ret

INPUT.S:	la		t0, SAMUS_MOVE_Y
		li		t1, 1
		sb		t1, 0(t0)		# moveY = 1 (baixo)
		ret

INPUT.D:	la		t0, SAMUS_MOVE_X
		li		t1, 1
		sb		t1, 0(t0)		# moveX = 1 (direita)
		
		#la		t0, CHAR_DIR
		#sb		zero, 0(t0)		# charDir = 0 (direita)
		
		ret


END_INPUT:	la t0, SAMUS_MOVE_X
		sw zero, 0(t0)		# zera moveX, moveY, jump e roll (cada um eh um byte, usamos word para zerar os 4 ja que est�o um em seguida do outro na memoria)
		ret			# 
				
