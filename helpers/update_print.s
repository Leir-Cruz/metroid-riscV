UPDATE_PRINT :
        # uso da Print -> ra , a0 e a3 devem ser salvos
        addi sp , sp , -12
        sw ra , 0( sp)
        sw a0 , 4( sp)
        sw a3 , 8( sp)
        addi a3 , a3 , 1
        li t0 , 3
        remu a3 , a3 , t0 # estado atual = estado anterior + 1 ( mod 3)
        sw a3 , 8( a0) # atualiza na label
        # decide a sprite a ser impressa de acordo com o estado
        beqz a3 , samus0 # estado = 0?
        li t0 , 1
        beq a3 , t0 , samus1 # estado = 1?
        la a0 , samusStandBy # estado = 2
END_UPDATE_PRINT :
        xori s0 , s0 , 1
        mv a3 , s0 # a3 <- frame oposto ao atual
        call PRINT # impressao da pose no outro frame
        li t0 , 0xFF200604
        sw s0 , 0( t0) # exibe o outro frame
        lw ra , 0( sp)
        lw a0 , 4( sp)
        lw a3 , 8( sp)
        addi sp , sp , 12

ret # retorno
        samus0: la a0 , samusStandBy # mudar para outro estado da samus
        j END_UPDATE_PRINT
        samus1: la a0 , samusStandBy  # mudar para outro estado da samus
        j END_UPDATE_PRINT