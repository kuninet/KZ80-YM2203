;
; YM2203 VGM PLAY FOR KZ80
;
	CPU	Z80

TARGET:	equ	"Z80"

MUSIC	EQU	4200H
OPM_ADDR	EQU	040H
OPM_DATA	EQU	041H
;
	ORG	4100H
;
	JP	MAIN	
;
MAIN:
	CALL	MAIN1
;
	RET	; PGM END
;
MAIN1:
	LD	HL,MUSIC
LOOP:
	LD	A,(HL)	; GET COMMAND
	CP	055H
	JP	Z,PLAY
	CP	061H
	JP	Z,WAIT1
	CP	062H
	JP	Z,WAIT2
	CP	063H
	JP	Z,WAIT3
	CP	064H
	JP	Z,WAIT3
	CP	066H
	JP	Z,END_RTN
;
	CP	70H
	JP	Z,WAIT4
	JP	NZ,CHK_WAIT
NEXT:
	INC	HL
	JP	LOOP
;
END_RTN:
	RET	; GOTO MAIN	
;
PLAY:
	INC 	HL
	LD 	D,(HL)
	INC 	HL
	LD 	E,(HL)
WRITEOPN:
; STATUS CHECK WAIT
	IN  A,(OPM_ADDR)
	RLCA
	JR      C,WRITEOPN
; REG OUT
	LD      A,D
	OUT     (OPM_ADDR),A
	LD      A,(IX+0)        ;DUMMY
; DATA OUT
	LD      A,E
	OUT     (OPM_DATA),A
	JP 	NEXT
;
WAIT1:
	INC	HL
	LD	E,(HL)
	INC	HL
	LD	D,(HL)
	CALL	WAIT
	JP NEXT
;
WAIT2:
	LD	DE,735	
	CALL	WAIT
	JP 	NEXT
;
WAIT3:
	LD 	DE,882
	CALL 	WAIT
	JP 	NEXT
;
CHK_WAIT:
	CP	80H
	JP	NC,NEXT
WAIT4:
	AND	0FH
	INC	A
	LD 	D,0
	LD	E,A
	CALL	WAIT
	JP 	NEXT
;  
WAIT:	
	CALL	WAIT1MS	
	DEC	DE		
	LD	A,D
	OR	E
	JR	NZ,WAIT
	RET		
; 
WAIT1MS:	
	LD	BC,1		 
WAIT1MSLOOP:
	DEC	BC
	NOP		;DUMMY (clock 4)
	LD	A,C
	OR	B
	JR	NZ,WAIT1MSLOOP
	RET
;
END
