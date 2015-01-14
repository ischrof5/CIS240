	;;; user_hw.asm: by Daniel McCann
	;;; Pennkey: mccannd
	
	.DATA
	.ADDR x4000
	
	
	;;; space for puts
name_array
	.STRINGZ "Daniel McCann"
	
	;;; space allocation
	.ADDR x4200
TEMPS 	.BLKW x200

	;;; colors
GREEN .UCONST x03E0	; 0 00000 11111 00000
BLUE  .UCONST x001F	; 0 00000 00000 11111
WHITE .UCONST xFFFF	; 1 11111 11111 11111

	;;; number sprites
ZERO .UCONST x0077
ONE .UCONST x0024
TWO .UCONST x005D
THREE .UCONST x006D
FOUR .UCONST x002E
FIVE .UCONST x006B
SIX .UCONST x007B
SEVEN .UCONST x0025
EIGHT .UCONST x007F
NINE .UCONST x002F
	
	.CODE
	.ADDR x0000
	
	;;; print name to console
	LEA R0 name_array
	TRAP x08
	
	;;; echo characters from keyboard to console
WAIT_CHAR_LOOP
	TRAP x09			; wait for character input
	ADD R0 R5 #0		; copy character to R0
	TRAP x01			; put into console
	CMPI R0 0x0A		; check for newline, exit loop if it is
	BRnp WAIT_CHAR_LOOP
	
	
	;;; create green rectangle
	CONST R0 #60
	CONST R1 #80
	CONST R2 #20
	CONST R3 #40
	LC R4 GREEN
	
	TRAP 0x0A
	
	;;; create blue rectangle
	
	CONST R0 #60
	CONST R1 #100
	CONST R2 #120
	CONST R3 #80
	LC R4 BLUE
	
	TRAP 0x0A
	
	;;; write 0 - 9 onto video display
	CONST R0 3		; starting column
	CONST R1 5		; starting row
	LC R2 WHITE
	LC R3 ZERO
	
	TRAP x0B
	
	CONST R0 11		; starting column
	CONST R1 5		; starting row
	LC R2 WHITE
	LC R3 ONE
	
	TRAP x0B
	
	CONST R0 19		; starting column
	CONST R1 5		; starting row
	LC R2 WHITE
	LC R3 TWO
	
	TRAP x0B
	
	CONST R0 27		; starting column
	CONST R1 5		; starting row
	LC R2 WHITE
	LC R3 THREE
	
	TRAP x0B
	
	CONST R0 35		; starting column
	CONST R1 5		; starting row
	LC R2 WHITE
	LC R3 FOUR
	
	TRAP x0B
	
	CONST R0 43		; starting column
	CONST R1 5		; starting row
	LC R2 WHITE
	LC R3 FIVE
	
	TRAP x0B
	
	CONST R0 51		; starting column
	CONST R1 5		; starting row
	LC R2 WHITE
	LC R3 SIX
	
	TRAP x0B
	
	CONST R0 59		; starting column
	CONST R1 5		; starting row
	LC R2 WHITE
	LC R3 SEVEN
	
	TRAP x0B
	
	CONST R0 67		; starting column
	CONST R1 5		; starting row
	LC R2 WHITE
	LC R3 EIGHT
	
	TRAP x0B
	
	CONST R0 75		; starting column
	CONST R1 5		; starting row
	LC R2 WHITE
	LC R3 NINE
	
	TRAP x0B
	
END
	NOP