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
		lw t1, 4(t0)
		li t2, 40
		ble t1, t2, INPUT_RET
		addi t1, t1, -32
		sw t1, 4(t0)
		
		j INPUT_RET

INPUT.S: la t0, SAMUS_POSITION
		lw t1, 4(t0)
		li t2, 170
		bge t1, t2, INPUT_RET
		addi t1, t1, 16
		sw t1, 4(t0)
		
		j INPUT_RET

INPUT.A: la t0, MAP_POSITION
		lw t1, 0(t0)
		li t2, 120
		ble t1, t2, INPUT_RET
		addi t1, t1, -20
		sw t1, 0(t0)
		
		j INPUT_RET

INPUT.D: la t0, MAP_POSITION
		lw t1, 0(t0)
		li t2, 1640
		bge t1, t2, INPUT_RET
		addi t1, t1, 20
		sw t1, 0(t0)
		
		j INPUT_RET


END_INPUT:	la t0, SAMUS_JUMP
		sw zero, 0(t0)		# zera moveX, moveY, jump e roll (cada um eh um byte, usamos word para zerar os 4 ja que est�o um em seguida do outro na memoria)
		j INPUT_RET			
				
INPUT_RET: ret