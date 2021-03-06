;/**************************************************************************//**
; * @file     startup_LPC17xx.s
; * @brief    CMSIS Cortex-M3 Core Device Startup File for
; *           NXP LPC17xx Device Series
; * @version  V1.10
; * @date     06. April 2011
; *
; * @note
; * Copyright (C) 2009-2011 ARM Limited. All rights reserved.
; *
; * @par
; * ARM Limited (ARM) is supplying this software for use with Cortex-M
; * processor based microcontrollers.  This file can be freely distributed
; * within development tools that are supporting such ARM based processors.
; *
; * @par
; * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
; * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
; * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
; * ARM SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
; * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
; *
; ******************************************************************************/

; *------- <<< Use Configuration Wizard in Context Menu >>> ------------------

; <h> Stack Configuration
;   <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Stack_Size      EQU     0x00000200

                AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   Stack_Size
__initial_sp


; <h> Heap Configuration
;   <o>  Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>
n      			EQU     0x0000001e
m      			EQU     0x00000004
;wordsizeback	EQU     0xFFFFFFFC
wordsize		EQU     0x00000004
;twowordsizeback	EQU     0xFFFFFFF8
twowordsize		EQU     0x00000008
Heap_Size       EQU     0x00000000

                AREA    HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit


                PRESERVE8
                THUMB


; Vector Table Mapped to Address 0 at Reset

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     __initial_sp              ; Top of Stack
                DCD     Reset_Handler             ; Reset Handler
                DCD     NMI_Handler               ; NMI Handler
                DCD     HardFault_Handler         ; Hard Fault Handler
                DCD     MemManage_Handler         ; MPU Fault Handler
                DCD     BusFault_Handler          ; Bus Fault Handler
                DCD     UsageFault_Handler        ; Usage Fault Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     SVC_Handler               ; SVCall Handler
                DCD     DebugMon_Handler          ; Debug Monitor Handler
                DCD     0                         ; Reserved
                DCD     PendSV_Handler            ; PendSV Handler
                DCD     SysTick_Handler           ; SysTick Handler

                ; External Interrupts
                DCD     WDT_IRQHandler            ; 16: Watchdog Timer
                DCD     TIMER0_IRQHandler         ; 17: Timer0
                DCD     TIMER1_IRQHandler         ; 18: Timer1
                DCD     TIMER2_IRQHandler         ; 19: Timer2
                DCD     TIMER3_IRQHandler         ; 20: Timer3
                DCD     UART0_IRQHandler          ; 21: UART0
                DCD     UART1_IRQHandler          ; 22: UART1
                DCD     UART2_IRQHandler          ; 23: UART2
                DCD     UART3_IRQHandler          ; 24: UART3
                DCD     PWM1_IRQHandler           ; 25: PWM1
                DCD     I2C0_IRQHandler           ; 26: I2C0
                DCD     I2C1_IRQHandler           ; 27: I2C1
                DCD     I2C2_IRQHandler           ; 28: I2C2
                DCD     SPI_IRQHandler            ; 29: SPI
                DCD     SSP0_IRQHandler           ; 30: SSP0
                DCD     SSP1_IRQHandler           ; 31: SSP1
                DCD     PLL0_IRQHandler           ; 32: PLL0 Lock (Main PLL)
                DCD     RTC_IRQHandler            ; 33: Real Time Clock
                DCD     EINT0_IRQHandler          ; 34: External Interrupt 0
                DCD     EINT1_IRQHandler          ; 35: External Interrupt 1
                DCD     EINT2_IRQHandler          ; 36: External Interrupt 2
                DCD     EINT3_IRQHandler          ; 37: External Interrupt 3
                DCD     ADC_IRQHandler            ; 38: A/D Converter
                DCD     BOD_IRQHandler            ; 39: Brown-Out Detect
                DCD     USB_IRQHandler            ; 40: USB
                DCD     CAN_IRQHandler            ; 41: CAN
                DCD     DMA_IRQHandler            ; 42: General Purpose DMA
                DCD     I2S_IRQHandler            ; 43: I2S
                DCD     ENET_IRQHandler           ; 44: Ethernet
                DCD     RIT_IRQHandler            ; 45: Repetitive Interrupt Timer
                DCD     MCPWM_IRQHandler          ; 46: Motor Control PWM
                DCD     QEI_IRQHandler            ; 47: Quadrature Encoder Interface
                DCD     PLL1_IRQHandler           ; 48: PLL1 Lock (USB PLL)
                DCD     USBActivity_IRQHandler    ; 49: USB Activity interrupt to wakeup
                DCD     CANActivity_IRQHandler    ; 50: CAN Activity interrupt to wakeup


                IF      :LNOT::DEF:NO_CRP
                AREA    |.ARM.__at_0x02FC|, CODE, READONLY
