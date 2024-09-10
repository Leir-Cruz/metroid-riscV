.data

.include "../sprites/title2.data"  
.include "../sprites/title3.data"  


.text



MENU_START: 	la a0, title2
		li a1, 0
		li a2, 0
		li a3, 0
            	jal PRINT
            	la a0, title3
		li a1, 0
		li a2, 0
		li a3, 1
		jal PRINT
		

MENU_CHANGE:	xori, s0, s0,1
		mv a3, s0
		li s0,0xFF200604
		sw s0, 0(t0)
		
		
		sw t2,0(s0)		# seleciona a Frame t2
	  	xori t2,t2,0x001	# escolhe a outra frame
SLEEP_MENU:	li a0,1000		
	  	li a7,32
	 	ecall
	 	
	 	jal FIRST_INPUT	
		
		j MENU_CHANGE
		

CLOSE_MENU: 	ret
		
