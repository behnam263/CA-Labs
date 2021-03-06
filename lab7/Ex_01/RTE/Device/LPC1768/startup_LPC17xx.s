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

P equ 2
M equ 4
N equ 3	
wordsize equ 4	
				AREA A_arrayMEM , DATA, READONLY 
;A_array DCD 4,-3,5,1,3,-5,0,11,-5,12,4,-5
A_array DCD 	0x00000BB8,0x000036B0,0xFFFFC568,0x00002328,0x00006590,0xFFFF30F8,0x00001388,0x00015BA8,0x00013498,0x00000BB8,0x000059D8,0x00014820,0xFFFFE890,0xFFFF8AD0,0x0000A7F8,0xFFFFF448,0x00014438,0x00006978,0xFFFFDCD8,0x0000C350,0x00006D60,0xFFFEA840,0x0000A028,0x00017AE8,0xFFFE6DA8,0x00010D88,0x00009858,0xFFFFDCD8
	
				AREA B_arrayMEM , DATA, READONLY 
;B_array DCD -2,3,5,-1,4,3,9,-7
B_array DCD 	0x00009088,0xFFFE7578 ,0x00000000 ,0x0000E290 ,0xFFFFB1E0,0x00002328,0x00012110 ,0x00016F30 ,0xFFFFF060 ,0x0000E678,0xFFFFA628,0x00015F90 ,0xFFFECF50 ,0x00003E80 ,0xFFFFF060,0x00000000,0xFFFF0DD0 ,0x00014FF0 ,0x00004E20 ,0x00015BA8,0x00002328,0x00014FF0 ,0x00006D60 ,0x00000000 ,0xFFFF7B30,0x00014050,0x00001388 ,0x000084D0 ,0xFFFFADF8 ,0x000003E8,0x00011170,0xFFFEFA48 ,0x00002328 ,0x00014050 ,0x000036B0
	
	
				AREA C_arrayMEM , DATA, READWRITE 
C_array SPACE P*N*wordsize					
                AREA    |.text|, CODE, READONLY


; Reset Handler
A_address RN R0
B_address RN R1
C_address RN R2

ATemp RN r3
BTemp RN r4
ResTempL RN r5
ResTempH RN r6

GeneralTemp RN r7
GeneralTemp2 RN r8

CounterP RN R9
CounterM RN R10
CounterN RN R11

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
				ldr A_address,=A_array
				ldr B_address,=B_array
				ldr C_address,=C_array


loop
				mov GeneralTemp2,#M							; M=4 to get the result of i+j*4
				mul GeneralTemp,CounterN,GeneralTemp2		; j*4
				add GeneralTemp,GeneralTemp,CounterM		;  = i+j*4
				mov GeneralTemp2,#wordsize					; Multiply 4 to move to the next cell of by considering bytes needed
				mul GeneralTemp,GeneralTemp,GeneralTemp2	; Get the result of =(i+j*4)*4 because of size of registers in memory
				ldr ATemp,[A_address,GeneralTemp]			; Read memory cell of Array A
				
				mov GeneralTemp2,#P							; M=2 to get the result of j+i*2
				mul GeneralTemp,CounterM,GeneralTemp2       ; i*2
				add GeneralTemp,GeneralTemp,CounterP        ;  = j+i*2
				mov GeneralTemp2,#wordsize                        ; Multiply 4 to move to the next cell of by considering bytes needed
				mul GeneralTemp,GeneralTemp,GeneralTemp2    ; Get the result of =(j+i*2)*4 because of size of registers in memory
				ldr BTemp,[B_address,GeneralTemp]			; Read memory cell of Array B	
				
				smlal ResTempL,ResTempH,ATemp,BTemp			; Calculate multiply and sum it with previouse values
				bvs overflow
				b notoverflow                                            	
overflow		
				teq ResTempH,#0x80000000
				beq minusInfinity
				b	plusInfinity
minusInfinity	
				ldr ResTempH,=0xFFFFFFFF
plusInfinity	
				ldr ResTempH,=0x00000000				
notoverflow							
				mov GeneralTemp2,#P							; M=2 to get the result of j+k*2
				mul GeneralTemp,CounterP,GeneralTemp2       ; k*2
				add GeneralTemp,GeneralTemp,CounterN        ;  = j+k*2
				mov GeneralTemp2,#wordsize                  ; Multiply 4 to move to the next cell of by considering bytes needed
				mul GeneralTemp,GeneralTemp,GeneralTemp2    ; Get the result of =(j+k*4)*4 because of size of registers in memory
					
				str ResTempL,[C_address,GeneralTemp]		; Save the first part register in memory	
				add GeneralTemp,#wordsize					; Move to the second part register in memory
				str ResTempH,[C_address,GeneralTemp]		; Save the second part register in memory
	
				add CounterM,#1								; go to next column in A and next row in B
				cmp CounterM,#M								; check for the M counter
				bne loop									; go back to continue loop
				mov CounterM,#0								; make M counter zero for the next
				mov ResTempL,#0								; make ResTempL zero because we need to compute comultive sum
				mov ResTempH,#0								; make ResTempH zero because we need to compute comultive sum
				add CounterP,#1								; go to next Column in B and in C
				cmp CounterP,#P								; check for the P counter
				bne loop 									; go back to continue loop
				mov CounterP,#0								; make P counter zero for the next
				
				add CounterN,#1								; go to next Row in A and in C
				cmp CounterN,#N 							; check for the N counter
				bne loop									; go back to continue loop
							
stop 			b stop				
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
