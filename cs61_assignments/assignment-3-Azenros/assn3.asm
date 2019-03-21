;=================================================
; Name: Steven Tran
; Email: stran050@ucr.edu
; GitHub username: Azenros
; 
; Assignment name: Assignment 3
; Lab section: 25
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_addr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
LD R2, COUNTER1
LD R3, COUNTER2

LOOP
  ADD R3,R3,#0
  BRp POS
    LEA R0, SPACE
    PUTS
    LD R3, COUNTER2
    ADD R2,R2,#0
;     BR END
    BRp LOOP
  
  POS
    ADD R1,R1,#0
    BRn IF_NEG
    LEA R0, ZERO_FILL
    PUTS
    BR END
    
    IF_NEG
    LEA R0, ONE_FILL
    PUTS
    BR END
  
  END
    ADD R1,R1,R1
    ADD R3,R3,#-1
    ADD R2,R2,#-1
    BRp LOOP
  
LD R0, ENDL
OUT

;---------------	
;Data
;---------------
Value_addr	.FILL xD100	; The address where value to be displayed is stored
SPACE .STRINGZ " "
ENDL .FILL '\n'
COUNTER1 .FILL #16
COUNTER2 .FILL #4
ZERO_FILL .STRINGZ "0"
ONE_FILL .STRINGZ "1"


.ORIG xD100					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
