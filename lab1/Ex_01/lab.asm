.MODEL small
.STACK
.DATA 
first_line DB 50 DUP(?)  
second_line DB 50 DUP(?)
third_line DB 50 DUP(?)
fourth_line DB 50 DUP(?) 
occurrences  DB 100 DUP(?)
maxoccurrences  DB 8 DUP(0)
Endline_msg DB '===================================',0Ah,0Dh,'$'
halfmax_msg DB 'The character occurring half the one which occour the most is:',0Ah,0Dh,'$'   
 msg db 'Do you want to get all occurrences?(y/n):$'      
keytocountmsg db 'press a key to show count:$' 
linetype_askmsg db 'Please write input line:$'
Print_cryptmsg db 'Print encrypted message:$'
print_maxmsg db 'Max character distinguished:$'  
print_avgxmsg db 'List of characters with number more than half distinguished:$'
.CODE
.STARTUP                    
             mov occurrences[0],0 ;to find empty array                
             pusha
             mov cx,4  ; get 4 lines 
             push cx   ; save to stack to use inside the loop
getline:                         
             lea DX,linetype_askmsg
             call printmsg
                      
             mov cx,0   ; get number of first 
             mov di,0 
             
getchar:     mov ah,1
             int 21h 
             cmp al,0Dh     ;checks for getting enter key
             je endchar 
getchar_afterEnter:             
             call pushlines   ; saves to the right array 
             call count_occurrences
             inc cx
             inc di 
             cmp cx,50     ; checks for reaching 50
             jbe getchar 
             jmp get50 
endchar:     
             cmp cx,20     ;check if it is before 20 to go back to loop
             jbe getchar_afterEnter
             jmp endpr       

get50:       mov ah,1         
             int 21h 
             call pushlines ; saves to the right array       
             inc cx           
             inc di           
             cmp cx,50         
             jbe get50      
               
endpr:                              
             call newline    ; go to new line                           
             call newline    ; go to new line              
             lea dx,Print_cryptmsg    
             mov ah,20;length of print msg
             call printmsg
             
             mov di,0 
printchar:   call printcypher 
             mov ah,2
             int 21h 
             dec cx 
             inc di
             cmp cx,0
             jnz printchar                     
             call newline               
             call PrintMaxCount    ;before going to next line print max
             call printhalfmaxes   
             call newline 
             lea DX, keytocountmsg 
             call printmsg
             call countcharOCC  
             call PrintAllCount  
             call clear_occurrences  
             
             lea dx,Endline_msg
             call printmsg
                
             pop cx
             dec cx
             push cx
             cmp cx,0
             jnz getline
   
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

poplines PROC ; procedure declaration. 
                pop bx   ; save return address
                pop si   ; get the line number
                push si
                push bx  
                cmp si,4 
                je firstline
                cmp si,3 
                je secondline
                cmp si,2 
                je thirdline
                cmp si,1 
                je forthline  
                jmp assignend
firstline:                
                mov dl, first_line[di] 
                jmp assignend
secondline:             
                mov dl, second_line[di] 
                jmp assignend
thirdline:               
                mov dl, third_line[di]   
                jmp assignend
forthline:               
                mov dl, fourth_line[di] 
                jmp assignend 
assignend:                
                
              RET ; return to caller.
poplines ENDP  

pushlines PROC ; procedure declaration.
                
                pop bx 
                pop si 
                push si 
                push bx 
                cmp si,4 
                je pfirstline
                cmp si,3 
                je psecondline
                cmp si,2 
                je pthirdline
                cmp si,1 
                je pforthline 
                jmp passignend
pfirstline:                
                mov  first_line[di], al
                jmp passignend
psecondline:             
                mov  second_line[di], al
                jmp passignend
pthirdline:               
                mov  third_line[di], al  
                jmp passignend
pforthline:                          
                mov  fourth_line[di], al
                jmp passignend 
passignend:                
                
              RET ; return to caller.
pushlines ENDP 


count_occurrences Proc
                 push di     ; save registers to work with them
                 push bx     
                 mov di, 0
checktofind:     cmp occurrences[di] ,al   ; check if we have the char previously in array
                 je foundprev             
                 
 
                 cmp occurrences[di],0
                 je  writenewcount 
                 inc di 
                 cmp di,100                ; check if we reach the end;
                 jbe checktofind
                                 
