.data
SAMUS_MOVE_X:		.byte 0		# left: -1, right: 1
SAMUS_MOVE_Y:		.byte 0		# up: -1, down: 1
SAMUS_JUMP:		.byte 0		# jump: 1, nothing: 0
SAMUS_ROLLING:		.byte 0		# roll: 1, nothing: 0

.text
GAME_START:	jal MENU_START
AFT_CLOSE_MENU: jal MUSIC_SETUP
            	
            	
GAME_LOOP: 	jal MUSIC_PLAY_NOTES
		j EXIT
		



EXIT:
		li		a7, 10
		ecall
		

.data 
.include "helpers/play_main_music.s"
.include "helpers/menu.s"
.include "helpers/inputs.s"
.include "helpers/print.s"
	
	