CRP_Key         DCD     0xFFFFFFFF
                ENDIF
				
				AREA inputData, DATA, READONLY
Price_list 	DCD 0x004, 20, 0x006, 15, 0x007, 10, 0x00A, 5,  0x010, 8
			DCD 0x012, 7,  0x016, 22, 0x017, 17, 0x018, 38, 0x01A, 22
			DCD 0x01B, 34, 0x01E, 11, 0x022, 3,  0x023, 9,  0x025, 40
			DCD 0x027, 12, 0x028, 11, 0x02C, 45, 0x02D, 10, 0x031, 40
			DCD 0x033, 45, 0x035, 9,  0x036, 11, 0x039, 12, 0x03C, 19
			DCD 0x03E, 1,  0x041, 20, 0x042, 30, 0x045, 12, 0x047, 7

Item_list	DCD 0x022, 4, 0x006, 1, 0x03E, 10, 0x017, 2		; total cost is 71 (0x47)


                AREA    |.text|, CODE, READONLY
 

; Reset Handler
countrM     RN  r10 
Pivot       RN  r10

countrN     RN  r11
Temp3       RN  r11

Temp1		 RN	r5
Temp2		 RN	r6
Min  		 RN r8
Item_Index   RN r8
Max  		 RN r9
Price_Index  RN r9
Temp4      	 RN r12

Inout1 RN	r0
Inout2 RN	r1

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
				EXPORT  sequentialSearch
				EXPORT  binarySearch					
									
				; remove comments to solve item 3
				;IMPORT  SystemInit
                ;IMPORT  __main
                ;LDR     R0, =SystemInit
                ;BLX     R0
                ;LDR     R0, =__main
                ;BX      R0

				; item 1
				LDR r0, =Price_list
				LDR r1, =Item_list
				BL sequentialSearch
				
				; remove comments to solve item 2
				LDR r0, =Price_list
				LDR r1, =Item_list
				BL binarySearch
				
				
				

stop			B stop


                ENDP
sequentialSearch PROC
				push {r4-r12,lr}
				mov countrM,#0 ;counter
				mov countrN,#0 ;counter
				sub Inout1,#twowordsize ; because of loop and changable address we come 1 place back
				sub Inout2,#twowordsize ; because of loop and changable address we come 1 place back
				mov Price_Index,Inout1  ; set first index
