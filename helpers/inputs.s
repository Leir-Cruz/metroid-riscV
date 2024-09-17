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


INPUT.W: la t0, SAMUS_POSITION
		la t1, SAMUS_LAST_POSITION
		lw t2, 4(t0)
		sw t2, 4(t1)

		lw t1, 4(t0)
		addi t1, t1, -32
		sw t1, 4(t0)
		
		ret

INPUT.S: la t0, SAMUS_POSITION
		la t1, SAMUS_LAST_POSITION
		lw t2, 4(t0)
		sw t2, 4(t1)

		lw t1, 4(t0)
		addi t1, t1, 16
		sw t1, 4(t0)
		
		ret

INPUT.A: la t0, MAP_POSITION
		lw t1, 0(t0)
		addi t1, t1, -20
		sw t1, 0(t0)
		
		ret

INPUT.D: la t0, MAP_POSITION
		lw t1, 0(t0)
		addi t1, t1, 20
		sw t1, 0(t0)
		
		ret


END_INPUT:	la t0, SAMUS_MOVE_X
		sw zero, 0(t0)		# zera moveX, moveY, jump e roll (cada um eh um byte, usamos word para zerar os 4 ja que est�o um em seguida do outro na memoria)
		ret			# 
				
