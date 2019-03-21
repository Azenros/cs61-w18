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

LD R2, DEC_0
LD R3, ARR_PTR
LD R4, COUNT

FILL_ARRAY
  STR R2, R3, #0
  ADD R3, R3, #1
  ADD R2, R2, #1
  ADD R4, R4, #-1  
  
  BRp FILL_ARRAY

LD R3, ARR_PTR
LD R4, COUNT
LD R5, CONVERT

PRINT_LOOP
  LDR R0, R3, #0
  ADD R0, R0, R5
  OUT
  ADD R3, R3, #1
  ADD R4, R4, #-1
  BRp PRINT_LOOP



HALT


DEC_0 .FILL #0
COUNT .FILL #10
ARR_PTR .FILL x4000
CONVERT .FILL x30

.ORIG x4000
ARRAY1 .BLKW #10

.END