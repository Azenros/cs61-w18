;=================================================
; Name: Steven Tran
; Email:  stran050@ucr.edu
; GitHub username: Azenros
; 
; Lab: lab 6
; Lab section: 25
; TA: Daniel Handojo
;=================================================

;=================================================
; Main:
;      Testing out subroutines
;=================================================
.ORIG x3000

LD R1, DEC_1
LD R3, ARR_PTR
LD R4, COUNT

FILL_ARRAY
  STR R1, R3, #0
  ADD R3, R3, #1
  ADD R1, R1, R1
  ADD R4, R4, #-1  
  BRp FILL_ARRAY

LD R3, ARR_PTR
ADD R3, R3, #6
LDR R1, R3, #0

LD R3, ARR_PTR
LD R4, COUNT
LD R5, CONVERT



LEA R2, SUB_PRINT_ARRAY_3200
JSRR R2
  
HALT


DEC_1 .FILL #1
COUNT .FILL #10
ARR_PTR .FILL x4000
CONVERT .FILL x30
SUB_PRINT_ARRAY_3200 .FILL x3200


;==================================================================
; Subroutine: Printing From Array
; Parameter (R2): The number to print to binary
; Postcondition: The subroutine has printed to consle all characters 
;                of every number in the array.
; Return Value: None
;===================================================================
.ORIG x3200

  ST R2, BACKUP_R2_3200
  ST R3, BACKUP_R3_3200
  ST R4, BACKUP_R4_3200
  ST R5, BACKUP_R5_3200
  ST R6, BACKUP_R6_3200
  ST R7, BACKUP_R7_3200

WHILE_3200
  LOAD_LOOP
    LD R0, LETTER_B
    OUT
    LD R0, #0
    LD R6, COUNTER
    LDR R2, R3, #0
  
  PRINT
    ADD R2, R2, #0
    BRzp ZERO
    ADD R2, R2, #0
    BRn ONE

  LEFT_SHIFT
    ADD R2, R2, R2
    ADD R6, R6, #-1
    ADD R7, R6, #-12
    BRz SPACE_PRINT
    ADD R7, R6, #-8
    BRz SPACE_PRINT
    ADD R7, R6, #-4
    BRz SPACE_PRINT
    
  SPACE_AFTER
    ADD R6, R6, #0
    BRp PRINT
    LD R0, ENDL
    OUT
    ADD R3, R3, #1
    ADD R4, R4, #-1
    BRp LOAD_LOOP
    HALT
    
  SPACE_PRINT
    LD R0,SPACE
    OUT
    BR SPACE_AFTER

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

 END_WHILE_3200
    LD R2, BACKUP_R2_3200
    LD R3, BACKUP_R3_3200
    LD R4, BACKUP_R4_3200
    LD R5, BACKUP_R5_3200
    LD R6, BACKUP_R6_3200
    LD R7, BACKUP_R7_3200


    RET
    
;=====================
;  Subroutine Data
;=====================
SPACE .FILL ' '
ENDL .FILL '\n'
LETTER_B .FILL x62
COUNTER .FILL #16

BACKUP_R2_3200 .BLKW #1
BACKUP_R3_3200 .BLKW #1
BACKUP_R4_3200 .BLKW #1
BACKUP_R5_3200 .BLKW #1
BACKUP_R6_3200 .BLKW #1
BACKUP_R7_3200 .BLKW #1


.ORIG x4000
ARRAY1 .BLKW #10



.END