foundprev:       inc di
                 inc occurrences[di]   
                 mov bl, occurrences[di] 
                 mov bh, occurrences[di-1]
                 mov di, 0 
                 cmp bl, maxoccurrences[di+1] 
                 ja setmaxcount 
                 
                 jmp finishedcount 
                 
setmaxcount:     
                 mov maxoccurrences[di], bh
                 mov maxoccurrences[di+1], bl
                 jmp finishedcount
                 
                 
writenewcount:   mov  occurrences[di],al               
                 inc di
                 mov occurrences[di],1   
                 mov occurrences[di+1],0   ; to distinguish next empty memory
                 
finishedcount:   
                 pop bx               
                 pop di  
                  ret
count_occurrences endp   


countcharOCC Proc   
                 push di
                 mov di,0
                 mov ah,1
                 int 21h
loopforcount:              
                 cmp di , 100
                 jae finishloopforcount
                 
                 cmp occurrences[di+2] , 0
                 je finishloopforcount
                 
                 cmp al,occurrences[di] 
                 je foundcount 
                 
                 inc di 
                 inc di 
                 jmp loopforcount
foundcount:
                 mov dh,occurrences[di+1]    ; number of occurances of a char  
                 jmp printcountofchar
                 
finishloopforcount:
                  mov ah,0 
                  mov dh,0 
printcountofchar:                  
                 call newline
                 push dx
                 
                 MOV dl, dh 
                 ADD dl,"0"
                 MOV ah, 02h
                 INT 21h 
                 call newline
                 pop dx                                 
                 pop di
                 ret
countcharOCC endp



showmessage_get_key proc  
           call newline  
           mov di,0                  
 

showmessage_get_line proc  
           call newline
           mov di,0                  
printchar_linetype:                     
           MOV dl, linetype_askmsg[di]                     
           MOV ah, 02h
           INT 21h 
           inc di
           cmp di,24
           jbe  printchar_linetype
           call newline
           
    ret
   
showmessage_get_line endp 

print_a_char Proc
           MOV ah, 02h
           INT 21h 
    ret
print_a_char endp

PrintMaxCount proc  
           call newline 
           mov di,0
           lea DX,print_maxmsg
           call printmsg
           MOV dl, "["
           call print_a_char 
           MOV dl, maxoccurrences[di]
           call print_a_char 
           MOV dl, ":"
           call print_a_char 
           MOV al, maxoccurrences[di+1]
           call print2digit 
           MOV dl, "]"
           call print_a_char
           call newline          
    ret
   
PrintMaxCount endp  


PrintAllCount proc  
           call newline   
           mov di,0                  
           lea dx,msg
           call printmsg
           
           mov ah,1
           int 21h
           cmp al,"y"
           je printallocc
           cmp al,"Y"
           je printallocc
           jmp endprint
                  
printallocc: 
            mov di,0 
            call newline      
printalloccsub: 

            mov dl,occurrences[di]  ;check for the enter 
            cmp dl,0Dh
            je skipenterinloop
             
            mov dl,occurrences[di]  ;check for the enter 
            cmp dl,00h
            je skipenterinloop 
             
            jmp continuetoloopenter
skipenterinloop:            
            inc di
            inc di 
            jmp printalloccsub
            
continuetoloopenter:

            mov dl,"[" 
            mov ah,2
            int 21h 
                       
            mov dl,occurrences[di]  
            mov ah,2
            int 21h 
            inc di
            
            mov dl,":"  
            mov ah,2
            int 21h       
           
            mov al,occurrences[di]
            call print2digit
            inc di   
            
            mov dl,"]" 
            mov ah,2
            int 21h
            mov dl," " 
            mov ah,2
            int 21h  
            
            cmp occurrences[di],0
            je end_printalloccsub
            cmp di, 100
            jbe printalloccsub
end_printalloccsub:            
           

endprint:   
               
           call newline          
    ret
   
PrintAllCount endp 


print2digit proc   ; prints two digits in ah
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

clear_occurrences proc 
       push di
       mov di,0 
clr_occurences:
       mov word ptr occurrences[di],0 
       add di,2
       cmp di,100
       jbe clr_occurences      
pop di
    ret    
clear_occurrences endp 


