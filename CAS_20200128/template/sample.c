/*----------------------------------------------------------------------------
 * Name:    sample.c
 *
 * This software is supplied "AS IS" without warranties of any kind.
 *
 * Copyright (c) 2020 Politecnico di Torino. All rights reserved.
 *----------------------------------------------------------------------------*/
                  
#include <stdio.h>
#include "LPC17xx.h"                    /* LPC17xx definitions                */
extern int radical (unsigned int input);
extern int coprime (unsigned int a,unsigned int b);
unsigned int  a;
unsigned int  b;
unsigned int  c;
/*-----------------------------------------------------------------
Uncomment to import the libraries that you need
 *-----------------------------------------------------------------*/
  #include "led/led.h"
//#include "button/button.h"
//#include "timer/timer.h"
//#include "ADC_DAC/adc_dac.h"

/*----------------------------------------------------------------------------
  Main Program
 *----------------------------------------------------------------------------*/
int main (void)
{  
	LED_init();					/* LED Initialization */
	unsigned int admiss=0;
	unsigned int exceptionsnum=0;
	a=576;
	b=1;
	for( b=1;b<100;b++){
		c=a+b;
	if(	coprime(a,b)==1 )
		if(coprime(a,c)==1)
			if(	coprime(b,c)==1)
			{
				admiss++;
				if(c>radical(a*b*c))
				exceptionsnum++;
			}
	}
	
	switch(exceptionsnum)
{
    case 0:
     LED_On(0);
      break;
    case 1:
      LED_On(1);
      break;
		    case 2:
      LED_On(2);
      break;
    case 3:
      LED_On(3);
      break;
		    case 4:
      LED_On(4);
      break;
    case 5:
      LED_On(5);
      break;
		    case 6:
      LED_On(6);
      break;
    case 7:
      LED_On(7);
      break;
    default:
      LED_On(7);
}
	
	// Uncomment the instructions (and add others) according to your needs
	
	//BUTTON_init();				/* BUTTON Initialization */
	//init_timer(0,0x0EE6B280);		/* TIMER0 Initialization */
	//enable_timer(0);
	//ADC_init();
	//DAC_init();
	
	LPC_SC->PCON |= 0x1;	/* power-down mode */								
	LPC_SC->PCON &= 0xFFFFFFFFD; 
	SCB->SCR |= 0x2;			/* set SLEEPONEXIT */	
	
	//ADC_start_conversion();

	__ASM("wfi");
}
