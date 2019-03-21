;=================================================
; Name: Steven Tran
; Email:  stran050@ucr.edu
; GitHub username: Azenros
; 
; Lab: lab 4
; Lab section: 25
; TA: Daniel Handojo
; 
;=================================================

.ORIG x3000

LD R1, COUNT
LEA R2, ARRAY1
LD R3, TEMP_A

DO_WHILE
  GETC
  OUT
  STR R0, R2, #0
  
  ADD R2, R2, #1
  ADD R1, R1, #-1
  BRp DO_WHILE
  
HALT

ARRAY1 .BLKW #10
COUNT .FILL #10
TEMP_A .FILL #0



.END