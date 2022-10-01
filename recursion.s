  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global   quicksort
  .global   partition
  .global   swap

@ quicksort subroutine
@ Sort an array of words using Hoare's quicksort algorithm
@ https://en.wikipedia.org/wiki/Quicksort 
@
@ Parameters:
@   R0: Array start address
@   R1: lo index of portion of array to sort
@   R2: hi index of portion of array to sort
@
@ Return:
@   none
quicksort:
  PUSH    {R3-R6,LR}                      @ add any registers R4...R12 that you use
  @ *** PSEUDOCODE ***
  @ if (lo < hi) { // !!! You must use signed comparison (e.g. BGE) here !!!
  @   p = partition(array, lo, hi);
  @   quicksort(array, lo, p - 1);
  @   quicksort(array, p + 1, hi);
  @ }
  Mov R3, R0
  Mov R4, R1
  Mov R5, R2
  CMP R1, R2
  BGT .greater
  BL partition
  Mov R6, R0
  Mov R0, R3
  Sub R2, R6, #1
  Mov R0, R3
  BL quicksort
  Mov R0, R3
  Mov R1, R4
  Add R1, R6, #1
  Mov R2, R5
  BL quicksort 
.greater:                    @ add any registers R4...R12 that you use
 POP     {R3-R6,PC} 

@ partition subroutine
@ Partition an array of words into two parts such that all elements before some
@   element in the array that is chosen as a 'pivot' are less than the pivot
@   and all elements after the pivot are greater than the pivot.
@
@ Based on Lomuto's partition scheme (https://en.wikipedia.org/wiki/Quicksort)
@
@ Parameters:
@   R0: array start address
@   R1: lo index of partition to sort
@   R2: hi index of partition to sort
@
@ Return:
@   R0: pivot - the index of the chosen pivot value
partition:
  PUSH    {R3-R9,LR}                      @ add any registers R4...R12 that you use

  @ *** PSEUDOCODE ***
  @ pivot = array[hi];
  @ i = lo;
  @ for (j = lo; j <= hi; j++) {
  @   if (array[j] < pivot) {
  @     swap (array, i, j);
  @     i = i + 1;
  @   }
  @ }
  @ swap(array, i, hi);
  @ return i;
  LDR R3, [R0, R2, LSL #2] @ pivot = array[hi];
  MOV R4, R1 @ i = low
  MOV R5, R1 @ j = lo
  MOV R7, R2 @ save high
  MOV R8, R1 @ save low
  for:
  CMP R5, R2  @j = low
  BHS endLoop
  LDR R6, [R0, R5, LSL #2] @ if (array[j] < pivot)
  CMP R6, R3
  BHI notLower
  MOV R1, R4 @ i
  MOV R2, R5 @ j
  BL swap
  MOV R1, R8 @lo = lo saved
  MOV R2, R7 @hi = hi saved
  ADD R4, R4, #1 @ i = i + 1
  ADD R5, R5, #1
  B for
  notLower:
  ADD R5, R5, #1
  B for 
  endLoop:
  MOV R1, R4
  MOV R2, R7
  BL swap
  MOV R1, R8
  MOV R2, R7
  MOV R0, R4
  POP     {R3-R9, PC}                      @ add any registers R4...R12 that you use



@ swap subroutine
@ Swap the elements at two specified indices in an array of words.
@
@ Parameters:
@   R0: array - start address of an array of words
@   R1: a - index of first element to be swapped
@   R2: b - index of second element to be swapped
@
@ Return:
@   none
swap:
  PUSH    {R5 - R6, LR}
  LDR R5, [R0, R1, LSL #2]
  LDR R6, [R0, R2, LSL #2]
  STR R5, [R0, R2, LSL #2]
  STR R6, [R0, R1, LSL #2]
  POP     {R5 - R6, PC}


.end