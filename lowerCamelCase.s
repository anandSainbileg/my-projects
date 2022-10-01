  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:
  
  @ Follow the instructions in the handout for Assignment 7

  @
  @ TIP: To view memory when debugging your program you can ...
  @
  @   Add the watch expression to see individual characters: (char[64])newString
  @
  @   OR
  @
  @   Add the watch expression to see the string: (char*)&newString
  @
  @   OR
  @
  @   Open a 'Memory View' specifying the address &newString and length at
  @   least 128. You can open a Memory View with ctrl-shift-p type
  @   'View Memory' (cmd-shift-p on a Mac).
  @

  @ *** your program goes here ***
  MOV   R9, #0x00           //R9 = 0
  SUB   R0, R0, #1          //string = string - 1
  MOV   R6, #0              //count = 0

while:                //while
  LDRB  R3, [R1]      //load first letter from R1 to R3
  ADD   R0, R0, #1    //string = string + 1
      
  ifspace:
  CMP   R3, #0x00          //while (letter != null)
  BEQ   end              
  CMP   R3, #0x20       //if (R3 = space){
  BNE  ifnotspace       //R1 = R1 + 1
  ADD   R1, R1, #1      //load the next letter
  LDRB  R4, [R1]        //load the next letter of R1 to R4
  CMP   R4, #'A'        //if (R4 >= A) && (R <= Z)
  BLO  AddifNotCap      
  CMP   R4, #'Z'
  BHI  AddifNotCap   
  SUB   R1, R1, #1     //R1 = R1 + 1
  MOV   R5, R4         //R5 = R4
  STRB  R5, [R0]       //store R5 to R0
  ADD  R6, R6, #1      //count = count + 1
  ADD   R1, R1, #1     //R1 = R1 + 2
  ADD   R1, R1, #1
  B while              //}
  
  AddifNotCap:   
  CMP   R4, #0x00         //R4 != 0
  BEQ   end
  CMP   R4, #0x20        //if(R4 = space)
  BEQ   extraSpace       //go to extraSpace
  CMP   R4, #'a'         //if not then if(R4 >= a)&&(R4 <= z)
  BLO   symbols          // if it doesnt belong in letters go to symbols
  CMP   R4, #'z'     
  BHI   symbols
  SUB   R4, #0x20        //R4 - 0x20 to make the letter lower case
  SUB   R1, R1, #1       //R1 = R1 - 1move back to previous letter
  MOV   R5, R4           //register R4 as R5
  STRB  R5, [R0]         //store the next letter to the preivous space
  ADD   R6, R6, #1       //count = count + 1
  ADD   R1, R1, #1       //R1 = R1 + 2
  ADD   R1, R1, #1
  B while               //}

  symbols:
  MOV   R3, #0x20      //If symbols  R3 = space
  STRB  R3, [R1]       //store the space in R1
  B ifspace            //}

  extraSpace: 
  MOV   R3, #0x20      //if extraSpace then R3 = space
  STRB  R3, [R1]       //store the space in R1
  SUB   R0, R0, #1     //R0 = R0 - 1 move back to previous string
  B while              //}
  
  ifnotspace:          //if its not space
  CMP   R3, #'A'       //if (R3 >= A) && (R3 <= Z)
  BLO  ifnotcapital     
  CMP   R3, #'Z'
  BHI  ifnotcapital
  ADD   R3, #0x20      //if capital R3 = R3 + 0x20 to make it lower case
  STRB  R3, [R0]       //store the lower case letter to R1
  ADD   R6, R6, #1     //count  = count + 1
  ADD   R1, R1, #1     //R1 = R1 + 1
  B while              //}
  
  ifnotcapital:
  CMP   R3, #'a'        //if its not capital 
  BLO notletter         //if (R3 >= a) && (R3 <= z)
  CMP   R3, #'z'
  BHI notletter
  STRB  R3, [R0]         //store R3 (lower case letter) in R0
  ADD   R6, R6, #1       //count = count + 1
  ADD   R1, R1, #1       //R1 = R1 + 1 (move to next letter)
  B while                //}
  
  notletter:             //if its not a letter then
  ADD   R1, R1, #1       //R1 = R1 + 1 move to the next letter
  SUB   R0, R0, #1       //R0 = R0 - 1 move to the previous letter
  B while                //}
  
  end:
  SUB   R0, R0, R6       //R0 = R0 - count to go to the initial letter
  LDRB  R7, [R0]         //load the first letter to R7
  CMP   R7, #'A'         //if(R7 >= A)&&(R7 <= Z)
  BLO firstcapital       //to check if the first letter is capital
  CMP   R7, #'Z'
  BHI firstcapital
  ADD   R7, #0x20        //R7 = R7 + 0x20 to make it lower case
  STRB  R7, [R0]         //store R7 to the initial letter of R0
  firstcapital:
  ADD   R0, R0, R6       //if not capital then add count back to R0
  STRB  R9, [R0]         //store 0 to R0
  
End_Main:
  BX    lr
@ End of program ... check your result