;=================================================
; Name: Steven Tran
; Email:  stran050@ucr.edu
; GitHub username: Azenros
; 
; Lab: lab 3
; Lab section: 25
; TA: Daniel Handojo
; 
;=================================================
.ORIG x3000

LD R0, HEX_61
LD R1, HEX_1A


FOR_LOOP1
  OUT 
  ADD R0, R0, #1
  ADD R1, R1, #-1
  BRp FOR_LOOP1
  

HALT



HEX_61 .FILL x61
HEX_1A .FILL x1A

.END