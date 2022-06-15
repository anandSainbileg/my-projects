  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global   fp_add

@ fp_add subroutine
@ Add two IEEE-754 floating point numbers
@
@ Paramaters:
@   R0: a - first number
@   R1: b - second number
@
@ Return:
@   R0: result - a+b
@
fp_add:
  PUSH    {R3 - R9, LR}                      @ add any registers R4...R12 that you use
  LDR R9, =0x007fffff
  MOV R3, R0
  MOV R4, R1
  BL fp_exp
  MOV R5, R0    @ exponent of the first number
  MOV R0, R4
  BL fp_exp
  MOV R6, R0    @ exponent of the second number
  MOV R0, R3
  BL fp_frac
  MOV R7, R0    @ fraction of the first number
  MOV R0, R4
  BL fp_frac
  MOV R8, R0    @ fraction of the second number
  CMP R5, R6
  BGT firstExpHigher
  CMP R6, R5
  BGT secondExpHigher
  while:
  CMP R7, R9
  BLE low 
  MOVS R7, R7, ASR #1 
  ADD R5, R5, #1
  B while
  low:
  while2:
  CMP R8, R9
  BLE low2 
  MOVS R8, R8, ASR #1 
  ADD R6, R6, #1
  B while2
  low2:
  ADD R0, R7, R8
  MOV R1, R5
  BL fp_enc
  POP     {R3 - R9, PC} 
  
  firstExpHigher:
  CMP R5, R6
  BEQ equalExp1
  MOVS R8, R8, ASR #1
  ADD R6, R6, #1
  B firstExpHigher
  secondExpHigher:
  CMP R6, R5
  BEQ equalExp2
  MOVS R7, R7, ASR #1
  ADD R5, R5, #1
  B secondExpHigher
  equalExp1:
  equalExp2:
  ADD R0, R7, R8
  MOV R1, R5
  BL fp_enc
  POP     {R3-R9,PC}                      @ add any registers R4...R12 that you use


@
@ Copy your fp_frac, fp_exp, fp_enc subroutines from Assignment #6 here
@   and call them from fp_add above.
@
fp_exp:
  PUSH    {R4 - R7, LR}                      @ add any registers R4...R12 that you use
  MOV R4, #0x7f800000
  AND R5, R4, R0
  MOVS R0, R5, LSR #23
  MOV R6, #127
  SUB R0, R0, R6
  POP     {R4 - R7, PC}

  fp_frac:
  PUSH    {R4, R5, LR}                      @ add any registers R4...R12 that you use
  MOV R4, R0
  LDR R5, =0x007FFFFF
  AND R0, R5
  ADD R0, #0x00800000
  CMP R4, #0
  BGE ifHigher
  NEG R0, R0
  ifHigher:
  POP     {R4, R5, PC}   
  
  
  fp_enc:
  PUSH    {R4 - R6,LR}                      @ add any registers R4...R12 that you use
  MOV R5, #0x00ffffff
  CMP R1, #0
  BNE exponent0
  CMP R0, #0
  BGT posFrac
  NEG R0, R0
  negFrac:
  CMP R0, R5
  BLE lower
  MOVS R0, R0, LSR #1
  ADD R1, R1, #1
  B negFrac
  
  posFrac:
  CMP R0, R5
  BLE lowr 
  MOVS R0, R0, LSR #1 
  ADD R1, R1, #1
  B posFrac
  lowr:
  exponent0:
  CMP R0, #0
  BGE exponent1
  NEG R0, R0
  ADD R0, R0, 0x80000000
  
  exponent1:
  ADD R1, R1, #127                  @reversing everything to get back the original value
  MOVS R6, R1, LSL #23
  SUB R0, R0, #0x00800000
  ADD R0, R0, R6
  POP     {R4 - R6, PC}                      @ add any registers R4...R12 that you use
  
  lower:
  ADD R0, R0, 0x80000000
  ADD R1, R1, #127                  @reversing everything to get back the original value
  MOVS R6, R1, LSL #23
  SUB R0, R0, #0x00800000
  ADD R0, R0, R6
  POP     {R4 - R6, PC} 

.end