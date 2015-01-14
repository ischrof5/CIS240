
.CODE

.FALIGN
test_ifs

	;; function prologue for test_ifs;;
	ADD R6 R6 #-3
	STR R7 R6 #1
	STR R5 R6 #0
	ADD R5 R6 #0
	;; retrieving identifier n ;;
	LDR R0 R5 #3
	STR R0 R6 #-1
	ADD R6 R6 #-1

	CONST R0 #10
	STR R0 R6 #-1
	ADD R6 R6 #-1

	LDR R0 R6 #0
	ADD R6 R6 #1
	LDR R1 R6 #0
	CMP R1 R0
	BRn TRUE0
	CONST R3 #0
	BRnzp FALSE0
.FALIGN
TRUE0
	CONST R3 #1
.FALIGN
FALSE0
	STR R3 R6 #0

	BRnz ELSE1

	;; retrieving identifier n ;;
	LDR R0 R5 #3
	STR R0 R6 #-1
	ADD R6 R6 #-1

	CONST R0 #5
	STR R0 R6 #-1
	ADD R6 R6 #-1

	LDR R0 R6 #0
	ADD R6 R6 #1
	LDR R1 R6 #0
	CMP R1 R0
	BRn TRUE1
	CONST R3 #0
	BRnzp FALSE1
.FALIGN
TRUE1
	CONST R3 #1
.FALIGN
FALSE1
	STR R3 R6 #0

	BRnz ELSE2

	CONST R0 #1
	STR R0 R6 #-1
	ADD R6 R6 #-1

	BRnzp ELSEEND2

.FALIGN
ELSE2
	CONST R0 #2
	STR R0 R6 #-1
	ADD R6 R6 #-1

.FALIGN
ELSEEND2
	BRnzp ELSEEND1

.FALIGN
ELSE1
	;; retrieving identifier n ;;
	LDR R0 R5 #3
	STR R0 R6 #-1
	ADD R6 R6 #-1

	CONST R0 #20
	STR R0 R6 #-1
	ADD R6 R6 #-1

	LDR R0 R6 #0
	ADD R6 R6 #1
	LDR R1 R6 #0
	CMP R1 R0
	BRn TRUE2
	CONST R3 #0
	BRnzp FALSE2
.FALIGN
TRUE2
	CONST R3 #1
.FALIGN
FALSE2
	STR R3 R6 #0

	BRnz ELSE3

	CONST R0 #3
	STR R0 R6 #-1
	ADD R6 R6 #-1

	BRnzp ELSEEND3

.FALIGN
ELSE3
	CONST R0 #4
	STR R0 R6 #-1
	ADD R6 R6 #-1

.FALIGN
ELSEEND3
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
	CONST R0 #3
	STR R0 R6 #-1
	ADD R6 R6 #-1

	;; binding identifier b ;;
	CONST R0 #7
	STR R0 R6 #-1
	ADD R6 R6 #-1

	;; binding identifier c ;;
	CONST R0 #13
	STR R0 R6 #-1
	ADD R6 R6 #-1

	;; binding identifier d ;;
	CONST R0 #105
	STR R0 R6 #-1
	ADD R6 R6 #-1


	;; calling function printnum ;;

	;; calling function test_ifs ;;
	;; retrieving identifier a ;;
	LDR R0 R5 #-1
	STR R0 R6 #-1
	ADD R6 R6 #-1


	;; reversing stack for calling convention ;;
	LDR R2 R6 #0
	LDR R3 R6 #0
	STR R2 R6 #0
	STR R3 R6 #0

	JSR test_ifs

	;; function caller epilogue ;;
	LDR R4 R6 #-1
	ADD R6 R6 #0
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

	;; calling function printnum ;;

	;; calling function test_ifs ;;
	;; retrieving identifier b ;;
	LDR R0 R5 #-2
	STR R0 R6 #-1
	ADD R6 R6 #-1


	;; reversing stack for calling convention ;;
	LDR R2 R6 #0
	LDR R3 R6 #0
	STR R2 R6 #0
	STR R3 R6 #0

	JSR test_ifs

	;; function caller epilogue ;;
	LDR R4 R6 #-1
	ADD R6 R6 #0
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

	;; calling function printnum ;;

	;; calling function test_ifs ;;
	;; retrieving identifier c ;;
	LDR R0 R5 #-3
	STR R0 R6 #-1
	ADD R6 R6 #-1


	;; reversing stack for calling convention ;;
	LDR R2 R6 #0
	LDR R3 R6 #0
	STR R2 R6 #0
	STR R3 R6 #0

	JSR test_ifs

	;; function caller epilogue ;;
	LDR R4 R6 #-1
	ADD R6 R6 #0
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

	;; calling function printnum ;;

	;; calling function test_ifs ;;
	;; retrieving identifier d ;;
	LDR R0 R5 #-4
	STR R0 R6 #-1
	ADD R6 R6 #-1


	;; reversing stack for calling convention ;;
	LDR R2 R6 #0
	LDR R3 R6 #0
	STR R2 R6 #0
	STR R3 R6 #0

	JSR test_ifs

	;; function caller epilogue ;;
	LDR R4 R6 #-1
	ADD R6 R6 #0
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

