####################### PROCEDIMENTO MAX ########################
#	ARGUMENTOS:						#
#		a0 = numero					#
#		a1 = numero					#
#	RETORNO:						#
#		retorna em a0 o maior valor entre a0 e a1	#
#################################################################

MAX:		bge		a0, a1, MAX.RET	# IF a0 > a1 JUMP MAX.RET
		mv		a0, a1		# returns a1
MAX.RET:	ret

####################### PROCEDIMENTO MIN ########################
#	ARGUMENTOS:						#
#		a0 = numero					#
#		a1 = numero					#
#	RETORNO:						#
#		retorna em a0 o menor valor entre a0 e a1	#
#################################################################

MIN:		ble		a0, a1, MIN.RET	# IF a0 < a1 JUMP MIN.RET
		mv		a0, a1		# returns a1
MIN.RET:	ret


RENDER_SAMUS_LIFE3:
		la t1, SAMUS_LIFE_POSITION

		la a0, samusLife3
		lw a1, 0(t1)
		lw a2, 4(t1)
		mv a3, s3
		mv a4, zero
		mv a5, zero
		jal PRINT

		j RENDER_SAMUS	


RENDER_SAMUS_LIFE2:
		la t1, SAMUS_LIFE_POSITION

		la a0, samusLife2
		lw a1, 0(t1)
		lw a2, 4(t1)
		mv a3, s3
		mv a4, zero
		mv a5, zero
		jal PRINT

		j RENDER_SAMUS

RENDER_SAMUS_LIFE1:
		la t1, SAMUS_LIFE_POSITION

		la a0, samusLife1
		lw a1, 0(t1)
		lw a2, 4(t1)
		mv a3, s3
		mv a4, zero
		mv a5, zero
		jal PRINT

		j RENDER_SAMUS


RENDER_SAMUS_LIFE0:
		la t1, SAMUS_LIFE_POSITION

		la a0, samusLife0
		lw a1, 0(t1)
		lw a2, 4(t1)
		mv a3, s3
		mv a4, zero
		mv a5, zero
		jal PRINT

		j RENDER_SAMUS