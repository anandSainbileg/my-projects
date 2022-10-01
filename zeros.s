  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:
  
  @ Follow the instructions in the handout for Assignment 8

  @ *** your program goes here ***

  MOV   R4, #0               //count = 0
  MOV   R0, #0               //countZero = 0
  MOV   R3, #0               //countForZeros = 0
  MOV   R5, #0               //tempCount = 0
  MOV   R6, #0               //tempCountZeros = 0
  while:
  CMP   R4, #32              //While (R4 <= 32){
  BHS Endwhile
  
  MOVS  R1, R1, LSL #1       //Move the binary digits to the left by one
  BCS Endif                  //End if its 1 
  ADD   R5, R5, #1           //tempCount = tempCount + 1
  ADD   R4, R4, #1           //count = count + 1
  ADD   R6, R6, #1           //tempCountZeros = tempCountZeros + 1
  B while                    //}
 
  Endif:                     //If branch is 1
  MOV   R6, #0               //tempCountZeros = 0
  ADD   R4, R4, #1           //count = count + 1
  CMP   R5, R3               //if (tempCount >= countForZeros){
  BHS ifhigher
  MOV   R5, R3               //tempCount =  countForZeros
  MOV   R5, #0               //tempCount = 0
  B while                    //}
  
  ifhigher:                  //else {
  MOV   R3, R5               //countForZeros = tempCount
  MOV   R5, #0               //tempCount = 0
  B while                    //}

 Endwhile:                   //}        
  CMP   R3, R6               //if (countForZeros <= tempCountZeros){
  BHS putHigher 
  MOV   R0, R6               //countZero = tempCountZeros
  B End_Main                 //}
  
  putHigher:                 //else{
  MOV   R0, R3               //countZero = countForZeros
  @ End of program ... check your result

End_Main:                    //}
  BX    lr
