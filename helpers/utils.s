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