printcypher proc
                pop bx   ; save return address
                pop si   ; get the line number
                push si
                push bx  
                
                       
                mov bx,4
                xor si,0FFFFh
                inc si
                add si,bx  
                inc si     
                       
                 
                cmp si,1 
                je firstline_cypher
                cmp si,2 
                je secondline_cypher
                cmp si,3 
                je thirdline_cypher
                cmp si,4 
                je forthline_cypher  
                jmp assignend_cypher
firstline_cypher:                
                mov dl, first_line[di] 
                cmp dl,"z"
                je firstline_cypher_end_sz
                cmp dl,"Z" 
                je  firstline_cypher_end_bz                      
                jmp assignend_cypher
                
firstline_cypher_end_sz:
                sub dl,"z"-"A" 
                dec dl
                jmp assignend_cypher
firstline_cypher_end_bz:
                sub dl,"Z" -"a"
                dec dl  
                jmp assignend_cypher                             
                
secondline_cypher:             
                mov dl, second_line[di]                             
                cmp dl,"z"
                je secondline_cypher_end_sz
                cmp dl,"Z" 
                je  secondline_cypher_end_bz
                cmp dl,"y"
                je secondline_cypher_end_sz
                cmp dl,"Y" 
                je  secondline_cypher_end_bz                        
                jmp assignend_cypher  
                
secondline_cypher_end_sz:
                sub dl,"z" -"A" 
                dec dl
                jmp assignend_cypher
secondline_cypher_end_bz:
                sub dl,"Z" -"a" 
                dec dl  
                jmp assignend_cypher                 

thirdline_cypher:               
                mov dl, third_line[di]   
                cmp dl,"z"
                je thirdline_cypher_end_sz
                cmp dl,"Z" 
                je  thirdline_cypher_end_bz
                cmp dl,"y"
                je thirdline_cypher_end_sz
                cmp dl,"Y" 
                je  thirdline_cypher_end_bz  
                cmp dl,"x"
                je thirdline_cypher_end_sz
                cmp dl,"X" 
                je  thirdline_cypher_end_bz    
                jmp assignend_cypher 
                
                
thirdline_cypher_end_sz:
                sub dl,"z"-"A"
                dec dl   
                jmp assignend_cypher
thirdline_cypher_end_bz:
                sub dl,"Z"-"a" 
                dec dl  
                jmp assignend_cypher 
 
                
forthline_cypher:               
                mov dl, fourth_line[di]
                cmp dl,"z"
                je forthline_cypher_end_sz
                cmp dl,"Z" 
                je  forthline_cypher_end_bz
                cmp dl,"y"
                je forthline_cypher_end_sz
                cmp dl,"Y" 
                 je  forthline_cypher_end_bz  
                cmp dl,"x"
                je forthline_cypher_end_sz
                cmp dl,"X" 
                je  forthline_cypher_end_bz   
                cmp dl,"w"
                je forthline_cypher_end_sz
                cmp dl,"W" 
                je  forthline_cypher_end_bz    
                jmp assignend_cypher 
                
                
forthline_cypher_end_sz:
                sub dl,"z"-"A" 
                dec dl
                jmp assignend_cypher
forthline_cypher_end_bz:
                sub dl,"Z"-"a"  
                dec dl 
                jmp assignend_cypher 

assignend_cypher:
                add dx,si   
            ret
printcypher endp 

printhalfmaxes proc
           push cx
           call newline 
           mov di,0  
           lea DX,print_avgxmsg
           call printmsg 
           
           mov cl, maxoccurrences[1] 
           shr cl,01
           adc cl,0 
           
printhalf:         
           cmp  cl,occurrences[di+1]
           jb  printhalf_skip
           MOV dl, "["
           call print_a_char 
           MOV dl, occurrences[di]
           call print_a_char 
           MOV dl, ":"
           call print_a_char 
           MOV al, occurrences[di+1]
           call print2digit 
           MOV dl, "]"  
           call print_a_char 
            
printhalf_skip: 
            add di,2  
           cmp occurrences[di],0 
           je end_printhalf
           cmp di,100
           jbe printhalf
end_printhalf:
           
           call newline
           pop cx               
             ret
printhalfmaxes endp
 
 
printmsg proc  ;call I/O primitive interrupt             
           MOV AH,9h ;sets "print string" mode
           INT 21h ;call I/O primitive interrupt 
           call newline
           ret
printmsg  endp  



             popa
END