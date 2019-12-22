/*----------------------------------------------------------------------------
 * Name:    sample.c
 * Purpose: to control led through EINT buttons
 * Note(s):
 *----------------------------------------------------------------------------
 *
 * This software is supplied "AS IS" without warranties of any kind.
 *
 * Copyright (c) 2019 Politecnico di Torino. All rights reserved.
 *----------------------------------------------------------------------------*/
                  
#include <stdio.h>
#include "LPC17xx.H"                    /* LPC17xx definitions                */
#include "led/led.h"

/*----------------------------------------------------------------------------
  Main Program
 *----------------------------------------------------------------------------*/
void LED_Off(unsigned int num)  
{

	switch(num)
	{
		case 0:	LPC_GPIO2->FIOCLR = 0x00000001; 	break;
		case 1:	LPC_GPIO2->FIOCLR = 0x00000002; 	break;
		case 2: LPC_GPIO2->FIOCLR = 0x00000004; 	break;	 
		case 3:LPC_GPIO2->FIOCLR =  0x00000008; 	break;
		case 4:LPC_GPIO2->FIOCLR =  0x00000010; 	break;	
		case 5:LPC_GPIO2->FIOCLR =  0x00000020; 	break;
		case 6:LPC_GPIO2->FIOCLR =  0x00000040; 	break;
	  case 7:LPC_GPIO2->FIOCLR =  0x00000080; 	break;		
	}
	                     	
}
