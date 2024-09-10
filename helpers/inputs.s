FIRST_INPUT: 	li t1,0xFF200000
	lw t0,0(t1)			# Le bit de Controle Teclado
	andi t0,t0, 1		
   	beqz t0, END_FIRST_INPUT  	   	# Se não há tecla pressionada então vai para END__INPUT
  	lw t2,4(t1)  			# le o valor da tecla tecla
  	
	b AFT_CLOSE_MENU		# se a tecla pressionada, fecha o menu



END_FIRST_INPUT: ret


END_INPUT:	la t0, SAMUS_MOVE_X
		sw zero, 0(t0)		# zera moveX, moveY, jump e roll (cada um eh um byte, usamos word para zerar os 4 ja que estão um em seguida do outro na memoria)
		ret			# 
				
