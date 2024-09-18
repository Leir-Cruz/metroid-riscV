PHYSICS:
        la t0, SAMUS_JUMP
        lb t1, 0(t0)
        bnez t1, FALL_FROM_JUMP

        ret 


FALL_FROM_JUMP:
        li t4, 1
        beq t1, t4, STOP_IN_THE_AIR

        la t2, SAMUS_POSITION
        lw t3, 4(t2)
		addi t3, t3, 32
		sw t3, 4(t2)

        li t4, 0
		sb t4, 0(t0)

        j START_RENDERING

STOP_IN_THE_AIR:
        li t4, 2
		sb t4, 0(t0)

        j START_RENDERING