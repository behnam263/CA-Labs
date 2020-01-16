;N EQU 3
;M EQU 4
;P EQU 2 

N EQU 4
M EQU 7
P EQU 5

.MODEL samll
.STACK
.DATA

;matA DB  4,-3,256,1,3,-5,0,11,-5,12,4,-5
;matB DB  -2,3,5,-1,4,3,9,-7  

matA DB  3,14,-15,9,26,-53,5,89,79,3,23,84,-6,26,43,-3,83,27,-9,50,28,-88,41,97,-103,69,39,-9 
matB DB  37,-101,0,58,-20,9,74,94,-4,59,-23,90,-78,16,-4,0,-62,86,20,89,9,86,28,0,-34,82,5,34,-21,1,70,-67,9,82,14 




matC DW  N*P DUP(?)
Printcell_val db 6 dup('$') ;STRING TO STORE NUMBER.  
tempN dw 0   ;value to save index of current cell in N
tempM dw 0   ;value to save index of current cell in M
tempP dw 0   ;value to save index of current cell in P   
.CODE
.STARTUP


;these are for making registers zero
XOR  AX,AX
XOR  BX,BX
XOR  CX,CX
XOR  DX,DX
XOR  SI,SI
XOR  DI,DI
XOR  BP,BP

MOV	CX,N    ;counter for looping inside 1st matrix rows and 2nd matrix columns
decN: 

PUSH CX   ; save counter not to loose the first loop counter
PUSH BX   ; save register not to loose its value inside
MOV CX,P  ; get new loop counter for inner loop
mov bp,0  ; save register not to loose its value inside
decP:

PUSH CX   ; save counter not to loose the first loop counter
PUSH BP   ; save register not to loose its value inside
MOV CX,M  ; counter for looping inside 1st matrix columns and 2nd matrix rows
MOV DI,0  ; mov zero to start index from 0 in next inner loop

decM:
PUSH CX   ; save cx to preserve after some instructions
XOR AH,AH ; 
mov bx,tempM   ;bring back index to access related memory
MOV Al,matA[BX][DI]   ;read related memory block of first matrix to al


mov BX,tempP        ; move the index of related row to move to next row of first matrix
push DI             ; save di for temporary usage
mov DI,BP           ; get the index of first place of the row in memory
MOV DL,matB[DI][BX] ; get the memory block by summing first place of a row index and column index
pop DI              ; roll back index 
add BX,tempP        ; go to next row in second matrix 

IMUL DL             ; multiply loaded cells in al and dl
MOV SI,BP           ; mov index of next index in loop above (todo:check if adding one is enough)
add si,si           ; 
MOV BX,tempN        ;
ADD matC[BX][SI],AX ;  



push cx   
mov cx,p            ;
add tempP,CX        ; add another P value to move to next row in matrix B
pop cx              ;


INC DI              ; continue to go furtur in cells in matrix B row and in matrix A column
POP CX
LOOP decM
POP BP              ; go to next column in matrix B in each row
INC BP 
mov tempP,0
POP CX
LOOP decP 
mov bp,0            ; reset counter of index 
push cx 
mov cx,M
add tempM,CX  

mov cx,P
add tempN,CX 
add tempN,CX 
pop cx

POP BX
INC BX
POP CX
LOOP decN
 ;;;;;;;;;;;;;;;;print;;;;;;;;;;;;;;;;;;;;;;
mov bp,0 
mov di,0
MOV	CX,N  
mov tempP,0
printP:
PUSH CX
MOV CX,p

printN:
PUSH CX 
mov bx,tempP
mov AX,matC[BX][DI]   

cmp ax, 0
jg printplus

push ax  
mov dl,"-"
mov ah,2
int 21h
pop ax 
xor ax,0FFFFH   
inc ax

printplus:
;xor ah,ah
call number2string
call printmsg    
;call print2digit
   
add di,2
POP CX
LOOP printN
mov di,0
add tempP,p
add tempP,p
call newline 
inc bp  
POP CX
LOOP printP 
         

.EXIT

newline PROC ; procedure declaration.
           ;newline begin  
           push dx
           push ax
           MOV dl, 10
           MOV ah, 02h
           INT 21h
           MOV dl, 13
           MOV ah, 02h
           INT 21h   
           pop ax
           pop dx
           ;newline begin
       RET ; return to caller.
newline ENDP 

number2string proc  
  mov  bx, 10 ;DIGITS ARE EXTRACTED DIVIDING BY 10.
  mov  cx, 0 ;COUNTER FOR EXTRACTED DIGITS.
cycle1:       
  mov  dx, 0 ;NECESSARY TO DIVIDE BY BX.
  div  bx ;DX:AX / 10 = AX:QUOTIENT DX:REMAINDER.
  push dx ;PRESERVE DIGIT EXTRACTED FOR LATER.
  inc  cx ;INCREASE COUNTER FOR EVERY DIGIT EXTRACTED.
  cmp  ax, 0  ;IF NUMBER IS
  jne  cycle1 ;NOT ZERO, LOOP. 
;NOW RETRIEVE PUSHED DIGITS.
  lea  si, Printcell_val
  
cycle2:  
  pop  dx        
  add  dl, 48 ;CONVERT DIGIT TO CHARACTER.
  mov  [ si ], dl
  inc  si
  loop cycle2  
  ret
number2string endp 

print2digit proc   ; prints two digits in al
         mov dl,10 
         mov ah,0
         cmp al,10
         jb printonedigit 
         div dl  
         mov dl,al
         add dl,"0"
         mov dh,ah
         mov ah,2
         int 21h 
         add dh,"0"
         mov dl,dh
         int 21h 
         jmp enddigitprint 
printonedigit:
        add al,"0"
        mov dl,al
        mov ah,2
        int 21h
enddigitprint:          
    ret
print2digit endp  

printmsg proc  ;call I/O primitive interrupt             
;DISPLAY STRING.
  mov  ah, 9
  lea  dx, Printcell_val  ;NUMBER CONVERTED.   
  int  21h    
  
  mov ah,2
  mov dl,32
  int 21h
           ret
printmsg  endp  


END

