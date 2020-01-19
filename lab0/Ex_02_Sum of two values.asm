.MODEL small
.STACK
.DATA
OPD1 DW 10
OPD2 DW 24
RESULT DW ?
.CODE
.STARTUP
MOV AX, OPD1      ; move a memory cell to reg
ADD AX, OPD2      ; add another memory cell to reg
MOV RESULT, AX    ; save results in another memory cell
.EXIT
END