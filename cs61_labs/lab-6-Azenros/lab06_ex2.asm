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

LD R1, COUNT

INPUT_LOOP
  GETC
  OUT
  ADD R1, R1, #-1
  ADD R2, R1, #-16
  BRz INPUT_LOOP
  ADD R3, R1, #0
  LD R2, CONVERT_BACK
  ADD R0, R0, R2
  
INPUT_LOOP2
  ADD R3, R3, #0
  BRz AFTER_INPUT
  ADD R0, R0, R0
  ADD R3, R3, #-1
  BRp INPUT_LOOP2
  
AFTER_INPUT
  ADD R4, R4, R0
  ADD R1, R1, #0
  BRp INPUT_LOOP
  
  ADD R2, R4, #0
  ADD R1, R2, #0
  LD R5, CONVERT
  LD R3, PRINT_ARRAY
  LD R0, NEWLINE
  OUT
  JSRR R3
  
HALT

; Data
INTRO_MESSAGE .STRINGZ "Enter a 'b', and then a 16 bit number (no spaces): "
COUNT .FILL #17
NEWLINE .FILL '\n'
CONVERT .FILL #48
CONVERT_BACK .FILL #-48
PRINT_ARRAY .FILL x3200


;==================================================================
; Subroutine: Printing From Array
; Parameter (R1): The number to print to binary
; Postcondition: The subroutine has printed to consle all characters 
;                of every number in the array.
; Return Value: None
;===================================================================

.ORIG x3200

SUBROUTINE
  
  ST R7, BACKUP_R7_3200
  LD R6, COUNTER
  LD R0, LETTER_B
  OUT
  AND R0, R0, #0
  
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
    AND R0, R0, #0
    ADD R0, R0, R5
    OUT
    BR LEFT_SHIFT
  
  ONE
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

BACKUP_R7_3200 .BLKW #1








.END




