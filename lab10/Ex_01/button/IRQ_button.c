#include <time.h>
#include <stdlib.h>

#include "button.h"
#include "lpc17xx.h"
#include "../led/led.h"
extern unsigned int led_value;
unsigned int  ledvalue;
unsigned int  resledvalue;
extern unsigned int counter;
extern unsigned int ReadLed(void);
extern void WriteLed(unsigned int);
unsigned int lastcounter0;
unsigned int lastcounter1;
unsigned int lastcounter2;
unsigned int Gap=0x0020000;
	
 

 
void EINT0_IRQHandler (void)	  
{	if(lastcounter0==counter)
	{
 	all_LED_off();
	LED_On(3);

  LPC_SC->EXTINT |= (1 << 0);     /* clear pending interrupt         */
	}	
	lastcounter0=counter;
}


void EINT1_IRQHandler (void)	  
{
	
	if(counter-lastcounter1>Gap)
	{
	ledvalue=	 ReadLed();
	resledvalue=	ledvalue & 0x000000FF;
		if(resledvalue==0x00000080)
			resledvalue=1;
			else
	resledvalue= resledvalue<<1;
	ledvalue=ledvalue & 0xFFFFFF00;
  ledvalue|=resledvalue;
	WriteLed(ledvalue);		

	LPC_SC->EXTINT |= (1 << 1);     /* clear pending interrupt    */  
	 
	}

	
	lastcounter1=counter;
}

void EINT2_IRQHandler (void)	  
{	
	if(counter-lastcounter2>Gap)
	{
		ledvalue=	 ReadLed();
		resledvalue=	ledvalue & 0x000000FF;
			if(resledvalue==0x00000001)
			resledvalue=0x00000080;
			else
		resledvalue= resledvalue>>1;
 		 ledvalue=ledvalue & 0xFFFFFF00;
     ledvalue|=resledvalue;
		 	WriteLed(ledvalue);	
  LPC_SC->EXTINT |= (1 << 0);     /* clear pending interrupt         */
		 
	}
	lastcounter2=counter;
	
}




