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

LD R1, ARR_PTR

DO_WHILE
  GETC
  OUT
  STR R0, R1, #0
  ADD R1, R1, #1
  ADD R0, R0, #-10
  BRnp DO_WHILE
  
  
LD R1, ARR_PTR

LOOP
  LD R0, ENDL
  OUT
  LDR R0,R1,#0
  OUT
  ADD R2,R0,#0
  
  ADD R1,R1,#1
  ADD R2,R2,#-10
  BRnp LOOP
  
HALT


ENDL .FILL x0A
ARR_PTR .FILL x4000


.END