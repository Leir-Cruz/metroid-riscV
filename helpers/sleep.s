###################### PROCEDIMENTO PRINT ######################
#	ARGUMENTOS:						
#		a0 = tempo solicitado para sleep em ms
#################################################################
SLEEP:
        csrr t0 , time # le o tempo do sistema
        add t1 , t0 , a0 # soma com o tempo solicitado
SLEEP_LOOP:
        csrr t0 , time # le o tempo do sistema
        sltu t2 , t0 , t1
        bne t2 , zero , SLEEP_LOOP # t0 <t1 ?
        ret
