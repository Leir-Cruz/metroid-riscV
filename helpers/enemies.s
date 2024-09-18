.data
RIPPER_POSITION: .word 200, 180
RIPPER_X_MIN_MAX: .word 600, 800 #maximo tem que ser o lugar que a gente quer - o tamanho do ripper

.text
MOVE_RIPPER:
        la t1, RIPPER_POSITION
        lw t2, 0(t1) #posicao atual

        la a1, RIPPER_X_MIN_MAX
        lw a2, 0(a1) #minimo
        lw a3, 4(a1) #maximo

        beq t2, a2, MOVE_LEFT_RIPPER
        bgt t2, a3, MOVE_RIGHT_RIPPER ## enquanto não chegar no minimo manter andando esquerda

MOVE_RIGHT_RIPPER:

        ##### mudando a posiçãp (t2 é a posicao x atual)
        addi t3, t2, 16 #supondo tamanho ripper é de 16 pixeis
        sw t3, 0(t1)
        # ....

MOVE_LEFT_RIPPER:
        addi t2, t2, -16
        sw t2, 0(t1)



RET_LOOP: J MOVE_RIPPER