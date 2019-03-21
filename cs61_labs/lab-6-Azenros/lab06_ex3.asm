;=================================================
; Name: Steven Tran
; Email:  stran050@ucr.edu
; GitHub username: Azenros
; 
; Lab: lab 6
; Lab section: 25
; TA: Daniel Handojo
; 
;=================================================

.ORIG x3000
LEA R0, INTRO_MESSAGE
PUTS
LD R0, NEWLINE
OUT

LEA R1, PTR_3400
LDR R0, R1, #0
JSRR R0

LEA R1, PTR_3200
LDR R0, R1, #0
JSRR R0

HALT

INTRO_MESSAGE .STRINGZ "Enter a 'b', and then a 16 bit number (no spaces):"
NEWLINE .FILL '\n'
PTR_3200 .FILL x3200
PTR_3400 .FILL x3400

;==================================================================
; Subroutine: Printing From Array
; Parameter (R2): The number to print to binary
; Postcondition: The subroutine has printed to consle all characters 
;                of every number in the array.
; Return Value: None
;===================================================================

.ORIG x3200

PRINT_SUBROUTINE
ST R0, BACKUP_R0_3200
ST R1, BACKUP_R1_3200
ST R2, BACKUP_R2_3200
ST R6, BACKUP_R6_3200
ST R7, BACKUP_R7_3200

LD R6, COUNTER
LD R0, LETTER_B
OUT
AND R0, R0, #0
LD R1, BACKUP_R2_3200
PRINT_LOOP
  
  ADD R1, R1, #0
  BRzp ZERO
  ADD R1, R1, #0
  BRn ONE

LEFT_SHIFT
  ADD R1, R1, R1
  ADD R6, R6, #-1
  ADD R7, R6, #-12
  BRz SPACE_PRINT
  ADD R7, R6, #-8
  BRz SPACE_PRINT
  ADD R7, R6, #-4
  BRz SPACE_PRINT
  
SPACE_AFTER
  ADD R6, R6, #0
  BRp PRINT_LOOP
  LD R0, SPACE
  OUT
  JSR END
  
ZERO
  LD R5, CONVERT_ASCII
  AND R0, R0, #0
  ADD R0, R0, R5
  OUT
  BR LEFT_SHIFT

ONE
  LD R5, CONVERT_ASCII
  AND R0, R0, #0
  ADD R0, R0, #1
  ADD R0, R0, R5
  OUT
  BR LEFT_SHIFT
  
SPACE_PRINT
  LD R0,SPACE
  OUT
  BR SPACE_AFTER
  
END
  LD R0, BACKUP_R0_3200
  LD R1, BACKUP_R1_3200
  LD R2, BACKUP_R2_3200
  LD R6, BACKUP_R6_3200
  LD R7, BACKUP_R7_3200
  RET
  
;=====================
;  Subroutine Data
;=====================
SPACE .FILL ' '
ENDL .FILL '\n'
COUNTER .FILL #16
LETTER_B .FILL x62

SPACE_1 .FILL #-12
SPACE_2 .FILL #-8
SPACE_3 .FILL #-4
CONVERT_ASCII .FILL #48

BACKUP_R0_3200 .BLKW #1
BACKUP_R1_3200 .BLKW #1
BACKUP_R2_3200 .BLKW #1
BACKUP_R6_3200 .BLKW #1
BACKUP_R7_3200 .BLKW #1



;==================================================================
; Subroutine: Inserting into Array
; Parameter: No Parameters 
; Postcondition: The subroutine has finished inputting all 16
;                binary numbers and stored the correct decimal value.
; Return Value(R2): The decimal value of the inputted binary
;===================================================================
.ORIG x3400
  
INSERT_SUBROUTINE
  ST R0, BACKUP_R0_3400
  ST R1, BACKUP_R1_3400
  ST R3, BACKUP_R3_3400
  ST R4, BACKUP_R4_3400
  ST R5, BACKUP_R5_3400
  ST R7, BACKUP_R7_3400

  LD R1, COUNT
  

  B_LOOP
    GETC
    OUT
    LD R5, LETTER_B_CHECK
    ADD R5, R5, R0
    BRnp INVALID_B
    

  INPUT_LOOP
    
    GETC
    OUT
    LD R5, SPACE_CHECK
    ADD R5, R5, R0
    BRz INPUT_SPACE
    
    LD R5, CONVERT_BACK
    ADD R5, R5, R0
    BRn INVALID_INPUT
    
    LD R5, ABOVE_2
    ADD R5, R5, R0
    BRzp INVALID_INPUT
    
    
    ADD R1, R1, #-1
    ADD R3, R1, #0
    LD R2, CONVERT_BACK
    ADD R0, R0, R2
    
  POWER_2
    ADD R3, R3, #0
    BRz AFTER_INPUT
    ADD R0, R0, R0
    ADD R3, R3, #-1
    BRp POWER_2
    
  AFTER_INPUT
    ADD R4, R4, R0
    ADD R1, R1, #0
    BRp INPUT_LOOP
    
    ADD R2, R4, #0
    ADD R1, R2, #0
    LD R5, CONVERT
    LD R0, NEWLINE3
    OUT
    JSR END_SUB
    
  INPUT_SPACE
    OUT
    JSR INPUT_LOOP

  INVALID_B
    OUT
    LEA R0, ERROR_MESSAGE
    PUTS
    JSR B_LOOP
    
  INVALID_INPUT
    LEA R0, ERROR_MESSAGE2
    PUTS
    JSR INPUT_LOOP
    
  END_SUB
    LD R1, BACKUP_R1_3400
    LD R3, BACKUP_R3_3400
    LD R4, BACKUP_R4_3400
    LD R5, BACKUP_R5_3400
    LD R7, BACKUP_R7_3400
    RET

HALT  

;=====================
;  Subroutine Data
;=====================
ERROR_MESSAGE .STRINGZ "\nError: letter entered is not 'b'"
ERROR_MESSAGE2 .STRINGZ "\nError: character entered is not 0, 1, or space\n"
COUNT .FILL #16
SPACE_CHECK .FILL #-32
LETTER_B_CHECK .FILL #-98
NEWLINE3 .FILL '\n'
CONVERT .FILL #48
CONVERT_BACK .FILL #-48
ABOVE_2 .FILL #-50


BACKUP_R0_3400 .BLKW #1
BACKUP_R1_3400 .BLKW #1
BACKUP_R2_3400 .BLKW #1
BACKUP_R3_3400 .BLKW #1
BACKUP_R4_3400 .BLKW #1
BACKUP_R5_3400 .BLKW #1
BACKUP_R7_3400 .BLKW #1

.END





