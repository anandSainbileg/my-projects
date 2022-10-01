  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ write your program here
  @
 
  MOV   R4, #0                    @ count = 0
  CMP   R1, R2                    @ Compare oldIndex with newIndex
  BHS ifOldHigher
  BLS ifNewHigher
  B end

  ifOldHigher:                    @ if(oldIndex > newIndex){
  SUB   R5, R1, R2                @ number = oldIndex - newIndex  (number is the number of digits to move)
  LDR   R3, [R0, R1, LSL #2]      @ numberToMove = array[oldIndex]
  whileOld:                       @ while(count <= number){
  CMP   R4, R5                    
  BHS endWhile  
  SUB   R1, R1, #1                @ oldIndex = oldIndex - 1
  LDR   R7, [R0, R1, LSL #2]      @ changeNumber = array[oldIndex]
  ADD   R1, R1, #1                @ oldIndex = oldIndex + 1
  STR   R7, [R0, R1, LSL #2]      @ array[oldNumber] = changeNumber
  SUB   R1, R1, #1                @ oldIndex = oldIndex - 1
  ADD   R4, R4, #1                @ count = count + 1
  B whileOld                      @ }
  endWhile:                   
  STR R3, [R0, R2, LSL #2]        @ numberToMove = array[newIndex]
  B end                           @ }
  
  ifNewHigher:                    @ if(newIndex < oldIndex){
  SUB   R5, R2, R1                @ number = oldIndex - newIndex  (number is the number of digits to move)
  LDR   R3, [R0, R1, LSL #2]      @ numberToMove = array[oldIndex]
  whileNew:                       @ while(count <= number){
  CMP   R4, R5
  BHS endNew
  ADD   R1, R1, #1                @ oldIndex = oldIndex + 1
  LDR   R7, [R0, R1, LSL #2]      @ changeNumber = array[oldIndex]
  SUB   R1, R1, #1                @ oldIndex = oldIndex - 1
  STR   R7, [R0, R1, LSL #2]      @ array[oldNumber] = changeNumber
  ADD   R1, R1, #1                @ oldIndex = oldIndex + 1
  ADD   R4, R4, #1                @ count = count + 1
  B whileNew                      @ }
  endNew:
  STR   R3, [R0, R2, LSL #2]      @ numberToMove = array[newIndex]
  B end                           @ }

  @ End of program ... check your result
end:
End_Main:
  BX    lr

