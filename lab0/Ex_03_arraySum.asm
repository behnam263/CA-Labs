.MODEL SMALL
.STACK
.DATA
VETT DW 5, 7, 3, 4, 3
RESULT DW ?
.CODE
.STARTUP
MOV AX, 0           ; setting ax to 0
ADD AX, VETT        ; adding first place of memory cell to ax
ADD AX, VETT+2      ; adding second place of memory cell to ax
ADD AX, VETT+4      ; adding third place of memory cell to ax  
ADD AX, VETT+6      ; adding forth place of memory cell to ax 
ADD AX, VETT+8      ; adding fifth place of memory cell to ax  
MOV RESULT, AX      ; get the result back in a memory cell 
.EXIT
END