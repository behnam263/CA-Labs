N EQU 3
M EQU 4
P EQU 2

.MODEL samll
.STACK
.DATA

matA DB  4,-3,5,1,3,-5,0,11,-5,12,4,-5
matB DB  -2,3,5,-1,4,3,9,-7
matC DW  N*P DUP(?)
Printcell_val db 6 dup('$') ;STRING TO STORE NUMBER.        
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

MOV	CX,N
decN:
PUSH CX
PUSH BX
MOV CX,P
mov bp,0
decP:
PUSH CX 
PUSH BP
MOV CX,M
MOV DI,0
decM:
PUSH CX
XOR AH,AH 
 
push BX  
mov bx,bp
mov al,M 
xor bh,0
mul bl 
mov bl,al
MOV Al,matA[BX][DI] 
pop BX


PUSH BX 
push ax  
push DI

MOV BX,BP 

shl DI,8
mov ax,DI
mov al,P
mul ah   
xor ah,ah
mov DI,ax   
MOV DL,matB[DI][BX]
pop DI 
pop ax
POP BX 

IMUL DL
MOV SI,BP
 
Push BX  
push ax

mov ax,N
mul bl 

mov bl,al
xor bh,bh     
pop ax     
ADD matC[BX][SI],AX 

pop BX
INC DI
POP CX
LOOP decM
POP BP
INC BP 
POP CX
LOOP decP
POP BX
INC BX
POP CX
LOOP decN 

mov bp,0 
mov si,0
MOV	CX,N
printP:
PUSH CX
MOV CX,p
printN:
PUSH CX 
 
push ax
mov ax,p 
mov bx,bp
mul bl
mov bl,al
xor bh,bh     
pop ax 

mov AX,matC[BX][SI] 
cmp ah,0
jae print_plus
push ax  
mov dl,"-"
mov ah,2
int 21h
pop ax 
xor ax,0FFFFH

print_plus :
xor ah,ah
call number2string
call printmsg    
;call print2digit

inc si
POP CX
LOOP printN 
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

