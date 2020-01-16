DIM EQU 15
.MODEL small
.STACK
.DATA
VETT DW 2, 5, 16, 12, 34, 7, 20, 11, 31, 44, 70, 69, 2,
4, 23
RESULT DW ?
.CODE
.STARTUP
MOV AX, 0
MOV CX, DIM ; array size now stored in CX
MOV DI, 0
lab: ADD AX, VETT[DI] ; add i-th element to AX
ADD DI, 2 ; go to next element
DEC CX
CMP CX, 0 ; compare array index with 0
JNZ lab ; jump if not equal
MOV RESULT, AX ; otherwise, write the result
.EXIT
END