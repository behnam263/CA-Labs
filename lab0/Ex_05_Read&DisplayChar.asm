DIM EQU 20
.MODEL small
.STACK
.DATA
VETT DB DIM DUP(?)
.CODE
.STARTUP
MOV CX, DIM
MOV DI, 0
MOV AH, 1 ; set AH for reading
lab1: INT 21H ; read a character
MOV VETT[DI], AL ; store the character
INC DI ; go to next element
DEC CX
CMP CX, 0 ; compare array index with 0
JNZ lab1 ; jump if not equal
MOV CX, DIM
MOV AH, 2 ; set AH for writing
lab2: DEC DI ; go to next element
MOV DL, VETT[DI]
INT 21H ; display the character
DEC CX
CMP CX, 0
JNZ lab2
.EXIT
END