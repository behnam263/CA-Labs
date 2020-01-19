.MODEL small
.STACK
DIM EQU 20
.DATA
TABLE DB DIM DUP(?)
.CODE
.STARTUP
MOV CX, DIM
LEA DI, TABLE
MOV AH, 1 ; reading
lab1: INT 21H
MOV [DI], AL
INC DI
DEC CX
CMP CX, 0
JNE lab1 ; loop 20 times
MOV CL, 0FFH
MOV DI, 0
ciclo: CMP CL, TABLE[DI] ; compare with current minimum
JB dopo
MOV CL, TABLE[DI] ; store new minimum
dopo: INC DI
CMP DI, DIM
JB ciclo
output: MOV DL, CL
MOV AH, 2
INT 21H ; display
.EXIT
END