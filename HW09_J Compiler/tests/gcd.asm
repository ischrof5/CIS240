
.CODE

.FALIGN
gcd

	;; function prologue for gcd;;
	ADD R6 R6 #-3
	STR R7 R6 #1
	STR R5 R6 #0
	ADD R5 R6 #0
	;; retrieving identifier b ;;
	LDR R0 R5 #4
	STR R0 R6 #-1
	ADD R6 R6 #-1

	CONST R0 #0
	STR R0 R6 #-1
	ADD R6 R6 #-1

	LDR R0 R6 #0
	ADD R6 R6 #1
	LDR R1 R6 #0
	CMP R1 R0
	BRz TRUE0
	CONST R3 #0
	BRnzp FALSE0
.FALIGN
TRUE0
	CONST R3 #1
.FALIGN
FALSE0
	STR R3 R6 #0

	BRnz ELSE1

	;; retrieving identifier a ;;
	LDR R0 R5 #3
	STR R0 R6 #-1
	ADD R6 R6 #-1

	BRnzp ELSEEND1

.FALIGN
ELSE1

	;; calling function gcd ;;
	;; retrieving identifier b ;;
	LDR R0 R5 #4
	STR R0 R6 #-1
	ADD R6 R6 #-1

	;; retrieving identifier a ;;
	LDR R0 R5 #3
	STR R0 R6 #-1
	ADD R6 R6 #-1

	;; retrieving identifier b ;;
	LDR R0 R5 #4
	STR R0 R6 #-1
	ADD R6 R6 #-1

	LDR R0 R6 #0
	ADD R6 R6 #1
	LDR R1 R6 #0
	MOD R1 R1 R0
	STR R1 R6 #0


	;; reversing stack for calling convention ;;
	LDR R2 R6 #1
	LDR R3 R6 #0
	STR R2 R6 #0
	STR R3 R6 #1

	JSR gcd

	;; function caller epilogue ;;
	LDR R4 R6 #-1
	ADD R6 R6 #1
	STR R4 R6 #0
.FALIGN
ELSEEND1

	;; function epilogue ;;
	LDR R0 R6 #0
	STR R0 R5 #2
	ADD R6 R5 #0
	LDR R5 R6 #0
	LDR R7 R6 #1
	ADD R6 R6 #3
	RET


.CODE

.FALIGN
main

	;; function prologue for main;;
	ADD R6 R6 #-3
	STR R7 R6 #1
	STR R5 R6 #0
	ADD R5 R6 #0
	;; binding identifier a ;;
	CONST R0 x2f
	HICONST R0 #4
	STR R0 R6 #-1
	ADD R6 R6 #-1

	;; binding identifier b ;;
	CONST R0 xce
	HICONST R0 #1
	STR R0 R6 #-1
	ADD R6 R6 #-1


	;; calling function printnum ;;
	;; retrieving identifier a ;;
	LDR R0 R5 #-1
	STR R0 R6 #-1
	ADD R6 R6 #-1


	;; reversing stack for calling convention ;;
	LDR R2 R6 #0
	LDR R3 R6 #0
	STR R2 R6 #0
	STR R3 R6 #0

	JSR printnum

	;; function caller epilogue ;;
	LDR R4 R6 #-1
	ADD R6 R6 #0
	STR R4 R6 #0

	;; calling function endl ;;

	;; reversing stack for calling convention ;;

	JSR endl

	;; function caller epilogue ;;
	LDR R4 R6 #-1
	ADD R6 R6 #-1
	STR R4 R6 #0

	;; calling function printnum ;;
	;; retrieving identifier b ;;
	LDR R0 R5 #-2
	STR R0 R6 #-1
	ADD R6 R6 #-1


	;; reversing stack for calling convention ;;
	LDR R2 R6 #0
	LDR R3 R6 #0
	STR R2 R6 #0
	STR R3 R6 #0

	JSR printnum

	;; function caller epilogue ;;
	LDR R4 R6 #-1
	ADD R6 R6 #0
	STR R4 R6 #0

	;; calling function endl ;;

	;; reversing stack for calling convention ;;

	JSR endl

	;; function caller epilogue ;;
	LDR R4 R6 #-1
	ADD R6 R6 #-1
	STR R4 R6 #0

	;; calling function printnum ;;

	;; calling function gcd ;;
	;; retrieving identifier a ;;
	LDR R0 R5 #-1
	STR R0 R6 #-1
	ADD R6 R6 #-1

	;; retrieving identifier b ;;
	LDR R0 R5 #-2
	STR R0 R6 #-1
	ADD R6 R6 #-1


	;; reversing stack for calling convention ;;
	LDR R2 R6 #1
	LDR R3 R6 #0
	STR R2 R6 #0
	STR R3 R6 #1

	JSR gcd

	;; function caller epilogue ;;
	LDR R4 R6 #-1
	ADD R6 R6 #1
	STR R4 R6 #0

	;; reversing stack for calling convention ;;
	LDR R2 R6 #0
	LDR R3 R6 #0
	STR R2 R6 #0
	STR R3 R6 #0

	JSR printnum

	;; function caller epilogue ;;
	LDR R4 R6 #-1
	ADD R6 R6 #0
	STR R4 R6 #0

	;; calling function endl ;;

	;; reversing stack for calling convention ;;

	JSR endl

	;; function caller epilogue ;;
	LDR R4 R6 #-1
	ADD R6 R6 #-1
	STR R4 R6 #0

	;; function epilogue ;;
	LDR R0 R6 #0
	STR R0 R5 #2
	ADD R6 R5 #0
	LDR R5 R6 #0
	LDR R7 R6 #1
	ADD R6 R6 #3
	RET

