;=================================================
; Name: Steven Tran
; Email:  stran050@ucr.edu
; GitHub username: Azenros
; 
; Lab: lab 5
; Lab section: 25
; TA: Daniel Handojo
; 
;=================================================
.ORIG x3000


; Beginning ex. 03
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


; Beginning ex. 04
LD R3, ARR_PTR
LD R4, COUNT
LD R5, CONVERT

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
  
HALT


DEC_1 .FILL #1
COUNT .FILL #10
ARR_PTR .FILL x4000
CONVERT .FILL x30
COUNTER .FILL #16
ENDL .FILL '\n'
SPACE .FILL ' '
LETTER_B .FILL x62


.ORIG x4000
ARRAY1 .BLKW #10

.END