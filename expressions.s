  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ write your program here
  @

  @
  @ You can use either
  @
  @   The System stack (R13/SP) with PUSH and POP operations
  @
  @   or
  @
  @   A user stack (R12 has been initialised for this purpose)
  @
 MOV    R4, #10           @ number = 10
 LDRB   R2, [R1]          @ R2 = byte[R1] load byte into R2
 ADD    R1, R1, #1        @ R1 = R1 + 1 
 LDRB   R7, [R1]          @ R7 = byte[R1] to check the next byte to see if its 0 so the program can stop and store the number if there's a single number without other digits or operations
 CMP    R7, #0            @ if(R7 = 0){
 BNE    notZero           
 SUB    R2, R2, #48       @ R2 = R2 - 48 (ascii to decimal) 
 SUB    R1, R1, #1        @ R1 = R1 - 1 to move to previous byte
 MOV    R0, R2            @ R0 = R2 if the program has a single digit and nothing 
 B      End_Main          @ }
 notZero:                 @ else {
 SUB    R1, R1, #1        @ R1 = R1 - 1 to move to previous byte

 while:                   @ while(R2 != 0){
 CMP    R2, #0            
 BEQ    over
 CMP    R2, #'0'          @ if(R2 >= 0 && R2 <= 9){
 BLO    notNumber   
 CMP    R2, #'9'
 BHI    notNumber
 SUB    R2, R2, #48       @ R2 = R2 - 48 (ascii to decimal)
 
 digit:                   @ while(R3 >= 0 && R3 <= 9){      (to check if the number has more digits than one)
 ADD    R1, R1, #1        @ R1 = R1 + 1
 LDRB   R3, [R1]          @ R3 = byte[R1]
 CMP    R3, #'0'          
 BLO    noDigit
 CMP    R3, #'9'
 BHI    noDigit
 SUB    R3, R3, #48       @ R3 = R3 - 48
 MUL    R2, R2, R4        @ R2 = R2 * 10
 ADD    R2, R2, R3        @ R2 = R2 + R3
 B      digit             @ }
 
 noDigit:                 
 PUSH   {R2}              @ Push R2 to system pointer
 ADD    R1, R1, #1        @ R1 = R1 + 1
 LDRB   R2, [R1]          @ R2 = byte[R1]
 B      while             
 
 notNumber:               @ if(R2 = ' '){     (if the byte is ascii character space)
 CMP    R2, #' '        
 BNE    notSpace    
 ADD    R1, R1, #1        @ R1 = R1 + 1
 LDRB   R2, [R1]          @ R2 = byte[R1]
 B      while             @ }

 notSpace:                @ else if(R2 = '+'){
 CMP    R2, #'+'
 BNE    notPlus
 POP    {R0}              @ Pop the system stack into R0
 MOV    R5, R0            @ R5 = R0 to save the initial R0
 POP    {R0}              @ Pop the system stack into R0
 ADD    R0, R0, R5        @ R0 = R0 + R5 to perform add function
 PUSH   {R0}              @ Push R0 to system pointer to have only one stack
 ADD    R1, R1, #1        @ R1 = R1 + 1
 LDRB   R2, [R1]          @ R2 = byte[R1]
 B      while             @ }
 
 notPlus:                 @else if(R2 = '-'){
 CMP    R2, #'-'         
 BNE    notMinus
 POP    {R0}              @ Pop the system stack into R0
 MOV    R5, R0            @ R5 = R0 to save the initial R0 
 POP    {R0}              @ Pop the system stack into R0
 SUB    R0, R0, R5        @ R0 = R0 - R5 to perform subtract function
 PUSH   {R0}              @ Push R0 to system pointer to have only one stack
 ADD    R1, R1, #1        @ R1 = R1 + 1
 LDRB   R2, [R1]          @ R2 = byte[R1]
 B      while             @ }
 
 notMinus:                @else if(R2 = '*'){
 CMP    R2, #'*'
 BNE    notMul
 POP    {R0}              @ Pop the system stack into R0
 MOV    R5, R0            @ R5 = R0 to save the initial R0 
 POP    {R0}              @ Pop the system stack into R0
 MUL    R0, R0, R5        @ R0 = R0 * R5 to perform subtract function
 PUSH   {R0}              @ Push R0 to system pointer to have only one stack
 ADD    R1, R1, #1        @ R1 = R1 + 1
 LDRB   R2, [R1]          @ R2 = byte[R1]
 B      while             @ }
 notMul:                  @ }

 over:      
 MOV    R6, R0            @ R6 = R0 to save current character in R0
 for:                     @ while(R0 != 0){     (to pop everything in system pointer)
 POP    {R0}              @ Pop the system stack into R0
 CMP    R0, #0            
 BEQ    done
 B      for               @ }
 done:
 MOV    R0, R6            @ R0 = R6 to get the result saved 
 
  @ End of program ... check your result

End_Main:
  BX    lr

