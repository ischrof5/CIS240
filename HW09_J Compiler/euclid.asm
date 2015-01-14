.CODE
.ADDR 0x1000
.FALIGN

EUCLID:

	;; allocate stack slots
	ADD R6 R6 #-3
	;; save RA
	STR R7 R6 #1
	;; save caller FP
	STR R5 F6 #0
	;; local FP
	ADD R5 R6 #0

	;; method body

	;; load a and b
	LDR R1 R5 #3 ;; a
	LDR R2 R5 #4 ;; b
	CMPI R2 #0
	BRz EUCLIDEND

	;; push new euclid call onto stack
	;; calculate a % b and push onto stack
	;; (lecture slides said load right to left)
	MOD R3 R1 R2
	STR R3 R6 #-1
	ADD R6 R6 #-1
	;; push a onto stack
	STR R2 R6 #-1
	ADD R6 R6 #-1
	;; call euclid
	JSR EUCLID

	;; if it did a JSR, it RETs here
	;; copy the return value to this one
	LDR R7 R6 #-1
	STR R7 R5 #3

EUCLIDEND:
	; result is argument a, @(FP+3), copy to RV
	LDR R7 R5 #3
	STR R7 R5 #2

	ADD R6 R5 #0

	;; restore caller FP
	LDR R5 R6 #0

	;; restore RA
	LDR R7 R6 #1

	;; free FP RA RV
	ADD R6 R6 #3

	RET