outerloop				
				ldr Temp1,[Inout2,#twowordsize]! ;	Item_list code loaded
				mov Inout1,Price_Index 			 ;	reset price list index to first place
innerloop		
				ldr Temp2,[Inout1,#twowordsize]! ;	Price_list code loaded
				add countrN,#1	; add one to index
				cmp countrN,#n	; check if prices are not finished
				beq finishloop	; go to end
				cmp Temp1,Temp2	; compare Item code and price code
				bne innerloop	; not found so go to the next price
				b   founditem	; found match price
founditem	    
				mov countrN,#0	; bring back index of price list to 0
				ldr Temp1,[Inout1,#wordsize]	; load value of  price 	
				ldr Temp2,[Inout2,#wordsize]	; load value of Item count
				mul Temp1,Temp1,Temp2			; multiply item count and price
			 	add Temp4,Temp1					; add to previous values
			    
				add countrM,#1					; move to next item
				cmp countrM,#m					; compare the number of items in list 
				bl outerloop					; if we are not finished yet go back to find the price
finishloop		
				mov Inout1,Temp4				; move result in r0 as standard says
				pop {r4-r12,pc}
				 ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
binarySearch    PROC
				push {r4-r12,lr}
				sub Inout2,#twowordsize 	;	Because I am really adding to current address I need to start one place before
				push {Inout2} 	;	save the first place of Item list for getting out of loop
				
looplblB		mov Pivot,#n 		;	save number of price list in pivot
				mov Max,#n 			;	save number of price list in Max
				mov Min,#0 			;	save first of price list in Min
                 
				ldr Temp1,[Inout2,#twowordsize]!	;	Item_list
looplbl2B		
				
				sub Temp2,Max,Min    		;	get the space between max and min
				LSR Temp3,Temp2,#1   		;	find the middle point
				add Pivot,Temp3,Min			;	align between min and max	
				mov Temp2,#twowordsize		;	get size of two blocks for real addressing calculation
				mul Pivot,Pivot,Temp2		;	get the real address of middle

				ldr Temp2,[Inout1,Pivot]	;	get the value of the related address to compare	
				cmp Temp1,Temp2				;	compare code values of item and price 
				beq founditemB				;	found item so add it with previous values
				sub Temp2,Max,Min			;	Not found item so find new middle
				LSR Temp3,Temp2,#1			
				add Temp3,Min
				ITE GT						;	If is in higher half bring Min in pivot place
				ADDGT Min,Temp3
				SUBLE Max,Temp3	
				b looplbl2B
				
founditemB		
				mov Temp2,Pivot
				add Temp2,Temp2,#wordsize
				ldr Temp1,[Inout1,Temp2] 	;	Read value of price 
				ldr Temp2,[Inout2,#wordsize]	;	Read value of item quantity

				mul Temp2,Temp1,Temp2			;	calculate price
			 	add r12,Temp2					;	add to previous 
				
				mov Temp2,#m					;	
				mov Temp1,#twowordsize
				mul Temp2,Temp1,Temp2
				
				ldr Temp1,[R13] ; read first place of memory of item list 
				add Temp2,Temp1 ; + Size of that item list 
				cmp Inout2,Temp2	 
				bne looplblB
				
				mov r0,r12
				pop {r4-r12,pc}
				ENDP					

; Dummy Exception Handlers (infinite loops which can be modified)

NMI_Handler     PROC
                EXPORT  NMI_Handler               [WEAK]
                B       .
                ENDP
HardFault_Handler\
                PROC
                EXPORT  HardFault_Handler         [WEAK]
                B       .
                ENDP
MemManage_Handler\
                PROC
                EXPORT  MemManage_Handler         [WEAK]
                B       .
                ENDP
BusFault_Handler\
                PROC
                EXPORT  BusFault_Handler          [WEAK]
                B       .
                ENDP
UsageFault_Handler\
                PROC
                EXPORT  UsageFault_Handler        [WEAK]
                B       .
                ENDP
SVC_Handler     PROC
                EXPORT  SVC_Handler               [WEAK]
                B       .
                ENDP
DebugMon_Handler\
                PROC
                EXPORT  DebugMon_Handler          [WEAK]
                B       .
                ENDP
PendSV_Handler  PROC
                EXPORT  PendSV_Handler            [WEAK]
                B       .
                ENDP
SysTick_Handler PROC
                EXPORT  SysTick_Handler           [WEAK]
                B       .
                ENDP

Default_Handler PROC

                EXPORT  WDT_IRQHandler            [WEAK]
                EXPORT  TIMER0_IRQHandler         [WEAK]
                EXPORT  TIMER1_IRQHandler         [WEAK]
                EXPORT  TIMER2_IRQHandler         [WEAK]
                EXPORT  TIMER3_IRQHandler         [WEAK]
                EXPORT  UART0_IRQHandler          [WEAK]
                EXPORT  UART1_IRQHandler          [WEAK]
                EXPORT  UART2_IRQHandler          [WEAK]
                EXPORT  UART3_IRQHandler          [WEAK]
                EXPORT  PWM1_IRQHandler           [WEAK]
                EXPORT  I2C0_IRQHandler           [WEAK]
                EXPORT  I2C1_IRQHandler           [WEAK]
                EXPORT  I2C2_IRQHandler           [WEAK]
                EXPORT  SPI_IRQHandler            [WEAK]
                EXPORT  SSP0_IRQHandler           [WEAK]
                EXPORT  SSP1_IRQHandler           [WEAK]
                EXPORT  PLL0_IRQHandler           [WEAK]
                EXPORT  RTC_IRQHandler            [WEAK]
                EXPORT  EINT0_IRQHandler          [WEAK]
                EXPORT  EINT1_IRQHandler          [WEAK]
                EXPORT  EINT2_IRQHandler          [WEAK]
                EXPORT  EINT3_IRQHandler          [WEAK]
                EXPORT  ADC_IRQHandler            [WEAK]
                EXPORT  BOD_IRQHandler            [WEAK]
                EXPORT  USB_IRQHandler            [WEAK]
                EXPORT  CAN_IRQHandler            [WEAK]
                EXPORT  DMA_IRQHandler            [WEAK]
                EXPORT  I2S_IRQHandler            [WEAK]
                EXPORT  ENET_IRQHandler           [WEAK]
                EXPORT  RIT_IRQHandler            [WEAK]
                EXPORT  MCPWM_IRQHandler          [WEAK]
                EXPORT  QEI_IRQHandler            [WEAK]
                EXPORT  PLL1_IRQHandler           [WEAK]
                EXPORT  USBActivity_IRQHandler    [WEAK]
                EXPORT  CANActivity_IRQHandler    [WEAK]

WDT_IRQHandler
TIMER0_IRQHandler
TIMER1_IRQHandler
TIMER2_IRQHandler
TIMER3_IRQHandler
UART0_IRQHandler
UART1_IRQHandler
UART2_IRQHandler
UART3_IRQHandler
PWM1_IRQHandler
I2C0_IRQHandler
I2C1_IRQHandler
I2C2_IRQHandler
SPI_IRQHandler
SSP0_IRQHandler
SSP1_IRQHandler
PLL0_IRQHandler
RTC_IRQHandler
EINT0_IRQHandler
EINT1_IRQHandler
EINT2_IRQHandler
EINT3_IRQHandler
ADC_IRQHandler
BOD_IRQHandler
USB_IRQHandler
CAN_IRQHandler
DMA_IRQHandler
I2S_IRQHandler
ENET_IRQHandler
RIT_IRQHandler
MCPWM_IRQHandler
QEI_IRQHandler
PLL1_IRQHandler
USBActivity_IRQHandler
CANActivity_IRQHandler

                B       .

                ENDP


                ALIGN


; User Initial Stack & Heap

                IF      :DEF:__MICROLIB

                EXPORT  __initial_sp
                EXPORT  __heap_base
                EXPORT  __heap_limit

                ELSE

                IMPORT  __use_two_region_memory
                EXPORT  __user_initial_stackheap
__user_initial_stackheap

                LDR     R0, =  Heap_Mem
                LDR     R1, =(Stack_Mem + Stack_Size)
                LDR     R2, = (Heap_Mem +  Heap_Size)
                LDR     R3, = Stack_Mem
                BX      LR

                ALIGN

                ENDIF


                END
